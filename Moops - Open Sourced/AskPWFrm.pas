unit AskPWFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TAskPWForm = class(TForm)
    DescrLabel: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ServerLabel: TLabel;
    Bevel1: TBevel;
    Image1: TImage;
    Panel1: TPanel;
    PassEdit: TEdit;
    Panel2: TPanel;
    UserEdit: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function AskPW(Description, Server: string; var User, Pass: string): Boolean;

implementation

{$R *.DFM}

function AskPW(Description, Server: string; var User, Pass: string): Boolean;
var
  AskPWForm: TAskPWForm;
begin
  AskPWForm:=TAskPWForm.Create(Application);
  with AskPWForm do
  begin
    DescrLabel.Caption:=Description;
    ServerLabel.Caption:=Server;
    UserEdit.Text:=User;
    PassEdit.Text:=Pass;
    if User='' then
      ActiveControl:=UserEdit
    else
      ActiveControl:=PassEdit;
    Result:=(ShowModal=mrOK);
    if Result then
    begin
      User:=UserEdit.Text;
      Pass:=PassEdit.Text;
    end;
  end;
  AskPWForm.Free;
end;

end.
