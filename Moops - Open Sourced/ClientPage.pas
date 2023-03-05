unit ClientPage;

interface

uses
  Windows, Classes, Controls, ComCtrls, StdCtrls, ExtCtrls, ScktComp, Dialogs, SysUtils,
  BeChatView, StdPlugins, ColorFrm, Parser, BePlugin, Common, mwCustomEdit, McpPlugin,
  ClipBrd, Messages, mwMooSyn, ShellAPI, IniFiles, Graphics, ImgManager, BeNetwork,
  StatusUnit, LinkParser, mwKeyCmds;

const
  ColorNames: array[0..15] of string =
    ('Black','Maroon','Green','Olive','Navy','Purple','Teal','Gray',
     'Silver','Red','Lime','Yellow','Blue','Fuchsia','Aqua','White');


  WM_NCCLOSEPAGE = WM_USER + 201;
  WM_ECCLOSEPAGE = WM_USER + 202;

  imgIdle    = 26; // 26
  imgChanged = 27;
  imgActive  = 28;
  LedTime    = 5; // Time the activity-led will be shown

  isOnLoad               = 0;
  isOnServerConnected    = 1;
  isOnLoginSent          = 2;
  isOnDisconnect         = 3;
  isOnServerDisconnected = 4;
  isOnClose              = 5;

type
  PScriptEnviron = ^TScriptEnviron;
  TScriptEnviron = record
    Level:    Integer;
    FileName: string;
    Lines:    TStringList;
    ActLine:  Integer;
  end;

  TBeTabControl = class(TTabControl)
  end;
  TBeMemo = class(TMemo)
  private
    procedure WMPaste(var Msg: TMessage); message WM_PASTE;
  public
    Prefix, Postfix: string;
  end;

  TClientPage = class(TClientPageBase)
  protected
    procedure PageChanged;
  public
    StatusBar: TStatusBar;
    StatusTxt: string;
    StatusCmd: string;
    StatusIco: Integer;
    CloseLoop: Boolean;

    constructor Create(AOwner: TComponent; APageList: TList);
    destructor Destroy; override;
    procedure SheetEnter(Sender: TObject); virtual;
    procedure ActivatePage(APage: TClientPage);
    function CanFree: Boolean; virtual;

    procedure AddToLog(Msg: string); override;
    procedure SetStatus(const Msg: string); virtual;
    procedure UpdateStatus(UpdExpire: Boolean); virtual;
    procedure StatusChanged;
  end;

  TScriptArray = array[0..5] of TStringList;
  TEditClientPage = class;

  TNetClientPage = class(TClientPage)
  private
    fImageIndex: Integer;
    fThemeFileName, fThemeDescr: string;
    fSessionFileName, fSessionDescr: string;
    Working: Boolean;
    InputHist: TStringList;
    HistLine: Integer;
    ActMsg: string;
    fWaitFor: string;
    fWaitForFound: Boolean;
    fStopped, fAbortAll: Boolean;
    fLogFilePlugin: TLogFilePlugin;
    fMooServer: string;
    fMooPort: Integer;
    {fUseProxy: Boolean;
    fProxyServer, fProxyCmd: string;
    fProxyPort: Integer;}
    fPasteCmd, fEditCmd, fNotEditCmd, fLineLengthCmd: string;
    fLogInp, fLogOut, fLogErr, fLogInf: string;
    InternalScripts: TScriptArray;
    fOldLineLen: Integer; // used for AutoLineLength
    TabControl: TTabControl;
    fVerboseLog: Boolean;
    FirstTimeLoad: Boolean; // True if session wasn't loaded yet
    procedure ISplitterMoved(Sender: TObject);
    function GetLogging: Boolean;
    procedure SetLogging(Value: Boolean);
    procedure SetImageIndex(Index: Integer);
    function CaptionExists(ACaption: string): Boolean;
    procedure ChatViewLinkClick(Sender: TObject; LinkData: TLinkData; Button, X, Y: Integer);
    procedure AddToHist(const Msg: string);
    procedure InputEditKeyPress(Sender: TObject; var Key: Char);
    procedure InputEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ShowHist;
    function  StartLogging: Boolean;
    procedure StopLogging;
    procedure cmQuit;
    procedure cmIn;
    procedure cmOut;
    procedure cmDebug_Mcp;
    procedure cmConnect;
    procedure cmPlainLogin;
    procedure cmCryptLogin;
    procedure cmReLogin;
    procedure cmReconnect;
    procedure cmDisconnect;
    procedure cmEncrypt;
    procedure cmDecrypt;
    procedure cmExec;
    procedure cmNew;
    procedure cmChDir;
    procedure cmPwd;
    procedure cmLeave;
    procedure cmWaitFor;
    procedure cmEnd;
    procedure cmAddToLog;
    procedure cmAddToChat;
    procedure cmCommanderMsg;
    procedure cmSetCaption;
    procedure cmHelp;
    procedure cmSetStatus;
    procedure cmClear;
    procedure cmDelay;
    procedure cmEdit;
    procedure cmNoteEdit;
    procedure cmLocalEdit;
    procedure cmStop;
    procedure cmDumpML;
    procedure cmPluginDump;
    procedure cmPluginPri;
    procedure cmLogRotate;
    procedure cmLoadLog;
    procedure cmHE;
    procedure cmME;
    procedure cmDE;
    procedure cmLoadTheme;
    procedure cmLoadSession;
    procedure cmStartSession;
    procedure cmDumpDebug;
    procedure cmShell;
    procedure cmInfo;
    procedure cmHoppa;
    procedure cmMemUsage;
  protected
    ScriptEnviron: PScriptEnviron;
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMNetworkData(var Message: TMessage); message WM_NETWORKDATA;
    function  NewScriptEnviron(FileName: string): PScriptEnviron;
    procedure FreeScriptEnviron(Environ: PScriptEnviron);
    procedure StartExec(OldEnviron: PScriptEnviron);
    procedure ExecInternalScript(ScriptName: string; Lines: TStringList);
    procedure EndWith(const Msg: string);
    procedure EndScript;
    function  ScriptEnded: Boolean;
    procedure CreatePage(ACaption: string);
    procedure CloseChildren;
    procedure DoConnected;
    procedure DoDisconnected;
//    procedure NetClientStatus(Sender: TObject; EventType: TncEventType; Msg: string);
  public
    NetClient: TNetClient;
    InputEdit: TBeMemo;
    ISplitter: TSplitter;
    Commander: TParser;
    Plugins:   TList;
    McpPlugin: TMcpPlugin;
    SimpleEditPlugin: TSimpleEditPlugin;
    SelectiveHist, SaveHist: Boolean;
    ActiveCount: Integer;
    DefaultStatusTxt: string;
    MaxHist: Integer;
    OwnedPages: TList;
    StatusMan: TStatusManager;
    IdentID: string;
    UList: TListView;
    USplitter: TSplitter;
    StatusPlugin: TMcpStatusPkg;
    UserlistPlugin: TMcpVmooUserlistPkg;

    constructor Create(AOwner: TComponent; APageList: TList; ATabControl: TTabControl);
    destructor Destroy; override;
    procedure SheetEnter(Sender: TObject); override;
    function CanFree: Boolean; override;
    procedure Leave;
    procedure UpdateLed;
    procedure UpdateEditorTabs;
    procedure NextPage;
    procedure PrevPage;

    procedure SendLineDirect(const Msg: string); override;
    procedure SendLine(const Msg: string); override;
    procedure AddToChat(const Msg: string); override;
    procedure CommanderMsg(const Msg: string); override;
    procedure HandleLines;
    procedure ReceiveLine(const Msg: string);
    procedure HandleInput(const Msg: string);
    procedure Translate(const Msg: string);
    procedure AddInputKey(K: Char);

    procedure ExecuteScript(FileName: string);
    function OpenEditor(ACaption: string): TEditClientPage;
    procedure DoPasteText(const Lines, Command: string);
    procedure PasteText;
    procedure Connect;
    procedure DoConnectButton;
    procedure UpdateLineLength;
    procedure SetStatus(const Msg: string); override;
    procedure SetCaption(const S: string); override;
    procedure UpdateStatus(UpdExpire: Boolean); override;
    function GetLoggingInfo: string;
    function GetConnectionInfo: string;
    function GetScrollLockInfo: string;
    procedure ShowConnInfo;

    function LoadTheme(FileName: string): Boolean;
    function LoadSession(FileName: string): Boolean;
    function SaveSession(FileName: string): Boolean;
    procedure SetDefaultTheme;
    procedure UpdateTheme;
    procedure UpdateSession;
    procedure StartSession;

    procedure ShowUserList;
    procedure HideUserList;

    property ThemeFileName: string read fThemeFileName;
    property ThemeDescription: string read fThemeDescr;
    property SessionFileName: string read fSessionFileName;
    property SessionDescription: string read fSessionDescr;
    property ImageIndex: Integer read fImageIndex write SetImageIndex;
    property Logging: Boolean read GetLogging write SetLogging;
  end;

  TEditClientPage = class(TClientPage)
  private
    LastCaretX, LastCaretY: Integer;
  public
    EditWin: TmwCustomEdit;
    NCPage:  TNetClientPage;
    FileName, TextType, UploadCmd, SimpleEditReference: string;
    CloseAfterSave: Boolean;
    constructor Create(AOwner: TComponent; APageList: TList);
    destructor Destroy; override;
    procedure SwitchToWorld;
    procedure SheetEnter(Sender: TObject); override;
    procedure LoadFromFile(const AFileName: string);
    procedure Save;
    procedure SaveAs;
    procedure Close;
    procedure SaveAndClose;
    procedure InitLoading(const VerbName: string);
    procedure FinishLoading;
    procedure EditWinSelChanged(Sender: TObject);
    procedure EditWinChanged(Sender: TObject);
    procedure SetStatus(const Msg: string); override;
    procedure UpdateFont;
    procedure UpdateEditorTabs;
    procedure SetCaption(const S: string); override;
  end;

  TEditorSettings = record
    FontName: string;
    FontSize: Integer;
    FontBold: Boolean;
  end;

var
  EditorSettings: TEditorSettings;

implementation

uses
  Forms, MainFrm, MoopsHelp, SessionOptFrm, WatcherUnit, UpdateCheck;

function SizeToStr(I: Integer): string;
const
  Meg: Integer = 1024*1024;
begin
  Result:=IntToStr(I);
  if I>Meg then
    Result:=Result+' ('+FormatFloat('0.0',I/Meg)+'MB)'
  else
    Result:=Result+' ('+FormatFloat('0.0',I/1024)+'kB)';
end;

constructor TEditClientPage.Create(AOwner: TComponent; APageList: TList);
begin
  inherited Create(AOwner,APageList);
  Parent:=TWinControl(AOwner);
  Align:=alClient;
  LastCaretX:=0; LastCaretY:=0;
  EditWin:=TmwCustomEdit.Create(Self);
  EditWin.Parent:=Self;
  EditWin.PopupMenu:=MainForm.PopupEdit;
  EditWin.Align:=alClient;
  EditWin.RightEdge:=0;
  EditWin.Gutter.Width:=0;
