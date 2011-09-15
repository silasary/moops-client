unit GlobalOptFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, BeChatView, Mask, ToolEdit, RXSpin,
  RxCombos, IniFiles, ImgManager, FileCtrl, Common, ClientPage, Winshoes,
  BeNetwork;

type
  TGlobalOptForm = class(TForm)
    Label1: TLabel;
    Panel_2: TPanel;
    Panel_3: TPanel;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    Panel_4: TPanel;
    PageControl: TPageControl;
    TabCaption: TStaticText;
    CategoryView: TTreeView;
    Image1: TImage;
    TabGeneral: TTabSheet;
    TabStartup: TTabSheet;
    TabConnection: TTabSheet;
    StatusHintBox: TCheckBox;
    VerCheckBox: TCheckBox;
    ShowSessionBox: TCheckBox;
    ProxyLabel1: TLabel;
    ProxyServer: TEdit;
    ProxyLabel2: TLabel;
    ProxyPort: TRxSpinEdit;
    ProxyCmd: TEdit;
    ProxyLabel3: TLabel;
    ProxyNoteLabel: TLabel;
    WinshoeClient1: TWinshoeClient;
    ConnectCombo: TComboBox;
    Label2: TLabel;
    ProxyAuthBox: TCheckBox;
    ProxyLabel4: TLabel;
    ProxyLabel5: TLabel;
    ProxyUser: TEdit;
    ProxyPass: TEdit;
    IdentCheckBox: TCheckBox;
    Label5: TLabel;
    DefIdentEdit: TEdit;
    MvCaptionBox: TCheckBox;
    ProxyAskPwBox: TCheckBox;
    ShowSplashBox: TCheckBox;
    TabEditor: TTabSheet;
    GroupBox1: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    EditorExample: TLabel;
    EditorFontCombo: TFontComboBox;
    EditorSizeEdit: TRxSpinEdit;
    EditorBoldBox: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CategoryViewChange(Sender: TObject; Node: TTreeNode);
    procedure FormShow(Sender: TObject);
    procedure ConnectComboChange(Sender: TObject);
    procedure ProxyAuthBoxClick(Sender: TObject);
    procedure ProxyAuthBoxKeyPress(Sender: TObject; var Key: Char);
    procedure OKButtonClick(Sender: TObject);
    procedure ProxyAskPwBoxClick(Sender: TObject);
    procedure ProxyAskPwBoxKeyPress(Sender: TObject; var Key: Char);
    procedure TabEditorShow(Sender: TObject);
    procedure EditorFontChange(Sender: TObject);
    procedure EditorBoldBoxKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    IniFileName: string;
    function SaveSettings(const FileName: string): Boolean;
    function LoadSettings(const FileName: string): Boolean;
    procedure UpdateEditorFont;
  end;

var
  GlobalOptForm: TGlobalOptForm;

implementation

uses MainFrm, SessionOptFrm, SelectSessionFrm;

{$R *.DFM}

procedure TGlobalOptForm.FormCreate(Sender: TObject);
begin
  Image1.Width:=32;
  Image1.Height:=32;
  Image1.Top:=Panel_3.Height-33;
  CategoryView.FullExpand;
  CategoryView.Selected:=CategoryView.Items[0];
  ConnectCombo.ItemIndex:=0;

  EditorFontCombo.FontName:='Courier';
  EditorSizeEdit.Value:=10;
  EditorBoldBox.Checked:=False;
end;

