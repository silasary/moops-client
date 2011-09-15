unit frmSimpleFTPU;
{.$define USING_IE5}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ImgList, ExtCtrls, ActnList, ToolWin, ComCtrls, WinInetControl,
  SimpFTP, StdCtrls, ShellAPI;

resourcestring
  S_ERR_CONNECTED_TO      = 'Connected to %s';
  S_ERR_DISCONNECTED_FROM = 'Disconnected from %s';

  S_FTP_GETTING_FILE      = 'Getting %s';
  S_FTP_PUTTING_FILE      = 'Uploading %s';

const
  C_PNL_STATUSTEXT = 0;
  C_PNL_STATUSBAR  = 1;

type
  TListItemType = (itFile, itFolder);

  TfrmSimpleFTP = class(TForm)
    ftpMain: TSimpleFTP;
    stbMain: TStatusBar;
    ToolBar1: TToolBar;
    aclMain: TActionList;
    spltVert: TSplitter;
    pnlTmpEdits: TPanel;
    imlButtons: TImageList;
    MainMenu1: TMainMenu;
    popLocal: TPopupMenu;
    popRemote: TPopupMenu;
    edtHost: TEdit;
    memStatus: TMemo;
    spltHorz: TSplitter;
    actConnectToSite: TAction;
    Label1: TLabel;
    edtUser: TEdit;
    Label2: TLabel;
    edtPassword: TEdit;
    Label3: TLabel;
    pnlLocal: TPanel;
    pnlRemote: TPanel;
    lvRemote: TListView;
    btnConnect: TToolButton;
    actDisconnect: TAction;
    btnDisconnect: TToolButton;
    ToolButton2: TToolButton;
    actGetFile: TAction;
    actPutFile: TAction;
    File1: TMenuItem;
    Connect1: TMenuItem;
    Disconnect1: TMenuItem;
    N1: TMenuItem;
    actExit: TAction;
    actExit1: TMenuItem;
    lvLocal: TListView;
    actRefreshRemote: TAction;
    actCDUPRemote: TAction;
    pnlRemoteLbl: TPanel;
    pnlLocalLbl: TPanel;
    edtCommand: TEdit;
    btnGet: TToolButton;
    btnPut: TToolButton;
    btnRefresh: TToolButton;
    ToolButton1: TToolButton;
    Label4: TLabel;
    GetFile1: TMenuItem;
    PutFile1: TMenuItem;
    N2: TMenuItem;
    Refresh1: TMenuItem;
    actRefreshLocal: TAction;
    N3: TMenuItem;
    actRefreshRemote1: TMenuItem;
    pbMain: TProgressBar;
    actGetAllFiles: TAction;
    imlFiles: TImageList;
    tlbLocal: TToolBar;
    btnCDUPLocal: TToolButton;
    tlbRemote: TToolBar;
    btnCDUPRemote: TToolButton;
    actCDUPLocal: TAction;
    procedure edtHostKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ftpMainFindItem(Sender: TObject;
      FindData: _WIN32_FIND_DATAA);
    procedure actConnectToSiteExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure lvRemoteDblClick(Sender: TObject);
    procedure ftpMainDisconnected(Sender: TObject);
    procedure ftpMainConnected(Sender: TObject);
    procedure actRefreshRemoteExecute(Sender: TObject);
    procedure actCDUPRemoteExecute(Sender: TObject);
    procedure actDisconnectExecute(Sender: TObject);
    procedure edtCommandKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvRemoteSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvRemoteCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure actRefreshLocalExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvLocalDblClick(Sender: TObject);
    procedure stbMainDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure actGetFileExecute(Sender: TObject);
    procedure ftpMainTransferProgress(Sender: TObject;
      ProgressInfo: TFTPProgressInfo);
    procedure actPutFileExecute(Sender: TObject);
    procedure lvLocalSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure actCDUPLocalExecute(Sender: TObject);
  private
    { Private declarations }
    procedure AddNewFileItem(Item: TListItem; FindData: TWin32FindData);
    function GetShellInfo(const FileName: string;
      dwFileAttributes: DWORD): TSHFileInfo;
    function GetListItemType(Item: TListItem): TListItemType;
    function GetLocalDir: string;
    function GetRemoteDir: string;
    procedure SetLocalDir(const Value: string);
    procedure SetRemoteDir(const Value: string);
  public
    { Public declarations }
    procedure ConnectToSite;
    procedure ClearFileList(
      const lvFiles: TListView; sPath: string
    );

    property LocalDir: string read GetLocalDir write SetLocalDir;
    property RemoteDir: string read GetRemoteDir write SetRemoteDir;
  end;

