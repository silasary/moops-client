unit RGFileutil;
{
  Scooby's magic file utilities.

  Last modified : 16/7/97

  In Win32 you might want to use API FileCopy rather than the
  included CopyFile.
}

interface
uses SysUtils, LZExpand, Dialogs, WinProcs, WinTypes, forms, classes;

const
    NL = #10;

type
    ELZCopyError = class(exception);
    EWinExecError = class(exception);

function CopyFile(PFromFileName, PToFileName : PChar): Boolean;
function CatFiles(const SourceFile, DestFile: string): boolean;
function FileLen(f_name: string): Longint;
function DeleteFileSpec(filespec: string): integer;
procedure Log_Report(log_OutputName, log_InputName: string);
function ReadFlatKeyString(Filename, KeyName: string): string;
function ReadFirstHTMLTag(sHTMLFile, sTagName: string): string;
function FindFiles(
  FileSpec: string;
  var lstHits: TStringList;
  KeepPath: Boolean
): integer;

implementation


function CopyFile(PFromFileName, PToFileName : PChar): Boolean;
{ Corresponds to Delphi2 CopyAFile function ? }
var FromFile,ToFile: File;
    FromFileName, ToFileName: String;

Begin
    CopyFile := False;
    try
      FromFileName := StrPas(PFromFileName);
      ToFileName := StrPas(PToFileName);
      AssignFile(FromFile, FromFileName);
      AssignFile(ToFile, ToFileName);
      Reset(FromFile);
    except
      On E: EInOutError do begin
        {ShowMessage('Error Copying!');}
        CopyFile := False;
        exit;
      end;
    end;

    try
      try
        ReWrite(ToFile);
      except
        On E: EInOutError do begin
          // ShowMessage('Disk I/O error! ' + E.message);
          CopyFile := False;
          exit;
        end;
      end;

      try
        if LZCopy(TFileRec(FromFile).Handle, TFileRec(ToFile).Handle) < 0 then
        begin
          raise ELZCopyError.Create('Error copying file with LZCopy');
        end else begin
          CopyFile := True;
        end;
      finally
        CloseFile(ToFile);
      end;
    finally
      CloseFile(FromFile);
    end;
End;


function CatFiles(const SourceFile, DestFile: string): boolean;
{
  Appends SourceFile to DestFile.
}
const
  BUF_SIZE = 4096;
var
  strmSource, strmDest: TFileStream;
  Buffer: array[0..BUF_SIZE] of char;
  bytesRead: LongInt;
begin
  try
    strmSource := TFileStream.Create(SourceFile, fmOpenRead);
    if FileExists(DestFile) then
      strmDest := TFileStream.Create(DestFile, fmOpenWrite)
    else
      strmDest := TFileStream.Create(DestFile, fmCreate);

    strmDest.Seek(0, soFromEnd);
    try
      repeat
        bytesRead := strmSource.Read(Buffer, BUF_SIZE);
        strmDest.Write(Buffer, bytesRead);
      until bytesRead < Sizeof(Buffer);
      result := true;
    finally
      strmSource.Free;
      strmDest.Free;
		end;
	except
    On E: EInOutError do result := false;
  end;
end;


function FileLen(f_name: string): Integer;
{ Returns the size of a file given by a fully-qualified filename }
begin
  with TFileStream.Create(f_name, fmOpenRead) do try
    result := Size;
  finally free; end;
end;


procedure Log_Report(log_OutputName, log_InputName: string);
{
  Write to a report file using the entire contents of log_InputName.
  Where log_InputName begins with '*', this indicates verbatim text
  to be written to the log file.  When writing a new log file, attention
  is paid to the first letter of the filename and a header written accordingly.
}
const
  HDR_VIRUS = '--- One day Abnormal Virus Scan Log ---';
  HDR_HEADER = '--- One day HEADER.INI log ---';
  HDR_PROGRAM = '--- One day program operation log ---';
  HDR_REPORT = '--- One day REPORT.DAT log ---';
var
  Log_Out, Log_In:  Textfile;
  buf:              String;
