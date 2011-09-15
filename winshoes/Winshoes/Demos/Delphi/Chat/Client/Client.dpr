program client;

uses
  Forms,
  main in 'main.pas' {FormClient};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormClient, FormClient);
  Application.Run;
end.
