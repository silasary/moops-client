unit MsgRetrieveForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Winshoes, WinshoeMessage, NNTPWinshoe, FolderList;

type
  TformMsgRetrieve = class(TForm)
    butnCancel: TButton;
    pbarNewsgroup: TProgressBar;
    pbarMessage: TProgressBar;
    lablHost: TLabel;
    lablNewsgroup: TLabel;
    lablStatus: TLabel;
    lablNewsgroupCount: TLabel;
    lablMsgNumbers: TLabel;
    NNTP: TWinshoeNNTP;
    wsMSG: TWinshoeMessage;
    procedure butnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure NNTPStatus(Sender: TComponent; const sOut: String);
  private
    FTreeNode: TTreeNode;
    FUserAbort: Boolean;
    procedure SetHostData(HostData: THostData);
    procedure ResetDisplay;
  protected
    procedure RetrieveMsgsPrim(NewsItem: TTreeNode);
    procedure RetrieveNewsMsgs(NewsItem: TTreeNode);
    procedure RetrieveHostMsgs(HostItem: TTreeNode);
    procedure RetrieveAllMsgs(RootItem: TTreeNode);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property TreeNode: TTreeNode read FTreeNode write FTreeNode;
  end;

implementation

uses
  Datamodule, MainForm;

{$R *.DFM}

constructor TformMsgRetrieve.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  dataMain.tablAuthor.Open;
  dataMain.tablArticle.Open;
  ResetDisplay;
end;

destructor TformMsgRetrieve.Destroy;
begin
  dataMain.tablAuthor.Close;
  dataMain.tablArticle.Close;
  inherited Destroy;
end;

procedure TformMsgRetrieve.butnCancelClick(Sender: TObject);
begin
  FUserAbort := True;
end;

procedure TformMsgRetrieve.ResetDisplay;
begin
  lablHost.Caption := '';
  lablNewsgroupCount.Caption := '';
  lablNewsgroup.Caption := '';
  lablMsgNumbers.Caption := '';
  pbarNewsgroup.Position := 0;
  pbarMessage.Position := 0;
  Self.Refresh;
end;

procedure TformMsgRetrieve.SetHostData(HostData: THostData);
begin
  NNTP.Host        := HostData.HostName;
  NNTP.Port        := HostData.Port;
  NNTP.UserID      := HostData.UserID;
  NNTP.Password    := HostData.Password;
  lablHost.Caption := HostData.HostName;
  lablHost.Update;
end;

procedure TformMsgRetrieve.RetrieveMsgsPrim(NewsItem: TTreeNode);
var
  NewsData: TNewsgroupData;
  ArticleNo: Integer;
