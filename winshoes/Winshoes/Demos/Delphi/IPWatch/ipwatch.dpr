program ipwatch;

uses
  Forms,
  mainfrm in 'mainfrm.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'IPWatchDemo';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
