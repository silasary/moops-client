unit SimpFTP;
//
// Define debug (remove 'x') if you wish OutputDebugString
// to output unhandled WinInet status callbacks.
// Define USING_IE5 (remove 'x') to implement FtpCommand functionality
// (only available with IE5 or higher WinInet or Windows CE :) )
//
{$define xDEBUG}
{.$define USING_IE5}
//
//  Defines for cross-version compatibility.  Delphi 2 is still supported
//  but is no longer actively being tested with each release
//
{$ifndef VER80}
  {$ifndef VER90}
    {$define D3ORHIGHER}
  {$endif}
{$endif}
{
  VER80   : Delphi 1 - not supported
  VER90   : Delphi 2 - supported with modified WinInet (WinInetMod) unit
  VER100  : Delphi 3   Supported through D3ORHIGHER define
  VER120  : Delphi 4       "        "         "       "
  VER130  : Delphi 5       "        "         "       "
}
{
  Delphi wrapper for the WinInet.dll FTP functions.  Tries to remove the
  complexities that TFTP introduced for those just wishing to get/put files
  and look at simple progress information.

  Author: R Garner, 16/7/97

  Last Modified on : 01/11/99

  Version 0.99e: 01/11/99
    un-Fixed minor "memory leak" which wasn't in privFTPFindFiles.  D'oh.
    Thanks, Steve H :)

  Version 0.99d: 23/10/99
    Removal of About box (to avoid dsgnintf issue).  Fixed mis-reporting
    of file size in Progress event on finish.  Fixed minor memory
    leak in privFTPFindFiles.

  Version 0.99c: 8/5/99
    Cleaned up conditional defines - USING_IE5 is no longer the default!

  Version 0.99b: 22/04/99
    Winshoes Code Freeze version
    FTPCommand and Abort methods implemented (Abort from WinInetControl, see
    caveat )

  Version 0.99:  17/04/99
    Further mods arising from inheritance from TWinInetControl, plus clean-up
    of a few ex-fudges around GetCurrentDirectory (again)!

  Version 0.98:  15/04/99
      Fixed a nasty Overlapped I/O error caused in GetRemoteDir.  See MS KB
      article Q187770.  Am working around it by unregistering and re-registering
      the synchronous callback.  Have also fixed other GetCurrentDirectory-
      related issues which were previously being worked around.

  Version 0.98b: 08/04/99
      Separated into two classes, TWinInetControl and descendant TSimpleFTP
      to isolate WinInet-specific and FTP-specific functions.  This will
      also allow easier creation of HTTP and/or Gopher (?!) controls ...

  Version 0.97 : 30/03/99
      Compiler version defines added for future Delphi compatibility
      Removed ClassExplorer Lint (temporarily) from  end of code.  I'll
      put this back when there's a version of ClassExplorer that'll dock
      properly with Delphi 4 or greater that can adequately replace the
      Code Explorer.  Anybody who might actually have been compiling help
      files from said lint - apologies!

  Version 0.96b:
    Bugs Fixed / Features Added:
      Combined bugfix/feature - connecting to a mainframe (MVS) system would not
      allow 'directory' changing since WinInet returned 'false' to the change
      request even though it was successful (!) For example, changing the
      'directory name prefix' from 'ZEPD0.' to a null prefix with a call to
      FTPSetDirectory('..') would return false ... why I don't know,
      ask Microsoft (again) :)

      This has necessitated the addition of a 'FileSystemType' property, also
      useful for those circumstances where a Unix slash (/) is not appropriate.

  Version 0.95b: 22/02/99
    Bugs Fixed:
      Public LastError property now works
      Fixed resource leak from commenting out part of Destroy(!)
      Fixed the fact that I used to ignore the Port property :/
      File '0 of 0' on quickstatus fixed
    Features added:
      OnConnect/OnDisconnect plain notify events
      OnLogin for people who like to work that way
      List method and OnFindItem events now included
      Timeout property now allows connections to time out (see caveat below)
      QuickStatus for *really* lazy people
      SilentExceptions property - exceptions are now available for connect
      errors only
      TranslateStatusText function added to get meaningful string values for
      TWinInetState variables (though you may prefer to use QuickStatus)
    Known Bugs:
      Timeout length options don't work, see
      http://support.microsoft.com/support/kb/articles/q176/4/20.asp
      This will be fixed when Microsoft get around to it ... I'm not messing
      about with timers at my time of life, guv.

  Initial release: 0.9b 27/09/97
}
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$ifdef D3ORHIGHER}WinInet{$else}WinInetMod{$endif}, comctrls, stdctrls,
  WinInetControl;

