Program Ping;

uses
  Forms,
  pingunit in 'pingunit.pas' {WinshoesPingForm};

{$R *.RES}

Begin
  Application.Initialize;
  Application.CreateForm(TWinshoesPingForm, WinshoesPingForm);
  Application.Run;
End.
