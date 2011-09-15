unit RGStrFuncs;
{***************************************************************************}
{*                                                                         *}
{*   An ever-expanding magical set of string functions.                    *}
{*                                                                         *}
{*   Author : R.Garner      Last Modified :  16/7/97                       *}
{*                                                                         *}
{***************************************************************************}

interface
uses
    SysUtils, Classes, Dialogs, INIFiles, Windows;

procedure Fill_StringList(var StrLst: TStringList;
                              delimited_text: string;
                              delimiter: Char);

procedure WordWrapToList(StrLst:    TStringList;
                         SrcText:   String;
                         Delimiter: Char;
                         width:     Integer);

function Add_Slash(path: string): string;
function Kill_Slash(path: string): string;
function Add_UNIXSlash(path: string): string;
function Expand_Amp(caption: string): string;
function Strip_Amp(s: string): string;
function ExtractFilePre(filename: string; with_path: Boolean): string;
function ExtractFilePreNoDot(filename: string; with_path: Boolean): string;
function PosLastOccur(SubStr: String; S: String): Integer;
function ReverseString(S: String): String;
function StripDOSChars(filename: string): string;
function LastPathPart(sDirName: string; sPathSep: string): string;
function ParentDir(sDirName: string; sPathSep: string): string;
function ShortPath(filename: string): string;
function FindInStringList(SearchList: TStringList; item: string): integer;
function QuoteOnDelim(s, sDelim: string): string;
procedure SetCommaText(sList: TStringList; const Value: string);
function LeftPad(sString: string; nLength: Integer; cPadChar: Char): string;
function StripChar(text: string; ch: char): string;
function ExtractUNIXFilePath(const FileName: string): string;
function ExtractUNIXFileName(const FileName: string): string;

//******************************************************************************
implementation
//******************************************************************************
function LeftPad(sString: string; nLength: Integer; cPadChar: Char): string;
{
  Pad sString to the left with enough cPadChar characters to bring it up
  to nLength in length.
}
var
  i: Integer;
begin
  If Length(sString) >= nLength then begin
    result := sString;
    exit;
  end;

  result := sString;

  for i := 1 to nLength - Length(sString) do
    result := cPadChar + result;
end;

function ReverseString(S: String): String;
{
  What?  You want a *comment* for this?
}
var
    i: Integer;
begin
    result := S;    // Make sure string is big enough to receive
    For i := Length(S) downto 1 do
        result[Length(S) - i + 1] := S[i];
end;


function PosLastOccur(SubStr: String; S: String): Integer;
{
  Returns the position of the last given occurrence of a substring
  0 if not found.
  Uses ReverseString.
}
begin
    If Pos(ReverseString(SubStr), ReverseString(S)) <> 0 then
        result := Length(S) - Pos(ReverseString(SubStr), ReverseString(S)) + 1
    else
        result := 0;
end;


procedure WordWrapToList(StrLst:    TStringList;
                         SrcText:   String;
                         delimiter: Char;
                         width:     Integer);
{
  Wraps a chunk of text to a width specified by the 'width' parameter,
  strangely.  Fills your stringlist with lines of this max width.
}
var
    Work:           String;     // Work buffer
    segpos:         Integer;    // Segment of text (modulo width) looked at
    poslast:        Integer;    // Position of last delimiter in segment
begin
    If Length(SrcText) = 0 then exit;

    // Split SrcText up into width-sized segments
    segpos := 1;
    repeat
        Work := Copy(SrcText, segpos, width);
        posLast := PosLastOccur(delimiter, Work);
        If (posLast <> 0) and (Length(Work) = width) then begin
            // Wrap the line
            StrLst.Add(Copy(Work, 1, posLast - 1));
            segpos := segpos + posLast;   // Look at next segment
        end else begin
            // Truncate the whole buffer :(
            StrLst.Add(Work);
            segpos := segpos + width;
        end; {if}

    until  segpos >= Length(SrcText);
end;    {Word_WrapToList}


function ExtractFilePre(filename: string; with_path: Boolean): string;
{
  Extracts file name w/out extension ... e.g.
  ExtractFilePre('C:\ODI\BTPRINT.EXE', True) = 'C:\ODI\BTPRINT.'
}
var
    iDotPos: Integer;
begin
    result := filename;
    If not with_path then
        result := ExtractFileName(filename);

    iDotPos := poslastoccur('.', result);
    If iDotPos <> 0 Then
        result := Copy(result, 1, iDotPos)
    else
        result := result + '.';
end;    {ExtractFilePre}


