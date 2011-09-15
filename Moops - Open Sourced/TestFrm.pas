unit TestFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    UpDown1: TUpDown;
    Label3: TLabel;
    Label4: TLabel;
    procedure UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.UpDown1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
{  Label3.Caption:=IntToStr(UpDown1.Position);
  Edit1.Font.Size:=UpDown1.Position;
  Memo1.Font.Size:=UpDown1.Position;
  Memo1.Height:=Round(-Memo1.Font.Height*1.06)+10;
  Label1.Caption:=IntToStr(Edit1.Height);
  Label2.Caption:=IntToStr(Memo1.Height);
  Label4.Caption:=IntToStr(-Edit1.Font.Height);}
  Label3.Caption:=IntToStr(UpDown1.Position);
  Memo1.Height:=Round(-(UpDown1.Position-1)*Memo1.Font.Height*1.21)+Round(-Memo1.Font.Height*1.06)+10;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.MainForm.Close;
end;

end.
