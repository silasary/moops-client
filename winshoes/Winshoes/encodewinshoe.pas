unit EncodeWinshoe;

{
1999.06.20:
  -Added full decoding support to this and WinshoeMessage
1999.06.17:
  -Only supports MIME. UUE and XXE are outdated, and rarely used.
   (UUE is occasionally, but pretty rare)
1999.04.04
  -Fixed Base64 Encoding Problem
1998.08.16
  -Removed QQE support - was incomplete, cannot find documentation
   , and it is rarely if at all used by anyone anymore
}

interface

Uses
	Classes
  , GlobalWinshoe;

Type
	TWinshoeCoder = class
  public
    class procedure InitTables;
  end;

  {TODO Change this to be a class unto itself to be passed into function}
  TWriteLnEvent = procedure(Sender: TWinshoeCoder; const psData: string) of object;

	TWinshoeEncoder = class(TWinshoeCoder)
	private
		fOnWriteLn: TWriteLnEvent;
	protected
		Procedure DoWriteLn(objc: TObject; const sOut: String);
	public
    procedure EncodeFile(objc: TObject; const psFile: string);
		// Can accept TStrings, TStream, or nil.
    // If nil, OnWriteLnEvent will be fired for each line
    class function EncodeUnit(sIn: ShortString): string;
    class function EncodeLine(const sIn: ShortString): string;
    //
		property OnWriteLn: TWriteLnEvent read fOnWriteLn write fOnWriteLn;
	end;

	TWinshoeDecoder = class(TWinshoeCoder)
	private
	protected
	public
		Procedure DecodeFile(pstrm: TStream; const psFile: string);
    class function DecodeLine(const psIn: String): ShortString;
    class function DecodeUnit(const psIn: String): ShortString;
	end;

const
	CodeTable: String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

var
  // MIME only right now
  DecodingTable: String;

implementation

Uses
	Forms
  , SysUtils
  , Winshoes, WinProcs, WinTypes;

procedure TWinshoeEncoder.DoWriteLn;
begin
	// Could be optimized by using the original method, making sep procs, and using them, but this is
  // more maintable, and not  much slower
	if objc is TStrings then begin
		TStrings(objc).Add(sOut);
	end else if objc is TStream then begin
		StreamWriteLn(TStream(objc), sOut);
	end else if objc is TWinshoeClient then begin
		TWinshoeSocket(objc).WriteLn(sOut);
	end else if objc = nil then begin
		if Assigned(OnWriteLn) then
      OnWriteLn(Self, sOut)
    else
      raise Exception.Create('No Event Defined');
	end else begin
    raise exception.Create('Unsupported Write Object in Encoder.');
  end;
end;

class function TWinshoeEncoder.EncodeUnit;
var
  iLen: integer;
begin
  {TODO Re add support for XXE and UUE, only does MIME properly right now}
  result := '====';

  iLen := Length(sIn);
  if iLen < 3 then
    sIn := Copy(sIn + #0#0, 1, 3);

  // Need and 63?
  result[1] := CodeTable[((Ord(sIn[1]) SHR 2) and 63) + 1];
  result[2] := CodeTable[(((Ord(sIn[1]) SHL 4) or (Ord(sIn[2]) SHR 4)) and 63) + 1];

  if iLen = 2 then begin
    result[3] := CodeTable[(((Ord(sIn[2]) SHL 2)) and 63) + 1];
  end else if iLen = 3 then begin
    result[3] := CodeTable[(((Ord(sIn[2]) SHL 2) or (Ord(sIn[3]) SHR 6)) and 63) + 1];
    result[4] := CodeTable[(Ord(sIn[3]) and 63) + 1];
  end;
end;

class function TWinshoeEncoder.EncodeLine;
var
  iIn: Integer;
begin
  result := '';
  iIn := 1;
  While iIn <= Length(sIn) do begin
    result := result + EncodeUnit(Copy(sIn, iIn, 3));
    Inc(iIn, 3);
  end;
end;

class function TWinshoeDecoder.DecodeLine;
var
  i: Integer;
begin
  result := '';
  for i := 0 to ((Length(psIn) div 4) - 1) do
    Result := Result + DecodeUnit(Copy(psIn, i * 4 + 1, 4));
end;

procedure TWinshoeEncoder.EncodeFile;
var
	strmIn: TFileStream;
	sIn, sOut: ShortString;
	lBytesIn: LongInt;
begin
  strmIn := TFileStream.Create(psFile, fmShareDenyWrite); try
    if objc is TWinshoeSocket then
      TWinshoeSocket(objc).BeginWork (strmIn.Size);
    try
      SetLength(sIn, 45);
      while true do begin
        lBytesIn := strmIn.Read(sIn[1],	Length(sIn));
        if lBytesIn = 0 then
          break;
        SetLength(sIn, lBytesIn);
        sOut := EncodeLine(sIn);
        DoWriteLn(objc, sOut);
        if objc is TWinshoeSocket then
          TWinshoeSocket(objc).DoWork(strmIn.Position);
      end;
    finally
      if objc is TWinshoeSocket then
        TWinshoeSocket(objc).EndWork;
    end;
  finally strmIn.Free; end;
	DoWriteLn(objc, '');
end;

procedure TWinshoeDecoder.DecodeFile;
var
	strmOut: TFileStream;
	sIn, sOut: ShortString;
begin
  strmOut := TFileStream.Create(psFile, fmCreate); try
    while true do begin
      sIn := StreamReadLn(pstrm);
      if length(sIn) = 0 then
        break;
      sOut := DecodeLine(sIn);
      strmOut.WriteBuffer(sOut[1], Length(sOut));
    end;
  finally strmOut.Free; end;
end;

class procedure TWinshoeCoder.InitTables;
var
  i: Integer;
  s: string;
begin
  SetLength(DecodingTable, 127);
  s := CodeTable;
  for i := 1 to length(s) do
    DecodingTable[Ord(s[i])] := chr(i - 1);
end;

class function TWinshoeDecoder.DecodeUnit;
var
  y1, y2, y3, y4: Byte;
begin
  if length(psIn) <> 4 then
    raise Exception.Create('DecodeUnit length error.');

  y1 := Ord(DecodingTable[Ord(psIn[1])]);
  y2 := Ord(DecodingTable[Ord(psIn[2])]);
  y3 := Ord(DecodingTable[Ord(psIn[3])]);
  y4 := Ord(DecodingTable[Ord(psIn[4])]);

  SetLength(result, 3);
  result[1] := chr((y1 shl 2) or (y2 shr 4));
  result[2] := chr((y2 shl 4) or (y3 shr 2));
  result[3] := chr((y3 shl 6) or y4);

  if psIn[3] = '=' then
    SetLength(Result, 1)
  else if psIn[4] = '=' then
    SetLength(Result, 2)
end;

initialization
  TWinshoeCoder.InitTables;
end.
