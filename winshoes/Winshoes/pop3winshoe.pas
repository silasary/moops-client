{
     13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Clients)
     Dec 12th, 1999 - Added 2 procedures
          KeepAlive - just sends noop to the server

          Reset     - Resets the mailbox to the state
                      before you connected. Useful if
                      you've marked msgs for deletion
                      and then decide not to delete them.

          Jeremiah Gilbert
}

unit Pop3Winshoe;

interface

uses
	Classes,
	winshoes, WinshoeMessage;

Type
	TWinshoePOP3 = class(TWinshoeMessageClient)
	private
	protected
	public
		constructor Create(AOwner: TComponent); override;
		procedure Connect; override;
		procedure Disconnect; override;
		function CheckMessages: Longint;
          function Delete(const piMsgNo: Integer): boolean;
		function Retrieve(const piMsgNo: Integer; pMsg: TWinshoeMessage): boolean;
          function RetrieveHeader(const piMsgNo: Integer; pMsg: TWinshoeMessage): boolean;
          function RetrieveSize(const piMsgNo: integer):integer;
          procedure KeepAlive;
          function Reset: boolean;

     published

          property Password;
          property UserID;
	end;

// procs
  procedure Register;

implementation

Uses
  GlobalWinshoe
	, SysUtils;

procedure Register;
begin
  RegisterComponents('Winshoes Clients' , [TWinshoePOP3]);
end;

Constructor TWinshoePOP3.Create;
Begin
	inherited Create(AOwner);
	Port := WSPORT_POP3;
End;

procedure TWinshoePOP3.Disconnect;
begin
  try
    WriteLn('Quit');
  finally inherited end;
end;

procedure TWinshoePOP3.Connect;
begin
	inherited Connect; try
		FsCommandResult := ReadLn;
		if Copy(FsCommandResult, 1, 3) <> '+OK' then
      SRaise(EWinshoeConnectRefused);
		DoStatus('Connected');

		Command('User ' + UserID, wsOk, 1, 'User Account is valid');
		Command('Pass ' + Password, wsOk, 1, 'Password is valid');
	except
		Disconnect;
		Raise;
	end;
end;

function TWinshoePOP3.Retrieve;
begin
	if Command('RETR ' + IntToStr(piMsgNo), 1, 0, '') = wsOk then
     begin
		DoStatus('Retrieving message body '+IntToStr(piMsgNo)+'...');
          ReceiveHeader(pMsg, '');
          ReceiveBody(pMsg);
          DoStatus('Finished retrieving message body '+IntToStr(piMsgNo)+'.');
	end;
  // Will only hit here if ok and NO exception, or IF is not executed
	result := ResultNo = wsOk;
end;

function TWinshoePOP3.CheckMessages;
var
     s1,s2: string;

begin
	result := 0;
	try
          Command('STAT', wsOk, 0, 'Checking for messages...');
          s1 := CommandResult ;
		if s1 <> '' then
    	     begin
      	     s2 := Copy(s1,5,Length(s1)-5);
               result := StrToInt(Copy(s2,1,Pos(' ',s2)-1));
          end;

     except
		on E: Exception do DoStatus(E.Message);
	end;
end;

function TWinshoePOP3.Delete;
begin
	Command('DELE ' + IntToStr(piMsgNo), -1, 0, 'Deleting message '+ IntToStr(piMsgNo) + '...');
	result := ResultNo = wsOk;
end;

function TWinShoePOP3.RetrieveHeader(const piMsgNo: Integer; pMsg: TWinshoeMessage): boolean;
var
	sDummy:string;
begin
	if Command('TOP ' + IntToStr(piMsgNo) + ' 0', wsOk, 0, 'Retrieving headers for message '+inttostr(pimsgno)+'...') = wsOk then
		begin
	   	ReceiveHeader(pMsg, '');
      sDummy := ReadLn ;
      while sDummy = '' do
        sDummy := ReadLn ;
      if sDummy = '.' then
      	result := true
      else
      	result := false ;
    end
  else
  	result := false ;
end ;

function TWinshoePOP3.RetrieveSize(const piMsgNo: integer): integer;
var
  s:string;
begin
  try
    // Returns the size of the message. if an error ocurrs, returns -1.
    if Command('LIST ' + InttoStr(piMsgNo), wsOK, 0, 'Retrieving size of message '+inttostr(pimsgno)+'...') = wsOk then
      if CommandResult <> '' then
        begin
          s := Copy(CommandResult, 5, Length(CommandResult) - 4);
          result := StrToIntDef(Copy(s,Pos(' ',s)+1, Length(s)-Pos(' ',s)+1),-1);
        end
      else
        result := -1
    else
      result := -1 ;
  except
		on E: Exception do
      begin
        DoStatus(E.Message);
        result := -1 ;
      end;
	end;
end;


procedure TWinshoePOP3.KeepAlive;
begin
    Command('NOOP', wsOK, 0,'Sending Keep Alive(NOOP)...');
end;

function TWinshoePOP3.Reset;
begin
     Command('RSET', wsOK, 0,'Resetting mailbox...');
     result:= ResultNo = wsOK;

end;
end.
