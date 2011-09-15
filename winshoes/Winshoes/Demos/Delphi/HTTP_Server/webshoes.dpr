program webshoes;

uses
  Forms,
  main in 'main.pas' {formMain},
  ServerWinshoeHTTP in '..\..\ServerWinshoeHTTP.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