begin
  NewsData := TNewsgroupData(NewsItem.Data);
  pbarNewsgroup.Position := Succ(pbarNewsgroup.Position);
  lablNewsgroup.Caption := NewsData.NewsgroupName;
  lablNewsgroup.Update;

  NNTP.SelectGroup(NewsData.NewsgroupName);
  lablMsgNumbers.Caption := Format('(%d of %d)', [NewsData.HiMsg, NNTP.MsgHigh]);
  lablMsgNumbers.Update;
  {-Check to see if any new messages have been posted}
  if NewsData.HiMsg < NNTP.MsgHigh then begin
    try
      {-Adjust low message number if needed}
      if NewsData.HiMsg < Pred(NNTP.MsgLow) then begin
        NewsData.HiMsg := Pred(NNTP.MsgLow);
      end;

      with dataMain do begin
        pbarMessage.Max := NNTP.MsgHigh - NewsData.HiMsg;
        pbarMessage.Position := 0;

        {-Attempt to retrieve all message numbers since last run}
        for ArticleNo := Succ(NewsData.HiMsg) to NNTP.MsgHigh do begin
          try
            pbarMessage.Position := Succ(pbarMessage.Position);
            lablMsgNumbers.Caption := Format('(%d of %d)', [ArticleNo, NNTP.MsgHigh]);
            lablMsgNumbers.Update;
            {-Retrieve message from server}
            if NNTP.GetHeader(ArticleNo, '', wsMSG) then begin
              {-Add new Author name if not found}
              if not tablAuthor.FindKey([wsMSG.ExtractReal(wsMSG.From)]) then begin
                tablAuthor.Append;
                tablAuthorAuthor_Name.Value := wsMSG.ExtractReal(wsMSG.From);
                tablAuthorReply_To.Value    := wsMSG.ExtractAddr(wsMSG.From);
                tablAuthor.Post;
              end;

              {-Post message information for subsequent stat analysis}
              tablArticle.Append;
              tablArticleArticle_No.Value   := ArticleNo;
              tablArticleAuthor_ID.Value    := tablAuthorAuthor_ID.Value;
              tablArticleArticle_Date.Value := wsMSG.Date;
              tablArticleHost_ID.Value      := NewsData.HostID;
              tablArticleNewsgroup_ID.Value := NewsData.NewsgroupID;
              tablArticle.Post;
            end;
          except
            {-Absorbs missing articles from server}
          end;

          {-Check to see if user cancelled}
          Application.ProcessMessages;
          if FUserAbort or not NNTP.Connected then
            Break;
        end;
      end;

      NewsData.HiMsg := ArticleNo;
    finally
      NewsData.Save; {-Post changes}
    end;
  end;
end;

procedure TformMsgRetrieve.RetrieveNewsMsgs(NewsItem: TTreeNode);
begin
  SetHostData(THostData(NewsItem.Parent.Data));

  pbarNewsgroup.Max := 1;
  pbarNewsgroup.Position := 0;
  lablNewsgroupCount.Caption := '';
  lablNewsgroupCount.Update;

  NNTP.Connect;
  try
    RetrieveMsgsPrim(NewsItem);
  finally
    NNTP.Disconnect;
  end;
end;

procedure TformMsgRetrieve.RetrieveHostMsgs(HostItem: TTreeNode);
var
  NewsItem: TTreeNode;
begin
  SetHostData(THostData(HostItem.Data));

  pbarNewsgroup.Max := HostItem.Count;
  pbarNewsgroup.Position := 0;
  lablNewsgroupCount.Caption := Format('Subscribed: %d', [HostItem.Count]);
  lablNewsgroupCount.Update;

  NNTP.Connect;
  try
    NewsItem := HostItem.GetFirstChild;
    while Assigned(NewsItem) and not FUserAbort and NNTP.Connected do begin
      RetrieveMsgsPrim(NewsItem);
      NewsItem := NewsItem.GetNextChild(NewsItem);
    end;
  finally
    NNTP.Disconnect;
  end;
end;

procedure TformMsgRetrieve.RetrieveAllMsgs(RootItem: TTreeNode);
var
  HostItem: TTreeNode;
begin
  HostItem := formMain.lstvFolders.Items.GetFirstNode.GetFirstChild;
  while Assigned(HostItem) and not FUserAbort do begin
    ResetDisplay;

    if THostData(HostItem.Data).IncludeDuringScan then begin
      RetrieveHostMsgs(HostItem);
    end;

    HostItem := HostItem.GetNextChild(HostItem);
  end;
end;

procedure TformMsgRetrieve.FormActivate(Sender: TObject);
begin
  Refresh;
  if TObject(TreeNode.Data) is TFolderData then
    RetrieveAllMsgs(TreeNode)
  else if TObject(TreeNode.Data) is THostData then
    RetrieveHostMsgs(TreeNode)
  else if TObject(TreeNode.Data) is TNewsgroupData then
    RetrieveNewsMsgs(TreeNode);
end;

procedure TformMsgRetrieve.NNTPStatus(Sender: TComponent; const sOut: String);
begin
  lablStatus.Caption := Trim(sOut);
  lablStatus.Update;
end;

end.
