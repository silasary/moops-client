unit simphttp;
{******************************************************************************}
{*                                                                            *}
{*   Author       : R. Garner         Version       : 0.92b                   *}
{*                                                                            *}
{*                  ©Zephyros Systems 1999                                    *}
{*                                                                            *}
{*   Date Created : 08/04/99          Last Modified : 19/11/99                *}
{*                                                                            *}
{*   Description  : Simple HTTP component. Presently supporting GET, HEAD,    *}
{*                  and POST along with SSL                                   *}
{*                                                                            *}
{*   Revision History:                                                        *}
{*                                                                            *}
{*      19/11/99  0.93  Added PostFromStream which supports upload of         *}
{*                      large files                                           *}
{*      01/11/99  0.92b Moved connect and disconnect to protected             *}
{*                      (where they should always have been)                  *}
{*      23/10/99  0.92  UseSSL property removed (not used)                    *}
{*      22/06/99  0.91b SSL enabling added to crackURL procedure              *}
{*      22/04/99  0.9b  Code freeze release                                   *}
{*      17/04/99  0.5a  Initial WinShoes alpha release                        *}
{*                                                                            *}
{******************************************************************************}
{$ifndef VER80}
  {$ifndef VER90}
    {$define D3ORHIGHER}
  {$endif}
{$endif}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$ifdef D3ORHIGHER}WinInet{$else}WinInetMod{$endif}, WinInetControl;

const
  C_HTTPVERB_GET  = 'GET';
  C_HTTPVERB_HEAD = 'HEAD';
  C_HTTPVERB_POST = 'POST';
  C_HTTPVERB_PUT  = 'PUT';

  C_HTTP_URLSIGNIFIER = '://';

  C_HTTP_DEF_BLOCK_SIZE       = $2000;
  C_HTTP_DEF_RETURNBUF_SIZE   = $4000;
  // C_HTTP_DEF_ACCEPT_TYPES     = '*/*';

{$ifdef D3ORHIGHER}
resourcestring
{$endif}
  S_HTTP_ERR_REQUEST_SEND  = 'Unable to send request to %s (%s)';
  S_HTTP_ERR_HEAD_QUERY    = 'Error %d (%s) querying HTTP response header';
  S_HTTP_ERR_URL_CRACK     = 'Error %d (%s) cracking URL %s';
  S_HTTP_ERR_FILE_READ     = 'Error %d (%s) reading URL';
  S_HTTP_ERR_FILE_WRITE    = 'Error %d (%s) posting to URL';
  S_HTTP_ERR_HEADER_ADD    = 'Error %d (%s) adding post headers';

