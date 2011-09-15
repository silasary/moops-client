unit frmMainUnit;
{
  NNTP Client Demo

    The program is intended to show the very basic
    nntp client capabilities. That is, listing
    groups, downloading headers, reading articles
    and posting both new and follow up articles.

    Articles are not sorted in any way.
    This demo has been kept single-threaded, since
    threading is not the issue here.

    by Asbjørn Heid (AH)


  History
    26 july 1999 - Added message indenting, body has to be downloaded for
                   this to work (AH)
                   
    15 july 1999 - Initial release (AH)
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ComCtrls, StdCtrls, Winshoes, WinshoeMessage, NNTPWinshoe,
  Menus, frmPropertiesUnit, frmArticleUnit, fileio;

type
  TfrmMain = class(TForm)
    wsNNTP: TWinshoeNNTP;
    lbGroups: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    lwMessages: TListView;
    ilFolders: TImageList;
    ilToolbar: TImageList;
    mnuMain: TMainMenu;
    mnuFile: TMenuItem;
    mnuGroup: TMenuItem;
    mnuMessage: TMenuItem;
    mnuExit: TMenuItem;
    mnuGetGroups: TMenuItem;
    mnuGetHeaders: TMenuItem;
    mnuGetBodies: TMenuItem;
    N1: TMenuItem;
    mnuNewFollowUp: TMenuItem;
    mnuOnline: TMenuItem;
    mnuConnect: TMenuItem;
    mnuProperties: TMenuItem;
    sbNews: TStatusBar;
    memoMsg: TMemo;
    mnuNewArticle: TMenuItem;
    mnuDisconnect: TMenuItem;
    procedure mnuConnectClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure wsNNTPStatus(Sender: TComponent; const sOut: String);
    procedure wsNNTPNewsgroupList(const sNewsgroup: String; const lLow,
      lHigh: Cardinal; const sType: String; var CanContinue: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure lwMessagesDblClick(Sender: TObject);
    procedure lwMessagesDeletion(Sender: TObject; Item: TListItem);
    procedure lbGroupsDblClick(Sender: TObject);
    procedure mnuDisconnectClick(Sender: TObject);
    procedure mnuPropertiesClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure mnuGetGroupsClick(Sender: TObject);
    procedure mnuGetHeadersClick(Sender: TObject);
    procedure mnuGetBodiesClick(Sender: TObject);
    procedure mnuNewArticleClick(Sender: TObject);
    procedure mnuNewFollowUpClick(Sender: TObject);
    procedure wsNNTPWork(Sender: TComponent; const plWork,
      plWorkSize: Integer);
  private
    { Private declarations }
    FCanContinue: boolean;
    FCurrentGroup: string;

    procedure DisableOnlineActions;
    procedure EnableOnlineActions;
    procedure DisableGroupActions;
    procedure EnableGroupActions;
    procedure DisableMessageActions;
    procedure EnableMessageActions;

    procedure AddMessageItem(const wsMsg: TWinshoeMessage);

    procedure SetServerValues;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

const
  OnlineStatus: array[boolean] of string = ('Offline', 'Online');

  MSG_IMG_BODY = 4;
  MSG_IMG_HEADER = 3;


procedure TfrmMain.mnuGetGroupsClick(Sender: TObject);
begin
  lbGroups.Clear;
  
  FCanContinue:= True;

  wsNNTP.GetNewsgroupList;

  wsNNTP.DoStatus('Finished retrieving groups');
end;

procedure TfrmMain.wsNNTPNewsgroupList(const sNewsgroup: String;
  const lLow, lHigh: Cardinal; const sType: String;
  var CanContinue: Boolean);
begin
  lbGroups.Items.Add(sNewsgroup);
  CanContinue:= FCanContinue;
end;

procedure TfrmMain.AddMessageItem(const wsMsg: TWinshoeMessage);
var
  item: TListItem;
begin
  item:= lwMessages.Items.Add;

  item.SubItems.Add(wsMsg.Subject);
  item.SubItems.Add(wsMsg.From);
  item.SubItems.Add(FormatDateTime('dd.mm.yy hh:mm', wsMsg.Date));
  item.Data:= wsMsg;

  item.ImageIndex:= MSG_IMG_HEADER;
end;

procedure TfrmMain.lwMessagesDblClick(Sender: TObject);
// view article body
var
  item: TListItem;
begin
  // in case we're not supposed to do anything
  if not mnuGroup.Enabled then
    exit; 

  item:= lwMessages.Selected;
  if not Assigned(item) then
    exit;

  // if we just got the header, retrive body
  if item.ImageIndex = MSG_IMG_HEADER then
  begin
    // get body if we need to
    // might fail if message isnt found for some reason
    mnuGetBodies.Click;
  end;

  // display body if we got one (retrival might have
  // failed, and we'll have nothing to show)
  if item.ImageIndex = MSG_IMG_BODY then
  begin
    memoMsg.Clear;
    memoMsg.Lines.AddStrings(TWinshoeMessage(item.data).Text);
  end;
end;

procedure TfrmMain.lwMessagesDeletion(Sender: TObject; Item: TListItem);
begin
  // free the message object we've created
  if Assigned(Item.Data) then
    TWinshoeMessage(Item.Data).Free;
end;

procedure TfrmMain.mnuGetHeadersClick(Sender: TObject);
var
  wsMsg: TWinshoeMessage;
  r: boolean;
begin
  if lbGroups.ItemIndex < 0 then // if no group selected
    exit;

  DisableOnlineActions;
  lwMessages.Items.Clear;

  // select group
  FCurrentGroup:= lbGroups.Items[lbGroups.ItemIndex];
  wsNNTP.SelectGroup(FCurrentGroup);

  // select the first article in the group
  r:= wsNNTP.SelectArticle(wsNNTP.MsgLow);

  wsMsg:= TWinshoeMessage.Create(nil);
  wsMsg.ExtractAttachments:= false;

  while r do
  begin
    wsNNTP.DoStatus('Retrieving header of article no. ' + IntToStr(wsNNTP.MsgNo));
    
    if wsNNTP.GetHeader(wsNNTP.MsgNo, '', wsMsg) then
    begin

      // if we find the article, add it to the list
      // the message object will be associated with the icon
      AddMessageItem(wsMsg);

      // we'll need a new message object
      wsMsg:= TWinshoeMessage.Create(nil);
      wsMsg.ExtractAttachments:= false;
    end;

    // as Rutger Hauer so elegantly put it: NEXT!
    r:= wsNNTP.Next;
  end;

  wsMsg.Free;

  EnableOnlineActions;
end;

procedure TfrmMain.mnuGetBodiesClick(Sender: TObject);
var
  i: integer;
  item: TListItem;
  wsMsg: TWinshoeMessage;
begin
  for i:= 0 to lwMessages.Items.Count-1 do
  begin
    item:= lwMessages.Items[i];
    if item.Selected then
    begin
      wsMsg:= TWinshoeMessage(Item.Data);

      wsNNTP.DoStatus('Retrieved body of article no. ' + IntToStr(wsMsg.MsgNo));

      // the msgID is in the form <id>, but the GetBody expects it to just be the id,
      // so we need to strip it
      if wsNNTP.GetBody(0, Copy(wsMsg.MsgID, 2, length(wsMsg.MsgID)-2), wsMsg) then
        // show that we successfully got the body
        item.ImageIndex:= MSG_IMG_BODY;
        
    end;
  end;
end;

procedure TfrmMain.mnuNewArticleClick(Sender: TObject);
begin
  with frmArticle do
  begin
    // setup the message object
    wsMessage.Clear;
    editNewsgroups.Text:= FCurrentGroup;
  end;

  if frmArticle.ShowModal = 1 then
  begin
 // DisableOnlineActions;
    wsNNTP.Send(frmArticle.wsMessage);
    EnableOnlineActions;
  end;
end;

procedure TfrmMain.mnuNewFollowUpClick(Sender: TObject);
  procedure IndentMessage(wsNew, wsOriginal: TWinshoeMessage; indent: string);
  var
    i: integer;
  begin
    if wsOriginal.Text.Text = '' then
      exit;

    wsNew.Text.Add(wsOriginal.From + ' wrote:');
    for i:= 0 to wsOriginal.Text.Count-1 do
      wsNew.Text.Add(indent + wsOriginal.Text.Strings[i]);
  end;

var
  item: TListItem;
  wsOriginalMsg: TWinshoeMessage;
begin
  item:= lwMessages.Selected;
  if not Assigned (item) then
    exit;

  wsOriginalMsg:= TWinshoeMessage(item.data);

  with frmArticle do
  begin
    // setup the message object
    wsMessage.Clear;
    editNewsgroups.Text:= FCurrentGroup;

    // since this is a follow-up we must build the reference field
    // and subject line
    if wsOriginalMsg.References = '' then
    begin
      // we're replying to a original post here, so we must create
      // the reference field by inserting the msgID of the original
      wsMessage.References:= wsOriginalMsg.MsgID;
      editSubject.Text:= 'RE: ' + wsOriginalMsg.Subject;

      IndentMessage(wsMessage, wsOriginalMsg, '> ');
    end
    else
    begin
      // this is a follow-up to a follow-up, add the msgID to the end
      // of the chain, also assume there's a re: there
      wsMessage.References:= wsOriginalMsg.References + ' ' + wsOriginalMsg.MsgID;
      editSubject.Text:= wsOriginalMsg.Subject;

      IndentMessage(wsMessage, wsOriginalMsg, '>');
    end;

    // so we can see the previous post
    memoArticle.Lines:= wsMessage.Text;
  end;

  if frmArticle.ShowModal = 1 then
  begin
    DisableOnlineActions;

    wsNNTP.Send(frmArticle.wsMessage);

    EnableOnlineActions;
  end;
end;

procedure TfrmMain.mnuConnectClick(Sender: TObject);
begin
  try
    SetServerValues;

    wsNNTP.Connect;

    mnuConnect.Enabled:= False;
    mnuDisconnect.Enabled:= True;

    mnuGetGroups.Click;

    EnableGroupActions;
  finally
  end;
end;

procedure TfrmMain.mnuDisconnectClick(Sender: TObject);
begin
  try
    wsNNTP.Disconnect;

    mnuConnect.Enabled:= True;
    mnuDisconnect.Enabled:= False;
    DisableOnlineActions;
  finally
    // connect might not have successfull, so show currect status
  end;
end;

procedure TfrmMain.mnuPropertiesClick(Sender: TObject);
begin
  frmProperties.ShowModal;
end;

procedure TfrmMain.mnuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.SetServerValues;
begin
  with frmProperties do
  begin
    wsNNTP.Host:= Server;
    wsNNTP.Port:= Port;
    wsNNTP.UserID:= UserName;
    wsNNTP.Password:= Password;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  DisableOnlineActions;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if wsNNTP.Connected then
    wsNNTP.Disconnect;

  CanClose:= not wsNNTP.Connected;
end;

procedure TfrmMain.lbGroupsDblClick(Sender: TObject);
begin
  mnuGetHeaders.Click;
end;

procedure TfrmMain.DisableGroupActions;
begin
  mnuGroup.Enabled:= false;
end;

procedure TfrmMain.EnableGroupActions;
begin
  mnuGroup.Enabled:= true;
end;

procedure TfrmMain.DisableMessageActions;
begin
  mnuMessage.Enabled:= false;
end;

procedure TfrmMain.EnableMessageActions;
begin
  mnuMessage.Enabled:= true;
end;

procedure TfrmMain.DisableOnlineActions;
begin
  // make sure user is unable to issue other commands
  DisableGroupActions;
  DisableMessageActions;
end;

procedure TfrmMain.EnableOnlineActions;
begin
  EnableGroupActions;
  EnableMessageActions;
end;

procedure TfrmMain.wsNNTPWork(Sender: TComponent; const plWork,
  plWorkSize: Integer);
begin
  // so that the client doesnt lock up when we retrive data
  Application.ProcessMessages;
end;

procedure TfrmMain.wsNNTPStatus(Sender: TComponent; const sOut: String);
begin
  sbNews.Panels[0].Text:= sOut;
  sbNews.Panels[1].Text:= OnlineStatus[wsNNTP.Connected];
  Application.ProcessMessages;
end;

end.
