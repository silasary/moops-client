unit Debug;

interface

function NewSession(const Name: string): Integer;
procedure SendDebug(Session: Integer; const Data: array of string);

implementation

uses
  Windows, Winshoes, SysUtils;

type
  TDebugClient = class{(TThread)}
  private
    fClient: TWinshoeClient;
  protected
//    procedure Execute; override;
    function SendStrings(const Data: array of string): Boolean;
    function ReadResult: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    function NewSession(const Name: string): Integer;
    function SendDebug(Session: Integer; const Data: array of string): Boolean;
  end;

var
  DebugClient: TDebugClient;
  SessionHandle: Integer;

function NewSession(const Name: string): Integer;
begin
  if DebugClient=nil then
    DebugClient:=TDebugClient.Create;
  Result:=DebugClient.NewSession(Name);
end;

procedure SendDebug(Session: Integer; const Data: array of string);
begin
  if DebugClient<>nil then DebugClient.SendDebug(Session,Data);
end;

{ TDebugClient }

constructor TDebugClient.Create;
begin
  inherited Create{(True)};
  fClient:=TWinshoeClient.Create(nil);
  fClient.EOLTerminator:=#10;
  fClient.Host:='127.0.0.1';
  fClient.Port:=6789;
  try
    fClient.Connect;
  except
  end;
end;

destructor TDebugClient.Destroy;
begin
  fClient.Free;
  inherited;
end;

{procedure TDebugClient.Execute;
begin
  while not Terminated do
    try
    except
      Sleep(50);
    end;
end;}

function TDebugClient.NewSession(const Name: string): Integer;
begin
  Result:=0;
  try
    if not fClient.Connected then Abort;
    SendStrings(['Command=NewSession','Name='+Name]);
    SessionHandle:=ReadResult;
    Result:=SessionHandle;
  except
  end;
end;

function TDebugClient.ReadResult: Integer;
var
  S: string;
begin
  S:=fClient.ReadLn;
  if Copy(S,1,8)<>' Result=' then Abort;
  Delete(S,1,8);
  Result:=StrToInt(S);
end;

function TDebugClient.SendDebug(Session: Integer;
  const Data: array of string): Boolean;
var
  I: Integer;
begin
  Result:=False;
  if Session=0 then Session:=SessionHandle;
  if Session<=0 then Exit;

  try
    for I:=0 to High(Data) do
      fClient.WriteLn('+'+Data[I]);
    fClient.WriteLn(' Session='+IntToStr(Session));
    Result:=ReadResult=1; // make sure the data is transmitted
  except
  end;
end;

function TDebugClient.SendStrings(const Data: array of string): Boolean;
var
  I: Integer;
begin
  Result:=False;
  try
    for I:=0 to High(Data)-1 do
      fClient.WriteLn('+'+Data[I]);
    if High(Data)>=0 then
      fClient.WriteLn(' '+Data[High(Data)]);
    Result:=True;
  except
  end;
end;

initialization
finalization
  DebugClient.Free;
end.
