program DemoDNSProxy;

uses
  Forms,
  DemoMain in 'DemoMain.pas' {Form1},
  DNSMappedPort in 'DNSMappedPort.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