procedure TGlobalOptForm.CategoryViewChange(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.Selected then
  begin
    PageControl.ActivePageIndex:=Node.AbsoluteIndex;
    TabCaption.Caption:=PageControl.ActivePage.Caption;
  end;
end;

procedure TGlobalOptForm.FormShow(Sender: TObject);
begin
  CategoryView.Selected:=CategoryView.Items[0];
  LoadSettings(AppDir+'Moops.ini');
  ShowSessionBox.Checked:=SelectSessionForm.ShowOnStartupBox.Checked;
end;

procedure TGlobalOptForm.ConnectComboChange(Sender: TObject);
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
  if ConnectCombo.ItemIndex>0 then
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

procedure TGlobalOptForm.ProxyAuthBoxClick(Sender: TObject);
begin
  ConnectComboChange(Sender);
end;

procedure TGlobalOptForm.ProxyAuthBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  ConnectComboChange(Sender);
end;

function TGlobalOptForm.SaveSettings(const FileName: string): Boolean;
var
  Ini: TIniFile;
begin
  Result:=False;
  try
    Ini:=TIniFile.Create(FileName);
  except
    ShowMessage('Error saving settings to '+FileName);
    Exit;
  end;
  try
    Ini.WriteBool('General','StatusHints',StatusHintBox.Checked);
    Ini.WriteBool('General','VersionCheck',VerCheckBox.Checked);
    Ini.WriteBool('General','MoovingCaption',MvCaptionBox.Checked);
    Ini.WriteBool('General','IdentServer',IdentCheckBox.Checked);
    Ini.WriteString('General','DefaultIdent',DefIdentEdit.Text);

    Ini.WriteBool('Startup','ShowSessions',ShowSessionBox.Checked);
    Ini.WriteBool('Startup','ShowSplash',ShowSplashBox.Checked);

    Ini.WriteInteger('Proxy','ConnectionType',ConnectCombo.ItemIndex);
    Ini.WriteString('Proxy','Server',ProxyServer.Text);
    Ini.WriteInteger('Proxy','Port',Round(ProxyPort.Value));
    Ini.WriteString('Proxy','Cmd',ProxyCmd.Text);
    Ini.WriteString('Proxy','User',ProxyUser.Text);
    if ProxyAskPWBox.Checked then ProxyPass.Text:='';
    Ini.WriteString('Proxy','Pass',PwToStr(ProxyPass.Text));
    Ini.WriteBool('Proxy','Auth',ProxyAuthBox.Checked);
    Ini.WriteBool('Proxy','AskPW',ProxyAskPWBox.Checked);

    Ini.WriteString('EditorFont','Name',EditorFontCombo.FontName);
    Ini.WriteInteger('EditorFont','Size',Round(EditorSizeEdit.Value));
    Ini.WriteBool('EditorFont','Bold',EditorBoldBox.Checked);

    MainForm.LoadEditorSettings(Ini);

    IniFileName:=FileName;
    Ini.Free;
    Result:=True;
  except
    Ini.Free;
    ShowMessage('Error saving settings to '+FileName);
    Exit;
  end;
end;

function TGlobalOptForm.LoadSettings(const FileName: string): Boolean;
var
  Ini: TIniFile;
begin
  Result:=False;
  try
    Ini:=TIniFile.Create(FileName);
  except
    ShowMessage('Error loading settings from '+FileName);
    Exit;
  end;
  try
    StatusHintBox.Checked:=Ini.ReadBool('General','StatusHints',True);
    VerCheckBox.Checked:=Ini.ReadBool('General','VersionCheck',True);
    MvCaptionBox.Checked:=Ini.ReadBool('General','MoovingCaption',True);
    IdentCheckBox.Checked:=Ini.ReadBool('General','IdentServer',True);
    DefIdentEdit.Text:=Ini.ReadString('General','DefaultIdent','');

    ShowSessionBox.Checked:=Ini.ReadBool('Startup','ShowSessions',True);
    ShowSplashBox.Checked:=Ini.ReadBool('Startup','ShowSplash',True);

    ConnectCombo.ItemIndex:=Ini.ReadInteger('Proxy','ConnectionType',0);
    ProxyServer.Text:=Ini.ReadString('Proxy','Server','');
    ProxyPort.Value:=Ini.ReadInteger('Proxy','Port',23);
    ProxyCmd.Text:=Ini.ReadString('Proxy','Cmd','c %server% %port%');
    ProxyUser.Text:=Ini.ReadString('Proxy','User','');
    ProxyPass.Text:=StrToPw(Ini.ReadString('Proxy','Pass',''));
    ProxyAuthBox.Checked:=Ini.ReadBool('Proxy','Auth',False);
    ProxyAskPwBox.Checked:=Ini.ReadBool('Proxy','AskPW',False);
    ConnectComboChange(nil);

    EditorFontCombo.FontName:=Ini.ReadString('EditorFont','Name','Courier');
    EditorSizeEdit.Value:=Ini.ReadInteger('EditorFont','Size',10);
    EditorBoldBox.Checked:=Ini.ReadBool('EditorFont','Bold',False);

    IniFilename:=FileName;
    Ini.Free;
    Result:=True;
  except
    Ini.Free;
    ShowMessage('Error loading settings from '+FileName);
    Exit;
  end;
end;

procedure TGlobalOptForm.OKButtonClick(Sender: TObject);
begin
  SaveSettings(AppDir+'Moops.ini');
  MainForm.ShowStatusHints:=StatusHintBox.Checked;
  MainForm.DoVersionCheck:=VerCheckBox.Checked;
  SelectSessionForm.ShowOnStartupBox.Checked:=ShowSessionBox.Checked;
end;

procedure TGlobalOptForm.ProxyAskPwBoxClick(Sender: TObject);
begin
  if ProxyAskPWBox.Checked<>GlobalProxy.AuthInfo.AskPW then
    GlobalProxy.AuthInfo.GotPW:=False;
  ProxyPass.Enabled:=not ProxyAskPWBox.Checked;
  if ProxyAskPWBox.Checked then
    ProxyPass.Color:=clBtnFace
  else
    ProxyPass.Color:=clWindow;
  ProxyLabel5.Enabled:=ProxyPass.Enabled;
end;

procedure TGlobalOptForm.ProxyAskPwBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProxyAskPwBoxClick(Sender);
end;

procedure TGlobalOptForm.UpdateEditorFont;
begin
  EditorExample.Color:=clWhite;
  EditorExample.Font.Color:=clBlack;
  EditorExample.Font.Name:=EditorFontCombo.FontName;
  EditorExample.Font.Size:=Round(EditorSizeEdit.Value);
  if EditorBoldBox.Checked then
    EditorExample.Font.Style:=[fsBold]
  else
    EditorExample.Font.Style:=[];
end;

procedure TGlobalOptForm.TabEditorShow(Sender: TObject);
begin
  UpdateEditorFont;
end;

procedure TGlobalOptForm.EditorFontChange(Sender: TObject);
begin
  UpdateEditorFont;
end;

procedure TGlobalOptForm.EditorBoldBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  UpdateEditorFont;
end;

end.
