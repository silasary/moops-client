unit SubUtils;

interface

uses
  Classes, Controls, ComCtrls, VirtListView, FolderList;

type
  PNewsRec = ^TNewsRec;
  TNewsRec = packed record
    NewsgroupID: Integer;
    NewsgroupName: string[200];
    NewsgroupDesc: string[150];
    Subscribed: Boolean;
    Modified: Boolean;
  end;

  TNewsList = class(TObject)
  private
    FStream: TMemoryStream;
    FCount: Integer;
  protected
    function GetItem(Index: Integer) : PNewsRec;
  public
    constructor Create(Records: Integer);
    destructor Destroy; override;
    property Items[Index: Integer]: PNewsRec read GetItem; default;
    property Count: Integer read FCount;
  end;

  TSubscriptionData = class(TObject)
  private
    FViewAll: TvsListView;
    FViewSub: TvsListView;
    FNews: TNewsList;
    FListAll: TList;
    FListSub: TList;
    FFilteredAll: TList;
    FFilteredSub: TList;
    FFilterAll: string;
    FFilterSub: string;
    FFilter: string;
    FFiltered: Boolean;
    FSearchDesc: Boolean;
    FLoaded: Boolean;
    FHostData: THostData;
    FModified: Boolean;
    procedure SetFilter(Value: string);
    procedure SetSearchDesc(Value: Boolean);
    procedure GetItemInfo(Sender: TObject; Item, SubItem: Integer;
     Mask: TLVODMaskItems; var Image, Param: Integer; var State: Cardinal; var Text: string);
  protected
    function CreateListView(Parent: TWinControl; ImageList: TImageList) : TvsListView;
    procedure BuildFiltered(Source, Dest: TList; ListView: TvsListView);
    procedure Refresh;
  public
    constructor Create(ParentAll, ParentSub: TWinControl; ImageList: TImageList);
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Load;
    procedure Save;
    procedure SortList(Mode: string);
    function GetAllNewsRec(Index: Integer) : PNewsRec;
    function GetSubNewsRec(Index: Integer) : PNewsRec;
    procedure RefreshSubList;
    property ViewAll: TvsListView read FViewAll write FViewAll;
    property ViewSub: TvsListView read FViewSub write FViewSub;
    property Filter: string read FFilter write SetFilter;
    property SearchDesc: Boolean read FSearchDesc write SetSearchDesc;
    property Loaded: Boolean read FLoaded;
    property HostData: THostData read FHostData write FHostData;
    property Modified: Boolean read FModified write FModified;
  end;

implementation

uses
  Datamodule, DbTables, Forms, SysUtils;

function NewsRecCompare(Item1, Item2: Pointer): Integer;
begin
  Result := CompareStr(PNewsRec(Item1)^.NewsgroupName, PNewsRec(Item2)^.NewsgroupName);
end;

{=================================================================}