function ExtractFilePreNoDot(filename: string; with_path: Boolean): string;
{
  Extracts file name w/out extension ... e.g.
  ExtractFilePre('C:\ODI\BTPRINT.EXE', True) = 'C:\ODI\BTPRINT.'
}
var
    iDotPos: Integer;
begin
    result := filename;
    If not with_path then
        result := ExtractFileName(filename);

    iDotPos := poslastoccur('.', result);
    If iDotPos <> 0 Then
        result := Copy(result, 1, iDotPos - 1)
end;    {ExtractFilePreNoDot}


function Expand_Amp(caption: string): string;
{
  Expand ampersands in a string to avoid the '_' character
  in TWinControls.  NEW!  Now it's recursive!  Hurrah!
  What do you mean, what's the use????  It's more compact, OK?
  And there's more chance of a stack overflow, which just
  *adds* to the fun.  Hmph.  Oh, and you could probably set ShowAccelChars
  to False.  So this function is useless.  Hmm.
}
var
    pAmp: Integer;
begin
    pAmp := Pos('&', caption);

    if pAmp = 0 then
      Expand_amp := caption
    else
      Expand_amp := copy(caption, 1, pAmp) + '&' +
                      Expand_amp(
                        copy(caption, pAmp + 1, length(caption) - pAmp + 1));
end;    {Expand_Amp}


function Strip_Amp(s: string): string;
{
  Strips double-ampersands for non-accel-charred display.
  Direct colleague of Expand_Amp.
}
var
  iPos: integer;
begin
  iPos := Pos('&&', s);
  if iPos = 0 then
    result := s
  else
    result := copy(s, 1, iPos) + Strip_Amp(copy(s, iPos + 2, Length(s)));
end;


function Add_Slash(path: string): string;
{
  Simply add a backslash to pathnames if it isn't there already.
  Probably a bit extravagant, but who cares?
}
begin
    try
        If copy(path, Length(path), 1) <> '\' then
            result := path + '\'
        else
            result := path;
    except
        On Exception do result := path;
    end;
end;    {Add_Slash}


function Add_UNIXSlash(path: string): string;
{
  Simply add a backslash to pathnames if it isn't there already.
  Probably a bit extravagant, but who cares?
}
begin
    try
        If copy(path, Length(path), 1) <> '/' then
            result := path + '/'
        else
            result := path;
    except
        On Exception do result := path;
    end;
end;    {Add_Slash}


