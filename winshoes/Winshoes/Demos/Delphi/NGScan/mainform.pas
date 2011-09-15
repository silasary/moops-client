unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Winshoes, NNTPWinshoe, Db, DBTables, ComCtrls, Grids, DBGrids,
  ExtCtrls, DBCtrls, WinshoeMessage, Menus, ToolWin, Buttons, ImgList, RootMainForm;

type
  TformMain = class(TformRootMain)
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    tbtnNew: TToolButton;
    tbtnDelete: TToolButton;
    ToolButton3: TToolButton;
    tbtnNewsgroups: TToolButton;
    tbtnReset: TToolButton;
    Splitter1: TSplitter;
    ilstFolders: TImageList;
    pmnuFolders: TPopupMenu;
    pitmProperties: TMenuItem;
    pitmDelete: TMenuItem;
    pitmNew: TMenuItem;
    Panel3: TPanel;
    lstvFolders: TTreeView;
    Panel4: TPanel;
    Panel5: TPanel;
    Label4: TLabel;
    dtpkBegin: TDateTimePicker;
    dtpkEnd: TDateTimePicker;
    Panel1: TPanel;
    Memo1: TMemo;
    Panel2: TPanel;
    Label1: TLabel;
    mitmView: TMenuItem;
    mitmRefresh: TMenuItem;
    pitmReset: TMenuItem;
    pitmNewsgroups: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    pitmRetrieve: TMenuItem;
    N3: TMenuItem;
    pitmGenerate: TMenuItem;
    mitmEmptyArticle: TMenuItem;
    pitmPostTopTen: TMenuItem;
    mitmProperties: TMenuItem;
    N5: TMenuItem;
    mitmToolbar: TMenuItem;
    mitmStatusBar: TMenuItem;
    mitmTools: TMenuItem;
    mitmNewsgroups: TMenuItem;
    mitmReset: TMenuItem;
    mitmMessages: TMenuItem;
    mitmRetrieve: TMenuItem;
    mitmGenerate: TMenuItem;
    mitmPostTopTen: TMenuItem;
    N10: TMenuItem;
    mitmNew: TMenuItem;
    mitmDelete: TMenuItem;
    ToolButton2: TToolButton;
    tbtnRetrieve: TToolButton;
    tbtnGenerate: TToolButton;
    tbtnPostTopTen: TToolButton;
    ToolButton6: TToolButton;
    tbtnProperties: TToolButton;
    ilstToolbar: TImageList;
    procedure DetermineProtection(Sender: TObject);
    procedure lstvFoldersDeletion(Sender: TObject; Node: TTreeNode);
    procedure pitmPropertiesClick(Sender: TObject);
    procedure lstvFoldersChange(Sender: TObject; Node: TTreeNode);
    procedure mitmRefreshClick(Sender: TObject);
    procedure pitmNewClick(Sender: TObject);
    procedure pitmDeleteClick(Sender: TObject);
    procedure pitmResetClick(Sender: TObject);
    procedure pitmNewsgroupsClick(Sender: TObject);
    procedure pitmRetrieveClick(Sender: TObject);
    procedure pitmGenerateClick(Sender: TObject);
    procedure pmnuFoldersPopup(Sender: TObject);
    procedure mitmEmptyArticleClick(Sender: TObject);
    procedure pitmPostTopTenClick(Sender: TObject);
    procedure mitmViewClick(Sender: TObject);
  private
  protected
    procedure UpdateStatus;
    procedure BuildDisplay(Sender: TObject);
    function FirstNewsgroup(Node: TTreeNode) : TTreeNode;
  public
    constructor Create(AOwner: TComponent); override;
    function AddChildNode(ParentNode: TTreeNode; RefID: Integer) : TTreeNode;
    procedure BuildSubscribedNewsgroups(HostNode: TTreeNode);
  end;

var
  formMain: TformMain;

implementation

{$R *.DFM}

uses
  Datamodule, FolderList, RootProp, HostsForm, NewsgroupsForm,
  ListingForm, MsgRetrieveForm, TopTenForm, MsgSendForm, SubscriptionsForm,
  DemoUtils;

constructor TformMain.Create(AOwner: TComponent);
var
  qeryFolders: TQuery;
  FolderNode: TTreeNode;
