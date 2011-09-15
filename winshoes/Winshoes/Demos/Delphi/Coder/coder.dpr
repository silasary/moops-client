program coder;

uses
  Forms,
  CoderMain in 'CoderMain.pas' {Form1},
  CoderWinshoeBinToASCII in '..\..\CoderWinshoeBinToASCII.pas',
  CoderWinshoe in '..\..\CoderWinshoe.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
