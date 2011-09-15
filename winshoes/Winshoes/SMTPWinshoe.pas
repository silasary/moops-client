unit SMTPWinshoe;

{
13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
1999.12.22 refined the IsAuthProtocolAvailable procedure to prevent duplicate and blank entries in the AuthSchemesSupported property - JPM
           also refined the logic for AUTH search so that it must be followed by a space or equals sign
           words separated by equals are now treated as a single entry
           The check for authentication wanted and available on the server is now done in the Send procedure so that a developer can adjust their wanted authentication method depending on what is available.
           bUseAuthentication has been removed because I feel it is no longer needed
1999.12.21 Added support for AUTH LOGIN - required a few changes - JPM
1999.04.07:
  -Modified Connect to no longer use NOOP as SLMail has a bug re NOOP before
   HELO
1999.04.04:
  -Set default EncodingType to encBase64
  -X-Mailer now checks for ''
  -Removed DistList, added CCList and BCCList
  -Fixed bug in which default domain did not add @
1998.08.16
  -Added DATE header
}

interface

uses
	Classes
  , EncodeWinshoe
	, Winshoes, WinshoeMessage;

Type
        TAuthenticationType = (atNone, atLogin);   //JPM
	TWinshoeSMTP = class(TWinshoeMessageClient)
	private
	protected
          FAUthenticationType : TAuthenticationType; //JPM
          FAuthSchemesSupported  : TStringList;  //JPM
          Function IsAuthProtocolAvailable(Auth : TAuthenticationType) : Boolean;  virtual; //JPM - see if an authentication protocol is available on the server
          Procedure GetAuthTypes; //JPM - get authentication types available on a server
	public
                function Authenticate : Boolean; virtual; //we use this to authenticate to the server
		constructor Create(AOwner: TComponent); override;
                destructor Destroy; override;
		procedure Connect; override;
		procedure Disconnect; override;
		class procedure QuickSend(const sHost, sSubject, sTo, sFrom, sText: String);
		procedure Send(pMsg: TWinshoeMessage); override;
                property AuthSchemesSupported : TStringList read FAuthSchemesSupported;
	published
    property Password;
    property UserID;
    property AuthenticationType : TAuthenticationType read FAUthenticationType write FAUthenticationType;   //JPM
	end;

// Procs
	procedure Register;

implementation

Uses
  GlobalWinshoe,
  StringsWinshoe,
	SysUtils;

procedure Register;
begin
  RegisterComponents('Winshoes Clients', [TWinshoeSMTP]);
end;

Function TWinshoeSMTP.IsAuthProtocolAvailable(Auth : TAuthenticationType): Boolean;  //JPM
begin
  case Auth of
    atLogin : Result := (FAuthSchemesSupported.IndexOf('LOGIN') <> -1);
  else
    Result := False;
  end;
end;

Procedure TWinshoeSMTP.GetAuthTypes; //JPM
//this procedure gets the AUTH list from the EHLO reply and then returns the protocols being listed in the AUTH lines into a Results TStringList
var intIterator : Integer;
    strBuffer : String;
    strListEntry : String;
begin
   //find the AUTH line in reply

   intIterator := 1;  //we start with the second line
   while intIterator < FslstCommandResultLong.Count do begin    //iterate through the EHLO reply finding AUTH list
     strBuffer := UpperCase( FslstCommandResultLong[ intIterator ] ); //the values should be case insensitive
     //we only accept AUTH if there is a space or equals sign after it - just in case a command comes along such as AUTHOR throwing things off  - I also use Copy for the test to prevent an error if the Length of the string is shorter than I would expect
     if (Pos('AUTH', strBuffer ) = 5) and ((Copy(strBuffer,9,1)=' ') or (Copy(strBuffer,9,1)='=')) then begin     //position 5 excluses the reply code and separator
        strBuffer := Copy(strBuffer, 10 , Length( strBuffer ) );  //put string in temporary buffer to facilitate parsing.  10 = place where string would start in the AUTH line
        while StrBuffer <> '' do
        begin
//          strListEntry := StringReplace( strBuffer, '=' , ' ' ,rfReplaceAll);
          strListEntry :=  Fetch ( strBuffer,' ' );
          if ( FAuthSchemesSupported.IndexOf ( strListEntry ) = -1 ) then   //ensure no duplicates are listed
            FAuthSchemesSupported.Add ( strListEntry ); //add protocol to our list
        end;
     end;
     Inc ( intIterator );
   end;
end;

Constructor TWinshoeSMTP.Create;
Begin
	inherited Create(AOwner);
        FAuthSchemesSupported := TStringList.Create;
        FAuthSchemesSupported.Duplicates := dupIgnore; //prevent duplicates in the supported AUTH protocol list
	Port := WSPORT_SMTP;
End;