type
  ESimpleHTTPError = class(Exception);

  TSimpleHTTP = class;

  THTTPTransferDirection = (tdGetting, tdPutting);

  THTTPProgressInfo = record
    Minor,
    MinorMax:               Longint;
    HTTPTransferDirection:  THTTPTransferDirection;
  end;

  THTTPTransferProgressEvent = procedure (
    Sender:       TObject;
    ProgressInfo: THTTPProgressInfo
  ) of object;

  THTTPHeaderInfo = class(TObject)
  private
    pvSysTime:      TSystemTime;
    pReturnBuffer:  PChar;
    dwReturnSize,
    dwReturnIndex:  DWORD;

    FOwner:         TSimpleHTTP;

    function GetContentLength:  DWORD;
    function GetContentType:    string;
    function GetDate:           TDateTime;
    function GetExpires:        TDateTime;
    function GetLastModified:   TDateTime;
    function GetRawHeader:      string;
    function GetStatusCode: DWORD;
    function GetStatusText: string;
  protected
    function RetrieveADate  (DateHeaderConst: DWORD):   TDateTime;
    function RetrieveAString(StringHeaderConst: DWORD): string;
    function RetrieveANumber(NumberHeaderConst: DWORD): DWORD;
  public
    constructor Create(AOwner: TSimpleHttp); virtual;
    destructor  Destroy; override;

    function    GetCustomHeader(HeaderName: string): string;

    property    ContentLength:  DWORD     read GetContentLength;
    property    ContentType:    string    read GetContentType;
    property    Date:           TDateTime read GetDate;
    property    Expires:        TDateTime read GetExpires;
    property    LastModified:   TDateTime read GetLastModified;
    property    RawHeader:      string    read GetRawHeader;
    property    StatusCode:     DWORD     read GetStatusCode;
    property    StatusText:     string    read GetStatusText;

    property    Owner:          TSimpleHTTP read FOwner;
  end;


  TSimpleHTTP = class(TWinInetControl)
  private
    // FAcceptMimeTypes: TStrings;
    FhHTTP:           HINTERNET;
    FhRequest:        HINTERNET;
    FBlockSize:       Integer;
    FHTTPHeaderInfo:  THTTPHeaderInfo;
    FReferrer:        string;
    FOptionalHeaders: TStrings;
    FPostData:        TStrings;

    ProgressInfo:         THTTPProgressInfo;
    FOnTransferProgress:  THTTPTransferProgressEvent;
    FEnableSSL: boolean;

    // procedure SetAcceptMimeTypes(const Value: TStrings);
    procedure AddRequestHeaders;
    procedure SetOptionalHeaders(const Value: TStrings);
    procedure SetPostData(const Value: TStrings);
    procedure SetBlockSize(const Value: Integer);
    procedure SetEnableSSL(const Value: boolean);
    { Private declarations }
  protected
    { Protected declarations }
    function    Connect: Boolean;    override;
    function    Disconnect: Boolean; override;

    function  CrackURL(var URL: string): boolean;
    procedure DoQuickProgress; override;

    function  MakeRequest(URLorObj: string; Verb: string): boolean;
    function  MakeStreamPostRequest(
      URLorObj: string; StreamSize: Integer): boolean;
    function  SendRequest(Verb: string): Boolean;
    function  SendRequestEx(StreamSize: Integer): Boolean;
    function  FillPostStream(const PostStream: TStream): boolean;
    function  FillResponseStream(const ToStream: TStream): boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure   Head(URLorObj: string);
    procedure   Get (URLorObj: string; const ResponseStream: TStream);
    procedure   Post(URLorObj: string; const ResponseStream: TStream);
    procedure   PostFromStream(
      URLorObj: string; const PostStream, ResponseStream: TStream
    );

    property    hHTTP:     HINTERNET read FhHTTP;
    property    hRequest:  HINTERNET read FhRequest;

    property    HTTPHeaderInfo: THTTPHeaderInfo read FHTTPHeaderInfo;
  published
    { Published declarations }
    //property AcceptMimeTypes: TStrings
    //  read FAcceptMimeTypes write SetAcceptMimeTypes;

    property BlockSize: Integer read FBlockSize write SetBlockSize;

    property EnableSSL: boolean read FEnableSSL write SetEnableSSL;

    property OptionalHeaders: TStrings
      read FOptionalHeaders write SetOptionalHeaders;

    property OnTransferProgress: THTTPTransferProgressEvent
      read FOnTransferProgress write FOnTransferProgress;

    property PostData: TStrings
      read FPostData write SetPostData;

    property Referrer: string read FReferrer write FReferrer;
  end;

procedure Register;

implementation

function MinDW(Val1, Val2: DWORD): DWORD;
begin
  If Val1 < Val2 then
    result := Val1
  else
    result := Val2;
end;

procedure Register;
begin
  RegisterComponents(S_INTERNETPAGE, [TSimpleHTTP]);
end;

{ TSimpleHTTP }

