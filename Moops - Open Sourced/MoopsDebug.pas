unit MoopsDebug;

interface

uses
  Winshoes;

procedure StartDebugger;
procedure SendStatus(Session: Integer; const Msg: string);
procedure SendDebug(Session: Integer; Data: array of string);

implementation

uses
  SysUtils, Windows, ShellApi, MainFrm, Forms;

var
  DebugSocket: TWinshoeClient;
  DoDebug: Boolean = False;

procedure InitSocket;
begin
  DebugSocket:=TWinshoeClient.Create(nil);
  DebugSocket.Host:='127.0.0.1';
  DebugSocket.Port:=6789;
end;

procedure OpenSocket;
begin
  DebugSocket.Connect;
  DoDebug:=True;
end;

procedure CloseSocket;
begin
  SendStatus(0,'*END*');
  DoDebug:=False;
  DebugSocket.Disconnect;
end;

procedure DestroySocket;
begin
  try
    CloseSocket;
  except
  end;
  DebugSocket.Free;
end;

procedure StartDebugger;
var
  ErrCode: Integer;
  FileName: string;
  Timer: Integer;
begin
  try
    OpenSocket; // already started?
  except
    FileName:=ExtractFileDir(ParamStr(0));
    if FileName[Length(FileName)]='\' then
      FileName:=FileName+'MoopsDebug.exe'
    else
      FileName:=FileName+'\MoopsDebug.exe';

    ErrCode:=ShellExecute(Application.Handle,'open',PChar(FileName),nil,nil,SW_SHOWNORMAL);
    if ErrCode<32 then Exit; // error

    Timer:=100;
    repeat
      Sleep(100);
      try
        OpenSocket;
        Application.BringToFront;
      except
      end;
      Dec(Timer);
    until DebugSocket.Connected or (Timer<0);
  end;
end;

procedure SendStatus(Session: Integer; const Msg: string);
begin
  if not DoDebug then Exit;
  try
    DebugSocket.WriteLn(Msg);
    DebugSocket.ReadLn; // wait for answer before continuing
  except
    try
      CloseSocket;
    except
    end;
    try
      OpenSocket;
    except
    end;
  end;
end;

procedure SendDebug(Session: Integer; Data: array of string);
var
  I: Integer;
  S: string;
begin
  for I:=Low(Data) to High(Data)-1 do
    S:=S+''''+Data[I]+''',''';
  S:=S+''''+Data[High(Data)]+'''';
  SendStatus(Session,S);
end;

initialization
  InitSocket;
finalization
  DestroySocket;
end.
