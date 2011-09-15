unit UnitAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TFormAbout = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ImageDPower: TImage;
    Label5: TLabel;
    Label6: TLabel;
    ButtonClose: TButton;
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
  end;

var
  FormAbout: TFormAbout;

implementation
{$R *.DFM}

procedure TFormAbout.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
