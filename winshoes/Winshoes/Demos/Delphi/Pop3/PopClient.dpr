program PopClient;

uses
  Forms,
  main in 'main.pas' {fmMAIN},
  msg in 'msg.pas' {fmMESSAGE};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfmMAIN, fmMAIN);
  Application.CreateForm(TfmMESSAGE, fmMESSAGE);
  Application.Run;
end.
