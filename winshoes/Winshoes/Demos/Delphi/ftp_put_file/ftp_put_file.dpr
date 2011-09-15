program FTP_Put_File;

{$APPTYPE CONSOLE}

uses
  Forms,
  SimpFTP, SysUtils;

{$R *.RES}

procedure Main;
begin
  Try
    WriteLn('FTP_Put_File by Chad Z. Hower');
    WriteLn('http://www.pbe.com/Kudzu');
    WriteLn('');
    if ParamCount < 1 then begin
      WriteLn('Usage:');
      WriteLn('  FTP_Put_File <FTP Address> <Path and filename of local file> <Path and filename of local file> <Username> <Password>');
      WriteLn('');
      WriteLn('Example:');
      WriteLn('  FTP_Put_File ftp.inprise.com c:\temp\feedback.txt /pub/feedback.txt');
      WriteLn('');
      WriteLn('Username and password may be ommitted. If they are an anonymous login will be');
      WriteLn('attempted.');
      Exit;
    end;
    with TSimpleFTP.Create(nil) do try
      if ParamCount >= 4 then
        UserName := ParamStr(4)
      else
        Username := 'anonymous';
      if ParamCount >= 5 then
        Password := ParamStr(5)
      else
        Password := 'spamme@microsoft.com';
      HostName := ParamStr(1);

      WriteLn('Host: ' + HostName);
      WriteLn('User Name: ' + Username);

      if not Connect then begin
        WriteLn('Connect Error');
        exit;
      end;
      try
        WriteLn('Connected');
        Write('Transferring...');
        if PutQualifiedFile(ParamStr(2), ParamStr(3)) then
          WriteLn('Transfer Successful')
        else
          WriteLn('Transfer Failed: ' + LastError);
      finally Disconnect; end;
      WriteLn('Disconnected');
    finally free; end;
  except
    On E: Exception do
      WriteLn('ERROR: ' + E.Message);
  end;
end;

begin
  Main;
end.
