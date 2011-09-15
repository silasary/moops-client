interface

{$I CompilerDefines.inc}

uses
  // This is an INC file!
	Classes;

// Procs
  function AddBackSlash(const S: string): string;
	function Fetch(var s1: string; const sDelim: string): string;
  function Pluck(const psSearchIn: string; psStart, psEnd: String; const pbIgnoreCase: boolean): String;
  function TrimWhiteSpace(const psString: string): string;
  procedure ParseCommaString(slst:TStrings;const strIn:string);
  function InvParseCommaString(slst: TStrings):string;
  //
  {$IFNDEF OVERLOADING}
  function Pad(const s: string; piCount: Integer; const pcPadChar: Char): string;
  {$ELSE}
  function Pad(const s: string; piCount: Integer; const pcPadChar: Char = ' ')
   : string;
  {$ENDIF}

implementation

uses
  // This is an INC file!
  SysUtils;

function InvParseCommaString(slst: TStrings):string;
var
	intIndex:integer;
begin
  // Take a stringlist and returns a string seperating items with commas
	result := '' ;
	for intIndex := 0 to Pred ( slst.Count ) do
  	result := result + slst.Strings[intIndex] + ',' ;
  result := Copy ( result, 1, Length (result) - 1 );
end ;

procedure ParseCommaString(slst:TStrings;const strIn:string);
var
    intStart,
    intEnd,
		intQuote,
    intPos,
    intLength : integer ;
    strTemp : string ;
begin
    intQuote := 0;
    intPos := 1 ;
    intLength := Length ( strIn ) ;
    slst.Clear ;
    while ( intPos <= intLength ) do
    	begin
      	intStart := intPos ;
        intEnd := intStart ;
        while ( intPos <= intLength ) do
        	begin
          	if strIn [ intPos ] = '"' then
            	inc(intQuote);
          	if strIn[ intPos ]= ',' then
            	if intQuote <> 1 then
              	break;
						inc ( intEnd ) ;
            inc ( intPos ) ;
          end ;
      strTemp := Trim ( Copy ( strIn , intStart , intEnd - intStart ) ) ;
      if strTemp <> '' then
      	slst.Add ( strTemp );
      intPos := intEnd + 1 ;
      intQuote := 0 ;
    end ;
end;

function Pluck;
var
  iStart, iEnd: integer;
  s: string;
begin
  if pbIgnoreCase then begin
    s := Uppercase(psSearchIn);
    psStart := Uppercase(psStart);
    psEnd := Uppercase(psEnd);
  end else begin
    s := psSearchIn;
  end;

  Result := '';
  iStart := Pos(psStart, s);

	iEnd := Pos(psEnd, Copy(s, iStart + Length(psStart), MaxInt)) + iStart;
  if iStart + iEnd > 0 then
 		Result := Copy(psSearchIn, iStart +  Length(psStart), iEnd - iStart-length(psEnd));
end;

function Pad;
begin
  if piCount < Length(S) then
    piCount := Length(S);
  SetLength(Result, piCount);
  FillChar(Result[1], piCount, pcPadChar);
  Move(S[1], Result[1], Length(S));
end;

function AddBackSlash(const S: string) : string;
var
  Len: Integer;
begin
  Result := S;
  Len := Length(Result);
  if Len = 0 then
    Result := '\'
  else if Result[Len] <> '\' then
    Result := Result + '\';
end;

Function Fetch;
var
	iPos: Integer;
begin
	iPos := Pos(sDelim, s1);
	If iPos = 0 then begin
		Result := s1;
		s1 := '';
	end else begin
		result := Copy(s1, 1, iPos - 1);
		Delete(s1, 1, iPos + Length(sDelim) - 1);
	end;
end;

function TrimWhitespace;
begin
  result := psString;
  {TODO Improve this - too many delets/setlenghts}
  while length(result) > 0 do begin
    if Ord(result[1]) < 33 then
      Delete(result, 1, 1)
    else
      break;
  end;
  while length(result) > 0 do begin
    if Ord(result[Length(result)]) < 33 then
      SetLength(result, Length(result) - 1)
    else
      break;
  end;
end;
