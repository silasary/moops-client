unit SessionOptFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, BeChatView, Mask, ToolEdit, RXSpin,
  RxCombos, IniFiles, ImgManager, ViewOptFrm, Common, FileCtrl, Menus, ClientPage,
  BeNetwork;

type
  TScriptArray = array[0..5] of TStringList;

  TSessionOptForm = class(TForm)
    Label1: TLabel;
    Panel_2: TPanel;
    Panel_3: TPanel;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    Panel_4: TPanel;
    PageControl: TPageControl;
    TabCaption: TStaticText;
    CategoryView: TTreeView;
    TabGeneral: TTabSheet;
    TabAccount: TTabSheet;
    TabTheme: TTabSheet;
    TabLog: TTabSheet;
    TabInfo: TTabSheet;
    Label2: TLabel;
    ThemeList: TListBox;
    NewThemeButton: TButton;
    DeleteThemeButton: TButton;
    RefreshThemesButton: TButton;
    EditThemeButton: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ServerEdit: TEdit;
    UserEdit: TEdit;
    PassEdit: TEdit;
    TabProxy: TTabSheet;
    TabCommands: TTabSheet;
    PortEdit: TRxSpinEdit;
    Label9: TLabel;
    Label11: TLabel;
    PasteCmdEdit: TEdit;
    EditCmdEdit: TEdit;
    Label13: TLabel;
    NotEditCmdEdit: TEdit;
    Label12: TLabel;
    EnableLogBox: TCheckBox;
    TabScripts: TTabSheet;
    Label14: TLabel;
    ScriptCombo: TComboBox;
    Label15: TLabel;
    ScriptMemo: TMemo;
    GroupBox1: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    GroupBox2: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    GroupBox3: TGroupBox;
    Label27: TLabel;
    Label35: TLabel;
    FileNameLabel: TLabel;
    SessionDescrEdit: TEdit;
    SaveAsButton: TButton;
    ImportButton: TButton;
    ResetButton: TButton;
    SaveButton: TButton;
    Label5: TLabel;
    TabBuffer: TTabSheet;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    ScreenBufEdit: TRxSpinEdit;
    FollowRadio: TRadioGroup;
    Label16: TLabel;
    GroupBox5: TGroupBox;
    Label10: TLabel;
    InputBufEdit: TRxSpinEdit;
    Label28: TLabel;
    SelHistBox: TCheckBox;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    Label29: TLabel;
    PageCaptionEdit: TEdit;
    Label30: TLabel;
    LineLengthCmdEdit: TEdit;
    LogInpLabel: TLabel;
    LogOutEdit: TEdit;
    LogOutLabel: TLabel;
    LogInpEdit: TEdit;
    LogErrLabel: TLabel;
    LogErrEdit: TEdit;
    LogInfLabel: TLabel;
    LogInfEdit: TEdit;
    LogNoteLabel: TLabel;
    LoginCmdCombo: TComboBox;
    Label31: TLabel;
    Label32: TLabel;
    IdentIDEdit: TEdit;
    Image1: TImage;
    AutoStartBox: TCheckBox;
    VerboseLogBox: TCheckBox;
    Label33: TLabel;
    ConnectCombo: TComboBox;
    ProxyLabel1: TLabel;
    ProxyServer: TEdit;
    ProxyLabel2: TLabel;
    ProxyLabel3: TLabel;
    ProxyAuthBox: TCheckBox;
    ProxyLabel4: TLabel;
    ProxyLabel5: TLabel;
    ProxyNoteLabel: TLabel;
    ProxyPort: TRxSpinEdit;
    ProxyCmd: TEdit;
    ProxyUser: TEdit;
    ProxyPass: TEdit;
    ProxyAskPwBox: TCheckBox;
    AskPWBox: TCheckBox;
    SaveHistBox: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CategoryViewChange(Sender: TObject; Node: TTreeNode);
    //procedure ProxyBoxClick(Sender: TObject);
    procedure RefreshThemesButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NewThemeButtonClick(Sender: TObject);
    procedure EditThemeButtonClick(Sender: TObject);
    procedure ThemeListClick(Sender: TObject);
    procedure DeleteThemeButtonClick(Sender: TObject);
    procedure ThemeListKeyPress(Sender: TObject; var Key: Char);
    procedure ResetButtonClick(Sender: TObject);
    procedure ScriptComboChange(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure SaveAsButtonClick(Sender: TObject);
    procedure ImportButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure EnableLogBoxClick(Sender: TObject);
    procedure ConnectComboChange(Sender: TObject);
    procedure ProxyAuthBoxClick(Sender: TObject);
    procedure ProxyAuthBoxKeyPress(Sender: TObject; var Key: Char);
    procedure ProxyAskPwBoxClick(Sender: TObject);
    procedure ProxyAskPwBoxKeyPress(Sender: TObject; var Key: Char);
    procedure AskPWBoxClick(Sender: TObject);
    procedure AskPWBoxKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Scripts: TScriptArray;
    LastScriptIndex: Integer;
  public
    { Public declarations }
    ThemeNames: TStringList;
    IniFileName: string;
    UpdateMainForm: Boolean;
    ClientPage: TNetClientPage;
    procedure SetDefaults;
    procedure SetDefaultScripts;
    function  SaveSession(const FileName: string): Boolean;
    function  LoadSession(const FileName: string): Boolean;
    function  ImportSession(const FileName: string): Boolean;
    function  FindThemeIndex(FileName: string): Integer;
  end;

var
  SessionOptForm: TSessionOptForm;

function LoadProxySettings(Ini: TIniFile; var Proxy: TProxySettings): Boolean;

implementation

uses MainFrm;

{$R *.DFM}

function LoadProxySettings(Ini: TIniFile; var Proxy: TProxySettings): Boolean;
begin
  Result:=False;
  try
    Proxy.Method:=TConnectionMethod(Ini.ReadInteger('Proxy','ConnectionType',Ord(cmGlobal)));
    Proxy.Server:=Ini.ReadString('Proxy','Server','');
    Proxy.Port:=Ini.ReadInteger('Proxy','Port',23);
    Proxy.Cmd:=Ini.ReadString('Proxy','Cmd','');
    Proxy.AuthInfo.User:=Ini.ReadString('Proxy','User','');
    Proxy.AuthInfo.AskPw:=Ini.ReadBool('Proxy','AskPW',False);
    if not Proxy.AuthInfo.AskPW then
      Proxy.AuthInfo.Pass:=StrToPw(Ini.ReadString('Proxy','Pass',''));
    Proxy.Auth:=Ini.ReadBool('Proxy','Auth',False);
    Result:=True;
  except
  end;
end;

procedure TSessionOptForm.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  Image1.Width:=32;
  Image1.Height:=32;
  Image1.Top:=Panel_3.Height-33;
  LastScriptIndex:=-1;
  ClientPage:=nil;
  UpdateMainForm:=True;
  CategoryView.FullExpand;
  CategoryView.Selected:=CategoryView.Items[1];
  ThemeNames:=TStringList.Create;
  for I:=Low(Scripts) to High(Scripts) do
    Scripts[I]:=TStringList.Create;
  SetDefaults;
end;

procedure TSessionOptForm.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  ThemeNames.Free;
  for I:=Low(Scripts) to High(Scripts) do
    Scripts[I].Free;
end;

procedure TSessionOptForm.SetDefaultScripts;
begin
  Scripts[0].Clear;
  Scripts[0].Add('// This script gets called right after this session is loaded,');
  Scripts[0].Add('// and just before any connections are made.');
  Scripts[0].Add('// Settings like the theme will be applied just before OnLoad.');
  Scripts[1].Clear;
  Scripts[1].Add('// This script gets called right after a connection to the mud');
  Scripts[1].Add('// is established and just before login-data is sent.');
  Scripts[2].Clear;
  Scripts[2].Add('// The login-data is sent and you can send commands like the');
  Scripts[2].Add('// way you would normally type them when you''re logged in.');
  Scripts[3].Clear;
  Scripts[3].Add('// This script is executed when you press the Close button, just');
  Scripts[3].Add('// BEFORE the connection is actually closed. This doesn''t work');
  Scripts[3].Add('// for connections that are closed by the server of course...');
  Scripts[4].Clear;
  Scripts[4].Add('// Use this script to execute commands when the connection is just');
  Scripts[4].Add('// closed.');
  Scripts[5].Clear;
  Scripts[5].Add('// This script is executed when the page is closed.');
end;

procedure TSessionOptForm.SetDefaults;
begin
  IniFilename:='';
  FileNameLabel.Caption:='Unnamed (yet)';
  SessionDescrEdit.Text:='';
  PageCaptionEdit.Text:='';
  AutoStartBox.Checked:=False;

  UserEdit.Text:='guest';
  PassEdit.Text:='';
  ServerEdit.Text:='';
  PortEdit.Value:=1111;
  IdentIDEdit.Text:='Anonymous';
  AskPWBox.Checked:=False;
  AskPWBoxClick(nil);

{  ProxyBox.Checked:=False;
  ProxyBoxClick(nil);}
  ConnectCombo.ItemIndex:=5;
  ProxyServer.Text:='';
  ProxyPort.Value:=23;
  ProxyCmd.Text:='c %server% %port%';
  ProxyAuthBox.Checked:=False;
  ProxyUser.Text:='';
  ProxyPass.Text:='';
  ProxyAskPWBox.Checked:=False;
  ConnectComboChange(nil);

  ScreenBufEdit.Value:=1000;
  FollowRadio.ItemIndex:=2;
  InputBufEdit.Value:=500;
  SelHistBox.Checked:=True;
  SaveHistBox.Checked:=False;

  LoginCmdCombo.Text:='CO %user% %pass%';
  PasteCmdEdit.Text:='@paste';
  EditCmdEdit.Text:='@edit';
  NotEditCmdEdit.Text:='@notedit';
  LineLengthCmdEdit.Text:='@linelength';

  ThemeList.ItemIndex:=0;
  RefreshThemesButton.Click;

  EnableLogBox.Checked:=True;
  LogOutEdit.Text:='< %text%';
  LogInpEdit.Text:='> %text%';
  LogErrEdit.Text:='! %text%';
  LogInfEdit.Text:='# %text%';
  VerboseLogBox.Checked:=False;
  EnableLogBoxClick(nil);

  SetDefaultScripts;
  LastScriptIndex:=-1;
  ScriptCombo.ItemIndex:=0;
  LastScriptIndex:=-1;
  ScriptComboChange(nil);
end;

procedure TSessionOptForm.CategoryViewChange(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.Selected then
  begin
    PageControl.ActivePageIndex:=Node.AbsoluteIndex;
    TabCaption.Caption:=PageControl.ActivePage.Caption;
  end;
end;

procedure TSessionOptForm.RefreshThemesButtonClick(Sender: TObject);
var
  SR: TSearchRec;
  I, OldIndex: Integer;
  Ini: TIniFile;
  BaseName, Txt: string;
  Item: TMenuItem;
begin
  OldIndex:=ThemeList.ItemIndex;
  if OldIndex<0 then OldIndex:=0;
  ThemeList.Items.Clear;
  ThemeList.Items.Add('(No theme)');
  ThemeNames.Clear;
  ThemeNames.Add('');
  BaseName:=AppDir+'Themes\';
  if FindFirst(BaseName+'*.mth',faAnyFile,SR)=0 then
  begin
    ThemeNames.Add(BaseName+SR.Name);
    while FindNext(SR) = 0 do ThemeNames.Add(BaseName+SR.Name);
    FindClose(SR);
  end;
  for I:=1 to ThemeNames.Count-1 do
  begin
    Ini:=TIniFile.Create(ThemeNames[I]);
    try
      Txt:=Ini.ReadString('Theme','Description','');
      if Txt='' then Txt:='(no description)';
      ThemeList.Items.Add(Txt);
    finally
      Ini.Free;
    end;
  end;
  if OldIndex<ThemeList.Items.Count then ThemeList.ItemIndex:=OldIndex;
  ThemeListClick(Sender); // to update the buttons

  if not UpdateMainForm then Exit;
  // now update the menu in MainForm
  with MainForm.ThemesMenu do
  begin
    for I:=Count-1 downto 0 do
      Items[I].Free;
    Item:=TMenuItem.Create(Self);
    Item.Action:=MainForm.ThCurEdit;
    Add(Item);
    Item:=TMenuItem.Create(Self);
    Item.Action:=MainForm.ThNew;
    Add(Item);
    Item:=TMenuItem.Create(Self);
    Item.Caption:='-';
    Add(Item);
  end;
  MainForm.ThemeMenuList.Clear;
  for I:=0 to ThemeList.Items.Count-1 do
  begin
    Item:=TMenuItem.Create(Self);
    Item.Caption:=ThemeList.Items[I];
    Item.OnClick:=MainForm.ThemesMenuItemClick;
    Item.Tag:=I;
    Item.GroupIndex:=1;
    Item.RadioItem:=True;
    MainForm.ThemesMenu.Add(Item);
    MainForm.ThemeMenuList.Add(Item);
  end;
end;

procedure TSessionOptForm.FormShow(Sender: TObject);
begin
  LastScriptIndex:=-1;
  ScriptComboChange(nil);
  CategoryView.Selected:=CategoryView.Items[1];
end;

procedure TSessionOptForm.NewThemeButtonClick(Sender: TObject);
begin
  ViewOptForm.SetDefaults;
  if ViewOptForm.ShowModal=mrOK then
  begin
    RefreshThemesButton.Click;
    ThemeList.ItemIndex:=ThemeList.Items.Count-1;
  end
  else
    RefreshThemesButton.Click;
  ThemeListClick(Sender); // to update the buttons
end;

procedure TSessionOptForm.EditThemeButtonClick(Sender: TObject);
begin
  if ThemeList.ItemIndex<=0 then Exit;
  if ViewOptForm.LoadTheme(ThemeNames[ThemeList.ItemIndex]) then
  begin
    ViewOptForm.ShowModal;
    RefreshThemesButton.Click;
  end;
end;

procedure TSessionOptForm.ThemeListClick(Sender: TObject);
begin
  EditThemeButton.Enabled:=ThemeList.ItemIndex>0;
  DeleteThemeButton.Enabled:=ThemeList.ItemIndex>0;
end;

procedure TSessionOptForm.DeleteThemeButtonClick(Sender: TObject);
begin
  if ThemeList.ItemIndex<=0 then Exit;
  if Application.MessageBox('Are you SURE you want to delete this theme?','Moops!',MB_YESNO+MB_ICONWARNING)=IDYES then
  begin
    if not DeleteFile(ThemeNames[ThemeList.ItemIndex]) then
      Application.MessageBox('Error deleting theme!','Moops!',MB_ICONERROR);
    RefreshThemesButton.Click;
    ThemeList.ItemIndex:=0;
    ThemeListClick(Sender); // to update the buttons
  end;
end;

procedure TSessionOptForm.ThemeListKeyPress(Sender: TObject;
  var Key: Char);
begin
  ThemeListClick(Sender);
end;

procedure TSessionOptForm.ResetButtonClick(Sender: TObject);
begin
  SetDefaults;
end;

procedure TSessionOptForm.ScriptComboChange(Sender: TObject);
begin
  if LastScriptIndex>=0 then
    Scripts[LastScriptIndex].Text:=ScriptMemo.Lines.Text;
  LastScriptIndex:=ScriptCombo.ItemIndex;
  ScriptMemo.Lines.Text:=Scripts[ScriptCombo.ItemIndex].Text;
end;

function TSessionOptForm.SaveSession(const FileName: string): Boolean;
var
  Ini: TIniFile;
  I: Integer;
begin
  Result:=False;
  try
    Ini:=TIniFile.Create(FileName);
  except
    ShowMessage('Error saving session '+FileName);
    Exit;
  end;
  try
    if SessionDescrEdit.Text='' then
      SessionDescrEdit.Text:=ExtractFileName(ChangeFileExt(FileName,''));
    if PageCaptionEdit.Text='' then
      PageCaptionEdit.Text:=ExtractFileName(ChangeFileExt(FileName,''));
    Ini.WriteString('Session','Description',SessionDescrEdit.Text);
    Ini.WriteString('Session','PageCaption',PageCaptionEdit.Text);
    Ini.WriteBool('Session','AutoStart',AutoStartBox.Checked);

    Ini.WriteString('Account','UserName',UserEdit.Text);
    Ini.WriteBool('Account','AskPW',AskPWBox.Checked);
    if AskPWBox.Checked then PassEdit.Text:='';
    Ini.WriteString('Account','Password',PwToStr(PassEdit.Text));
    Ini.WriteString('Account','Server',ServerEdit.Text);
    Ini.WriteInteger('Account','Port',Round(PortEdit.Value));
    Ini.WriteString('Account','IdentID',IdentIDEdit.Text);

    Ini.WriteInteger('Proxy','ConnectionType',ConnectCombo.ItemIndex);
    Ini.WriteString('Proxy','Server',ProxyServer.Text);
    Ini.WriteInteger('Proxy','Port',Round(ProxyPort.Value));
    Ini.WriteString('Proxy','Cmd',ProxyCmd.Text);
    Ini.WriteString('Proxy','User',ProxyUser.Text);
    if ProxyAskPWBox.Checked then ProxyPass.Text:='';
    Ini.WriteString('Proxy','Pass',PwToStr(ProxyPass.Text));
    Ini.WriteBool('Proxy','Auth',ProxyAuthBox.Checked);
    Ini.WriteBool('Proxy','AskPW',ProxyAskPWBox.Checked);

    Ini.WriteInteger('Buffers','ScreenBuffer',Round(ScreenBufEdit.Value));
    Ini.WriteInteger('Buffers','FollowMode',FollowRadio.ItemIndex);
    Ini.WriteInteger('Buffers','InputBuffer',Round(InputBufEdit.Value));
    Ini.WriteBool('Buffers','SelectiveHistory',SelHistBox.Checked);
    Ini.WriteBool('Buffers','SaveHistory',SaveHistBox.Checked);

    Ini.WriteString('Commands','Login',LoginCmdCombo.Text);
    Ini.WriteString('Commands','Paste',PasteCmdEdit.Text);
    Ini.WriteString('Commands','Edit',EditCmdEdit.Text);
    Ini.WriteString('Commands','NotEdit',NotEditCmdEdit.Text);
    Ini.WriteString('Commands','LineLength',LineLengthCmdEdit.Text);

    Ini.WriteString('Themes','FileName',ExtractFileName(ThemeNames[ThemeList.ItemIndex]));

    Ini.WriteBool('Logging','EnableLog',EnableLogBox.Checked);
    Ini.WriteString('Logging','LogOutput',LogOutEdit.Text);
    Ini.WriteString('Logging','LogInput',LogInpEdit.Text);
    Ini.WriteString('Logging','LogError',LogErrEdit.Text);
    Ini.WriteString('Logging','LogInfo',LogInfEdit.Text);
    Ini.WriteBool('Logging','Verbose',VerboseLogBox.Checked);

    ScriptComboChange(nil);
    Ini.WriteString('Scripting','OnLoad',EncodeIniVar(Scripts[0].Text));
    Ini.WriteString('Scripting','OnServerConnected',EncodeIniVar(Scripts[1].Text));
    Ini.WriteString('Scripting','OnLoginSent',EncodeIniVar(Scripts[2].Text));
    Ini.WriteString('Scripting','OnDisconnect',EncodeIniVar(Scripts[3].Text));
    Ini.WriteString('Scripting','OnServerDisconnected',EncodeIniVar(Scripts[4].Text));
    Ini.WriteString('Scripting','OnClose',EncodeIniVar(Scripts[5].Text));

    IniFileName:=FileName;
    FileNameLabel.Caption:=ExtractFileName(FileName);
    Ini.Free;
    Result:=True;
  except
    Ini.Free;
    ShowMessage('Error saving session '+FileName);
    Exit;
  end;
  if ClientPage<>nil then ClientPage.LoadSession(FileName);
  with MainForm do
    for I:=0 to ClientPages.Count-1 do
      if (ClientPages[I]<>ClientPage) and (TComponent(ClientPages[I]) is TNetClientPage) then
        with TNetClientPage(ClientPages[I]) do
          if UpperCase(SessionFileName)=UpperCase(FileName) then
            UpdateSession;
end;

procedure TSessionOptForm.SaveButtonClick(Sender: TObject);
begin
  if IniFileName='' then
    SaveAsButton.Click
  else
    SaveSession(IniFileName);
end;

procedure TSessionOptForm.SaveAsButtonClick(Sender: TObject);
begin
  if not ForceDirectories(AppDir+'Sessions') then
    Application.MessageBox(PChar('Error creating directory "'+AppDir+'Sessions"!'),'Moops!',MB_ICONERROR);
  SaveDialog.InitialDir:=AppDir+'Sessions';
  SaveDialog.FileName:=IniFileName;
  if SaveDialog.Execute then
    SaveSession(SaveDialog.Filename);
end;

function TSessionOptForm.LoadSession(const FileName: string): Boolean;
begin
  RefreshThemesButton.Click;
  if (FileName='') or (FileName[Length(FileName)]='\') then
  begin
    Result:=True;
    SetDefaults;
    Exit;
  end;
  Result:=ImportSession(FileName);
  if Result then
  begin
    IniFilename:=FileName;
    FileNamelabel.Caption:=ExtractFileName(FileName);
  end;
end;

function TSessionOptForm.FindThemeIndex(FileName: string): Integer;
var
  I: Integer;
begin
  Result:=0;
  if FileName='' then Exit
  else
  begin
    FileName:=UpperCase(AppDir+'Themes\'+FileName);
    for I:=1 to ThemeNames.Count-1 do
      if UpperCase(ThemeNames[I])=FileName then
      begin
        Result:=I; Exit;
      end;
  end;
end;

function TSessionOptForm.ImportSession(const FileName: string): Boolean;
var
  Ini: TIniFile;
begin
  Result:=False;
  try
    Ini:=TIniFile.Create(FileName);
  except
    ShowMessage('Error opening session '+FileName);
    Exit;
  end;
  try
    SessionDescrEdit.Text:=Ini.ReadString('Session','Description','');
    PageCaptionEdit.Text:=Ini.ReadString('Session','PageCaption','');
    AutoStartBox.Checked:=Ini.ReadBool('Session','AutoStart',False);

    UserEdit.Text:=Ini.ReadString('Account','UserName','guest');
    PassEdit.Text:=StrToPw(Ini.ReadString('Account','Password',''));
    AskPWBox.Checked:=Ini.ReadBool('Account','AskPW',False);
    ServerEdit.Text:=Ini.ReadString('Account','Server','');
    PortEdit.Value:=Ini.ReadInteger('Account','Port',1111);
    IdentIDEdit.Text:=Ini.ReadString('Account','IdentID','Anonymous');
    AskPWBoxClick(nil);

{    ProxyBox.Checked:=Ini.ReadBool('Proxy','UseProxy',False);
    ProxyServer.Text:=Ini.ReadString('Proxy','Server','');
    ProxyPort.Value:=Ini.ReadInteger('Proxy','Port',23);
    ProxyCmd.Text:=Ini.ReadString('Proxy','Command','c %server% %port%');}
    ConnectCombo.ItemIndex:=Ini.ReadInteger('Proxy','ConnectionType',5);
    ProxyServer.Text:=Ini.ReadString('Proxy','Server','');
    ProxyPort.Value:=Ini.ReadInteger('Proxy','Port',23);
    ProxyCmd.Text:=Ini.ReadString('Proxy','Cmd','c %server% %port%');
    ProxyUser.Text:=Ini.ReadString('Proxy','User','');
    ProxyPass.Text:=StrToPw(Ini.ReadString('Proxy','Pass',''));
    ProxyAuthBox.Checked:=Ini.ReadBool('Proxy','Auth',False);
    ProxyAskPwBox.Checked:=Ini.ReadBool('Proxy','AskPW',False);
    ConnectComboChange(nil);

    ScreenBufEdit.Value:=Ini.ReadInteger('Buffers','ScreenBuffer',1000);
    FollowRadio.ItemIndex:=Ini.ReadInteger('Buffers','FollowMode',2);
    InputBufEdit.Value:=Ini.ReadInteger('Buffers','InputBuffer',500);
    SelHistBox.Checked:=Ini.ReadBool('Buffers','SelectiveHistory',True);
    SaveHistBox.Checked:=Ini.ReadBool('Buffers','SaveHistory',False);

    LoginCmdCombo.Text:=Ini.ReadString('Commands','Login','CO %user% %pass%');
    PasteCmdEdit.Text:=Ini.ReadString('Commands','Paste','@paste');
    EditCmdEdit.Text:=Ini.ReadString('Commands','Edit','@edit');
    NotEditCmdEdit.Text:=Ini.ReadString('Commands','NotEdit','@notedit');
    LineLengthCmdEdit.Text:=Ini.ReadString('Commands','LineLength','@linelength');

    ThemeList.ItemIndex:=FindThemeIndex(Ini.ReadString('Themes','FileName',''));

    EnableLogBox.Checked:=Ini.ReadBool('Logging','EnableLog',True);
    LogOutEdit.Text:=Ini.ReadString('Logging','LogOutput','< %text%');
    LogInpEdit.Text:=Ini.ReadString('Logging','LogInput','> %text%');
    LogErrEdit.Text:=Ini.ReadString('Logging','LogError','! %text%');
    LogInfEdit.Text:=Ini.ReadString('Logging','LogInfo','# %text%');
    VerboseLogBox.Checked:=Ini.ReadBool('Logging','Verbose',False);

    SetDefaultScripts;
    Scripts[0].Text:=DecodeIniVar(Ini.ReadString('Scripting','OnLoad',Scripts[0].Text));
    Scripts[1].Text:=DecodeIniVar(Ini.ReadString('Scripting','OnServerConnected',Scripts[1].Text));
    Scripts[2].Text:=DecodeIniVar(Ini.ReadString('Scripting','OnLoginSent',Scripts[2].Text));
    Scripts[3].Text:=DecodeIniVar(Ini.ReadString('Scripting','OnDisconnect',Scripts[3].Text));
    Scripts[4].Text:=DecodeIniVar(Ini.ReadString('Scripting','OnServerDisconnected',Scripts[4].Text));
    Scripts[5].Text:=DecodeIniVar(Ini.ReadString('Scripting','OnClose',Scripts[5].Text));
    LastScriptIndex:=-1;
    ScriptComboChange(nil);

    Ini.Free;
    Result:=True;
  except
    Ini.Free;
    ShowMessage('Error opening session '+FileName);
    Exit;
  end;
end;

procedure TSessionOptForm.ImportButtonClick(Sender: TObject);
begin
  if not ForceDirectories(AppDir+'Sessions') then
    Application.MessageBox(PChar('Error creating directory "'+AppDir+'Sessions"!'),'Moops!',MB_ICONERROR);
  OpenDialog.InitialDir:=AppDir+'Sessions';
  if OpenDialog.Execute then
    ImportSession(OpenDialog.FileName);
end;

procedure TSessionOptForm.OKButtonClick(Sender: TObject);
begin
  ModalResult:=mrOK;
  if IniFileName='' then
  begin
    SaveAsButton.Click;
    if IniFileName='' then ModalResult:=mrNone; // Error has occured
  end
  else
    if not SaveSession(IniFileName) then ModalResult:=mrNone;
end;

procedure TSessionOptForm.FormHide(Sender: TObject);
begin
  ClientPage:=nil;
end;

procedure TSessionOptForm.EnableLogBoxClick(Sender: TObject);
begin
  if EnableLogBox.Checked then
  begin
    LogInpEdit.Enabled:=True; LogInpEdit.Color:=clWindow;
    LogOutEdit.Enabled:=True; LogOutEdit.Color:=clWindow;
    LogErrEdit.Enabled:=True; LogErrEdit.Color:=clWindow;
    LogInfEdit.Enabled:=True; LogInfEdit.Color:=clWindow;
    LogInpLabel.Enabled:=True;
    LogOutLabel.Enabled:=True;
    LogErrLabel.Enabled:=True;
    LogInfLabel.Enabled:=True;
    LogNoteLabel.Enabled:=True;
    VerboseLogBox.Enabled:=True;
  end
  else
  begin
    LogInpEdit.Enabled:=False; LogInpEdit.Color:=clBtnFace;
    LogOutEdit.Enabled:=False; LogOutEdit.Color:=clBtnFace;
    LogErrEdit.Enabled:=False; LogErrEdit.Color:=clBtnFace;
    LogInfEdit.Enabled:=False; LogInfEdit.Color:=clBtnFace;
    LogInpLabel.Enabled:=False;
    LogOutLabel.Enabled:=False;
    LogErrLabel.Enabled:=False;
    LogInfLabel.Enabled:=False;
    LogNoteLabel.Enabled:=False;
    VerboseLogBox.Enabled:=False;
  end;
end;

procedure TSessionOptForm.ConnectComboChange(Sender: TObject);
begin
  if ConnectCombo.ItemIndex=4 then
  begin
    ProxyCmd.Enabled:=True;
    ProxyCmd.Color:=clWindow;
    ProxyNoteLabel.Visible:=True;
  end
  else
  begin
    ProxyCmd.Enabled:=False;
    ProxyCmd.Color:=clBtnFace;
    ProxyNoteLabel.Visible:=False;
  end;
  if (ConnectCombo.ItemIndex>0) and (ConnectCombo.ItemIndex<5) then
  begin
    ProxyServer.Enabled:=True;
    ProxyServer.Color:=clWindow;
    ProxyPort.Enabled:=True;
    ProxyPort.Color:=clWindow;
  end
  else
  begin
    ProxyServer.Enabled:=False;
    ProxyServer.Color:=clBtnFace;
    ProxyPort.Enabled:=False;
    ProxyPort.Color:=clBtnFace;
  end;
  ProxyAuthBox.Enabled:=ConnectCombo.ItemIndex in [1..4];
  if ProxyAuthBox.Checked and (ConnectCombo.ItemIndex in [1..4]) then
  begin
    ProxyUser.Enabled:=True;
    Proxyuser.Color:=clWindow;
    ProxyAskPWBox.Enabled:=True;
    ProxyAskPWBoxClick(nil);
  end
  else
  begin
    ProxyUser.Enabled:=False;
    ProxyUser.Color:=clBtnFace;
    ProxyAskPWBox.Enabled:=False;
    ProxyPass.Enabled:=False;
    ProxyPass.Color:=clBtnFace;
  end;
  ProxyLabel1.Enabled:=ProxyServer.Enabled;
  ProxyLabel2.Enabled:=ProxyPort.Enabled;
  ProxyLabel3.Enabled:=ProxyCmd.Enabled;
  ProxyLabel4.Enabled:=ProxyUser.Enabled;
  ProxyLabel5.Enabled:=ProxyPass.Enabled;
end;

procedure TSessionOptForm.ProxyAuthBoxClick(Sender: TObject);
begin
  ConnectComboChange(Sender);
end;

procedure TSessionOptForm.ProxyAuthBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  ConnectComboChange(Sender);
end;

procedure TSessionOptForm.ProxyAskPwBoxClick(Sender: TObject);
begin
  if (ClientPage<>nil) and (ClientPage.NetClient.Proxy.AuthInfo.AskPW<>ProxyAskPWBox.Checked) then
    ClientPage.NetClient.Proxy.AuthInfo.GotPW:=False;
  ProxyPass.Enabled:=not ProxyAskPWBox.Checked;
  if ProxyAskPWBox.Checked then
    ProxyPass.Color:=clBtnFace
  else
    ProxyPass.Color:=clWindow;
  ProxyLabel5.Enabled:=ProxyPass.Enabled;
end;

procedure TSessionOptForm.ProxyAskPwBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProxyAskPwBoxClick(Sender);
end;

procedure TSessionOptForm.AskPWBoxClick(Sender: TObject);
begin
  if (ClientPage<>nil) and (ClientPage.NetClient.AuthInfo.AskPW<>AskPWBox.Checked) then
    ClientPage.NetClient.AuthInfo.GotPW:=False;
  PassEdit.Enabled:=not AskPWBox.Checked;
  if AskPWBox.Checked then
    PassEdit.Color:=clBtnFace
  else
    PassEdit.Color:=clWindow;
  Label8.Enabled:=PassEdit.Enabled;
end;

procedure TSessionOptForm.AskPWBoxKeyPress(Sender: TObject; var Key: Char);
begin
  AskPWBoxClick(Sender);
end;
end.