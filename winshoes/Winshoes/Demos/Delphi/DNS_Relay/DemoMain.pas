unit DemoMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Winshoes, UDPWinshoe, DNSMappedPort, StdCtrls, WinshoeDnsREsolver,
  WinshoeGUIIntegrator;

type
  TForm1 = class(TForm)
    DNSMappedPort1: TDNSMappedPort;
    memLog: TMemo;
    WinshoeGUIIntegrator1: TWinshoeGUIIntegrator;
    procedure DNSMappedPort1UDPRead(Sender: TObject; const psData,
      psPeer: String; const piPort: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.DNSMappedPort1UDPRead(Sender: TObject; const psData,
  psPeer: String; const piPort: Integer);
begin
  memLog.Lines.Insert(0, 'Request ' + IntToStr(Random(100)));
end;

end.