function Kill_Slash(path: string): string;
{
  Remove the trailing backslash for the same reasons
}
begin
    try
        If ((copy(path, Length(path), 1) = '\') or
          (copy(path, Length(path), 1) = '/')) and
          (Length(path) > 1) then
          result := copy(path, 1, Length(path) - 1)
        else
            result := path;
    except
        On Exception do result := path;
    end;
end;    {Kill_Slash}


procedure Fill_StringList(var StrLst: TStringList;
                              delimited_text: string;
                              delimiter: Char);
{
  Takes a StringList, some delimited text and a delimiter and
  fills the string list from the text with items separated by
  delimiter
}
var
    Work: string;
    del_pos: integer;

begin
    If Length(delimited_text)=0 then begin
        showmessage('Fill_StringList : delimited_text length 0!');
        exit;
    end;

    Work := delimited_text;
    StrLst.Clear;
    
    repeat
        del_pos := Pos(delimiter, Work);
        If (del_pos = 0) Then begin
            If Length(Work)>0 Then StrLst.Add(Work);
            exit;
        end else
            StrLst.Add(Copy(Work, 1, del_pos - 1));
        {Make work shorter}
        Work := Copy(Work, del_pos + 1, Length(Work) - del_pos);
    until del_pos = 0;
end;    {Fill_StringList}


function StripDOSChars(filename: string): string;
{
  Rip characters that are illegal in a DOS or 95 filename.
  At last muster, these were :-
  \ / : * ? " < > |
}
type
  TCharSet = set of char;
const
  DOSChars: TCharSet = ['\', '/', ':', '*', '?', '"', '<', '>', '|'];
var
  i, j: Integer;
begin
  result := filename;

  j := 1;
  for i := 1 to length(filename) do begin
    if not(filename[i] in DOSChars) then begin
      result[j] := filename[i];
      inc(j);
    end;
  end;

  { Truncate result to real length }
  result := copy(result, 1, j - 1);
end;


function LastPathPart(sDirName: string; sPathSep: string): string;
{
  Return everything following the last *valid* occurrence of sPathSep in
  sDirName -
  eg: /project/news/foo returns foo
      /whee/splat/ returns splat
}
var
  iPos: Integer;
begin
  iPos := PosLastOccur(sPathSep, Kill_Slash(sDirName));
  if iPos = 0 then
    result := ''
  else
    result := copy(sDirName, Succ(iPos), Length(sDirName));
end;


function ParentDir(sDirName: string; sPathSep: string): string;
{
  Return the parent of a given dir or similarly-qualified path -
  eg: /project/news/foo returns /project/news/
      /whee/splat/      returns /whee/
      //whee//splat//   returns //whee
}
var
  iPos: integer;
begin
  try
    iPos := PosLastOccur(sPathSep, sDirName);
    If iPos = 1 then begin
      result := sPathSep;
      exit;
    end;

    If iPos = (Length(sDirName) - (Length(sPathSep) + 1)) then
      // Kill separators that exist at the end of lines.
      // Caters for > 1 char separators
      result := ParentDir(Copy(sDirName, 1, (iPos - Length(sPathSep))), sPathSep)
    else
      result := Copy(sDirName, 1, Pred(iPos));
  except
    On Exception do
      result := '';
  end;
end;


function ShortPath(filename: string): string;
{
  Return a short DOS path from a long filename
}
var
  lpShortWork: PChar;
begin
  try
    result := '';
    lpShortWork := StrAlloc(255);
    try
      GetShortPathName(PChar(Kill_Slash(filename)), lpShortWork, 255);
      result := StrPas(lpShortWork);
    finally
      StrDispose(lpShortWork);
    end;
  except
    On Exception do ;
  end;
end;


function FindInStringList(SearchList: TStringList; item: string): integer;
{
  A non-case-sensitive function version of the stringlist's Find method.
  returns -1 if not found, item index otherwise.
}

var
  i: Integer;
begin
  result := -1;
  try
    for i := 0 to SearchList.Count - 1 do begin
      If LowerCase(SearchList.Strings[i]) = LowerCase(item) then begin
        result := i;
        exit;
      end;
    end;
  except
    on exception do ;
  end;
end;


function QuoteOnDelim(s, sDelim: string): string;
{
  If a given delimiter (',', say) occurs in s,
  surround s with quotation marks.
}
const
  C_QUOTE = '"';
begin
  If pos(sDelim, s) <> 0 Then
    result := C_QUOTE + S + C_QUOTE
  else
    result := s;
end;


procedure SetCommaText(sList: TStringList; const Value: string);
{
  Miles of snaffled, inscrutable, uncommented VCL code, which
  takes a double-quoted, comma-delimited line (value) and creates
  a stringlist out of the individual values.
  e.g.
    "Hello, you",1,3 ->
    Hello, you
    1
    3
  (Bugfixed by Scooby)
}
var
  P, P1, P2: PChar;
  S: string;
  Text: array[0..4095] of Char;
begin
  sList.Clear;
  StrLCopy(Text, PChar(Value), SizeOf(Text) - 1);
  P := Text;
  while (P^ <> #0) and (P^ <= ' ') do Inc(P);
  if P^ <> #0 then
    while True do begin
      P1 := P;
      if P^ = '"' then begin
        P2 := P;
        Inc(P);
        while P^ <> #0 do begin
          if P^ = '"' then begin
            Inc(P);
            if P^ <> '"' then Break;
          end;
          P2^ := P^;
          Inc(P2);
          Inc(P);
        end;
      end else begin
        while (P^ >= ' ') and (P^ <> ',') do Inc(P);
        P2 := P;
      end;
      SetString(S, P1, P2 - P1);
      sList.Add(S);
      while (P^ <> #0) and (P^ <= ' ') do Inc(P);
      if P^ = #0 then Break;
      if P^ = ',' then begin
        Inc(P);
        while (P^ <> #0) and (P^ <= ' ') do Inc(P);
      end;
    end;
end;


function StripChar(text: string; ch: char): string;
{
  Strip a given character from a string
}
var
  i, j : integer;
begin
  result := text;
  j := 1;
  for i := 1 to length(text) do begin
    if not(text[i] = ch) then begin
      result[j] := text[i];
      inc(j);
    end;
  end;
  { Truncate result to real length }
  result := copy(result, 1, j - 1);
end;


function ExtractUNIXFilePath(const FileName: string): string;
var
  I: Integer;
begin
  I := Length(FileName);
  while (I > 0) and not (FileName[I] = '/') do Dec(I);
  Result := Copy(FileName, 1, I);
end;


function ExtractUNIXFileName(const FileName: string): string;
var
  I: Integer;
begin
  I := PosLastOccur('/', FileName);
  Result := Copy(FileName, I + 1, Length(FileName));
end;


end.
