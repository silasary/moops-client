unit SSLSupportWinshoes;

{
1999-Jan-05 - Kudzu
	-Dynamic loading of DLLs made automatic
  -Small changes and clean up of code
  -Created TWinshoeSSLOptions class
1999-Jan-04 - Kudzu
  -This unit created from code written by Gregor Ibic
---
  -Original SSL code by Gregor Ibic
}

interface

uses
	Classes,
	MySSLWinshoe,
  WinsockIntf;

type
  TSSLVersion = (sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1);
  TSSLMode = (sslmUnassigned, sslmClient, sslmServer, sslmBoth);

  TWinshoeSSLOptions = class(TPersistent)
  protected
    fsRootCertFile, fsServerCertFile, fsKeyFile: String;
	published
    property RootCertFile: String read fsRootCertFile write fsRootCertFile;
    property ServerCertFile: String read fsServerCertFile write fsServerCertFile;
    property KeyFile: String read fsKeyFile write fsKeyFile;
  end;

  TWinshoeSSLContext = class(TObject)
  protected
    fMethod: TSSLVersion;
    fMode: TSSLMode;
    fsRootCertFile, fsServerCertFile, fsKeyFile: String;
    fContext: PSSL_CTX;        
    //
		procedure DestroyContext;
    function InternalGetMethod: PSSL_METHOD;
		function LoadOpenSLLibrary: Boolean;
    procedure SetMode(const Value: TSSLMode);
		procedure UnLoadOpenSLLibrary;
  public
    constructor Create;
    destructor Destroy; override;
    function LoadRootCert: Boolean;
    function LoadServerCert: Boolean;
    function LoadKey: Boolean;
  published
    property Method: TSSLVersion read fMethod write fMethod;
    property Mode: TSSLMode read fMode write SetMode;
    property RootCertFile: String read fsRootCertFile write fsRootCertFile;
    property ServerCertFile: String read fsServerCertFile write fsServerCertFile;
    property KeyFile: String read fsKeyFile write fsKeyFile;
  end;

  TWinshoeSSLSocket = class(TObject)
  public
    fSSL: PSSL;
    //
    procedure Accept(const pHandle: TSocket; fSSLContext: TWinshoeSSLContext);
    procedure Connect(const pHandle: TSocket; fSSLContext: TWinshoeSSLContext);
    destructor Destroy; override;
  end;

implementation

uses
	Winshoes,
	SysUtils;

var
	DLLLoadCount: Integer = 0;

function PasswordCallback(buf:PChar; size:Integer; rwflag:Integer; userdata: Pointer):Integer; cdecl;
var
  Password: String;
begin
  Password := 'aaaa' + #0;  // Staticaly assigned password
                            // I use 'aaaa' for now.
                            // This procedure should call
                            // some metod to get the password
  size := Length(Password) + 1;
  StrLCopy(buf, @Password[1], size);
  Result := StrLen(buf);
end;

constructor TWinshoeSSLContext.Create;
begin
  inherited;
  if DLLLoadCount = 0 then begin
  	if not LoadOpenSLLibrary then begin
    	raise Exception.Create('Could not load SSL library.');
    end;
  end;
 	Inc(DLLLoadCount);
  fMethod := sslvSSLv2;
  fMode := sslmUnassigned;
end;

destructor TWinshoeSSLContext.Destroy;
begin
	DestroyContext;
	Dec(DLLLoadCount);
  if DLLLoadCount = 0 then begin
		UnLoadOpenSLLibrary;
  end;
  inherited;
end;

procedure TWinshoeSSLContext.DestroyContext;
begin
  if fContext <> nil then begin
    f_SSL_CTX_free(fContext);
    fContext := nil;
  end;
end;

function TWinshoeSSLContext.InternalGetMethod: PSSL_METHOD;
begin
	if fMode = sslmUnassigned then begin
  	raise exception.create('Mode has not been set.');
  end;
  case fMethod of
    sslvSSLv2:
      case fMode of
        sslmServer : Result := f_SSLv2_server_method;
        sslmClient : Result := f_SSLv2_client_method;
        sslmBoth   : Result := f_SSLv2_method;
      else
        Result := f_SSLv2_method;
      end;

    sslvSSLv23:
      case fMode of
        sslmServer : Result := f_SSLv23_server_method;
        sslmClient : Result := f_SSLv23_client_method;
        sslmBoth   : Result := f_SSLv23_method;
      else
        Result := f_SSLv23_method;
      end;

    sslvSSLv3:
      case fMode of
        sslmServer : Result := f_SSLv3_server_method;
        sslmClient : Result := f_SSLv3_client_method;
        sslmBoth   : Result := f_SSLv3_method;
      else
        Result := f_SSLv3_method;
      end;

    sslvTLSv1:
      case fMode of
        sslmServer : Result := f_TLSv1_server_method;
        sslmClient : Result := f_TLSv1_client_method;
        sslmBoth   : Result := f_TLSv1_method;
      else
        Result := f_TLSv1_method;
      end;
  else
    raise Exception.Create('Error geting SSL method.');
  end;
