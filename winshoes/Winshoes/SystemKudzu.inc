interface

Uses
  // This is an INC file!
  // Also No link to forms
  Classes,
  Windows;

{$I CompilerDefines.inc}

Type
	TFileInfo = (fiCompanyName, fiFileDescription, fiFileVersion, fiIntName, fiLegalCopyright
   , fiLegalTradmark, fiOrigFilename, fiProductName, fiProductVersion, fiComments);

// Procs
  function CompareDateTime(adDate1, adDate2: TDateTime): Integer;
  function CompareInteger(anInt1, anInt2: Integer): Integer;
	procedure FileAppend(const asPathName, asData: string);
  function FileContents(const asPathname: string): string;
  procedure FileCopy(const asSourcePathname, asDestPathname: string; const abCanOverwrite: Boolean);
	procedure FileCreate(const asPathName, asData: string);
	// Writes sData to filename, creates if it does not exist.
	function FixPath(const asPath: string): string;
	function GetFileInfo(asFileName: string; axItem: TFileInfo): string;
  function GetPropertyList(pClassType: TClass): TList;
	function IsNumeric(const c1: Char): Boolean;
  function MakeTempFilename: string;
	function Minutes(const iMin: Integer): TDateTime;
  procedure NotImp;
	function PosInIntArray(const iLook: Integer; Search: array of Integer): Integer;
	function PosInStrArray(const sLook: string; Search: array of string): Integer;
	procedure RaiseWin32Error(const piErr: Integer; const psMsg: string);
	procedure RaiseLastWin32Err(const psMsg: string);
	procedure Shell(const asCmd, asFile: string; const abWait: Boolean);
	function StrToCard(asValue: string): DWord;
	function TempPath: string;
  {$IFNDEF SAMETEXT}
	function SameText(const S1, S2: string): Boolean;
  {$ENDIF}
  {$IFDEF OVERLOADING}
  function iif(const abValue: boolean; const asTrue, asFalse: string): string; overload;
  function iif(const abValue: boolean; const anTrue, anFalse: integer): integer; overload;
  {$ENDIF}
	//Return Temp dir - use gsTempPath instead

