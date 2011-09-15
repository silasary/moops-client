program Bftp;

uses
	Forms,
	main in 'main.pas' {formMain},
	edit in 'edit.pas' {formEdit};

{$R *.RES}

{
-Encrypt Password so user cannot FTP in themselves
}

begin
	Application.Initialize;
	Application.Title := 'BFTP';
	Application.CreateForm(TformMain, formMain);
	Application.Run;
end.
