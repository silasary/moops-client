unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Winshoes, StdCtrls;

type
  TForm1 = class(TForm)
    Client: TWinshoeClient;
    Button1: TButton;
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
  with Client do begin
    Connect; try
      WriteLn('Hello');
      WriteLn('EXIT');
    finally Disconnect; end;
  end;
end;

end.
