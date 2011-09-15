unit SubscriptionsForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ComCtrls, StdCtrls, ExtCtrls, FolderList, SubUtils, CommCtrl;

type
  TformSubscriptions = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    butnOk: TButton;
    butnCancel: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label1: TLabel;
    Panel1: TPanel;
    lstvAccounts: TListView;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Panel4: TPanel;
    butnSubscribe: TButton;
    butnUnsubscribe: TButton;
    butnResetList: TButton;
    Panel5: TPanel;
    Bevel6: TBevel;
    editSearch: TEdit;
    pctlMain: TPageControl;
    tshtAll: TTabSheet;
    tshtSub: TTabSheet;
    Panel6: TPanel;
    Label2: TLabel;
    Panel7: TPanel;
    ilstAll: TImageList;
    ilstAccounts: TImageList;
    timrSearch: TTimer;
    cboxSearchDescriptions: TCheckBox;
    procedure DetermineProtection(Sender: TObject);
    procedure butnSubscribeClick(Sender: TObject);
    procedure butnUnsubscribeClick(Sender: TObject);
    procedure butnResetListClick(Sender: TObject);
    procedure butnOkClick(Sender: TObject);
    procedure lstvAccountsDeletion(Sender: TObject; Item: TListItem);
    procedure lstvAccountsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure timrSearchTimer(Sender: TObject);
    procedure editSearchChange(Sender: TObject);
    procedure cboxSearchDescriptionsClick(Sender: TObject);
  private
    FHostItem: TListItem;
  protected
    function ActiveListView : TListView;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  MainForm, ListingForm, Datamodule, DbTables, DemoUtils;

{$R *.DFM}

constructor TformSubscriptions.Create(AOwner: TComponent);
var
  Node: TTreeNode;
  Item: TListItem;
begin
  inherited Create(AOwner);
  Node := formMain.lstvFolders.Items.GetFirstNode.GetFirstChild;
  while Assigned(Node) do begin
    Item := lstvAccounts.Items.Add;
    Item.Caption := Node.Text;
    Item.ImageIndex := 0;
    Item.Data := TSubscriptionData.Create(Panel6, Panel7, ilstAll);
    TSubscriptionData(Item.Data).HostData := Node.Data;

    if Item.Caption = formMain.lstvFolders.Selected.Text then
      FHostItem := Item;

    Node := Node.GetNextChild(Node);
  end;

  lstvAccounts.OnChange := lstvAccountsChange;
end;

function TformSubscriptions.ActiveListView : TListView;
begin
  if pctlMain.ActivePage = tshtAll then
    Result := TSubscriptionData(lstvAccounts.Selected.Data).ViewAll
  else
    Result := TSubscriptionData(lstvAccounts.Selected.Data).ViewSub;
end;

procedure TformSubscriptions.DetermineProtection(Sender: TObject);
var
  SubData: TSubscriptionData;
  IndexAll, IndexSub: Integer;
begin
  if Assigned(lstvAccounts.Selected) then
    SubData := TSubscriptionData(lstvAccounts.Selected.Data)
  else
    SubData := nil;

  if Assigned(SubData) then begin
    IndexAll := SubData.ViewAll.GetNextItem(-1, LVNI_ALL or LVNI_SELECTED);
    IndexSub := SubData.ViewSub.GetNextItem(-1, LVNI_ALL or LVNI_SELECTED);
  end else begin
    IndexAll := -1;
    IndexSub := -1;
  end;

  {-The protection of sub/unsub buttons needs to be extended}
  butnResetList.Enabled := Assigned(SubData) and (pctlMain.ActivePage = tshtAll);
  butnSubscribe.Enabled := butnResetList.Enabled and (IndexAll <> -1);
  if pctlMain.ActivePage = tshtAll then
    butnUnsubscribe.Enabled := butnSubscribe.Enabled
  else if pctlMain.ActivePage = tshtSub then
    butnUnsubscribe.Enabled := Assigned(SubData) and (IndexSub <> -1);
end;

procedure TformSubscriptions.butnSubscribeClick(Sender: TObject);
var
  Index: Integer;
  SubData: TSubscriptionData;
  NewsRec: PNewsRec;
begin
  SubData := TSubscriptionData(lstvAccounts.Selected.Data);
  SubData.Modified := True;
  SubData.BeginUpdate;
  try
    Index := SubData.ViewAll.GetNextItem(-1, LVNI_ALL or LVNI_SELECTED);
    while Index <> -1 do begin
      NewsRec := SubData.GetAllNewsRec(Index);
      NewsRec^.Subscribed := True;
      NewsRec^.Modified := True;
      Index := SubData.ViewAll.GetNextItem(Index, LVNI_ALL or LVNI_SELECTED);
    end;
  finally
    SubData.RefreshSubList;
    SubData.EndUpdate;
  end;

  DetermineProtection(Sender);
end;

procedure TformSubscriptions.butnUnsubscribeClick(Sender: TObject);
var
  Index: Integer;
  SubData: TSubscriptionData;
  NewsRec: PNewsRec;
