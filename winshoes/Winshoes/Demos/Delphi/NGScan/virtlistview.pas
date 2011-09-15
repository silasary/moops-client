unit VirtListView;

interface

uses
  Windows, Messages, Classes, Controls, ComCtrls, CommCtrl;

const
  LVN_ODSTATECHANGED = LVN_FIRST-15;

type
  PLVCacheHint = ^TLVCacheHint;
  TLVCacheHint = packed record
    Hdr: TNMHDR;
    iFrom: Integer;
    iTo: Integer;
  end;

  PLVFindItem = ^TLVFindItem;
  TLVFindItem = packed record
    Hdr: TNMHDR;
    iStart: Integer;
    lvif: TLVFindInfo;
  end;

  PLVODStateChange = ^TLVODStateChange;
  TLVODStateChange = packed record
    Hdr: TNMHDR;
    iFrom: Integer;
    iTo: Integer;
    uNewState: UINT;
    uOldState: UINT;
  end;

  TLVItemCountFlag = (lvsicfNoInvalidateAll, lvsicfNoScroll);
  TLVItemCountFlags = set of TLVItemCountFlag;
  TLVODMaskItem = (lvifText, lvifImage, lvifParam, lvifState);
  TLVODMaskItems = set of TLVODMaskItem;

  TLVODGetItemInfoEvent  = procedure(Sender: TObject; Item, SubItem: Integer;
   Mask: TLVODMaskItems; var Image: Integer; var Param: lParam; var State: UINT;
   var Text: string) of object;
  TLVODCacheHintEvent    = procedure(Sender: TObject; var HintInfo: TLVCacheHint) of object;
  TLVODFindItemEvent     = procedure(Sender: TObject; var FindInfo: TLVFindItem; var Found: boolean) of object;
  TLVODStateChangedEvent = procedure(Sender: TObject; var StateInfo: TLVODStateChange) of object;

type
  TvsListView = class(TListView)
  private
    FVirtualMode: Boolean;
    FOnODGetItemInfo: TLVODGetItemInfoEvent;
    FOnODCacheHint: TLVODCacheHintEvent;
    FOnODFindItem: TLVODFindItemEvent;
    FOnODStateChanged: TLVODStateChangedEvent;
    procedure SetVirtualMode(Value: Boolean);
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ODGetDispInfo(var ItemInfo: TLVItem); virtual;
    procedure ODCacheHint(var HintInfo: TLVCacheHint); virtual;
    function ODFindItem(var FindInfo: TLVFindItem): Boolean; virtual;
    procedure ODStateChanged(var StateInfo: TLVODStateChange); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetItemCount(Count: Integer; Flags: TLVItemCountFlags);
    function GetNextItem(Index: Integer; Flags: Integer) : Integer;
    procedure SelectFirst;
  published
    property VirtualMode: Boolean read FVirtualMode write SetVirtualMode default False;
    property OnODGetItemInfo: TLVODGetItemInfoEvent read FOnODGetItemInfo write FOnODGetItemInfo;
    property OnODCacheHint: TLVODCacheHintEvent read FOnODCacheHint write FOnODCacheHint;
    property OnODFindItem: TLVODFindItemEvent read FOnODFindItem write FOnODFindItem;
    property OnODStateChanged: TLVODStateChangedEvent read FOnODStateChanged write FOnODStateChanged;
  end;

procedure Register;

implementation

uses
  SysUtils;

const
  LVSICF_NOINVALIDATEALL  = $00000001;
  LVSICF_NOSCROLL         = $00000002;

procedure ListView_SetItemCountEx(LVWnd: HWnd; Items: Integer; Flags: DWORD);
begin
  SendMessage(LVWnd, LVM_SETITEMCOUNT, Items, Flags);
end;

constructor TvsListView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVirtualMode := False;
end;

procedure TvsListView.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if FVirtualMode then
    Params.Style := Params.Style or LVS_OWNERDATA;
end;

