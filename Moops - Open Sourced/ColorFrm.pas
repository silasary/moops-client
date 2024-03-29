unit ColorFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, BeChatView, ComCtrls;

type
  TColorForm = class(TForm)
    ColorDialog: TColorDialog;
    ChatPanel: TPanel;
    InputEdit: TEdit;
    InputFont: TFontDialog;
    ChatFont: TFontDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel16: TPanel;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Panel0: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Label15: TLabel;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label11: TLabel;
    Label12: TLabel;
    DefFgCombo: TComboBox;
    DefBgCombo: TComboBox;
    Label16: TLabel;
    ComboBox1: TComboBox;
    Label17: TLabel;
    ComboBox2: TComboBox;
    Label13: TLabel;
    InputFgCombo: TComboBox;
    Label14: TLabel;
    InputBgCombo: TComboBox;
    ChatFontButton: TButton;
    InputFontButton: TButton;
    procedure ChangeColor(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ChatFontButtonClick(Sender: TObject);
    procedure InputFontButtonClick(Sender: TObject);
    procedure ChatDefChange(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure InputDefChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure LoadLines;
  public
    { Public declarations }
    OldInpFg, OldInpBg: Integer;
    ChatView: TChatView;
    procedure UpdateColors;
    procedure LoadChatColors(AChatView: TChatView);
    procedure LoadChatFont(AChatView: TChatView);
    procedure LoadInputColors(AInputEdit: TEdit);
    procedure LoadInputFont(AInputEdit: TEdit);
  end;

var
  ColorForm: TColorForm;

implementation

{$R *.DFM}

uses
  MainFrm, ClientPage;

procedure TColorForm.ChangeColor(Sender: TObject);
begin
  if Sender is TPanel then
    with Sender as TPanel do
    begin
      ColorDialog.Color:=Color;
      if ColorDialog.Execute then
      begin
        Color:=ColorDialog.Color;
        UpdateColors;
      end;
    end;
end;

procedure TColorForm.FormCreate(Sender: TObject);
begin
  InputEdit.Align:=alBottom;
  ChatView:=TChatView.Create(Self);
  ChatView.Parent:=ChatPanel;
  ChatView.Align:=alClient;
  LoadLines;
end;

procedure TColorForm.LoadLines;
var
  I: Integer;
begin
  ChatView.BeginUpdate;
  ChatView.Clear;
  for I:=0 to 15 do
    if I<>DefBgCombo.ItemIndex then
      ChatView.AddLine(DoColor(I,DefBgCombo.ItemIndex)+DefFgCombo.Items[I]);
  ChatView.EndUpdate;
end;

procedure TColorForm.UpdateColors;
begin
  ChatView.SetFgColor(0,Panel0.Color);   ChatView.SetFgColor(1,Panel1.Color);
  ChatView.SetFgColor(2,Panel2.Color);   ChatView.SetFgColor(3,Panel3.Color);
  ChatView.SetFgColor(4,Panel4.Color);   ChatView.SetFgColor(5,Panel5.Color);
  ChatView.SetFgColor(6,Panel6.Color);   ChatView.SetFgColor(7,Panel7.Color);
  ChatView.SetFgColor(8,Panel8.Color);   ChatView.SetFgColor(9,Panel9.Color);
  ChatView.SetFgColor(10,Panel10.Color); ChatView.SetFgColor(11,Panel11.Color);
  ChatView.SetFgColor(12,Panel12.Color); ChatView.SetFgColor(13,Panel13.Color);
  ChatView.SetFgColor(14,Panel14.Color); ChatView.SetFgColor(15,Panel15.Color);
  LoadLines;
  InputEdit.Font.Color:=ChatView.FgColorTable[InputFgCombo.ItemIndex];
  InputEdit.Color:=ChatView.FgColorTable[InputBgCombo.ItemIndex];
end;

procedure TColorForm.LoadChatColors(AChatView: TChatView);
begin
  AChatView.NormalFg:=ChatView.NormalFg;
  AChatView.NormalBg:=ChatView.NormalBg;
  AChatView.FgColorTable:=ChatView.FgColorTable;
  AChatView.Repaint;
end;

procedure TColorForm.LoadChatFont(AChatView: TChatView);
begin
  AChatView.ChangeFont(ChatView.Font);
  AChatView.Repaint;
end;

procedure TColorForm.LoadInputColors(AInputEdit: TEdit);
begin
  AInputEdit.Font.Color:=InputEdit.Font.Color;
  AInputEdit.Color:=InputEdit.Color;
end;

procedure TColorForm.LoadInputFont(AInputEdit: TEdit);
begin
  AInputEdit.Font.Assign(InputEdit.Font);
end;

procedure TColorForm.FormDestroy(Sender: TObject);
begin
  ChatView.Free;
end;

procedure TColorForm.ChatFontButtonClick(Sender: TObject);
begin
  ChatFont.Font.Assign(ChatView.Font);
  if ChatFont.Execute then
    ChatView.ChangeFont(ChatFont.Font);
end;

procedure TColorForm.InputFontButtonClick(Sender: TObject);
begin
  InputFont.Font.Assign(InputEdit.Font);
  if InputFont.Execute then
    InputEdit.Font.Assign(InputFont.Font);
end;

procedure TColorForm.ChatDefChange(Sender: TObject);
begin
  ChatView.NormalFg:=DefFgCombo.ItemIndex;
  ChatView.NormalBg:=DefBgCombo.ItemIndex;
  LoadLines;
end;

procedure TColorForm.CancelButtonClick(Sender: TObject);
begin
  with MainForm do
  begin
    ChatView.FgColorTable:=TNetClientPage(ClientPages[0]).ChatView.FgColorTable;
    ChatView.NormalFg:=TNetClientPage(ClientPages[0]).ChatView.NormalFg;
    ChatView.NormalBg:=TNetClientPage(ClientPages[0]).ChatView.NormalBg;
    ChatView.ChangeFont(TNetClientPage(ClientPages[0]).ChatView.Font);
    InputEdit.Font.Assign(TNetClientPage(ClientPages[0]).InputEdit.Font);
    InputEdit.Color:=TNetClientPage(ClientPages[0]).InputEdit.Color;
    InputFgCombo.ItemIndex:=OldInpFg;
    InputBgCombo.ItemIndex:=OldInpBg;
  end;
end;

procedure TColorForm.InputDefChange(Sender: TObject);
begin
  InputEdit.Font.Color:=ChatView.FgColorTable[InputFgCombo.ItemIndex];
  InputEdit.Color:=ChatView.FgColorTable[InputBgCombo.ItemIndex];
end;

procedure TColorForm.FormShow(Sender: TObject);
begin
  OldInpFg:=InputFgCombo.ItemIndex;
  OldInpBg:=InputBgCombo.ItemIndex;
  DefFgCombo.ItemIndex:=ChatView.NormalFg;
  DefBgCombo.ItemIndex:=ChatView.NormalBg;
  Panel0.Color:=ChatView.FgColorTable[0];   Panel1.Color:=ChatView.FgColorTable[1];
  Panel2.Color:=ChatView.FgColorTable[2];   Panel3.Color:=ChatView.FgColorTable[3];
  Panel4.Color:=ChatView.FgColorTable[4];   Panel5.Color:=ChatView.FgColorTable[5];
  Panel6.Color:=ChatView.FgColorTable[6];   Panel7.Color:=ChatView.FgColorTable[7];
  Panel8.Color:=ChatView.FgColorTable[8];   Panel9.Color:=ChatView.FgColorTable[9];
  Panel10.Color:=ChatView.FgColorTable[10]; Panel11.Color:=ChatView.FgColorTable[11];
  Panel12.Color:=ChatView.FgColorTable[12]; Panel13.Color:=ChatView.FgColorTable[13];
  Panel14.Color:=ChatView.FgColorTable[14]; Panel15.Color:=ChatView.FgColorTable[15];
  LoadLines;
end;

end.