// Use resourcestring only if Delphi3/4, otherwise, pretend we have constants.
{$ifdef D3ORHIGHER}
resourcestring
{$else}
const
{$endif}
  S_INDEXBOUNDERROR                     = 'File index is out of bounds.';
  S_OF                                  = ' of ';
  S_NOFINDDATA                          = 'No file information at this index.';

  S_ERROR_CREATING_DIR                  = 'Error creating directory %s';
  S_ERROR_REMOVING_DIR                  = 'Error removing directory %s';
  S_ERROR_CHANGING_DIR                  = 'Couldn''t change to directory %s';
  S_ERROR_CHANGING_FILESYSTEM           =
    'Cannot change file system type when connected';
  S_ERROR_DELETING_FILE                 = 'Error deleting %s';
  S_ERROR_RENAMING_FILE                 = 'Error renaming file from %s to %s';
  S_ERROR_PUTTING_FILE                  = 'Error putting %s to %s';
  S_ERROR_PUTTING_FILE_NOT_FOUND        =
    'Error putting %s to %s: local file not found';
  S_ERROR_GETTING_FILE                  = 'Error getting %s from %s';
  S_ERROR_GETTING_FILE_NOT_FOUND        =
    'Error getting %s to %s: remote file not found';
  S_ERROR_GETTING_REMOTEDIR             = 'Error getting remote directory - ' +
                                          'last known used (%s)';
  S_ERROR_GETTING_COMMAND_RESPONSE      =
    'Error getting reponse from command %s';

  S_ERROR_SENDING_COMMAND               = 'Error sending site command %s';
  S_REASON_NOTCONNECTED                 = 'Not connected';

  S_XFER_BYTES                          = 'bytes';
  S_XFER_KB                             = 'KB';
  S_XFER_MB                             = 'MB';

type
  ESimpleFTPError = class(Exception);
  // Binary or Ascii transfer mode?
  TFTPTransferType = (ttBinary, ttAscii, ttUnknown);
  TFTPFileSystemType = (ftUnix, ftUnknown);

  TFTPProgressInfo = record
    Minor,
    MinorMax,
    Major,
    MajorMax:     Longint;
    CurrentFile:  String;
  end;

  {
    Major/Minor progress percentages
  }
  TTransferProgressEvent = procedure (
    Sender:       TObject;
    ProgressInfo: TFTPProgressInfo
  ) of object;

  TFindItemEvent = procedure (
    Sender: TObject;
    FindData: TWin32FindData
  ) of object;

  TLoginEvent = procedure (
    Sender: TObject;
    var UserName, Password: string
  ) of object;

  TSimpleFTP = class(TWinInetControl)
  private
    { Private declarations }

    FLocalDir,
    FMOTD,
    FRemoteDir:           string;

    FTransferType:        TFTPTransferType;
    FAPI_TransferType:    DWORD;

    FFileList:            TStringList;

    FFailIfExistsOnGet:   Boolean;

    FhFtp:                HINTERNET;

    FOnLogin:             TLoginEvent;
    FOnTransferProgress:  TTransferProgressEvent;

    {
      Non-field private class globals
    }
    ProgressInfo:         TFTPProgressInfo;
    FOnFindItem:          TFindItemEvent;
    FPassive: boolean;
    FFileSystemType:      TFTPFileSystemType;
    FOnDirectoryChange: TNotifyEvent;

    function  Add_UNIXSlash(path: string): string;
    function  GetFileInfo(Index: Integer): TWin32FindData;
    procedure SetRemoteDir(NewDir: string);
    procedure SetTransferType(NewType: TFTPTransferType);
    procedure ClearFindDataList(lstFindData: TStringList);
    function  privFTPFindFiles(
      FileSpec: string;
      lstFiles: TStringList;
      KeepPath: Boolean
    ): integer;
    procedure SetPassive(const Value: boolean);
    function  GetRemoteDir: string;
    procedure SetFileSystemType(const Value: TFTPFileSystemType);
  protected
    { Protected declarations }
    procedure HandleStatusCallback(
      dwInternetStatus:           DWORD;
      lpvStatusInfo:              Pointer;
      dwStatusInformationLength:  DWORD
    ); override;
    procedure DoQuickProgress; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;  override;

    {
    *********************************************************************

                          Main Transfer functions

    *********************************************************************
    }
    {$ifdef USING_IE5}
    function  FTPCommand(Command: String; ResponseStream: TStream): Boolean;
    {$endif}
    function  FTPFindFiles(FileSpec: string; KeepPath: Boolean): integer;
    function  Connect:    Boolean; override;
    function  Disconnect: Boolean; override;
    function  PutFile(LocalFile: string): boolean;
    function  GetFile(RemoteFile: string): boolean;
    function  DeleteFile(RemoteFile: string): boolean;
    function  PutFiles(FileSpec: string): integer;
    function  GetFiles(FileSpec: string): integer;
    function  DeleteFiles(FileSpec: string): integer;
    function  MkDir(RemoteDir: string): boolean;
    function  RmDir(RemoteDir: string): boolean;
    function  ChangeRemoteDir(NewDir: string): boolean;
    function  RenameFile(ExistingName, NewName: string): boolean;
    function  FTPForceDirectories(DirName: string): boolean;
    function  PutQualifiedFile(LocalFile, RemoteFile: string): boolean;
    function  GetQualifiedFile(RemoteFile, LocalFile: string): boolean;
    function  DeleteQualifiedFile(RemoteFile: string): boolean;

    property hFtp:  HINTERNET read FhFtp;

    property FileNameList: TStringList read FFileList;
    property FileInfo[Index: Integer]: TWin32FindData read GetFileInfo;
    function RemoteDirectoryExists(sDirectory: string): boolean;
    procedure List;

    property MOTD: string read FMOTD;
  published
    property TransferType: TFTPTransferType
      read FTransferType write SetTransferType default ttBinary;

    property LocalDir: string read FLocalDir write FLocalDir;
    property RemoteDir: string read GetRemoteDir write SetRemoteDir;

    property FailIfExistsOnGet: Boolean
      read FFailIfExistsOnGet write FFailIfExistsOnGet;

    property FileSystemType: TFTPFileSystemType
      read FFileSystemType write SetFileSystemType;

    property OnDirectoryChange: TNotifyEvent
      read FOnDirectoryChange write FOnDirectoryChange;

    property OnFindItem: TFindItemEvent read FOnFindItem write FOnFindItem;

    property OnLogin: TLoginEvent read FOnLogin write FOnLogin;

    property OnTransferProgress: TTransferProgressEvent
      read FOnTransferProgress write FOnTransferProgress;

    property Passive: boolean read FPassive write SetPassive;

    //
    // Re-published properties
    //
    property OnDisconnected;
    property QuickLabelMinor;
    property QuickLabelMajor;
    property QuickProgressMajor;
  end;

