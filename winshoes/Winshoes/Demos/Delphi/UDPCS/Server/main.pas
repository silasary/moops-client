unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Winshoes, UDPWinshoe, StdCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Listener: TWinshoeUDPListener;
    procedure ListenerUDPRead(Sender: TObject; const psData,
      psPeer: String; const piPort: Integer);
  private
  public
  end;

var
  Form1: TForm1;

implementation
{$R *.DFM}

procedure TForm1.ListenerUDPRead(Sender: TObject; const psData,
  psPeer: String; const piPort: Integer);
begin
  listbox1.Items.Add('Message "' + psData + '" from ' + psPeer + ' on port '
   + IntToStr(Listener.Port));
  listbox1.Items.Add('  Returning "PONG" on port ' + IntToStr(piPort));

  Listener.SendTo(psPeer, piPort, 'PONG');
end;

end.
