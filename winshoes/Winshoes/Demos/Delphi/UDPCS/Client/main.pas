unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Winshoes, UDPWinshoe, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    editMessage: TEdit;
    Button1: TButton;
    UDPClient: TWinshoeUDPClient;
    procedure Button1Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation
{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  with UDPClient do begin
    Connect; Try
      Send(editMessage.Text);
      ShowMessage(Receive);
    finally Disconnect; end;
  end;
end;

end.
