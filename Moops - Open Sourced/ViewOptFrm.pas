unit ViewOptFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, BeChatView, Mask, ToolEdit, RXSpin,
  RxCombos, IniFiles, ImgManager, FileCtrl, Common, ClientPage;

type
  TViewOptForm = class(TForm)
    Label1: TLabel;
    Panel_2: TPanel;
    Panel_3: TPanel;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    Panel_4: TPanel;
    PageControl: TPageControl;
    TabTheme: TTabSheet;
    TabCaption: TStaticText;
    TabColors: TTabSheet;
    TabColorFg: TTabSheet;
    TabBackground: TTabSheet;
    TabWindow: TTabSheet;
    TabExample: TTabSheet;
    Label2: TLabel;
    PanelF0: TPanel;
    PanelF1: TPanel;
    PanelF2: TPanel;
    PanelF3: TPanel;
    PanelF4: TPanel;
    PanelF5: TPanel;
    PanelF6: TPanel;
    PanelF7: TPanel;
    Label10: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label11: TLabel;
    Label3: TLabel;
    PanelF8: TPanel;
    PanelF9: TPanel;
    PanelF10: TPanel;
    PanelF11: TPanel;
    PanelF12: TPanel;
    PanelF13: TPanel;
    PanelF14: TPanel;
    PanelF15: TPanel;
    Label12: TLabel;
    InputEdit: TEdit;
    NoBackRadio: TRadioButton;
    ImgRadio: TRadioButton;
    ImgFileNameCaption: TLabel;
    ImgFileNameEdit: TFilenameEdit;
    StyleCaption: TLabel;
    ImgStyleCombo: TComboBox;
    ImgOpacityLabel: TLabel;
    ImgOpacityEdit: TRxSpinEdit;
    ImgPercentLabel: TLabel;
    TranspRadio: TRadioButton;
    TabFont: TTabSheet;
    GroupBox1: TGroupBox;
    ChatFontCombo: TFontComboBox;
    Label19: TLabel;
    Label20: TLabel;
    ChatSizeEdit: TRxSpinEdit;
    ChatBoldBox: TCheckBox;
    FontInputBox: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    InputFontCombo: TFontComboBox;
    InputSizeEdit: TRxSpinEdit;
    InputBoldBox: TCheckBox;
    IndentBox: TCheckBox;
    IndentEdit: TEdit;
    ChatExample: TLabel;
    InputExample: TLabel;
    ColorDialog: TColorDialog;
    GroupBox3: TGroupBox;
    Label23: TLabel;
    ThemeDescrEdit: TEdit;
    SaveAsButton: TButton;
    ImportButton: TButton;
    ResetButton: TButton;
    ColorsInputBox: TGroupBox;
    Label14: TLabel;
    InputFgCombo: TComboBox;
    Label18: TLabel;
    InputBgCombo: TComboBox;
    AnsiEnableGroup: TRadioGroup;
    SaveButton: TButton;
    TabColorBg: TTabSheet;
    HorScrollBox: TCheckBox;
    ScrollThroughBox: TCheckBox;
    Label24: TLabel;
    Label25: TLabel;
    PanelB0: TPanel;
    PanelB8: TPanel;
    PanelB1: TPanel;
    PanelB2: TPanel;
    PanelB3: TPanel;
    PanelB4: TPanel;
    PanelB5: TPanel;
    PanelB6: TPanel;
    PanelB7: TPanel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    PanelB9: TPanel;
    PanelB10: TPanel;
    PanelB11: TPanel;
    PanelB12: TPanel;
    PanelB13: TPanel;
    PanelB14: TPanel;
    PanelB15: TPanel;
    Label35: TLabel;
    FileNameLabel: TLabel;
    Label36: TLabel;
    NormalFgCombo: TComboBox;
    Label37: TLabel;
    BoldFgCombo: TComboBox;
    AllHighBox: TCheckBox;
    BoldHighBox: TCheckBox;
    Label15: TLabel;
    NormalBgCombo: TComboBox;
    Label17: TLabel;
    BoldBgCombo: TComboBox;
    Label34: TLabel;
    ColorsSelectionBox: TGroupBox;
    Label13: TLabel;
    SelFgCombo: TComboBox;
    Label16: TLabel;
    SelBgCombo: TComboBox;
    AutoCopyBox: TCheckBox;
    TranspOpacityLabel: TLabel;
    TranspOpacityEdit: TRxSpinEdit;
    TranspPercentLabel: TLabel;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    CategoryView: TTreeView;
    AlignBtmBox: TCheckBox;
    GroupBox5: TGroupBox;
    BlinkBox: TCheckBox;
    BeepBox: TCheckBox;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure CategoryViewChange(Sender: TObject; Node: TTreeNode);
    procedure NoBackRadioClick(Sender: TObject);
    procedure ImgRadioClick(Sender: TObject);
    procedure TabExampleShow(Sender: TObject);
    procedure TabFontShow(Sender: TObject);
    procedure ChatFontComboChange(Sender: TObject);
    procedure ChatBoldBoxClick(Sender: TObject);
    procedure ColorValueChange(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure IndentBoxClick(Sender: TObject);
    procedure TranspRadioClick(Sender: TObject);
    procedure TabWindowShow(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure SaveAsButtonClick(Sender: TObject);
    procedure ImportButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure ImgFileNameEditAfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ChatBoldBoxKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    WatcherMode: Boolean;

    ChatView: TChatView;
    IniFileName: string;
    ClientPage: TNetClientPage;
    procedure SetDefaults;
    procedure LoadLines;
    procedure UpdateFont;
    procedure UpdateChatView;
    function  LoadTheme(const FileName: string): Boolean;
    function  ImportTheme(const FileName: string): Boolean;
    function  SaveTheme(const FileName: string): Boolean;
    procedure SetWatcherMode;
    procedure SetNormalMode;
  end;

var
  ViewOptForm: TViewOptForm;

implementation

uses
  MainFrm, SessionOptFrm, WatcherUnit;

{$R *.DFM}

procedure TViewOptForm.FormCreate(Sender: TObject);
begin
  WatcherMode:=False;
  Image1.Width:=32;
  Image1.Height:=32;
  Image1.Top:=Panel_3.Height-33;
  ClientPage:=nil;
  CategoryView.FullExpand;
  CategoryView.Selected:=CategoryView.Items[0];
  InputEdit.Align:=alBottom;
  ChatView:=TChatView.Create(Self);
  ChatView.Parent:=TabExample;
  ChatView.Align:=alClient;
  SetDefaults;
end;

procedure TViewOptForm.SetDefaults;
begin
  if not WatcherMode then
  begin
    IniFilename:='';
    FileNameLabel.Caption:='Unnamed (yet)';
    ThemeDescrEdit.Text:='';

    IndentBox.Checked:=False;
    IndentEdit.Text:='>';
    HorScrollBox.Checked:=True;
    AlignBtmBox.Checked:=False;
    AutoCopyBox.Checked:=True;
    ScrollThroughBox.Checked:=True;
  end;

  ChatFontCombo.FontName:='Courier';
  if not WatcherMode then
    ChatSizeEdit.Value:=10
  else
    ChatSizeEdit.Value:=8;
  ChatBoldBox.Checked:=False;
  InputFontCombo.FontName:='Courier';
  InputSizeEdit.Value:=10;
  InputBoldBox.Checked:=False;

  AnsiEnableGroup.ItemIndex:=0;
  InputFgCombo.ItemIndex:=cvGray;
  InputBgCombo.ItemIndex:=cvBlack;
  SelFgCombo.ItemIndex:=cvBlack;
  SelBgCombo.ItemIndex:=cvSilver;
  BlinkBox.Checked:=True;
  BeepBox.Checked:=True;

  PanelF0.Color:=clBlack;
  PanelF1.Color:=clMaroon;
  PanelF2.Color:=clGreen;
  PanelF3.Color:=clOlive;
  PanelF4.Color:=clNavy;
  PanelF5.Color:=clPurple;
  PanelF6.Color:=clTeal;
  PanelF7.Color:=clGray;
  PanelF8.Color:=clSilver;
  PanelF9.Color:=clRed;
  PanelF10.Color:=clLime;
  PanelF11.Color:=clYellow;
  PanelF12.Color:=clBlue;
  PanelF13.Color:=clFuchsia;
  PanelF14.Color:=clAqua;
  PanelF15.Color:=clWhite;
  NormalFgCombo.ItemIndex:=cvGray;
  BoldFgCombo.ItemIndex:=cvWhite;
  BoldHighBox.Checked:=False;
  AllHighBox.Checked:=False;

  PanelB0.Color:=clBlack;
  PanelB1.Color:=clMaroon;
  PanelB2.Color:=clGreen;
  PanelB3.Color:=clOlive;
  PanelB4.Color:=clNavy;
  PanelB5.Color:=clPurple;
  PanelB6.Color:=clTeal;
  PanelB7.Color:=clGray;
  PanelB8.Color:=clSilver;
  PanelB9.Color:=clRed;
  PanelB10.Color:=clLime;
  PanelB11.Color:=clYellow;
  PanelB12.Color:=clBlue;
  PanelB13.Color:=clFuchsia;
  PanelB14.Color:=clAqua;
  PanelB15.Color:=clWhite;
  NormalBgCombo.ItemIndex:=cvBlack;
  BoldBgCombo.ItemIndex:=cvSilver;

  ImgRadio.Checked:=False;
  TranspRadio.Checked:=False;
  NoBackRadio.Checked:=True;
  NoBackRadio.OnClick(nil);
  ImgFileNameEdit.Text:='';
  ImgStyleCombo.ItemIndex:=imStretch;
  ImgOpacityEdit.Value:=100;
  TranspOpacityEdit.Value:=100;
end;

function TViewOptForm.LoadTheme(const FileName: string): Boolean;
begin
  if (FileName='') or (FileName[Length(FileName)]='\') then
  begin
    Result:=True;
    SetDefaults;
    Exit;
  end;
  Result:=ImportTheme(FileName);
  if Result then
  begin
    IniFilename:=FileName;
    FileNameLabel.Caption:=ExtractFileName(FileName);
  end;
end;

function TViewOptForm.ImportTheme(const FileName: string): Boolean;
var
  Ini: TIniFile;
begin
  Result:=False;
  try
    Ini:=TIniFile.Create(FileName);
  except
    ShowMessage('Error opening theme '+FileName);
    Exit;
  end;
  try
    ThemeDescrEdit.Text:=Ini.ReadString('Theme','Description','');

    if not WatcherMode then
    begin
      IndentBox.Checked:=Ini.ReadBool('Window','IndentLines',False);
      IndentEdit.Text:=DecodeURLVar(Ini.ReadString('Window','IndentText','>'));
      HorScrollBox.Checked:=Ini.ReadBool('Window','HorScrollBar',True);
      AlignBtmBox.Checked:=Ini.ReadBool('Window','AlignToBottom',False);
      AutoCopyBox.Checked:=Ini.ReadBool('Window','AutoCopy',True);
      ScrollThroughBox.Checked:=Ini.ReadBool('Window','ScrollThrough',True);
    end;

    ChatFontCombo.FontName:=Ini.ReadString('Font','TextFontName','Courier');
    ChatSizeEdit.Value:=Ini.ReadInteger('Font','TextFontSize',10);
    ChatBoldBox.Checked:=Ini.ReadBool('Font','TextFontBold',False);
    if not WatcherMode then
    begin
      InputFontCombo.FontName:=Ini.ReadString('Font','InputFontName','Courier');
      InputSizeEdit.Value:=Ini.ReadInteger('Font','InputFontSize',10);
      InputBoldBox.Checked:=Ini.ReadBool('Font','InputFontBold',False);
    end;

    AnsiEnableGroup.ItemIndex:=Ini.ReadInteger('Ansi','AnsiMode',0);
    if not WatcherMode then
    begin
      InputFgCombo.ItemIndex:=Ini.ReadInteger('Color','InputFg',cvGray);
      InputBgCombo.ItemIndex:=Ini.ReadInteger('Color','InputBg',cvBlack);
      SelFgCombo.ItemIndex:=Ini.ReadInteger('Color','SelFg',cvBlack);
      SelBgCombo.ItemIndex:=Ini.ReadInteger('Color','SelBg',cvSilver);
      BeepBox.Checked:=Ini.ReadBool('Ansi','EnableBeep',True);
    end;
    BlinkBox.Checked:=Ini.ReadBool('Ansi','EnableBlink',True);

    PanelF0.Color:=Ini.ReadInteger('FgColor','Black',clBlack);
    PanelF1.Color:=Ini.ReadInteger('FgColor','Maroon',clMaroon);
    PanelF2.Color:=Ini.ReadInteger('FgColor','Green',clGreen);
    PanelF3.Color:=Ini.ReadInteger('FgColor','Olive',clOlive);
    PanelF4.Color:=Ini.ReadInteger('FgColor','Navy',clNavy);
    PanelF5.Color:=Ini.ReadInteger('FgColor','Purple',clPurple);
    PanelF6.Color:=Ini.ReadInteger('FgColor','Teal',clTeal);
    PanelF7.Color:=Ini.ReadInteger('FgColor','Gray',clGray);
    PanelF8.Color:=Ini.ReadInteger('FgColor','Silver',clSilver);
    PanelF9.Color:=Ini.ReadInteger('FgColor','Red',clRed);
    PanelF10.Color:=Ini.ReadInteger('FgColor','Lime',clLime);
    PanelF11.Color:=Ini.ReadInteger('FgColor','Yellow',clYellow);
    PanelF12.Color:=Ini.ReadInteger('FgColor','Blue',clBlue);
    PanelF13.Color:=Ini.ReadInteger('FgColor','Fuchsia',clFuchsia);
    PanelF14.Color:=Ini.ReadInteger('FgColor','Aqua',clAqua);
    PanelF15.Color:=Ini.ReadInteger('FgColor','White',clWhite);
    NormalFgCombo.ItemIndex:=Ini.ReadInteger('FgColor','Normal',cvGray);
    BoldFgCombo.ItemIndex:=Ini.ReadInteger('FgColor','Bold',cvWhite);
    BoldHighBox.Checked:=Ini.ReadBool('FgColor','BoldHigh',False);
    AllHighBox.Checked:=Ini.ReadBool('FgColor','AllHigh',False);

    PanelB0.Color:=Ini.ReadInteger('BgColor','Black',clBlack);
    PanelB1.Color:=Ini.ReadInteger('BgColor','Maroon',clMaroon);
    PanelB2.Color:=Ini.ReadInteger('BgColor','Green',clGreen);
    PanelB3.Color:=Ini.ReadInteger('BgColor','Olive',clOlive);
    PanelB4.Color:=Ini.ReadInteger('BgColor','Navy',clNavy);
    PanelB5.Color:=Ini.ReadInteger('BgColor','Purple',clPurple);
    PanelB6.Color:=Ini.ReadInteger('BgColor','Teal',clTeal);
    PanelB7.Color:=Ini.ReadInteger('BgColor','Gray',clGray);
    PanelB8.Color:=Ini.ReadInteger('BgColor','Silver',clSilver);
    PanelB9.Color:=Ini.ReadInteger('BgColor','Red',clRed);
    PanelB10.Color:=Ini.ReadInteger('BgColor','Lime',clLime);
    PanelB11.Color:=Ini.ReadInteger('BgColor','Yellow',clYellow);
    PanelB12.Color:=Ini.ReadInteger('BgColor','Blue',clBlue);
    PanelB13.Color:=Ini.ReadInteger('BgColor','Fuchsia',clFuchsia);
    PanelB14.Color:=Ini.ReadInteger('BgColor','Aqua',clAqua);
    PanelB15.Color:=Ini.ReadInteger('BgColor','White',clWhite);
    NormalBgCombo.ItemIndex:=Ini.ReadInteger('BgColor','Normal',cvBlack);
    BoldBgCombo.ItemIndex:=Ini.ReadInteger('BgColor','Bold',cvSilver);

    NoBackRadio.Checked:=False;
    ImgRadio.Checked:=False;
    TranspRadio.Checked:=False;
    case Ini.ReadInteger('Background','Type',0) of
      1: begin ImgRadio.Checked:=True; ImgRadio.OnClick(nil); end;
      2: begin TranspRadio.Checked:=True; TranspRadio.OnClick(nil); end;
    else
      NoBackRadio.Checked:=True; NoBackRadio.OnClick(nil);
    end;
    ImgFileNameEdit.Text:=Ini.ReadString('Background','ImgFileName','');
    ImgStyleCombo.ItemIndex:=Ini.ReadInteger('Background','ImgStyle',imStretch);
    ImgOpacityEdit.Value:=Ini.ReadInteger('Background','ImgOpacity',100);
    TranspOpacityEdit.Value:=Ini.ReadInteger('Background','TranspOpacity',100);

    Ini.Free;
    Result:=True;
  except
    Ini.Free;
    ShowMessage('Error opening theme '+FileName);
    Exit;
  end;
end;

function TViewOptForm.SaveTheme(const FileName: string): Boolean;
var
  Ini: TIniFile;
  I: Integer;
begin
  Result:=False;
  try
    Ini:=TIniFile.Create(FileName);
  except
    ShowMessage('Error saving theme '+FileName);
    Exit;
  end;
  try
    if ThemeDescrEdit.Text='' then
      ThemeDescrEdit.Text:=ExtractFileName(FileName);
    Ini.WriteString('Theme','Description',ThemeDescrEdit.Text);

    if not WatcherMode then
    begin
      Ini.WriteBool('Window','IndentLines',IndentBox.Checked);
      Ini.WriteString('Window','IndentText',EncodeURLVar(IndentEdit.Text));
      Ini.WriteBool('Window','HorScrollBar',HorScrollBox.Checked);
      Ini.WriteBool('Window','AlignToBottom',AlignBtmBox.Checked);
      Ini.WriteBool('Window','AutoCopy',AutoCopyBox.Checked);
      Ini.WriteBool('Window','ScrollThrough',ScrollThroughBox.Checked);
    end;

    Ini.WriteString('Font','TextFontName',ChatFontCombo.FontName);
    Ini.WriteInteger('Font','TextFontSize',Round(ChatSizeEdit.Value));
    Ini.WriteBool('Font','TextFontBold',ChatBoldBox.Checked);
    if not WatcherMode then
    begin
      Ini.WriteString('Font','InputFontName',InputFontCombo.FontName);
      Ini.WriteInteger('Font','InputFontSize',Round(InputSizeEdit.Value));
      Ini.WriteBool('Font','InputFontBold',InputBoldBox.Checked);
    end;

    Ini.WriteInteger('Ansi','AnsiMode',AnsiEnableGroup.ItemIndex);
    if not WatcherMode then
    begin
      Ini.WriteInteger('Color','InputFg',InputFgCombo.ItemIndex);
      Ini.WriteInteger('Color','InputBg',InputBgCombo.ItemIndex);
      Ini.WriteInteger('Color','SelFg',SelFgCombo.ItemIndex);
      Ini.WriteInteger('Color','SelBg',SelBgCombo.ItemIndex);
      Ini.WriteBool('Ansi','EnableBeep',BeepBox.Checked);
    end;
    Ini.WriteBool('Ansi','EnableBlink',BlinkBox.Checked);

    Ini.WriteInteger('FgColor','Black',PanelF0.Color);
    Ini.WriteInteger('FgColor','Maroon',PanelF1.Color);
    Ini.WriteInteger('FgColor','Green',PanelF2.Color);
    Ini.WriteInteger('FgColor','Olive',PanelF3.Color);
    Ini.WriteInteger('FgColor','Navy',PanelF4.Color);
    Ini.WriteInteger('FgColor','Purple',PanelF5.Color);
    Ini.WriteInteger('FgColor','Teal',PanelF6.Color);
    Ini.WriteInteger('FgColor','Gray',PanelF7.Color);
    Ini.WriteInteger('FgColor','Silver',PanelF8.Color);
    Ini.WriteInteger('FgColor','Red',PanelF9.Color);
    Ini.WriteInteger('FgColor','Lime',PanelF10.Color);
    Ini.WriteInteger('FgColor','Yellow',PanelF11.Color);
    Ini.WriteInteger('FgColor','Blue',PanelF12.Color);
    Ini.WriteInteger('FgColor','Fuchsia',PanelF13.Color);
    Ini.WriteInteger('FgColor','Aqua',PanelF14.Color);
    Ini.WriteInteger('FgColor','White',PanelF15.Color);
    Ini.WriteInteger('FgColor','Normal',NormalFgCombo.ItemIndex);
    Ini.WriteInteger('FgColor','Bold',BoldFgCombo.ItemIndex);
    Ini.WriteBool('FgColor','BoldHigh',BoldHighBox.Checked);
    Ini.WriteBool('FgColor','AllHigh',AllHighBox.Checked);

    Ini.WriteInteger('BgColor','Black',PanelB0.Color);
    Ini.WriteInteger('BgColor','Maroon',PanelB1.Color);
    Ini.WriteInteger('BgColor','Green',PanelB2.Color);
    Ini.WriteInteger('BgColor','Olive',PanelB3.Color);
    Ini.WriteInteger('BgColor','Navy',PanelB4.Color);
    Ini.WriteInteger('BgColor','Purple',PanelB5.Color);
    Ini.WriteInteger('BgColor','Teal',PanelB6.Color);
    Ini.WriteInteger('BgColor','Gray',PanelB7.Color);
    Ini.WriteInteger('BgColor','Silver',PanelB8.Color);
    Ini.WriteInteger('BgColor','Red',PanelB9.Color);
    Ini.WriteInteger('BgColor','Lime',PanelB10.Color);
    Ini.WriteInteger('BgColor','Yellow',PanelB11.Color);
    Ini.WriteInteger('BgColor','Blue',PanelB12.Color);
    Ini.WriteInteger('BgColor','Fuchsia',PanelB13.Color);
    Ini.WriteInteger('BgColor','Aqua',PanelB14.Color);
    Ini.WriteInteger('BgColor','White',PanelB15.Color);
    Ini.WriteInteger('BgColor','Normal',NormalBgCombo.ItemIndex);
    Ini.WriteInteger('BgColor','Bold',BoldBgCombo.ItemIndex);

    if NoBackRadio.Checked then Ini.WriteInteger('Background','Type',0)
    else if ImgRadio.Checked then Ini.WriteInteger('Background','Type',1)
    else Ini.WriteInteger('Background','Type',2);
    Ini.WriteString('Background','ImgFileName',ImgFileNameEdit.Text);
    Ini.WriteInteger('Background','ImgStyle',ImgStyleCombo.ItemIndex);
    Ini.WriteInteger('Background','ImgOpacity',Round(ImgOpacityEdit.Value));
    Ini.WriteInteger('Background','TranspOpacity',Round(TranspOpacityEdit.Value));

    IniFileName:=FileName;
    FileNameLabel.Caption:=ExtractFileName(FileName);
    Ini.Free;
    Result:=True;
  except
    Ini.Free;
    ShowMessage('Error saving theme '+FileName);
    Exit;
  end;
  SessionOptForm.RefreshThemesButton.Click;
  if ClientPage<>nil then ClientPage.LoadTheme(FileName);
  if WatcherMode then Watcher.LoadTheme;
  with MainForm do
    for I:=0 to ClientPages.Count-1 do
      if (ClientPages[I]<>ClientPage) and (TComponent(ClientPages[I]) is TNetClientPage) then
        with TNetClientPage(ClientPages[I]) do
          if UpperCase(ThemeFileName)=UpperCase(FileName) then
            UpdateTheme;
end;

procedure TViewOptForm.CategoryViewChange(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.Selected then
  begin
    PageControl.ActivePageIndex:=Node.AbsoluteIndex;
    TabCaption.Caption:=PageControl.ActivePage.Caption;
  end;
end;

procedure TViewOptForm.NoBackRadioClick(Sender: TObject);
begin
  ImgFileNameCaption.Enabled:=False;
  StyleCaption.Enabled:=False;
  ImgFileNameEdit.Enabled:=False;
  ImgFileNameEdit.Color:=clBtnFace;
  ImgStyleCombo.Enabled:=False;
  ImgStyleCombo.Color:=clBtnFace;
  ImgOpacityLabel.Enabled:=False;
  ImgOpacityEdit.Enabled:=False;
  ImgOpacityEdit.Color:=clBtnFace;
  ImgPercentLabel.Enabled:=False;
  TranspOpacityLabel.Enabled:=False;
  TranspOpacityEdit.Enabled:=False;
  TranspOpacityEdit.Color:=clBtnFace;
  TranspPercentLabel.Enabled:=False;
end;

procedure TViewOptForm.ImgRadioClick(Sender: TObject);
begin
  ImgFileNameCaption.Enabled:=True;
  StyleCaption.Enabled:=True;
  ImgFileNameEdit.Enabled:=True;
  ImgFileNameEdit.Color:=clWindow;
  ImgStyleCombo.Enabled:=True;
  ImgStyleCombo.Color:=clWindow;
  ImgOpacityLabel.Enabled:=True;
  ImgOpacityEdit.Enabled:=True;
  ImgOpacityEdit.Color:=clWindow;
  ImgPercentLabel.Enabled:=True;
  TranspOpacityLabel.Enabled:=False;
  TranspOpacityEdit.Enabled:=False;
  TranspOpacityEdit.Color:=clBtnFace;
  TranspPercentLabel.Enabled:=False;
end;

procedure TViewOptForm.TranspRadioClick(Sender: TObject);
begin
  ImgFileNameCaption.Enabled:=False;
  StyleCaption.Enabled:=False;
  ImgFileNameEdit.Enabled:=False;
  ImgFileNameEdit.Color:=clBtnFace;
  ImgStyleCombo.Enabled:=False;
  ImgStyleCombo.Color:=clBtnFace;
  ImgOpacityLabel.Enabled:=False;
  ImgOpacityEdit.Enabled:=False;
  ImgOpacityEdit.Color:=clBtnFace;
  ImgPercentLabel.Enabled:=False;
  TranspOpacityLabel.Enabled:=True;
  TranspOpacityEdit.Enabled:=True;
  TranspOpacityEdit.Color:=clWindow;
  TranspPercentLabel.Enabled:=True;
end;

procedure TViewOptForm.TabExampleShow(Sender: TObject);
begin
  UpdateChatView;
end;

procedure TViewOptForm.UpdateChatView;
begin
  ChatView.SetFgColor(0,PanelF0.Color);   ChatView.SetFgColor(1,PanelF1.Color);
  ChatView.SetFgColor(2,PanelF2.Color);   ChatView.SetFgColor(3,PanelF3.Color);
  ChatView.SetFgColor(4,PanelF4.Color);   ChatView.SetFgColor(5,PanelF5.Color);
  ChatView.SetFgColor(6,PanelF6.Color);   ChatView.SetFgColor(7,PanelF7.Color);
  ChatView.SetFgColor(8,PanelF8.Color);   ChatView.SetFgColor(9,PanelF9.Color);
  ChatView.SetFgColor(10,PanelF10.Color); ChatView.SetFgColor(11,PanelF11.Color);
  ChatView.SetFgColor(12,PanelF12.Color); ChatView.SetFgColor(13,PanelF13.Color);
  ChatView.SetFgColor(14,PanelF14.Color); ChatView.SetFgColor(15,PanelF15.Color);
  ChatView.SetBgColor(0,PanelB0.Color);   ChatView.SetBgColor(1,PanelB1.Color);
  ChatView.SetBgColor(2,PanelB2.Color);   ChatView.SetBgColor(3,PanelB3.Color);
  ChatView.SetBgColor(4,PanelB4.Color);   ChatView.SetBgColor(5,PanelB5.Color);
  ChatView.SetBgColor(6,PanelB6.Color);   ChatView.SetBgColor(7,PanelB7.Color);
  ChatView.SetBgColor(8,PanelB8.Color);   ChatView.SetBgColor(9,PanelB9.Color);
  ChatView.SetBgColor(10,PanelB10.Color); ChatView.SetBgColor(11,PanelB11.Color);
  ChatView.SetBgColor(12,PanelB12.Color); ChatView.SetBgColor(13,PanelB13.Color);
  ChatView.SetBgColor(14,PanelB14.Color); ChatView.SetBgColor(15,PanelB15.Color);
  ChatView.NormalFg:=NormalFgCombo.ItemIndex;
  ChatView.NormalBg:=NormalBgCombo.ItemIndex;
  ChatView.NormalFgBold:=BoldFgCombo.ItemIndex;
  ChatView.NormalBgBold:=BoldBgCombo.ItemIndex;
  ChatView.SelectionFg:=SelFgCombo.ItemIndex;
  ChatView.SelectionBg:=SelBgCombo.ItemIndex;
  ChatView.UseBoldFont:=ChatBoldBox.Checked;
  ChatView.BoldHighColor:=BoldHighBox.Checked;
  ChatView.HorizScrollBar:=HorScrollBox.Checked;
  ChatView.AutoCopy:=AutoCopyBox.Checked;
  ChatView.ScrollThrough:=ScrollThroughBox.Checked;
  if ImgRadio.Checked then
    ChatView.SetImage(ImgFileNameEdit.Text,ImgStyleCombo.ItemIndex,Round(ImgOpacityEdit.Value))
  else
    ChatView.SetImage('',0,0);
  ChatView.AnsiColors:=2-AnsiEnableGroup.ItemIndex;
  if AllHighBox.Checked then
    ChatView.AllHighColors:=8
  else
    ChatView.AllHighColors:=0;
  if IndentBox.Checked then
    ChatView.IndentText:=IndentEdit.Text
  else
    ChatView.IndentText:='';
  UpdateFont;
  ChatView.Font.Assign(ChatExample.Font);
  InputEdit.Font.Assign(InputExample.Font);
  InputEdit.Color:=InputExample.Color;
  LoadLines;
end;

procedure TViewOptForm.LoadLines;
var
  I: Integer;
begin
  ChatView.BeginUpdate;
  ChatView.Clear;
  for I:=0 to 15 do
//    if I<>ChatView.NormalBg then
      ChatView.AddLine(DoColor(I,cvNormal)+NormalFgCombo.Items[I]);
  ChatView.AddLine(DoColor(cvNormal,cvNormal)+'And this is a line that should be long enough to test the wordwrap capabilities of the component');
  ChatView.EndUpdate;
end;

procedure TViewOptForm.UpdateFont;
begin
  ChatExample.Color:=ChatView.BgColorTable[ChatView.NormalBg];
  ChatExample.Font.Color:=ChatView.FgColorTable[ChatView.NormalFg];
  ChatExample.Font.Name:=ChatFontCombo.FontName;
  ChatExample.Font.Size:=Round(ChatSizeEdit.Value);
  if ChatBoldBox.Checked then
    ChatExample.Font.Style:=[fsBold]
  else
    ChatExample.Font.Style:=[];
  InputExample.Color:=ChatView.BgColorTable[InputBgCombo.ItemIndex];
  InputExample.Font.Color:=ChatView.FgColorTable[InputFgCombo.ItemIndex];
  InputExample.Font.Name:=InputFontCombo.FontName;
  InputExample.Font.Size:=Round(InputSizeEdit.Value);
  if InputBoldBox.Checked then
    InputExample.Font.Style:=[fsBold]
  else
    InputExample.Font.Style:=[];
end;

procedure TViewOptForm.TabFontShow(Sender: TObject);
begin
  UpdateFont;
end;

procedure TViewOptForm.ChatFontComboChange(Sender: TObject);
begin
  UpdateFont;
end;

procedure TViewOptForm.ChatBoldBoxClick(Sender: TObject);
begin
  UpdateFont;
end;

procedure TViewOptForm.ColorValueChange(Sender: TObject);
begin
  if Sender is TPanel then
    with Sender as TPanel do
    begin
      ColorDialog.Color:=Color;
      if ColorDialog.Execute then
        Color:=ColorDialog.Color;
    end;
end;

procedure TViewOptForm.ResetButtonClick(Sender: TObject);
begin
  SetDefaults;
end;

procedure TViewOptForm.IndentBoxClick(Sender: TObject);
begin
  IndentEdit.Enabled:=IndentBox.Checked;
  if IndentEdit.Enabled then
    IndentEdit.Color:=clWindow
  else
    IndentEdit.Color:=clBtnFace;
end;

procedure TViewOptForm.TabWindowShow(Sender: TObject);
begin
  IndentBoxClick(Sender);
end;

procedure TViewOptForm.SaveButtonClick(Sender: TObject);
begin
  if (IniFileName<>'') and (IniFileName[Length(IniFileName)]='\') then IniFileName:='';
  if IniFileName='' then
    SaveAsButton.Click
  else
    SaveTheme(IniFileName);
end;

procedure TViewOptForm.SaveAsButtonClick(Sender: TObject);
begin
  if (IniFileName<>'') and (IniFileName[Length(IniFileName)]='\') then IniFileName:='';
  if not ForceDirectories(AppDir+'Themes') then
    Application.MessageBox(PChar('Error creating directory "'+AppDir+'Themes"!'),'Moops!',MB_ICONERROR);
  SaveDialog.InitialDir:=AppDir+'Themes';
  SaveDialog.FileName:=IniFileName;
  if SaveDialog.Execute then
    SaveTheme(SaveDialog.Filename);
end;

procedure TViewOptForm.ImportButtonClick(Sender: TObject);
begin
  if not ForceDirectories(AppDir+'Themes') then
    Application.MessageBox(PChar('Error creating directory "'+AppDir+'Themes"!'),'Moops!',MB_ICONERROR);
  OpenDialog.InitialDir:=AppDir+'Themes';
  if OpenDialog.Execute then
    ImportTheme(OpenDialog.FileName);
end;

procedure TViewOptForm.OKButtonClick(Sender: TObject);
begin
  if IniFileName='' then
  begin
    SaveAsButton.Click;
    if IniFileName='' then ModalResult:=mrNone // Error has occured
    else ModalResult:=mrOK;
  end
  else
    if not SaveTheme(IniFileName) then ModalResult:=mrNone;
end;

procedure TViewOptForm.ImgFileNameEditAfterDialog(Sender: TObject;
  var Name: String; var Action: Boolean);
begin
  if Name<>'' then if Name[1]='"' then Delete(Name,1,1);
  if Name<>'' then if Name[Length(Name)]='"' then Delete(Name,Length(Name),1);
  Name:=ExtractRelativePath(AppDir,Name);
end;

procedure TViewOptForm.FormShow(Sender: TObject);
begin
  CategoryView.Selected:=CategoryView.Items[0];
end;

procedure TViewOptForm.FormHide(Sender: TObject);
begin
  ClientPage:=nil;
end;

procedure TViewOptForm.ChatBoldBoxKeyPress(Sender: TObject; var Key: Char);
begin
  UpdateFont;
end;

procedure TViewOptForm.SetWatcherMode;
begin
  WatcherMode:=True;
  SaveAsButton.Enabled:=False;

  IndentBox.Enabled:=False;
  HorScrollBox.Enabled:=False;
  HorScrollBox.Checked:=False;
  AutoCopyBox.Enabled:=False;
  AutoCopyBox.Checked:=False;
  ScrollThroughBox.Enabled:=False;
  ScrollThroughBox.Checked:=False;
  AlignBtmBox.Enabled:=False;
  AlignBtmBox.Checked:=False;

  FontInputBox.Visible:=False;
  ColorsInputBox.Visible:=False;
  ColorsSelectionBox.Visible:=False;
  BeepBox.Checked:=False;
  BeepBox.Enabled:=False;
  InputEdit.Visible:=False;

  ChatView.HorizScrollBar:=False;
end;

procedure TViewOptForm.SetNormalMode;
begin
  WatcherMode:=False;
  SaveAsButton.Enabled:=True;

  IndentBox.Enabled:=True;
  HorScrollBox.Enabled:=True;
  AutoCopyBox.Enabled:=True;
  ScrollThroughBox.Enabled:=True;
  AlignBtmBox.Enabled:=True;

  FontInputBox.Visible:=True;
  ColorsInputBox.Visible:=True;
  ColorsSelectionBox.Visible:=True;
  BeepBox.Enabled:=True;
  InputEdit.Visible:=True;

  ChatView.HorizScrollBar:=True;
end;

end.