{
  Procedure/Function forwards
}
function  FileTimeToDateTime(FileTime: TFileTime): TDateTime;
function  NormalizeBytesTransferred(Bytes: DWORD): string;
{$ifdef USING_IE5}
function FtpCommandA(hConnect: HINTERNET; fExpectResponse: BOOL;
  dwFlags: DWORD; lpszCommand: PChar; dwContext: DWORD;
  var hFTPCommand: HINTERNET): BOOL; stdcall;
{$endif}

procedure Register;

{ *************************************************************************** }
implementation
uses
  RGFileUtil, RGStrFuncs;

const
  winetdll = 'wininet.dll';


function TSimpleFTP.Add_UNIXSlash(path: string): string;
{
  Simply add a backslash to pathnames for UNIX-type filesystems if it isn't
  there already.
}
begin
    try
        If (copy(path, Length(path), 1) <> '/') and (FFileSystemType = ftUnix)
        then
            result := path + '/'
        else
            result := path;
    except
        On Exception do result := path;
    end;
end;    {Add_Slash}


{ ***************************************************************************
  Constructor / Destructor
  *************************************************************************** }

constructor TSimpleFTP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FTransferType      := ttBinary;
  FFileSystemType    := ftUnix;
  Port               := INTERNET_DEFAULT_FTP_PORT;
  FAPI_TransferType  := FTP_TRANSFER_TYPE_BINARY;
  FFailIfExistsOnGet := False;
  FFileList          := TStringList.Create;
  QuickProgress      := False;
  FPassive           := False;
  FMOTD              := '';
end;


destructor TSimpleFTP.Destroy;
begin
  Disconnect;

  try
    with FFileList do begin
      while Count > 0 do begin
        If assigned(PWin32FindData(Objects[Pred(Count)])) then
          Dispose(PWin32FindData(Objects[Pred(Count)]));
        Delete(Pred(Count));
      end;
    end;
  finally
    FFileList.Free;
  end;

  inherited Destroy;
end;

{ *************************************************************************** }

function TSimpleFTP.Connect: boolean;
{
  Establish Connection state
}
var
  dwConnectError: DWORD;
begin
  result := inherited Connect;

  if assigned(FOnLogin) then
    FOnLogin(Self, FUserName, FPassWord);

  if (assigned(hInet)) and (not assigned(FhFtp)) then
    FhFtp := InternetConnect (
      hInet,
      PChar(FHostName),
      Port,
      PChar(FUsername),
      PChar(FPassword),
      INTERNET_SERVICE_FTP,
      FAPI_ConnectFlags,
      DWORD(Self)
    );


  dwConnectError := GetLastError;

  If assigned(FhFtp) then begin
    result  := True;
    FMOTD   := LastError;

    if FRemoteDir <> '' then
      SetRemoteDir(FRemoteDir);

    If assigned(OnConnected) then
      OnConnected(Self);
  end else begin
    SafeCloseHandle(FhInet);
    HandleConnectError(dwConnectError);
  end;
end;


function TSimpleFTP.Disconnect: boolean;
{
  Close remote connections
}
begin
  try
    SafeCloseHandle(FhFtp);

    result := inherited Disconnect;
  except
    {
      Swallow exceptions, this is non-critical.  If you disagree, you could
      always change it :)
    }
    On Exception do
      result := False;
  end;