begin
  inherited Create(AOwner);
  AboutTitle := 'Newsgroup Scanner Demo';
  AboutAuthor := 'Joe Martin';
  AboutAddress := 'jmartin@viasft.com';

  dtpkEnd.Date := Date;
  FolderNode := nil;

  {-Load subscribed newsgroup list}
  qeryFolders := dataMain.SelectQuery('Select Folder_ID from Folders');
  try
    qeryFolders.Open;
    while not qeryFolders.EOF do begin
      FolderNode := AddChildNode(nil, qeryFolders.Fields[0].AsInteger);

      with dataMain.SelectQuery('Select Host_ID from Hosts where Folder_ID = '+
        IntToStr(qeryFolders.Fields[0].AsInteger)) do begin
        try
          Open;
          while not EOF do begin
            BuildSubscribedNewsgroups(AddChildNode(FolderNode, Fields[0].AsInteger));
            Next;
          end;
        finally
          Free;
        end;
      end;

      qeryFolders.Next;
    end;
  finally
    qeryFolders.Free;
  end;

  if Assigned(FolderNode) then
    FolderNode.Expand(False);
  lstvFolders.Selected := lstvFolders.Items.GetFirstNode;
end;

function TformMain.AddChildNode(ParentNode: TTreeNode; RefID: Integer) : TTreeNode;
begin
  Result := lstvFolders.Items.AddChild(ParentNode, '');
  if not Assigned(ParentNode) then
    Result.Data := TFolderData.Create(RefID)
  else if TObject(ParentNode.Data) is TFolderData then
    Result.Data := THostData.Create(RefID)
  else if TObject(ParentNode.Data) is THostData then
    Result.Data := TNewsgroupData.Create(RefID);

  if Assigned(Result.Data) then begin
    TObjectData(Result.Data).Data := Result;
    TObjectData(Result.Data).OnDataUpdate := BuildDisplay;
    TObjectData(Result.Data).DataUpdate;
  end;
end;

procedure TformMain.BuildSubscribedNewsgroups(HostNode: TTreeNode);
begin
  lstvFolders.Items.BeginUpdate;
  try
    Screen.Cursor := crHourGlass;
    HostNode.DeleteChildren;
    with dataMain.SelectQuery('Select Newsgroup_ID from Newsgroups where Host_ID='+
      IntToStr(THostData(HostNode.Data).HostID)+' and Subscribed=True') do begin
      try
        Open;
        while not EOF do begin
          AddChildNode(HostNode, Fields[0].AsInteger);
          Next;
        end;

        HostNode.AlphaSort;
        HostNode.Expand(True);
      finally
        Free;
      end;
    end;
  finally
    lstvFolders.Items.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TformMain.UpdateStatus;
var
  Node: TTreeNode;
  Hosts, Count: Integer;
begin
  Count := 0;
  Hosts := 0;
  Node := lstvFolders.Items.GetFirstNode.GetFirstChild;
  while Assigned(Node) do begin
    Inc(Hosts);
    Inc(Count, Node.Count);
    Node := Node.GetNextChild(Node);
  end;
  StatusBar1.Panels[0].Text := 'Hosts: '+IntToStr(Hosts);
  StatusBar1.Panels[1].Text := 'Newsgroups: '+IntToStr(Count);
end;

