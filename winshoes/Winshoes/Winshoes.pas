unit Winshoes;

{
(C) 1993-1999 Chad Z. Hower (Kudzu) & the Winshoes Working Group (WWG).
The license for this software is available at
http://www.pbe.com/SourceWorks/Winshoes/

Source code to be distributed in unmodified form only.

Initials:
CZH: Chad Z. Hower (Or where intials don't exist)
GH: Gordon Hamm
OZZ: Ozz Nixon
PM : Peter Mee
MTL: Mark Lussier
}

{History: (Major changes - Many things have been forgotten/omitted)
19 Jan 2000 Pete Mee
 - Re-written spooler.  May still be some functionality to do but now compiles correctly. ;-)
 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
8 Jan 2000 PM
 - Altered naming convention of file spoolers to WriteDebugToFile and
   ReadDebugToFile.
 - Added check fDoDebug to prevent attempting to writing strings when not necessary.
   Enables simple True / False of DebugToFile features (fully qualified file names
   are still required for the DebugToFile objects).
24 Oct 1999 PM
 - Added Gopher port constant (WSPORT_GOPHER)
 - Removed existing Spool to file
 - Added new Spool to file functionality.  All spool to file functionality now
   contained in FileSpoolRead and FileSpoolWrite objects.  Functionally ready - just
   add FQ file name to the FileSpoolx object using FileSpoolx.SetFileName(string).
1999.09.09
  -Readded Buffer support (ReadTo and WriteFrom). Somehow they myteriously disappeared.
1999.09.03
  -Started to remove dependency on Winsock. Use WinsockIntf instead.
1999.08.23
  -Added suport for socks connections to TWinshoeClient [Gregor Ibic]
03 Aug 1999 PM
  -Finished adding options for Spool to file
1999.04.22: [Ozz]
  = Added Support for
  : DISCARD Server Component
  : CHARGEN Server Component
1999.04.13: [Ozz]
  = TWinshoeMessageClient.WriteMessage; Moved per conversation with Chad
  = TWinshoeMessageClient.CaptureHeader; DITTO
  = TWinshoeMessageClient.Capture; DITTO
  = Removed all the "left over from Delphi 1" Message variables.
  - Removed Forms from Usage per request of potential end-user/developer.
  - Restructured Code Indentation [used Borland's standard 2 char indent].
  - Expand IPPORT_* to include all basic protocols!
1999.04.12:
  -MAJOR restructuring from this point on.
   Many changes not listed here.
   Breaks backwards compatibility, but easy to fix.
1999.04.07:
  -Eliminated obsolte CleanUp method
  -Removed WriteListMethod
1999.04.04:
  -Removed DestroySource
  -Attachments no longer disappear from Attachments property after sending
  -Removed Reset method
  -Added WriteList method
1999.03.29:
  -Moved UDP components into their own unit
  -Removed FORMS unit dependency (except UDP stuff)
1999.03.14:
  -Improved UnixDateStrToDateTime
  -Fixed FromArpa bug
  -Changed format for ToArpa to <> from ()
1999.03.10:
  -Major restructuring and cleanup
  -New server component
1999.03.09
  -Removed MATH unit dependency
  -Fixed UDP Server (GH)
1998.10.05:
  -Reconnected StrInternetToDateTime
  -Visual cleanup
1998.10.03:
	-Removed About, Key and ShareLevel props - They have been obsoleted
	-Changed result type in ResolveHost from Cardinal to u_long -
		Caused GPFs with Delphi 4
	-Fixed a bug in which received blank lines in Capture would GPF
	 (in GlobalWinshoe)
	-Fixed EOL bug in capture which also affected Header property
1998.08.20
  -Removed old async events which are no longer supported
1998.08.16
  -Fixed freeing of TstringStream in Capture
   (Tried to access after it had been freed)
1998.07.29:
  -Removed PBE unit and dependencies
  -Renamed all units
  -Removed Dialog functions
1998.07.01:
	-Delphi 4 conversion
  -Removed Bind options
1998.04.11:
  -Wrapped disconnect with try..except
10.21.97
	-Fixed "Connection Closed Gracefully" bug. Flag was not being reset before a new connect.
7.2.97:
	-Added UseNagle property
5.25.97
	-Added WriteStream
5.11.97
	-Added iMaxSockets global var
5.5.97
	-SMTP: Fixed RSET problem with stupid MS Exchange
5.1.97
	-Fixed sender types to TObject
	-Added Threaded property
	-Added Thread parameter to OnAccepted
	-Changed Accept to AcceptQuery
	-Fixed Read Bug
	-Fixed EOL before close bug
	-Added ReadAll
	-Multithreaded. OnAccepted is now in a seperate thread
	-Fixed CS in same EXE bug
	-Added UDP Support
	-Added iMaxUDPSize global var
	-Added sStackDescription global var
4.12.97
	-Sockets now clean them selves up when other end initiates the disconnect
	-Dramatically reduced CPU usage
	-Installed buffering code
	-Removed ReadBlock
	-Changed the name of some exceptions
	-All exceptions now inherited from EWinshoeexception
	-Now recognizes localhost without DNS, fixes bug in 95
	-Fixed blank PeerAddress problem
	-Changed default WaitTimeOut to 30
	-Fixed Listen property bug
	-Added ASCIIFilter
	-Fixed persisten buffer between unique connects bug
	-Added more exceptions
	-Added Status Control
	-Now uses one window handle for ALL sockets, instead of one for each server
	-Eliminated Client property
	-Modified Hiearchy some
1.27.97:
	-Added Readable function
	-Modified Command to accept a null string. If used, it will not do a writeln, but merely look for input
	-Modified internals of Read
1.26.97:
	-Added PeerAddress to Winshoe
	-Added Passive functinality to FTP, and made it the default
	-Addes sIP to ResolveHost
12.13.96
	-Added QuickSend to SMTP
12.4.96
	-Added ReadBlock
11.30.96
	-Allowed SendMessage to accept nil (Sends Nothing)
11.18.96
	-Had to add a parameter to WaitWritable and Writeable
11.16.96:
	-Fixed a bug which reset the WaitTimeOut
	-Added error checking to Writeable function
	-Fixed a BIG bug which unloaded Winsock.dll under certain situations when multiple sockets were created/destroyed out of
	 order
11.10.96:
	-Added LocalAddress
	-Added LastError to E
10.25.96:
	-Fixed temp file cleanup bug
	-Added Connected function
	-Fixed bug in CleanUp method
	-Added ReadByte, ReadShortInteger, ReadToStream
	-Fixed hanlde initilization bug
	-Added support for multiline responses
10.1.96:
	-Fixed compatibility problem with Acadia stack
9.11.96:
	-Changed T_ to TWinshoe
	-Reset Version to 1.000
9.7.96:
 -Because of conflicts with the Internet Control Pig, I renamed all of our components. Instead of starting wtih T, they all
	now start with T_.  Sorry for the inconvenience.  GREP should help you fix up your programs rather quickly.
8.25.96:
 -Many minor bug fixes
 -Added WaitTimeOut property, Waiting property
 -Increased stability of Disconnects and Aborts
 -Moved ResolveHost. It used to be just a function, it is now a class function of T_Winshoe
 -Fixed ResolveHost to include exception handling (Previously nothing occurred, Connect hung)
 -Made the following class methods vs normal methods: Raise_SocketError, sErr, SockErrMsg
 -Modified the Disconnect implementation when an error occurs. Sometimes this used to hang while attempting to be graceful.
8.12.96:
 -Connect is now non blocking
 -Added ABORT method. Aborts connect or WaitWriteable
1996.06.10:
 -Added Encoding
 -Added DestroySource
1996.05.24:
  -Capture and WriteMessage (Retrieve, and others that rely on this..) do NOT auto destroy streams anymore
}

{To Do List:
-Lock strings for more efficiency in _Text
-Allow sendmessage to accept a string or PChar
-Change SelectGroup to a property
-NNTP Post Dialog
-Notes in SMTP.DialogSend
-Threads Etc
}

// {$R *.dcr} Removed gives problems with CB.

interface

uses
  Classes,
  FileIO,
  GlobalWinshoe,
  MySSLWinshoe,
  SysUtils, SSLSupportWinshoes,
  Windows, WinsockIntf;

const
  {$I WinshoesVersion.inc}
  WSPORT_ECHO   = 7;
  WSPORT_DISCARD= 9;
  WSPORT_SYSTAT = 11;
  WSPORT_DAYTIME= 13;
  WSPORT_NETSTAT= 15;
  WSPORT_QOTD   = 17;
  WSPORT_CHARGEN= 19; {UDP Server!}
  WSPORT_FTP    = 21;
  WSPORT_TELNET = 23;
  WSPORT_SMTP   = 25;
  WSPORT_TIME   = 37;
  WSPORT_WHOIS  = 43;
  WSPORT_DOMAIN = 53;
  WSPORT_TFTP   = 69;
  WSPORT_GOPHER = 70;
  WSPORT_FINGER = 79;
  WSPORT_HTTP   = 80;
  WSPORT_POP2   = 109;
  WSPORT_POP3   = 110;
  WSPORT_AUTH   = 113;
  WSPORT_NNTP   = 119;
  WSPORT_SSL    = 443;
  WSPORT_DICT   = 2628;

  wsOk = 1;
  wsErr = 0;

type
  ExceptionClass = class of Exception;
  EWinshoeException = class(Exception);
  TClassWinshoeException = class of EWinshoeException;

  EWinshoeSocketError = class(EWinshoeexception)
  private
    FiLastError: Integer;
  public
    constructor CreateError(const sMsg: string; const iErr, iVoid: Integer); virtual;
    property LastError: Integer read FiLastError;
  end;

  EWinshoeResponseError = class(EWinshoeException);
  EWinshoeClosedSocket = class(EWinshoeException);
  EWinshoeInvalidSocket = class(EWinshoeException);
  EWinshoeConnectRefused = class(EWinshoeException);
  EWinshoeGetMessage = class(EWinshoeException);
  EWinshoeInterrupted = class(EWinshoeException);
  EWinshoeTimedOut = class(EWinshoeInterrupted);
  EWinshoeNotWaiting = class(EWinshoeException);
  EWinshoeNotListening = class(EWinshoeexception);
  EWinshoeAlreadyListening = class(EWinshoeException);
  EWinshoeAlreadyConnected = class(EWinshoeException);
  EWinshoeAlreadyConnecting = class(EWinshoeException);

  // You can add EWinshoeException to the list of ignored exceptions to reduce debugger "trapping"
  // of "normal" exceptions
  EWinshoeSilentException = class(EWinshoeException);
  EWinshoeConnClosedGraceful = class(EWinshoeSilentException);

  TProgressEvent = procedure(Sender: TComponent; const plWork, plWorkSize: LongInt) of object;

  TWinshoeGUIIntegratorBase = class(TComponent)
  private
  protected
    fbOnlyWhenIdle: Boolean;
    fiIdleTimeOut: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Process; virtual;
  published
    property IdleTimeOut: integer read fiIdleTimeOut write fiIdleTimeOut;
    property OnlyWhenIdle: Boolean read fbOnlyWhenIdle write fbOnlyWhenIdle;
  end;

  TWinshoeBase = class(TComponent)
  // Includes "Wrapped" functions to WinsockIntf
  // New "New" functionality
  public
    class function CheckForSocketError(const iResult: integer): boolean;
    class function CheckForSocketError2(const iResult: integer; const aiIgnore: array of integer)
     : boolean;
    // Pass 0 to ignore none
    class procedure DoProcess;
    class procedure Raise_SocketError(const iErr: integer);
    class function ResolveHost(const psHost: string; var psIP: string): u_long;
    // Resolves host passed in sHost. sHost may be an IP or a HostName.
    // sIP returns string version of the IP
    class function ResolveIP(const psIP: string): string;
    class function TInAddrToString(prIP: TInAddr): string;
  end;

  TWinshoe = class(TWinshoeBase)
  protected
  	fbSSLEnabled: Boolean;
    fiPort: Integer;
    fsBoundIP: string;
    fslstLocalAddresses: TStrings;
    fHandle: TSocket;
    fSSLContext: TWinshoeSSLContext;
    fxSSLOptions: TWinshoeSSLOptions;
    //
    procedure AllocateSocket(const piSocketType: Integer); dynamic;
    procedure Bind;
    procedure CreateSSLContext(axMode: TSSLMode);
    function GetLocalAddress: string;
    function GetLocalAddresses: TStrings;
    function GetLocalName: string;
    // Cannot be static method - CBuilder doesnt handle it correctly for a prop accessor
    function GetVersion: string;
    procedure Listen;
    procedure ListenNonDefault(const piQueueCount: integer);
    procedure PopulateLocalAddresses;
    procedure SetVersion(const Value: string);
  public
    //
    procedure CloseSocket; virtual;
    function Connected: Boolean; Virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Disconnect; Virtual;
    //
    property Handle: TSocket read FHandle;
    property LocalAddress: string read GetLocalAddress;
    property LocalAddresses: TStrings read GetLocalAddresses;
    property LocalName: string read GetLocalName;
  published
    property BoundIP: string read fsBoundIP write fsBoundIP;
    property Port: Integer read FiPort write FiPort;
    property SSLEnabled: boolean read fbSSLEnabled write fbSSLEnabled;
    property SSLOptions: TWinshoeSSLOptions read fxSSLOptions write fxSSLOptions;
    property Version: string read GetVersion write SetVersion stored false;
  end;

  TWinshoeSocket = class;
  TWinshoeDebugToFileEvent = procedure (Sender : TWinshoeSocket) of object;

  TWinshoeSocket = class(TWinshoe)
  protected
    fbClosedGracefully, fbUseNagle: Boolean;
    fsPeerAddress, fsCommandResult, fsReadBuffer,
    fnLogFile, fsEOLTerminator: string;
    FbASCIIFilter: Boolean;
    FnResultNo: SmallInt;
    FlLastWork, FiBufferChunk, fiReadBufferPos: integer;
    lWork, lWorkSize: LongInt;
    strmLog: TFileStream;
    fOnStatus, fOnCaptureLine: TStringEvent;
    fOnWork: TProgressEvent;
    // DebugToFile Options (by default not enabled)
//    fReadDebugToFile, fWriteDebugToFile : TWinshoeDebugToFile;
    fDebugging : Boolean;
    fOnWriteDebugToFile : TWinshoeDebugToFileEvent;
    fOnReadDebugToFile : TWinshoeDebugToFileEvent;
    //
    FslstCommandResultLong: TStrings;
    fSSLSocket: TWinshoeSSLSocket;
    //
    procedure SRaise(exception: TClassWinshoeException);
    //
    property OnCaptureLine: TStringEvent read FOnCaptureLine write FOnCaptureLine;
  public
    //
    procedure BeginWork(const lSize: LongInt);
    function Capture(objc: TObject; const asDelim: array of string): integer;
    function CaptureQuotedPrintable(objc: TObject; const asDelim: array of string): integer;
    procedure CaptureHeader(pslstHeaders: TStrings; const psDelim: string);
    procedure CheckForDisconnect;
    procedure CloseSocket; override;
    function Command(const sOut: string; const nResponse: SmallInt; const nLevel: byte;
     const sMsg: string): SmallInt; virtual;
    procedure ConvertHeadersToValues(pslstHeaders: TStrings);
    constructor Create(AOwner: TComponent); override;
    procedure Disconnect; override;
    destructor Destroy; override;
    procedure DoWork(lNewWork: LongInt); Virtual;
    procedure DoDebugToFile(var Spooler: TWinshoeDebugToFile;
      var fOnEvent : TWinshoeDebugToFileEvent;
      sOut : String; startBuf, endBuf : Integer); Virtual;
    procedure DoStatus(const sMsg: string); dynamic;
    procedure EndWork;
    function ExtractXBytesFromBuffer(const piPos: Integer): string;
    function GetResponse: SmallInt;
    function Read(const piLen: Integer): string; virtual;
    function Readable(const piMSec: Integer): boolean;
    procedure ReadToBuffer(var pBuffer; piCount: Longint);
    function ReadBuffer: String;
    // ReadBuffer WILL wait for data if none exists
    function ReadBufferSize: Integer;
    function ReadByte: Byte;
    procedure ReadFromWinsock;
    function ReadShortInt: ShortInt;
    procedure ReadToStream(strm: TStream; const iCount: Integer);
    function ReadLn: string;
    function ReadLnAndEcho(const psMask: string): string;
    function ReadLnWait: string;
    procedure SetBufferChunk(const iValue: Integer);
    procedure SetDebugging(DebugOn : Boolean);
    procedure SetDebuggingOutput(const FQWriteFileName, FQReadFileName : String);
    procedure Write(psOut: string);
    procedure WriteFromBuffer(var pBuffer; piCount: Longint);
    procedure WriteHeaders(pslstHeaders: TStrings);
    procedure WriteLn(const sOut: string);
    procedure WriteStream(strm: TStream; const bAll: Boolean);
    procedure WriteTStrings(pslst: TStrings);
    //
    property CommandResult: string read FsCommandResult;
    property CommandResultLong: Tstrings read FslstCommandResultLong;
    property EOLTerminator: string read fsEOLTerminator write fsEOLTerminator;
    property PeerAddress: string read FsPeerAddress;
    property ResultNo: SmallInt read FnResultNo;
  published
    property ASCIIFilter: boolean read FbASCIIFilter write FbASCIIFilter default False;
    property BufferChunk: Integer read FiBufferChunk write SetBufferChunk;
    property Debugging : Boolean read fDebugging write SetDebugging default False;
    property LogFile: string read FnLogFile write FnLogFile;
    property OnStatus: TStringEvent read FOnStatus write FOnStatus;
    property OnWork: TProgressEvent read FOnWork write FOnWork;
    property OnWriteDebugToFile: TWinshoeDebugToFileEvent read FOnWriteDebugToFile
      write FOnWriteDebugToFile;
    property OnReadDebugToFile: TWinshoeDebugToFileEvent read FOnReadDebugToFile
      write FOnReadDebugToFile;
    property UseNagle: Boolean read FbUseNagle write FbUseNagle default True;
{    property ReadDebugToFile : TWinshoeDebugToFile read fReadDebugToFile;
    property WriteDebugToFile : TWinshoeDebugToFile read fWriteDebugToFile;
}
  end;

  TSocksVersion = (svNoSocks, svSocks4, svSocks4A, svSocks5);
  TSocksAuthentication = (saNoAuthentication, saUsernamePassword);

  TWinshoeClient = class(TWinshoeSocket)
  private
    fsHost, fsPassword, fsUserID, fsSocksHost, fsSocksUserID, fsSocksPassword: string;
    fiSocksPort: Integer;
    fSocksVersion: TSocksVersion;
    fSocksAuthentication: TSocksAuthentication;
  protected
    property Password: string read FsPassword write FsPassword;
    property UserID: string read FsUserID write FsUserID;
  public
    procedure Connect; virtual;
    destructor Destroy; override;
    procedure Disconnect; override;
  published
    property Host: string read FsHost write FsHost;
    property SocksHost: string read fsSocksHost write fsSocksHost;
    property SocksPort: Integer read fiSocksPort write fiSocksPort;
    property SocksUserID: string read fsSocksUserID write fsSocksUserID;
    property SocksPassword: string read fsSocksPassword write fsSocksPassword;
    property SocksVersion: TSocksVersion read fSocksVersion write fSocksVersion;
    property SocksAuthentication: TSocksAuthentication read fSocksAuthentication write fSocksAuthentication;
  end;

// Procs
  procedure Register;
  function GmtOffsetStrToDateTime(s: string) : TDateTime;
  function DateTimeToGmtOffSetStr(dttm: TDateTime; bSubGMT: Boolean) : string;
  function UnixDateStrToDateTime(s: string) : TDateTime;

implementation

var
  GUIProcess: TWinshoeGUIIntegratorBase;

procedure Register;
begin
  RegisterComponents('Winshoes Clients', [TWinshoeClient]);
end;

procedure TWinshoeSocket.Sraise;
begin
  raise Exception.Create(FsCommandResult);
end;

function TWinshoe.Connected;
begin
  Result := Handle <> INVALID_SOCKET;
end;

procedure TWinshoe.Disconnect;
begin
  fSSLContext.Free;
  if Connected then begin
    CloseSocket;
  end;
end;

constructor TWinshoeSocket.Create;
begin
  inherited Create(AOwner);

  fsEOLTerminator := #13#10;
  fiReadBufferPos := 1;
  FiBufferChunk := 8192;
  FbUseNagle := True;
  FslstCommandResultLong := TstringList.Create;
end;

procedure TWinshoeSocket.SetBufferChunk;
begin
  if Connected or (csDesigning in ComponentState) or (csLoading in ComponentState) then
    exit;

  fiBufferChunk := iValue;
  if not (csDesigning in ComponentState) then begin
    SetLength(fsReadBuffer, fiBufferChunk);
  end;
end;

destructor TWinshoeSocket.Destroy;
begin
  FslstCommandResultLong.Free;
  inherited Destroy;
end;

function TWinshoeSocket.Command;
begin
  if sOut <> CHAR0 then begin
    if strmLog <> nil then
      StreamWriteLn(strmLog, 'O: ' + sOut);
    WriteLn(sOut);
  end;

  GetResponse;
  if (nResponse > -1) and (ResultNo <> nResponse) then
    raise EWinshoeResponseError.Create(CommandResult);

  if sMsg = '*' then
    DoStatus(stringOfChar(' ', nLevel * 2) + CommandResult)
  else if length(sMsg) > 0 then
    DoStatus(stringOfChar(' ', nLevel * 2) + sMsg);

  Result := ResultNo;
end;

function TWinshoeSocket.GetResponse;
var
  s, t: string;
begin
  FslstCommandResultLong.Clear;
  s := ReadLnWait;
  if strmLog <> nil then
    StreamWriteLn(strmLog, 'I: ' + s + EOL);
  if length(s) > 3 then begin
    if s[4] = '-' then begin {Multi line response coming}
      t := Copy(s, 1, 3) + CHAR32;
      FslstCommandResultLong.Add(s);
      repeat
        s := ReadLnWait;
        if strmLog <> nil then
          StreamWriteLn(strmLog, 'I: ' + s + EOL);
        FslstCommandResultLong.Add(s);
      until Copy(s, 1, 4) = t;
    end;
  end;
  FsCommandResult := s;

  if Copy(FsCommandResult, 1, 3) = '+OK' then
    FnResultno := wsOK
  else if Copy(FsCommandResult, 1, 4) = '-ERR' then
    FnResultno := wsErr
  else
    FnResultno := StrToIntDef(Copy(FsCommandResult, 1, 3), 0);

  Result := ResultNo;
end;

function TWinshoeSocket.ReadLn;
var
  i: Integer;
begin
  repeat
    {TODO make searches more efficient}
    i := Pos(EOLTerminator, Copy(fsReadBuffer, 1, fiReadBufferPos - 1));
    // ReadFromWinsock blocks - dont call unless we need to
    if i = 0 then begin
      ReadFromWinsock;
    end;
  until i > 0;
  Result := ExtractXBytesFromBuffer(i + Length(EOLTerminator) - 1);
  SetLength(Result, i - 1);
end;

procedure TWinshoeSocket.ReadToStream;
var
  iChunk, iTotal: integer;
begin
  iTotal:= iCount;
  while iTotal > 0 do begin
    if iTotal > FiBufferChunk then
      iChunk:= FiBufferChunk
    else
      iChunk:= iTotal;

    strm.WriteBuffer(Read(iChunk)[1], iChunk);
    dec(iTotal, iChunk);
  end;
end;

function TWinshoeSocket.ReadByte;
begin
  Result := Ord(Read(1)[1]);
end;

function TWinshoeSocket.ReadShortInt;
begin
  Result := ReadByte;
  Result := ReadByte * 256 + Result;
end;

procedure TWinshoeSocket.ReadFromWinsock;
// Reads any data in tcp/ip buffer and puts it into Winshoe buffer
// This must be the ONLY raw read from Winsock routine
var
  i, j: Integer;
begin
  if (Length(fsReadBuffer) - fiReadBufferPos) < (fiReadBufferPos div 2) then
    SetLength(fsReadBuffer, Length(fsReadBuffer) + FiBufferChunk)
  else if ((Length(fsReadBuffer) - fiReadBufferPos) > (FiBufferChunk * 2))
   and ((Length(fsReadBuffer) - FiBufferChunk) > fiBufferChunk) then
    SetLength(fsReadBuffer, Length(fsReadBuffer) - FiBufferChunk);

  UniqueString(fsReadBuffer);
  // This must be the ONLY call to RECV - all data goes thru this method
  if SSLEnabled then begin
    i := f_SSL_read(fSSLSocket.fSSL, @fsReadBuffer[fiReadBufferPos]
     , Length(fsReadBuffer) - fiReadBufferPos);
  end else begin
    i := WinsockInterface.recv(Handle, fsReadBuffer[fiReadBufferPos]
     , Length(fsReadBuffer) - fiReadBufferPos, 0);
  end;
  //NOTE - this is currently kind of a hack - there is a newer/better plan that I have to find time
  //to implement
  DoProcess;

  fbClosedGracefully := i = 0;
  if not fbClosedGracefully then begin
     // Quicker to have an if here than to call the proc to check the if inside
    if fDebugging then begin
//       DoDebugToFile(fReadDebugToFile, fOnReadDebugToFile, fsReadBuffer, fiReadBufferPos, i);
    end;
    if CheckForSocketError2(i, [10058]) then begin
    	i := 0;
    	if Connected then begin
	      Disconnect;
      end;
      // Dont raise unless all data has been read by the user
      if fiReadBufferPos = 0 then begin
        Raise_SocketError(10058);
      end;
    end;
    DoWork(lWork + i);
    if fbASCIIFilter then begin
      for j := fiReadBufferPos to fiReadBufferPos + i - 1 do begin
        fsReadBuffer[i] := Chr(Ord(fsReadBuffer[i]) and $7F);
      end;
    end;
    fiReadBufferPos := fiReadBufferPos + i;
  end;
  CheckForDisconnect;
end;

function TWinshoeSocket.ExtractXBytesFromBuffer(const piPos: Integer): string;
begin
  if piPos >= fiReadBufferPos then
    raise Exception.Create('Not enough data in buffer.');

  result := Copy(fsReadBuffer, 1, piPos);
  fiReadBufferPos := fiReadBufferPos - piPos;
  Uniquestring(fsReadBuffer);
  MoveMemory(PChar(fsReadBuffer), PChar(fsReadBuffer) + piPos, fiReadBufferPos - 1);
end;

function TWinshoeSocket.Read;
begin
  result := '';
  // This is necessary otherwise ReadFromWinsock blocks. HTTP server and others do call this with 0
  // because they may be reacting to parameters they receive
  if piLen = 0 then
    exit;

  while fiReadBufferPos <= piLen do
    ReadFromWinsock;

  Result := ExtractXBytesFromBuffer(piLen);
end;

function TWinshoeSocket.ReadLnWait;
begin
  Result := '';
  while length(Result) = 0 do
    Result := Trim(ReadLn);
end;

function TWinshoe.GetLocalName;
var
  s: String;
begin
  SetLength(s, MAX_PATH);
  CheckForSocketError(WinsockInterface.GetHostName(PChar(s), Length(s)));
  Result := String(PChar(s));
end;

function TWinshoe.GetLocalAddress;
begin
  result := LocalAddresses[0];
end;

procedure TWinshoe.PopulateLocalAddresses;
type
  TaPInAddr = Array[0..250] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  i: integer;
  aHost: PHostEnt;
  padrptr: PaPInAddr;
begin
  fslstLocalAddresses.Clear;

  aHost := WinsockInterface.gethostbyname(PChar(LocalName));
  if aHost = nil then begin
    CheckForSocketError(SOCKET_ERROR)
  end else begin
    padrptr := PaPInAddr(aHost^.h_addr_list);
    i := 0;
    while padrptr^[i] <> nil do begin
      fslstLocalAddresses.Add(WinsockInterface.INet_ntoa(padrptr^[I]^));
      Inc(I);
    end;
  end;
end;

procedure TWinshoeSocket.DoWork;
begin
  lWork := lNewWork;
  if (lWorkSize <> -2) then begin
    if (lWork = -1) or (lNewWork div 1024 > flLastWork) then begin
      flLastWork := lNewWork div 1024;
      if assigned(FOnWork) then
        FOnWork(Self, lWork, lWorkSize);
    end;
  end;
end;

procedure TWinshoeSocket.DoStatus;
begin
  if assigned(FOnStatus) then begin
    try
      FOnStatus(Self, sMsg);
    except
      on E: Exception do
        raise ExceptionClass(E.ClassType).Create(
          E.Message + ' occurred in user''s OnStatus Event.');
    end;
  end;
end;

procedure TWinshoeSocket.WriteLn;
begin
  Write(sOut + EOLTerminator);
end;

function TWinshoe.GetVersion;
begin
  Result := WinshoeVersion;
end;

procedure TWinshoeSocket.beginWork;
begin
  lWork := 0;
  lWorkSize := lSize;
end;

function GmtOffsetStrToDateTime(s: string) : TDateTime;
begin       {-Typical string: -0500  or  +0200  or  -0130}
  Result := 0.0;
  S := Copy(Trim(s), 1, 5);

  if Length(s) > 0 then begin
    if s[1] in ['-', '+'] then begin
      try
        Result := EncodeTime(StrToInt(Copy(s, 2, 2)), StrToInt(Copy(s, 4, 2)), 0, 0);
        if s[1] = '-' then
          Result := -Result;
      except Result := 0.0; end;
    end;
  end;
end;

function DateTimeToGmtOffSetStr(dttm: TDateTime; bSubGMT: Boolean) : string;
var
  wHour, wMin, wSec, wMSec: Word;

  function ZeroPad(s: string) : string;
  begin
    if Length(s) < 2 then
      Result := '0' + s
    else
      Result := s;
  end;

begin
  if (dttm = 0.0) and bSubGMT then begin
    Result := 'GMT';
    Exit;
  end;

  DecodeTime(abs(dttm), wHour, wMin, wSec, wMSec);
  Result := CHAR32 + ZeroPad(IntToStr(wHour)) + ZeroPad(IntToStr(wMin));
  if dttm < 0.0 then
    Result[1] := '-'
  else
    Result[1] := '+';
end;

function UnixDateStrToDateTime(s: string) : TDateTime;
var  {-Always returns date/time relative to GMT!!  -Replaces StrInternetToDateTime}
  slst: TStringList;
  dttmOffset: TDateTime;
  X: Integer;
  wMonth, wDay, wYear, wCurYear, wHour, wMin, wSec: Word;
begin
  Result := 0.0;
  {-Remove the day of week ie: Wed, Sun, etc}
  X := Pos(',', s);
  if X > 0 then s := Copy(s, Succ(X), MaxInt);

  {-Remove the trailing suffix ie: (CDT) or (EST) etc}
  X := Pos('(', s);
  if X > 0 then s := Copy(s, 1, Pred(X));

  {-Replace spaces with CR}
  s := UpperCase(Trim(s));
  repeat
    X := Pos(CHAR32, s);
    if X > 0 then s[X] := CR; {[Ozz] was #13}
  until X = 0;

  slst := TStringList.Create;
  try  {-Indexes: 0  1   2    3        4}
    slst.Text := s;
    try            {-         30 Sep 1998 10:58:02 -0500 }
      if slst.Count < 4 then
        Exit;

      {-Save off wCurYear for possible use}
      DecodeDate(Date, wCurYear, wMonth, wDay);
      wCurYear := StrToInt(Copy(IntToStr(wCurYear), 1, 2)) * 100;

      wDay   := StrToIntDef(slst[0], 1);
      wMonth := StrToMonth(UpcaseFirst(slst[1]));
      wYear  := StrToIntDef(slst[2], 1900);

      {-Hack for Y2K problem}
      if wYear < 100 then
        Inc(wYear, wCurYear);

      wHour  := StrToIntDef(Copy(slst[3], 1, 2), 0);
      wMin   := StrToIntDef(Copy(slst[3], 4, 2), 0);
      wSec   := StrToIntDef(Copy(slst[3], 7, 2), 0);
      dttmOffset := GmtOffsetStrToDateTime(slst[4]);

      Result := EncodeDate(wYear, wMonth, wDay) + EncodeTime(wHour, wMin, wSec, 0);
      {-Apply GMT offset here}
      if dttmOffset < 0.0 then
        Result := Result + Abs(dttmOffset)
      else
        Result := Result - dttmOffset;
    except Result := 0.0; end;
  finally slst.Free; end;
end;

procedure TWinshoeSocket.endWork;
begin
  lWorkSize := -1;
  DoWork(-1);
  lWorkSize := -2;
end;

procedure TWinshoeSocket.Write;
var
  iPos, dPos, i: Integer;
begin
  if length(psOut) = 0 then begin
    exit;
  end;
  if Not Connected then begin
    raise EWinshoeClosedSocket.Create('Socket is closed, cannot write');
  end;

  iPos := 1;
  Repeat
    dPos := iPos;

    // This must be the ONLY call to SEND - all data goes thru this method
    if SSLEnabled then begin
      i := f_SSL_write(fSSLSocket.fSSL, @psOut[iPos], Length(psOut) - iPos + 1);
    end else begin
	    i := WinsockInterface.Send(Handle, psOut[iPos], Length(psOut) - iPos + 1, 0);
		end;
    fbClosedGracefully := i = 0;
    //NOTE - this is currently kind of a hack - there is a newer/better plan that I have to find time
    //to implement
    DoProcess;

    // Quicker to have an if here than to call the proc to check the if inside
    if fDebugging then begin
//       DoDebugToFile(fWriteDebugToFile, fOnWriteDebugToFile, psOut, dPos, i);
    end;

    CheckForDisconnect;
    if CheckForSocketError2(i, [10058]) then begin
      Disconnect;
      Raise_SocketError(10058);
    end;
    iPos := iPos + i
  until iPos > Length(psOut);
end;

procedure TWinshoeClient.Disconnect;
begin
  try
    DoStatus('Disconnecting');
    strmLog.Free;
    fsReadBuffer := '';
    fiReadBufferPos := 1;
    inherited;
    DoStatus('Disconnected');
  except end;
end;

procedure TWinshoeClient.Connect;
var
  sao: TSockAddr;
  req: TSocksRequest;
  res: TSocksResponse;
  len, pos: Integer;
  tempBuffer: Array [0..255] of Byte;
  ReqestedAuthMethod,
  ServerAuthMethod: Byte;
  tempPort: Word;
begin
  if Connected then begin
    raise EWinshoeAlreadyConnected.Create('Already connected.');
  end;

  DoStatus('Connecting to ' + FsHost);
  SetBufferChunk(BufferChunk);
  AllocateSocket(SOCK_STREAM); try
    if not UseNagle then begin
      CheckForSocketError(WinsockInterface.SetSockOpt(FHandle, IPPROTO_TCP, TCP_NODELAY, '1111'
       , 4));
    end;

    sao.sin_family := PF_INET;
    case SocksVersion of
      svSocks4, svSocks4A, svSocks5: begin
        if SocksVersion in [svSocks4, svSocks4A] then begin
          sao.sin_port := WinsockInterface.htons(fiSocksPort);
          sao.sin_addr.S_addr := ResolveHost(fsSocksHost, sVoid);
          fsPeerAddress := '';
        end else
        if SocksVersion in [svSocks5] then begin
          sao.sin_port := WinsockInterface.htons(fiSocksPort);
          sao.sin_addr.S_addr := ResolveHost(fsSocksHost, sVoid);
          fsPeerAddress := '';
        end;
      end;
      else begin
        sao.sin_port := WinsockInterface.htons(FiPort);
        sao.sin_addr.S_addr := ResolveHost(fsHost, fsPeerAddress);
      end;
    end;
    CheckForSocketError(WinsockInterface.Connect(Handle, sao, SizeOf(sao)));
    if SSLEnabled then begin
    	CreateSSLContext(sslmClient);
      fSSLSocket := TWinshoeSSLSocket.Create;
      fSSLSocket.Connect(Handle, fSSLContext);
    end;

    if length(FnLogFile) > 0 then begin
      strmLog := TFileStream.Create(FnLogFile, fmCreate);
    end;

    Case SocksVersion of
      svSocks4, svSocks4A: begin
        req.Version := 4;
        req.OpCode  := 1;
        req.Port    := WinsockInterface.htons(FiPort);
        if SocksVersion = svSocks4A then begin
          req.IpAddr.S_addr := WinsockInterface.inet_addr(PChar('0.0.0.1'))
        end else begin
          req.IpAddr.S_addr := ResolveHost(fsHost, fsPeerAddress);
        end;
        req.UserId  := fsSocksUserID;
        len := Length(req.UserId); // calc the len of username
        req.UserId[len + 1] := #0;
        if SocksVersion = svSocks4A then begin
          Move(fsHost[1], req.UserId[len + 2], Length(fsHost));
          len := len + 1 + Length(fsHost);
          req.UserId[len + 1] := #0;
        end;
        len := 8 + len + 1;        // calc the len of request
        WriteFromBuffer(req, len);
        try
          ReadToBuffer(res, 8);
        except
          On E: Exception do begin
            raise;
          end;
        end;
        case res.OpCode of
          90: ;// request granted, do nothing
          91: raise EWinshoeException.Create('Request rejected or failed.');
          92: raise EWinshoeException.Create('Request rejected becasue SOCKS server cannot connect.');
          93: raise EWinshoeException.Create('Request rejected because the client program and identd report different user-ids.');
          else
              raise EWinshoeException.Create('Unknown socks error.');
        end;
      end;
      svSocks5: begin
        // defined in rfc 1928
        if fSocksAuthentication = saNoAuthentication then
          tempBuffer[2] := $0   // No authentication
        else
          tempBuffer[2] := $2;  // Username password authentication

        ReqestedAuthMethod := tempBuffer[2];
        tempBuffer[0] := $5;     // socks version
        tempBuffer[1] := $1;     // number of possible authentication methods

        len := 2 + tempBuffer[1];
        WriteFromBuffer(tempBuffer, len);

        try
          ReadToBuffer(tempBuffer, 2);  // Socks server sends the selected authentication method
        except
          On E: Exception do begin
            raise EWinshoeException.Create('Socks server didn''t respond.');
          end;
        end;

        ServerAuthMethod := tempBuffer[1];
        if (ServerAuthMethod <> ReqestedAuthMethod) or (ServerAuthMethod = $FF) then
          raise EWinshoeException.Create('Invalid socks authentication method.');

        // Authentication process
        if fSocksAuthentication = saUsernamePassword then begin
          tempBuffer[0] := 1; // version of subnegotiation
          tempBuffer[1] := Length(fsSocksUserID);
          pos := 2;
          if Length(fsSocksUserID) > 0 then
            Move(fsSocksUserID[1], tempBuffer[pos], Length(fsSocksUserID));
          pos := pos + Length(fsSocksUserID);
          tempBuffer[pos] := Length(fsSocksPassword);
          pos := pos + 1;
          if Length(fsSocksPassword) > 0 then
            Move(fsSocksPassword[1], tempBuffer[pos], Length(fsSocksPassword));
          pos := pos + Length(fsSocksPassword);

          WriteFromBuffer(tempBuffer, pos); // send the username and password
          try
            ReadToBuffer(tempBuffer, 2);    // Socks server sends the authentication status
          except
            On E: Exception do begin
              raise EWinshoeException.Create('Socks server didn''t respond.');
            end;
          end;

          if tempBuffer[1] <> $0 then
            raise EWinshoeException.Create('Authentication error to socks server.');
        end;

        // Connection process
        tempBuffer[0] := $5;   // socks version
        tempBuffer[1] := $1;   // connect method
        tempBuffer[2] := $0;   // reserved
        // for now we stick with domain name, must ask Chad how to detect
        // address type
        tempBuffer[3] := $3;   // address type: IP V4 address: X'01'
                               //               DOMAINNAME:    X'03'
                               //               IP V6 address: X'04'
        // host name
        tempBuffer[4] := Length(fsHost);
        pos := 5;
        if Length(fsHost) > 0 then
          Move(fsHost[1], tempBuffer[pos], Length(fsHost));
        pos := pos + Length(fsHost);
        // port
        tempPort := WinsockInterface.htons(FiPort);
        Move(tempPort, tempBuffer[pos], SizeOf(tempPort));
        pos := pos + 2;

        WriteFromBuffer(tempBuffer, pos); // send the connection packet
        try
          ReadToBuffer(tempBuffer, 5);    // Socks server replies on connect, this is the first part
        except
          On E: Exception do begin
            raise EWinshoeException.Create('Socks server didn''t respond.');
          end;
        end;

        case tempBuffer[1] of
          0: ;// success, do nothing
          1: raise EWinshoeException.Create('General SOCKS server failure.');
          2: raise EWinshoeException.Create('Connection not allowed by ruleset.');
          3: raise EWinshoeException.Create('Network unreachable.');
          4: raise EWinshoeException.Create('Host unreachable.');
          5: raise EWinshoeException.Create('Connection refused.');
          6: raise EWinshoeException.Create('TTL expired.');
          7: raise EWinshoeException.Create('Command not supported.');
          8: raise EWinshoeException.Create('Address type not supported.');
          else
             raise EWinshoeException.Create('General socks error.');
        end;

        // type of destiantion address is domain name
        case tempBuffer[3] of
          // IP V4
          1: len := 4 + 2; // 4 is for address and 2 is for port length

          // FQDN
          3: len := tempBuffer[4] + 2; // 2 is for port length

          // IP V6
          4: len := 16 + 2; // 16 is for address and 2 is for port length
        end;

        try
          ReadToBuffer(tempBuffer[5], len-1);    // Socks server replies on connect, this is the seconf part
        except
          On E: Exception do begin
            raise EWinshoeException.Create('Socks server didn''t respond.');
          end;
        end;
      end;
    end;
    DoStatus('Socket Connected')
  except
    On E: Exception do begin
      Disconnect;
      raise;
    end;
  end;
  fbClosedGracefully := False;
end;

procedure TWinshoeSocket.WriteStream;
var
  sChunk: string;
  iSize: Integer;
begin
  if bAll then begin
    strm.Position := 0;
  end;
  BeginWork(strm.Size); try
    while true do begin
      iSize := strm.Size - strm.Position;
      if iSize > 8192 then begin
        iSize := 8192
      end else if iSize = 0 then begin
        break;
      end;
      SetLength(sChunk, iSize);
      strm.ReadBuffer(sChunk[1], iSize);
      Write(sChunk);
    end;
  Finally EndWork; end;
end;

function TWinshoeSocket.Readable;
var
  tmTo: TTimeVal;
  FDRead: TFDSet;
begin
  result := ReadBufferSize > 0;
  if result then begin
    exit;
  end;

  tmTo.tv_sec := piMSec div 1000;
  tmTo.tv_usec := piMSec mod 1000;

  FDRead.fd_count := 1;
  FDRead.fd_array[0] := Handle;

  if piMSec = -1 then begin
    Result := WinsockInterface.Select(0, @FDRead, nil, nil, nil) = 1
  end else begin
    Result := WinsockInterface.Select(0, @FDRead, nil, nil, @tmTO) = 1;
    {TODO - Split this up and do DoProcess}
  end;
  //NOTE - this is currently kind of a hack - there is a newer/better plan that I have to find time
  //to implement
  DoProcess;
end;

destructor TWinshoeClient.Destroy;
begin
  if Connected then begin
    Disconnect;
  end;
  FOnStatus := nil;
  inherited;
end;

procedure TWinshoe.Bind;
var
  m_addr: TSockAddrIn;
begin
  // Setup local address for receiving socket
  with m_addr do begin
    sin_family := PF_INET;
    sin_port := WinsockInterface.htons(fiPort);
    sin_addr.s_addr := INADDR_ANY;
    if length(BoundIP) > 0 then begin
      sin_addr.s_addr := WinsockInterface.inet_addr(PChar(BoundIP));
    end;
  end;

  if CheckForSocketError2(WinsockInterface.bind(FHandle, m_addr, sizeof(m_addr))
   , [WSAEADDRINUSE]) then begin
    raise EWinshoeException.Create('Could not bind socket. Address and port are already in use.');
  end;
end;

procedure TWinshoe.ListenNonDefault;
begin
  CheckForSocketError(WinsockInterface.listen(FHandle, piQueueCount));
end;

procedure TWinshoe.AllocateSocket;
begin
  if FHandle <> INVALID_SOCKET then begin
  	CloseSocket;
  end;
  FHandle := WinsockInterface.Socket(PF_INET, piSocketType, IPPROTO_IP);
  if FHandle = INVALID_SOCKET then begin
    raise EWinshoeInvalidSocket.Create('Cannot allocate socket.');
  end;
end;

procedure TWinshoe.Listen;
begin
  ListenNonDefault(5);
end;

function TWinshoeSocket.Capture;
var
  s: string;
  i: Integer;
begin
  result := 0;
  beginWork(-1); try
    repeat
      // Retrieve next line
      s := ReadLn;

      // End of message?
      for i := 0 to High(asDelim) do begin
        if s = asDelim[i] then begin
          result := i + 1;
          exit;
        end;
      end;

      // For RFC 822 retrieves
      if (asDelim[0] = '.') and (Copy(s, 1, 2) = '..') then
        Delete(s, 1, 1);

      // Write to output
      if objc is TStrings then begin
        TStrings(objc).Add(s);
      end else if objc is TStream then begin
        StreamWriteLn(TStream(objc), s);
      end else if objc = nil then begin
        if assigned(fOnCaptureLine) then
          fOnCaptureLine(Self, s);
      end else begin
        raise Exception.Create('objc type not supported.');
      end;
    until false;
  finally EndWork; end;
end;

// THERE IS A REASON THIS IS STILL IN WINSHOES. SHOULD BE PUT IN WINSHOEMESSAGE.
function TWinshoeSocket.CaptureQuotedPrintable;

	procedure ParseQuotedPrintable(var s:string);
  var
    intPos:integer;
    strTemp:string;

  begin

    intPos := Pos('=',s);
    if intPos <> 0 then
    	begin
        strTemp := '' ;
        while (intPos <> 0) do
        	begin
						if intPos = Length(s) then
            	s := Copy(s,1,Length(s)-1)
            else
            	begin
		           	if ((s[intPos+1] in ['0'..'9','A'..'F'])) and ((s[intPos+2] in ['0'..'9','A'..'F'])) then
									begin
		            		strTemp := strTemp + Copy(s,1,intPos - 1 ) + chr ( StrToInt('$' + s[intPos+1] + s[intPos+2] ));
			            	s := Copy(s,intPos + 3, Length(s) - intPos - 2 ) ;
		  						end
		            else
		              begin
			            	strTemp := strTemp + Copy(s,1,intPos);
		                s := Copy(s,intPos +1, Length(s) - intPos ) ;
		              end;
              end ;
            intPos := Pos ('=', s);
          end;

        s := strTemp + s ;
      end ;
  end ;

  var
  s: string;
  intLen,
  i: Integer;
begin
  result := 0;
  beginWork(-1); try
    repeat
      // Retrieve next line
      s := ReadLn;
			intLen := Length(s);
      if (intLen >0 ) then
      	ParseQuotedPrintable(s);
      // End of message?
      for i := 0 to High(asDelim) do begin
        if s = asDelim[i] then begin
          result := i + 1;
          exit;
        end;
      end;

      // For RFC 822 retrieves
      if (asDelim[0] = '.') and (Copy(s, 1, 2) = '..') then
        Delete(s, 1, 1);

      // Write to output
      if objc is TStrings then begin
        TStrings(objc).Add(s);
      end else if objc is TStream then begin
        StreamWriteLn(TStream(objc), s);
      end else if objc = nil then begin
        if assigned(fOnCaptureLine) then
          fOnCaptureLine(Self, s);
      end else begin
        raise Exception.Create('objc type not supported.');
      end;
    until false;
  finally EndWork; end;
end;

procedure TWinshoeSocket.CaptureHeader(pslstHeaders: TStrings; const psDelim: string);
begin
  pslstHeaders.Clear;
  Capture(pslstHeaders, psDelim);
  ConvertHeadersToValues(pslstHeaders);
end;

procedure TWinshoeSocket.WriteTStrings(pslst: TStrings);
var
  i: integer;
begin
  for i := 0 to Pred(pslst.Count) do begin
    WriteLn(pslst[i]);
  end;
end;

procedure TWinshoeSocket.ConvertHeadersToValues(pslstHeaders: TStrings);
var
  i: Integer;
  s: string;
  slst: TStringList;
begin
  slst := TStringList.Create; try
    for i := 0 to Pred(pslstHeaders.Count) do begin
      s := pslstHeaders[i];
      // Length will never be 0 - this would have terminated the header
      if s[1] in [#9, ' '] then begin
        s := ' ' + Trim(StringReplace(s, #9, ' ', [rfReplaceAll]));
        slst[pred(slst.Count)] := slst[pred(slst.Count)] + s;
      end else begin
        // No ReplaceAll flag - we only want to replace the first one
        slst.add(StringReplace(s, ': ', '=', []));
      end;
    end;
    pslstHeaders.Assign(slst);
  finally slst.free; end;
end;

procedure TWinshoeSocket.WriteHeaders(pslstHeaders: TStrings);
var
  i: Integer;
begin
  for i := 0 to Pred(pslstHeaders.Count) do
    // No ReplaceAll flag - we only want to replace the first one
    WriteLn(StringReplace(pslstHeaders[i], '=', ': ', []));
  WriteLn('');
end;

procedure TWinshoeSocket.CheckForDisconnect;
begin
  // ************************************************************* //
  // An exception may occur here. This only happens in the IDE and this is normal.
  // Winshoes will handle this. This does not happen in the EXE.
  // ************************************************************* //
  if fbClosedGracefully then begin
    if Connected then
    	Disconnect;
    // Dont raise unless all data has been read by the user
	  if fiReadBufferPos = 0 then
    	raise EWinshoeConnClosedGraceful.Create('Connection Closed Gracefully.');
  end;
end;

function TWinshoeSocket.ReadBuffer: String;
begin
  Result := '';
  ReadFromWinsock; // Must call first to adjust readbuffersize
  if ReadBufferSize > 0 then
    Result := Read(ReadBufferSize);
end;

function TWinshoeSocket.ReadBufferSize: Integer;
begin
  result := fiReadBufferPos - 1;
end;

procedure TWinshoe.SetVersion(const Value: string);
begin
  // Void
end;

function TWinshoeSocket.ReadLnAndEcho;
var
  c: Char;
begin
  result := '';
  Repeat
    c := Read(1)[1];
    if c = #9 then begin
      Write(#9#32#9);
      if length(Result) > 0 then begin
        SetLength(Result, length(result) - 1);
      end;
    end else if not (c in [#13, #10]) then begin
      Result := Result + c;
      if psMask = '' then begin
        Write(c)
      end else begin
        Write(psMask);
      end;
    end;
  until c = #13;
  Write(EOL);
end;

constructor TWinshoe.Create(AOwner: TComponent);
begin
  inherited;
  fHandle := INVALID_SOCKET;
  fxSSLOptions := TWinshoeSSLOptions.Create;
end;

destructor TWinshoe.Destroy;
begin
  if Connected then begin
    Disconnect;
  end;
  fslstLocalAddresses.Free;
  fxSSLOptions.Free;
  inherited;
end;

function TWinshoe.GetLocalAddresses: TStrings;
begin
  if fslstLocalAddresses = nil then begin
    fslstLocalAddresses := TStringList.Create;
    PopulateLocalAddresses;
  end;
  result := fslstLocalAddresses;
end;

procedure TWinshoe.CloseSocket;
var
  OldHandle: THandle;
begin
  // Must be first, closing socket will trigger some errors, and they
  // may then check (in other threads) Connected, which checks this.
  OldHandle := Handle;
  fHandle := INVALID_SOCKET;
  WinsockInterface.CloseSocket(OldHandle);
end;

// Debugging procedures
procedure TWinshoeSocket.SetDebuggingOutput;
begin
     SetDebugging(True);
{     if Assigned(fWriteDebugToFile) then begin
        fWriteDebugToFile.SetFileName(FQWriteFileName);
     end;
     if Assigned(fReadDebugToFile) then begin
        fReadDebugToFile.SetFileName(FQReadFileName);
     end;
}
end;

procedure TWinshoeSocket.SetDebugging;
begin
{     if not Assigned(fReadDebugToFile) then begin
        try
           fReadDebugToFile := TWinshoeDebugToFile.Create(Self);
        except
        end;
     end;
     if not Assigned(fWriteDebugToFile) then begin
        try
           fWriteDebugToFile := TWinshoeDebugToFile.Create(Self);
        except
        end;
     end;
}
     fDebugging := True;
end;

procedure TWinshoeSocket.DoDebugToFile;
begin
     if Spooler.FileHandle <> INVALID_HANDLE_VALUE then begin
        if assigned(fOnEvent) then begin
           fOnEvent(Self);
        end;
     end;
     Spooler.WriteString(Copy(sOut, startBuf, endBuf));
end;

procedure TWinshoeSocket.Disconnect;
begin
  fsPeerAddress := '';
  inherited;
end;

procedure TWinshoeSocket.ReadToBuffer;
var
  s: string;
begin
  s := Read(piCount);
  Move(s[1], pBuffer, piCount);
end;

procedure TWinshoeSocket.WriteFromBuffer;
var
  s: string;
begin
  SetString(s, PChar(@pBuffer), piCount);
  Write(s);
end;

{ TWinshoeBase }

class function TWinshoeBase.CheckForSocketError(const iResult: integer): boolean;
begin
  result := CheckForSocketError2(iResult, [0]);
end;

class function TWinshoeBase.CheckForSocketError2(const iResult: integer;
  const aiIgnore: array of integer): boolean;
// Returns True if error was ignored (Matches iIgnore), false if no error occurred
var
  i, iErr: integer;
begin
  Result := false;
  if iResult = SOCKET_ERROR then begin
    iErr := WinsockInterface.WSAGetLastError;
    for i := Low(aiIgnore) to High(aiIgnore) do begin
      if iErr = aiIgnore[i] then begin
        Result := true;
        exit;
      end;
    end;
    Raise_SocketError(iErr);
  end;
end;

class procedure TWinshoeBase.DoProcess;
begin
  if assigned(GUIProcess) then begin
    GUIProcess.Process;
  end;
end;

class procedure TWinshoeBase.Raise_SocketError(const iErr: integer);
begin
  raise EWinshoeSocketError.CreateError(WinsockInterface.TranslateSocketErrorMsg(iErr), iErr, 0);
end;

class function TWinshoeBase.ResolveHost(const psHost: string; var psIP: string): u_long;
var
  pa: PChar;
  sa: TInAddr;
  aHost: PHostEnt;
begin
  psIP := psHost;
  // Sometimes 95 forgets who localhost is
  if CompareText(psHost, 'LOCALHOST') = 0 then begin
    sa.S_un_b.s_b1 := #127;
    sa.S_un_b.s_b2 := #0;
    sa.S_un_b.s_b3 := #0;
    sa.S_un_b.s_b4 := #1;
    psIP := '127.0.0.1';
    Result := sa.s_addr;
  end else begin
    // Done if is tranlated (ie There were numbers}
    Result := WinsockInterface.inet_addr(PChar(psHost));
    // If no translation, see if it resolves}
    if Result = u_long(INADDR_NONE) then begin
      aHost := WinsockInterface.GetHostByName(PChar(psHost));
      if aHost = nil then begin
      	CheckForSocketError(SOCKET_ERROR);
      end else begin
        pa := aHost^.h_addr_list^;
        sa.S_un_b.s_b1 := pa[0];
        sa.S_un_b.s_b2 := pa[1];
        sa.S_un_b.s_b3 := pa[2];
        sa.S_un_b.s_b4 := pa[3];
        psIP := TInAddrToString(sa);
      end;
      Result := sa.s_addr;
    end;
  end;
end;

class function TWinshoeBase.ResolveIP(const psIP: string): string;
var
  i: Integer;
  P: PHostEnt;
begin
  result := '';
  if CompareText(psIP, '127.0.0.1') = 0 then begin
    result := 'LOCALHOST';
  end else begin
    i := WinsockInterface.inet_addr(PChar(psIP));
    P := WinsockInterface.GetHostByAddr(@i, 4, PF_INET);
    if P <> nil then begin
      result := P.h_name
    end else begin
      CheckForSocketError2(SOCKET_ERROR, [WSANO_DATA]);
    end;
  end;
end;

class function TWinshoeBase.TInAddrToString(prIP: TInAddr): string;
begin
  {TODO change to inet_ntoa()}
  result := IntToStr(Ord(prIP.S_un_b.s_b1)) + '.' + IntToStr(Ord(prIP.S_un_b.s_b2)) + '.'
   + IntToStr(Ord(prIP.S_un_b.s_b3)) + '.' + IntToStr(Ord(prIP.S_un_b.s_b4));
end;

constructor EWinshoeSocketError.CreateError(const sMsg: string; const iErr, iVoid: Integer);
begin
  FiLastError := iErr;
  inherited Create(sMsg);
end;

{ TWinshoeGUIIntegratorBase}

constructor TWinshoeGUIIntegratorBase.Create(AOwner: TComponent);
begin
  inherited;
  if assigned(GUIProcess) then begin
    raise Exception.Create('Only one TWinshoeGUIIntegrator can exist per application.');
  end;
  fiIdleTimeOut := 250;
  GUIProcess := Self;
end;

destructor TWinshoeGUIIntegratorBase.Destroy;
begin
  inherited;
  GUIProcess := nil;
end;

procedure TWinshoeGUIIntegratorBase.Process;
begin
end;

procedure TWinshoeSocket.CloseSocket;
begin
  inherited;
  if fSSLSocket <> nil then begin
    fSSLSocket.Destroy;
    fSSLSocket := nil;
  end;
end;

procedure TWinshoe.CreateSSLContext(axMode: TSSLMode);
begin
  fSSLContext := TWinshoeSSLContext.Create;
  with fSSLContext do begin
    RootCertFile := SSLOptions.RootCertFile;
    ServerCertFile := SSLOptions.ServerCertFile;
    KeyFile := SSLOptions.KeyFile;
    // Must set mode after above props are set
  	Mode := sslmServer;
  end;
end;

end.