(*  EditWin.OnKeyPress:=EditWinKeyPress;
  EditWin.OnMouseMove:=EditWinMouseMove;*)
  EditWin.OnChange:=EditWinChanged;
  EditWin.WantTabs:=True;
  UpdateFont;
  EditWin.MaxUndo:=1000;
  EditWin.KeyStrokes.Items[EditWin.Keystrokes.FindKeyCode(Ord('Y'),[ssCtrl])].Command:=ecRedo;
  NCPage:=nil;
  FileName:=''; TextType:=''; UploadCmd:='';
  CloseAfterSave:=False;
  StatusBar.SimplePanel:=False;
  with StatusBar.Panels.Add do
  begin
    Text:='0';
    Width:=30;
  end;
  with StatusBar.Panels.Add do
  begin
    Text:='0';
    Width:=30;
  end;
  StatusTxt:='';
  StatusIco:=imgNotepad;
end;

destructor TEditClientPage.Destroy;
var
  NC: TNetClientPage;
begin
//  TabControl.TabIndex:=NCPage.TabIndex;
//  if Assigned(TabControl.OnChange) then TabControl.OnChange(nil);
  NC:=NCPage;
  SwitchToWorld;
  EditWin.Free;
  inherited Destroy;
  if NC<>nil then NC.UpdateEditorTabs;
end;

procedure TEditClientPage.UpdateFont;
begin
  EditWin.Font.Name:=EditorSettings.FontName;
  EditWin.Font.Size:=EditorSettings.FontSize;
  if EditorSettings.FontBold then
    EditWin.Font.Style:=[fsBold]
  else
    EditWin.Font.Style:=[];
end;

procedure TEditClientPage.SwitchToWorld;
begin
  ActivatePage(NCPage);
end;

procedure TEditClientPage.SetStatus(const Msg: string);
begin
  //StatusBar.Panels[2].Text:=Msg;
  StatusTxt:=Msg;
  StatusChanged;
end;

(*procedure TEditClientPage.EditWinMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  EditWinSelChanged;
end;

procedure TEditClientPage.EditWinKeyPress(Sender: TObject; var Key: Char);
begin
  EditWinSelChanged;
end;*)

procedure TEditClientPage.EditWinSelChanged(Sender: TObject);
begin
  if (EditWin.CaretY=LastCaretY) and (EditWin.CaretX=LastCaretX) then Exit;
  LastCaretY:=EditWin.CaretY;
  LastCaretX:=EditWin.CaretX;
  StatusBar.Panels[0].Text:=IntToStr(LastCaretY);
  StatusBar.Panels[1].Text:=IntToStr(LastCaretX);
  StatusChanged;
end;

procedure TEditClientPage.EditWinChanged(Sender: TObject);
begin
  SetStatus('Modified');
end;

procedure TEditClientPage.LoadFromFile(const AFileName: string);
begin
  TextType:='file';
  FileName:=AFileName;
  try
    if FileName<>'' then
      if FileExists(FileName) then
      begin
        EditWin.Lines.LoadFromFile(FileName);
        SetStatus('Opened existing '+FileName);
      end
      else
        SetStatus('New file '+FileName);
  except
    SetStatus('Error opening '+AFileName);
  end;
end;

procedure TEditClientPage.SaveAs;
var
  SD: TSaveDialog;
begin
  SD:=TSaveDialog.Create(Self);
  SD.DefaultExt:='.msc';
  if FileName='' then
    SD.FileName:='unnamed'
  else
    SD.FileName:=FileName;
  SD.Filter:='Moops scripts (*.msc)|*.msc|Text files (*.txt)|*.txt|All files (*.*)|*.*';
  SD.FilterIndex:=1;
  if SD.Execute then
  begin
    FileName:=SD.FileName;
    Save;
  end
  else
    CloseAfterSave:=False;
  SD.Free;
end;

procedure TEditClientPage.Save;
var
  EditPlugin: TMcpEditPkg;
begin
  if TextType='file' then
    if FileName='' then
      SaveAs
    else
      try
        EditWin.Lines.SaveToFile(FileName);
        SetStatus('Saved '+FileName);
      except
        SetStatus('Error saving '+FileName);
      end
  else
  begin
    EditPlugin := TMcpEditPkg(NCPage.McpPlugin.FindPackage('dns-net-beryllium-edit'));
    if EditPlugin.Supported then
      EditPlugin.SaveLines(Self)
    else
      TMcpSimpleEdit(NCPage.McpPlugin.FindPackage('dns-org-mud-moo-simpleedit')).Send(Self);
    SwitchToWorld;
  end;
end;

