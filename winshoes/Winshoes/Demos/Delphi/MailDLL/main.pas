unit main;

interface

uses
	Windows;

	// Procs
	function SendMessage(sHost, sSubject, sTo, sFrom, sText, sPath,
		sAttachments: PChar): WordBool; StdCall;
	function SendMessage2(sHost, sSubject, sTo, sFrom, sText, sPath,
		sAttachments: PChar; ShowFileNames: DWORD): WordBool; StdCall;
	function SendText(sHost, sSubject, sTo, sFrom, sText: PChar): WordBool; StdCall;

implementation

uses
  Classes
	, SysUtils, SMTPWinshoe, WinshoeMessage;

function SendMessage;
const
	ShowFileNames = 0;
begin
	result := SendMessage2(sHost, sSubject, sTo, sFrom, sText, sPath,
		sAttachments, ShowFileNames);
end;

function SendMessage2;
var
	i, NewTop: Integer;
	Msg: TWinshoeMessage;
begin
	with TWinshoeSMTP.Create(nil) do
	try
		Msg := TWinshoeMessage.Create(Nil);
		try
			with Msg do begin
				Attachments.Clear;
				Host := sHost;
				Subject := sSubject;
				Too := sTo;
				From := sFrom;
        with TStringList.Create do try
  				CommaText := sAttachments;
          for i := 0 to Pred(Count) do
            Attachments.AddAttachment(Strings[i]);
        finally free; end;
				Text.Text := sText;
				if ShowFileNames = 1 then begin
					Text.Add('');
					Text.Add('Default Working Path=' + GetCurrentDir);
					Text.Add( 'Attachments Included: (Path=' + sPath + ')' );
				end;
				i := 0;
				NewTop := Attachments.Count;
				while i < NewTop do begin
					// Add path is not specified
					if NOT ((pos(':\', Attachments[i].StoredPathName) <> 0) OR
						(pos('\\', Attachments[i].StoredPathName) <> 0)) then begin
						Attachments[i].StoredPathName := sPath + '\' + Attachments[i].StoredPathName;
					end;
					if NOT FileExists(Attachments[i].StoredPathname) then begin
						if ShowFileNames = 1 then begin
							Text.Add( Chr(9) + Attachments[i].StoredPathName + ' (Not Found');
						end;
						Attachments.Delete(i);
						Dec(NewTop);
					end else begin
						if ShowFileNames = 1 then Text.Add( Chr(9) + Attachments[i].StoredPathname + ' (Included)' );
						Inc(i);
					end;
				end; // While More Attachments
			end;
			Send(Msg);
			Result := True;
		finally
			Msg.Free;
		end;
	finally
		Free;
	End;
end;

function SendText;
begin
	try
		QuickSend(StrPas(sHost), StrPas(sSubject), StrPas(sTo), StrPas(sFrom), StrPas(sText));
		Result := True;
	except
		result := False;
	end;
end;

end.
