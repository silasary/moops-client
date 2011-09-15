unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ScktComp, ExtCtrls, WinSock, ActnList, Menus, BePlugin,
  BeChatView, IniFiles, Parser, StdPlugins, Common, ClientPage,
  mwCustomEdit, ToolWin, ImgList, Buttons, mwMooSyn, jpeg, SessionOptFrm,
  Placemnt, RXCtrls, ShellApi, AppEvent, ImgManager, BeNetwork, Winshoes,
  UpdateCheck, MoopsDebug, serverwinshoe, LinkParser, MoopsHelp, HintWin,
  WatcherUnit;

var
  DebugMode: Boolean = False;

const
  StatusSpeed = 10;

  WM_INITMOOPS  = WM_USER + 204; // Create pages etc
  WM_INITMOOPS2 = WM_USER + 205; // Check registration, show sessionlist etc
  WM_UPDWINMENU = WM_USER + 210;

  { Indexes in tray }
  iaLog        = 0;
  iaScrollLock = 1;
  iaConnection = 2;
  iaUpload     = 3;
  iaDownload   = 4;

  { Indexes in imagelist }
  imgLogPage   = 58;
  imgNotepad   = 52;

  MoopsArray: array[1..7] of string = (
    'mOops!','moOps!','mooPs!','moopS!','moops?','moops!','Moops!'
  );

    UpdateURL: string = 'http://dl.dropbox.com/u/4187827/Moops/MoopsVersion.txt';
//  UpdateURL: string = 'http://www.beryllium.net/moops/moopsvc.php';