var
  frmSimpleFTP: TfrmSimpleFTP;

implementation
uses
  RGStrFuncs;
{$R *.DFM}

procedure TfrmSimpleFTP.ConnectToSite;
begin
  Screen.Cursor := crAppStart;
  try
    with ftpMain do begin
      HostName := edtHost.Text;
      UserName := edtUser.Text;
      Password := edtPassword.Text;
      Disconnect;
      lvRemote.Items.Clear;
      try
        Connect;
      except
        On E: Exception do
          memStatus.Lines.Add(E.Message);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;


procedure TfrmSimpleFTP.edtHostKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_RETURN then
    ConnectToSite;
end;


procedure TfrmSimpleFTP.ftpMainFindItem(Sender: TObject;
  FindData: _WIN32_FIND_DATAA);
begin
  If (string(FindData.cFileName) = '.') or
  (string(FindData.cFileName) = '..') then
    exit;

  AddNewFileItem(lvRemote.Items.Add, FindData);
end;


procedure TfrmSimpleFTP.actConnectToSiteExecute(Sender: TObject);
begin
  ConnectToSite;
end;


procedure TfrmSimpleFTP.actExitExecute(Sender: TObject);
begin
  Close;
end;


procedure TfrmSimpleFTP.lvRemoteDblClick(Sender: TObject);
var
  sOldDir: string;
begin
  if not assigned(lvRemote.Selected) then
    exit;

  Case GetListItemType(lvRemote.Selected) of
    itFile:
      actGetFile.Execute;

    itFolder:
    begin          
      sOldDir := RemoteDir;
      RemoteDir := Add_UNIXSlash(sOldDir)
        + lvRemote.Selected.Caption;
    end;
  end;
end;


procedure TfrmSimpleFTP.ClearFileList(
  const lvFiles: TListView; sPath: string
);
var
  i: Integer;
begin
  with lvFiles do begin
    for i := 0 to Pred(Items.Count) do
      if assigned(Items[i].Data) then
        dispose(pWin32FindData(Items[i].Data));

    Items.Clear;
  end;
end;


procedure TfrmSimpleFTP.ftpMainDisconnected(Sender: TObject);
begin
  memStatus.Lines.Add(Format(S_ERR_DISCONNECTED_FROM, [ftpMain.HostName]));
  actConnectToSite.Enabled := True;
  actDisconnect.Enabled := False;
  actRefreshRemote.Enabled := False;
  ClearFileList(lvRemote, RemoteDir);
  RemoteDir := '/';
end;


procedure TfrmSimpleFTP.ftpMainConnected(Sender: TObject);
begin
  with ftpMain do begin
    actConnectToSite.Enabled := False;
    actDisconnect.Enabled := True;
    actRefreshRemote.Enabled := True;
    memStatus.Lines.Add(MOTD);
    memStatus.Lines.Add(Format(S_ERR_CONNECTED_TO, [HostName]));
    List;
  end;
end;


procedure TfrmSimpleFTP.actRefreshRemoteExecute(Sender: TObject);
begin
  Screen.Cursor := crAppStart;
  actCDUPRemote.Enabled := (Length(RemoteDir) > 1);
  try
    ClearFileList(lvRemote, RemoteDir);
    pnlRemoteLbl.Caption := RemoteDir;
    ftpMain.List;
    lvRemote.AlphaSort;
  finally
    Screen.Cursor := crDefault;
  end;