procedure TSimpleHTTP.AddRequestHeaders;
// Assumes a working hRequest
begin
  if Length(FOptionalHeaders.Text) > 0 then begin
    If (not HttpAddRequestHeaders(
      FhRequest,
      PChar(FOptionalHeaders.Text),
      DWORD(-1),
      0
    )) and (not SilentExceptions) then
      raise ESimpleHTTPError.CreateFmt(
        S_HTTP_ERR_HEADER_ADD,
        [GetLastError, LastError]
      );
  end;
end;


function TSimpleHTTP.Connect: Boolean;
{
  Establish the HTTP internet handle for WinInet
  (OK, not a 'real' connect, but a convenient point to do so)
}
var
  dwConnectError: DWORD;
begin
  result := inherited Connect;

  SafeCloseHandle(FhHTTP);

  If assigned(hInet) then
    FhHTTP := InternetConnect(
      hInet,
      PChar(FHostName),
      Port,
      PChar(FUserName),
      PChar(FPassWord),
      INTERNET_SERVICE_HTTP,
      0,
      DWORD(Self)
    );

  dwConnectError := GetLastError;

  If assigned(FhHTTP) then
    result := True
  else begin
    SafeCloseHandle(FhInet);
    HandleConnectError(dwConnectError);
  end;
end;


{*********************** Constructor / Destructor *****************************}
function TSimpleHTTP.CrackURL(var URL: string): boolean;
{
  Crack a given URL to fill HostName, Username & password properties
}
const
  MAX_BUF_SIZE = 512;
var
  URLComponents:  TURLComponents;

  procedure AllocateURLComponents;
  begin
    with URLComponents do begin
      lpszScheme        := StrAlloc(MAX_BUF_SIZE);
      dwSchemeLength    := MAX_BUF_SIZE;
      lpszHostName      := StrAlloc(MAX_BUF_SIZE);
      dwHostNameLength  := MAX_BUF_SIZE;
      lpszUserName      := StrAlloc(MAX_BUF_SIZE);
      dwUserNameLength  := MAX_BUF_SIZE;
      lpszPassWord      := StrAlloc(MAX_BUF_SIZE);
      dwPasswordLength  := MAX_BUF_SIZE;
      lpszURLPath       := StrAlloc(MAX_BUF_SIZE);
      dwURLPathLength   := MAX_BUF_SIZE;
      lpszExtraInfo     := StrAlloc(MAX_BUF_SIZE);
      dwExtraInfoLength := MAX_BUF_SIZE;
    end;
  end;

  procedure DeAllocateURLComponents;
  begin
    StrDispose(URLComponents.lpszScheme);
    StrDispose(URLComponents.lpszHostName);
    StrDispose(URLComponents.lpszUserName);
    StrDispose(URLComponents.lpszPassWord);
    StrDispose(URLComponents.lpszURLPath);
    StrDispose(URLComponents.lpszExtraInfo);
  end;

begin
  if pos(C_HTTP_URLSIGNIFIER, URL) = 0 then begin
    result := false;
    exit;
  end;

  FillChar(URLComponents, sizeof(URLComponents), 0);

  AllocateURLComponents;
  try
    URLComponents.dwStructSize := sizeof(URLComponents);

    result := InternetCrackURL(
      PChar(URL),
      0,
      0 {ICU_ESCAPE},
      URLComponents
    );

    if not result then
      if SilentExceptions then
        exit
      else
        raise ESimpleHTTPError.CreateFmt(
          S_HTTP_ERR_URL_CRACK,
          [GetLastError, LastError, URL]
        );

    with URLComponents do begin
      Port       := nPort;

      case nScheme of
        INTERNET_SCHEME_HTTPS:  EnableSSL := True;
        INTERNET_SCHEME_HTTP:   EnableSSL := False;
      end;

      If dwHostNameLength <> 0 then
        HostName := string(lpszHostName);

      If dwUserNameLength <> 0 then
        UserName := string(lpszUserName);

      If dwPasswordLength <> 0 then
        Password := string(lpszPassword);

      if dwUrlPathLength <> 0 then begin
        URL := string(lpszUrlPath);
        if dwExtraInfoLength <> 0 then
          URL := URL + string(lpszExtraInfo);
      end;
    end;
  finally
    DeAllocateURLComponents;
  end;