type
  TIconData = record
    ImageIndex: Integer;
    Left: Integer;
  end;

  TEmptyPanel = class(TPanel)
    constructor Create(AOwner: TComponent); override;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
  end;

  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    FileExit: TAction;
    FileMenu: TMenuItem;
    Exit1: TMenuItem;
    OptSelHist: TAction;
    WorldMenu: TMenuItem;
    SelectiveHistory1: TMenuItem;
    N1: TMenuItem;
    FollowOff: TMenuItem;
    FollowOn: TMenuItem;
    FollowAuto: TMenuItem;
    BlinkTimer: TTimer;
    EditorMenu: TMenuItem;
    EditorSave: TAction;
    Save1: TMenuItem;
    Close1: TMenuItem;
    EditorSaveAndClose: TAction;
    EditorClose: TAction;
    SaveandClose1: TMenuItem;
    Pastetext1: TMenuItem;
    WorldPaste: TAction;
    WinNextWorld: TAction;
    WinPrevWorld: TAction;
    ImageList1: TImageList;
    FileSelectSession: TAction;
    Runscript1: TMenuItem;
    WorldPasteAdv: TAction;
    WorldConnect: TAction;
    Options1: TMenuItem;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    MenuToolbar: TToolBar;
    ToolButton8: TToolButton;
    Moops1: TMenuItem;
    WorldMenuButton: TToolButton;
    EditorMenuButton: TToolButton;
    OptionsMenuButton: TToolButton;
    ToolButton12: TToolButton;
    WorldConnectButton: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton4: TToolButton;
    PageCloseButton: TToolButton;
    WorldPasteAdv1: TMenuItem;
    Disconnect1: TMenuItem;
    N2: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    WinNextWorld2: TAction;
    WinPrevWorld2: TAction;
    PopupEdit: TPopupMenu;
    EditCut: TAction;
    EditCopy: TAction;
    EditPaste: TAction;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    TabControl: TTabControl;
    WorldClose: TAction;
    Close2: TMenuItem;
    EditorHilite: TAction;
    N3: TMenuItem;
    Verbhilite1: TMenuItem;
    PopupWorld: TPopupMenu;
    PopupEditor: TPopupMenu;
    Pastetext2: TMenuItem;
    Advancedpastetext1: TMenuItem;
    N4: TMenuItem;
    Disconnect2: TMenuItem;
    Close3: TMenuItem;
    Save2: TMenuItem;
    SaveandClose2: TMenuItem;
    Close4: TMenuItem;
    N5: TMenuItem;
    VerbHighlighter1: TMenuItem;
    EditorSaveAs: TAction;
    SaveAs1: TMenuItem;
    AppEvents: TAppEvents;
    WorldCopy: TAction;
    Copy2: TMenuItem;
    ThCurEdit: TAction;
    SesCurEdit: TAction;
    ThemesMenu: TMenuItem;
    SessionsMenu: TMenuItem;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    Help1: TMenuItem;
    Session2: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Theme2: TMenuItem;
    N8: TMenuItem;
    ThNew: TAction;
    WorldLineLength: TAction;
    UpdateLinelength1: TMenuItem;
    UpdateLinelength2: TMenuItem;
    FileMinimize: TAction;
    MinimizeMoops1: TMenuItem;
    WinNextWindow: TAction;
    WinPrevWindow: TAction;
    WindowMenuButton: TToolButton;
    WinMenu: TMenuItem;
    N9: TMenuItem;
    OptGlobal: TAction;
    GlobalOptions1: TMenuItem;
    Nextwindow1: TMenuItem;
    Previouswindow1: TMenuItem;
    Nextwindow2: TMenuItem;
    Previouswindow2: TMenuItem;
    N10: TMenuItem;
    FormStorage: TFormStorage;
    IdentServer: TWinshoeListener;
    SesNewSession: TAction;
    Newsession1: TMenuItem;
    Toolbars1: TMenuItem;
    ToolBarMenu: TMenuItem;
    ToolBarBar1: TMenuItem;
    ToolBarWorlds: TMenuItem;
    UListImages: TImageList;
    TrayImages: TImageList;
    OptLogging: TAction;
    StartLogging1: TMenuItem;
    ToolbarEditors: TMenuItem;
    StatusBarPanel: TPanel;
    TrayPanel: TPanel;
    TrayBox: TPaintBox;
    StatusBar: TStatusBar;
    IconPanel: TPanel;
    IconBox: TPaintBox;
    BottomBar: TControlBar;
    EditorTabs: TTabControl;
    EditorShowCaptions: TAction;
    Fulleditorcaptions1: TMenuItem;
    WorldShowCaptions: TAction;
    Fullworldcaptions1: TMenuItem;
    WatcherPopup: TPopupMenu;
    WatcherSwitchWorld: TAction;
    Switchtoworld1: TMenuItem;
    WatcherTheme: TAction;
    WatcherEnable: TAction;
    Themesettings1: TMenuItem;
    EnableWatcher1: TMenuItem;
    EnableWatcher2: TMenuItem;
    Themesettings2: TMenuItem;
    Editorbarcaptions1: TMenuItem;
    Worldbarcaptions1: TMenuItem;
    EditorOpenFile: TAction;
    Openfile1: TMenuItem;
    procedure FileExitExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OptSelHistExecute(Sender: TObject);
    procedure FollowClick(Sender: TObject);
    procedure ClientPagesChange(Sender: TObject);
    procedure BlinkTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditorSaveExecute(Sender: TObject);
    procedure EditorSaveAndCloseExecute(Sender: TObject);
    procedure EditorCloseExecute(Sender: TObject);
    procedure WorldPasteExecute(Sender: TObject);
    procedure WndProc(var Message: TMessage); override;
    procedure EditorUpdate(Sender: TObject);
    procedure WinNextWorldExecute(Sender: TObject);
    procedure WinPrevWorldExecute(Sender: TObject);
    procedure WorldUpdate(Sender: TObject);
    procedure FileSelectSessionExecute(Sender: TObject);
    procedure WorldPasteAdvExecute(Sender: TObject);
    procedure WorldConnectExecute(Sender: TObject);
    procedure WorldConnectUpdate(Sender: TObject);
    procedure WorldPasteAdvUpdate(Sender: TObject);
    procedure TabControlGetImageIndex(Sender: TObject; TabIndex: Integer;
      var ImageIndex: Integer);
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure EditCutUpdate(Sender: TObject);
    procedure EditCutExecute(Sender: TObject);
    procedure EditUpdate(Sender: TObject);
    procedure EditCopyExecute(Sender: TObject);
    procedure EditPasteExecute(Sender: TObject);
    procedure TabControlStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure TabControlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure WorldCloseUpdate(Sender: TObject);
    procedure WorldCloseExecute(Sender: TObject);
    procedure EditorHiliteExecute(Sender: TObject);
    procedure EditorHiliteUpdate(Sender: TObject);
    procedure EditorSaveAsExecute(Sender: TObject);
    procedure TabControlResize(Sender: TObject);
    procedure AppEventsHint(Sender: TObject);
    procedure WorldCopyUpdate(Sender: TObject);
    procedure WorldCopyExecute(Sender: TObject);
    procedure SesCurEditExecute(Sender: TObject);
    procedure ThCurEditExecute(Sender: TObject);
    procedure OptSelHistUpdate(Sender: TObject);
    procedure SessionsMenuItemClick(Sender: TObject);
    procedure ThemesMenuItemClick(Sender: TObject);
    procedure ThCurEditUpdate(Sender: TObject);
    procedure ThNewExecute(Sender: TObject);
    procedure WorldLineLengthExecute(Sender: TObject);
    procedure WorldLineLengthUpdate(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure FileMinimizeExecute(Sender: TObject);
    procedure WinNextWindowExecute(Sender: TObject);
    procedure WinPrevWindowExecute(Sender: TObject);
    procedure StatusBarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OptGlobalExecute(Sender: TObject);
    procedure AppEventsException(Sender: TObject; E: Exception);
    procedure IdentServerSessionTimeout(Thread: TWinshoeServerThread;
      var KeepAlive: Boolean);
    procedure IdentServerExecute(Thread: TWinshoeServerThread);
    procedure SesNewSessionExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolBarMenuClick(Sender: TObject);
    procedure ToolBarBar1Click(Sender: TObject);
    procedure ToolBarWorldsClick(Sender: TObject);
    procedure PopupWorldPopup(Sender: TObject);
    procedure IconBoxPaint(Sender: TObject);
    procedure IconBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IconBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TrayBoxPaint(Sender: TObject);
    procedure TrayBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TrayBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BottomBarDockDrop(Sender: TObject; Source: TDragDockObject;
      X, Y: Integer);
    procedure OptLoggingExecute(Sender: TObject);
    procedure OptLoggingUpdate(Sender: TObject);
    procedure EditorTabsChange(Sender: TObject);
    procedure EditorTabsGetImageIndex(Sender: TObject; TabIndex: Integer;
      var ImageIndex: Integer);
    procedure EditorTabsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditorTabsResize(Sender: TObject);
    procedure ToolbarEditorsClick(Sender: TObject);
    procedure EditorTabsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EditorShowCaptionsExecute(Sender: TObject);
    procedure EditorShowCaptionsUpdate(Sender: TObject);
    procedure WorldShowCaptionsExecute(Sender: TObject);
    procedure WorldShowCaptionsUpdate(Sender: TObject);
    procedure TabControlMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure WatcherSwitchWorldExecute(Sender: TObject);
    procedure WatcherEnableExecute(Sender: TObject);
    procedure WatcherEnableUpdate(Sender: TObject);
    procedure WatcherThemeExecute(Sender: TObject);
  private
    { Private declarations }
    TextPanel, TextPanelLeft, TextPanelIco: Integer;
    IconArray: array[0..4] of TIconData;
    TrafficFg, TrafficBg: array[False..True] of Integer;
    fShowEditorCaps, fShowWorldCaps: Boolean;
    procedure LoadDefaultBar;
    procedure UpdCheckerStatus(Sender: TObject; EventType: TucEventType);
    procedure DrawStatusIcon(Position: Integer);
    procedure SetStatusIcon(Position, IconIndex: Integer);
    procedure WinMenuItemClick(Sender: TObject);
    procedure WinMenuSubItemClick(Sender: TObject);
    function  Pos2StatusIcon(X, Y: Integer): Integer;
    procedure SetShowEditorCaps(const Value: Boolean);
    procedure SetShowWorldCaps(const Value: Boolean);
  public
    { Public declarations }
    CaptionBase: string;
    Blink: Boolean;
    BlinkCount: Integer;
    StatusCount: Integer;
    MoopsCount: Integer;
    ClientPages: TList;
    NCPage: TNetClientPage;
    ECPage: TEditClientPage;
    CurPage: TClientPage;
    LastTabCount, LastEditorTabCount: Integer;
    StatusPage: TNetClientPage;
    ThemeMenuList, SessionMenuList, WindowList, PopupWinList: TList;
    MoopsID: string;
    MoopsRegd: Boolean;
    MoopsRegInfo: string;
    ShowStatusHints: Boolean;
    DoVersionCheck: Boolean;
    BetaMode: Boolean;
    DefaultIdent: string;
    MvCaption: Boolean;
    PagesPanel: TEmptyPanel;

    procedure WriteDebug(const Msg: string);
    function  NCPageExists(CP: TClientPage): Boolean;
    function  ECPageExists(CP: TClientPage): Boolean;
    procedure SaveSettings;
    procedure LoadSettings;
    procedure LoadEditorSettings(Ini: TIniFile);
    procedure CreatePage(const PageCaption: string);
    function  GetVersion: string;
    procedure CheckLeds;
    procedure NetworkTraffic(Upload: Boolean; WorldNr: Integer);
    procedure UpdateTabBar;
    procedure UpdateEditorTabs;
    procedure UpdateCaption;
    procedure InitMoops;
    procedure InitMoops2;
    procedure LoadSession(FileName: string);
    procedure CheckRegistration;
    procedure ActivatePage(APage: TClientPage);
    procedure UpdateEditorMenus;
    procedure StatusChanged;
    procedure StatusResized;
    procedure EnableWatcher;
    procedure DisableWatcher;

    property ShowEditorCaps: Boolean read fShowEditorCaps write SetShowEditorCaps;
    property ShowWorldCaps: Boolean read fShowWorldCaps write SetShowWorldCaps;
  end;

var
  MainForm: TMainForm;

implementation

uses
  PasteFrm, SelectSessionFrm, ViewOptFrm, RegisterFrm,
  GlobalOptFrm, SplashFrm;

{$R *.DFM}

procedure TMainForm.StatusResized;
var
  W: Integer;
begin
  IconPanel.Left:=StatusBarPanel.Width-IconPanel.Width;
  if NCPage<>nil then
    W:=NCPage.StatusPlugin.TrayWidth
  else
    W:=0;
  TrayPanel.Left:=IconPanel.Left-W-7;
  TrayPanel.Visible:=W<>0;
  TrayPanel.ClientWidth:=W+4;
  if TrayPanel.Visible then
    Statusbar.Width:=TrayPanel.Left-3
  else
    Statusbar.Width:=IconPanel.Left-3;
  TrayBox.Invalidate;
end;

procedure TMainForm.UpdateTabBar;
var
  I, W: Integer;
begin
  LastTabCount:=TabControl.Tabs.Count;
  W:=0;
  for I:=0 to LastTabCount-1 do
    with TabControl.TabRect(I) do
      Inc(W,Right-Left+10);
  TabControl.Width:=W+1;
end;

procedure TMainForm.UpdateCaption;
var
  S: string;
begin
  S:=CaptionBase;
  if NCPage<>nil then S:=S+' - '+NCPage.Caption;
  if ECPage<>nil then S:=S+' - '+ECPage.Caption;
  if AppTerminating or ((NCPage<>nil) and NCPage.CloseLoop) then S:=S+' (Closing, please wait...)';
  if Caption<>S then Caption:=S;
end;

const
  TrafficIcon: array[False..True,False..True,False..True] of Integer = (
    ((36,37),(38,38)),
    ((33,34),(35,35))
  );

procedure TMainForm.CheckLeds;
var
  I: Integer;
  B: Boolean;
begin
  for I:=1 to ClientPages.Count-1 do
    TNetClientPage(ClientPages[I]).UpdateLed;
  for B:=False to True do
  begin
    Dec(TrafficFg[B]); Dec(TrafficBg[B]);
    if (TrafficFg[B]=0) or (TrafficBg[B]=0) then
      if B then
        SetStatusIcon(iaUpload,TrafficIcon[B,TrafficFg[B]>0,TrafficBg[B]>0])
      else
        SetStatusIcon(iaDownload,TrafficIcon[B,TrafficFg[B]>0,TrafficBg[B]>0]);
    if TrafficFg[B]<0 then TrafficFg[B]:=0;
    if TrafficBg[B]<0 then TrafficBg[B]:=0;
  end;
end;

procedure TMainForm.NetworkTraffic(Upload: Boolean; WorldNr: Integer);
begin
  if TabControl.TabIndex=WorldNr then TrafficFg[Upload]:=5 else TrafficBg[Upload]:=5;
  if Upload then
    SetStatusIcon(iaUpload,TrafficIcon[Upload,TrafficFg[Upload]>0,TrafficBg[Upload]>0])
  else
    SetStatusIcon(iaDownload,TrafficIcon[Upload,TrafficFg[Upload]>0,TrafficBg[Upload]>0]);
end;

function TMainForm.GetVersion: string;
var
  RS: TResourceStream;
  C: Char;
  Handle: THandle;
  P: Integer;
begin
  Result:='';
  Handle:=LoadLibrary(PChar(ParamStr(0)));
  if Handle<>0 then
    try
      RS:=TResourceStream.CreateFromID(Handle,1,RT_VERSION);
      try
        while RS.Position<RS.Size-1 do
        begin
          RS.Read(C,1);
          Result:=Result+C;
          RS.Position:=RS.Position+1;
        end;
        P:=Pos('FileVersion',Result);
        if P>0 then
        begin
          Result:=Copy(Result,P+13,Length(Result));
          P:=Pos(#0,Result);
          if P=0 then P:=Length(Result);
          Result:=Copy(Result,1,P-1);
        end
        else
          Result:='1.2.0.0';
      finally
        RS.Free;
      end;
    finally
      FreeLibrary(Handle);
    end
  else
    Result:='1.2.0.0';
end;

function TMainForm.NCPageExists(CP: TClientPage): Boolean;
var
  I: Integer;
begin
  for I:=ClientPages.Count-1 downto 0 do
    if ClientPages[I]=CP then
      begin Result:=True; Exit; end;
  Result:=False;
end;

function TMainForm.ECPageExists(CP: TClientPage): Boolean;
var
  I, J: Integer;
begin
  for I:=ClientPages.Count-1 downto 0 do
    with TNetClientPage(ClientPages[I]) do
      for J:=OwnedPages.Count-1 downto 0 do
        if OwnedPages[J]=CP then
          begin Result:=True; Exit; end;
  Result:=False;
end;

procedure TMainForm.WndProc(var Message: TMessage);
var
  FileName: string;
  S: string;
begin
  if Message.Msg=WM_NCCLOSEPAGE then
  begin
    Message.Result:=1;
    if NCPageExists(Pointer(Message.WParam)) then
      with TClientPage(Pointer(Message.WParam)) do
      begin
        S:=Caption;
        if CloseLoop then Exit;
        CloseLoop:=True;
        while not CanFree do Application.ProcessMessages;
        if TabIndex=0 then StatusPage:=nil;
        AddToLog('Closed '+S);
        try
          Free;
        except
          ClientPages.Remove(Pointer(Message.WParam));
        end;
        while NCPageExists(Pointer(Message.WParam)) do Application.ProcessMessages;
        Exit;
      end;
    Message.Result:=1;
  end
  else if Message.Msg=WM_ECCLOSEPAGE then
  begin
//    try
    Message.Result:=1;
      if ECPageExists(Pointer(Message.WParam)) then
        with TClientPage(Pointer(Message.WParam)) do
        begin
          S:=Caption;
          SendDebug(0,['(E)'+S+' Try closing']);
          if CloseLoop then Exit;
          SendDebug(0,['(E)'+S+' Closing']);
          CloseLoop:=True;
          while not CanFree do Application.ProcessMessages;
          SendDebug(0,['(E)'+S+' Freeing']);
          try
            Free;
          except
            SendDebug(0,['(E)'+S+' Exception freeing']);
          end;
          SendDebug(0,['(E)'+S+' Freed']);
          while ECPageExists(Pointer(Message.WParam)) do Application.ProcessMessages;
          SendDebug(0,['(E)'+S+' Closed']);
          Exit;
        end;
//    except
//    end;
    Message.Result:=1;
  end
  else if Message.Msg=WM_OPENSESSION then
  begin
    if SelectSessionForm.SelectSession(FileName) then
      LoadSession(FileName);
    Message.Result:=1;
  end
  else if Message.Msg=WM_INITMOOPS then
  begin
    InitMoops;
    Message.Result:=1;
  end
  else if Message.Msg=WM_INITMOOPS2 then
  begin
    InitMoops2;
    Message.Result:=1;
  end
  else if Message.Msg=WM_UPDWINMENU then
  begin
    UpdateEditorMenus;
    Message.Result:=1;
  end
  else inherited WndProc(Message);
end;

procedure TMainForm.CreatePage(const PageCaption: string);
var
  CPage: TNetClientPage;
begin
  CPage:=TNetClientPage.Create(Self,ClientPages,TabControl);
  CPage.Caption:=PageCaption;
  CPage.SheetEnter(Self);
  CPage.ChatView.WordWrap:=0;
  ShowDefaultHelp(CPage);
  CPage.ChatView.DoColor(cvNormal,cvNormal);
  CPage.ChatView.WordWrap:=1;
  CPage.PopupMenu:=PopupWorld;
  CPage.ImageIndex:=imgLogPage;
  TabControl.TabIndex:=0;
  StatusPage:=CPage;
  ActivatePage(CPage);
end;

procedure TMainForm.FileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.OptSelHistExecute(Sender: TObject);
begin
  with TNetClientPage(ClientPages[TabControl.TabIndex]) do
    SelectiveHist:=not SelectiveHist;
end;

procedure TMainForm.SaveSettings;
var
  Ini: TIniFile;
  FileName: string;
begin
  FileName:=ExtractFileDir(ParamStr(0));
  if FileName[Length(FileName)]='\' then
    FileName:=FileName+'Moops.ini'
  else
    FileName:=FileName+'\Moops.ini';
  Ini:=TIniFile.Create(FileName);
  try
    if Ini.SectionExists('Sessions') then
      Ini.EraseSection('Sessions');
    Ini.WriteBool('Startup','ShowSessions',SelectSessionForm.ShowOnStartUpBox.Checked);
    Ini.WriteString('Registration','MoopsID',MoopsID);
    Ini.WriteBool('Registration','Registered',MoopsRegd);
    Ini.WriteString('Registration','RegInfo',MoopsRegInfo);

    Ini.WriteInteger('Storage','TabControl_Top',TabControl.Top);
    Ini.WriteInteger('Storage','TabControl_Left',TabControl.Left);
    Ini.WriteInteger('Storage','EditorTabs_Top',EditorTabs.Top);
    Ini.WriteInteger('Storage','EditorTabs_Left',EditorTabs.Left);
    if TabControl.Parent=ControlBar1 then Ini.WriteInteger('Storage','TabControl_Mode',0)
    else if TabControl.Parent=BottomBar then Ini.WriteInteger('Storage','TabControl_Mode',2)
    else Ini.WriteInteger('Storage','TabControl_Mode',1);
    if EditorTabs.Parent=ControlBar1 then Ini.WriteInteger('Storage','EditorTabs_Mode',0)
    else if EditorTabs.Parent=BottomBar then Ini.WriteInteger('Storage','EditorTabs_Mode',2)
    else Ini.WriteInteger('Storage','EditorTabs_Mode',1);

    Ini.WriteBool('General','ShowEditorCaptions',ShowEditorCaps);
    Ini.WriteBool('General','ShowWorldCaptions',ShowWorldCaps);
    Ini.WriteBool('General','ShowWatcher',Watcher<>nil);
  finally
    Ini.Free;
  end;
end;

procedure TMainForm.LoadSettings;
var
  Ini: TIniFile;
  FileName: string;
  S: TStringList;
  WasActive: Boolean;
  I: Integer;
begin
  FileName:=ExtractFileDir(ParamStr(0));
  if FileName[Length(FileName)]='\' then
    FileName:=FileName+'Moops.ini'
  else
    FileName:=FileName+'\Moops.ini';
  S:=TStringList.Create;
  Ini:=TIniFile.Create(FileName);
  try
    SelectSessionForm.ShowOnStartupBox.Checked:=Ini.ReadBool('Startup','ShowSessions',True);

    DefaultIdent:=Ini.ReadString('General','DefaultIdent','');
    try
      WasActive:=IdentServer.Active;
      IdentServer.Active:=Ini.ReadBool('General','IdentServer',True);
      if (StatusPage<>nil) and (WasActive<>IdentServer.Active) then
        if IdentServer.Active then
          StatusPage.AddToLog('Identd started.')
        else
          StatusPage.AddToLog('Identd stopped.');
    except
      if StatusPage<>nil then
      begin
        if IdentServer.Active=False then
          StatusPage.AddToLog('Identd: An error occured while starting up.')
        else
          StatusPage.AddToLog('Identd: An error occured while shutting down.');
      end;
    end;

    ShowStatusHints:=Ini.ReadBool('General','StatusHints',True);
    MvCaption:=Ini.ReadBool('General','MoovingCaption',True);
    DoVersionCheck:=Ini.ReadBool('General','VersionCheck',True);
    BetaMode:=Ini.ReadBool('General','BetaMode',False);
    NetworkDebug:=Ini.ReadBool('General','NetworkDebug',False);
    ShowEditorCaps:=Ini.ReadBool('General','ShowEditorCaptions',True);
    ShowWorldCaps:=Ini.ReadBool('General','ShowWorldCaptions',True);
    if Ini.ReadBool('General','ShowWatcher',True) then
      EnableWatcher
    else
      DisableWatcher;

    MoopsID:=Ini.ReadString('Registration','MoopsID','');
    MoopsRegd:=Ini.ReadBool('Registration','Registered',False);
    MoopsRegInfo:=Ini.ReadString('Registration','RegInfo','');

    LoadProxySettings(Ini,GlobalProxy);
    if GlobalProxy.Method=cmGlobal then GlobalProxy.Method:=cmDirect;
{    FileName:=Ini.ReadString('Icons','General','');
    if FileName<>'' then
      try
        ImageList1.Clear;
        ImageList1
      except

      end;}
    I:=Ini.ReadInteger('Storage','TabControl_Mode',0);
    if I>2 then I:=0;
    case I of
      0: TabControl.Parent:=ControlBar1;
      1: TabControl.ManualFloat(TabControl.BoundsRect);
      2: TabControl.Parent:=BottomBar;
    end;
    TabControl.Top:=Ini.ReadInteger('Storage','TabControl_Top',TabControl.Top);
    TabControl.Left:=Ini.ReadInteger('Storage','TabControl_Left',TabControl.Left);

    I:=Ini.ReadInteger('Storage','EditorTabs_Mode',2);
    if I>2 then I:=0;
    case I of
      0: EditorTabs.Parent:=ControlBar1;
      1: EditorTabs.ManualFloat(EditorTabs.BoundsRect);
      2: EditorTabs.Parent:=BottomBar;
    end;
    EditorTabs.Top:=Ini.ReadInteger('Storage','EditorTabs_Top',EditorTabs.Top);
    EditorTabs.Left:=Ini.ReadInteger('Storage','EditorTabs_Left',EditorTabs.Left);
    BottomBar.Top:=0;

    LoadEditorSettings(Ini);

    if not MoopsInitialized then
      if Ini.ReadBool('Startup','ShowSplash',True) then
        SplashForm.Visible:=True
      else
      begin
        SplashForm.Visible:=False; SplashForm.Close;
      end;
  finally
    S.Free;
    Ini.Free;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
  SaveSettings;
  AppTerminating:=True;

  DisableWatcher;

  UpdChecker.Terminate;
  //TabControl.OnChange:=nil;
  for I:=ClientPages.Count-1 downto 1 do
    PostMessage(Handle,WM_NCCLOSEPAGE,Integer(ClientPages[I]),0);
  while ClientPages.Count>1 do
    Application.ProcessMessages;
  // Close the Statuspage as the last one
  BlinkTimer.Enabled:=False;
  CurPage:=nil; NCPage:=nil; ECPage:=nil;
  PostMessage(Handle,WM_NCCLOSEPAGE,Integer(ClientPages[0]),0);
  TabControl.OnChange:=nil;
  EditorTabs.OnChange:=nil;
  while ClientPages.Count>0 do
    Application.ProcessMessages;
end;

procedure TMainForm.InitMoops;
begin
  //ShowMonitor;
  Show;

  StatusResized;
  MenuToolBar.AutoSize:=False;
  MenuToolBar.Height:=Toolbar1.Height;
  BottomBar.Top:=StatusBar.Top-1;
  GlobalOptForm.LoadSettings(AppDir+'Moops.ini');
  CreatePage('Status');
  LoadSettings;
  Blink:=False;
  BlinkTimer.Enabled:=True;

  {$IFDEF DEBUG}
  StartDebugger;
  {$ENDIF}
end;

procedure TMainForm.InitMoops2;
var
  FileName: string;
begin
  FileName:=ExtractFileDir(ParamStr(0));
  if FileName[Length(FileName)]='\' then
    FileName:=FileName+'AutoExec'
  else
    FileName:=FileName+'\AutoExec';
  if FileExists(FileName+'.msc') then
    TNetClientPage(ClientPages[0]).ExecuteScript(FileName);

  CheckRegistration;

  if SelectSessionForm.ShowOnStartupBox.Checked then
    PostMessage(MainForm.Handle,WM_OPENSESSION,0,0)
  else
    SelectSessionForm.AutoStart;

  if DoVersionCheck then
    UpdChecker.StartCheck;

end;

procedure TMainForm.CheckRegistration;
begin
//  if not MoopsRegd then
//    if RegisterForm.ShowModal=mrOK then
//    begin
//      MoopsRegInfo:='name='+EncodeURLVar(RegisterForm.NameEdit.Text)+
//        '&email='+EncodeURLVar(RegisterForm.EmailEdit.Text)+
//        '&country='+EncodeURLVar(RegisterForm.CountryEdit.Text)+
//        '&how='+EncodeURLVar(RegisterForm.HowCombo.Text);
//      MoopsRegd:=True;
//    end
//    else
//    begin
//      MoopsRegInfo:='name=&email=&country=&how=';
//      MoopsRegd:=True;
//    end;
//  if MoopsID='' then
//    UpdChecker.ScriptURL:=UpdateURL+'?'+MoopsRegInfo+'&version='+UpdChecker.ThisVersion
//  else
    UpdChecker.ScriptURL:=UpdateURL+'?id='+MoopsID+'&version='+UpdChecker.ThisVersion;
end;

procedure TMainForm.FollowClick(Sender: TObject);
begin
  with TClientPage(ClientPages[TabControl.TabIndex]).ChatView do
    if Sender=FollowOff then FollowMode:=cfOff
    else if Sender=FollowOn then FollowMode:=cfOn
    else if Sender=FollowAuto then FollowMode:=cfAuto;
  TMenuItem(Sender).Checked:=True;
end;

procedure TMainForm.ActivatePage(APage: TClientPage);
var
  I{, J}: Integer;
begin
  if DebugMode then WriteDebug('# ActivatePage 1 ('+IntToStr(Integer(APage))+')');
  PostMessage(WindowHandle,WM_UPDWINMENU,0,0);
  if APage=nil then begin NCPage:=nil; ECPage:=nil; CurPage:=nil; Exit; end;
  if DebugMode then WriteDebug('# ActivatePage 2 ('+APage.Caption+')');
  if TabControl.Tabs.Count<>LastTabCount then UpdateTabBar;
  if DebugMode then WriteDebug('# ActivatePage 3');
  if CurPage<>APage then
  begin
    if CurPage<>nil then CurPage.Visible:=False;
    CurPage:=APage;
    CurPage.Visible:=True;
  end;
  if DebugMode then WriteDebug('# ActivatePage 4');
  if CurPage=nil then begin TabControl.TabIndex:=-1; Exit; end;
  if DebugMode then WriteDebug('# ActivatePage 5');
  CurPage.SheetEnter(nil);
  if DebugMode then WriteDebug('# ActivatePage 6');
  if CurPage is TNetClientPage then
  begin
    PageCloseButton.Action:=WorldClose;
    NCPage:=TNetClientPage(CurPage);
    ECPage:=nil;
    for I:=0 to ClientPages.Count-1 do
      if ClientPages[I]=NCPage then begin TabControl.TabIndex:=I; Break; end;
    EditorTabs.TabIndex:=0;
    if DebugMode then WriteDebug('# ActivatePage 7');
    //EditorMenuButton.Enabled:=False;
    {EditorSave.Enabled:=False;
    EditorClose.Enabled:=False;
    EditorSaveAndClose.Enabled:=False;
    WorldMenuButton.Enabled:=True;
    ThemesMenu.Enabled:=True;
    SessionsMenu.Enabled:=True;
    OptSelHist.Enabled:=True;}
    TabControl.PopupMenu:=PopupWorld;
    EditorTabs.PopupMenu:=PopupWorld;
  end
  else
  begin
    PageCloseButton.Action:=EditorClose;
    ECPage:=TEditClientPage(CurPage);
    NCPage:=ECPage.NCPage;
    for I:=0 to ClientPages.Count-1 do
      if ClientPages[I]=NCPage then begin TabControl.TabIndex:=I; Break; end;

    if NCPage=nil then
      TabControl.TabIndex:=-1
    else
      for I:=0 to NCPage.OwnedPages.Count-1 do
        if NCPage.OwnedPages[I]=ECPage then begin EditorTabs.TabIndex:=I+1; Break; end;

    if DebugMode then WriteDebug('# ActivatePage 8');
    {WorldMenuButton.Enabled:=False;
    OptSelHist.Enabled:=False;
    EditorClose.Enabled:=True;
    EditorSaveAndClose.Enabled:=True;
    EditorSave.Enabled:=True;
    EditorMenuButton.Enabled:=True;
    ThemesMenu.Enabled:=False;
    SessionsMenu.Enabled:=False;}
    TabControl.PopupMenu:=PopupEditor;
    EditorTabs.PopupMenu:=PopupEditor;
  end;
  if DebugMode then WriteDebug('# ActivatePage 9');
  StatusChanged;
  if Assigned(Application.OnHint) then
    Application.OnHint(nil);
  if DebugMode then WriteDebug('# ActivatePage 10');
  UpdateCaption;
  StatusResized;
  if DebugMode then WriteDebug('# ActivatePage 11');
  if EditorTabs.Tabs.Count<>LastEditorTabCount then UpdateEditorTabs;
  //EditorTabs.Invalidate;
end;

procedure TMainForm.ClientPagesChange(Sender: TObject);
begin
  ActivatePage(ClientPages[TabControl.TabIndex]);
end;

procedure TMainForm.BlinkTimerTimer(Sender: TObject);
begin
  CheckLeds;

  if MvCaption then
  begin
    if Odd(MoopsCount) and (MoopsCount shr 1<=High(MoopsArray)) then
    begin
      CaptionBase:=MoopsArray[MoopsCount shr 1];
      UpdateCaption;
      Application.Title:=CaptionBase;
      Inc(MoopsCount);
    end;
    if MoopsCount=1000 then
      MoopsCount:=2
    else
      Inc(MoopsCount);
  end;

  Inc(BlinkCount); if BlinkCount<5 then Exit;
  BlinkCount:=0; Blink:=not Blink;

  //if MonitorForm<>nil then MonitorForm.ChatView.DoBlink(Blink);
  if NCPage<>nil then NCPage.StatusPlugin.BlinkIcons(Blink);

  if (NCPage=nil) or (NCPage<>CurPage) then Exit;
  Inc(StatusCount);
  if StatusCount>StatusSpeed then
  begin
    NCPage.UpdateStatus(True);
    StatusChanged; StatusCount:=0;
  end;
  NCPage.ChatView.DoBlink(Blink);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.ShowMainForm:=False;
  MvCaption:=True;
  BetaMode:=False;
  StatusCount:=StatusSpeed;
  ChDir(ExtractFileDir(ParamStr(0)));
//  FormPlacement.IniFileName:=AppDir+'Moops.ini';
  FormStorage.IniFileName:=AppDir+'Moops.ini';
  LastTabCount:=0; LastEditorTabCount:=0; MoopsCount:=800;
  ClientPages:=TList.Create;
  ThemeMenuList:=TList.Create;
  SessionMenuList:=TList.Create;
  WindowList:=TList.Create;
  PopupWinList:=TList.Create;
  PagesPanel:=TEmptyPanel.Create(Self);
  PagesPanel.Parent:=Self;
  PagesPanel.Align:=alClient;
  BottomBar.Parent:=PagesPanel;
{  Toolbar1.Left:=MenuToolbar.Width;
  //TabControl.Left:=Toolbar1.Width+Toolbar1.Left;
  TabControl.Left:=0;}
  UpdChecker:=TUpdChecker.Create(Self);
  UpdChecker.Referrer:='Beryllium Moops!';
  UpdChecker.ThisVersion:=GetVersion;
  UpdChecker.OnStatus:=UpdCheckerStatus;
  MoopsID:=''; MoopsRegd:=False; MoopsRegInfo:='';
  CaptionBase:='Moops!';
  with IconArray[0] do begin ImageIndex:=42; Left:=1; end;
  with IconArray[1] do begin ImageIndex:=40; Left:=19; end;
  with IconArray[2] do begin ImageIndex:=25; Left:=39; end;
  with IconArray[3] do begin ImageIndex:=33; Left:=58; end;
  with IconArray[4] do begin ImageIndex:=36; Left:=74; end;
  StatusBarPanel.Height:=StatusBar.Height;
  TrayPanel.Height:=StatusBar.Height;
  IconPanel.Height:=StatusBar.Height;
  IconPanel.Width:=IconArray[4].Left+21;

  NCPage:=nil;
  ECPage:=nil;
  CurPage:=nil;
  TextPanelIco:=39;
  LoadDefaultBar;

  BottomBar.Top:=0;
end;

procedure TMainForm.UpdCheckerStatus(Sender: TObject; EventType: TucEventType);
begin
  if StatusPage=nil then Exit;
  if EventType=ucNoNew then
    StatusPage.CommanderMsg('Version check: You have an up to date version of Moops.')
  else if EventType=ucNewVersion then
  begin
    StatusPage.CommanderMsg('Version check: A '+DoColorEx(cvYellow,cvNavy,False,True)+'@[http://dl.dropbox.com/u/4187827/Moops/Moops.exe]new version of Moops@[/]'+DoColor(cvYellow,cvNavy)+' is available!');
    StatusPage.AddToChat('Please click here to go to the website: http://dl.dropbox.com/u/4187827/Moops/index.html');
    StatusPage.AddToChat('Or download the new version directly at http://dl.dropbox.com/u/4187827/Moops/Moops.exe');
    StatusPage.ReceiveLine(UpdChecker.Changes+#10);
    ActivatePage(StatusPage);
    ShowMessage('Hey, did you notice? A new version of Moops is available!'#13+
                'Check out the Statuspage for more information...');
  end
  else
    StatusPage.CommanderMsg('Version check: An error has occured.');
  if UpdChecker.MoopsID<>'' then MoopsID:=UpdChecker.MoopsID;
  SaveSettings;
//  StatusPage.ReceiveLine(UpdChecker.fGetResult.DataString+#10);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  UpdChecker.Free;
  ClientPages.Free;
  TabControl.Free;
  EditorTabs.Free;
  ThemeMenuList.Free;
  WindowList.Free;
  PopupWinList.Free;
  SessionMenuList.Free;
end;

procedure TMainForm.EditorSaveExecute(Sender: TObject);
begin
  ECPage.Save;
end;

procedure TMainForm.EditorSaveAndCloseExecute(Sender: TObject);
begin
  ECPage.SaveAndClose;
end;

procedure TMainForm.EditorCloseExecute(Sender: TObject);
begin
  ECPage.Close;
end;

procedure TMainForm.WorldPasteExecute(Sender: TObject);
begin
  NCPage.PasteText;
end;

procedure TMainForm.EditorUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled:=ECPage<>nil;
  if ECPage<>nil then ECPage.EditWinSelChanged(Self);
end;

procedure TMainForm.WinNextWindowExecute(Sender: TObject);
begin
  if NCPage<>nil then NCPage.NextPage;
end;

procedure TMainForm.WinPrevWindowExecute(Sender: TObject);
begin
  if NCPage<>nil then NCPage.PrevPage;
end;

procedure TMainForm.WinNextWorldExecute(Sender: TObject);
begin
  if TabControl.TabIndex=TabControl.Tabs.Count-1 then
    TabControl.TabIndex:=0
  else
    TabControl.TabIndex:=TabControl.TabIndex+1;
  ClientPagesChange(Sender);
end;

procedure TMainForm.WinPrevWorldExecute(Sender: TObject);
begin
  if TabControl.TabIndex=0 then
    TabControl.TabIndex:=TabControl.Tabs.Count-1
  else
    TabControl.TabIndex:=TabControl.TabIndex-1;
  ClientPagesChange(Sender);
end;

procedure TMainForm.WorldUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled:=WorldMenuButton.Enabled;
end;

procedure TMainForm.LoadSession(FileName: string);
var
  CPage: TNetClientPage;
var
  Loaded: Integer;
  I: Integer;
begin
  Loaded:=-1;
  for I:=0 to ClientPages.Count-1 do
    if TNetClientPage(ClientPages[I]).SessionFileName=FileName then
    begin
      Loaded:=I; Break;
    end;
  if Loaded>-1 then
    if Application.MessageBox(
      PChar('You already have a page for '+TNetClientPage(ClientPages[Loaded]).SessionDescription+#10#13'Really open another one?'),
      'Moops!',MB_YESNO+MB_ICONWARNING)=idNo
    then
      Exit;
  CPage:=TNetClientPage.Create(Self,ClientPages,TabControl);
  CPage.McpPlugin.DebugMode:=StatusPage.McpPlugin.DebugMode;
  CPage.ChatView.WordWrap:=1;
  CPage.PopupMenu:=PopupWorld;
  TabControl.TabIndex:=TabControl.Tabs.Count-1;
  ClientPagesChange(nil);
  CPage.LoadSession(FileName);
  MainForm.UpdateCaption;
  CPage.StartSession;
end;

procedure TMainForm.FileSelectSessionExecute(Sender: TObject);
var
  FileName: string;
begin
  if SelectSessionForm.SelectSession(FileName) then
    LoadSession(FileName);
end;

procedure TMainForm.WorldPasteAdvExecute(Sender: TObject);
var
  I: Integer;
begin
  if PasteForm.ShowModal=mrOk then
    with PasteForm, NCPage do
    begin
      if not RawPasteBox.Checked then
        DoPasteText(TextMemo.Lines.Text,CmdCombo.Text)
      else
      begin
        if CmdCombo.Text<>'' then SendLine(CmdCombo.Text);
        for I:=0 to TextMemo.Lines.Count-1 do
          SendLine(TextMemo.Lines[I]);
      end;
    end;
end;

procedure TMainForm.WorldConnectExecute(Sender: TObject);
begin
  NCPage.DoConnectButton;
end;

procedure TMainForm.WorldConnectUpdate(Sender: TObject);
begin
  WorldConnect.Enabled:=(NCPage<>nil) and (NCPage.NetClient.CanConnect);
  if not WorldConnect.Enabled then
    WorldConnectButton.Down:=False
  else
    WorldConnectButton.Down:=NCPage.NetClient.State<>stDisconnected;
  if WorldConnectButton.Down then
    WorldConnect.ImageIndex:=24
  else
    WorldConnect.ImageIndex:=25;
  SetStatusIcon(iaConnection,WorldConnect{Button}.ImageIndex);
  // The following items are updated here, but this is merely a hack
  if NCPage<>nil then
  begin
    if NCPage.ChatView.ScrollLock then SetStatusIcon(iaScrollLock,41) else SetStatusIcon(iaScrollLock,40);
    if NCPage.Logging then SetStatusIcon(iaLog,42) else SetStatusIcon(iaLog,43);
  end
  else
  begin
    SetStatusIcon(iaScrollLock,40);
    SetStatusIcon(iaLog,43);
  end;
end;

procedure TMainForm.WorldPasteAdvUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled:=(NCPage<>nil) and (CurPage is TNetClientPage)
    and (NCPage.NetClient.State=stConnected);
end;

procedure TMainForm.TabControlGetImageIndex(Sender: TObject;
  TabIndex: Integer; var ImageIndex: Integer);
begin
  ImageIndex:=TNetClientPage(ClientPages[TabIndex]).ImageIndex;
end;

procedure TMainForm.WMEraseBkgnd(var Message: TMessage);
begin
  Message.Result:=1;
end;

procedure TMainForm.EditCutUpdate(Sender: TObject);
begin
  EditCut.Enabled:=ECPage<>nil;
end;

procedure TMainForm.EditCutExecute(Sender: TObject);
begin
  ECPage.EditWin.CutToClipBoard;
end;

procedure TMainForm.EditUpdate(Sender: TObject);
begin
  EditCut.Enabled:=ECPage<>nil;
end;

procedure TMainForm.EditCopyExecute(Sender: TObject);
begin
  if ECPage<>nil then ECPage.EditWin.CopyToClipBoard;
end;

procedure TMainForm.EditPasteExecute(Sender: TObject);
begin
  if ECPage<>nil then ECPage.EditWin.PasteFromClipBoard
end;

procedure TMainForm.TabControlStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  BeginDrag(False);
end;

procedure TMainForm.TabControlMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then  { drag only if left button pressed }
    TWinControl(Sender).BeginDrag(False);  { if so, drag it }
end;

procedure TMainForm.WorldCloseUpdate(Sender: TObject);
begin
  WorldClose.Enabled:=TabControl.TabIndex>0;
end;

procedure TMainForm.WorldCloseExecute(Sender: TObject);
begin
  NCPage.Leave;
end;

procedure TMainForm.EditorHiliteExecute(Sender: TObject);
begin
  with EditorHilite do
  begin
    Checked:=not Checked;
    if Checked then
      ECPage.EditWin.HighLighter:=mwMooHighLighter
    else
      ECPage.EditWin.HighLighter:=nil;
  end;
end;

procedure TMainForm.EditorHiliteUpdate(Sender: TObject);
begin
  EditorHilite.Enabled:=ECPage<>nil;
  EditorHilite.Checked:=EditorHilite.Enabled and (ECPage.EditWin.HighLighter<>nil);
end;

procedure TMainForm.EditorSaveAsExecute(Sender: TObject);
begin
  Application.MessageBox('Sorry, this is not functional yet...','Moops',0);
  //ECPage.Save;
end;

procedure TMainForm.TabControlResize(Sender: TObject);
begin
  UpdateTabBar;
end;

procedure TMainForm.WorldCopyUpdate(Sender: TObject);
begin
  WorldCopy.Enabled:=(NCPage<>nil) and NCPage.ChatView.HasSelection;
end;

procedure TMainForm.WorldCopyExecute(Sender: TObject);
begin
  NCPage.ChatView.CopyToClipBoard;
end;

procedure TMainForm.SesCurEditExecute(Sender: TObject);
begin
  SessionOptForm.LoadSession(NCPage.SessionFileName);
  SessionOptForm.ClientPage:=NCPage;
  SessionOptForm.ShowModal;
end;

procedure TMainForm.ThCurEditExecute(Sender: TObject);
begin
  ViewOptForm.LoadTheme(NCPage.ThemeFileName);
  ViewOptForm.ClientPage:=NCPage;
  ViewOptForm.ShowModal;
  NCPage.ChatView.Invalidate;
end;

procedure TMainForm.OptSelHistUpdate(Sender: TObject);
begin
  if NCPage=nil then Exit;
  with NCPage, ChatView do
  begin
    OptSelHist.Checked:=SelectiveHist;
    case FollowMode of
      cfOff:  FollowOff.Checked:=True;
      cfOn:   FollowOn.Checked:=True;
      cfAuto: FollowAuto.Checked:=True;
    end;
  end;
end;

procedure TMainForm.SessionsMenuItemClick(Sender: TObject);
begin
  LoadSession(SelectSessionForm.SessionNames[TComponent(Sender).Tag]);
end;

procedure TMainForm.ThemesMenuItemClick(Sender: TObject);
var
  CPage: TNetClientPage;
begin
  CPage:=ClientPages[TabControl.TabIndex];
  if CPage.SessionFileName<>'' then
    with SessionOptForm do
    begin
      UpdateMainForm:=False;
      LoadSession(CPage.SessionFileName);
      ThemeList.ItemIndex:=FindThemeIndex(ExtractFileName(ThemeNames[TComponent(Sender).Tag]));
      SaveSession(CPage.SessionFileName);
      UpdateMainForm:=True;
    end;
  CPage.LoadTheme(SessionOptForm.ThemeNames[TComponent(Sender).Tag]);
  CPage.Invalidate;
end;

procedure TMainForm.ThCurEditUpdate(Sender: TObject);
begin
  TMenuItem(
    ThemeMenuList.Items[
      SessionOptForm.FindThemeIndex(
        ExtractFileName(TNetClientPage(ClientPages[TabControl.TabIndex]).ThemeFileName)
      )
    ]
  ).Checked:=True;
end;

procedure TMainForm.ThNewExecute(Sender: TObject);
begin
  ViewOptForm.SetDefaults;
  ViewOptForm.ClientPage:=TNetClientPage(ClientPages[TabControl.TabIndex]);
  ViewOptForm.ShowModal;
end;

procedure TMainForm.WorldLineLengthExecute(Sender: TObject);
begin
  NCPage.UpdateLineLength;
end;

procedure TMainForm.WorldLineLengthUpdate(Sender: TObject);
begin
  WorldLineLength.Enabled:=
    (TabControl.TabIndex>0) and
    (TComponent(ClientPages[TabControl.TabIndex]) is TNetClientPage) and
    TNetClientPage(ClientPages[TabControl.TabIndex]).NetClient.Connected;
end;

procedure TMainForm.WMSize(var Message: TWMSize);
var
  I: Integer;
begin
  inherited;
  if ClientPages=nil then Exit;
  UpdateTabBar;
  for I:=0 to ClientPages.Count-1 do
    PostMessage(TNetClientPage(ClientPages[I]).ChatView.Handle,WM_SIZE,0,0);
  StatusResized;
end;

procedure TMainForm.LoadDefaultBar;
begin
  StatusBar.Panels.Clear;
  with StatusBar.Panels.Add do
  begin
    Width:=StatusBar.ClientWidth;
    Style:=psOwnerDraw;
  end;
  TextPanel:=0;
  TextPanelLeft:=3;
end;

procedure TMainForm.AppEventsHint(Sender: TObject);
var
  I: Integer;
begin
  if (GetLongHint(Application.Hint)='') and (CurPage<>nil) then
  begin
    CurPage.UpdateStatus(False);
    if TextPanel<>CurPage.StatusBar.Panels.Count then
    begin
      LoadDefaultBar;
      for I:=CurPage.StatusBar.Panels.Count-1 downto 0 do
      begin
        StatusBar.Panels.Insert(0);
        with StatusBar.Panels[0] do
        begin
          Text:=CurPage.StatusBar.Panels[I].Text;
          Width:=CurPage.StatusBar.Panels[I].Width;
          Inc(TextPanel);
          Inc(TextPanelLeft,Width+3);
          StatusBar.Panels[TextPanel].Width:=StatusBar.Panels[TextPanel].Width-Width;
        end;
      end;
    end;
    StatusBar.Panels[TextPanel].Text:=CurPage.StatusTxt;
    TextPanelIco:=CurPage.StatusIco;
  end
  else
  begin
    if TextPanel<>0 then LoadDefaultBar;
    TextPanelIco:=39;
    StatusBar.Panels[TextPanel].Text:=GetLongHint(Application.Hint);
  end;
end;

procedure TMainForm.StatusChanged;
var
  I: Integer;
begin
  //ShowMessage('StatusChanged');
{  if NCPage<>nil then W:=NCPage.StatusPlugin.TrayWidth else W:=0;
  if W<>StatusBar.Panels[TrayPanel].Width then
  begin
    StatusBar.Panels[TextPanel].Width:=StatusBar.Panels[TextPanel].Width-W+StatusBar.Panels[TrayPanel].Width;
    TrayPanelLeft:=TrayPanelLeft+W+StatusBar.Panels[TrayPanel].Width;
    StatusBar.Panels[TrayPanel].Width:=W;
  end;}

  if (GetLongHint(Application.Hint)<>'') or (TextPanel<>CurPage.StatusBar.Panels.Count) then
  begin
    AppEventsHint(nil); Exit;
  end;
  CurPage.UpdateStatus(False);
  for I:=0 to CurPage.StatusBar.Panels.Count-1 do
    if StatusBar.Panels[I].Text<>CurPage.StatusBar.Panels[I].Text then
      StatusBar.Panels[I].Text:=CurPage.StatusBar.Panels[I].Text;
  if (StatusBar.Panels[TextPanel].Text<>CurPage.StatusTxt) or (TextPanelIco<>CurPage.StatusIco) then
  begin
    TextPanelIco:=CurPage.StatusIco;
    StatusBar.Panels[TextPanel].Text:=CurPage.StatusTxt;
    StatusBar.Invalidate;
  end;
end;

procedure TMainForm.SetStatusIcon(Position, IconIndex: Integer);
var
  R: TRect;
begin
  if IconArray[Position].ImageIndex=IconIndex then Exit;
  IconArray[Position].ImageIndex:=IconIndex;
  R.Left:=IconArray[Position].Left;
  R.Top:=2;
  R.Right:=R.Left+16;
  R.Bottom:=R.Top+16;
  IconBox.Canvas.FillRect(R);
  DrawStatusIcon(Position);
end;

procedure TMainForm.DrawStatusIcon(Position: Integer);
begin
  ImageList1.Draw(IconBox.Canvas,IconArray[Position].Left,2,IconArray[Position].ImageIndex);
end;

procedure TMainForm.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel.Index<>TextPanel then Exit;
  ImageList1.Draw(StatusBar.Canvas,TextPanelLeft,4,TextPanelIco);
  StatusBar.Canvas.TextOut(TextPanelLeft+20,4,Panel.Text);
end;

procedure TMainForm.FileMinimizeExecute(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TMainForm.WinMenuItemClick(Sender: TObject);
begin
  ActivatePage(ClientPages[TMenuItem(Sender).MenuIndex-5]);
end;

procedure TMainForm.WinMenuSubItemClick(Sender: TObject);
begin
  ActivatePage(TNetClientPage(ClientPages[TMenuItem(Sender).Parent.MenuIndex-5]).OwnedPages[TMenuItem(Sender).MenuIndex]);
end;

procedure TMainForm.WriteDebug(const Msg: string);
begin
  if StatusPage<>nil then
    StatusPage.CommanderMsg(Msg);
end;

procedure TMainForm.UpdateEditorMenus;
var
  I, J: Integer;
  MI, SMI: TMenuItem;
begin
  if DebugMode then WriteDebug('# UpdateEditorMenus 1');
  // Clear current items
  for I:=WindowList.Count-1 downto 0 do
  begin
    TMenuItem(WindowList[I]).Free;
    WindowList.Delete(I);
  end;
  if DebugMode then WriteDebug('# UpdateEditorMenus 2');
  for I:=PopupWinList.Count-1 downto 0 do
  begin
    TMenuItem(PopupWinList[I]).Free;
    PopupWinList.Delete(I);
  end;
  if DebugMode then WriteDebug('# UpdateEditorMenus 3');
  // Fill the Window-menu
  for I:=0 to ClientPages.Count-1 do
  begin
    MI:=TMenuItem.Create(WinMenu);
    MI.Caption:=TNetClientPage(ClientPages[I]).Caption;
    with TNetClientPage(ClientPages[I]) do
    begin
      if OwnedPages.Count=0 then MI.OnClick:=WinMenuItemClick;
      for J:=0 to OwnedPages.Count-1 do
      begin
        SMI:=TMenuItem.Create(WinMenu);
        SMI.Caption:=TClientPage(OwnedPages[J]).Caption;
        SMI.OnClick:=WinMenuSubItemClick;
        MI.Add(SMI);
      end;
    end;
    WindowList.Add(MI);
    WinMenu.Add(MI);
  end;
  if DebugMode then WriteDebug('# UpdateEditorMenus 4');
end;

function TMainForm.Pos2StatusIcon(X, Y: Integer): Integer;
var
  I, L: Integer;
begin
  for I:=Low(IconArray) to High(IconArray) do
  begin
    L:=IconArray[I].Left;
    if (X>=L) and (X<=L+16) then begin Result:=I; Exit; end;
  end;
  Result:=-1;
end;

procedure TMainForm.IconBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  I:=Pos2StatusIcon(X,Y);
  if (I in [0,1]) and (NCPage<>nil) then
  begin
    if I=0 then NCPage.Logging:=not NCPage.Logging;
    if I=1 then NCPage.ChatView.ScrollLock:=not NCPage.ChatView.ScrollLock;
    if I in [2,3,4] then NCPage.ShowConnInfo;
  end;
end;

procedure TMainForm.IconBoxMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  I: Integer;
  P: TPoint;
  S: string;
begin
  I:=Pos2StatusIcon(X,Y);
  if I=-1 then IconBox.Hint:=''
  else
  begin
    if (I in [0,1,2]) then
    begin
      if NCPage=nil then S:=''
      else
        if I=0 then S:=NCPage.GetLoggingInfo
        else if I=1 then S:=NCPage.GetScrollLockInfo
        else if I=2 then S:=NCPage.GetConnectionInfo;
    end
    else
      if I=3 then S:='Upload indicator|'
      else S:='Download indicator|';
    if IconBox.Hint<>S then
    begin
      IconBox.Hint:=S;
      P:=IconBox.ClientToScreen(Point(X,3));
      Application.ActivateHint(P);
    end;
  end;
end;

procedure TMainForm.StatusBarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  procedure ShowError(const Msg: string);
  begin
    (*Application.MessageBox(
      PChar('This link is rejected by Moops because of possible dangerous content ('+Msg+')'
            {#10#13'You can disable this error under Global Options.'})
      ,'Moops!',MB_ICONWARNING);*)
    NCPage.CommanderMsg(
      'This link is rejected by Moops because of possible dangerous content ('+Msg+')'
            {#10#13'You can disable this error under Global Options.'}
    );
  end;
var
  ErrCode, Ico: Integer;
  Msg, Cmd: string;
  LinkType: Integer;
begin
  if (NCPage<>nil) and (CurPage=NCPage) and (Button in [mbLeft,mbMiddle]) then
  begin
    NCPage.StatusMan.Update(Msg,Cmd,Ico,False);
    if Cmd='' then Exit; // begin NCPage.CommanderMsg('No command defined for this particular message...'); Exit; end;

    Msg:=Cmd;
    SplitLink(Msg,LinkType,Cmd);
    if not IsValidURL(LinkType,Cmd,Msg) then
    begin
      ShowError(Msg);
      Exit;
    end;
    if LinkType=1 then // url
    begin
      ErrCode:=ShellExecute(Handle,'open',PChar(Cmd),nil,nil,SW_SHOWNORMAL);
      if ErrCode<32 then
        NCPage.CommanderMsg('Error: cannot execute link (there probably is no application linked to this type of url).');
    end
    else if LinkType=2 then // clientcommand
      NCPage.HandleInput(Cmd)
    else if LinkType=3 then // general moocommand (look etc)
      NCPage.SendLine(Cmd)
    else if LinkType=4 then // custom moocommand
      NCPage.SendLine(Cmd)
    else if LinkType=5 then // custom moocommand through mcp
      NCPage.McpPlugin.SendMcp('dns-net-beryllium-status-msg_exec','cmd: "'+EnQuote(Cmd)+'"');

{    if LowerCase(Copy(Cmd,1,5))='link:' then
    begin
      if not IsValidURL(1,Copy(Cmd,6,Length(Cmd)),Msg) then begin ShowError(Msg); Exit; end;
      ErrCode:=ShellExecute(Handle,'open',PChar(Copy(Cmd,6,Length(Cmd))),nil,nil,SW_SHOWNORMAL);
      if ErrCode<32 then
        NCPage.CommanderMsg('Error: cannot execute "'+Copy(Cmd,6,Length(Cmd))+'" (there probably is no application linked to this type of url).');
      Exit;
    end
    else if LowerCase(Copy(Cmd,1,4))='moo:' then
    begin
      NCPage.CommanderMsg('Sending "'+Copy(Cmd,5,Length(Cmd))+'"');
      NCPage.SendLine(Copy(Cmd,5,Length(Cmd)));
      Exit;
    end
    else if LowerCase(Copy(Cmd,1,5))='clnt:' then
    begin
      if not IsValidURL(2,Copy(Cmd,6,Length(Cmd)),Msg) then begin ShowError(Msg); Exit; end;
      NCPage.HandleInput(Copy(Cmd,6,Length(Cmd)));
      Exit;
    end;
    NCPage.CommanderMsg('Error: unknown command ('+Cmd+')');
    Exit;}
  end;
end;

procedure TMainForm.OptGlobalExecute(Sender: TObject);
begin
  MainForm.SaveSettings;
  GlobalOptForm.ShowModal;
  MainForm.LoadSettings;
end;

procedure TMainForm.AppEventsException(Sender: TObject; E: Exception);
begin
  if E is EAbort then Exit;
  if BetaMode then Application.ShowException(E);
  { Do nothing }
end;

procedure TMainForm.IdentServerSessionTimeout(Thread: TWinshoeServerThread;
  var KeepAlive: Boolean);
begin
  Thread.Connection.CloseSocket;
  KeepAlive:=False;
end;

procedure TMainForm.IdentServerExecute(Thread: TWinshoeServerThread);
var
  LogString, S, UserName, Msg: string;
  I, P, RPort, LPort: Integer;
begin
  LogString:='Ident: Request by '+Thread.Connection.PeerAddress;
  try
    S:=Thread.Connection.ReadLn;
    //StatusPage.AddToLog('Ident: <'+S+'>');
    P:=Pos(',',S);

    LPort:=StrToInt(Trim(Copy(S,1,P-1))); if (LPort<1) or (LPort>65535) then Abort;
    RPort:=StrToInt(Trim(Copy(S,P+1,Length(S)))); if (RPort<1) or (RPort>65535) then Abort;

    S:=IntToStr(LPort)+', '+IntToStr(RPort);

    P:=-1;
    for I:=0 to ClientPages.Count-1 do
      with TNetClientPage(ClientPages[I]) do
        if NetClient.IsConnection(Thread.Connection.PeerAddress,LPort,RPort,Msg) then
        begin
          UserName:=IdentID;
          LogString:=LogString+' <'+Caption+'>';
          if UserName='' then LogString:=LogString+' (Ident disallowed)';
          P:=I; Break;
        end;
    if P=-1 then
      if DefaultIdent<>'' then
      begin
        UserName:=DefaultIdent; P:=0;
        LogString:=LogString+' (Unkown connection, sending default)';
      end
      else
        LogString:=LogString+' (Unknown connection, ident denied)';

    if (P=-1) or (UserName='') then
      Thread.Connection.WriteLn(S+' : ERROR : HIDDEN-USER')
    else
      Thread.Connection.WriteLn(S+' : USERID : Moops : '+UserName);
  except
    Thread.Connection.WriteLn(S+' : ERROR : INVALID-PORT');
  end;
  try
    Thread.Connection.CloseSocket;
    StatusPage.AddToLog(LogString);
  except
  end;
end;

procedure TMainForm.SesNewSessionExecute(Sender: TObject);
begin
  SessionOptForm.SetDefaults;
  if SessionOptForm.ShowModal=mrOK then
    LoadSession(ExtractFileName(SessionOptForm.IniFileName));
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=115) and (Shift=[ssCtrl]) then EditorClose.Execute;
  if (Key=118) and (Shift=[]) then EditorSave.Execute;
  if (Key=118) and (Shift=[ssCtrl]) then EditorSaveAndClose.Execute;
end;

procedure TMainForm.ToolBarMenuClick(Sender: TObject);
begin
  with MenuToolBar do
    Visible:=not Visible;
end;

procedure TMainForm.ToolBarBar1Click(Sender: TObject);
begin
  with ToolBar1 do
    Visible:=not Visible;
end;

procedure TMainForm.ToolBarWorldsClick(Sender: TObject);
begin
  with TabControl do
    Visible:=not Visible;
end;

procedure TMainForm.PopupWorldPopup(Sender: TObject);
begin
  ToolBarMenu.Checked:=MenuToolBar.Visible;
  ToolBarBar1.Checked:=Toolbar1.Visible;
  ToolBarWorlds.Checked:=TabControl.Visible;
  ToolbarEditors.Checked:=EditorTabs.Visible;
end;

procedure TMainForm.IconBoxPaint(Sender: TObject);
var
  I: Integer;
begin
  for I:=Low(IconArray) to High(IconArray) do DrawStatusIcon(I);
end;

procedure TMainForm.TrayBoxPaint(Sender: TObject);
begin
  if NCPage<>nil then
    NCPage.StatusPlugin.PaintIcons;
end;

procedure TMainForm.TrayBoxMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if NCPage<>nil then NCPage.StatusPlugin.MouseMove(Shift,X,Y);
end;

procedure TMainForm.TrayBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if NCPage<>nil then NCPage.StatusPlugin.MouseDown(Button,Shift,X,Y);
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (NCPage<>nil) and (NCPage=CurPage) and NCPage.InputEdit.CanFocus and (not NCPage.InputEdit.Focused) then
  begin
    NCPage.InputEdit.SetFocus;
    if Key in [#32..#126] then NCPage.InputEdit.SelText:=Key;
    Key:=#0;
  end;
end;

procedure TMainForm.BottomBarDockDrop(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer);
begin
  BottomBar.Top:=0;
end;

procedure TMainForm.OptLoggingExecute(Sender: TObject);
begin
  NCPage.Logging:=not NCPage.Logging;
end;

procedure TMainForm.OptLoggingUpdate(Sender: TObject);
begin
  if NCPage.Logging then
  begin
    OptLogging.Caption:='Stop Logging';
    OptLogging.ImageIndex:=42;
  end
  else
  begin
    OptLogging.Caption:='Start Logging';
    OptLogging.ImageIndex:=43;
  end;
end;

procedure TMainForm.LoadEditorSettings(Ini: TIniFile);
var
  I, J: Integer;
begin
  try
    EditorSettings.FontName:=Ini.ReadString('EditorFont','Name','Courier');
    EditorSettings.FontSize:=Ini.ReadInteger('EditorFont','Size',10);
    EditorSettings.FontBold:=Ini.ReadBool('EditorFont','Bold',False);

    for I:=ClientPages.Count-1 downto 0 do
      with TNetClientPage(ClientPages[I]) do
        for J:=OwnedPages.Count-1 downto 0 do
          if TClientPage(OwnedPages[J]) is TEditClientPage then
            TEditClientPage(OwnedPages[J]).UpdateFont;
  except
  end;
end;

procedure TMainForm.EditorTabsChange(Sender: TObject);
begin
  try
    if NCPage<>nil then
      if EditorTabs.TabIndex=0 then
        ActivatePage(NCPage)
      else
        ActivatePage(NCPage.OwnedPages[EditorTabs.TabIndex-1]);
  except
  end;
end;

procedure TMainForm.EditorTabsGetImageIndex(Sender: TObject;
  TabIndex: Integer; var ImageIndex: Integer);
begin
  try
    if (TabIndex=0) or (NCPage=nil) then ImageIndex:=46
    else
      ImageIndex:=TEditClientPage(NCPage.OwnedPages[TabIndex-1]).StatusIco;
  except
    ImageIndex:=46;
  end;
end;

procedure TMainForm.EditorTabsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then  { drag only if left button pressed }
    TWinControl(Sender).BeginDrag(False);  { if so, drag it }
end;

procedure TMainForm.EditorTabsResize(Sender: TObject);
begin
  UpdateEditorTabs;
end;

procedure TMainForm.UpdateEditorTabs;
var
  I, W: Integer;
begin
  LastEditorTabCount:=EditorTabs.Tabs.Count;
  W:=0;
  for I:=0 to LastEditorTabCount-1 do
    with EditorTabs.TabRect(I) do
      Inc(W,Right-Left+10);
  EditorTabs.Width:=W+1;
end;

procedure TMainForm.ToolbarEditorsClick(Sender: TObject);
begin
  with EditorTabs do
    Visible:=not Visible;
end;

{ TEmptyPanel }

constructor TEmptyPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption:='';
  BevelInner:=bvNone;
  BevelOuter:=bvNone;
end;

procedure TEmptyPanel.WMEraseBkgnd(var Msg: TMessage);
begin
  Msg.Result:=1;
end;

procedure TMainForm.EditorTabsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  P: TPoint;
  S: string;
begin
  if ShowEditorCaps then
    I:=-1
  else
    I:=EditorTabs.IndexOfTabAt(X,Y);
  if I=-1 then EditorTabs.Hint:=''
  else
  begin
    {if I=0 then
      S:=NCPage.Caption
    else
      S:=TEditClientPage(NCPage.OwnedPages[I-1]).Caption;}
    S:=EditorTabs.Tabs[I];
    if EditorTabs.Hint<>S then
    begin
      EditorTabs.Hint:=S;
      P:=EditorTabs.ClientToScreen(Point(X,3));
      Application.ActivateHint(P);
    end;
  end;
end;

procedure TMainForm.EditorShowCaptionsExecute(Sender: TObject);
begin
  ShowEditorCaps:=not ShowEditorCaps;
end;

procedure TMainForm.EditorShowCaptionsUpdate(Sender: TObject);
begin
  EditorShowCaptions.Checked:=ShowEditorCaps;
end;

procedure TMainForm.WorldShowCaptionsExecute(Sender: TObject);
begin
  ShowWorldCaps:=not ShowWorldCaps;
end;

procedure TMainForm.WorldShowCaptionsUpdate(Sender: TObject);
begin
  WorldShowCaptions.Checked:=ShowWorldCaps;
end;

procedure TMainForm.SetShowEditorCaps(const Value: Boolean);
begin
  fShowEditorCaps := Value;
  if Value then
    EditorTabs.TabWidth:=0
  else
    EditorTabs.TabWidth:=22;
end;

procedure TMainForm.SetShowWorldCaps(const Value: Boolean);
begin
  fShowWorldCaps := Value;
  if Value then
    TabControl.TabWidth:=0
  else
    TabControl.TabWidth:=22;
end;

procedure TMainForm.TabControlMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  P: TPoint;
  S: string;
begin
  if ShowWorldCaps then
    I:=-1
  else
    I:=TabControl.IndexOfTabAt(X,Y);
  if I=-1 then TabControl.Hint:=''
  else
  begin
    {if I=0 then
      S:=NCPage.Caption
    else
      S:=TEditClientPage(NCPage.OwnedPages[I-1]).Caption;}
    S:=TabControl.Tabs[I];
    if TabControl.Hint<>S then
    begin
      TabControl.Hint:=S;
      P:=TabControl.ClientToScreen(Point(X,3));
      Application.ActivateHint(P);
    end;
  end;
end;

procedure TMainForm.WatcherSwitchWorldExecute(Sender: TObject);
begin
  Watcher.SwitchToWorld;
end;

procedure TMainForm.WatcherEnableExecute(Sender: TObject);
begin
  if Watcher<>nil then
    DisableWatcher
  else
    EnableWatcher;
end;

procedure TMainForm.WatcherEnableUpdate(Sender: TObject);
begin
  WatcherEnable.Checked:=Watcher<>nil;
end;

procedure TMainForm.DisableWatcher;
begin
  if Watcher=nil then Exit;
  FreeAndNil(Watcher);
end;

procedure TMainForm.EnableWatcher;
begin
  if Watcher<>nil then Exit;
  Watcher:=TWatcher.Create(Self);
  Watcher.Parent:=Self;
  Watcher.PopupMenu:=WatcherPopup;
  Watcher.Activate;
end;

procedure TMainForm.WatcherThemeExecute(Sender: TObject);
begin
  try
    ViewOptForm.SetWatcherMode;
    ViewOptForm.LoadTheme(AppDir+'Themes\watcher.mth');
    ViewOptForm.ClientPage:=nil;
    ViewOptForm.ShowModal;
  finally
    ViewOptForm.SetNormalMode;
  end;
end;

initialization
  {$IFDEF DEBUG}
  //NewSession('Moops');
  {$ENDIF}
end.