begin
  try
    try
      {
        Open log for append if exists, otherwise create with
        default text.
      }
      AssignFile(Log_Out, log_OutputName);
      If FileExists(log_OutputName) then
        Append(Log_Out)
      else begin
        { New file }
        ReWrite(Log_Out);

        { Write report header }
        buf := lowercase(copy(ExtractFileName(log_OutputName), 1, 1));

        if      buf = 'v' then
          Writeln(Log_Out, HDR_VIRUS)

        else if buf = 'h' then
          Writeln(Log_Out, HDR_HEADER)

        else if buf = 'p' then
          Writeln(Log_Out, HDR_PROGRAM)

        else if buf = 'r' then
          Writeln(Log_Out, HDR_REPORT);
        writeln(Log_Out);
      end;

      {
        Append the entire input file (header, virus log, REPORT.DAT,
        (or take literal text from the '*'-prefixed Log_InputName)
        to the output file specified in Log_OutputName
      }
      writeln(Log_Out, FormatDateTime('hh:mm:ss :', now));
      if Copy(Log_InputName, 1, 1) <> '*' then begin
        AssignFile(Log_In, log_InputName);
        Reset(Log_In);
        writeln(Log_Out);
        try
          while not EOF(Log_In) do begin
            readln(Log_In, buf);
            writeln(Log_Out, buf);
          end;
        finally
          CloseFile(Log_In);
        end;
      end else begin
        buf := copy(Log_InputName, 2, length(Log_InputName));
        writeln(Log_Out, buf);
      end;
    finally
      CloseFile(Log_Out);
    end;
  except
    On exception do ; // Keep quiet, this is non-essential
  end;
end;


function DeleteFileSpec(filespec: string): integer;
{
  Delete all files matching a given fully-qualified filespec.
  *** USE WITH CAUTION. ***

      ^^^ You're intelligent.  You didn't need to know this.
}
var
  srHits:   TSearchRec;
  sPath:    string;
begin
  result := 0;
  try
    sPath := ExtractFilePath(filespec);
    if FindFirst(filespec, faAnyFile, srHits) = 0 then begin
      try
        repeat
          if DeleteFile(PChar(sPath + srHits.Name)) then
            inc(result);
        until FindNext(srHits) <> 0;
      finally
        Sysutils.FindClose(srHits);
      end;
    end;
  except
    on exception do ;
  end;
end;


function FindFiles(
  FileSpec: string;
  var lstHits: TStringList;
  KeepPath: Boolean
): integer;
{
  Returns a stringlist of files found using the supplied filespec.
  Does only one directory, for now, but may be expanded for recursion
  later.
}
var
  srHits:   TSearchRec;
  sPath:    string;
begin
  result := 0;
  lstHits.Clear;
  try
    sPath := ExtractFilePath(filespec);
    if FindFirst(filespec, faAnyFile, srHits) = 0 then begin
      try
        repeat
          If KeepPath then
            lstHits.Add(sPath + srHits.Name)
          else
            lstHits.Add(srHits.Name);

          inc(result);
        until FindNext(srHits) <> 0;
      finally
        Sysutils.FindClose(srHits);
      end;
    end;
  except
    on exception do ;
  end;
end;


function ReadFlatKeyString(Filename, KeyName: string): string;
{
  Will read an INI-style string value from a flat, sectionless (e.g. html)
  file.
}
var
  KeyFile:  TextFile;
  buf:      string;
  iPos:     Integer;
begin
  result := '';
  try
    try
      AssignFile(KeyFile, FileName);
      Reset(KeyFile);

      While not(EOF(KeyFile)) do begin
        { Read line by line til EOF }
        readln(KeyFile, buf);
        { Look for key }
        iPos := pos(lowercase(KeyName), lowercase(buf));
        if iPos <> 0 then begin
          buf := Trim(Copy(buf, iPos + 1, Length(buf)));
          iPos := pos('=', buf);
          If iPos <> 0 then result := Trim(copy(buf, iPos + 1, Length(buf)));
          break;
        end;
      end;
    finally
      CloseFile(KeyFile);
    end;
  except
    On E: Exception do begin
      result := '';
      {$ifdef DEBUG}
      Log_Report('C:\WINDOWS\DESKTOP\HAHA.LOG',
        '*FlatKey Exception: ' + E.Message);
      {$endif}
    end;
  end;
end;


function ReadFirstHTMLTag(sHTMLFile, sTagName: string): string;
{
  Read first value occurrence of a given HTML tag (e.g. H1, TITLE)
}
const
  TAG_START = '<';
  TAG_START_END = '</';
  TAG_END = '>';
var
  lSize:          Longint;
  pStart, pEnd:   PChar;
  Buffer, Target: PChar;
  HTML:           TFileStream;
  bytesRead:      Longint;
begin
  result := '';
  try
    If not FileExists(sHTMLFile) then exit;
    lSize := FileLen(sHTMLFile);

    Buffer := StrAlloc(Succ(lSize));
    Target := StrAlloc(Succ(Length(TAG_START_END) + Length(TAG_END)
      + Length(sTagName)));

    HTML := nil;
    try
      StrCopy(Target, PChar(TAG_START + sTagName + TAG_END));

      HTML := TFileStream.Create(sHTMLFile, fmOpenRead);
      bytesRead := HTML.Read(Buffer[0], lSize);
      if bytesRead = 0 then
        exit;

      Buffer[lSize] := #0;
      pStart := StrPos(Buffer, Target);
      If pStart <> nil then
        pStart := pStart + StrLen(Target)
      else
        exit;

      StrCopy(Target, PChar(TAG_START_END + sTagName + TAG_END));
      pEnd := StrPos(Buffer, Target);
      if pEnd = nil then exit;

      pEnd[0] := #0;

      result := StrPas(pStart);

      pEnd[0] := TAG_START;
    finally
      StrDispose(Buffer);
      StrDispose(Target);
      HTML.Free;
    end;
  except
    on Exception do result := '';
  end;
end;

end.
