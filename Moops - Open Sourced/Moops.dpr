program Moops;

{%ToDo 'Moops.todo'}

uses
  Forms,
  MainFrm in 'MainFrm.pas' {MainForm},
  BePlugin in 'BePlugin.pas',
  StdPlugins in 'StdPlugins.pas',
  Parser in 'Commander\Parser.pas',
  Common in 'Common.pas',
  ClientPage in 'ClientPage.pas',
  McpPlugin in 'McpPlugin.pas',
  MoopsHelp in 'MoopsHelp.pas',
  PasteFrm in 'PasteFrm.pas' {PasteForm},
  BeChatView in 'BeChatView.pas',
  mwMooSyn in 'mwMooSyn.pas',
  ImgManager in 'ImgManager.pas',
  ViewOptFrm in 'ViewOptFrm.pas' {ViewOptForm},
  SessionOptFrm in 'SessionOptFrm.pas' {SessionOptForm},
  SelectSessionFrm in 'SelectSessionFrm.pas' {SelectSessionForm},
  BeNetwork in 'BeNetwork.pas',
  UpdateCheck in 'UpdateCheck.pas',
  RegisterFrm in 'RegisterFrm.pas' {RegisterForm},
  GlobalOptFrm in 'GlobalOptFrm.pas' {GlobalOptForm},
  StatusUnit in 'StatusUnit.pas',
  LinkParser in 'LinkParser.pas',
  AskPWFrm in 'AskPWFrm.pas' {AskPWForm},
  SplashFrm in 'SplashFrm.pas' {SplashForm},
  MoopsDebug in 'MoopsDebug.pas',
  HintWin in 'HintWin.pas',
  WatcherUnit in 'WatcherUnit.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Moops!';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TPasteForm, PasteForm);
  Application.CreateForm(TViewOptForm, ViewOptForm);
  Application.CreateForm(TSessionOptForm, SessionOptForm);
  Application.CreateForm(TSelectSessionForm, SelectSessionForm);
  Application.CreateForm(TRegisterForm, RegisterForm);
  Application.CreateForm(TGlobalOptForm, GlobalOptForm);
  Application.CreateForm(TSplashForm, SplashForm);
  Application.Run;
end.