end;


constructor TSimpleHTTP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SilentExceptions  := False;     // Exceptions are on by default for HTTP
                                  // Wish I'd done this for FTP :P

  //FAcceptMimeTypes  := TStringlist.Create;
  //FAcceptMimeTypes.Add(C_HTTP_DEF_ACCEPT_TYPES);

  FOptionalHeaders  := TStringlist.Create;
  FPostData         := TStringList.Create;
  FHTTPHeaderInfo   := THTTPHeaderInfo.Create(Self);

  Port              := INTERNET_DEFAULT_HTTP_PORT;
  FhHTTP            := nil;
  FhRequest         := nil;
  FBlockSize        := C_HTTP_DEF_BLOCK_SIZE;
end;


destructor TSimpleHTTP.Destroy;
begin
  Disconnect;

  //FAcceptMimeTypes.Free;
  FOptionalHeaders.Free;
  FPostData.Free;
  FHTTPHeaderInfo.Free;

  inherited Destroy;
end;
{******************************************************************************}


function TSimpleHTTP.Disconnect: Boolean;
begin
  try
    // Just closing the HTTP handle would close the request handle too,
    // but we want them set to nil as well, just to be safe
    SafeCloseHandle(FhRequest);
    SafeCloseHandle(FhHTTP);

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


procedure TSimpleHTTP.DoQuickProgress;
begin
  with ProgressInfo do begin
    If assigned(QuickProgressMinor) then begin
      with QuickProgressMinor, ProgressInfo do begin
        Max := 100;
        if minormax > 0 then
          Position := round(Minor / MinorMax * 100)
        else
          Position := 0;
      end;
    end;
  end;
end;


function TSimpleHTTP.FillPostStream(const PostStream: TStream): boolean;
var
  pBuffer:                      PChar;
  dwBytesRead, dwBytesWritten:  DWORD;
begin
  pBuffer       := StrAlloc(Succ(FBlockSize));
  result        := false;

  Fillchar(ProgressInfo, sizeof(ProgressInfo), 0);

  ProgressInfo.HTTPTransferDirection := tdPutting;
  try
    ProgressInfo.MinorMax := PostStream.Size;
  except
    // Swallow exception
    On Exception do ;
  end;

  try
    with PostStream do begin
      Seek(0, soFromBeginning);
      repeat
        StrCopy(pBuffer, '');

        dwBytesRead := PostStream.Read(pBuffer^, FBlockSize);

        if dwBytesRead > 0 then begin
          if not(InternetWriteFile(
            hRequest, pBuffer, dwBytesRead, dwBytesWritten
          )) then
            raise EWinInetError.CreateFmt(
              S_HTTP_ERR_FILE_WRITE,
              [GetLastError, LastError]
            );

          inc(ProgressInfo.Minor, dwBytesWritten);

          If assigned(FOnTransferProgress) then
            FOnTransferProgress(Self, ProgressInfo);

          If QuickProgress then
            DoQuickProgress;
        end;

      until (dwBytesRead = 0);

      result := True;
    end;
  finally
    StrDispose(pBuffer);
  end;
end;


function TSimpleHTTP.FillResponseStream(const ToStream: TStream): boolean;
{
  Fills the specified response stream with a web server response to
  GET or POST.  A pre-requisite for calling this function is that
  FhRequest holds a valid WinInet HTTP request handle
}
var
  pBuffer:      PChar;
  dwFlags,
  dwContext,
  dwBytesAvail,
  dwBytesRead:  DWORD;
