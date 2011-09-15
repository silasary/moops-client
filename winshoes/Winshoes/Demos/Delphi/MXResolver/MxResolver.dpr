program MxResolver;

uses
  Forms,
  MxTest in 'MxTest.pas' {MxTestForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMxTestForm, MxTestForm);
  Application.Run;
end.
