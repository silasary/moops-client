program lpdtest;

uses
  Forms,
  lpd_demo in 'lpd_demo.pas' {frmLPD},
  ServerWinshoeLPD in '..\..\..\..\WINDOWS\DESKTOP\Komponenten\Package\ServerWinshoeLPD.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLPD, frmLPD);
  Application.Run;
end.