begin
  dwFlags       := 0;
  dwContext     := 0;
  dwBytesAvail  := 0;
  pBuffer       := StrAlloc(Succ(C_HTTP_DEF_RETURNBUF_SIZE));
  result        := false;

  Fillchar(ProgressInfo, sizeof(ProgressInfo), 0);

  ProgressInfo.HTTPTransferDirection := tdGetting;
  try
    ProgressInfo.MinorMax := HTTPHeaderInfo.ContentLength;
  except
    // Swallow exception
    On Exception do ;
  end;

  try
    with ToStream do begin
      Seek(0, soFromBeginning);
      repeat
        StrCopy(pBuffer, '');
        InternetQueryDataAvailable(
          hRequest, dwBytesAvail, dwFlags, dwContext
        );

        if not(InternetReadFile(
          hRequest, pBuffer, MinDW(FBlockSize, dwBytesAvail), dwBytesRead
        )) then
          raise EWinInetError.CreateFmt(
            S_HTTP_ERR_FILE_READ,
            [GetLastError, LastError]
          );

        ToStream.WriteBuffer(pBuffer^, dwBytesRead);

        inc(ProgressInfo.Minor, dwBytesRead);

        If assigned(FOnTransferProgress) then
          FOnTransferProgress(Self, ProgressInfo);

        If QuickProgress then
          DoQuickProgress;

      until dwBytesRead = 0;

      result := True;
    end;
  finally
    StrDispose(pBuffer);
  end;
end;


procedure TSimpleHTTP.Get(URLorObj: string; const ResponseStream: TStream);
begin
  try
    MakeRequest(URLorObj, PChar(nil));
    FillResponseStream(ResponseStream);
  finally
    DoStateChange(fsNoConnection);
  end;
end;


procedure TSimpleHTTP.Head(URLorObj: string);
begin
  try
    MakeRequest(URLOrObj, C_HTTPVERB_HEAD);
  finally
    DoStateChange(fsNoConnection);
  end;
end;


function TSimpleHTTP.MakeRequest(URLorObj, Verb: string): boolean;
begin
  //
  // Close the outstanding request handle if it exists
  //
  SafeCloseHandle(FhRequest);
  CrackURL(URLOrObj);
  Connect;
  FhRequest := HttpOpenRequest(
    FhHTTP,
    PChar(Verb),
    PChar(URLorObj),
    nil,
    PChar(FReferrer),
    nil,
    FAPI_CacheFlag,
    DWORD(Self)
  );
  AddRequestHeaders;
  result := SendRequest(Verb);
end;


function TSimpleHTTP.MakeStreamPostRequest(URLorObj: string; StreamSize: Integer):
  boolean;
begin
  //
  // Close the outstanding request handle if it exists
  //
  SafeCloseHandle(FhRequest);
  CrackURL(URLOrObj);
  Connect;
  FhRequest := HttpOpenRequest(
    FhHTTP,
    PChar(C_HTTPVERB_POST),
    PChar(URLorObj),
    nil,
    PChar(FReferrer),
    nil,
    FAPI_CacheFlag or INTERNET_FLAG_NO_CACHE_WRITE,
    DWORD(Self)
  );

  try
    AddRequestHeaders;
  except
    HttpEndRequest(FhRequest, nil, 0, DWORD(Self));
    raise;
  end;

  result := SendRequestEx(StreamSize);
end;


procedure TSimpleHTTP.Post(URLorObj: string; const ResponseStream: TStream);
begin
  try
    MakeRequest(URLorObj, C_HTTPVERB_POST);
    FillResponseStream(ResponseStream);
  finally
    DoStateChange(fsNoConnection);
  end;
end;


procedure TSimpleHTTP.PostFromStream(URLorObj: string; const PostStream,
  ResponseStream: TStream);
begin
  try
    MakeStreamPostRequest(URLorObj, PostStream.Size);
    try
      FillPostStream(PostStream);
    finally
      HttpEndRequest(FhRequest, nil, 0, DWORD(Self));
    end;
    FillResponseStream(ResponseStream);
  finally
    DoStateChange(fsNoConnection);
  end;
end;