destructor TWinshoeSMTP.Destroy;
begin
  FAuthSchemesSupported.Free;
  inherited Destroy;
end;

procedure TWinshoeSMTP.Connect;
var iResult : Integer;
begin
  inherited Connect;
  try
    if GetResponse <> 220 then
      SRaise(EWinshoeConnectRefused);
      FAuthSchemesSupported.Clear;
      iResult := Command( 'ehlo ' + LocalName, -1, 0,  'Connected');   //JPM
      if iResult = 250 then
        GetAuthTypes
      else
        Command('Helo ' + LocalName, 250, 0, 'Connected');
  except
    Disconnect;
    Raise
  end;
end;

procedure TWinshoeSMTP.Disconnect;
begin
  try
    if Connected then
      WriteLn('Quit');
  finally inherited Disconnect; end;
end;

function TWinshoeSMTP.Authenticate : Boolean; //return True if successfule, false if failed - JPM

  function AuthLogin : Boolean;  //AUTH LOGIN support
  var encd : TWinshoeEncoder;
  begin
    encd := TWinshoeEncoder.Create;
    try
      Command('auth LOGIN',334,0,'Authenticating');   //for some odd reason wcSMTP does not accept lowercase 'LOGIN" (WcSMTP is part of the WildCat Interactive Net Server
      Command(encd.EncodeLine(UserID),334,0,'');
      Command(encd.EncodeLine(Password),235,0,'');
      Result := True;
    finally
      encd.Free;
    end;
  end;

begin
  Result := False;  //assume failure
  case FAUthenticationType of
    atLogin : Result := AuthLogin;
  end;
end;

procedure TWinshoeSMTP.Send;
var
 	bConnected: Boolean; {If not connected on entry, connect and then disconnect when done }

  function CheckDefaultDomain(const psAddress: string): string;
  begin
    result := psAddress;
    if Pos('@', result) = 0 then
      result := result + '@' + result;
  end;

  procedure WriteRecipient(const psAddr: string);
  begin
    Command('RCPT to:<' + CheckDefaultDomain(pMsg.ExtractAddr(psAddr)) + '>'
     , 250, 2, 'To: ' + psAddr);
  end;

  procedure WriteRecipients(pslst: TStrings);
  var
    i: integer;
  begin
 		if pslst.count = 0 then
      exit;
    for i := 0 to pred(pslst.count) do
      WriteRecipient(pslst[i]);
  end;

  Function NeedToAuthenticate : Boolean;
  begin
      if FAuthenticationType <> atNone then
         Result := IsAuthProtocolAvailable( FAuthenticationType )
      else
         Result := False;
  end;

begin
	bConnected := False;

  with pMsg do begin
    ValidateAddr(pMsg.From, 'From');
    if Length(ExtractAddr(Too.Text)) = 0 then
      raise Exception.Create('TO not specified.');
    If Length(Trim(Subject)) = 0 then
      Subject := 'None';
    DoStatus('  Sending Message: ' + Subject);

    try
      bConnected := Connected;
      if not bConnected then
        Connect;

      Command('Rset', 250, 2, 'Successful Reset');
      if not NeedToAuthenticate then //JPM - if we authenticate, we use the AUTH=<> parameter with a message
        Command('Mail from:<' + ExtractAddr(From) + '>', 250, 0, '')
      else begin
        Authenticate;
        Command('Mail from:<' + ExtractAddr(From) + '> AUTH=<'+ExtractAddr(From)+'>', 250, 0, '');
      end;
      WriteRecipients(BCCList);
      WriteRecipients(CCList);
      WriteRecipients(Too);

      Command('Data', 354, 2, 'SMTP is ready for message');

      // Header
      SetDynamicHeaders;
      Headers.Values['Newsgroups'] := InvParseCommaString(Newsgroups) ;
			Headers.Values['To'] := InvParseCommaString(Too) ;
      Headers.Values['Cc'] := InvParseCommaString(CCList);
      // X Headers
      Headers.Values['X-Library']:= 'WinShoes ' + Version;
      Headers.Values['X-Mailer'] := XProgram;
      //
      WriteHeaders(Headers);

      // Body
      inherited;

      DoStatus('    Waiting for acceptance');
      Command('.', 250, 2, 'Message accepted');
    finally
      if not bConnected then
        Disconnect;
    end;
  end;
end;

class procedure TWinshoeSMTP.QuickSend;
var
  Msg: TWinshoeMessage;
begin
	with TWinshoeSMTP.Create(nil) do try
    Msg := TWinshoeMessage.Create(Nil); try
      with Msg do begin
        Host := sHost;
        Subject := sSubject;
        Too.Text := sTo;
        From := sFrom;
        Text.Text := sText;
      end;
      Send(Msg);
    finally Msg.Free; end;
	finally Free; End;
end;

end.
