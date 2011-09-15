program HTTPGetDemo;

uses
  Forms,
  frmSimpHTTPGetDemoU in 'frmSimpHTTPGetDemoU.pas' {frmSimpHTTPGetDemo};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSimpHTTPGetDemo, frmSimpHTTPGetDemo);
  Application.Run;
end.