procedure TformMain.BuildDisplay(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TTreeNode(TObjectData(Sender).Data);

  if Sender is TFolderData then begin
    Node.Text := TFolderData(Sender).FolderDesc;
    Node.ImageIndex    := 0;
    Node.SelectedIndex := 0;
  end else if Sender is THostData then begin
    Node.Text := THostData(Sender).HostDesc;
    Node.ImageIndex    := 1;
    Node.SelectedIndex := 1;
  end else if Sender is TNewsgroupData then begin
    Node.Text := TNewsgroupData(Sender).NewsgroupDesc;
    Node.ImageIndex    := 2;
    Node.SelectedIndex := 2;
  end;

  UpdateStatus;
end;

procedure TformMain.DetermineProtection(Sender: TObject);
begin
  pitmDelete.Visible := TObject(lstvFolders.Selected.Data) is THostData;
  mitmDelete.Enabled := pitmDelete.Visible;
  tbtnDelete.Enabled := pitmDelete.Visible;

  N2.Visible := TObject(lstvFolders.Selected.Data) is THostData;
  pitmReset.Visible := N2.Visible;
  mitmReset.Enabled := pitmReset.Visible;
  tbtnReset.Enabled := pitmReset.Visible;
  pitmNewsgroups.Visible := N2.Visible;
  mitmNewsgroups.Enabled := pitmNewsgroups.Visible;
  tbtnNewsgroups.Enabled := pitmNewsgroups.Visible;

  N1.Visible := not (TObject(lstvFolders.Selected.Data) is TFolderData);
  pitmProperties.Visible := N1.Visible;
  mitmProperties.Enabled := pitmProperties.Visible;
  tbtnProperties.Enabled := pitmProperties.Visible;
end;

function TformMain.FirstNewsgroup(Node: TTreeNode) : TTreeNode;
begin
  Result := nil;
  if TObject(Node.Data) is TNewsgroupData then
    Result := Node
  else if TObject(Node.Data) is THostData then
    Result := Node.GetFirstChild
  else if TObject(Node.Data) is TFolderData then begin
    Result := Node.GetFirstChild;
    while Assigned(Result) do begin
      if TObject(Result.Data) is TNewsgroupData then
        Break
      else
        Result := Result.GetNext;
    end;
  end;

  if Result = nil then
    Result := Node;
end;

procedure TformMain.lstvFoldersDeletion(Sender: TObject; Node: TTreeNode);
begin
  if Assigned(Node.Data) then begin
    TObject(Node.Data).Free;
    UpdateStatus;
  end;
end;

procedure TformMain.pitmPropertiesClick(Sender: TObject);
var
  PropForm: TformRootProp;
begin
  if TObject(lstvFolders.Selected.Data) is THostData then
    PropForm := TformHosts.Create(Self)
  else if TObject(lstvFolders.Selected.Data) is TNewsgroupData then
    PropForm := TformNewsgroups.Create(Self)
  else
    PropForm := nil;

  if Assigned(PropForm) then begin
    try
      PropForm.OrigData := TObjectData(lstvFolders.Selected.Data);
      PropForm.ShowModal;
    finally
      PropForm.Free;
    end;
  end;
end;

procedure TformMain.lstvFoldersChange(Sender: TObject; Node: TTreeNode);
begin
  if Assigned(Node) and (TObject(Node.Data) is TNewsgroupData) then begin
    Memo1.Lines.Assign(TNewsgroupData(Node.Data).List);
  end else
    Memo1.Lines.Clear;

  DetermineProtection(Sender);
end;

procedure TformMain.mitmRefreshClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := lstvFolders.Items.GetFirstNode;
  while Assigned(Node) do begin
    BuildDisplay(Node.Data);
    Node := Node.GetNext;
  end;
end;

procedure TformMain.pitmNewClick(Sender: TObject);
var
  HostNode: TTreeNode;
begin
  HostNode := nil;

  with dataMain, tablHosts do begin
    Append;
    tablHostsFolder_ID.Value := TFolderData(lstvFolders.Items.GetFirstNode.Data).FolderID;
    tablHostsPort.Value := 119;
    tablHostsInclude_During_Scan.Value := True;
    Post;

    with TformHosts.Create(Self) do begin
      try
        OrigData := THostData.Create(tablHostsHost_ID.Value);
        try
          ShowModal;
          if ChangesPosted then begin
            HostNode := AddChildNode(lstvFolders.Items.GetFirstNode, tablHostsHost_ID.Value);
            if lstvFolders.Items.GetFirstNode.Count = 1 then
              lstvFolders.FullExpand;
          end else
            tablHosts.Delete;
        finally
          OrigData.Free;
        end;
      finally
        Free;
      end;
    end;
  end;
  {-A new news server was defined}
  if Assigned(HostNode) then begin
    lstvFolders.Selected := HostNode;
    pitmNewsgroupsClick(Sender);
  end;
end;

procedure TformMain.pitmDeleteClick(Sender: TObject);
var
  HostData: THostData;
begin
  HostData := THostData(lstvFolders.Selected.Data);
  if MessageDlg('Are you sure you wish to delete ' + HostData.HostDesc + '?',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;

  Screen.Cursor := crHourGlass;
  try
    dataMain.DeleteHost(HostData.HostID);
    lstvFolders.Items.Delete(lstvFolders.Selected);
    lstvFolders.Selected := lstvFolders.Items.GetFirstNode;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TformMain.pitmResetClick(Sender: TObject);
begin
  with TformListing.Create(Self) do begin
    try
      HostData := THostData(lstvFolders.Selected.Data);
      Show;
    finally
      Free;
    end;
  end;
end;

procedure TformMain.pitmNewsgroupsClick(Sender: TObject);
var
  HostNode: TTreeNode;
begin
  with TformSubscriptions.Create(Self) do begin
    try
      ShowModal;
    finally
      Free;
    end;
  end;

  Refresh;

  HostNode := lstvFolders.Items.GetFirstNode.getFirstChild;
  while Assigned(HostNode) do begin
    if THostData(HostNode.Data).Modified then begin
      THostData(HostNode.Data).Modified := False;
      BuildSubscribedNewsgroups(HostNode);
    end;

    HostNode := HostNode.GetNextChild(HostNode);
  end;
end;

procedure TformMain.pitmRetrieveClick(Sender: TObject);
begin
  with TformMsgRetrieve.Create(Self) do begin
    try
      TreeNode := lstvFolders.Selected;
      Show;
    finally
      Free;
    end;
  end;
end;

procedure TformMain.pitmGenerateClick(Sender: TObject);
begin
  with TformTopTen.Create(Self) do begin
    try
      TreeNode  := lstvFolders.Selected;
      BeginDate := dtpkBegin.Date;
      EndDate   := dtpkEnd.Date;
      Show;
    finally
      lstvFolders.Selected := FirstNewsgroup(TreeNode);
      Free;
    end;
  end;

  lstvFoldersChange(lstvFolders, lstvFolders.Selected);
end;

procedure TformMain.pmnuFoldersPopup(Sender: TObject);
var
  ItemData: TObjectData;
begin
  ItemData := TObjectData(lstvFolders.Selected.Data);
  if ItemData is TFolderData then begin
    pitmRetrieve.Caption := 'Retrieve msgs from all Hosts';
    mitmRetrieve.Caption := pitmRetrieve.Caption;
    pitmGenerate.Caption := 'Generate Top Ten report for all Hosts';
    mitmGenerate.Caption := pitmGenerate.Caption;
  end else if ItemData is THostData then begin
    pitmRetrieve.Caption := 'Retrieve msgs from: '+THostData(ItemData).HostName;
    mitmRetrieve.Caption := pitmRetrieve.Caption;
    pitmGenerate.Caption := 'Generate Top Ten report for: '+THostData(ItemData).HostName;
    mitmGenerate.Caption := pitmGenerate.Caption;
  end else if ItemData is TNewsgroupData then begin
    pitmRetrieve.Caption := 'Retrieve msgs from: '+TNewsgroupData(ItemData).NewsgroupName;
    mitmRetrieve.Caption := pitmRetrieve.Caption;
    pitmGenerate.Caption := 'Generate Top Ten report for: '+TNewsgroupData(ItemData).NewsgroupName;
    mitmGenerate.Caption := pitmGenerate.Caption;
  end;
  DetermineProtection(Sender);
end;

procedure TformMain.mitmEmptyArticleClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  dataMain.tablArticle.EmptyTable;
  Node := lstvFolders.Items.GetFirstNode;
  while Assigned(Node) do begin
    if TObject(Node.Data) is TNewsgroupData then begin
      TNewsgroupData(Node.Data).List.Clear;
    end;
    Node := Node.GetNext;
  end;
  lstvFoldersChange(lstvFolders, lstvFolders.Selected);
end;

procedure TformMain.pitmPostTopTenClick(Sender: TObject);
begin
  if MessageDlg('This process will generate a message containing the results of'+#13+
                'the top ten posters and send it to its respective newsgroup.'+#13+
                'Are you sure this is what you want to do?',
                mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;

  if MessageDlg('Last chance, are you sure you wish to generate these message(s)?',
                mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;

  with TformMsgSend.Create(Self) do begin
    try
      TreeNode := lstvFolders.Selected;
      Show;
    finally
      Free;
    end;
  end;
end;

procedure TformMain.mitmViewClick(Sender: TObject);
begin
  mitmToolbar.Checked   := ToolBar1.Visible;
  mitmStatusBar.Checked := StatusBar1.Visible;
  if Sender = mitmToolBar then
    Toolbar1.Visible := not Toolbar1.Visible
  else if Sender = mitmStatusbar then
    StatusBar1.Visible := not Statusbar1.Visible;
end;

end.

