unit ipwatchwinshoe;

////////////////////////////////////////////////////////////////////////////////
// *************************************************************
// Simple component determines Online status,
// returns current IP address, and keeps history on IP's issued.
// *************************************************************
// ..
// Author: Dave Nosker
//         AfterWave Technologies
//         (allbyte@jetlink.net)
// ..
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Misc)
//
// 5.20.99 First Version
////////////////////////////////////////////////////////////////////////////////

interface

uses
  Windows, Classes, Forms, extctrls;

const IP_WATCH_HIST_MAX = 25;
      IP_WATCH_HIST_FILENAME = 'iphist.dat';

type
  TWinshoeIPWatch = class(TComponent)
  private
    PathToHistFile : string;
    FTimer: TTimer;
    LocalIPHuntBusy: Boolean;
    FOnlineCount: Integer;
    FEnabled: boolean;
    FWatchInterval: cardinal;
    FIsOnline: boolean;
    FCurrentIP: string;
    FPreviousIP: string;
    FIPHistoryList: TStringList;
    FOnStatusChanged: TNotifyEvent;
    procedure CheckStatus(Sender: TObject);
    procedure SetEnabled(Value: Boolean);
    procedure SetWatchInterval(Value: Cardinal);
    procedure AddToIPHistoryList(Value: string);
    procedure SetBoolStub(Value: Boolean);
    procedure SetStringStub(Value: String);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function LocalIP: string;
    procedure LoadHistory;
    procedure SaveHistory;
    property IPHistoryList: TStringList read FIPHistoryList stored False;
  published
    property Enabled: Boolean read FEnabled write SetEnabled;
    property WatchInterval: Cardinal read FWatchInterval write SetWatchInterval;
    property IsOnline: Boolean read FIsOnline write SetBoolStub stored False;
    property CurrentIP: String read FCurrentIP write SetStringStub stored False;
    property PreviousIP: String read FPreviousIP write SetStringStub stored False;
    property OnStatusChanged: TNotifyEvent read FOnStatusChanged write FOnStatusChanged;
  end;


procedure Register;

implementation

uses
  WinsockIntf,
  SysUtils;

procedure Register;
begin
  RegisterComponents( 'Winshoes Misc' , [TWinshoeIPWatch]);
end;

constructor TWinshoeIPWatch.Create(AOwner: TComponent);
begin
  PathToHistFile := ExtractFilePath(Application.ExeName) + IP_WATCH_HIST_FILENAME;
  FIPHistoryList := TStringList.Create;
  FisOnline := False;
  FOnlineCount := 0;
  FWatchInterval := 1000;
  FEnabled := True;
  FPreviousIP := '';
  LocalIPHuntBusy:=False;

  inherited Create(AOwner);
  LoadHistory;

  FTimer := TTimer.Create(Self);
  FTimer.Enabled := False;
  FTimer.Interval := FWatchInterval;
  FTimer.OnTimer := CheckStatus;
  FTimer.Enabled := FEnabled;
end;

destructor TWinshoeIPWatch.Destroy;
begin
  // If we are still online then save the currentIP as a history item...
  if FIsOnline then AddToIPHistoryList(FCurrentIP);

  FEnabled := False;
  SaveHistory;
  FIPHistoryList.Free;
  FTimer.Free;
  inherited;
end;

function TWinshoeIPWatch.LocalIP: String;
type
  TaPInAddr = Array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  HostEnt: PHostEnt;
  padrptr: PaPInAddr;
  Buffer: Array[0..63] of char;
  I: Integer;
begin
  Result := '';
  I := 0;
  LocalIpHuntBusy := True;
  try
    WinsockInterface.GetHostName(Buffer, SizeOf(Buffer));
    HostEnt := WinsockInterface.GetHostByName(buffer);
    if HostEnt = nil then
      Exit;

    padrptr := PaPInAddr(HostEnt^.h_addr_list);
    while padrptr^[I] <> nil do
    begin
      Result := WinsockInterface.inet_ntoa(padrptr^[I]^);
      Inc(I);
    end;
  finally
    LocalIpHuntBusy := False;
  end;
end;

procedure TWinshoeIPWatch.CheckStatus(Sender: TObject);
var
  WasOnline: Boolean;
  OldIP: String;
begin
  try
    if LocalIpHuntBusy then Exit;
    WasOnline := FIsOnline;
    OldIP := FCurrentIP;
    FCurrentIP := LocalIP;
    FIsOnline := (FCurrentIP <> '127.0.0.1') and (FCurrentIP <> '');

    if (WasOnline) and (not FIsOnline) then
    begin
      if ((OldIP <> '127.0.0.1') and (OldIP <> '')) then
        FPreviousIP := OldIP;
      AddToIPHistoryList(FPreviousIP);
    end;

    if (not WasOnline) and (FIsOnline) then
    begin
      if FOnlineCount = 0 then FOnlineCount := 1;
      if FOnlineCount = 1 then
        if FPreviousIP = FCurrentIP then
        begin
          // Del last history item...
          if FIPHistoryList.Count > 0 then
            FIPHistoryList.Delete(FIPHistoryList.Count-1);
          // Change the Previous IP# to the remaining last item on the list
          // OR to blank if none on list.
          if FIPHistoryList.Count > 0 then
            FPreviousIP :=  FIPHistoryList[FIPHistoryList.Count-1]
          else FPreviousIP := '';
        end;
      FOnlineCount := 2;
    end;

    if (WasOnline and not FIsOnline)or(not WasOnline and FIsOnline) then
      if not (csDesigning in ComponentState) and Assigned(FOnStatusChanged) then
        FOnStatusChanged(Self);
  except
  end;
end;

procedure TWinshoeIPWatch.SetEnabled(Value: Boolean);
begin
  if Value = FEnabled then Exit;
  FEnabled := Value;
  FTimer.enabled := Value;
end;

procedure TWinshoeIPWatch.SetWatchInterval(Value: Cardinal);
begin
  if Value <> FWatchInterval then
    FTimer.Interval := Value;
end;

procedure TWinshoeIPWatch.AddToIPHistoryList(Value: string);
begin
  if ((Value = '') or (Value = '127.0.0.1')) then Exit;

  // Make sure the last entry does not allready contain the new one...
  if FIPHistoryList.Count > 0 then
    if FIPHistoryList[FIPHistoryList.Count-1] = Value then Exit;

  FIPHistoryList.Add(Value);
  if FIPHistoryList.Count > IP_WATCH_HIST_MAX then // delete the oldest...
    FIPHistoryList.Delete(0);
end;

procedure TWinshoeIPWatch.LoadHistory;
begin
  if (csDesigning in ComponentState) then Exit;
  FIPHistoryList.Clear;
  if FileExists(PathToHistFile) then
  begin
    FIPHistoryList.LoadFromFile(PathToHistFile);
    if FIPHistoryList.Count > 0 then
    FPreviousIP := FIPHistoryList[FIPHistoryList.Count-1];
  end;
end;

procedure TWinshoeIPWatch.SaveHistory;
begin
  if not (csDesigning in ComponentState) then
    FIPHistoryList.SaveToFile(PathToHistFile);
end;

procedure TWinshoeIPWatch.SetBoolStub(Value: Boolean);
begin
  //
end;

procedure TWinshoeIPWatch.SetStringStub(Value: String);
begin
  //
end;

end.