function TSimpleHTTP.SendRequest(Verb: string): Boolean;
var
  pPostData: PChar;
  sPostData: string;
  dwPostDataSize: DWORD;
begin
  If (Verb = C_HTTPVERB_POST) or (Verb = C_HTTPVERB_PUT) then begin
    sPostData       := FPostData.Text;
    dwPostDataSize  := Length(FPostData.Text) - 2;
    pPostData       := PChar(sPostData);
  end else begin
    pPostData       := nil;
    dwPostDataSize  := 0;
  end;

  result := HttpSendRequest(
    FhRequest,
    nil,
    0,
    pPostData,
    dwPostDataSize
  );

  if (result) and (assigned(OnConnected)) then
    OnConnected(Self);

  DoStateChange(fsConnected);

  if (not result) and (not SilentExceptions) then
    raise ESimpleHTTPError.CreateFmt(
      S_HTTP_ERR_REQUEST_SEND, [FHostName, LastError]
    );
end;

{procedure TSimpleHTTP.SetAcceptMimeTypes(const Value: TStrings);
begin
  FAcceptMimeTypes.Assign(Value);
end;}

{ THTTPHeaderInfo }

{*********************** Constructor / Destructor *****************************}
constructor THTTPHeaderInfo.Create(AOwner: TSimpleHttp);
begin
  FOwner := AOwner;
  pReturnBuffer := StrAlloc(C_HTTP_DEF_RETURNBUF_SIZE);
end;


destructor THTTPHeaderInfo.Destroy;
begin
  StrDispose(pReturnBuffer);
  inherited Destroy;
end;
{******************************************************************************}

{******************* Request / Buffer Query Functions *************************}
function THTTPHeaderInfo.GetContentLength: DWORD;
begin
  result := RetrieveANumber(HTTP_QUERY_CONTENT_LENGTH);
end;


function THTTPHeaderInfo.GetContentType: string;
begin
  result := RetrieveAString(HTTP_QUERY_CONTENT_TYPE);
end;


function THTTPHeaderInfo.GetCustomHeader(HeaderName: string): string;
begin
  if not assigned(Owner.hRequest) then begin
    result := '';
    exit;
  end;

  StrPCopy(pReturnBuffer, HeaderName);

  dwReturnIndex := 0;
  dwReturnSize  := C_HTTP_DEF_RETURNBUF_SIZE;

  if (not HttpQueryInfo(
    Owner.FhRequest,
    HTTP_QUERY_CUSTOM,
    pReturnBuffer,
    dwReturnSize,
    dwReturnIndex)) and (not Owner.SilentExceptions) then
      raise ESimpleHTTPError.CreateFmt(
        S_HTTP_ERR_HEAD_QUERY, [GetLastError, Owner.LastError]
      );

  result := string(pReturnBuffer);
end;


function THTTPHeaderInfo.GetDate: TDateTime;
begin
  result := RetrieveADate(HTTP_QUERY_DATE);
end;


function THTTPHeaderInfo.GetExpires: TDateTime;
begin
  result := RetrieveADate(HTTP_QUERY_EXPIRES);
end;


function THTTPHeaderInfo.GetLastModified: TDateTime;
begin
  result := RetrieveADate(HTTP_QUERY_LAST_MODIFIED);
end;


function THTTPHeaderInfo.GetRawHeader: string;
begin
  result := RetrieveAString(HTTP_QUERY_RAW_HEADERS_CRLF);
end;


function THTTPHeaderInfo.GetStatusCode: DWORD;
begin
  result := RetrieveANumber(HTTP_QUERY_STATUS_CODE);
end;


function THTTPHeaderInfo.GetStatusText: string;
begin
  result := RetrieveAString(HTTP_QUERY_STATUS_TEXT);
end;



