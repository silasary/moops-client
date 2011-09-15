program SMTPDemo;

uses
  Forms,
  Unitmain in 'Unitmain.pas' {FormMain},
  UnitSetup in 'UnitSetup.pas' {FormSetup},
  UnitAbout in 'UnitAbout.pas' {FormAbout},
  SenderThread in 'SenderThread.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
