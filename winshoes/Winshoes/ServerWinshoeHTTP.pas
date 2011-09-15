unit ServerWinshoeHTTP;

interface

{ $define use_htmldoc}
uses
  Classes
  {$ifdef use_htmldoc}
  , HTMLDoc
  {$endif}
  , ServerWinshoe;

Type
  THTTPRequestInfo = class(TObject)
  private
    procedure SetCookies(const Value: TStrings);
    procedure SetHeaders(const Value: TStrings);
    procedure SetParams(const Value: TStrings);
  protected
    fsDocument, fsCommand, fsVersion, fsAuthUsername, fsAuthPassword, fsUnparsedParams: string;
    fbAuthExists: Boolean;
    {TODO Make header accessors}
    fslstHeaders, fslstParams, fslstCookies: TStrings;
  public
    constructor Create; //override;
    destructor Destroy; override;
    //
    property AuthExists: Boolean read fbAuthExists write fbAuthExists;
    property AuthPassword: string read fsAuthPassword write fsAuthPassword;
    property AuthUsername: string read fsAuthUsername write fsAuthUsername;
    property Command: string read fsCommand;
    property Cookies: TStrings read fslstCookies write SetCookies;
    property Document: string read fsDocument;
    property Headers: TStrings read fslstHeaders write SetHeaders;
    property Params: TStrings read fslstParams write SetParams;
    property UnparsedParams: string read fsUnparsedParams;
    property Version: string read fsVersion;
  end;

  THTTPResponseInfo = class(TObject)
  private
    fsServerSoftware, fsAuthRealm, fsResponseText, fsContentType: string;
    fConnection: TWinshoeServer;
    fbHeaderHasBeenWritten: boolean;
    fiResponseNo, fiContentLength: Integer;
    fslstCookies, fslstHeaders: TStrings;
    fContentStream: TStream;
    fContentText: string;
    //
    procedure SetCookies(const Value: Tstrings);
    procedure SetHeaders(const Value: TStrings);
    procedure SetResponseNo(const Value: Integer);
  public
    constructor Create(pConnection: TWinshoeServer);
    destructor Destroy; override;
    procedure WriteHeader;
    procedure WriteContent;
    //
    property AuthRealm: string read fsAuthRealm write fsAuthRealm;
    property ContentStream: TStream read fContentStream write fContentStream;
    property ContentText: string read fContentText write fContentText;
    property Cookies: Tstrings read fslstCookies write SetCookies;
    property Headers: TStrings read fslstHeaders write SetHeaders;
    property HeaderHasBeenWritten: boolean read fbHeaderHasBeenWritten;
    property ResponseNo: Integer read fiResponseNo write SetResponseNo;
    property ResponseText: String read fsResponseText write fsResponseText;
    //
    {TODO Change to write directly to headers like TWinshoeMessage}
    property ContentLength: integer read fiContentLength write fiContentLength;
    property ContentType: string read fsContentType write fsContentType;
    property ServerSoftware: string read fsServerSoftware write fsServerSoftware;
  end;

  TGetEvent = procedure(Thread: TWinshoeServerThread;
   RequestInfo: THTTPRequestInfo; ResponseInfo: THTTPResponseInfo) of object;
  TOtherEvent = procedure(Thread: TWinshoeServerThread;
   const psCommand, psData, psVersion: string) of object;

  TWinshoeHTTPListener = class(TWinshoeListener)
  private
    fsServerSoftware: String;
    fbParseParams: boolean;
    fOnCommandGet: TGetEvent;
    fOnCommandOther: TOtherEvent;
  protected
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    // Decodes an URL to a normal file name (with space and chars, etc.)
    class function URLDecode(psSrc: string): string;
    // properly encode special chars into an URL
    class function URLEncode(const psSrc: string): string;
  published
    {TODO Link to Threads = use UniqeString to copy}
    property ParseParams: boolean read fbParseParams write fbParseParams default True;
    property ServerSoftware: string read fsServerSoftware write fsServerSoftware;
    //
    property OnCommandGet: TGetEvent read fOnCommandGet write fOnCommandGet;
    property OnCommandOther: TOtherEvent read fOnCommandOther write fOnCommandOther;
  end;