const
  BoolStr: array[Boolean] of string = ('False', 'True');
  BoolChar: array[Boolean] of Char = ('F', 'T');
  YesNoStr: array[Boolean] of string = ('No', 'Yes');
  CR = #13;
  LF = #10;
  TAB = #9;
  EOL = CR + LF;
  QT = '''';

var
  gsVoid: string = '';
  gsTempPath: String = '';
  gsAppPath: String = '';
  gsAppName: String = '';

implementation

uses
  // This is an INC file!
  // Also No link to forms
  SysUtils,
  TypInfo;

function GetPropertyList(pClassType: TClass): TList;
var
  i, iPropCount: integer;
	PropList: PPropList;
begin
  result := TList.Create; try
    iPropCount := GetTypeData(pClassType.ClassInfo)^.PropCount;
    if iPropCount > 0 then begin
      GetMem(PropList, iPropCount * SizeOf(Pointer)); try
        // GetPropInfos could also be used - but will return unsorted, and cannot be filtered
        iPropCount := GetPropList(pClassType.ClassInfo, tkProperties, PropList);
        for i := 0 to Pred(iPropCount) do
          Result.Add(PropList^[i]);
      finally FreeMem(PropList); end;
    end;
  except Result.Free; end;
end;

function MakeTempFilename;
begin
  SetLength(result, MAX_PATH + 1);
  GetTempFileName(PChar(gsTempPath), 'KDZ', 0, PChar(result));
  result := PChar(Result);
end;

Function TempPath;
Var
	i: integer;
begin
  SetLength(Result, MAX_PATH);
	i := GetTempPath(Length(Result), PChar(Result));
	SetLength(Result, i);

	If Copy(Result, Length(Result), 1) <> '\' Then
    Result := Result + '\'; {Will ONLY already have if C:\}
end;

procedure NotImp;
begin
  raise Exception.Create('Not implemented.');
end;

procedure RaiseLastWin32Err(const psMsg: string);
begin
	RaiseWin32Error(GetLastError, psMsg)
end;

procedure RaiseWin32Error(const piErr: Integer; const psMsg: string);
begin
	if piErr <> ERROR_SUCCESS then begin
		raise Exception.CreateFmt('Win32 Error. Code: %d.'#10'%s' + EOL + psMsg, [piErr, SysErrorMessage(piErr)])
	end else begin
		raise Exception.Create('A Win32 API function failed' + EOL + psMsg);
  end;
end;

function FixPath(const asPath: string): string;
begin
	Result := asPath;
	if Length(Result) > 0 then begin
		if Result[Length(Result)] <> '\' then begin
      result := Result + '\';
    end;
  end;
end;

procedure FileAppend;
begin
	with TFileStream.Create(asPathName, fmOpenWrite) do try
		Position := Size;
		WriteBuffer(asData[1], Length(asData));
	finally Free; end;
end;

procedure FileCreate;
begin
	with TFileStream.Create(asPathName, fmCreate) do try
  	if Length(asData) > 0 then begin
			WriteBuffer(asData[1], Length(asData));
    end;
	finally Free; end;
end;

procedure FileCopy;
begin
	if CopyFile(PChar(asSourcePathname), PChar(asDestPathname), not abCanOverwrite) = False then begin
  	{TODO change this to raisegetlasterror}
		raise Exception.Create('Copy Failed (' + IntToStr(GetLastError) + '): ' + asDestPathname);
  end;
end;

function FileContents;
begin
	Result := '';
	if FileExists(asPathName) then begin
		with TFileStream.Create(asPathName, fmOpenRead) do try
      if Size > 0 then begin
        SetLength(Result, Size);
        ReadBuffer(Result[1], Size);
      end;
		finally Free; end;
	end;
end;

function CompareInteger;
begin
	if anInt1 > anInt2 then begin
  	result := 1;
  end else if anInt2 > anInt1 then begin
  	result := -1;
  end else begin
  	result := 0;
  end;
end;

function CompareDateTime;
begin
	if adDate1 > adDate2 then begin
  	result := 1;
  end else if adDate2 > adDate1 then begin
  	result := -1;
  end else begin
  	result := 0;
  end;
end;

function IsNumeric(const c1: Char): Boolean;
begin
	Result := IsCharAlphaNumeric(c1) and not IsCharAlpha(c1);
end;

function Minutes(const iMin: Integer): TDateTime;
begin
	Result := EncodeTime(iMin div 60, iMin mod 60, 0, 0);
end;

function PosInIntArray;
var
	i1: integer;
begin
	result := -1;
	for i1 := low(Search) to high(Search) do begin
  	if iLook = Search[i1] then begin
    	result := i1;
    	break;
    end;
  end;
end;

function PosInStrArray;
var
	i1: integer;
begin
	result := -1;
	for i1 := low(Search) to high(Search) do begin
  	if sLook = Search[i1] then begin
    	result := i1;
    	break;
    end;
  end;
end;

procedure Shell;
var
	PCmd: PChar;
	StartInfo: TStartupInfo;
	ProcInfo: TProcessInformation;
begin
	// Fill with known state
	FillChar(StartInfo, SizeOf(TStartupInfo), #0);
	FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
	StartInfo.cb := SizeOf(TStartupInfo);

	if length(asCmd) = 0 then begin
    PCmd := nil
  end else begin
    PCmd := PChar(asCmd);
  end;

	if CreateProcess(PCmd, PChar(asFile), nil, nil, False, NORMAL_PRIORITY_CLASS, nil, nil, StartInfo
   , ProcInfo) then begin
			if abWait then begin
        WaitForSingleObject(ProcInfo.hProcess, INFINITE)
      end;
  end else begin
    RaiseLastWin32Err('Shell: ' + asCmd + ' : ' + asFile);
  end;
end;

const
  cCompName = 'CompanyName';
  cFileDesc = 'FileDescription';
  cFileVer  = 'FileVersion';
  cIntName  = 'InternalName';
  cLegCopy  = 'LegalCopyright';
  cLegTrad  = 'LegalTrademarks';
  cOrgFile  = 'OriginalFilename';
  cProdName = 'Productname';
  cProdVer  = 'ProductVersion';
  cComments = 'Comments';

function GetFileInfo;
var
  Buffer: string;
  LangCharset: ^longint;
  Value: pointer;
  Len: DWORD;
  sItem: string;
begin
	case axItem of
		fiCompanyName: sItem := 'CompanyName';
    fiFileDescription: sItem := 'FileDescription';
    fiFileVersion: sItem := 'FileVersion';
    fiIntName: sItem := 'InternalName';
    fiLegalCopyright: sItem := 'LegalCopyright';
    fiLegalTradmark: sItem := 'LegalTrademarks';
    fiOrigFilename: sItem := 'OriginalFilename';
    fiProductName: sItem := 'Productname';
    fiProductVersion: sItem := 'ProductVersion';
    fiComments: sItem := 'Comments';
  end;
  Result := '';
  Len := GetFileVersionInfoSize(PChar(asFileName), Len);
  If Len > 0 then begin
    SetLength(Buffer,Len);
    If GetFileVersionInfo(PChar(asFileName), 0, Len, PChar(Buffer)) then begin
			VerQueryValue(PChar(Buffer), '\VarFileInfo\Translation', pointer(LangCharset), Len);
      If VerQueryValue(PChar(Buffer), PChar('\StringFileInfo\' + IntToHex(LoWord(LangCharset^),4)
       + IntToHex(HiWord(LangCharset^),4) + '\' + sItem), Value, Len) then begin
        Result := PChar(Value);
      end;
    end;
  end;
end;

{$IFDEF OVERLOADING}
function iif(const abValue: boolean; const asTrue, asFalse: string): string; overload;
begin
	if abValue then begin
  	result := asTrue;
  end else begin
  	result := asFalse;
  end;
end;

function iif(const abValue: boolean; const anTrue, anFalse: integer): integer; overload;
begin
	if abValue then begin
  	result := anTrue;
  end else begin
  	result := anFalse;
  end;
end;
{$ENDIF}

function StrToCard(asValue: string): DWord;
var
  i: integer;
  nDigit: DWord;
begin
  result := 0;
	for i := 1 to length (asValue) do begin
  	// nDigit is split out to avoid widening of operands warning
  	nDigit := ord(asValue[i]) - ord('0');
  	result := (result * 10) + nDigit;
	end;
end;

{$IFNDEF SAMETEXT}
function SameText(const S1, S2: string): Boolean;
begin
	result := CompareText(S1, S2) = 0;
end;
{$ENDIF}

initialization
  gsAppPath := FixPath(ExtractFilePath(ParamStr(0)));
  gsAppName := ChangeFileExt(ExtractFilename(ParamStr(0)), '.nul');
  SetLength(gsAppName, Length(gsAppName) - 4);
  gsTempPath := TempPath;
