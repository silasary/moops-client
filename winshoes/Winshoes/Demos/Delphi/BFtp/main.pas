unit main;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, simpftp, ComCtrls, Menus, WinInetControl;

type
	TformMain = class(TForm)
    lboxStatus: TListBox;
    ftpc: TSimpleFTP;
		butnUpload: TButton;
		chckUploadAll: TCheckBox;
    chckProxy: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    lablProxyLabel: TLabel;
    lablServer: TLabel;
    lablUsername: TLabel;
		lablDestination: TLabel;
		lablProxy: TLabel;
		Label6: TLabel;
		lablFile: TLabel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    itemFile_Exit: TMenuItem;
    N1: TMenuItem;
    itemFile_CreateDefaultConfig: TMenuItem;
    itemFile_Upload: TMenuItem;
    lablCurrent: TLabel;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
		procedure FormCreate(Sender: TObject);
		procedure FormDestroy(Sender: TObject);
		procedure butnUploadClick(Sender: TObject);
		procedure chckProxyClick(Sender: TObject);
    procedure itemFile_ExitClick(Sender: TObject);
    procedure itemFile_CreateDefaultConfigClick(Sender: TObject);
	private
		procedure LoadFile(const sFile: String);
	public
		slstParams: TStringList;
		msProxy, msInputFile, msSource, msDest: String;
		mbSubDirs: Boolean;
		procedure Upload(const psPath: string; const pbUploadAll: Boolean; const pbIsSubDir: boolean);
	end;

var
	formMain: TformMain;

implementation
{$R *.DFM}

Uses
	Edit
  , GlobalWinshoe;

procedure TformMain.LoadFile;
begin
	if FileExists(msInputFile) then
    slstParams.LoadFromFile(msInputFile);
	lablFile.Caption := ExtractFileName(msInputFile);

	msSource := slstParams.Values['Source'];
	if length(msSource) = 0 then
    msSource := ExtractFilePath(msInputFile);
	if Copy(msSource, Length(msSource), 1) <> '\' then
    msSource := msSource + '\';

	msProxy := 'proxy';
	lablProxy.Caption := msProxy;

	msDest := slstParams.Values['Dest'];
	if Pos(Copy(msDest, Length(msDest), 1), '\/') = 0 then
    msDest := msDest + '/';
	lablDestination.Caption := msDest;

	lablUsername.Caption := slstParams.Values['User'];
	lablServer.Caption := slstParams.Values['Server'];
end;

procedure TformMain.FormCreate(Sender: TObject);
begin
	slstParams := TStringList.Create;
	if ParamCount > 0 then
		msInputFile := ParamStr(1)
	else
		msInputFile := ExtractFilePath(Application.EXEName) + 'default.bftp';
	LoadFile(msInputFile);
end;

procedure TformMain.FormDestroy(Sender: TObject);
begin
	slstParams.Free;
end;

procedure TformMain.Upload;
var
	i: integer;
	bResult: Boolean;
	srch: TSearchRec;
begin
	ftpc.LocalDir := msSource + psPath;
	if not ftpc.ChangeRemoteDir(msDest + StringReplace(psPath, '\', '/'
   , [rfReplaceall])) then begin
		ftpc.MkDir(msDest + StringReplace(psPath, '\', '/', [rfReplaceall]));
		ftpc.ChangeRemoteDir(msDest + StringReplace(psPath, '\', '/', [rfReplaceall]));
	end;

	i := FindFirst(msSource + psPath + '*.*', faReadOnly + faArchive, srch); try
		while i = 0 do begin
			if ((FileGetAttr(msSource + psPath + srch.Name) and faArchive) <> 0)
			 or pbUploadAll then begin
				lboxStatus.Items.Add(psPath + srch.name);
				lboxStatus.ItemIndex := lboxStatus.Items.Count - 1;

				bResult := ftpc.PutFile(srch.name);
				if bResult then
					FileSetAttr(msSource + psPath + srch.Name,
					 FileGetAttr(msSource + psPath + srch.Name) and (not faArchive))
				else
					lboxStatus.Items.Add('  Put Failed: ' + ftpc.LastError);
			end;
			i := FindNext(srch);
		end;
	finally FindClose(srch); end;

	if mbSubDirs then begin
		i := FindFirst(msSource + psPath + '*.*', faDirectory, srch); Try
			while i = 0 do begin
				if (srch.name <> '.') and (srch.name <> '..')
				 and ((srch.Attr and faDirectory) <> 0) then
					Upload(psPath + srch.Name + '\', pbUploadAll, True);
				i := FindNext(srch);
			end;
		finally FindClose(srch); end;
	end;
end;

procedure TformMain.butnUploadClick(Sender: TObject);
begin
  lboxStatus.Items.Clear;
  butnUpload.Enabled := False; try
    mbSubDirs := slstParams.Values['NoSubDirs'] = '';
    if not mbSubDirs then
      mbSubDirs := UpperCase(slstParams.Values['NoSubDirs'][1]) <> 'F';
    with ftpc do begin
      if chckProxy.checked then begin
        Hostname := msProxy;
        Username := slstParams.Values['User'] + '@'
         + slstParams.Values['Server'];
      end else begin
        Hostname := slstParams.Values['Server'];
        Username := slstParams.Values['User'];
      end;
      Password := slstParams.Values['Password'];
      if length(Password) = 0 then
        Password := Trim(InputBox('', 'Enter Password:', ''));

      lboxStatus.Items.Add('Connecting to ' + Hostname);
      Connect; Try
        Upload('', chckUploadAll.Checked, False);
      finally Disconnect; end;
    end;
  finally
    lboxStatus.Items.Add('----Done');
    lboxStatus.ItemIndex := lboxStatus.Items.Count - 1;
    butnUpload.Enabled := True;
  end;
end;

procedure TformMain.chckProxyClick(Sender: TObject);
begin
	lablProxy.Visible := chckProxy.Checked;
	lablProxyLabel.Visible := lablProxy.Visible;
end;

procedure TformMain.itemFile_ExitClick(Sender: TObject);
begin
	Close;
end;

procedure TformMain.itemFile_CreateDefaultConfigClick(Sender: TObject);
begin
	with TFormEdit.Create(Self) do try
		LoadFile(ExtractFilePath(Application.EXEName) + 'default.bftp');
		if ShowModal = mrOK then
      LoadFile(btedFile.text);
	finally free; end;
end;

end.
