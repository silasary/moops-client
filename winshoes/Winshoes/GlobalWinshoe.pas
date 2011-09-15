unit GlobalWinshoe;

interface

// Global support unit
// Nothing needs be documented in this unit

Uses
  Classes,
  Messages;

const
  CR = #13;
  LF = #10;
  EOL = #13#10;
  TAB = #9;
  CHAR0=#0;
  CHAR32=#32; {didn't use "SPACE" as name just incase of confliction!}

var
  bVoid: Boolean;
  sVoid: string;

type
  TStringEvent = procedure(Sender: TComponent; const sOut: String) of Object;

  TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
// Procs
  function iiif(const pbCondition: boolean;
                const piTrue, piFalse: Integer): Integer;
  function siif(const pbCondition: boolean;
                const psTrue, psFalse: String) : String;
	Function OffsetFromUTC: TDateTime;
  function RPos(const sSub, sIn: String; piStart: Integer): Integer;
  function StreamEOF(strm: TStream): Boolean;
//Returns true if at end of stream
  function StreamReadShortLn(strm: TStream): String;
  function StreamReadLongLn(strm: TStream;
                            var bEOL: Boolean; iSize: Integer): String;
  function StreamReadLn(strm: TStream): String; //Used to break D1
  function StreamReadXChars(strm: TStream; const iChars: Integer): String;
  procedure StreamWrite(strm: TStream; const sOut: string);
  procedure StreamWriteLn(strm: TStream; const sOut: string);

  function PosInStrArray(const SearchStr: string; Contents: array of string) : Integer;
  function UpcaseFirst(s: string) : string;

  function StrToDay(const sDay: string): Byte;
  function StrToMonth(const sMonth: string): Byte;
  function IsNumeric(c: char) : Boolean;

  function StringReplace(const S, OldPattern, NewPattern: string;
                         Flags: TReplaceFlags): string;
  Function NoAngleBrackets(Const s: string): string;
  Function TabPAD(S:String):String;
  Function Pad10(I:Integer):String;

implementation

uses
  // Math - Don't use Math - not all versions of Delph have it.
  SysUtils,
  Windows;

function MinIntValue(const Data: array of Integer): Integer;
var
  I: Integer;

begin
  Result := Data[Low(Data)];
  for I := Low(Data) + 1 to High(Data) do begin
    if Result > Data[I] then
      Result := Data[I];
  end;
end;

procedure StreamWrite(strm: TStream; const sOut: string);
{Writes a string to a stream}
begin
  if length(sOut) > 0 then
    strm.WriteBuffer(sOut[1], Length(sOut));
end;

procedure StreamWriteLn(strm: TStream; const sOut: string);
begin
  StreamWrite(strm, sOut);
  StreamWrite(strm, EOL);
end;

function iiif(const pbCondition: boolean; const piTrue, piFalse: Integer): Integer;
begin
  if pbCondition then
    Result := piTrue
  else
    Result := piFalse;
end;

function siif(const pbCondition: boolean; const psTrue, psFalse: string): string;
begin
  if pbCondition then result := psTrue
    else result := psFalse;
end;

function StreamEOF(strm: TStream): Boolean;
begin
// Streams that are not random access have 0 size
  Result := (strm.Position >= strm.Size) and (strm.Size <> 0);
end;

//These routines are really innefficient, need optimized
function StreamReadLn(strm: TStream): String; //Used to break D1 (AnsiString)
Var
  c1: char;

Begin
  with strm do begin
    if strm.Position >= strm.Size then
      raise Exception.Create('Input past end of stream');
    Result := '';

    repeat
      Read(c1, 1);
      Result := Result + c1;
    until (c1 = CR) or StreamEOF(strm);
    if c1 = CR then SetLength(Result, Length(Result) - 1);

// OK for Random access stream if they always use CR/LF combination
    if not StreamEOF(strm) then begin
      Read(c1, 1);
      if c1 <> LF then Position := Position - 1;
    end;
  end;
End;

function StreamReadShortLn(strm: TStream): String;
{Read's a line from <strm> starting at current position
If line is >255, 255 will be returned, and remaining will be bypassed
Result is line read, up to 255 char}
Var
  lPos: LongInt;
  iLen: Integer;
  s1: String[1];

Begin
  with strm do begin
    if strm.Position >= strm.Size then
      raise Exception.Create('Input past end of stream');
    lPos := Position;
{Not Readbuffer}
    SetLength(result, 254);
    SetLength(result, Read(result[1], 254));

    iLen := Pos(CR, result);
    if iLen > 0 then begin
      SetLength(result, iLen - 1);
      Position := lPos + iLen + 1;
    end
    else {Move buffer to EOL}
			{Not very efficient, can improve}
      repeat
        Read(s1[1], 1);
      Until (s1 = CR) or StreamEOF(strm);
    if not StreamEOF(strm) then begin
      Read(s1[1], 1);
      If s1 <> LF then Position := Position - 1;
    end;
  end;
End;

