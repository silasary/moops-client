program ChatViewTest;

uses
  Forms,
  cvtMainFrm in 'cvtMainFrm.pas' {MainForm},
  BeChatView_new in 'BeChatView_new.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
