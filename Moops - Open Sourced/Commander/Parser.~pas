unit Parser;

interface

{ These functions return the argument of a command.      }
{ Syntax of a command is:                                }
{ MYCOMMAND ARG1 ARG2 ...                                }
{ Where ARG# is an integer, double or string constant,   }
{ depending on the type of arguments MYCOMMAND requires. }
{ Command identifiers are case insensitive.              }
{ String-constants may be quoted with a '                }
{ For example:                                           }
{ MYCOMMAND('This, is just ONE argument')                }
{ This way, you can use comma's and spaces in strings    }
{ Use '' to denote a single ' in a string argument       }
{ Example: MYCOMMAND('Test '' Test')                     }
{ Will result in the string: Test ' Test                 }

const
  MaxArgs     = 10; { Maximum number of arguments in a function }
  MaxNameLen  = 40; { Maximum length of command-identifier }
  MaxDescrLen = 100;

type
  TCommandProc = procedure of object;
  TArgType = (atInt, atDbl, atStr, atNES, atAny);

  TCommand = record
    Name:  string[MaxNameLen];
    Descr: string[MaxDescrLen];
    Count: Integer;
    Args:  array[1..MaxArgs] of TArgType;
    Proc:  TCommandProc;
  end;

  PComList = ^TComList;
  TComList = array[1..1] of TCommand;

  TCommandsError =
  (
    ceOK,       { Everything is OK }
    ceOutOfMem, { Out of memory when (re)sizing array }
    ceTooMany,  { Too many commands (when AutoInc is off) }
    ceTooSmall, { New array size is too small to hold the old array }
    ceNotFound, { The bot was not found }
    ceOverflow  { Too many commands (when AutoInc is off) }
  );

  TCommands = class
  private
    Size:  Integer;
    Count: Integer;
    Comms: PComList;

    procedure ChangeCommand(Index: Integer; Name, Parms: string; Proc: TCommandProc; Descr: string);
  public
    Error:   TCommandsError;
    AutoInc: Integer;

    constructor Create(InitSize, AutoIncrement: Integer);
    destructor  Destroy; override;

    function EditCommand(Name, Parms: string; Proc: TCommandProc; Descr: string): Boolean;
    function Find(Name: string): Integer;
    function GetIndexed(Index: Integer): TCommand;
    function GetSyntax(Index: Integer): string; { Returns a human-readable syntax }

    function Resize(NewSize: LongInt): Boolean; { Resizes array }
    function GetSize: LongInt;  { Returns size of array }
    function GetCount: LongInt; { Returns actual number of commands in array }
  end;

  TParserError =
  (
    peOK,            { Everything OK }
    peUnknown,       { Unexpected error (actually a bug) }
    peSyntaxErr,     { Syntax error, e.g. 'Test'foo }
    peStrExLn,       { Stringconstant exceeds line, e.g. ('test) }
    peInvalidComm,   { The command identifier is invalid }
    peUnknownComm,   { Unknown command }
    peNoArgExpd,     { No arguments expected }
    peTooManyArgs,   { Too many arguments are given }
    peArgExpd,       { Argument expected, e.g. (23,,14) }
    peStrExpd,       { A stringconstant is expected }
    peIntExpd,       { An integer is expected }
    peDblExpd,       { A double is expected }
    peCommExpd,      { A command identifier is expected }
    peIndexRange     { Index is out of range, i.e. <1 or >(Number of arguments) }
  );

  TParser = class
  private
    fCommands: TCommands;
    Indexes: array[0..MaxArgs+1] of Integer; { Item 0 contains the number of args }
    Args: string;

    function ParseCommIdent(Comm: string): Boolean;
    function ParseArgs(S: string): Boolean;
    function FindComm(Comm: string): TCommand;
    function CheckLastType: Boolean;
    function CheckIsStr: Boolean;
  public
    ActComm:  TCommand; { The last parsed command is found in here }
    ArgNr: Integer; { Additional field for Error, contains the arg. num. where
      the error occured. 0 = 'General' }
    Error: TParserError;

    constructor Create(Coms: TCommands);
    destructor  Destroy; override;

    function ParseCommand(S: string): Boolean;
    function GetStr(Index: Integer): string;
    function GetInt(Index: Integer): LongInt;
    function GetDbl(Index: Integer): Double;
    function GetCommand: string;
    function GetCount: Integer;
    property Commands: TCommands read fCommands write fCommands;
  end;

  TCharSet = set of #0..#255;

const
  IdentChars: TCharSet = ['a'..'z','A'..'Z','_','0'..'9','-','*','+','.',':','@','#','$','!'];

function ParserErrorShort(Error: TParserError): string;
function ParserErrorLong(Error: TParserError): string;

implementation

uses
  SysUtils;

function ParserErrorLong(Error: TParserError): string;
begin
  case Error of
    peOK:            Result:='OK';
    peUnknown:       Result:='Unknown error';
    peSyntaxErr:     Result:='Syntax error';
    peStrExLn:       Result:='String constant exceeds line';
    peInvalidComm:   Result:='Invalid command identifier';
    peUnknownComm:   Result:='Unkown command';
    peNoArgExpd:     Result:='No arguments expected';
    peTooManyArgs:   Result:='Too many arguments given';
    peArgExpd:       Result:='Argument expected';
    peStrExpd:       Result:='String constant expected';
    peIntExpd:       Result:='Integer constant expected';
    peDblExpd:       Result:='Double constant expected';
    peCommExpd:      Result:='Command identifier expected';
    peIndexRange:    Result:='Index out of range';
  end;
end;

function ParserErrorShort(Error: TParserError): string;
begin
  case Error of
    peOK:            Result:='OK';
    peUnknown:       Result:='Unknown';
    peSyntaxErr:     Result:='SyntaxErr';
    peStrExLn:       Result:='StrExLn';
    peInvalidComm:   Result:='InvalidComm';
    peUnknownComm:   Result:='UnkownComm';
    peNoArgExpd:     Result:='NoArgExpd';
    peTooManyArgs:   Result:='TooManyArgs';
    peArgExpd:       Result:='ArgExpd';
    peStrExpd:       Result:='StrExpd';
    peIntExpd:       Result:='IntExpd';
    peDblExpd:       Result:='DblExpd';
    peCommExpd:      Result:='CommExpd';
    peIndexRange:    Result:='IndexRange';
  end;
end;

constructor TCommands.Create(InitSize, AutoIncrement: Integer);
begin
  inherited Create;
  Size:=0; Count:=0; Error:=ceOK; AutoInc:=AutoIncrement; Resize(InitSize);
end;

destructor TCommands.Destroy;
begin
  Count:=0; Resize(0);
  inherited Destroy;
end;

procedure TCommands.ChangeCommand(Index: Integer; Name, Parms: string; Proc: TCommandProc; Descr: string);
var
  I: Integer;
begin
  if (Index<1) or (Index>Count) then Exit;
  if Length(Parms)>MaxArgs then Exit;
  if Length(Name)>MaxNameLen then Exit;
  if Length(Descr)>MaxDescrLen then Exit;
  for I:=1 to Length(Name) do
    if not (Name[I] in IdentChars) then Exit;
  for I:=1 to Length(Parms) do
    if not (UpCase(Parms[I]) in ['D','I','S','A','N']) then Exit;
  Name:=UpperCase(Name);
  Comms^[Index].Name:=Name;
  Comms^[Index].Descr:=Descr;
  Comms^[Index].Proc:=Proc;
  with Comms^[Index] do
  begin
    Count:=Length(Parms);
    for I:=1 to Count do
      case UpCase(Parms[I]) of
        'A': Args[I]:=atAny;
        'N': Args[I]:=atNES;
        'D': Args[I]:=atDbl;
        'S': Args[I]:=atStr;
        'I': Args[I]:=atInt;
      end;
  end;
end;

function TCommands.EditCommand(Name, Parms: string; Proc: TCommandProc; Descr: string): Boolean;
var
  I: Integer;
begin
  Result:=False;
  I:=Find(Name);
  if I>0 then
    ChangeCommand(I,Name,Parms,Proc,Descr)
  else
  begin
    if Count=Size then
    begin
      if AutoInc<=0 then begin Error:=ceOverFlow; Exit; end;
      Resize(Size+AutoInc);
      if Error=ceOutOfMem then Exit;
    end;
    Inc(Count);
    ChangeCommand(Count,Name,Parms,Proc,Descr);
  end;
  Result:=True;
end;

function TCommands.Find(Name: string): Integer;
var
  I: LongInt;
begin
  Name:=UpperCase(Name);
  for I:=1 to Count do
    if Comms^[I].Name=Name then begin Result:=I; Exit; end;
  Result:=0;
end;

function TCommands.GetIndexed(Index: Integer): TCommand;
begin
  if (Index<1) or (Index>Count) then begin Result.Name:=''; Exit; end;
  Result:=Comms^[Index];
end;

function TCommands.GetSyntax(Index: Integer): string; { Returns a human-readable syntax }
{var
  I: Integer;}
begin
  if (Index<1) or (Index>Count) then begin Result:=''; Exit; end;
  Result:='/'+LowerCase(Comms[Index].Name)+' '+Comms[Index].Descr;
{  for I:=1 to Comms[Index].Count do
  begin
    case Comms[Index].Args[I] of
      atInt: Result:=Result+' Integer';
      atDbl: Result:=Result+' Float';
      atStr: Result:=Result+' String';
    end;
  end;}
end;

function TCommands.Resize(NewSize: LongInt): Boolean; { Resizes array }
var
  NewArr: PComList;
  I: LongInt;
begin
  Result:=False;
  if NewSize<Count then begin Error:=ceTooSmall; Exit; end;
  if NewSize>0 then
    try
      GetMem(NewArr,NewSize*SizeOf(TCommand));
    except
      Error:=ceOutOfMem;
      Exit;
    end
  else
    NewArr:=nil;

  if Size>0 then
  begin
    for I:=1 to Count do NewArr^[I]:=Comms^[I];
    FreeMem(Comms,Size*SizeOf(TCommand));
  end;

  Comms:=NewArr; Size:=NewSize;
  Result:=True;
end;

function TCommands.GetSize: LongInt;  { Returns size of array }
begin
  Result:=Size;
end;

function TCommands.GetCount: LongInt;
begin
  Result:=Count;
end;

function GetChar(S: string; I: Integer): Char;
begin
  if I>Length(S) then
    Result:=#0
  else
    Result:=S[I];
end;

constructor TParser.Create(Coms: TCommands);
begin
  inherited Create;
  Indexes[0]:=0; Args:=''; fCommands:=Coms; ActComm.Name:='';
end;

destructor TParser.Destroy;
begin
  inherited Destroy;
end;

{$HINTS OFF}
function TParser.CheckLastType: Boolean;
var
  S: string;
  I, Code: Integer;
  D: Double;
begin
  if Indexes[0]=0 then begin Result:=True; Exit; end; { There is no argument yet }
  Result:=False;
  ArgNr:=Indexes[0];
  if Indexes[0]>ActComm.Count then begin Error:=peTooManyArgs; Exit; end;
  S:=Copy(Args,Indexes[Indexes[0]],Length(Args));
  if S='' then begin Error:=peArgExpd; Exit; end;
  case ActComm.Args[Indexes[0]] of
    atAny, atNES, atStr: ; //begin {Error:=peStrExpd;} Exit; end;
    atInt: begin Val(S,I,Code); if Code<>0 then begin Error:=peIntExpd; Exit; end; end;
    atDbl: begin Val(S,D,Code); if Code<>0 then begin Error:=peDblExpd; Exit; end; end;
  end;
  Result:=True;
end;
{$HINTS ON}

function TParser.CheckIsStr: Boolean;
begin
  if Indexes[0]=0 then begin Result:=True; Exit; end; { There is no argument yet }
  Result:=False;
  ArgNr:=Indexes[0];
  if Indexes[0]>ActComm.Count then begin Error:=peTooManyArgs; Exit; end;
  if ActComm.Args[Indexes[0]]=atInt then begin Error:=peIntExpd; Exit; end;
  if ActComm.Args[Indexes[0]]=atDbl then begin Error:=peDblExpd; Exit; end;
  Result:=True;
end;

function TParser.ParseArgs(S: string): Boolean;
var
  P: Integer;
  InStrMode, IsStr: Boolean;
begin
  Result:=False;
  P:=1; InStrMode:=False; IsStr:=False;
  S:=' '+S+' ';
  while P<=Length(S) do
  begin
    if InStrMode then
    begin
      if S[P]='''' then
      begin
        if GetChar(S,P+1)='''' then begin Args:=Args+''''; Inc(P); end
        else
          InStrMode:=False;
      end
      else
        Args:=Args+S[P];
    end
    else
      if S[P]=' ' then
      begin
        if not IsStr then
        begin
          if not CheckLastType then Exit;
        end
        else
          if not CheckIsStr then Exit;
        Inc(Indexes[0]); Indexes[Indexes[0]]:=Length(Args)+1;
        IsStr:=False;
      end
      else if S[P]='''' then
        if IsStr then
          begin Error:=peSyntaxErr; Exit; end { Cannot enter stringmode again }
        else
          begin InStrMode:=True; IsStr:=True; end
      else
        if IsStr then begin Error:=peSyntaxErr; Exit; end
        else if S[P] in IdentChars then Args:=Args+S[P]
        else begin Error:=peSyntaxErr; Exit; end;
    Inc(P);
  end;
  Dec(Indexes[0]);
  if InStrMode then begin Error:=peStrExLn; Exit; end;
  if Indexes[0]<ActComm.Count then // Allowed if rest of args are strings
  begin
    for P:=Indexes[0]+1 to ActComm.Count do
      if ActComm.Args[P]<>atStr then
      begin
        Error:=peArgExpd;
        Exit;
      end;
    for P:=Indexes[0]+1 to ActComm.Count do
      Indexes[P]:=1;
    Indexes[0]:=ActComm.Count;
  end;
  Result:=True;
end;

function TParser.ParseCommIdent(Comm: string): Boolean;
var
  P: Integer;
begin
  Result:=False;
  if Length(Comm)=0 then begin Error:=peCommExpd; Exit; end;

  if Comm[1] in ['0'..'9'] then begin Error:=peInvalidComm; Exit; end;
  P:=1;
  while (P<=Length(Comm)) and (Comm[P] in IdentChars) do Inc(P);
  if P<=Length(Comm) then begin Error:=peInvalidComm; Exit; end;

  ActComm:=FindComm(Comm); if ActComm.Name='' then begin Error:=peUnknownComm; Exit; end;

  Result:=True;
end;

function TParser.ParseCommand(S: string): Boolean;
var
  P: Integer;
  Comm, Arg: string;
begin
  S:=Trim(S);
  Result:=False; Args:=''; Indexes[0]:=0; Error:=peUnknown;
  P:=Pos(' ',S); if P=0 then P:=Length(S)+1;
  Comm:=Copy(S,1,P-1);

  if not ParseCommIdent(Comm) then Exit;

  if ActComm.Count=0 then
    if Length(S)=Length(Comm) then begin Result:=True; Exit; end
    else begin Error:=peNoArgExpd; Exit; end;

  Arg:=Trim(Copy(S,Length(Comm)+1,Length(S)));
  if ActComm.Args[1]=atAny then
  begin
    Inc(Indexes[0]); Args:=Arg; Indexes[1]:=1; Indexes[2]:=Length(Arg)+1;
    Result:=True; Error:=peOK; Exit;
  end;

  if Arg='' then
  begin
    for P:=1 to ActComm.Count do
      if ActComm.Args[P]<>atStr then
      begin
        Error:=peArgExpd;
        Exit;
      end;
    Indexes[0]:=ActComm.Count;
    for P:=1 to ActComm.Count+1 do Indexes[P]:=1;
    Result:=True; Error:=peOK; Exit;
  end;

  if not ParseArgs(Arg) then Exit;

  Result:=True; Error:=peOK;
end;

function TParser.FindComm(Comm: string): TCommand;
var
  I: Integer;
  C: TCommand;
begin
  Result.Name:=''; Comm:=UpperCase(Comm);
  with fCommands do
    for I:=1 to fCommands.GetCount do
    begin
      C:=GetIndexed(I);
      if C.Name=Comm then begin Result:=C; Exit; end;
    end;
end;

function TParser.GetStr(Index: Integer): string;
begin
  if (Index<=0) or (Index>Indexes[0]) then begin Result:=''; Error:=peIndexRange; Exit; end;
  Result:=Copy(Args,Indexes[Index],Indexes[Index+1]-Indexes[Index]);
end;

function TParser.GetInt(Index: Integer): LongInt;
var
  Code: Integer;
begin
  Val(GetStr(Index),Result,Code);
end;

function TParser.GetDbl(Index: Integer): Double;
var
  Code: Integer;
begin
  Val(GetStr(Index),Result,Code);
end;

function TParser.GetCommand: string;
begin
  Result:=ActComm.Name;
end;

function TParser.GetCount: Integer;
begin
  Result:=Indexes[0];
end;

end.
