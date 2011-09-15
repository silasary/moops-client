unit RegisterFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, BeChatView, Mask, ToolEdit, RXSpin,
  RxCombos, IniFiles, ImgManager, ViewOptFrm, Common, FileCtrl, Menus, ClientPage;

type
  TScriptArray = array[0..3] of TStringList;

  TRegisterForm = class(TForm)
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
    TabSheet1: TTabSheet;
    Label2: TLabel;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    NameEdit: TEdit;
    EmailEdit: TEdit;
    CountryEdit: TEdit;
    Label6: TLabel;
    HowCombo: TComboBox;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CategoryViewChange(Sender: TObject; Node: TTreeNode);
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegisterForm: TRegisterForm;

implementation

uses MainFrm;

{$R *.DFM}

procedure TRegisterForm.FormCreate(Sender: TObject);
begin
  Image1.Width:=32;
  Image1.Height:=32;
  Image1.Top:=Panel_3.Height-33;
  CategoryView.FullExpand;
  CategoryView.Selected:=CategoryView.Items[0];
end;

procedure TRegisterForm.FormShow(Sender: TObject);
begin
  CategoryView.Selected:=CategoryView.Items[0];
end;

procedure TRegisterForm.CategoryViewChange(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.Selected then
  begin
    PageControl.ActivePageIndex:=Node.AbsoluteIndex;
    TabCaption.Caption:=PageControl.ActivePage.Caption;
    PageControl.ActivePage.Tag:=1;
  end;
end;

procedure TRegisterForm.OKButtonClick(Sender: TObject);
var
  I: Integer;
begin
  for I:=0 to PageControl.PageCount-1 do
    if PageControl.Pages[I].Tag=0 then
    begin
      PageControl.ActivePageIndex:=I;
      TabCaption.Caption:=PageControl.ActivePage.Caption;
      PageControl.ActivePage.Tag:=1;
      ModalResult:=mrNone;
      Exit;
    end;
end;

procedure TRegisterForm.CancelButtonClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

end.
