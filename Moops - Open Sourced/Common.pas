unit Common;

interface

var
  AppDir: string;
  AppTerminating: Boolean = False;

type
  TCodeSet = set of Char;

const
  EncodeURLSet: TCodeSet = ['a'..'z','A'..'Z','0'..'9','_','@','.'];
  EncodeIniSet: TCodeSet = ['/',' ',',','''','"','a'..'z','A'..'Z','0'..'9','-','_','@','.'];

function PwToStr(PW: string): string;
function StrToPW(S: string): string;
function IsIP(S: string): Boolean;
function NetworkErrorShort(Nr: Integer): string;
function NetworkErrorLong(Nr: Integer): string;
function HexToInt(S: string): Integer;
function EncodeVar(const S: string; const CodeSet: TCodeSet): string;
function DecodeVar(const S: string): string;
function EncodeURLVar(const S: string): string;
function DecodeURLVar(const S: string): string;
function EncodeIniVar(const S: string): string;
function DecodeIniVar(const S: string): string;

implementation

uses
  SysUtils, WinSock;

function HexToInt(S: string): Integer;
var
  I: Integer;
begin
  I:=1;
  Result:=0;
  S:=UpperCase(S);
  while S<>'' do
  begin
    if S[Length(S)] in ['0'..'9'] then
      Result:=Result+(Ord(S[Length(S)])-48)*I
    else
      Result:=Result+(Ord(S[Length(S)])-55)*I;
    S:=Copy(S,1,Length(S)-1); I:=I shl 4;
  end;
end;

function EncodeVar(const S: string; const CodeSet: TCodeSet): string;
var
  I: Integer;
begin
  I:=1;
  Result:=S;
  while I<=Length(Result) do
    if not (Result[I] in CodeSet) then
    begin
      Result:=Copy(Result,1,I-1)+'%'+IntToHex(Ord(Result[I]),2)+Copy(Result,I+1,Length(Result));
      Inc(I,3);
    end
    else
      Inc(I);
end;

function DecodeVar(const S: string): string;
var
  I: Integer;
begin
  Result:=S;
  try
    I:=1;
    while I<=Length(Result) do
    begin
      if Result[I]='%' then
        Result:=Copy(Result,1,I-1)+Chr(HexToInt(Copy(Result,I+1,2)))+Copy(Result,I+3,Length(Result));
      Inc(I);
    end;
  except
  end;
end;

function EncodeIniVar(const S: string): string;
begin
  Result:=EncodeVar(S,EncodeIniSet);
end;

function DecodeIniVar(const S: string): string;
begin
  Result:=DecodeVar(S);
end;

function EncodeURLVar(const S: string): string;
begin
  Result:=EncodeVar(S,EncodeURLSet);
end;

function DecodeURLVar(const S: string): string;
begin
  Result:=DecodeVar(S);
end;

function PwToStr(PW: string): string;
var
  I, Chk: Integer;
begin
  Chk:=0;
  for I:=1 to Length(PW) do
    Chk:=(Chk+Ord(PW[I])) mod 256;
  PW:=PW+Chr(Chk);
  Result:=Format('%3.3d',[255-Length(PW)]);
  for I:=1 to Length(PW) do
    Result:=Result+Format('%3.3d',[255-Ord(PW[I])]);
end;

function StrToPW(S: string): string;
var
  I, L, Chk: Integer;
begin
  try
    Result:='';
    if S='' then Exit;
    L:=255-StrToInt(Copy(S,1,3)); S:=Copy(S,4,Length(S)-3);
    while S<>'' do
    begin
      Result:=Result+Chr(255-StrToInt(Copy(S,1,3)));
      S:=Copy(S,4,Length(S)-3);
    end;
    if Length(Result)<>L then begin Result:=''; Exit; end;
    Chk:=0;
    for I:=1 to L-1 do
      Inc(Chk,Ord(Result[I]));
    if Ord(Result[L])<>Chk mod 256 then Result:='';
    Result:=Copy(Result,1,Length(Result)-1);
  except
    Result:='';
  end;
end;

{$HINTS OFF}
function IsIP(S: string): Boolean;
var
  I, P, V, Code: Integer;
begin
  Result:=True;
  for I:=1 to 4 do
  begin
    P:=Pos('.',S); if P=1 then begin Result:=False; Exit; end;
    if P=0 then P:=Length(S)+1;
    Val(Copy(S,1,P-1),V,Code);
    if Code<>0 then begin Result:=False; Exit; end;
    S:=Copy(S,P+1,Length(S));
  end;
end;
{$HINTS ON}

function NetworkErrorShort(Nr: Integer): string;
begin
  case Nr of
    WSAENETDOWN:     Result:='NetDown';
    WSAENETUNREACH:  Result:='NetUnReach';
    WSAENETRESET:    Result:='NetReset';
    WSAECONNABORTED: Result:='ConnAborted';
    WSAECONNRESET:   Result:='ConnReset';
    WSAENOBUFS:      Result:='NoBufs';
    WSAEISCONN:      Result:='IsConn';
    WSAENOTCONN:     Result:='NotConn';
    WSAESHUTDOWN:    Result:='ShutDown';
    WSAETOOMANYREFS: Result:='TooManyRefs';
    WSAETIMEDOUT:    Result:='TimedOut';
    WSAECONNREFUSED: Result:='ConnRefused';
    WSAELOOP:        Result:='Loop';
    WSAENAMETOOLONG: Result:='NameTooLong';
    WSAEHOSTDOWN:    Result:='HostDown';
    WSAEHOSTUNREACH: Result:='HostUnReach';
    WSASYSNOTREADY:  Result:='SysNotReady';
  else
    Result:='Unknown';
  end;
end;

function NetworkErrorLong(Nr: Integer): string;
begin
  case Nr of
    WSAENETDOWN:     Result:='Network down';
    WSAENETUNREACH:  Result:='Network unreachable';
    WSAENETRESET:    Result:='Network reset';
    WSAECONNABORTED: Result:='Connection aborted';
    WSAECONNRESET:   Result:='Connection reset';
    WSAENOBUFS:      Result:='No buffers';
    WSAEISCONN:      Result:='Is a connection';
    WSAENOTCONN:     Result:='Socket is not connected';
    WSAESHUTDOWN:    Result:='Shutdown';
    WSAETOOMANYREFS: Result:='Too many referentions';
    WSAETIMEDOUT:    Result:='Timed out';
    WSAECONNREFUSED: Result:='Connection refused';
    WSAELOOP:        Result:='Loop';
    WSAENAMETOOLONG: Result:='Name too long';
    WSAEHOSTDOWN:    Result:='Host down';
    WSAEHOSTUNREACH: Result:='Host unreachable';
    WSASYSNOTREADY:  Result:='System not ready';
  else
    Result:='Unknown';
  end;
end;

begin
  AppDir:=ExtractFilePath(ParamStr(0));
  if AppDir[Length(AppDir)]<>'\' then AppDir:=AppDir+'\';
end.