procedure TEditClientPage.Close;
begin
{ TODO -oMartin -ceditor : ff check toevoegen voor beryllium-edit protocol, bij voortijdig afbreken van laden }
  if NCPage.SimpleEditPlugin.ActivePage<>nil then
    if Application.MessageBox('A verb is still loading, aborting could cause the contents to be dropped in your normal text-window.'#13'Really abort?','Moops!',MB_ICONWARNING+MB_YESNO)=mrNo then Exit;
  NCPage.SimpleEditPlugin.ActivePage:=nil;
  PostMessage(MainForm.Handle,WM_ECCLOSEPAGE,Integer(Self),0);
end;

procedure TEditClientPage.SaveAndClose;
begin
  CloseAfterSave:=True;
  Save;
  if CloseAfterSave and (TextType='file') then Close;
  CloseAfterSave:=False;
end;

procedure TEditClientPage.InitLoading(const VerbName: string);
begin
  if TextType='property' then
    StatusIco:=53
  else if TextType='verb' then
    StatusIco:=54;

  TBeTabControl(MainForm.EditorTabs).UpdateTabImages;
  EditWin.ReadOnly:=True;
  SetStatus('Loading '+VerbName+'...');
end;

procedure TEditClientPage.FinishLoading;
begin
  SetStatus('Ready');
  EditWin.ReadOnly:=False;
end;

procedure TEditClientPage.SheetEnter(Sender: TObject);
begin
  inherited SheetEnter(Sender);
  if EditWin.CanFocus then
    EditWin.SetFocus;
end;

procedure TEditClientPage.SetCaption(const S: string);
begin
  inherited;
  UpdateEditorTabs;
end;

procedure TEditClientPage.UpdateEditorTabs;
begin
  NCPage.UpdateEditorTabs;
end;

constructor TClientPage.Create(AOwner: TComponent; APageList: TList);
begin
  inherited Create(AOwner,APageList);
  StatusBar:=TStatusBar.Create(Self);
  StatusBar.SimplePanel:=True;
  StatusBar.SimpleText:='';
  StatusTxt:='';
  StatusIco:=39;
  CloseLoop:=False;
end;

destructor TClientPage.Destroy;
begin
  inherited Destroy;
end;

procedure TClientPage.StatusChanged;
begin
  MainForm.StatusChanged;
end;

function TClientPage.CanFree: Boolean;
begin
  Result:=True;
end;

procedure TClientPage.SetStatus(const Msg: string);
begin
  {StatusBar.SimpleText:=Msg;}
  StatusTxt:='';
  StatusIco:=39;
  StatusChanged;
  //PageChanged;
end;

procedure TClientPage.UpdateStatus;
begin
end;

procedure TClientPage.PageChanged;
begin
  MainForm.ActivatePage(MainForm.CurPage);
end;

procedure TClientPage.SheetEnter(Sender: TObject);
begin
  if Sender<>nil then PageChanged;
end;

procedure TClientPage.ActivatePage(APage: TClientPage);
begin
  MainForm.ActivatePage(APage);
end;

procedure TClientPage.AddToLog(Msg: string);
begin
  Msg:='['+DateTimeToStr(Now)+'] <'+Caption+'> '+Msg;
  //Dec(TNetClientPage(PageList[0]).ChatView.WordWrap);
  with TNetClientPage(PageList[0]) do
  begin
    AddToChat(#27'[50m'+DoColor(cvAqua,cvNavy)+Msg);
    ChatView.DoColor(cvNormal,cvNormal);
    if fLogFilePlugin<>nil then fLogFilePlugin.SaveLine(ltInfo,Msg);
  end;
  //Inc(TNetClientPage(PageList[0]).ChatView.WordWrap);
end;

constructor TNetClientPage.Create(AOwner: TComponent; APageList: TList; ATabControl: TTabControl);
var
  I: Integer;
begin
  inherited Create(AOwner,APageList);
  FirstTimeLoad:=True;
  fVerboseLog:=False;
  StatusMan:=TStatusManager.Create;
  TabControl:=ATabControl;
  TabControl.Tabs.Add('');
  TabIndex:=TabControl.Tabs.Count-1;
  OwnedPages:=TList.Create;
  ImageIndex:=imgIdle;
  ActiveCount:=0;
  ChatView:=TChatView.Create(Self);
  ChatView.Align:=alClient;
  ChatView.Parent:=Self;
  ChatView.OnLinkClick:=ChatViewLinkClick;
  InputEdit:=TBeMemo.Create(Self);
  InputEdit.Parent:=Self;
  InputEdit.Align:=alBottom;
  InputEdit.OnKeyPress:=InputEditKeyPress;
  InputEdit.OnKeyDown:=InputEditKeyDown;
  //InputEdit.AutoSelect:=False;
  InputEdit.WordWrap:=False;
  InputEdit.ScrollBars:=ssNone;
  InputEdit.WantReturns:=False;
  InputEdit.WantTabs:=False;
  InputEdit.Height:=Round(-InputEdit.Font.Height*1.06)+10;
  InputEdit.Left:=0;
  InputEdit.Top:=ClientHeight-InputEdit.Height;
  InputEdit.Width:=ClientWidth;
  ISplitter:=TSplitter.Create(Self);
  ISplitter.Beveled:=False;
  ISplitter.AutoSnap:=False;
  ISplitter.MinSize:=InputEdit.Height;
  ISplitter.ResizeStyle:=rsPattern;
  ISplitter.Align:=alBottom;
  ISplitter.Left:=InputEdit.Top-1;
  ISplitter.Parent:=Self;
  ISplitter.OnMoved:=ISplitterMoved;
  Commander:=TParser.Create(TCommands.Create(10,10));
  Commander.Commands.EditCommand('about','A',cmHelp,'<any:Subject>: Show help about <Subject>');
  Commander.Commands.EditCommand('help','A',cmHelp,'<any:Subject>: Show help about <Subject>');
  Commander.Commands.EditCommand('quit','',cmQuit,': Quit Moops!');
  Commander.Commands.EditCommand('new','S',cmNew,'<nes:PageCaption>: Open a new page with name <PageCaption>');
  Commander.Commands.EditCommand('connect','SI',cmConnect,'<nes:Host> <int:Port>: Connect to <Host>:<Port>');
  Commander.Commands.EditCommand('waitfor','S',cmWaitFor,'<nes:Trigger>: Wait for <Trigger> to be received');
  Commander.Commands.EditCommand('reconnect','',cmReconnect,': Reconnect to the last server');
  Commander.Commands.EditCommand('disconnect','',cmDisconnect,': Disconnect from current host');
  Commander.Commands.EditCommand('plainlogin','SS',cmPlainLogin,'<nes:User> <nes:PlainPW>: Login using plaintext password');
  Commander.Commands.EditCommand('cryptlogin','SS',cmCryptLogin,'<nes:User> <nes:CruptPW>: Login using encrypted password');
  Commander.Commands.EditCommand('encrypt','S',cmEncrypt,'<nes:PlainPW>: Encrypt a plaintext password');
  Commander.Commands.EditCommand('decrypt','S',cmDecrypt,'<nes:CryptPW>: Decrypt an encrypted password');
  Commander.Commands.EditCommand('leave','',cmLeave,': Disconnect and close current page');
  Commander.Commands.EditCommand('clear','',cmClear,': Clear current window');
  Commander.Commands.EditCommand('addtolog','S',cmAddToLog,'<nes:Msg>: Add <Msg> to the log');
  Commander.Commands.EditCommand('addtochat','S',cmAddToChat,'<nes:Msg>: Add <Msg> to this window');
  Commander.Commands.EditCommand('commandermsg','S',cmCommanderMsg,'<nes:Msg>: Add <Msg> to the commanderlog');
  Commander.Commands.EditCommand('setcaption','S',cmSetCaption,'<nes:PageCaption>: Set the caption of the current page');
  Commander.Commands.EditCommand('setstatus','S',cmSetStatus,'<str:StatusTxt>: Set the text of the statusbar');
  Commander.Commands.EditCommand('in','S',cmIn,'<nes:Msg>: (Debug) Fake incoming message');
  Commander.Commands.EditCommand('out','S',cmOut,'<nes:Msg>: (Debug) Send <Msg> to the server, this way you can also send mcp-commands');
  Commander.Commands.EditCommand('debug-mcp','I',cmDebug_Mcp,'<int:Level>: (Debug) Set mcp-debuglevel (0=off,1=error,2=verbose)');
  Commander.Commands.EditCommand('dump-ml','A',cmDumpML,'<str:DataTag>: (Debug) Dump active multiline, or a list of all is <DataTag>=''''');
  Commander.Commands.EditCommand('exec','S',cmExec,'<nes:FileName>: Execute "<FileName>.msc"');
  Commander.Commands.EditCommand('x','S',cmExec,'<nes:FileName>: Execute "<FileName>.msc"');
  Commander.Commands.EditCommand('delay','I',cmDelay,'<int:MilliSecs>: Sleep during <MilliSecs>');
  Commander.Commands.EditCommand('end','',cmEnd,': Exit the running script');
  Commander.Commands.EditCommand('stop','',cmStop,': Stop current operation / Exit the running script');
  Commander.Commands.EditCommand('chdir','S',cmChDir,'<nes:NewDir>: Change current directory');
  Commander.Commands.EditCommand('pwd','',cmPwd,': Print Working Directory');
  Commander.Commands.EditCommand('e','A',cmEdit,'<any:Verb>: Open editor');
  Commander.Commands.EditCommand('edit','A',cmEdit,'<any:Verb>: Open editor');
  Commander.Commands.EditCommand('ne','A',cmNoteEdit,'<any:Prop>: Open editor');
  Commander.Commands.EditCommand('notedit','A',cmNoteEdit,'<any:Prop>: Open editor');
  Commander.Commands.EditCommand('le','S',cmLocalEdit,'<str:FileName>: Edit the local file <FileName>');
  Commander.Commands.EditCommand('localedit','S',cmLocalEdit,'<str:FileName>: Edit the local file <FileName>');
  Commander.Commands.EditCommand('plugindump','',cmPluginDump,': Show active plugins');
  Commander.Commands.EditCommand('pluginpri','II',cmPluginPri,'<int:PluginNr> <int:NewPri>: Change priority of plugin');
  Commander.Commands.EditCommand('logrotate','S',cmLogRotate,'<nes:FileName>: Rename "<FileName>.log" to "<FileName>.1.log", etc.');
  Commander.Commands.EditCommand('relogin','',cmReLogin,': Reconnect and relogin to the last server');
  Commander.Commands.EditCommand('loadlog','S',cmLoadLog,'<nes:FileName>: Load "<FileName>.log"');
  Commander.Commands.EditCommand('he','',cmHE,': Edit the description of the current location');
  Commander.Commands.EditCommand('me','',cmME,': Edit the description of yourself');
  Commander.Commands.EditCommand('de','A',cmDE,'<nes:Object>: Edit the description of <object>');
  Commander.Commands.EditCommand('loadtheme','S',cmLoadTheme,'<nes:FileName>: Load a theme');
  Commander.Commands.EditCommand('loadsession','S',cmLoadSession,'<nes:FileName>: Load a session (see also ''/startsession'')');
  Commander.Commands.EditCommand('startsession','',cmStartSession,': Start a session (i.e. connect to the world)');
  Commander.Commands.EditCommand('dumpdebug','',cmDumpDebug,': (Debug) For internal use only');
  Commander.Commands.EditCommand('shell','S',cmShell,'<nes:FileName>: Execute an external program');
  Commander.Commands.EditCommand('hoppa','S',cmHoppa,': (Debug) For internal use only');
  Commander.Commands.EditCommand('info','',cmInfo,': Show some info about memory usage etc');
  Commander.Commands.EditCommand('memusage','',cmMemUsage,': (Debug) Show about allocated memory');
  Working:=False;
  InputHist:=TStringList.Create;
  HistLine:=0; InputHist.Add('');
  MaxHist:=500;
  ActMsg:=''; Plugins:=TList.Create;
  McpPlugin:=TMcpPlugin.Create(Self);
  StatusPlugin:=TMcpStatusPkg(McpPlugin.FindPackage('dns-net-beryllium-status'));
  UserlistPlugin:=TMcpVmooUserlistPkg(McpPlugin.FindPackage('dns-com-vmoo-userlist'));
  AddPlugin(Plugins,McpPlugin);
  AddPlugin(Plugins,TTriggerPlugin.Create(Self));
  AddPlugin(Plugins,TDisplayPlugin.Create(Self));
  SimpleEditPlugin:=TSimpleEditPlugin.Create(Self);
  AddPlugin(Plugins,SimpleEditPlugin);
  AddPlugin(Plugins,TActivityPlugin.Create(Self));
  SelectiveHist:=True; SaveHist:=False;
  ScriptEnviron:=nil;
  ScriptEnviron:=NewScriptEnviron('');
  fWaitFor:=''; fWaitForFound:=False;
  fStopped:=False; fLogFilePlugin:=nil;
  fAbortAll:=False;
  StatusBar.SimpleText:='Not connected';
  DefaultStatusTxt:='Not connected';
  for I:=Low(InternalScripts) to High(InternalScripts) do
    InternalScripts[I]:=TStringList.Create;
  fThemeFileName:=''; fSessionFileName:='';
  if TabIndex=0 then
    fSessionDescr:='Statuspage'
  else
    fSessionDescr:='';
  NetClient:=TNetClient.Create(Self,WindowHandle);
  fLogInp:=''; fLogOut:=''; fLogInf:=''; fLogErr:='';
  IdentID:='Anonymous';
  SetDefaultTheme;
  UList:=TListView.Create(Self);
  UList.Visible:=False;
  UList.Width:=100;
  UList.Align:=alRight;
  UList.ViewStyle:=vsList;
  UList.HideSelection:=True;
  UList.ShowColumnHeaders:=False;
  UList.SmallImages:=MainForm.UListImages;
  UList.Parent:=Self;
  UList.Left:=ClientWidth-UList.Width;
  UList.Top:=0;
  UList.Height:=ClientHeight;
  UList.MultiSelect:=False;
  UList.ReadOnly:=True;
  UList.OnContextPopup:=UserListPlugin.ContextPopup;
  USplitter:=TSplitter.Create(Self);
  USplitter.Visible:=False;
  USplitter.Beveled:=False;
  USplitter.MinSize:=40;
  USplitter.ResizeStyle:=rsPattern;
  USplitter.Align:=alRight;
  USplitter.Left:=UList.Left-1;
  USplitter.Parent:=Self;
  with UList.Columns.Add do
  begin
    Caption:='Name';
    AutoSize:=True;
    MinWidth:=16;
  end;
  TMcpVmooClientPkg(McpPlugin.FindPackage('dns-com-vmoo-client')).UpdateLineLength(ChatView.LineLen,ChatView.RowLen);
  NetClient.AuthInfo.AskPW:=False; NetClient.AuthInfo.GotPW:=False;
  UpdateEditorTabs;
end;

procedure TBeMemo.WMPaste(var Msg: TMessage);
var
  I: Integer;
begin
  Prefix:=Copy(Text,1,SelStart);
  PostFix:=Copy(Text,SelStart+1,Length(Text));
  Text:='';
  inherited;
  while (Lines.Count>1) and (Lines[Lines.Count-1]='') do
    Lines.Delete(Lines.Count-1);
  if Lines.Count=1 then begin Text:=Prefix+Text+Postfix; SelStart:=Length(Text)-Length(Postfix); end
  else
  begin
    if (Prefix<>'') and (Prefix[1]='/') then // paste as commands
    begin
      Delete(Prefix,1,1);
      for I:=0 to Lines.Count-1 do
        TNetClientPage(Owner).Translate(Prefix+Lines[I]+Postfix);
    end
    else // paste as normal text to the moo
      for I:=0 to Lines.Count-1 do
        TNetClientPage(Owner).SendLine(Prefix+Lines[I]+Postfix);
    Text:='';
  end;
  Prefix:='';
  Postfix:='';
end;

procedure TNetClientPage.ISplitterMoved(Sender: TObject);
begin
  if InputEdit.Height<ISplitter.MinSize then InputEdit.Height:=ISplitter.MinSize;
  InputEdit.WordWrap:=InputEdit.Height>ISplitter.MinSize;
end;

procedure TNetClientPage.ShowUserList;
begin
  DisableAlign;
  UList.Visible:=True;
  USplitter.Visible:=True;
  EnableAlign;
  TMcpVmooClientPkg(McpPlugin.FindPackage('dns-com-vmoo-client')).UpdateLineLength(ChatView.LineLen,ChatView.RowLen);
end;

procedure TNetClientPage.HideUserList;
begin
  USplitter.Visible:=False;
  UList.Visible:=False;
  TMcpVmooClientPkg(McpPlugin.FindPackage('dns-com-vmoo-client')).UpdateLineLength(ChatView.LineLen,ChatView.RowLen);
end;

destructor TNetClientPage.Destroy;
var
  I: Integer;
begin
  if NetClient.State<>stDisconnected then
    ExecInternalScript('OnDisconnect',InternalScripts[isOnDisconnect]);
  CloseChildren;
  try
    NetClient.Disconnect;
  except
  end;
  try
    NetClient.Free;
  except
  end;
  ExecInternalScript('OnClose',InternalScripts[isOnClose]);
  SaveSession(SessionFileName);
  StopLogging;
  TabControl.Tabs.Delete(TabIndex);
  if TabIndex<>0 then
  begin
    TabControl.TabIndex:=TabIndex-1;
    if Assigned(TabControl.OnChange) then TabControl.OnChange(nil);
  end;
  ChatView.Free;
  InputEdit.Free;
  InputEdit:=nil;
  OwnedPages.Free;
  StatusMan.Free;
  USplitter.Free;
  UList.Free;
  ISplitter.Free;
  Commander.Commands.Free;
  Commander.Free;
  InputHist.Free;
  while Plugins.Count>0 do
  begin
    TBePlugin(Plugins[0]).Free;
    Plugins.Delete(0);
  end;
  Plugins.Free;
  FreeScriptEnviron(ScriptEnviron);
  for I:=Low(InternalScripts) to High(InternalScripts) do
    InternalScripts[I].Free;
  inherited Destroy;
end;

procedure TNetClientPage.NextPage;
var
  I, Index: Integer;
begin
  if MainForm.CurPage=Self then
  begin
    if OwnedPages.Count>0 then ActivatePage(OwnedPages[0]);
    Exit;
  end;
  Index:=-1;
  for I:=0 to OwnedPages.Count-1 do
    if OwnedPages[I]=MainForm.CurPage then begin Index:=I; Break; end;
  if (Index=-1) or (Index=OwnedPages.Count-1) then
    ActivatePage(Self)
  else
    ActivatePage(OwnedPages[Index+1]);
end;

procedure TNetClientPage.PrevPage;
var
  I, Index: Integer;
begin
  if MainForm.CurPage=Self then
  begin
    if OwnedPages.Count>0 then ActivatePage(OwnedPages[OwnedPages.Count-1]);
    Exit;
  end;
  Index:=-1;
  for I:=0 to OwnedPages.Count-1 do
    if OwnedPages[I]=MainForm.CurPage then begin Index:=I; Break; end;
  if (Index=-1) or (Index=0) then
    ActivatePage(Self)
  else
    ActivatePage(OwnedPages[Index-1]);
end;

procedure TNetClientPage.SetCaption(const S: string);
begin
  inherited SetCaption(S);
  TabControl.Tabs[TabIndex]:=S;
  UpdateEditorTabs;

  if NetClient.SessionDescr='' then NetClient.SessionDescr:=S;
end;

procedure TNetClientPage.SetImageIndex(Index: Integer);
begin
  fImageIndex:=Index;
  TBeTabControl(TabControl).UpdateTabImages;
end;

function TNetClientPage.CaptionExists(ACaption: string): Boolean;
begin
  Result:=TabControl.Tabs.IndexOf(ACaption)>-1;
end;

procedure TNetClientPage.DoConnected;
begin
  ChatView.UserActivity;
  ExecInternalScript('OnServerConnected',InternalScripts[isOnServerConnected]);
end;

procedure TNetClientPage.DoDisConnected;
var
  Pri, Dbg: Integer;
begin
  ExecInternalScript('OnServerDisconnected',InternalScripts[isOnServerDisconnected]);
  UList.Items.BeginUpdate; UList.Items.Clear; UList.Items.EndUpdate;
  Plugins.Remove(McpPlugin);
  Pri:=McpPlugin.Priority;
  Dbg:=McpPlugin.DebugMode;
  McpPlugin.Free;
  McpPlugin:=TMcpPlugin.Create(Self);
  McpPlugin.Priority:=Pri;
  McpPlugin.DebugMode:=Dbg;
  StatusPlugin:=TMcpStatusPkg(McpPlugin.FindPackage('dns-net-beryllium-status'));
  UserlistPlugin:=TMcpVmooUserlistPkg(McpPlugin.FindPackage('dns-com-vmoo-userlist'));
  AddPlugin(Plugins,McpPlugin);
  SimpleEditPlugin.ActivePage:=nil;
  UList.OnContextPopup:=UserListPlugin.ContextPopup;
  ActMsg:='';
end;

procedure TNetClientPage.WMNetworkData(var Message: TMessage);
  procedure DoMsg(Msg: string);
  var
    P: Integer;
  begin
    P:=Pos(#13#10,Msg);
    if P>0 then Msg:=Copy(Msg,1,P-1)+' ('+Copy(Msg,P+2,Length(Msg)-P-2)+')';
    CommanderMsg('% '+Msg); AddToLog(Msg); SetStatus(Msg);
  end;
var
  Event: TNetworkEvent;
begin
  while NetClient.GetEvent(Event) do
    case Event.EventType of
      ncRead:         ReceiveLine(Event.EventMsg);
      ncConnecting:   DoMsg('Connecting...');
      ncConnected:    begin DoMsg('Connected'); DoConnected; end;
      ncLoginSent:    begin DoMsg('Login data sent'); ChatView.UserActivity; ExecInternalScript('OnLoginSent',InternalScripts[isOnLoginSent]); end;
      ncDisconnected: begin DoMsg('Disconnected'); DoDisConnected; end;
      ncError:        begin DoMsg('Network '+Event.EventMsg); EndScript; end;
      ncDebug:        DoMsg('Network Debug: '+Event.EventMsg);
    end;
end;

function TNetClientPage.SaveSession(FileName: string): Boolean;
var
  Ini: TIniFile;
begin
  Result:=False;
  if FileName='' then Exit;
  try
    ChDir(AppDir+'Sessions');
    FileName:=ExpandFileName(FileName);
    Ini:=TIniFile.Create(FileName);
  except
    CommanderMsg('SaveSession: Error saving session to '+FileName);
    Exit;
  end;
  try
    Ini.WriteInteger('Layout','InputBarHeight',InputEdit.Height);
    Ini.WriteInteger('Info','TotalSent',NetClient.TotalSent);
    Ini.WriteInteger('Info','TotalRecv',NetClient.TotalRecv);
    Ini.Free;
    Result:=True;
  except
    try
      Ini.Free;
    except
    end;
    CommanderMsg('SaveSession: Error saving session to '+FileName);
    Exit;
  end;
  if SaveHist then
    try
      FileName:=ChangeFileExt(FileName,'.mih');
      InputHist.SaveToFile(FileName);
    except
      CommanderMsg('SaveSession: Error saving inputhistory to '+FileName);
    end;
end;

function TNetClientPage.LoadSession(FileName: string): Boolean;
var
  Ini: TIniFile;
  ACaption, S: string;
  C: Integer;
begin
  Result:=False;
  try
    ChDir(AppDir+'Sessions');
    FileName:=ExpandFileName(FileName);
    if not FileExists(FileName) then Abort;
    Ini:=TIniFile.Create(FileName);
  except
    CommanderMsg('LoadSession: Error opening session '+FileName);
    Exit;
  end;
  try
    fSessionDescr:=Ini.ReadString('Session','Description','session of a user who wasn''t creative enough to think of a nice session-description :)');
    NetClient.SessionDescr:=fSessionDescr;
    ACaption:=Ini.ReadString('Session','PageCaption','Unnamed');
    if ACaption<>Caption then
    begin
      S:=ACaption; C:=1;
      while CaptionExists(S) do
      begin
        S:=ACaption+':'+IntToStr(C); Inc(C);
      end;
      Caption:=S;
      MainForm.UpdateCaption;
    end;

    NetClient.AuthInfo.User:=Ini.ReadString('Account','UserName','');
    NetClient.AuthInfo.AskPW:=Ini.ReadBool('Account','AskPW',False);
    if not NetClient.AuthInfo.AskPW then
      NetClient.AuthInfo.Pass:=StrToPw(Ini.ReadString('Account','Password',''));
    fMooServer:=Ini.ReadString('Account','Server','');
    fMooPort:=Ini.ReadInteger('Account','Port',0);
    IdentID:=Ini.ReadString('Account','IdentID','Anonymous');

    NetClient.Host:=fMooServer;
    NetClient.Port:=fMooPort;
    LoadProxySettings(Ini,NetClient.Proxy);

    ChatView.MaxLines:=Ini.ReadInteger('Buffers','ScreenBuffer',1000);
    ChatView.FollowMode:=TFollowMode(Ini.ReadInteger('Buffers','FollowMode',2));
    MaxHist:=Ini.ReadInteger('Buffers','InputBuffer',500);
    SelectiveHist:=Ini.ReadBool('Buffers','SelectiveHistory',True);
    SaveHist:=Ini.ReadBool('Buffers','SaveHistory',True);

    NetClient.LoginCmd:=Ini.ReadString('Commands','Login','CO %user% %pass%');
    fPasteCmd:=Ini.ReadString('Commands','Paste','@paste');
    fEditCmd:=Ini.ReadString('Commands','Edit','@edit');
    fNotEditCmd:=Ini.ReadString('Commands','NotEdit','@notedit');
    fLineLengthCmd:=Ini.ReadString('Commands','LineLength','@linelength');

    LoadTheme(AppDir+'Themes\'+Ini.ReadString('Themes','FileName',''));

    fLogOut:=Ini.ReadString('Logging','LogOutput','< %text%');
    fLogInp:=Ini.ReadString('Logging','LogInput','> %text%');
    fLogErr:=Ini.ReadString('Logging','LogError','! %text%');
    fLogInf:=Ini.ReadString('Logging','LogInfo','# %text%');
    fVerboseLog:=Ini.ReadBool('Logging','Verbose',False);
    if fLogFilePlugin<>nil then fLogFilePlugin.VerboseLog:=fVerboseLog;

    InternalScripts[0].Text:=DecodeIniVar(Ini.ReadString('Scripting','OnLoad',''));
    InternalScripts[1].Text:=DecodeIniVar(Ini.ReadString('Scripting','OnServerConnected',''));
    InternalScripts[2].Text:=DecodeIniVar(Ini.ReadString('Scripting','OnLoginSent',''));
    InternalScripts[3].Text:=DecodeIniVar(Ini.ReadString('Scripting','OnDisconnect',''));
    InternalScripts[4].Text:=DecodeIniVar(Ini.ReadString('Scripting','OnServerDisconnected',''));
    InternalScripts[5].Text:=DecodeIniVar(Ini.ReadString('Scripting','OnClose',''));

    C:=Ini.ReadInteger('Layout','InputBarHeight',0);
    if C<ISplitter.MinSize then C:=ISplitter.MinSize;
    InputEdit.Height:=C; ISplitterMoved(nil);

    if NetClient.TotalSent=0 then NetClient.TotalSent:=Ini.ReadInteger('Info','TotalSent',0);
    if NetClient.TotalRecv=0 then NetClient.TotalRecv:=Ini.ReadInteger('Info','TotalRecv',0);

    fSessionFileName:=FileName;
    if Ini.ReadBool('Logging','EnableLog',True) then StartLogging
    else StopLogging;
    Ini.Free;
    Result:=True;
  except
    try
      Ini.Free;
    except
    end;
    CommanderMsg('LoadSession: Error loading session from '+FileName);
    Exit;
  end;
  if SaveHist and FirstTimeLoad then
    try
      FileName:=ChangeFileExt(FileName,'.mih');
      InputHist.LoadFromFile(FileName);
      while (InputHist.Count>0) and (InputHist[InputHist.Count-1]='') do
        InputHist.Delete(InputHist.Count-1);
      InputHist.Add('');
      while InputHist.Count>MaxHist do
        InputHist.Delete(0);
      HistLine:=InputHist.Count-1;
    except
    end;
  FirstTimeLoad:=False;
end;

procedure TNetClientPage.StartSession;
begin
  ExecInternalScript('OnLoad',InternalScripts[isOnLoad]);
  Connect;
end;

procedure TNetClientPage.Connect;
begin
  if not NetClient.CanConnect then Exit;

  if TabIndex=0 then
  begin
    CommanderMsg('Sorry, cannot connect to a server on the statuspage...');
    CommanderMsg('To avoid this message, leave the server-field empty in this session.');
    Exit;
  end;

  if NetClient.State=stConnected then begin EndWith('Connect: Already connected.'); Exit; end;
  if NetClient.State=stConnecting then begin EndWith('Connect: Already connecting.'); Exit; end;

  NetClient.AutoLogin:=True;
  NetClient.Connect;
  MainForm.WorldConnect.Update;
end;

procedure TNetClientPage.UpdateTheme;
begin
  LoadTheme(ThemeFileName);
end;

procedure TNetClientPage.UpdateSession;
begin
  LoadSession(SessionFileName);
end;

procedure TNetClientPage.SetDefaultTheme;
var
  I: Integer;
  Msg: TWMSize;
begin
  fThemeFileName:='';
  fThemeDescr:='';
  for I:=0 to 15 do
    ChatView.SetFgColor(I,DefaultColorTable[I]);

  for I:=0 to 15 do
    ChatView.SetBgColor(I,DefaultColorTable[I]);

  ChatView.IndentText:='';
  ChatView.HorizScrollBar:=True;
  ChatView.AutoCopy:=True;
  ChatView.ScrollThrough:=True;

  ChatView.Font.Style:=[];
  ChatView.Font.Name:='Courier';
  ChatView.Font.Size:=10;
  InputEdit.Font.Name:='Courier';
  InputEdit.Font.Size:=10;
  InputEdit.Font.Style:=[];
  ISplitter.MinSize:=Round(-InputEdit.Font.Height*1.06)+10; ISplitterMoved(nil);

  ChatView.AnsiColors:=2;
  InputEdit.Color:=ChatView.BgColorTable[cvBlack];
  InputEdit.Font.Color:=ChatView.FgColorTable[cvGray];
  ChatView.SelectionFg:=cvBlack;
  ChatView.SelectionBg:=cvSilver;
  ChatView.EnableBlink:=True;
  ChatView.EnableBeep:=True;

  ChatView.NormalFg:=cvGray;
  ChatView.NormalFgBold:=cvWhite;
  ChatView.BoldHighColor:=False;
  ChatView.AllHighColors:=0;
  ChatView.SetImage('',0,0);
  ChatView.NormalBg:=cvBlack;
  ChatView.NormalBgBold:=cvSilver;

  ChatView.Invalidate;
  Invalidate;
  WMSize(Msg);
end;

function TNetClientPage.LoadTheme(FileName: string): Boolean;
var
  Ini: TIniFile;
  Msg: TWMSize;
begin
  if (FileName='') or (FileName[Length(FileName)]='\') then begin Result:=True; SetDefaultTheme; Exit; end;
  Result:=False;
  try
    ChDir(AppDir+'Themes');
    FileName:=ExpandFileName(FileName);
    if not FileExists(FileName) then Abort;
    Ini:=TIniFile.Create(FileName);
  except
    CommanderMsg('LoadTheme: Error opening theme '+FileName);
    Exit;
  end;
  try
    fThemeDescr:=Ini.ReadString('Theme','Description','Theme of a user who was too lame to find a nice theme description ;)');

    ChatView.LoadFromIni(Ini);

    InputEdit.Font.Name:=Ini.ReadString('Font','InputFontName','Courier');
    InputEdit.Font.Size:=Ini.ReadInteger('Font','InputFontSize',10);
    if Ini.ReadBool('Font','InputFontBold',False) then
      InputEdit.Font.Style:=[fsBold]
    else
      InputEdit.Font.Style:=[];
    ISplitter.MinSize:=Round(-InputEdit.Font.Height*1.06)+10; ISplitterMoved(nil);

    InputEdit.Color:=ChatView.BgColorTable[Ini.ReadInteger('Color','InputBg',cvBlack)];
    InputEdit.Font.Color:=ChatView.FgColorTable[Ini.ReadInteger('Color','InputFg',cvGray)];

    Ini.Free;
    Result:=True;
    fThemeFileName:=FileName;
    MainForm.UpdateCaption;
  except
    Ini.Free;
    CommanderMsg('LoadTheme: Error loading theme '+FileName);
    Exit;
  end;
  ChatView.Invalidate;
  Invalidate;
  WMSize(Msg);
end;

procedure TNetClientPage.WMEraseBkgnd(var Message: TMessage);
begin
  Message.Result:=1;
end;

procedure TNetClientPage.SheetEnter(Sender: TObject);
begin
  if InputEdit.CanFocus then
    InputEdit.SetFocus;
  if (MainForm<>nil) and (MainForm.NCPage<>Self) then
  begin
    MainForm.NCPage:=Self;
    UpdateEditorTabs;
    UpdateLed;
  end;
  inherited SheetEnter(Sender);
end;

procedure TNetClientPage.UpdateEditorTabs;
var
  I: Integer;
begin
  if (MainForm=nil) or (MainForm.EditorTabs=nil) or (MainForm.NCPage<>Self) then Exit;
  with MainForm.EditorTabs do
  begin
    Tabs.BeginUpdate;
    try
      Tabs.Clear;
      Tabs.Add(Caption);
      for I:=0 to OwnedPages.Count-1 do
        Tabs.Add(TEditClientPage(OwnedPages[I]).Caption);
      Visible:=Tabs.Count>1;
    finally
      Tabs.EndUpdate;
    end;
  end;
end;

procedure TNetClientPage.SetStatus(const Msg: string);
begin
  StatusMan.SetStatus(Msg,0,MoopsIco);
  StatusChanged;
end;

procedure TNetClientPage.UpdateStatus(UpdExpire: Boolean);
begin
  if ChatView.StatusText='' then
    StatusMan.Update(StatusTxt,StatusCmd,StatusIco,UpdExpire)
  else
  begin
    StatusIco:=39;
    StatusTxt:=ChatView.StatusText;
    StatusCmd:=''
  end;
end;

procedure TNetClientPage.UpdateLed;
begin
  if TabIndex=0 then Exit;
  if ImageIndex=imgActive then
  begin
    Dec(ActiveCount);
    if ActiveCount<=0 then
    begin
      ActiveCount:=0;
      if MainForm.CurPage=Self then
        ImageIndex:=imgIdle
      else
        ImageIndex:=imgChanged;
    end;
  end
  else if (ImageIndex=imgChanged) and (MainForm.CurPage=Self) then
    ImageIndex:=imgIdle;
end;

procedure TNetClientPage.CloseChildren;
var
  I{, Index}: Integer;
begin
  for I:=0 to OwnedPages.Count-1 do // Send WM_CLOSEPAGE to all children
    PostMessage(MainForm.Handle,WM_ECCLOSEPAGE,Integer(OwnedPages[I]),0);
  while OwnedPages.Count>0 do Application.ProcessMessages;
{  for I:=0 to PageList.Count-1 do // Send WM_CLOSEPAGE to all children
    if TControl(PageList[I]) is TEditClientPage then
      if TEditClientPage(PageList[I]).NCPage=Self then
        PostMessage(MainForm.Handle,WM_CLOSEPAGE,Integer(PageList[I]),0);
  repeat // Wait for all to close
    Index:=-1;
    for I:=0 to PageList.Count-1 do
      if TComponent(PageList[I]) is TEditClientPage then
        if TEditClientPage(PageList[I]).NCPage=Self then begin Index:=I; Break; end;
    Application.ProcessMessages;
  until Index=-1;}
end;

function TNetClientPage.CanFree: Boolean;
begin
  Result:=ScriptEnviron.Level=0;
end;

procedure TNetClientPage.AddToChat(const Msg: string);
begin
  ChatView.AddLine(Msg);
end;

procedure TNetClientPage.CommanderMsg(const Msg: string);
begin
  Dec(ChatView.WordWrap);
  AddToChat(DoColor(cvYellow,cvNavy)+'> '+Msg);
  Inc(ChatView.WordWrap);
  ChatView.DoColor(cvNormal,cvNormal);
  if fLogFilePlugin<>nil then fLogFilePlugin.SaveLine(ltInfo,Msg);
end;

procedure TNetClientPage.SendLineDirect(const Msg: string);
begin
  if NetClient.Connected then
  begin
    NetworkTraffic(True,TabIndex);
    NetClient.SendText(Msg);
    if fLogFilePlugin<>nil then fLogFilePlugin.SaveLine(ltOutData,Msg);
  end
  else
    EndWith('Send: Not connected ('+Msg+').');
end;

procedure TNetClientPage.SendLine(const Msg: string);
begin
  if (Copy(Msg,1,3)='#$#') or (Copy(Msg,1,3)='#$"') then
    SendLineDirect('#$"'+Msg)
  else
    SendLineDirect(Msg);
end;

procedure TNetClientPage.HandleLines;
var
  P, I: Integer;
  ActLine: string;
begin
  Working:=True;
  repeat  // Split the lines
    P:=Pos(#10,ActMsg);
    if P>0 then
    begin
      ActLine:=Copy(ActMsg,1,P-1);
      if (ActLine<>'') and (ActLine[Length(ActLine)]=#13) then
        Delete(ActLine,Length(ActLine),1);
      ActMsg:=Copy(ActMsg,P+1,Length(ActMsg));
      // Translate one line
      for I:=0 to Plugins.Count-1 do
        if TBePlugin(Plugins[I]).HandleLine(ActLine) then Break;
    end;
  until P=0;
  Working:=False;
end;

procedure TNetClientPage.ReceiveLine(const Msg: string);
begin
  NetworkTraffic(False,TabIndex);
  ActMsg:=ActMsg+Msg;
  if fWaitFor<>'' then
    if Pos(fWaitFor,ActMsg)>0 then
    begin
      fWaitForFound:=True;
      fWaitFor:='';
    end;
  if not Working then HandleLines;
end;

procedure TNetClientPage.HandleInput(const Msg: string);
begin
  if (Msg<>'') and (Msg[1]='/') then
    Translate(Copy(Msg,2,Length(Msg)-1))
  else
    SendLine(Msg);
end;

procedure TNetClientPage.Translate(const Msg: string);
begin
  if ScriptEnviron.Level=0 then fAbortAll:=False;
  fStopped:=False;
  if (Msg='') or (Msg[1]='/') then Exit;
  if not Commander.ParseCommand(Msg) then
  begin
    EndWith('Error: '+ParserErrorLong(Commander.Error));
    case Commander.Error of
      peSyntaxErr, peStrExLn, peNoArgExpd, peTooManyArgs, peArgExpd, peStrExpd, peIntExpd,
      peDblExpd:
        CommanderMsg('Syntax: '+Commander.Commands.GetSyntax(Commander.Commands.Find(Commander.ActComm.Name)));
    else
      CommanderMsg('Syntax: /COMMAND [ARGUMENT1 [ARGUMENT2 [...]]');
      CommanderMsg('- You can quote strings like: ''this is one string''');
      CommanderMsg('- Try "/help commands" for a list of available commands, or "/help script".');
    end;
  end
  else
    Commander.ActComm.Proc;
end;

procedure TNetClientPage.InputEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    Key:=#0;
    AddToHist(InputEdit.Text);
    try
      HandleInput(InputEdit.Text);
    except
    end;
    if InputEdit<>nil then // For Leave
      InputEdit.Text:='';
  end
  else if Key=#27 then
  begin
    InputEdit.Text:='';
    HistLine:=InputHist.Count-1;
    InputHist[HistLine]:='';
    Key:=#0;
  end;
end;

procedure TNetClientPage.InputEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  I: Integer;
  Msg: string;
begin
  ChatView.UserActivity;
  if Key=38 then // ArrowUp
  begin
    Key:=0;
    if HistLine=InputHist.Count-1 then
      InputHist[HistLine]:=InputEdit.Text;
    if SelectiveHist then
    begin
      Msg:=InputHist[InputHist.Count-1];
      for I:=HistLine-1 downto 0 do
        if Copy(InputHist[I],1,Length(Msg))=Msg then
        begin
          HistLine:=I; ShowHist; Exit;
        end;
      Beep; Exit;
    end;
    Dec(HistLine); ShowHist;
  end
  else if Key=40 then // ArrowDn
  begin
    Key:=0;
    if HistLine=InputHist.Count-1 then
      InputHist[HistLine]:=InputEdit.Text;
    if SelectiveHist then
    begin
      Msg:=InputHist[InputHist.Count-1];
      for I:=HistLine+1 to InputHist.Count-1 do
        if Copy(InputHist[I],1,Length(Msg))=Msg then
        begin
          HistLine:=I; ShowHist; Exit;
        end;
      Beep; Exit;
    end;
    Inc(HistLine); ShowHist;
  end
  else if Key=33 then // PageUp
  begin
    ChatView.ScrollPageUp;
    Key:=0;
  end
  else if Key=34 then // PageDn
  begin
    ChatView.ScrollPageDown;
    Key:=0;
  end;
end;

procedure TNetClientPage.AddToHist(const Msg: string);
begin
  InputHist[InputHist.Count-1]:=Msg;
  InputHist.Add('');
  while InputHist.Count>MaxHist do
    InputHist.Delete(0);
  HistLine:=InputHist.Count-1;
end;

procedure TNetClientPage.AddInputKey(K: Char);
begin
  if not InputEdit.Focused then
  begin
    InputEdit.Text:=InputEdit.Text+K;
    if InputEdit.CanFocus then
      InputEdit.SetFocus;
    InputEdit.SelStart:=InputEdit.GetTextLen;
  end;
end;

procedure TNetClientPage.ShowHist;
begin
  if HistLine<0 then begin HistLine:=0; Beep; end
  else if HistLine>InputHist.Count-1 then begin HistLine:=InputHist.Count-1; Beep; end
  else
  begin
    InputEdit.Text:=InputHist[HistLine];
    if InputEdit.CanFocus then
      InputEdit.SetFocus;
    InputEdit.SelStart:=InputEdit.GetTextLen;
  end;
end;

procedure TNetClientPage.EndWith(const Msg: string);
begin
  CommanderMsg(Msg);
  EndScript;
end;

procedure TNetClientPage.EndScript;
begin
  ScriptEnviron.ActLine:=ScriptEnviron.Lines.Count; fStopped:=True;
  if NetClient.State=stConnecting then // connecting
    cmDisconnect;
end;

function TNetClientPage.ScriptEnded: Boolean;
begin
  Result:=((ScriptEnviron.Level>0) and (ScriptEnviron.ActLine>=ScriptEnviron.Lines.Count))
    or fStopped or Application.Terminated or fAbortAll;
end;

function TNetClientPage.NewScriptEnviron(FileName: string): PScriptEnviron;
begin
  GetMem(Result,SizeOf(TScriptEnviron));
  Pointer(Result.FileName):=nil;
  Result.FileName:=FileName;
  Result.Lines:=TStringList.Create;
  if FileName<>'' then Result.Lines.LoadFromFile(FileName);
  Result.ActLine:=0;
  if ScriptEnviron=nil then
    Result.Level:=0
  else
    Result.Level:=ScriptEnviron.Level+1;
end;

procedure TNetClientPage.FreeScriptEnviron(Environ: PScriptEnviron);
begin
  Environ.Lines.Free;
  SetLength(Environ.FileName,0);
  FreeMem(Environ);
end;

procedure TNetClientPage.StartExec(OldEnviron: PScriptEnviron);
begin
  try
    with ScriptEnviron^ do
      while not ScriptEnded do
      begin
        if Lines[ActLine]<>'' then
          HandleInput(Lines[ActLine]);
        Inc(ActLine);
      end;
  finally
    FreeScriptEnviron(ScriptEnviron);
    ScriptEnviron:=OldEnviron;
  end;
end;

procedure TNetClientPage.ExecuteScript(FileName: string);
var
  OldEnviron: PScriptEnviron;
begin
  if ScriptEnviron.Level=0 then
  begin
    ChDir(AppDir);
    fAbortAll:=False;
  end;
  fStopped:=False;
  OldEnviron:=ScriptEnviron;
  try
    try
      ScriptEnviron:=NewScriptEnviron(FileName+'.msc');
    except
      CommanderMsg('Exec: Error opening '+FileName+'.msc'); Exit;
    end;
    StartExec(OldEnviron);
  except
  end;
  if ScriptEnviron.Level=0 then ChDir(AppDir);
end;

procedure TNetClientPage.ExecInternalScript(ScriptName: string; Lines: TStringList);
var
  OldEnviron: PScriptEnviron;
begin
  if Lines.Count=0 then Exit;
  if ScriptEnviron.Level=0 then
  begin
    ChDir(AppDir);
    fAbortAll:=False;
  end;
  fStopped:=False;
  OldEnviron:=ScriptEnviron;
  try
    try
      ScriptEnviron:=NewScriptEnviron('');
      ScriptEnviron.FileName:=ScriptName;
      ScriptEnviron.Lines.AddStrings(Lines);
    except
      CommanderMsg('Exec: Error running '+ScriptName); Exit;
    end;
    StartExec(OldEnviron);
  except
  end;
end;

procedure TNetClientPage.CreatePage(ACaption: string);
var
  CPage: TNetClientPage;
  OldEnviron: PScriptEnviron;
  C: Integer;
  S: string;
begin
  try
    CPage:=TNetClientPage.Create(Parent,PageList,TabControl);
    CPage.McpPlugin.DebugMode:=McpPlugin.DebugMode;
    CPage.PopupMenu:=PopupMenu;
    S:=StringReplace(ACaption,'&','&&',[rfReplaceAll]); C:=1;
    while CaptionExists(S) do
    begin
      S:=ACaption+':'+IntToStr(C); Inc(C);
    end;
    CPage.Caption:=S;
    MainForm.UpdateCaption;
    TabControl.TabIndex:=CPage.TabIndex;
    if Assigned(TabControl.OnChange) then TabControl.OnChange(nil);
    Application.ProcessMessages;
    OldEnviron:=CPage.ScriptEnviron;
    CPage.ScriptEnviron:=CPage.NewScriptEnviron(ScriptEnviron.FileName);
    CPage.ScriptEnviron.ActLine:=ScriptEnviron.ActLine+1;
    CPage.StartExec(OldEnviron);
  except
    on EAbort do ;
    else EndWith('New: Error creating new page');
  end;
  EndScript;
end;

function TNetClientPage.OpenEditor(ACaption: string): TEditClientPage;
var
  C: Integer;
  S: string;
begin
  try
    Result:=TEditClientPage.Create(Self,OwnedPages);
    Result.NCPage:=Self;
    S:=StringReplace(ACaption,'&','&&',[rfReplaceAll]); C:=1;
    while CaptionExists(S) do
    begin
      S:=ACaption+' ('+IntToStr(C)+')'; Inc(C);
    end;
    Result.Caption:=S;
    Result.Parent:=Parent;
    ActivatePage(Result);
  except
    Result:=nil;
    EndWith('OpenEditor: Error creating editor-page');
  end;
end;

procedure TNetClientPage.DoPasteText(const Lines, Command: string);
var
  S: TStringList;
  I: Integer;
  Line: string;
begin
  S:=TStringList.Create;
  S.Text:=Lines;
  try
    if Command<>'' then
      SendLine(Command);
    for I:=0 to S.Count-1 do
    begin
      Line:=S[I];
      if (Copy(Line,1,1)='.') or (LowerCase(Copy(Line,1,6))='@abort') then
        Line:='.'+Line;
      SendLine(Line);
    end;
    SendLine('.');
  finally
    S.Free;
  end;
end;

procedure TNetClientPage.PasteText;
begin
  if Clipboard.HasFormat(CF_TEXT) then
    DoPasteText(ClipBoard.AsText,'@paste')
  else
    CommanderMsg('Nothing to paste');
end;

procedure TNetClientPage.Leave;
begin
  if TabIndex=0 then begin EndWith('Leave: Cannot leave the Status-page'); Exit; end;
  fAbortAll:=True; fStopped:=True; EndScript;
  PostMessage(MainForm.Handle,WM_NCCLOSEPAGE,Integer(Self),0);
end;

procedure TNetClientPage.ChatViewLinkClick(Sender: TObject; LinkData: TLinkData; Button, X, Y: Integer);
  procedure ShowError(const Msg: string);
  begin
    Application.MessageBox(
      PChar('This link is rejected by Moops because of possible dangerous content ('+Msg+')'
            {#10#13'You can disable this error under Global Options.'})
      ,'Moops!',MB_ICONWARNING);
  end;
var
  ErrCode: Integer;
  Msg: string;
begin
  if Button=MK_LBUTTON then
  begin
    if not IsValidURL(LinkData.LinkType,LinkData.LinkData,Msg) then
    begin
      ShowError(Msg);
      Exit;
    end;
    if LinkData.LinkType=1 then // url
    begin
      ErrCode:=ShellExecute(Handle,'open',PChar(LinkData.LinkData),nil,nil,SW_SHOWNORMAL);
      if ErrCode<32 then
        CommanderMsg('Error: cannot execute link (there probably is no application linked to this type of url).');
    end
    else if LinkData.LinkType=2 then // clientcommand
      HandleInput(LinkData.LinkData)
    else if LinkData.LinkType=3 then // general moocommand (look etc)
      SendLine(LinkData.LinkData)
    else if LinkData.LinkType=4 then // custom moocommand
      SendLine(LinkData.LinkData)
  end;
  if Button=MK_RBUTTON then
    PopupMenu.Popup(X,Y);
end;

procedure TNetClientPage.UpdateLineLength;
begin
  fOldLineLen:=ChatView.LineLen;
  if fLineLengthCmd='' then
    CommanderMsg('Cannot update linelength, no command defined.')
  else
    SendLine(fLineLengthCmd+' '+IntToStr(fOldLineLen));
end;

procedure TNetClientPage.WMSize(var Message: TWMSize);
begin
  inherited;
  if (ChatView<>nil) and (ChatView.LineLen<>fOldLineLen) then
  begin
    fOldLineLen:=ChatView.LineLen;
    TMcpVmooClientPkg(McpPlugin.FindPackage('dns-com-vmoo-client')).UpdateLineLength(fOldLineLen,ChatView.RowLen);
//    SendLine(fLineLengthCmd+' '+IntToStr(fOldLineLen));
  end;
end;

function TNetClientPage.GetLogging: Boolean;
begin
  Result:=fLogFilePlugin<>nil;
end;

procedure TNetClientPage.SetLogging(Value: Boolean);
begin
  if Value<>(fLogFilePlugin<>nil) then
    if Value then StartLogging else StopLogging;
end;

function TNetClientPage.GetLoggingInfo: string;
begin
  if fLogFilePlugin=nil then
    Result:='Logging disabled'
  else
    Result:='Logging enabled|Logging to '+fLogFilePlugin.FileName;
end;

function TNetClientPage.GetConnectionInfo: string;
begin
  if NetClient.State=stConnecting then
    Result:='Connecting|Connecting to '+NetClient.Host+':'+IntToStr(NetClient.Port)
  else if NetClient.State=stConnected then
    Result:='Connected|Connected to '+NetClient.Host+':'+IntToStr(NetClient.Port)
  else
    Result:='Disconnected|Not connected'
end;

function TNetClientPage.GetScrollLockInfo: string;
begin
  if ChatView.ScrollLock then
    Result:='Scrolling disabled'
  else
    Result:='Scrolling enabled';
end;

procedure TNetClientPage.cmQuit;
begin
  Application.MainForm.Close;
end;

procedure TNetClientPage.cmIn;
begin
  ReceiveLine(Commander.GetStr(1)+#10);
end;

procedure TNetClientPage.cmOut;
begin
  SendLineDirect(Commander.GetStr(1));
end;

procedure TNetClientPage.cmDebug_Mcp;
begin
  McpPlugin.DebugMode:=Commander.GetInt(1);
end;

procedure TNetClientPage.cmConnect;
begin
  if NetClient.State=stConnected then begin EndWith('Connect: Already connected.'); Exit; end;
  if NetClient.State=stConnecting then begin EndWith('Connect: Already connecting.'); Exit; end;
  if TabIndex=0 then
  begin
    Dec(ScriptEnviron.ActLine);
    CreatePage('Unnamed');
    if ScriptEnviron.Level=0 then
      TNetClientPage(PageList[TabControl.TabIndex]).Translate('connect '+Commander.GetStr(1)+' '+Commander.GetStr(2));
    Exit;
  end;
  NetClient.Host:=Commander.GetStr(1);
  NetClient.Port:=Commander.GetInt(2);
  if NetClient.Host='' then
    begin EndWith('Connect: Specify a hostname.'); Exit; end;
  if NetClient.Port=0 then
    begin EndWith('Connect: Specify a portnumber.'); Exit; end;
  try
    NetClient.AutoLogin:=False;
    NetClient.Connect;
    MainForm.WorldConnect.Update;
    while (not ScriptEnded) and (NetClient.State=stConnecting) do
      Application.ProcessMessages;
    if ScriptEnded or (NetClient.State<>stConnected) then Abort;
  except
    EndWith('Connect: Could not connect to '+Commander.GetStr(1)+':'+Commander.GetStr(2));
  end;
end;

procedure TNetClientPage.cmPlainLogin;
begin
  Application.ProcessMessages;
  if Commander.GetStr(1)='' then begin EndWith('PlainLogin: Specify a playername'); Exit; end;
  if Commander.GetStr(2)='' then begin EndWith('PlainLogin: Specify a plaintext password'); Exit; end;
  NetClient.AuthInfo.User:=Commander.GetStr(1);
  NetClient.AuthInfo.Pass:=Commander.GetStr(2);
  NetClient.AuthInfo.AskPW:=False;
  Sleep(100);
  SendLine('CO '+NetClient.AuthInfo.User+' '+NetClient.AuthInfo.Pass);
  AddToLog('Login data sent...');
  ChatView.UserActivity;
end;

procedure TNetClientPage.cmCryptLogin;
begin
  Application.ProcessMessages;
  if Commander.GetStr(1)='' then begin EndWith('CryptLogin: Specify a playername'); Exit; end;
  if Commander.GetStr(2)='' then begin EndWith('CryptLogin: Specify an encrypted password'); Exit; end;
  NetClient.AuthInfo.User:=Commander.GetStr(1);
  NetClient.AuthInfo.Pass:=StrToPw(Commander.GetStr(2));
  NetClient.AuthInfo.AskPW:=False;
  Sleep(100);
  SendLine('CO '+NetClient.AuthInfo.User+' '+NetClient.AuthInfo.Pass);
  AddToLog('Login data sent...');
  ChatView.UserActivity;
end;

procedure TNetClientPage.cmReconnect;
begin
  if NetClient.State<>stDisconnected then
  begin
    ExecInternalScript('OnDisconnect',InternalScripts[isOnDisconnect]);
    try
      NetClient.Disconnect;
    except
      EndWith('Reconnect: Error disconnecting.');
      Exit;
    end;
  end;
  try
    if not NetClient.CanConnect then begin EndWith('Reconnect: Nothing to reconnect to.'); Exit; end;
    NetClient.AutoLogin:=False;
    NetClient.Connect;
    MainForm.WorldConnect.Update;
    while (not ScriptEnded) and (NetClient.State=stConnecting) do
      Application.ProcessMessages;
    if ScriptEnded or (NetClient.State<>stConnected) then Abort;
  except
    EndWith('Reconnect: Could not connect to '+NetClient.Host+':'+IntToStr(NetClient.Port));
  end;
end;

procedure TNetClientPage.cmDisconnect;
begin
  if NetClient.State=stDisconnected then begin EndWith('Disconnect: Already disconnected.'); Exit; end;
  if NetClient.State=stConnected then
    ExecInternalScript('OnDisconnect',InternalScripts[isOnDisconnect]);
  try
    NetClient.Disconnect;
  except
    EndWith('Disconnect: Error disconnecting.');
  end;
  MainForm.WorldConnect.Update;
end;

procedure TNetClientPage.cmEncrypt;
begin
  if Commander.GetStr(1)='' then begin EndWith('Encrypt: Specify a plaintext password.'); Exit; end;
  CommanderMsg('Encrypt: '+PwToStr(Commander.GetStr(1)));
end;

procedure TNetClientPage.cmDecrypt;
begin
  if Commander.GetStr(1)='' then begin EndWith('Decrypt: Specify an encrypted password.'); Exit; end;
  CommanderMsg('Decrypt: '+StrToPw(Commander.GetStr(1)));
end;

procedure TNetClientPage.cmExec;
begin
  if Commander.GetStr(1)='' then begin EndWith('Exec: Specify a filename.'); Exit; end;
  ExecuteScript(Commander.GetStr(1));
end;

procedure TNetClientPage.cmNew;
begin
  if Commander.GetStr(1)='' then begin EndWith('New: Specify a caption.'); Exit; end;
  CreatePage(Commander.GetStr(1));
end;

procedure TNetClientPage.cmChDir;
var
  S: string;
begin
  //if Commander.GetStr(1)='' then begin EndWith('ChDir: Specify a directory.'); Exit; end;
  S:=Commander.GetStr(1);
  if S='' then S:=AppDir;
  if not SetCurrentDir(S) then
    CommanderMsg('ChDir: Could not change directory to "'+S+'".');
end;

procedure TNetClientPage.cmPwd;
begin
  CommanderMsg('Current directory: '+GetCurrentDir);
end;

procedure TNetClientPage.cmLeave;
begin
  Leave;
end;

procedure TNetClientPage.cmWaitFor;
begin
  if Commander.GetStr(1)='' then begin EndWith('WaitFor: Specify a trigger.'); Exit; end;
  fWaitFor:=Commander.GetStr(1);
  fWaitForFound:=False;
  while (not ScriptEnded) and (not fWaitForFound) do
    Application.ProcessMessages;
end;

procedure TNetClientPage.cmEnd;
begin
  EndScript;
end;

procedure TNetClientPage.cmAddToLog;
begin
  AddToLog(Commander.GetStr(1));
end;

procedure TNetClientPage.cmAddToChat;
begin
  AddToChat(Commander.GetStr(1));
end;

procedure TNetClientPage.cmCommanderMsg;
begin
  CommanderMsg(Commander.GetStr(1));
end;

procedure TNetClientPage.cmSetCaption;
var
  S: string;
begin
  S:=Commander.GetStr(1);
  if S='' then begin EndWith('SetCaption: specify a caption'); Exit; end;
  S:=StringReplace(S,'&','&&',[rfReplaceAll]);
  if S=Caption then
  begin
    CommanderMsg('SetCaption: Caption is already up to date.');
    Exit;
  end;
  if CaptionExists(S) then begin EndWith('SetCaption: Caption already exists'); Exit; end;
  AddToLog('SetCaption: Changed "'+Caption+'" to "'+S+'"');
  Caption:=S; MainForm.UpdateCaption;
end;

procedure TNetClientPage.cmHelp;
begin
  ShowHelp(Self);
end;

procedure TNetClientPage.cmSetStatus;
begin
  SetStatus(Commander.GetStr(1));
  PageChanged;
end;

procedure TNetClientPage.cmClear;
begin
  ChatView.Clear;
end;

procedure TNetClientPage.cmDelay;
begin
  Application.ProcessMessages;
  Sleep(Commander.GetInt(1));
end;

procedure TNetClientPage.cmEdit;
begin
  if not NetClient.Connected then begin EndWith('Edit: Must be connected to edit verbs.'); Exit; end;
  if Commander.GetStr(1)='' then begin EndWith('Edit: Verbname expected'); Exit; end;
  TMcpEditPkg(McpPlugin.FindPackage('dns-net-beryllium-edit')).Load(Commander.GetStr(1),'verb');
end;

procedure TNetClientPage.cmNoteEdit;
begin
  if not NetClient.Connected then begin EndWith('NoteEdit: Must be connected to edit properties.'); Exit; end;
  if Commander.GetStr(1)='' then begin EndWith('NoteEdit: Property-name expected'); Exit; end;
  TMcpEditPkg(McpPlugin.FindPackage('dns-net-beryllium-edit')).Load(Commander.GetStr(1),'property');
end;

procedure TNetClientPage.cmLocalEdit;
var
  S: string;
begin
  S:=Commander.GetStr(1);
  if S='' then S:='unnamed';
  with OpenEditor(S) do
    LoadFromFile(Commander.GetStr(1));
end;

procedure TNetClientPage.cmStop;
begin
  EndScript;
  CommanderMsg('Stopped.');
end;

function TNetClientPage.StartLogging: Boolean;
var
  Temp: TLogFilePlugin;
begin
  if fLogFilePlugin=nil then
  begin
    Temp:=TLogFilePlugin.Create(Self,ppNormal);
    if Temp.OpenFile(ChangeFileExt(ExtractFileName(SessionFileName),'')) then
    begin
      fLogFilePlugin:=Temp;
      AddPlugin(Plugins,fLogFilePlugin);
    end
    else
      Temp.Free;
  end;
  if fLogFilePlugin<>nil then
  begin
    fLogFilePlugin.LogCmd[ltInData]:=fLogInp;
    fLogFilePlugin.LogCmd[ltOutData]:=fLogOut;
    fLogFilePlugin.LogCmd[ltError]:=fLogErr;
    fLogFilePlugin.LogCmd[ltInfo]:=fLogInf;
    fLogFilePlugin.VerboseLog:=fVerboseLog;
  end;
  Result:=fLogFilePlugin<>nil;
end;

procedure TNetClientPage.StopLogging;
begin
  if fLogFilePlugin=nil then Exit;
  Plugins.Remove(fLogFilePlugin);
  fLogFilePlugin.Free;
  fLogFilePlugin:=nil;
end;

procedure TNetClientPage.cmDumpML;
var
  I: Integer;
begin
  CommanderMsg('');
  if Commander.GetStr(1)='' then
  begin
    CommanderMsg('Active multilines initiated by Moops:');
    for I:=0 to McpPlugin.LocalTags.Count-1 do
      CommanderMsg('  <'+McpPlugin.LocalTags[I]+'>');
    CommanderMsg('');
    CommanderMsg('Active multilines initiated by server:');
    for I:=0 to McpPlugin.MultiLines.Count-1 do
      CommanderMsg('  '+McpPlugin.GetDebugMultiLine(I));
  end
  else
    McpPlugin.DumpMultiLine(Commander.GetStr(1));
  CommanderMsg('');
end;

procedure TNetClientPage.cmPluginDump;
var
  I: Integer;
begin
  CommanderMsg('Active plugins:');
  for I:=0 to Plugins.Count-1 do
    with TBePlugin(Plugins[I]) do
      CommanderMsg(' '+IntToStr(I)+': '+PluginName+' (Pri: '+IntToStr(Priority)+')');
end;

procedure TNetClientPage.cmPluginPri;
var
  P: TBePlugin;
  I, Pri: Integer;
begin
  I:=Commander.GetInt(1); Pri:=Commander.GetInt(2);
  if (I<0) or (I>=Plugins.Count) then begin EndWith('PluginPri: Index out of range.'); Exit; end;
  P:=Plugins[I];
  Plugins.Remove(P);
  P.Priority:=Pri;
  AddPlugin(Plugins,P);
end;

procedure TNetClientPage.cmLogRotate;
var
  I: Integer;
  BaseName: string;
begin
  BaseName:=Commander.GetStr(1);
  if BaseName='' then begin EndWith('LogRotate: Specify a filename.'); Exit; end;
  if FileExists(BaseName+'.9.log') then
    if not DeleteFile(BaseName+'.9.log') then
      CommanderMsg('LogRotate: Warning: Error removing '+BaseName+'.9.log');
  for I:=8 downto 1 do
  begin
    if FileExists(BaseName+'.'+IntToStr(I)+'.log') then
      if not RenameFile(BaseName+'.'+IntToStr(I)+'.log',BaseName+'.'+IntToStr(I+1)+'.log') then
        CommanderMsg('LogRotate: Warning: Error renaming '+BaseName+'.'+IntToStr(I)+'.log to '+BaseName+'.'+IntToStr(I+1)+'.log');
  end;
  if FileExists(BaseName+'.log') then
    if not RenameFile(BaseName+'.log',BaseName+'.1.log') then
      CommanderMsg('LogRotate: Warning: Error renaming '+BaseName+'.log to '+BaseName+'.1.log');
end;

procedure TNetClientPage.cmReLogin;
begin
{ TODO -omartin -cclientpage : Reset plugins etc bij connect }
  if NetClient.AuthInfo.User='' then begin EndWith('ReLogin: No user/password to login.'); Exit; end;
  NetClient.AskPWs;
  cmReconnect;
  if ScriptEnded then Exit;
  Sleep(100);
  SendLine('CO '+NetClient.AuthInfo.User+' '+NetClient.AuthInfo.Pass);
  AddToLog('Login data sent...');
  ChatView.UserActivity;
end;

procedure TNetClientPage.DoConnectButton;
begin
  if NetClient.State<>stDisconnected then
    cmDisconnect
  else
    Connect;
end;

procedure TNetClientPage.cmLoadLog;
var
  BaseName: string;
  F: TextFile;
  S: string;
begin
  BaseName:=Commander.GetStr(1);
  if BaseName='' then begin EndWith('LoadLog: Specify a filename.'); Exit; end;
  try
    ChatView.BeginUpdate;
    try
      AssignFile(F,BaseName+'.log');
      Reset(F);
      while not EOF(F) do
      begin
        ReadLn(F,S);
        ChatView.AddLine(S);
      end;
      CloseFile(F);
    except
      try
        CloseFile(F);
      except
      end;
      EndWith('LoadLog: Error opening "'+BaseName+'.log".');
    end;
  finally
    ChatView.EndUpdate;
  end;
end;

procedure TNetClientPage.cmHE;
begin
  if not NetClient.Connected then begin EndWith('NoteEdit: Must be connected to edit properties.'); Exit; end;
  TMcpEditPkg(McpPlugin.FindPackage('dns-net-beryllium-edit')).Load('here.description','property');
end;

procedure TNetClientPage.cmME;
begin
  if not NetClient.Connected then begin EndWith('NoteEdit: Must be connected to edit properties.'); Exit; end;
  TMcpEditPkg(McpPlugin.FindPackage('dns-net-beryllium-edit')).Load('me.description','property');
end;

procedure TNetClientPage.cmDE;
begin
  if not NetClient.Connected then begin EndWith('NoteEdit: Must be connected to edit properties.'); Exit; end;
  if Commander.GetStr(1)='' then begin EndWith('NoteEdit: Object expected'); Exit; end;
  TMcpEditPkg(McpPlugin.FindPackage('dns-net-beryllium-edit')).Load(Commander.GetStr(1)+'.description','property');
end;

procedure TNetClientPage.cmLoadTheme;
var
  BaseName: string;
begin
  BaseName:=Commander.GetStr(1);
  if BaseName='' then begin EndWith('LoadTheme: Specify a filename.'); Exit; end;
  if LoadTheme(BaseName+'.mth') then
    CommanderMsg('Loaded '+fThemeDescr);
end;

procedure TNetClientPage.cmLoadSession;
var
  BaseName: string;
begin
  BaseName:=Commander.GetStr(1);
  if BaseName='' then begin EndWith('LoadSession: Specify a filename.'); Exit; end;
  if LoadSession(BaseName+'.mse') then
  begin
    CommanderMsg('Loaded '+fSessionDescr);
    StartSession;
  end;
end;

procedure TNetClientPage.cmStartSession;
begin
  StartSession;
end;

procedure TNetClientPage.cmDumpDebug;
var
  I: Integer;
begin
  DebugMode:=True;
  CommanderMsg('ClientPages.Count='+IntToStr(MainForm.ClientPages.Count));
  for I:=0 to MainForm.ClientPages.Count-1 do
    CommanderMsg('ClientPages['+IntToStr(I)+']='+TClientPage(MainForm.ClientPages[I]).Caption);
end;

procedure TNetClientPage.cmShell;
var
  S: string;
  ErrCode: Integer;
begin
  S:=Commander.GetStr(1);
  if S='' then begin EndWith('Shell: Specify a filename to execute.'); Exit; end;
  ErrCode:=ShellExecute(Handle,'open',PChar(S),nil,nil,SW_SHOWNORMAL);
  if ErrCode<32 then
    CommanderMsg('Shell: cannot execute '''+S+'''');
end;

procedure TNetClientPage.cmInfo;
var
  C, B: Integer;
begin
  C:=Chatview.ActLineCount;
  B:=Chatview.ActLineBytes;
  CommanderMsg('Beryllium Engineering Moops! '+UpdChecker.ThisVersion);
  CommanderMsg('Info for:                    '+fSessionDescr);
  CommanderMsg('Lines in textbuffer:         '+IntToStr(C));
  CommanderMsg('Bytes in textbuffer:         '+SizeToStr(B));
  CommanderMsg('Lines in inputbuffer:        '+IntToStr(InputHist.Count));
  CommanderMsg('Bytes in inputbuffer:        '+SizeToStr(Length(InputHist.Text)));
  CommanderMsg('Bytes in networkbuffer (in): '+SizeToStr(Length(ActMsg)));
  CommanderMsg('Total bytes received:        '+SizeToStr(NetClient.TotalRecv));
  CommanderMsg('Total bytes sent:            '+SizeToStr(NetClient.TotalSent));
end;

function ItemSortFunc(Item1, Item2: TListItem; ParamSort: Integer): Integer; stdcall;
var
  I1, I2: Integer;
begin
  I1:=Item1.ImageIndex; if I1>3 then I1:=0;
  I2:=Item2.ImageIndex; if I2>3 then I2:=0;
  if I1=1 then I1:=2 else if I1=2 then I1:=1;
  if I2=1 then I2:=2 else if I2=2 then I2:=1;
  if I1>I2 then Result:=1
  else if I1=I2 then Result:=0
  else Result:=-1;
end;

procedure TNetClientPage.cmHoppa;
begin
  Watcher.SwitchBack;
end;

procedure TNetClientPage.cmMemUsage;
begin
  CommanderMsg('Number of allocations: '+IntToStr(AllocMemCount));
  CommanderMsg('Size of allocations:   '+SizeToStr(AllocMemSize));
end;

procedure TNetClientPage.ShowConnInfo;
begin
  cmInfo;
end;

end.