end;


{ *************************************************************************** }
function TSimpleFTP.ChangeRemoteDir(NewDir: string): boolean;
{
  Functional version to let us know if we can't change for any reason
}
begin
  result := true;

  If State = fsConnected then begin
    result := FtpSetCurrentDirectory( FhFtp, PChar(Kill_Slash(NewDir)) );
    if result then begin
      FRemoteDir := NewDir;
      If assigned(FOnDirectoryChange) then
        FOnDirectoryChange(Self);
    end else if not(SilentExceptions) and (FileSystemType <> ftUnknown) then
      // MVS will return false even though the 'directory' is changed,
      // so we don't raise exceptions if the file system is unknown
      raise ESimpleFTPError.CreateFmt(S_ERROR_CHANGING_DIR, [NewDir]);
  end else
  // Not connected?  Assume we can change anyway.
    FRemoteDir := NewDir;
end;


procedure TSimpleFTP.SetRemoteDir(NewDir: string);
begin
  ChangeRemoteDir(NewDir);
end;


function  TSimpleFTP.DeleteFiles(FileSpec: string): integer;
{
  Uses privFTPFindFiles to obtain a list of files for deletion based on the
  FileSpec parameter. Returns the number of files successfully deleted.
}
var
  lstFiles:   TStringlist;
  sPath:      string;
  i:          integer;
begin
  result := 0;
  lstFiles := TStringList.Create;
  try
    try
      // Fully-qualify filespec based on RemoteDir property
      if pos('/', filespec) <> 0 then begin
        sPath := ExtractUNIXFilePath(filespec);
        ProgressInfo.MajorMax :=
          privFTPFindFiles(FileSpec, lstFiles, False);
      end else begin
        sPath := Add_UNIXSlash(FRemoteDir);
        ProgressInfo.MajorMax :=
          privFTPFindFiles(sPath + FileSpec, lstFiles, False);
      end;

      for i := 0 to ProgressInfo.MajorMax - 1 do begin
        ProgressInfo.Major := Succ(i);
        ProgressInfo.CurrentFile := lstFiles[i];
        if DeleteQualifiedFile(sPath + lstFiles[i]) then
          inc(result);
      end;

    except
      on exception do
        if not(SilentExceptions) then
          raise;
    end;
  finally
    lstFiles.Free;
  end;
end;

{ *************************************************************************** }
// Deletion functions
{ *************************************************************************** }

function  TSimpleFTP.DeleteFile(RemoteFile: string): boolean;
{
  Delete a file, qualified or not.
}
begin
  if pos('/', RemoteFile) = 0 then
    result := DeleteQualifiedFile (
      Add_UNIXSlash(RemoteDir) + RemoteFile
    )
  else
    result := DeleteQualifiedFile (
      RemoteFile
    );
end;


function  TSimpleFTP.DeleteQualifiedFile(RemoteFile: string): boolean;
{
  Delete a fully-qualified file
}
begin
  result := false;

  if State = fsConnected then
    result := FTPDeleteFile(FhFtp, PChar(RemoteFile));

  if (not(Result)) and (not(SilentExceptions)) then
    raise ESimpleFTPError.CreateFmt(S_ERROR_DELETING_FILE, [RemoteFile]);
end;


{ *************************************************************************** }
// Transfer functions
{ *************************************************************************** }