end;


procedure TfrmSimpleFTP.actCDUPRemoteExecute(Sender: TObject);
begin
  RemoteDir := '..';
end;


procedure TfrmSimpleFTP.actDisconnectExecute(Sender: TObject);
begin
  ftpMain.Disconnect;
end;


procedure TfrmSimpleFTP.edtCommandKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {$ifdef USING_IE5}
  If Key = VK_RETURN then
    with ftpMain do begin
      FTPCommand(edtCommand.Text, nil);
      memStatus.Lines.Add(LastError);
    end;
  {$endif}
end;


procedure TfrmSimpleFTP.lvRemoteSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  actGetFile.Enabled :=
    (Selected)
  and
    (TWin32FindData(Item.Data^).dwFileAttributes and faDirectory = 0);
end;


procedure TfrmSimpleFTP.lvRemoteCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  // Files are equal (both dirs or both files), compare by text
  If {(TWin32FindData(Item1.Data^).dwFileAttributes and faDirectory)
  =  (TWin32FindData(Item2.Data^).dwFileAttributes and faDirectory)
  }
  GetListItemType(Item1) = GetListItemType(Item2)
  then begin
    Compare := CompareText(Item1.Caption, Item2.Caption);
    exit;
  end;

  If GetListItemType(Item1) = itFolder
  then
    Compare := -1
  else
    Compare := 1;
end;


procedure TfrmSimpleFTP.actRefreshLocalExecute(Sender: TObject);
var
  srHits:   TSearchRec;
begin
  Screen.Cursor := crAppStart;
  try
    ClearFileList(lvLocal, LocalDir);
    actCDUPLocal.Enabled := (Length(LocalDir) > 2);
    try
      if FindFirst(
        Add_Slash(LocalDir) + '*.*', faAnyFile - faSysFile, srHits
      ) = 0 then begin
        try
          repeat
            If (srHits.Name = '..') or (srHits.Name = '.') then
              Continue;

            AddNewFileItem(lvLocal.Items.Add, srHits.FindData);
          until FindNext(srHits) <> 0;
        finally
          Sysutils.FindClose(srHits);
        end;
      end;
    except
      on exception do ;
    end;
    lvLocal.AlphaSort;
  finally
    Screen.Cursor := crDefault;
  end;
end;


procedure TfrmSimpleFTP.FormCreate(Sender: TObject);
var
  SFI: TSHFileInfo;
begin
  pbMain.Parent := stbMain;
  imlFiles.Handle := SHGetFileInfo('', 0, SFI, SizeOf(SFI),
   SHGFI_SYSICONINDEX or SHGFI_SMALLICON);

  actRefreshLocal.Execute;
end;


procedure TfrmSimpleFTP.AddNewFileItem(Item: TListItem;
  FindData: TWin32FindData);
{
  With a newly-added item, sort out its viewable properties based on the
  TWin32FindData structure supplied
}
var
  NewWin32Data: pWin32FindData;
  SFI:          TSHFileInfo;
begin
  with Item do begin
    new(NewWin32Data);
    move(FindData, NewWin32Data^, sizeof(FindData));
    Data := NewWin32Data;

    Caption := FindData.cFileName;

    SFI := GetShellInfo(
      Add_Slash(LocalDir) + Item.Caption,
      FindData.dwFileAttributes
    );

    ImageIndex := SFI.iIcon;

    If (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY)
      = FILE_ATTRIBUTE_DIRECTORY then
      SubItems.Add('')
    else
      // Add file size
      SubItems.Add(
        NormalizeBytesTransferred(FindData.nFileSizeLow)
      );

    // Add type
    SubItems.Add(StrPas(SFI.szTypeName));

    // Add last modified
    SubItems.Add(
      FormatDateTime(
        'dd/mm/yyyy hh:mm:ss',
        FileTimeToDateTime(FindData.ftLastWriteTime)
      )
    );
  end;
end;


