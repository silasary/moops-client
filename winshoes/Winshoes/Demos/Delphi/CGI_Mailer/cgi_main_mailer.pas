unit CGI_Main_Mailer;

interface

uses
	Windows, Messages, SysUtils, Classes, HTTPApp;

type
	TWebModule1 = class(TWebModule)
		procedure WebModule1WebActionItem1Action(Sender: TObject;	Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
	private
	public
	end;

var
	WebModule1: TWebModule1;

implementation

{$R *.DFM}

uses
	SMTPWinshoe, WinshoeMessage;

procedure TWebModule1.WebModule1WebActionItem1Action(Sender: TObject;	Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
var
	sMsg, sDirectTo, sTemplate: string;
	X: Integer;
	strm: TStream;
	slstVarsIn: TStrings;
  Msg: TWinshoeMessage;
begin
	if Request.MethodType = mtGet then
		slstVarsIn := Request.QueryFields
	else if Request.MethodType = mtPost then
		slstVarsIn := Request.ContentFields
	else
		Exit;

	try
		sMsg := slstVarsIn.Values['Msg'];
    slstVarsIn.Values['Msg'] := '';
		sDirectTo := slstVarsIn.Values['Response'];
    slstVarsIn.Values['Response'] := '';

		// Template not currently in use.
		sTemplate := slstVarsIn.Values['Template'];
    slstVarsIn.Values['Template'] := '';

		with TWinshoeSMTP.Create(nil) do begin
      try
        Host := slstVarsIn.Values['SMTP'];
        slstVarsIn.Values['SMTP'] := '';

        Msg := TWinshoeMessage.Create(nil);
        try
          with Msg do begin
            Subject := slstVarsIn.Values['Subject'];
            slstVarsIn.Values['Subject'] := '';
            Too.Text := slstVarsIn.Values['To'];
            slstVarsIn.Values['To'] := '';
            From := slstVarsIn.Values['From'];
            slstVarsIn.Values['From'] := '';

            if Length(From) = 0 then
              From := Too.Text;
            if Length(Subject) = 0 then
              Subject := 'None';
          end;

          slstVarsIn.Values['Server'] := '';

          // Delete empty responses
          for X := Pred(slstVarsIn.Count) downto 0 do begin
            // Don't check last char, the value may contain an = itself
            if Pos('=', slstVarsIn[X]) = Length(slstVarsIn[X]) then
              slstVarsIn.Delete(X);
          end;

          Send(Msg);
        finally
          Msg.Free;
        end;
      finally
        Free;
      end;
    end;
	except
		on E: Exception do
			raise Exception.Create('Error occured while transmitting message.<BR>' + E.Message);
	end;

	// Response to user
	try
		if Length(sDirectTo) > 0 then begin
			strm := TFilestream.Create(sDirectTo, fmOpenRead);
      try
			  Response.SendResponse;
			  Response.SendStream(strm);
      finally
        strm.Free;
      end;
		end else if Length(sMsg) > 0 then begin
			Response.Content := #13#10 + sMsg
		end else begin
			Response.Content := #13#10 + 'Form submitted successfully.';
		end;
	except
		on E: Exception do
      raise Exception.Create('Error:<BR>' + E.Message);
	end;
end;

end.