end;

function TWinshoeSSLContext.LoadRootCert: Boolean;
var
  pStr: PChar;
  error: Integer;
begin
  pStr := StrNew(PChar(RootCertFile));
  error := f_SSL_CTX_load_verify_locations(
                 fContext,
                 pStr,
                 nil);
  if error <= 0 then begin
    Result := False
  end else begin
    Result := True;
  end;

  StrDispose(pStr);
end;

function TWinshoeSSLContext.LoadServerCert: Boolean;
var
  pStr: PChar;
  error: Integer;
begin
  pStr := StrNew(PChar(ServerCertFile));
  error := f_SSL_CTX_use_certificate_file(
                 fContext,
                 pStr,
                 SSL_FILETYPE_PEM);
  if error <= 0 then
    Result := False
  else
    Result := True;

  StrDispose(pStr);
end;

function TWinshoeSSLContext.LoadKey: Boolean;
var
  pStr: PChar;
  error: Integer;
begin
  Result := True;

  pStr := StrNew(PChar(fsKeyFile));
  error := f_SSL_CTX_use_certificate_file(
                 fContext,
                 pStr,
                 SSL_FILETYPE_PEM);
  if error <= 0 then begin
    Result := False;
  end;

  error := f_SSL_CTX_use_PrivateKey_file(
                 fContext,
                 pStr,
                 SSL_FILETYPE_PEM);

  if error <= 0 then begin
    Result := False;
  end else begin
    error := f_SSL_CTX_check_private_key(fContext);
    if error <= 0 then begin
      Result := False;
    end;
  end;

  StrDispose(pStr);
end;

destructor TWinshoeSSLSocket.Destroy;
begin
  if fSSL <> nil then begin
    f_SSL_set_shutdown(fSSL, SSL_SENT_SHUTDOWN);
    f_SSL_shutdown(fSSL);
    f_SSL_free(fSSL);
    fSSL := nil;
  end;
end;

procedure TWinshoeSSLSocket.Accept(const pHandle: TSocket; fSSLContext: TWinshoeSSLContext);
var
  err: Integer;
begin
  fSSL := f_SSL_new(fSSLContext.fContext);
  if fSSL = nil then exit;
  f_SSL_set_fd(fSSL, pHandle);
  err := f_SSL_accept(fSSL);
  if err <= 0 then exit;
end;

procedure TWinshoeSSLSocket.Connect(const pHandle: TSocket; fSSLContext: TWinshoeSSLContext);
var
  error: Integer;
begin
  fSSL := f_SSL_new(fSSLContext.fContext);
  if fSSL = nil then exit;

  f_SSL_set_fd(fSSL, pHandle);
  error := f_SSL_connect(fSSL);
  if error <= 0 then begin
    raise EWinshoeException.Create('Error connecting with SSL.');
  end;
end;

function TWinshoeSSLContext.LoadOpenSLLibrary: Boolean;
// Load the OpenSSL library which is wrapped by MySSL
begin
  if not MySSLWinshoe.Load then begin
    Result := False;
    Exit;
  end;

  f_SSL_load_error_strings;

	// Successful loading if true
  result := f_SSLeay_add_ssl_algorithms > 0;
end;

procedure TWinshoeSSLContext.SetMode(const Value: TSSLMode);
var
  method: PSSL_METHOD;
  error: Integer;
begin
	if fMode = Value then begin
  	exit;
  end;
  fMode := Value;

  // Destroy the context first
  DestroyContext;

  if fMode <> sslmUnassigned then begin
    // get SSL method constant
    method := InternalGetMethod;

    // create new SSL context
    fContext := f_SSL_CTX_new(method);
    if fContext = nil then begin
      raise Exception.Create('Error creating SSL context.');
    end;

    // assign a password lookup routine
    f_SSL_CTX_set_default_passwd_cb(fContext, @PasswordCallback);

    // load CA certificate file
    {TODO Not sure when exceptions should be raised. Gregor?}
    if not LoadRootCert then begin
      raise Exception.Create('Could not load root certificate.');
    end else if not LoadServerCert then begin
      raise Exception.Create('Could not load server certificate.');
    end else if not LoadKey then begin
//      raise Exception.Create('Could not load key.');
    end;

    error := f_SSL_CTX_set_cipher_list(fContext, 'ALL:!ADH:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP');
    if error <= 0 then begin
      raise Exception.Create('SetCipher failed.');
    end;
  end;
end;

procedure TWinshoeSSLContext.UnLoadOpenSLLibrary;
begin
  MySSLWinshoe.Unload;
end;

end.