function THTTPHeaderInfo.RetrieveADate(DateHeaderConst: DWORD): TDateTime;
begin
  if not assigned(Owner.hRequest) then begin
    result := 0;
    exit;
  end;

  dwReturnIndex := 0;
  dwReturnSize  := sizeof(TSystemTime);

  if (not HttpQueryInfo(
    Owner.FhRequest,
    DateHeaderConst or HTTP_QUERY_FLAG_SYSTEMTIME,
    @pvSysTime,
    dwReturnSize,
    dwReturnIndex)) and (not Owner.SilentExceptions) then
      raise ESimpleHTTPError.CreateFmt(
        S_HTTP_ERR_HEAD_QUERY, [GetLastError, Owner.LastError]
      );

  result := SystemTimeToDateTime(pvSysTime);
end;


function THTTPHeaderInfo.RetrieveANumber(NumberHeaderConst: DWORD): DWORD;
begin
  if not assigned(Owner.hRequest) then begin
    result := 0;
    exit;
  end;

  dwReturnSize  := SizeOf(DWORD);
  dwReturnIndex := 0;

  If (not HttpQueryInfo(
    Owner.FhRequest,
    NumberHeaderConst or HTTP_QUERY_FLAG_NUMBER,
    @Result,
    dwReturnSize,
    dwReturnIndex
  )) and (not Owner.SilentExceptions) then
    raise ESimpleHTTPError.CreateFmt(
      S_HTTP_ERR_HEAD_QUERY, [GetLastError, Owner.LastError]
    );
end;


function THTTPHeaderInfo.RetrieveAString(StringHeaderConst: DWORD): string;
begin
  if not assigned(Owner.hRequest) then begin
    result := '';
    exit;
  end;

  StrCopy(pReturnBuffer, '');

  dwReturnIndex := 0;
  dwReturnSize  := C_HTTP_DEF_RETURNBUF_SIZE;

  if (not HttpQueryInfo(
    Owner.FhRequest,
    StringHeaderConst,
    pReturnBuffer,
    dwReturnSize,
    dwReturnIndex)) and (not Owner.SilentExceptions) then
      raise ESimpleHTTPError.CreateFmt(
        S_HTTP_ERR_HEAD_QUERY, [GetLastError, Owner.LastError]
      );

  result := string(pReturnBuffer);
end;


function TSimpleHTTP.SendRequestEx(StreamSize: Integer): Boolean;
var
  BufferIn: TInternetBuffers;
begin
  FillChar(BufferIn, sizeof(BufferIn), 0);

  with BufferIn do begin
    dwStructSize  := sizeof(TInternetBuffers);
    dwBufferTotal := StreamSize;
  end;

  result := HttpSendRequestEx(
    FhRequest,
    @BufferIn,
    nil,
    0,
    DWORD(Self)
  );

  if (result) and (assigned(OnConnected)) then
    OnConnected(Self);

  DoStateChange(fsConnected);

  if (not result) and (not SilentExceptions) then
    raise ESimpleHTTPError.CreateFmt(
      S_HTTP_ERR_REQUEST_SEND, [FHostName, LastError]
    );
end;


procedure TSimpleHTTP.SetBlockSize(const Value: Integer);
begin
  FBlockSize := Value;
  InternetSetOption(
    hInet,
    INTERNET_OPTION_READ_BUFFER_SIZE,
    @FBlockSize,
    SizeOf(FBlockSize)
  );
end;


procedure TSimpleHTTP.SetEnableSSL(const Value: boolean);
begin
  FEnableSSL := Value;
  If FEnableSSL then
    FAPI_CacheFlag := FAPI_CacheFlag or INTERNET_FLAG_SECURE
  else
    FAPI_CacheFlag := FAPI_CacheFlag and (not INTERNET_FLAG_SECURE);
end;


procedure TSimpleHTTP.SetOptionalHeaders(const Value: TStrings);
begin
  FOptionalHeaders.Assign(Value);
end;


procedure TSimpleHTTP.SetPostData(const Value: TStrings);
begin
  FPostData.Assign(Value);
end;

end.