constructor TNewsList.Create(Records: Integer);
begin
  inherited Create;
  FStream := TMemoryStream.Create;
  FCount := Records;
  FStream.SetSize(FCount * SizeOf(TNewsRec));
  FillChar(FStream.Memory^, FStream.Size, #0);
end;

destructor TNewsList.Destroy;
begin
  FStream.Free;
  inherited Destroy;
end;

function TNewsList.GetItem(Index: Integer) : PNewsRec;
begin
  Result := PNewsRec(LongInt(FStream.Memory) + Index * SizeOf(TNewsRec));
end;

{=================================================================}

constructor TSubscriptionData.Create(ParentAll, ParentSub: TWinControl; ImageList: TImageList);
begin
  inherited Create;
  FViewAll := CreateListView(ParentAll, ImageList);
  FViewSub := CreateListView(ParentSub, ImageList);
  FListAll := TList.Create;
  FListSub := TList.Create;
  FFilteredAll := TList.Create;
  FFilteredSub := TList.Create;
end;

destructor TSubscriptionData.Destroy;
begin
  FFilteredSub.Free;
  FFilteredAll.Free;
  FListSub.Free;
  FListAll.Free;
  FNews.Free;
  FViewSub.Free;
  FViewAll.Free;
  inherited Destroy;
end;

procedure TSubscriptionData.SetFilter(Value: string);
begin
  if FFilter <> Value then begin
    FFilter := Value;
    FFiltered := FFilter <> '';
    if not FFiltered then begin
      FFilterAll := '';
      FFilterSub := '';
    end;
    Refresh;
  end;
end;

procedure TSubscriptionData.SetSearchDesc(Value: Boolean);
begin
  if FSearchDesc <> Value then begin
    FSearchDesc := Value;
    Refresh;
  end;
end;

function TSubscriptionData.CreateListView(Parent: TWinControl; ImageList: TImageList) : TvsListView;
  procedure AddColumn(ColCaption: string; ColWidth: Integer);
  begin
    with Result.Columns.Add do begin
      Caption := ColCaption;
      Width   := ColWidth;
    end;
  end;
begin
  Result := TvsListView.Create(nil);
  Result.Visible := False;
  Result.Parent := Parent;
  Result.Align := alClient;
  Result.ViewStyle := vsReport;
  Result.RowSelect := True;
  Result.MultiSelect := True;
  Result.ColumnClick := False;
  Result.HideSelection := False;
  Result.ReadOnly := True;
  Result.SmallImages := ImageList;
  Result.VirtualMode := True;
  Result.OnODGetItemInfo := GetItemInfo;

  AddColumn('Newsgroup', 250);
  AddColumn('Description', 250);
end;

procedure TSubscriptionData.BeginUpdate;
begin
  FViewAll.Items.BeginUpdate;
  FViewSub.Items.BeginUpdate;
end;

procedure TSubscriptionData.EndUpdate;
begin
  FViewAll.Items.EndUpdate;
  FViewSub.Items.EndUpdate;
end;

procedure TSubscriptionData.SortList(Mode: string);
begin
  if Mode = 'A' then begin
    FListAll.Sort(NewsRecCompare);
  end else if Mode = 'S' then begin
    FListSub.Sort(NewsRecCompare);
  end else begin
    FListAll.Sort(NewsRecCompare);
    FListSub.Sort(NewsRecCompare);
  end;
end;

procedure TSubscriptionData.RefreshSubList;
var
  X: Integer;
begin
  Screen.Cursor := crHourGlass;
  try
    FListSub.Clear;
    for X := 0 to Pred(FListAll.Count) do begin
      if PNewsRec(FListAll[X])^.Subscribed then
        FListSub.Add(FListAll[X]);
    end;

    FViewSub.SetItemCount(FListSub.Count, [lvsicfNoScroll]);
    if FFiltered then
      BuildFiltered(FListSub, FFilteredSub, FViewSub);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TSubscriptionData.BuildFiltered(Source, Dest: TList; ListView: TvsListView);
var
  X: Integer;
begin
  Dest.Clear;
  for X := 0 to Pred(Source.Count) do begin
    if (Pos(FFilter, PNewsRec(Source[X])^.NewsgroupName) > 0) or
       (FSearchDesc and (Pos(FFilter, PNewsRec(Source[X])^.NewsgroupDesc) > 0)) then begin
      Dest.Add(Source[X]);
    end;
  end;

  Dest.Sort(NewsRecCompare);
  ListView.SetItemCount(Dest.Count, [lvsicfNoScroll]);
end;

procedure TSubscriptionData.Refresh;
begin
  Screen.Cursor := crHourGlass;
  BeginUpdate;
  try
    if FFiltered then begin
      if FFilterAll <> FFilter then begin
        FFilterAll := FFilter;
        BuildFiltered(FListAll, FFilteredAll, FViewAll);
      end;

      if FFilterSub <> FFilter then begin
        FFilterSub := FFilter;
        BuildFiltered(FListSub, FFilteredSub, FViewSub);
      end;
    end else begin
      FViewAll.Items.Clear;
      FViewAll.SetItemCount(FListAll.Count, [lvsicfNoScroll]);
      FViewSub.Items.Clear;
      FViewSub.SetItemCount(FListSub.Count, [lvsicfNoScroll]);
    end;
  finally
    EndUpdate;
    FViewAll.SelectFirst;
    FViewSub.SelectFirst;
    Screen.Cursor := crDefault;
  end;
end;

function TSubscriptionData.GetAllNewsRec(Index: Integer) : PNewsRec;
begin
  if FFiltered then
    Result := PNewsRec(FFilteredAll[Index])
  else
    Result := PNewsRec(FListAll[Index]);
end;

function TSubscriptionData.GetSubNewsRec(Index: Integer) : PNewsRec;
begin
  if FFiltered then
    Result := PNewsRec(FFilteredSub[Index])
  else
    Result := PNewsRec(FListSub[Index]);
end;

procedure TSubscriptionData.GetItemInfo(Sender: TObject; Item, SubItem: Integer;
 Mask: TLVODMaskItems; var Image, Param: Integer; var State: Cardinal; var Text: string);
begin
  if lvifImage in Mask then begin
    if Sender = FViewAll then
      Image := Ord(GetAllNewsRec(Item)^.Subscribed)
    else if Sender = FViewSub then
      Image := Ord(GetSubNewsRec(Item)^.Subscribed);
  end;

  if lvifText in Mask then begin
    Text := '';
    if Sender = FViewAll then begin
      case SubItem of
        0: Text := GetAllNewsRec(Item)^.NewsgroupName;
        1: Text := GetAllNewsRec(Item)^.NewsgroupDesc;
      end;
    end else if Sender = FViewSub then begin
      case SubItem of
        0: Text := GetSubNewsRec(Item)^.NewsgroupName;
        1: Text := GetSubNewsRec(Item)^.NewsgroupDesc;
      end;
    end;
  end;
end;

procedure TSubscriptionData.Load;
var
  CountAll, Index: Integer;
begin
  FListAll.Clear;
  FListSub.Clear;
  FNews.Free;
  FNews := nil;
  FLoaded := False;

  Screen.Cursor := crHourGlass;
  try
    with dataMain.SelectQuery('') do begin
      try
        SQL.Text := 'SELECT Count(*) FROM Newsgroups WHERE Host_ID='+IntToStr(HostData.HostID);
        Open;
        CountAll := Fields[0].AsInteger;
        Close;

        Index := -1;
        FNews := TNewsList.Create(CountAll);
        FListAll.Capacity := CountAll;

        SQL.Clear;
        SQL.Add('SELECT Newsgroup_ID, Newsgroup_Name, Subscribed FROM Newsgroups');
        SQL.Add('WHERE Host_ID='+IntToStr(HostData.HostID));
        Open;
        while not EOF do begin
          Inc(Index);
          FNews[Index]^.NewsgroupID   := Fields[0].AsInteger;
          FNews[Index]^.NewsgroupName := Fields[1].AsString;
          FNews[Index]^.Subscribed    := Fields[2].AsBoolean;

          FListAll.Add(FNews[Index]);

          if FNews[Index]^.Subscribed then
            FListSub.Add(FNews[Index]);

          Next;
        end;

        SortList('');

        FLoaded := True;
      finally
        Free;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

  Refresh;
end;

procedure TSubscriptionData.Save;
var
  X: Integer;
begin
  with dataMain, tablNewsgroups do begin
    for X := 0 to Pred(FNews.Count) do begin
      if FNews[X]^.Modified then begin
        if FindKey([FNews[X]^.NewsgroupID]) then begin
          Edit;
          tablNewsgroupsSubscribed.Value := FNews[X]^.Subscribed;
          Post;
        end;
      end;
    end;
  end;
end;

end.
