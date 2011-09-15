unit WatcherUnit;

interface

uses
  Windows, Forms, Controls, Classes, IniFiles, SysUtils,
  BeChatView, Common, Menus, ExtCtrls;

type
  TWatcher = class(TChatView)
  private
    fPopupMenu: TPopupMenu;
    StayTopTimer: TTimer;
    fMonitor: Integer;

    function GetLastWorld: string;
    procedure StayTopTimerTimer(Sender: TObject);
    procedure SetOnTop;
  public
    procedure LoadTheme;

    procedure Activate;
    procedure CreateParams(var Params: TCreateParams); override;
    constructor Create(AOwner: TComponent); override;
    procedure ChatViewClick(Sender: TObject);

    procedure AddWatch(const World, Line: string);
    function WorldIsActive: Boolean;
    procedure SwitchToWorld;
    procedure SwitchBack;

    procedure DoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    property PopupMenu: TPopupMenu read fPopupMenu write fPopupMenu;
    property Monitor: Integer read fMonitor write fMonitor;
  end;

var
  Watcher: TWatcher;

procedure TellWatcher(const World, Line: string);

implementation

uses
  MainFrm, ClientPage, UpdateCheck;

var
  LastWorld, LastLine: string;

procedure TellWatcher(const World, Line: string);
begin
  LastWorld:=World;
  LastLine:=Line;
  if Watcher<>nil then Watcher.AddWatch(World,Line);
end;

{ TWatcher }

constructor TWatcher.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  StayTopTimer:=TTimer.Create(Self);
  with StayTopTimer do
  begin
    Interval:=1000;
    OnTimer:=StayTopTimerTimer;
    Enabled:=True;
  end;

  fPopupMenu:=nil;
//  Top:=0; Left:=150; Width:=Screen.DesktopWidth-250;
  Top:=Screen.Monitors[fMonitor].Top; Left:=Screen.Monitors[fMonitor].Left + 150; Width:=Screen.Monitors[fMonitor].Width-350;
  OnClick:=ChatViewClick;
  OnMouseUp:=DoMouseUp;

  LoadTheme;

  if LastWorld<>'' then
    AddWatch(LastWorld,LastLine)
  else
    AddLine('Beryllium Engineering Moops! '+UpdChecker.ThisVersion);
end;

procedure TWatcher.SetOnTop;
begin
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height,
    SWP_SHOWWINDOW or SWP_NOACTIVATE);
end;

procedure TWatcher.Activate;
begin
  SetOnTop;
  Invalidate;
end;

procedure TWatcher.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    if NewStyleControls then ExStyle := WS_EX_TOOLWINDOW;
    AddBiDiModeExStyle(ExStyle);
  end;
end;

procedure TWatcher.AddWatch(const World, Line: string);
begin
  AddLine('['+World+'] '+Line);
end;

procedure TWatcher.LoadTheme;
var
  Ini: TIniFile;
  FileName: string;
begin
  FileName:=AppDir+'Themes\watcher.mth';
  if FileExists(FileName) then
  begin
    Ini:=TIniFile.Create(FileName);
    try
      LoadFromIni(Ini);
    finally
      Ini.Free;
    end;
  end;

  WordWrap:=0;
  HorizScrollBar:=False;
  FollowMode:=cfOn;
  EnableBeep:=False;
  DisableSelect:=True;
  Height:=CharHeight+4;
end;

procedure TWatcher.ChatViewClick(Sender: TObject);
begin
  {if WorldIsActive then
    SwitchBack
  else}
  //  SwitchToWorld;
end;

procedure TWatcher.SwitchBack;
begin
  //Beep;
  SetForegroundWindow(GetWindow(Application.Handle,GW_HWNDNEXT));
end;

function TWatcher.WorldIsActive: Boolean;
begin
  Result:=Application.Active {and MainForm.Active} and (MainForm.CurPage<>nil)
    and (MainForm.CurPage.Caption=GetLastWorld);
end;

procedure TWatcher.SwitchToWorld;
var
  S: string;
  I: Integer;
begin
  Application.BringToFront;
  S:=GetLastWorld;
  if S='' then Exit;
  with MainForm do
  begin
    for I:=0 to ClientPages.Count-1 do
      if TNetClientPage(ClientPages[I]).Caption=S then
      begin
        ActivatePage(ClientPages[I]);
        Exit;
      end;
    Activate;
  end;
end;

procedure TWatcher.DoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button=mbRight) and Assigned(PopupMenu) then
  begin
    StayTopTimer.Interval:=20000; // Otherwise the Watcher will get
    // on top of the menu...
    PopupMenu.Popup(X,Y);
  end
  else if Focused then // Don't leave this window active
    SwitchBack;
end;

function TWatcher.GetLastWorld: string;
begin
  if ActLineCount=0 then begin Result:=''; Exit; end;
  Result:=GetLineText(TopLine);
  Result:=Copy(Result,2,Pos(']',Result)-2);
end;

procedure TWatcher.StayTopTimerTimer(Sender: TObject);
begin
  StayTopTimer.Interval:=1000; // because of popup-menu
  SetOnTop;
end;

end.