function  TSimpleFTP.PutFile(LocalFile: string): boolean;
{
  Put a single file, qualified or not
}
begin
  if pos('\', LocalFile) = 0 then
    result := PutQualifiedFile (
      Add_Slash(FLocalDir) + LocalFile, Add_UNIXSlash(RemoteDir) + LocalFile
    )
  else
    result := PutQualifiedFile (
     LocalFile, Add_UNIXSlash(RemoteDir) + ExtractFileName(LocalFile)
    )
end;


function  TSimpleFTP.GetFile(RemoteFile: string): boolean;
{
  Get a single file, qualified or not
}
begin
  if pos('/', RemoteFile) = 0 then
    result := GetQualifiedFile (
      Add_UNIXSlash(RemoteDir) + RemoteFile, Add_Slash(FLocalDir) + RemoteFile
    )
  else
    result := GetQualifiedFile (
      RemoteFile, Add_Slash(FLocalDir) + ExtractUNIXFileName(RemoteFile)
    )
end;


function  TSimpleFTP.PutFiles(FileSpec: string): integer;
{
  Uses a local FindFiles function held in FileUtil to get a list
  of names for host storage.  Attempts transfer to host, then returns
  the number of files successfully transferred.
}
var
  lstFiles:   TStringlist;
  sPath:      string;
  i:          integer;
begin
  result := 0;
  lstFiles := TStringList.Create;
  try
    try
      // Fully-qualify filespec based on LocalDir property
      if pos('\', filespec) <> 0 then begin
        sPath := ExtractFilePath(filespec);
        ProgressInfo.MajorMax := FindFiles(FileSpec, lstFiles, False);
      end else begin
        sPath := Add_Slash(FLocalDir);
        ProgressInfo.MajorMax := FindFiles(sPath + FileSpec, lstFiles, False);
      end;

      for i := 0 to ProgressInfo.MajorMax - 1 do begin
        ProgressInfo.Major := Succ(i);
        // ProgressInfo.CurrentFile := lstFiles[i];
        if PutQualifiedFile(
          sPath + lstFiles[i],
          Add_UNIXSlash(RemoteDir) + lstFiles[i]
        )
        then
          inc(result);
      end;

    except
      on exception do
        if not(SilentExceptions) then
          raise;
    end;
  finally
    lstFiles.Free;
  end;
end;


function  TSimpleFTP.GetFiles(FileSpec: string): integer;
{
  Uses privFTPFindFiles to obtain a list of files for retrieval
  based on the wildcard given in FileSpec.  Attempts to retrieve
  all files in this list, and returns the number of successful retrievals.
}
var
  lstFiles:   TStringlist;
  sPath:      string;
  i:          integer;
begin
  result := 0;
  lstFiles := TStringList.Create;
  try
    try
      // Fully-qualify filespec based on RemoteDir property
      if pos('/', filespec) <> 0 then begin
        sPath := ExtractUNIXFilePath(filespec);
        ProgressInfo.MajorMax :=
          privFTPFindFiles(FileSpec, lstFiles, False);
      end else begin
        sPath := Add_UNIXSlash(RemoteDir);
        ProgressInfo.MajorMax :=
          privFTPFindFiles(sPath + FileSpec, lstFiles, False);
      end;

      for i := 0 to ProgressInfo.MajorMax - 1 do begin
        ProgressInfo.Major := Succ(i);
        if GetQualifiedFile(
          sPath + lstFiles[i],
          Add_Slash(FLocalDir) + lstFiles[i]
        )
        then
          inc(result);
      end;

    except
      on exception do
        if not(SilentExceptions) then
          raise;
    end;
  finally
    lstFiles.Free;
  end;
end;


function  TSimpleFTP.PutQualifiedFile(LocalFile, RemoteFile: string): boolean;
{
  Put a fully-qualified filename to a fully-qualified remote file.
}
begin
  //
  // Bail-out clauses
  //
  if (State <> fsConnected) and not(SilentExceptions) then
    raise ESimpleFTPError.Create(S_ERROR_NOT_CONNECTED);

  if not(FileExists(LocalFile)) and not(SilentExceptions) then
    raise ESimpleFTPError.CreateFmt(
      S_ERROR_PUTTING_FILE_NOT_FOUND,
      [LocalFile, RemoteFile]
    );
  ///////////////////////////////////////////////////////////////////

  with ProgressInfo do begin
    Minor := 0;
    MinorMax := FileLen(LocalFile);
  end;
  ProgressInfo.CurrentFile := ExtractFileName(LocalFile);
  result := FTPPutFile (
    FhFtp,
    Pchar(LocalFile),
    PChar(RemoteFile),
    FAPI_TransferType,
    DWORD(Self)
  );
  If (not(Result)) and (not(SilentExceptions)) then
    raise ESimpleFTPError.CreateFmt(
      S_ERROR_PUTTING_FILE, [LocalFile, RemoteFile]
    );
end;


function  TSimpleFTP.GetQualifiedFile(RemoteFile, LocalFile: string): boolean;
{
  Get a fully-qualified remote file and put it in a fully-qualified local file.
}
var
  FindData: TWin32FindData;
  hFind:    HINTERNET;
begin
  result := false;

  if (State <> fsConnected) and not(SilentExceptions) then
    raise ESimpleFTPError.Create(S_ERROR_NOT_CONNECTED);

  if State = fsConnected then begin

    {
      Don't allow overwriting?
    }
    If FFailIfExistsOnGet and FileExists(LocalFile) then
      exit;

    with ProgressInfo do begin
      Minor    := 0;
      MinorMax := 0;
      hFind := FtpFindFirstFile(
        FhFtp,
        PChar(RemoteFile),
        FindData,
        0,
        0
      );
      try
        if assigned(hFind) then begin
          MinorMax := FindData.nFileSizeLow;
          ProgressInfo.CurrentFile := ExtractFileName(LocalFile);
          result := FTPGetFile (
            FhFtp,
            PChar( RemoteFile ),
            PChar( LocalFile ),
            FFailIfExistsOnGet,
            0,
            FAPI_TransferType or FAPI_CacheFlag,
            DWORD(Self)
          );
          If (not(Result)) and (not(SilentExceptions)) then
            raise ESimpleFTPError.CreateFmt(
              S_ERROR_GETTING_FILE, [RemoteFile, LocalFile]
            );
        end else
          if not(SilentExceptions) then
            raise ESimpleFTPError.CreateFmt(
              S_ERROR_GETTING_FILE_NOT_FOUND, [RemoteFile, LocalFile]
            );
      finally
        SafeCloseHandle(hFind);
      end;
    end;

  end;
end;


{ *************************************************************************** }
// Internal functions
{ *************************************************************************** }
procedure TSimpleFTP.SetTransferType(NewType: TFTPTransferType);
{
  Translator of FTransferType(TFTPTransferType) to Word constant for WinInet
}
begin
  Case NewType of
    ttBinary:
      FAPI_TransferType := FTP_TRANSFER_TYPE_BINARY;

    ttAscii:
      FAPI_TransferType := FTP_TRANSFER_TYPE_ASCII;

    ttUnknown:
      FAPI_TransferType := FTP_TRANSFER_TYPE_UNKNOWN;
  end;

  FTransferType := NewType;
end;


procedure TSimpleFTP.DoQuickProgress;
{
  If pointers to valid controls are supplied and property QuickProgress
  is set to True, will supply 'quick and lazy' status information
}
begin
  with ProgressInfo do begin

    If assigned(QuickProgressMajor) then begin
      with QuickProgressMajor do begin
        Max := MajorMax;
        Position := Major;
      end;
    end;

    If assigned(QuickProgressMinor) then begin
      with QuickProgressMinor, ProgressInfo do begin
        Max := 100;
        if minormax > 0 then
          Position := round(Minor / MinorMax * 100)
        else
          Position := 0;
      end;
    end;

    If assigned(QuickLabelMajor) then
      if MajorMax > 0 then
        QuickLabelMajor.Caption := IntToStr(Major) + S_OF + IntToStr(MajorMax);

    If (assigned(QuickLabelMinor)) and (CurrentFile <> '') then
      QuickLabelMinor.Caption := CurrentFile;
  end;
end;


procedure TSimpleFTP.HandleStatusCallback(
  dwInternetStatus:           DWORD;
  lpvStatusInfo:              Pointer;
  dwStatusInformationLength:  DWORD
);
{
  The 'real' callback handler for FTP events.  This is called
  only from RegisteredStatusCallback, once the former has worked
  out to which instance the callback belongs.
}
const
  nPrevBytes: LongInt = 0;
begin
  inherited HandleStatusCallback(
    dwInternetStatus, lpvStatusInfo, dwStatusInformationLength
  );

  Case dwInternetStatus of
    INTERNET_STATUS_REQUEST_SENT,
    INTERNET_STATUS_RESPONSE_RECEIVED:
    begin
      with ProgressInfo do begin
        nPrevBytes := Minor;
        inc( Minor, DWORD(lpvStatusInfo^) );

        If (Minor = nPrevBytes) or (Minor > MinorMax) then
          Minor := MinorMax;

        {
          Ok, we've normalised what the user will see.
          Trigger the progress event, or update the 'Quick'
          controls.
        }
        If assigned( FOnTransferProgress ) and ( CurrentFile <> '' ) then
          FOnTransferProgress( Self, ProgressInfo );

        if QuickProgress then
            DoQuickProgress;
      end;
    end; {needprogress}

  {$ifdef DEBUG}
  else
    OutputDebugString(PChar('UNHANDLED: ' + IntToStr(dwInternetStatus)));
  {$endif}
  end; {case}

  {
    Let the OS have some time to itself, bless it.  This should really be
    replaced by a threaded implementation.  This is SIMPLE ftp, though ...
  }
  Application.ProcessMessages;
end;


procedure TSimpleFTP.List;
begin
  privFTPFindFiles('', nil, False);
end;


procedure TSimpleFTP.SetPassive(const Value: boolean);
begin
  FPassive := Value;

  if FPassive then
    FAPI_ConnectFlags := FAPI_ConnectFlags or INTERNET_FLAG_PASSIVE
  else
    FAPI_ConnectFlags := FAPI_ConnectFlags and not INTERNET_FLAG_PASSIVE;
end;


function  TSimpleFTP.GetFileInfo(Index: Integer): TWin32FindData;
{
  Access method for file info
}
begin
  If (Index >= FFileList.Count) or (Index < 0) then
    raise EListError.Create(S_INDEXBOUNDERROR);

  If not(assigned(FFileList.Objects[Index])) then
    raise EListError.Create(S_NOFINDDATA);

  result := Twin32FindData(Pointer(FFileList.Objects[Index])^);
end;


procedure TSimpleFTP.ClearFindDataList(lstFindData: TStringList);
{
  Free all pointers in list before clearing
}
begin
  with lstFindData do begin
    While Count > 0 do begin
      Dispose(Pointer(Objects[Pred(Count)]));
      Delete(Pred(Count));
    end;
  end;
end;


function TSimpleFTP.GetRemoteDir: string;
var
  pBuffer:  PChar;
  dwSize:   DWORD;
begin
  If State <> fsConnected then
    result := FRemoteDir
  else begin
    pBuffer := StrAlloc(Succ(INTERNET_MAX_PATH_LENGTH));
    dwSize  := INTERNET_MAX_PATH_LENGTH;
    try
      InternetSetStatusCallback(FhFtp, nil);
      try
        If FtpGetCurrentDirectory(FhFTP, pBuffer, dwSize) then
          result := StrPas(pBuffer)
        else begin
          result := FRemoteDir;
          {$ifdef DEBUG}
          OutputDebugString(
            PChar('FtpGetCurrentDirectory fail: ' + IntToStr(GetLastError) + ',' +
              SysErrorMessage(GetLastError)
            )
          );
          {$endif}
        end;
      finally
        InternetSetStatusCallback(FhFtp, @RegisteredStatusCallback);
      end;
    finally
      StrDispose(pBuffer);
    end;
  end;
end;


function  TSimpleFTP.MkDir(RemoteDir: string): boolean;
begin
  result := False;
  if State = fsConnected then
    result := FTPCreateDirectory(
      FhFtp, PChar(
        ExtractFileName(
          Kill_Slash(
            RemoteDir
          )
        )
      )
    )
  else
    if not(SilentExceptions) then
      raise ESimpleFTPError.Create(S_ERROR_NOT_CONNECTED);

  if (not(result)) and (not(SilentExceptions)) then
    raise ESimpleFTPError.CreateFmt(S_ERROR_CREATING_DIR, [RemoteDir])

end;


function  TSimpleFTP.RmDir(RemoteDir: string): boolean;
begin
  result := False;
  if State = fsConnected then
    result := FTPRemoveDirectory(FhFtp, PChar(Kill_Slash(RemoteDir)))
  else
    if not(SilentExceptions) then
      raise ESimpleFTPError.Create(S_ERROR_NOT_CONNECTED);

  If (not(result)) and (not(SilentExceptions)) then
    raise ESimpleFTPError.CreateFmt(S_ERROR_REMOVING_DIR, [RemoteDir]);
end;


function TSimpleFTP.RemoteDirectoryExists(sDirectory: string): boolean;
var
  sOldDir : string;
begin
  If (State <> fsConnected) and (not(SilentExceptions)) then
    raise ESimpleFTPError.Create(S_ERROR_NOT_CONNECTED);

  try
    sOldDir := RemoteDir;
    result := ChangeRemoteDir(sDirectory);
  finally
    ChangeRemoteDir(sOldDir);
  end;
end;


function  TSimpleFTP.RenameFile(ExistingName, NewName: string): boolean;
begin
  result := False;

  if State = fsConnected then begin
    result := FTPRenameFile(
      FhFtp,
      PChar(ExistingName),
      PChar(NewName)
    );
    if (not(result)) and (not(SilentExceptions)) then
      raise ESimpleFTPError.CreateFmt(
        S_ERROR_RENAMING_FILE, [ExistingName, NewName]
      );
  end else
    if not(SilentExceptions) then
      raise ESimpleFTPError.Create(S_ERROR_NOT_CONNECTED);
end;


function  TSimpleFTP.FTPForceDirectories(DirName: string): boolean;
{
  Recurse up host directory structure, create anything not currently
  there.
}
begin
  result := false;
  if State <> fsConnected then begin
    If not(SilentExceptions) then
      raise ESimpleFTPError.Create(S_ERROR_NOT_CONNECTED);
    exit;
  end;

  // If can't find directory, try recursing one level up before creation of
  // this level.
  If not(FTPSetCurrentDirectory(FhFtp, PChar(Kill_Slash(DirName)))) then
  begin
    FTPForceDirectories(ParentDir(DirName, '/'));
    result := FTPCreateDirectory(FhFtp, PChar(Kill_Slash(DirName)));
    if (not(result)) and (not(SilentExceptions)) then
      raise ESimpleFTPError.CreateFmt(S_ERROR_CREATING_DIR, [DirName]);
  end;
end;


function  TSimpleFTP.FTPFindFiles(FileSpec: string; KeepPath: Boolean): integer;
{
  Public interface for finding files
}
begin
  FFileList.Clear;
  result := privFTPFindFiles(FileSpec, FFileList, KeepPath);
end;


function  TSimpleFTP.privFTPFindFiles(
  FileSpec: string;
  lstFiles: TStringList;
  KeepPath: Boolean
): integer;
{
  Private implementation of findfiles for FTP.  Used in wildcard
  copies/deletes.
}
var
  pFileSpec:PChar;
  FindData: TWin32FindData;
  pNewData: pWin32FindData;
  sPath:    String;
  hFind:    HINTERNET;
begin

  result := 0;
  if assigned(lstFiles) then
    ClearFindDataList(lstFiles);

  If Length(FileSpec) = 0 then
    pFileSpec := nil
  else begin
    If pos('/', FileSpec) = 0 then begin
      sPath    := Add_UNIXSlash(RemoteDir);
      FileSpec := sPath + FileSpec;
    end else
      sPath := ExtractUNIXFilePath(FileSpec);

    pFileSpec := PChar(sPath);
  end;

  hFind := FtpFindFirstFile (
    FhFtp,
    pFileSpec,
    FindData,
    FAPI_CacheFlag,
    DWORD(Self)
  );

  if assigned(hFind) then
  begin
    try
      repeat
        if assigned(lstFiles) then
          if KeepPath then
            lstFiles.Add(sPath + FindData.cFileName)
          else
            lstFiles.Add(FindData.cFileName);

        new(pNewData);
        move(FindData, pNewData^, sizeof(TWin32FindData));
        inc(result);
        if assigned(lstFiles) then
          lstFiles.Objects[Pred(lstFiles.Count)] := TObject(pNewData);

        if assigned(FOnFindItem) then
          FOnFindItem(Self, pNewData^);

      until not(InternetFindNextFile(hFind, @FindData))

    finally
      SafeCloseHandle(hFind);
    end;
  end;
end;


procedure TSimpleFTP.SetFileSystemType(const Value: TFTPFileSystemType);
begin
  if State = fsConnected then
    if SilentExceptions then
      exit
    else
      raise ESimpleFTPError.Create(S_ERROR_CHANGING_FILESYSTEM);

  FFileSystemType := Value;
end;


function  FileTimeToDateTime(FileTime: TFileTime): TDateTime;
{
  Snaffled from UseNet, so don't whine about the hard-coded magic numbers.
  It does what it's supposed to :)
}
begin
  result := (Comp(FileTime) / 8.64E11) - 109205.0
end;

function  NormalizeBytesTransferred(Bytes: DWORD): string;
begin
  if (Bytes < 1024) then
      result := Format('%d %s', [Bytes, S_XFER_BYTES])
    else if (Bytes < 1024 * 1024) then
      result := Format('%2.2f%s', [Bytes / 1024, S_XFER_KB])
    else
      result := Format('%2.2f%s', [Bytes / 1024 / 1024, S_XFER_MB]);
end;


procedure Register;
begin
  RegisterComponents(S_INTERNETPAGE, [TSimpleFTP]);
end;

{$ifdef USING_IE5}
function FtpCommandA; external winetdll name 'FtpCommandA';

function TSimpleFTP.FTPCommand(Command: String;
  ResponseStream: TStream): Boolean;
{
  Sends a command to the ftp server, returning a response to the supplied
  stream if necessary
}
const
  RESPONSE_BUF_BLOCK = $2000;
var
  bExpectResponse:  BOOL;
  hResponse:        HINTERNET;
  pBuffer:          PChar;
  dwFlags,
  dwContext,
  dwBytesAvail,
  dwBytesRead:      DWORD;
begin
  result := false;

  If (State <> fsConnected) then
    If SilentExceptions then
      exit
    else
      raise ESimpleFTPError.Create(S_REASON_NOTCONNECTED);

  bExpectResponse := Assigned(ResponseStream);
  hResponse := nil;

  result := FtpCommandA(
    FhFtp,
    bExpectResponse,
    FAPI_TransferType,
    PChar(Command),
    DWORD(Self),
    hResponse
  );

  if (not result) and (not SilentExceptions) then
    raise ESimpleFTPError.CreateFmt(S_ERROR_SENDING_COMMAND, [Command]);

  if not assigned(hResponse) then
    exit;

  //
  // Read response stream
  //
  dwFlags       := 0;
  dwContext     := 0;
  dwBytesAvail  := 0;
  Fillchar(ProgressInfo, sizeof(ProgressInfo), 0);
  Progressinfo.CurrentFile := Command;

  pBuffer := StrAlloc(RESPONSE_BUF_BLOCK);
  try
    with ResponseStream do begin
      Seek(0, soFromBeginning);
      repeat
        StrCopy(pBuffer, '');
        InternetQueryDataAvailable(
          hResponse, dwBytesAvail, dwFlags, dwContext
        );

        if not(InternetReadFile(
          hResponse, pBuffer, dwBytesAvail, dwBytesRead
        )) then
          raise ESimpleFTPError.CreateFmt(
            S_ERROR_GETTING_COMMAND_RESPONSE,
            [Command]
          );

        ResponseStream.WriteBuffer(pBuffer^, dwBytesRead);

        inc(ProgressInfo.Minor, dwBytesRead);

        If assigned(FOnTransferProgress) then
          FOnTransferProgress(Self, ProgressInfo);
        // Not appropriate - We don't know return stream's file size
        {If QuickProgress then
          DoQuickProgress;}
      until dwBytesRead = 0;

      result := True;
    end;
  finally
    SafeCloseHandle(hResponse);
    StrDispose(pBuffer);
  end;
end;
{$endif}

end.



