unit TopTenForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TformTopTen = class(TForm)
    butnCancel: TButton;
    Animate1: TAnimate;
    lablName: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure butnCancelClick(Sender: TObject);
  private
    FTreeNode: TTreeNode;
    FUserAbort: Boolean;
    FBeginDate: TDateTime;
    FEndDate: TDateTime;
  protected
    procedure GenerateTopTenPrim(NewsItem: TTreeNode);
    procedure GenerateNewsgroupTopTen(NewsItem: TTreeNode);
    procedure GenerateHostTopTen(HostItem: TTreeNode);
    procedure GenerateAllTopTen(RootItem: TTreeNode);
  public
    property TreeNode: TTreeNode read FTreeNode write FTreeNode;
    property BeginDate: TDateTime read FBeginDate write FBeginDate;
    property EndDate: TDateTime read FEndDate write FEndDate;
  end;

implementation

uses
  Datamodule, FolderList, DbTables, DemoUtils;

{$R *.DFM}

procedure TformTopTen.GenerateTopTenPrim(NewsItem: TTreeNode);
var
  X, SubTotal, Total: Integer;
  NewsData: TNewsgroupData;
  procedure SetDateRange(qery: TQuery; ID: Integer);
  begin
    with qery do begin
      ParamByName('Newsgroup_ID').AsInteger := ID;
      ParamByName('Date_Begin').AsDate := FBeginDate;
      ParamByName('Date_End').AsDate := FEndDate;
      Open;
    end;
  end;
begin
  NewsData := TNewsgroupData(NewsItem.Data);
  NewsData.List.Clear;
  lablName.Caption := NewsData.NewsgroupName;
  lablName.Update;

  SetDateRange(dataMain.qeryArticleCountByAuthor, NewsData.NewsgroupID);
  SetDateRange(dataMain.qeryTotalMessages, NewsData.NewsgroupID);
  try
    with NewsData.List do begin
      Total := dataMain.qeryTotalMessagesArticle_Count.Value;

      Add('=========================================================');
      Add('Newsgroup: ' + NewsData.NewsgroupName);
      Add('Msg Count: ' + Commaize(Total));
      with dataMain.qeryArticleCountByAuthor do
        Add('Period   : ' + ParamByName('Date_Begin').AsString + ' thru '
                          + ParamByName('Date_End').AsString);
      Add('');
      Add('Ranking  Msgs    Author');
      Add('-------  ------  ----------------------------------------');

      dataMain.qeryArticleCountByAuthor.First;
      SubTotal := 0;

      for X := 1 to 10 do begin
        if dataMain.qeryArticleCountByAuthor.EOF then
          Break;

        Inc(SubTotal, dataMain.qeryArticleCountByAuthorArticle_Count.Value);

        Add('  ' + Pad(LPad(Commaize(X), 2), 7)
         + Pad(Commaize(dataMain.qeryArticleCountByAuthorArticle_Count.Value), 8)
         + dataMain.qeryArticleCountByAuthorAuthor_Name.Value + '  <'
         + dataMain.qeryArticleCountByAuthorReply_To.Value + '>');

        dataMain.qeryArticleCountByAuthor.Next;
      end;

      Add('');
      Add('Others:  ' + Commaize(Total-SubTotal));
    end;
  finally
    dataMain.qeryArticleCountByAuthor.Close;
    dataMain.qeryTotalMessages.Close;
  end;
end;

procedure TformTopTen.GenerateNewsgroupTopTen(NewsItem: TTreeNode);
begin
  GenerateTopTenPrim(NewsItem);
end;

procedure TformTopTen.GenerateHostTopTen(HostItem: TTreeNode);
var
  NewsItem: TTreeNode;
begin
  NewsItem := HostItem.GetFirstChild;
  while Assigned(NewsItem) and not FUserAbort do begin
    GenerateTopTenPrim(NewsItem);
    NewsItem := NewsItem.GetNextChild(NewsItem);
    Application.ProcessMessages;
    if FUserAbort then
      Break;
  end;
end;

procedure TformTopTen.GenerateAllTopTen(RootItem: TTreeNode);
var
  HostItem: TTreeNode;
begin
  HostItem := RootItem.GetFirstChild;
  while Assigned(HostItem) and not FUserAbort do begin
    GenerateHostTopTen(HostItem);
    HostItem := HostItem.GetNextChild(HostItem);
    Application.ProcessMessages;
    if FUserAbort then
      Break;
  end;
end;

procedure TformTopTen.butnCancelClick(Sender: TObject);
begin
  FUserAbort := True;
end;

procedure TformTopTen.FormActivate(Sender: TObject);
begin
  Refresh;
  Animate1.Active := True;
  if TObject(TreeNode.Data) is TFolderData then
    GenerateAllTopTen(TreeNode)
  else if TObject(TreeNode.Data) is THostData then
    GenerateHostTopTen(TreeNode)
  else if TObject(TreeNode.Data) is TNewsgroupData then
    GenerateNewsgroupTopTen(TreeNode);
end;

end.