procedure TvsListView.SetVirtualMode(Value: Boolean);
begin
  if Value <> FVirtualMode then begin
    FVirtualMode := Value;
    RecreateWnd;
  end;
end;

procedure TvsListView.SetItemCount(Count: Integer; Flags: TLVItemCountFlags);
var
  APIFlags: DWORD;
begin
  APIFlags := 0;
  if lvsicfNoInvalidateAll in Flags then
    APIFlags := LVSICF_NOINVALIDATEALL;
  if lvsicfNoScroll in Flags then
    APIFlags := APIFlags or LVSICF_NOSCROLL;
  ListView_SetItemCountEx(Handle, Count, APIFlags);
end;

function TvsListView.GetNextItem(Index: Integer; Flags: Integer) : Integer;
begin
  Result := ListView_GetNextItem(Handle, Index, Flags);
end;

procedure TvsListView.SelectFirst;
var
  Index: Integer;
  Flags: Integer;
begin
  Flags := LVNI_ALL or LVNI_SELECTED;
  Index := GetNextItem(-1, Flags);
  while Index <> -1 do begin
    ListView_SetItemState(Handle, Index, 0, 0);
    Index := GetNextItem(Index, Flags);
  end;

  Flags := LVIS_SELECTED or LVIS_FOCUSED;
  Index := GetNextItem(-1, LVNI_ALL);
  if Index <> -1 then
    ListView_SetItemState(Handle, Index, Flags, Flags);
end;

procedure TvsListView.CNNotify(var Message: TWMNotify);
begin
  Message.Result := 0;
  if not FVirtualMode then
    inherited
  else begin
    case Message.NMHdr^.Code of
      LVN_GETDISPINFO:
        ODGetDispInfo(PLVDispInfo(Message.NMHdr)^.Item);
      LVN_ODCACHEHINT:
        ODCacheHint(PLVCacheHint(Message.NMHdr)^);
      LVN_ODSTATECHANGED:
        ODStateChanged(PLVODStateChange(Message.NMHdr)^);
      LVN_ODFINDITEM:
        if not ODFindItem(PLVFindItem(Message.NMHdr)^) then
          Message.Result := -1;
    else
      inherited;
    end;
  end;
end;

procedure TvsListView.ODGetDispInfo(var ItemInfo: TLVItem);
var
  Text: string;
  GetMask: TLVODMaskItems;
  function BuildMaskSet(Mask: UINT): TLVODMaskItems;
  begin
    Result := [];
    if (Mask and LVIF_TEXT)  = LVIF_TEXT  then Include(Result, lvifText);
    if (Mask and LVIF_IMAGE) = LVIF_IMAGE then Include(Result, lvifImage);
    if (Mask and LVIF_PARAM) = LVIF_PARAM then Include(Result, lvifParam);
    if (Mask and LVIF_STATE) = LVIF_STATE then Include(Result, lvifState);
  end;
begin
  if Assigned(FOnODGetItemInfo) and (ItemInfo.iItem <> -1) then begin
    Text := '';
    GetMask := BuildMaskSet(ItemInfo.Mask);

    with ItemInfo do begin
      FOnODGetItemInfo(Self, iItem, iSubItem, GetMask, iImage, lParam, State, Text);
      if (Mask and LVIF_TEXT) = LVIF_TEXT then
        StrLCopy(pszText, PChar(Text), cchTextMax);
    end;
  end;
end;

procedure TvsListView.ODCacheHint(var HintInfo: TLVCacheHint);
begin
  if Assigned(FOnODCacheHint) then FOnODCacheHint(Self, HintInfo);
end;

function TvsListView.ODFindItem(var FindInfo: TLVFindItem): boolean;
begin
  Result := False;
  if Assigned(FOnODFindItem) then FOnODFindItem(Self, FindInfo, Result);
end;

procedure TvsListView.ODStateChanged(var StateInfo: TLVODStateChange);
begin
  if Assigned(FOnODStateChanged) then FOnODStateChanged(Self, StateInfo);
end;

procedure Register;
begin
  RegisterComponents('Win32', [TvsListView]);
end;

end.
