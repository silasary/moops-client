program cgi_mailer;

{$APPTYPE CONSOLE}

// Documentation for usage of this program at http://www.pbe.com/kudzu (See CGI Form Mailer)

uses
  HTTPApp,
  CGIApp,
  CGI_Main_Mailer in 'CGI_Main_Mailer.pas' {WebModule1: TWebModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