// Procs
  procedure Register;

implementation

uses
  EncodeWinshoe
  , GlobalWinshoe
  , StringsWinshoe, SysUtils
  , Winshoes;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeHTTPListener]);
end;

constructor TWinshoeHTTPListener.Create(AOwner: TComponent);
begin
  inherited;
  Port := WSPORT_HTTP;
  fbParseParams := True;
end;

function TWinshoeHTTPListener.DoExecute(Thread: TWinshoeServerThread): boolean;
var
  i: integer;
  s, sInputLine, sCmd, sVersion, sCookie: String;
  RequestInfo: THTTPRequestInfo;
  ResponseInfo: THTTPResponseInfo;
begin
  try
    result := inherited DoExecute(Thread);
    if result then
      exit;

    with Thread.Connection do begin
      sInputLine := ReadLn;
      i := RPos(' ', sInputLine, -1);
      if i = 0 then
        raise Exception.Create('Error in parsing command.');
      sVersion := Copy(sInputLine, i + 1, MaxInt);
      SetLength(sInputLine, i - 1);
      {TODO Check for 1.0 only at this point}
      sCmd := UpperCase(Fetch(sInputLine, ' '));

      // These essentially all "retrieve" so they are all "Get"s
      if ((sCmd = 'GET') or (sCmd = 'POST') or (sCmd = 'HEAD')) and assigned(OnCommandGet)
       then begin
        RequestInfo := THTTPRequestInfo.Create; try
          RequestInfo.fsCommand := sCmd;
          CaptureHeader(RequestInfo.Headers, '');

          // Grab Params so we can parse them
          if sCmd = 'POST' then begin
            {TODO Change this, not all Posters send content-length}
            s := Read(StrToInt(RequestInfo.Headers.Values['Content-Length']));
          end else begin
            s := sInputLine;
            sInputLine := Fetch(s, '?');
          end;
          RequestInfo.fsUnparsedParams := s;

          // Parse Params
          if ParseParams then begin
            // Convert special characters
            s := StringReplace(s, '%0D', #27, [rfReplaceAll, rfIgnoreCase]);
            s := StringReplace(s, '%0A', '', [rfReplaceAll, rfIgnoreCase]);
            s := URLDecode(s);
            s := StringReplace(s, '&', EOL, [rfReplaceAll]);
            RequestInfo.Params.Text := s;
          end;

          //Decode Cookies
          for i := 0 to RequestInfo.Headers.Count - 1 do begin
            sCookie := RequestInfo.Headers[i];
            if Pos('Cookie=', sCookie) > 0 then begin
              Delete(sCookie, 1, pos('=', sCookie));
              sCookie := StringReplace(sCookie, ': ', '=', [rfReplaceAll]);
              While Pos(';', sCookie) > 0 do begin
                RequestInfo.Cookies.add(Copy(sCookie, 1, Pos(';', sCookie) - 1));
                Delete(sCookie, 1, Pos(';', sCookie));
              end;
              RequestInfo.Cookies.add(sCookie);
            end;
          end;

          RequestInfo.fsVersion := sVersion;
          RequestInfo.fsDocument := sInputLine;
          //
          s := RequestInfo.Headers.Values['Authorization'];
          RequestInfo.AuthExists := Length(s) > 0;
          if RequestInfo.AuthExists then begin
            if CompareText(Fetch(s, ' '), 'Basic') = 0 then begin
              s := TWinshoeDecoder.DecodeLine(s);
              RequestInfo.AuthUsername := Fetch(s, ':');
              RequestInfo.AuthPassword := s;
            end else begin
              raise Exception.Create('Unsupported authorization scheme.');
            end;
          end;
          //
          ResponseInfo := THTTPResponseInfo.Create(Thread.Connection);
          try
            // SG 05.07.99
            // Set the ServerSoftware string to what it's supposed to be.
            if Length(Trim(ServerSoftware)) > 0  then
               ResponseInfo.fsServerSoftware := ServerSoftware;
            try
               OnCommandGet(Thread, RequestInfo, ResponseInfo);
            except
              on E: Exception do begin
                ResponseInfo.ResponseNo := 500;
                ResponseInfo.ContentText := E.Message;
              end;
            end;
            if not ResponseInfo.HeaderHasBeenWritten then begin
              // Auto Populate Header values where possible
              // DO NOT try this in WriteHeader - WriteHeader may be called by user for an unknown
              // content
              // Always check ContentText first
              with ResponseInfo do begin
                if Length(ContentText) > 0 then
                  ContentLength := Length(ContentText)
                else if Assigned(ContentStream) then
                  ContentLength := ContentStream.Size;
                WriteHeader;
              end;
            end;
            // Always check ContentText first
            if Length(ResponseInfo.ContentText) > 0 then begin
              ResponseInfo.WriteContent;
            end else if Assigned(ResponseInfo.ContentStream) then begin
              ResponseInfo.ContentStream.Position := 0;
              ResponseInfo.WriteContent;
              // Clear the stream
              ResponseInfo.ContentStream.Free;
              ResponseInfo.ContentStream := nil;
            end;
            // Do auto clears
            if Assigned(ResponseInfo.ContentStream) then begin
              ResponseInfo.ContentStream.Free;
              ResponseInfo.ContentStream := nil;
            end;
          finally ResponseInfo.Free; end;
        finally RequestInfo.Free; end;
      end else begin
        if assigned(OnCommandOther) then
          OnCommandOther(Thread, sCmd, sInputLine, sVersion);
      end;
    end;
  finally Thread.Connection.Disconnect; end;
end;

constructor THTTPRequestInfo.Create;
begin
  inherited;
  fslstHeaders := TStringList.Create;
  fslstParams  := TStringList.Create;
  fslstCookies := TStringList.Create;
end;

destructor THTTPRequestInfo.Destroy;
begin
  fslstHeaders.Free;
  fslstParams.Free;
  fslstCookies.Free;
  inherited;
end;

constructor THTTPResponseInfo.Create;
begin
  inherited Create;

  fslstHeaders := TStringList.Create;
  fslstCookies := TStringList.Create;
  {TODO Specify version - add a class method dummy that calls version}
  ServerSoftware := 'Winshoes/1.000';
  ContentType := 'text/html';
  ContentLength := -1;

  fConnection := pConnection;
  ResponseNo := 200;
end;

destructor THTTPResponseInfo.Destroy;
begin
  fslstHeaders.Free;
  fslstCookies.Free;
  inherited;
end;

procedure THTTPResponseInfo.SetCookies(const Value: Tstrings);
begin
  fslstCookies.Assign(Value);
end;

procedure THTTPResponseInfo.SetHeaders(const Value: TStrings);
begin
  fslstHeaders.Assign(Value);
end;

procedure THTTPResponseInfo.SetResponseNo(const Value: Integer);
begin
  fiResponseNo := Value;
  case fiResponseNo of
    {TODO Add response 1xx for HTTP 1.1}
    {SG 02/06/99 : Added all status code in RFC 2068}
    // 2XX: Success
    200: ResponseText := 'OK';
    201: ResponseText := 'Created';
    202: ResponseText := 'Accepted';
    203: ResponseText := 'Non-authoritative Information';
    204: ResponseText := 'No Content';
    205: ResponseText := 'Reset Content';
    206: ResponseText := 'Partial Content';
    // 3XX: Redirections
    301: ResponseText := 'Moved Permanently';
    302: ResponseText := 'Moved Temporarily';
    303: ResponseText := 'See Other';
    304: ResponseText := 'Not Modified';
    305: ResponseText := 'Use Proxy';
    // 4XX Client Errors
    400: ResponseText := 'Bad Request';
    401: ResponseText := 'Unauthorized';
    403: ResponseText := 'Forbidden';
    404: ResponseText := 'Not Found';
    405: ResponseText := 'Methode not allowed';
    406: ResponseText := 'Not Acceptable';
    407: ResponseText := 'Proxy Authentication Required';
    408: ResponseText := 'Request Timeout';
    409: ResponseText := 'Conflict';
    410: ResponseText := 'Gone';
    411: ResponseText := 'Length Required';
    412: ResponseText := 'Precondition Failed';
    413: ResponseText := 'Request Entity To Long';
    414: ResponseText := 'Request-URI Too Long'; // max 256 chars
    415: ResponseText := 'Unsupported Media Type';
    // 5XX Server errors
    500: ResponseText := 'Internal Server Error';
    501: ResponseText := 'Not Implemented';
    502: ResponseText := 'Bad Gateway';
    503: ResponseText := 'Service Unavailable';
    504: ResponseText := 'Gateway timeout';
    505: ResponseText := 'HTTP version not supported';
    else
      ResponseText := 'Unknown Response Code';
  end;
end;

// SG 05/07/99 Use the conditional define for HTMLDoc.pas.
// SG 05/07/99 Check the status code before sending the data.
procedure THTTPResponseInfo.WriteContent;
begin
  // only send data back if the response is OK or if a client error occured.
  if (ResponseNo >= 200) and (ResponseNo < 500) then begin
    with fConnection do begin
      if Assigned( ContentStream ) then begin
        {$ifdef use_htmldoc}
        if (ContentStream is THTMLDoc) then
          (ContentStream as THTMLDoc).Format;
        {$endif}
        WriteStream(ContentStream, False);
      end else if Length(ContentText) > 0 then begin
        Write(ContentText);
        ContentText := '';
      end;
    end;
  end else begin
    fConnection.WriteLn('<B>' + IntToStr(ResponseNo) + ' ' + ResponseText + '</B><P>'
     + ContentText);
  end;
end;

procedure THTTPResponseInfo.WriteHeader;
var
  i: Integer;
begin
  if fbHeaderHasBeenWritten then begin
    raise Exception.Create('Header has already been written.');
  end;
  fbHeaderHasBeenWritten := True;

  Headers.Values['Server'] := ServerSoftware;
  Headers.Values['Content-Type'] := ContentType;

  if ContentLength > -1 then begin
    Headers.Values['Content-Length'] := IntToStr(ContentLength);
  end;

  if length(AuthRealm) > 0 then begin
    ResponseNo := 401;
    Headers.Values['WWW-Authenticate'] := 'Basic realm="' + AuthRealm + '"';
  end;

  with fConnection do begin
    // Write headers.
    WriteLn('HTTP/1.0 ' + IntToStr(ResponseNo) + ' ' + ResponseText);
	  //frames=no; expires=Monday, 31-Dec-99 23:59:59 GMT";
    For i := 0 to Cookies.Count - 1 do begin
      WriteLn('Set-Cookie: ' + Cookies[i]);
    end;
    WriteHeaders(Headers);
  end;
end;

{
HTTP/1.0 headers may be folded onto multiple lines if each
   continuation line begins with a space or horizontal tab. All linear     W
   whitespace, including folding, has the same semantics as SP.

       LWS            = [CRLF] 1*( SP | HT )
   However, folding of header lines is not expected by some
   applications, and should not be generated by HTTP/1.0 applications.

Multiple HTTP-header fields with the same field-name may be present
   in a message if and only if the entire field-value for that header
   field is defined as a comma-separated list [i.e., #(values)]. It must
   be possible to combine the multiple header fields into one "field-
   name: field-value" pair, without changing the semantics of the
   message, by appending each subsequent field-value to the first, each
   separated by a comma.

The list of methods acceptable by a specific resource can change
   dynamically; the client is notified through the return code of the
   response if a method is not allowed on a resource. Servers should
   return the status code 501 (not implemented) if the method is
   unrecognized or not implemented.

   The methods commonly used by HTTP/1.0 applications are fully defined
   in Section 8.

401 Unauthorized

   The request requires user authentication. The response must include
   a WWW-Authenticate header field (Section 10.16) containing a
   challenge applicable to the requested resource. The client may
   repeat the request with a suitable Authorization header field
   (Section 10.2). If the request already included Authorization
   credentials, then the 401 response indicates that authorization has
   been refused for those credentials. If the 401 response contains
   the same challenge as the prior response, and the user agent has
   already attempted authentication at least once, then the user
   should be presented the entity that was given in the response,
   since that entity may include relevant diagnostic information. HTTP
   access authentication is explained in Section 11.

10.2  Authorization

   A user agent that wishes to authenticate itself with a server--
   usually, but not necessarily, after receiving a 401 response--may do
   so by including an Authorization request-header field with the
   request. The Authorization field value consists of credentials
   containing the authentication information of the user agent for the
   realm of the resource being requested.

       Authorization  = "Authorization" ":" credentials

   HTTP access authentication is described in Section 11. If a request
   is authenticated and a realm specified, the same credentials should
   be valid for all other requests within this realm.

   Responses to requests containing an Authorization field are not
   cachable.

10.16  WWW-Authenticate

   The WWW-Authenticate response-header field must be included in 401
   (unauthorized) response messages. The field value consists of at
   least one challenge that indicates the authentication scheme(s) and
   parameters applicable to the Request-URI.

       WWW-Authenticate = "WWW-Authenticate" ":" 1#challenge

   The HTTP access authentication process is described in Section 11.
   User agents must take special care in parsing the WWW-Authenticate
   field value if it contains more than one challenge, or if more than
   one WWW-Authenticate header field is provided, since the contents of
   a challenge may itself contain a comma-separated list of
   authentication parameters.


   }

class function TWinshoeHTTPListener.URLDecode(psSrc: string): string;
var
  i : Integer;
  ESC: string[2];
  CharCode: integer;
begin
  Result := '';
  psSrc := StringReplace(psSrc, '+', ' ', [rfReplaceAll]);
  i := 1;
  while i <= Length(psSrc) do begin
    if psSrc[i] <> '%' then begin
      Result := Result + psSrc[i]
    end else begin
      Inc(i); // skip the % char
      ESC := Copy(psSrc, i, 2); // Copy the escape code
      Inc(i, 1); // Then skip it.
      try
        CharCode := StrToInt('$' + ESC);
        if (CharCode > 0) and (CharCode < 256) then
          Result := Result + Char(CharCode);
      except end;
    end;
    Inc(i);
  end;      // for
end;

class function TWinshoeHTTPListener.URLEncode;
const
  UnsafeChars = ' *#%<>éàèöäüçÉÁÀÈÊ¢ûÛÜÄËÖôÔîÎïÏ';
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(psSrc) do begin
    if Pos(psSrc[i], UnsafeChars) > 0 then
      Result := Result + '%' + IntToHex(Ord(psSrc[i]), 2)
    else
      Result := Result + psSrc[i];
  end;
end;

procedure THTTPRequestInfo.SetCookies(const Value: TStrings);
begin
  fslstCookies.Assign(Value);
end;

procedure THTTPRequestInfo.SetHeaders(const Value: TStrings);
begin
  fslstHeaders.Assign(Value);
end;

procedure THTTPRequestInfo.SetParams(const Value: TStrings);
begin
  fslstParams.Assign(Value);
end;

end.