procedure TfrmSimpleFTP.lvLocalDblClick(Sender: TObject);
begin
  If not assigned(lvLocal.Selected) then
    exit;

  Case GetListItemType(lvLocal.Selected) of
    itFile:
      actPutFile.Execute;

    itFolder:
    begin
      LocalDir :=
        Add_Slash(LocalDir) + lvLocal.Selected.Caption;

      actRefreshLocal.Execute;
    end;
  end;
end;


function TfrmSimpleFTP.GetLocalDir: string;
begin
  result := pnlLocallbl.Caption;
end;


function TfrmSimpleFTP.GetRemoteDir: string;
begin
  result := ftpMain.RemoteDir;
end;


procedure TfrmSimpleFTP.SetLocalDir(const Value: string);
begin
  pnlLocalLbl.Caption := Value;
  actRefreshLocal.Execute;
end;


procedure TfrmSimpleFTP.SetRemoteDir(const Value: string);
begin
  ftpMain.RemoteDir := Value;
  actRefreshRemote.Execute;
end;


procedure TfrmSimpleFTP.stbMainDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  NewRect: TRect;
begin
  If Panel.Index = C_PNL_STATUSBAR then begin
    NewRect := Rect;
    InflateRect(NewRect, 1, 1);
    pbMain.BoundsRect := NewRect;
  end;
end;


procedure TfrmSimpleFTP.actGetFileExecute(Sender: TObject);
begin
  If not assigned(lvRemote.Selected) then
    exit;

  Screen.Cursor := crAppStart;
  try
    stbMain.Panels[C_PNL_STATUSTEXT].Text :=
      Format(S_FTP_GETTING_FILE, [lvRemote.Selected.Caption]);

    memStatus.Lines.Add(
      stbMain.Panels[C_PNL_STATUSTEXT].Text
    );

    ftpMain.LocalDir := LocalDir;
    try
      ftpMain.GetFile(lvRemote.Selected.Caption);
    except
      On E: Exception do begin
        memStatus.Lines.Add(E.Message);
        memStatus.Lines.Add(ftpMain.LastError);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;


procedure TfrmSimpleFTP.ftpMainTransferProgress(Sender: TObject;
  ProgressInfo: TFTPProgressInfo);
begin
  stbMain.Refresh;
end;


procedure TfrmSimpleFTP.actPutFileExecute(Sender: TObject);
begin
  If not assigned(lvLocal.Selected) then
    exit;

  Screen.Cursor := crAppStart;
  try
    stbMain.Panels[C_PNL_STATUSTEXT].Text :=
      Format(S_FTP_PUTTING_FILE, [lvLocal.Selected.Caption]);

    memStatus.Lines.Add(
      stbMain.Panels[C_PNL_STATUSTEXT].Text
    );

    ftpMain.LocalDir := LocalDir;
    try
      ftpMain.PutFile(lvLocal.Selected.Caption);
    except
      On E: Exception do begin
        memStatus.Lines.Add(E.Message);
        memStatus.Lines.Add(ftpMain.LastError);
      end;
    end;
    
  finally
    Screen.Cursor := crDefault;
  end;
end;


procedure TfrmSimpleFTP.lvLocalSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  actPutFile.Enabled :=
    (Selected)
  and
    not (GetListItemType(Item) = itFolder)
  and
    (ftpMain.State = fsConnected);
end;


function TfrmSimpleFTP.GetShellInfo(const FileName: string;
  dwFileAttributes: DWORD): TSHFileInfo;
begin
  SHGetFileInfo(PChar(FileName), dwFileAttributes, result, SizeOf(TSHFileInfo),
    SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES);
end;


function TfrmSimpleFTP.GetListItemType(Item: TListItem): TListItemType;
begin
  If not assigned(Item.Data) then begin
    result := itFile;
    exit;
  end;

  If (TWin32FindData(Item.Data^).dwFileAttributes and faDirectory <> 0) then
    result := itFolder
  else
    result := itFile;
end;


procedure TfrmSimpleFTP.actCDUPLocalExecute(Sender: TObject);
begin
  LocalDir := ParentDir(LocalDir, '\');
end;

end.