function StreamReadLongLn(strm: TStream; var bEOL: Boolean; iSize: Integer): String;
{Read's a line from <strm> starting at current position
up to <ySize>. If no EOF before or including <ySize>, then bEOL will be false}
Var
	lPos: LongInt;
	iLen: Integer;
	c1: Char;
Begin
  with strm do begin
    if strm.Position >= strm.Size then
      raise Exception.Create('Input past end of stream');
    lPos := Position;
{Not Readbuffer}
    SetLength(result, iSize + 1);
    SetLength(result, Read(result[1], iSize + 1));

    iLen := Pos(CR, result);
    bEOL := (iLen > 0);
    if bEOL then begin
      SetLength(result, iLen - 1);
      Position := lPos + iLen + 1;
    end
    else
      if Length(result) = iSize + 1 then begin
        Position := Position - 1;
	SetLength(result, iSize);
      end;
// Can optimize to be included with above
    if not StreamEOF(strm) then begin
      Read(c1, 1);
      if c1 <> LF then Position := Position - 1;
    end;
  end;
End;

function StreamReadXChars(strm: TStream; const iChars: Integer): String;
begin
  SetLength(Result, iChars);
  strm.Read(Result[1], iChars);
end;

function RPos(const sSub, sIn: String; piStart: Integer): Integer;
//1995.06.01: Optimize using memory routines, or asm, or StrRPos
var
  y1, yLen: Integer;

begin
  result := 0;
  yLen := Length(sSub);
  if piStart = -1 then piStart := Length(sIn);
  For y1 := MinIntValue([Length(sIn) - yLen + 1, piStart]) downto 1 do begin
    if Copy(sIn, y1, yLen) = sSub then begin
      result := y1;
      break;
    end;
  end;
end;

function PosInStrArray(const SearchStr: string; Contents: array of string) : Integer;
begin
  for Result := Low(Contents) to High(Contents) do begin
    if SearchStr = Contents[Result] then
      Exit;
  end;
  Result := -1;
end;

function UpcaseFirst(s: string) : string;
begin {-Uppercases first character and lowercases the remaining ones}
  Result := LowerCase(s);
  if Result <> '' then
    Result[1] := UpCase(Result[1]);
end;

function StrToMonth(const sMonth: string): Byte;
begin {-No match, Result = 0} {CODED TO HANDLE MIS-USE IF UPCASE WAS SENT [Ozz]}
  Result := Succ(PosInStrArray(Uppercase(sMonth),
     ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC']));
end;

function StrToDay(const sDay: string): Byte;
begin {-No match, Result = 0} {CODED TO HANDLE MIS-USE IF UPCASE WAS SENT [Ozz]}
  Result := Succ(PosInStrArray(Uppercase(sDay),
    ['SUN','MON','TUE','WED','THU','FRI','SAT','SUN']));
end;

function IsNumeric(c: char): Boolean;
begin
  Result := IsCharAlphaNumeric(c) and not IsCharAlpha(c);
end;

function StringReplace(const S, OldPattern, NewPattern: string; Flags: TReplaceFlags): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then begin
    SearchStr := AnsiUpperCase(S);
    Patt := AnsiUpperCase(OldPattern);
  end else begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do begin
    Offset := Pos(Patt, SearchStr);
    if Offset = 0 then begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;

{used for stripping "<" and ">" from around a string}
  Function NoAngleBrackets(Const s: string): string;
  Begin
    Result := s;
    If (Copy(Result,1,1) = '<') and (Copy(Result, Length(Result), 1) = '>') then
      result := Copy(s, 2, Length(s) - 2);
  End;

Function TabPAD(S:String):String;
Begin
   Result:=S+CHAR32;
   While (Length(Result) mod 8)<>0 do Result:=Result+CHAR32;
End;

Function  Pad10(I:Integer):String;
Begin
try
   Result:=IntToStr(I);
Except
   Result:='1';
End;
   While Length(Result)<10 do Result:='0'+Result;
End;

Function OffsetFromUTC;
var
  iBias: Integer;
	tmez: TTimeZoneInformation;
const
  // CB3 and D3 do not have all of these
  TIME_ZONE_ID_INVALID = DWORD($FFFFFFFF);
  TIME_ZONE_ID_UNKNOWN  = 0;
  TIME_ZONE_ID_STANDARD = 1;
  TIME_ZONE_ID_DAYLIGHT = 2;
begin
  Case GetTimeZoneInformation(tmez) of
    TIME_ZONE_ID_INVALID:
      raise Exception.Create('Failed attempting to retrieve time zone information.');
    TIME_ZONE_ID_UNKNOWN  :
       iBias := Abs(tmez.Bias);
    TIME_ZONE_ID_DAYLIGHT :
      iBias := Abs(tmez.Bias + tmez.DaylightBias);
    TIME_ZONE_ID_STANDARD :
      iBias := Abs(tmez.Bias + tmez.StandardBias);
    else  raise Exception.Create('Failed attempting to retrieve time zone information.');
  end;
  Result := EncodeTime(iBias div 60, iBias mod 60, 0, 0);
end;


end.