begin
  SubData := TSubscriptionData(lstvAccounts.Selected.Data);
  SubData.Modified := True;
  SubData.BeginUpdate;
  try
    if pctlMain.ActivePage = tshtSub then begin
      Index := SubData.ViewSub.GetNextItem(-1, LVNI_ALL or LVNI_SELECTED);
      while Index <> -1 do begin
        NewsRec := SubData.GetSubNewsRec(Index);
        NewsRec^.Subscribed := False;
        NewsRec^.Modified := True;
        Index := SubData.ViewSub.GetNextItem(Index, LVNI_ALL or LVNI_SELECTED);
      end;
    end else begin
      Index := SubData.ViewAll.GetNextItem(-1, LVNI_ALL or LVNI_SELECTED);
      while Index <> -1 do begin
        NewsRec := SubData.GetAllNewsRec(Index);
        NewsRec^.Subscribed := False;
        NewsRec^.Modified := True;
        Index := SubData.ViewAll.GetNextItem(Index, LVNI_ALL or LVNI_SELECTED);
      end;
    end;
  finally
    SubData.EndUpdate;
    SubData.RefreshSubList;
  end;

  DetermineProtection(Sender);
end;

procedure TformSubscriptions.butnResetListClick(Sender: TObject);
var
  SubData: TSubscriptionData;
begin
  SubData := TSubscriptionData(lstvAccounts.Selected.Data);
  SubData.BeginUpdate;
  try
    with TformListing.Create(Self) do begin
      try
        HostData := SubData.HostData;
        Show;
        SubData.Load;
      finally
        Free;
      end;
    end;
  finally
    SubData.EndUpdate;
    ActiveListView.SetFocus;
  end;

  DetermineProtection(Sender);
end;

procedure TformSubscriptions.lstvAccountsDeletion(Sender: TObject; Item: TListItem);
begin
  if Assigned(Item.Data) then
    TObject(Item.Data).Free;
end;

procedure TformSubscriptions.lstvAccountsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
var
  SubData: TSubscriptionData;
  X: Integer;
begin
  if Visible and Assigned(Item) and Item.Selected and (Change = ctState) then begin
     SubData := TSubscriptionData(Item.Data);
     SubData.ViewAll.Visible := True;
     SubData.ViewSub.Visible := True;

     for X := 0 to Pred(lstvAccounts.Items.Count) do begin
       if lstvAccounts.Items[X].Data <> SubData then begin
         TSubscriptionData(lstvAccounts.Items[X].Data).ViewAll.Visible := False;
         TSubscriptionData(lstvAccounts.Items[X].Data).ViewSub.Visible := False;
       end;
     end;

     if not SubData.Loaded then begin
       ActiveListView.Refresh;
       SubData.Load;
     end;
  end;
end;

procedure TformSubscriptions.butnOkClick(Sender: TObject);
var
  AcctItem: TListItem;
  SubData: TSubscriptionData;
begin
  AcctItem := lstvAccounts.GetNextItem(nil, sdAll, [isNone]);
  while Assigned(AcctItem) do begin
    SubData := TSubscriptionData(AcctItem.Data);
    if SubData.Modified then begin
      SubData.Save;
      SubData.HostData.Modified := True;
    end;

    AcctItem := lstvAccounts.GetNextItem(AcctItem, sdAll, [isNone]);
  end;
end;

procedure TformSubscriptions.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Item: TListItem;
begin
  if ModalResult = mrCancel then begin
    Item := lstvAccounts.GetNextItem(nil, sdAll, [isNone]);
    while Assigned(Item) do begin
      if TSubscriptionData(lstvAccounts.Selected.Data).Modified then begin
        CanClose := MessageDlg('Changes have been made, do you wish to abandon them?',
          mtWarning, [mbYes, mbNo], 0) = mrYes;
        Exit;
      end;

      Item := lstvAccounts.GetNextItem(Item, sdAll, [isNone]);
    end;
  end;
end;

procedure TformSubscriptions.FormShow(Sender: TObject);
begin
  DetermineProtection(Sender);
  Refresh;
  lstvAccounts.Selected := FHostItem;
  lstvAccounts.ItemFocused := FHostItem;

  if Assigned(lstvAccounts.Selected) then begin
    if ActiveListView.Items.Count = 0 then begin
      if MessageDlg('Would you like to download the list of available newsgroups?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        butnResetListClick(Sender);
    end;
  end;
end;

procedure TformSubscriptions.timrSearchTimer(Sender: TObject);
var
  SubData: TSubscriptionData;
begin
  SubData := TSubscriptionData(lstvAccounts.Selected.Data);
  SubData.Filter := editSearch.Text;
  timrSearch.Enabled := False;
  ActiveListView.SetFocus;
end;

procedure TformSubscriptions.editSearchChange(Sender: TObject);
begin
  timrSearch.Enabled := False; {-Resets the timer}
  timrSearch.Enabled := True;
end;

procedure TformSubscriptions.cboxSearchDescriptionsClick(Sender: TObject);
var
  SubData: TSubscriptionData;
begin
  SubData := TSubscriptionData(lstvAccounts.Selected.Data);
  SubData.SearchDesc := cboxSearchDescriptions.Checked;
end;

end.
