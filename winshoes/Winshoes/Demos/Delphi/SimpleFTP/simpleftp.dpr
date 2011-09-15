program simpleftp;

uses
  Forms,
  frmSimpleFTPU in 'frmSimpleFTPU.pas' {frmSimpleFTP},
  SimpFTP in '..\..\simpftp.pas',
  WinInetControl in '..\..\WinInetControl.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Simple FTP';
  Application.CreateForm(TfrmSimpleFTP, frmSimpleFTP);
  Application.Run;
end.
