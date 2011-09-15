program Server;

uses
  Forms,
  main in 'main.pas' {FormServer};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormServer, FormServer);
  Application.Run;
end.
