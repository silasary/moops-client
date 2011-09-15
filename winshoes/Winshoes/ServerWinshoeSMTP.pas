Unit ServerWinshoeSMTP;

Interface

////////////////////////////////////////////////////////////////////////////////
//   Server WinShoeSMTP
//
//
////////////////////////////////////////////////////////////////////////////////
//  Based on RFC 821 - The SMTP Protocol
//
// the WinshoeSMPT server is based on TWinshoeSMTPListener  which is an abstract
// component that just listens on the port and parses the received commands. It
// calls abstract procedures for each command; Events for each of these
// comands are defined in the listener.
// The TWinshoeSPTPServer decends from the TWinshoeSMTPListener and implements
// The commands and events.
// ON receipt of a commmand the DoCommandXXXX procedure is called and if assigned
// it calls the related event. If the event is not assigned then the default
// behavior is run.
// Each event has the boolean variable named Handled. If Handled is set to True
// in the event handler default processing is not done.
//
//------------------------------------------------------------------------------
// The simplest Mail transaction is as follows
// An SMTP Client makes a connection.
//
// The Doconnect sends the following reply
//      220 '+ComputerName +' Simple Mail Transfer Service Ready
// The Client then sends a HELO command Which consists of the HELO command
//  and the Clients Domain Name
// The DoCommandHelo then replies
//        '250 '+ SMTPDomainName
//  Where ComputerName is the name returned by Win Function GetComputerName
//
//  The Client then sends the MAIL command which contains the From address
//    For example: MAIL From: "Charlie Smith" <char@hisdomain.com>
//        or     MAIL From: char@hisdomain.com
//   The Mail comannd argument is stored in  fFromStr which is th FromStr Property
//   If the address part is valid ( that is chars, @ chars dot chars) the server
//   Replies 250 OK
// The Client then sends one or more RCPT commans in any of the following forms:
//        RCPT To: "Bill Jones" <bill@hisdomain.com> (this is a comment)
//        RCPT To: "Bill Jones" <bill@hisdomain.com>
//        RCPT To: <bill@hisdomain.com>
//        RCPT To: bill@hisdomain.com
//  If the addess part is NOT valid( that is chars, @ chars dot chars) the server
//  replies 501 Syntax error
//  If the address part is valid it checks to see if the domain is local. If not
//  the reply is 250 (should be 251) that it will forward teh mail.
//  If the domain is local a check is made to see if the mail box (User Id) is
//  valid. If it is not then a 550 ERR invalid mail box error is returned.

//   The RCPT comannd arguments is stored in  fRecipients tRecipientList
//  this list contains the Addrsss part of the RCPT command as the Addresss
//  Field. A Local Mail Boolean, and a Local client boolean. If both the
//  LocalMail and LocalClient are true, the path to the recipients mailbox is
//  stored in the MailBoxDir field.
//  Mail to Be forwared only has the address field set.

// The Client next sends the data command.
//   The server responds 354 Start Mail Input; End with <CRLF>.<CRLF>
// The client then sends text lines of the Email document which are stored in
//   the FData.StringList
//  When the <CRLF>.<CRLF> is received by the SErver it then stores the
//  DoCommandData then Calls WriteMailToUserDirOrForward whick drops local mail
//  to the Users MailBox or writes it to the  Pickup dir to be forwarded.
//
//  when it is finished.
//  DoCommandData then Sends the folowing reply
//   250 OK
//  At this point the client can call quit or start another Mail command
//-----------------------------------------------------------------------------
// Revision History
// 10/15/99
// 0.01 Modification to handle  extra Period and blank line
//      Supplied by Roman Evstyunichev... thanks.
//
// 10/15/99
// 0.01 Revised Writetodisk to make sure To: is the intended Recipient for To
//      CC and BC Do not depend on x-receiver
//
// 10/28/99  Found / solved by Roman Evstyunichev... thanks.
// 0.02 When user sends more then one message sequentially, session data was not
//      Reset. Added SessionMsg.Clear to DoCommandMail for Clients Software that
//      fails to call RSET before each Session.
//
// 11/19/99  Found / solved by Roman Evstyunichev... thanks.
// 0.03   GetInternetDateTimeStr had following defects
//        Date array was in local language, RFC's call for English
//        Also time bias wasn't set in function.
//        Date Statement in  WriteMesageToFile did not folow RFC Date Format
//
// 15-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Clients)
//
////////////////////////////////////////////////////////////////////////////////


Uses
  Classes,
  Winshoes,
  Dialogs,
  WinShoeMessage,
  ServerWinshoe;



Const
  SMTPCommands:Array [1..14] Of String=
   ('HELO', { From RFC 821 }
    'MAIL',
    'RCPT',
    'DATA',
    'SEND',
    'SOML',
    'SAML',
    'RSET',
    'EXPN',
    'HELP',
    'VRFY',
    'NOOP',
    'QUIT',
    'TURN');

  cHELO = 1;
  cMAIL = 2;
  cRCPT = 3;
  cDATA = 4;
  cSEND = 5;
  cSOML = 6;
  cSAML = 7;
  cRSET = 8;
  CVRFY = 9;
  cEXPN = 10;
  cHELP = 11;
  cNOOP = 12;
  cQuit = 13;
  cTURN = 14;

Type
   EWinshoeSMTPError = Class(EWinshoeException);

Type
  pRecipientRec = ^tRecipientRec;
  tRecipientRec = Record
    Address,
    MailboxDir : String;
    LocalDomain,
    LocalClient : Boolean;
   End;

Const
  HeaderNamesStrs: Array [0..7] Of String =
   ('From',        // 0
    'Organization',// 1
    'References',  // 2
    'Reply-To',    // 3
    'Subject',     // 4
    'To',          // 5
    'Message-ID',  // 6
    'Date'         // 7
     );

Const

  cFrom  = 0;
  cOrg   = 1;
  CRef   = 2;
  CRepy  = 3;
  CSub   = 4;
  CTo =  5;
  CMsgId = 6;
  cDate = 7;


Type
  tRecipientList = Class(TComponent)
  Private
    { Private declarations }
    fList : TList;
    fCount : Integer;
  Protected
    { Protected declarations }
  Public
    { Public declarations }
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy;  Override;
    Function IsValidIndex(Idx :Integer): Boolean;
  Published
    { Published declarations }
    Property Count : Integer Read fCount Write fCount;
    Procedure Add(RecipientItem : tRecipientRec);
    Procedure Delete(Idx : Integer);
    Procedure Clear;
    Function GetRecipientRec(Idx: Integer):tRecipientRec;
    Function GetAddress(Idx : Integer) : String;
    Procedure SetAddress(Idx : Integer;  AnAddress : String);
    Function GetMailBoxDir(Idx : Integer) : String;
    Procedure SetMailBoxDir(Idx : Integer; aDirString : String);
    Function IsLocalDomain(Idx : Integer) : Boolean;
    Procedure SetIsLocalDomain(Idx : Integer;Value : Boolean);
    Function IsLocalClient(Idx : Integer) : Boolean;
    Procedure SetIsLocalClient(Idx : Integer; Value : Boolean);
  End;


Type
  TSMTPMsg = Class(TComponent)
    Private
      fSendingDomain : String;
      fRecipients : TRecipientList;
      fFromStr : String;
      fData : TStringList;
      fDateTime : TDateTime;
      fMsgId : String;
    Protected
    Public
      Procedure Clear;
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
    Published
      Property SendingDomain : String Read fSendingDomain Write fSendingDomain;
      Property Recipients : TRecipientList Read fRecipients Write fRecipients;
      Property FromStr : String Read fFromStr Write fFromStr;
      Property Data : TStringList Read fdata Write fdata;
      Property DateTime : TDateTime Read FDateTime Write FdateTime;
      Property MsgId : String Read FmsgId Write fMsgId;
    End;

Type
  THeloEvent= Procedure(Thread: TWinshoeServerThread; Domain: String;
                        SessionMsg: tSMTPMsg; Var Handled : Boolean) Of Object;
  TMailEvent= Procedure(Thread: TWinshoeServerThread; FromStr: String;
                        SessionMsg: tSMTPMsg; Var Handled : Boolean) Of Object;
  TRCPTEvent= Procedure(Thread: TWinshoeServerThread; ToStr: String;
                        SessionMsg: tSMTPMsg; Var Handled : Boolean) Of Object;
  TVRFYEvent= Procedure(Thread: TWinshoeServerThread; aName: String;
                        Var Handled : Boolean) Of Object;
  TEXPNEvent= Procedure(Thread: TWinshoeServerThread; aListName: String;
                        Var Handled : Boolean) Of Object;
  THELPEvent= Procedure(Thread: TWinshoeServerThread; ACommand: String;
                        Var Handled : Boolean) Of Object;
  TDATAEvent= Procedure(Thread: TWinshoeServerThread; SessionMsg :tSMTPMsg;
                        Var Handled : Boolean) Of Object;
  TSMTPEvent= Procedure(Thread: TWinshoeServerThread; Var Handled : Boolean)
                        Of Object;
  TVerifyClientEvent = procedure(Const EmailAddress : String; VAR MailBoxPath: String;
                                  VAR IsLocal, Handled : Boolean) of Object;
  TErrorEvent= Procedure(Thread: TWinshoeServerThread; ArgSTr: String;
                         Var Handled : Boolean) Of Object;

  TWinshoeSMTPListener = Class(TWinshoeListener)
  Private
{other support}
    fOnCommandHELO : THeloEvent;
    fOnCommandMAIL : TMailEvent;
    fOnCommandRCPT : TRcptEvent;
    fOnCommandDATA : TDATAEvent;
    fOnCommandSEND : TMailEvent;
    fOnCommandSOML : TMailEvent;
    fOnCommandSAML : TMailEvent;
    fOnCommandRSET : TDataEvent;
    fOnCommandVRFY : TVRFYEvent;
    fOnCommandEXPN : TEXPNEvent;
    fOnCommandHELP : THelpEvent;
    fOnCommandNOOP : TSMTPEvent;
    fOnCommandQUIT : TSMTPEvent;
    fOnCommandTURN : TDATAEvent;
    fonVerifyClient : TVerifyClientEvent;
    fOnCommandError : TErrorEvent;
  Protected
    Procedure DoCommandHELO(Thread: TWinshoeServerThread; Domain: String;
                            SessionMsg: tSMTPMsg; Var Handled: Boolean); Virtual; Abstract;
    Procedure DoCommandMAIL(Thread: TWinshoeServerThread; FromStr: String;
                            SessionMsg: tSMTPMsg; Var Handled: Boolean); Virtual; Abstract;
    Procedure DoCommandRCPT(Thread: TWinshoeServerThread; ToStr: String;
                            SessionMsg: tSMTPMsg; Var Handled: Boolean); Virtual; Abstract;
    Procedure DoCommandDATA(Thread: TWinshoeServerThread; SessionMsg: tSMTPMsg;
                            Var Handled : Boolean); Virtual;  Abstract;
    Procedure DoCommandSEND(Thread: TWinshoeServerThread; FromStr: String;
                            SessionMsg: tSMTPMsg; Var Handled: Boolean); Virtual; Abstract;
    Procedure DoCommandSOML(Thread: TWinshoeServerThread; FromStr: String;
                            SessionMsg: tSMTPMsg; Var Handled : Boolean);Virtual; Abstract;
    Procedure DoCommandSAML(Thread: TWinshoeServerThread; FromStr: String;
                            SessionMsg: tSMTPMsg; Var Handled: Boolean); Virtual; Abstract;
    Procedure DoCommandRSET(Thread: TWinshoeServerThread; SessionMsg: tSMTPMsg;
                            Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandVRFY(Thread: TWinshoeServerThread; aName: String;
                            Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandEXPN(Thread: TWinshoeServerThread; aListName: String;
                            Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandHELP(Thread: TWinshoeServerThread; aCommand: String;
                            Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandNOOP(Thread: TWinshoeServerThread;
                             Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandQUIT(Thread: TWinshoeServerThread;
                            Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandTURN(Thread: TWinshoeServerThread;SessionMsg: tSMTPMsg;
                            Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandError(Thread: TWinshoeServerThread; ArgSTr: String;
                             Var Handled : Boolean); Virtual; Abstract;

    Function DoExecute(Thread: TWinshoeServerThread): Boolean; Override;
  Public
    Constructor Create(AOwner: TComponent); Override;

  Published
    Property OnCommandHELO : THELOEvent Read fOnCommandHELO Write fOnCommandHELO;
    Property OnCommandMAIL : TMAILEvent Read fOnCommandMAIL Write fOnCommandMAIL;
    Property OnCommandRCPT : TRCPTEvent Read fOnCommandRCPT Write fOnCommandRCPT;
    Property OnCommandDATA : TDATAEvent Read fOnCommandDATA Write fOnCommandDATA;
    Property OnCommandSEND : TMAILEvent Read fOnCommandSEND Write fOnCommandSEND;
    Property OnCommandSOML : TMAILEvent Read fOnCommandSOML Write fOnCommandSOML;
    Property OnCommandSAML : TMAILEvent Read fOnCommandSAML Write fOnCommandSAML;
    Property OnCommandRSET : TDataEvent Read fOnCommandRSET Write fOnCommandRSET;
    Property OnCommandVRFY : TVRFYEvent Read fOnCommandVRFY Write fOnCommandVRFY;
    Property OnCommandEXPN : TEXPNEvent Read fOnCommandEXPN Write fOnCommandEXPN;
    Property OnCommandHELP : THELPEvent Read fOnCommandHELP Write fOnCommandHELP;
    Property OnCommandNOOP : TSMTPEvent Read fOnCommandNOOP Write fOnCommandNOOP;
    Property OnCommandQUIT : TSMTPEvent Read fOnCommandQUIT Write fOnCommandQUIT;
    Property OnCommandTURN : TDATAEvent Read fOnCommandTURN Write fOnCommandTURN;
    Property OnCommandError : TErrorEvent Read fOnCommandError Write fOnCommandError;
    PROPERTY OnVerifyClient : TVerifyClientEvent Read fOnVerifyClient Write FOnVerifyClient;
  End;

Type
  TWinshoeSMTPServer = Class(TWinshoeSMTPListener)
  Protected
    fLocalDomains : TStrings;
    UniqueNumber : Integer;
    fLogDebug,
    fForwardMail,
    fUseDomainDirs : Boolean;
    fMailRootDir : String;
    //
    Procedure SetLocalDomains( Value :Tstrings);
    Procedure DoConnect(Thread: TWinshoeServerThread); Override;
    Procedure DoCommandHELO(Thread: TWinshoeServerThread; Domain: String;
                            SessionMsg:tSMTPMsg; Var Handled: Boolean); Override;
    Procedure DoCommandMAIL(Thread: TWinshoeServerThread; FromStr: String;
                            SessionMsg: tSMTPMsg; Var Handled: Boolean); Override;
    Procedure DoCommandRCPT(Thread: TWinshoeServerThread; ToStr: String;
                            SessionMsg: tSMTPMsg; Var Handled: Boolean); Override;
    Procedure DoCommandDATA(Thread: TWinshoeServerThread; SessionMsg: tSMTPMsg;
                            Var Handled : Boolean); Override;
    Procedure DoCommandSEND(Thread: TWinshoeServerThread; FromStr: String;
                            SessionMsg: tSMTPMsg; Var Handled: Boolean); Override;
    Procedure DoCommandSOML(Thread: TWinshoeServerThread; FromStr: String;
                            SessionMsg: tSMTPMsg; Var Handled: Boolean); Override;
    Procedure DoCommandSAML(Thread: TWinshoeServerThread; FromStr: String;
                            SessionMsg: tSMTPMsg; Var Handled: Boolean); Override;
    Procedure DoCommandRSET(Thread: TWinshoeServerThread; SessionMsg: tSMTPMsg;
                            Var Handled : Boolean); Override;
    Procedure DoCommandVRFY(Thread: TWinshoeServerThread; aName: String;
                             Var Handled : Boolean); Override;
    Procedure DoCommandEXPN(Thread: TWinshoeServerThread; aListName: String;
                             Var Handled : Boolean); Override;
    Procedure DoCommandHELP(Thread: TWinshoeServerThread; aCommand: String;
                             Var Handled : Boolean); Override;
    Procedure DoCommandNOOP(Thread: TWinshoeServerThread;
                            Var Handled: Boolean); Override;
    Procedure DoCommandQUIT(Thread: TWinshoeServerThread;
                            Var Handled : Boolean); Override;
    Procedure DoCommandTURN(Thread: TWinshoeServerThread; SessionMsg: tSMTPMsg;
                            Var Handled : Boolean); Override;
    Procedure DoCommandError(Thread: TWinshoeServerThread; ArgSTr: String;
                             Var Handled : Boolean); Override;
    Procedure WriteDebugMsg(Const aStr :String);
    Function IsLocalDomain(Const aDomain : String): Boolean;
    Function AddressIsLocal(aIdx : Integer;  SessionMsg : tSMTPMsg): Boolean;
    Procedure SetMailBoxIfLocalClient(aIdx : Integer; AnAddress : String; SessionMsg : TSMTPMsg);
    Function AddressStrIsValid( AddrStr: String): Boolean;
    Procedure SetHeaderStrsToValues(HeaderStrs: TStringList);
    Function CreateAnEmailFileName(Const LocalName : String) : String;
    Function WriteMesageToFile(Const FiName : String;Idx: Integer; SessionMsg: TSMTPMsg): Integer;
    Function WriteMessageToClientDir(Idx: Integer; SessionMsg: TSMTPMsg): Integer;
    Function ForwardMessage(Idx : Integer; SessionMsg: TSMTPMsg): Integer;
    Function WriteMailToUserDirOrForward(Thread : TWinshoeServerThread; SessionMsg: tSMTPMsg): Integer;
  Public
    Constructor Create(AOwner : TComponent); Override;
    Destructor Destroy; Override;
  Published
    Property LocalDomains : TStrings Read FLocalDomains Write SetLocalDomains;
    Property LogDebug : Boolean Read fLogDebug Write fLogDebug;
    Property UseDomainDirs: Boolean Read fUseDomainDirs Write fUseDomainDirs;
    Property MailRootDir : String Read fMailRootDir Write fmailRootDir;
    Property ForwardMail : Boolean Read fForwardMail Write fForwardMail;
  End;

// Procs

  Procedure Register;

Implementation

Uses
  Windows,
  FileCtrl,
  GlobalWinshoe,
  SysUtils;

Const
  VersionId = 'Winshoe SMTP Server Version .10';

  Procedure Register;
  Begin
    RegisterComponents('Winshoes Servers', [TWinshoeSMTPServer]);
  End;

//------------------------------------------------------------------------------
//                        Start RecipientList Code
//------------------------------------------------------------------------------
  Constructor TRecipientList.Create(AOwner : TComponent);
  Begin
    Inherited Create(AOwner);
    fList := TList.Create;
    fList.Clear;
    fCount := 0;
  End;

  Destructor TRecipientList.Destroy;
  Var
    Idx : Integer;
    aPtr : pRecipientRec;
  Begin
    If fList.Count > 0 Then Begin
      For Idx := 0 To (fList.count -1) Do Begin
         aPtr := fList.Items[Idx];
         Dispose(aPtr);
       End;
     End;
    fList.Free;
    Inherited Destroy;
  End;

  Procedure TRecipientList.Clear;
  Var
    aPtr : pRecipientRec;
    Idx : Integer;
  Begin
    If fList.count > 0 Then Begin
      For Idx := 0 To (fList.count -1) Do Begin
         aPtr := fList.Items[Idx];
         Dispose(aPtr);
       End;
       fList.Clear;
     End;
    fCount := 0;
  End;

  Function TRecipientList.IsValidIndex(Idx :Integer): Boolean;
  Begin
    Result := (Idx >= 0) And (Idx < Fcount);
    If Not Result Then
      Raise EWinshoeSMTPError.Create('Recipient Index is out of range');
  End;

  Procedure TRecipientList.Add(RecipientItem : tRecipientRec);
  Var
    pRecipientItem : pRecipientRec;
  Begin
    New(pRecipientItem);
    pRecipientItem^.Address := RecipientItem.Address;
    pRecipientItem^.MailBoxDir := RecipientItem.MailBoxDir;
    pRecipientItem^.LocalDomain := RecipientItem.LocalDomain;
    pRecipientItem^.LocalClient := RecipientItem.LocalClient;
    fList.Add(pRecipientItem);
    fCount := fList.Count;
  End;

  Procedure TRecipientList.Delete(Idx : Integer);
  Var
    pRecipientItem : pRecipientRec;
  Begin
    If IsValidIndex (idx) Then Begin
      pRecipientItem := fList.Items[Idx];
      Dispose(pRecipientItem);
      fList.Delete(Idx);
      fCount := fList.Count;
    End;
  End;

  Function TRecipientList.GetRecipientRec(Idx: Integer):tRecipientRec;
  Var
    RecipientItem : tRecipientRec;
  Begin
    FillChar(RecipientItem,SizeOf(RecipientItem),0);
    Result := RecipientItem;
    If (Idx < fList.Count) And (Idx >= 0) Then Begin
      Result := tRecipientRec(fList.Items[Idx]^);
    End;
  End;

  Function TRecipientList.GetAddress(Idx : Integer) : String;
  Begin
    If IsValidIndex(Idx) Then
      Result := tRecipientRec(fList.Items[Idx]^).Address;
  End;

  Procedure TRecipientList.SetAddress(Idx : Integer;  AnAddress : String);
  Begin
    If IsValidIndex(Idx) Then
      tRecipientRec(fList.Items[Idx]^).Address := AnAddress;
  End;

  Function TRecipientList.GetMailBoxDir(Idx : Integer) : String;
  Begin
    If IsValidIndex(Idx) Then
      Result := tRecipientRec(fList.Items[Idx]^).MailBoxDir;
  End;

  Procedure TRecipientList.SetMailBoxDir(Idx : Integer; aDirString : String);
  Begin
    If IsValidIndex(Idx) Then
      tRecipientRec(fList.Items[Idx]^).MailBoxDir := aDirString;
  End;

  Function TRecipientList.IsLocalDomain(Idx : Integer) : Boolean;
  Begin
    Result := False;
    If IsValidIndex(Idx) Then
      Result := tRecipientRec(fList.Items[Idx]^).LocalDomain;
  End;

  Procedure TRecipientList.SetIsLocalDomain(Idx : Integer; Value : Boolean);
  Begin
    If IsValidIndex(Idx) Then
      tRecipientRec(fList.Items[Idx]^).LocalDomain := Value;
  End;

  Function TRecipientList.IsLocalClient(Idx : Integer) : Boolean;
  Begin
    Result := False;
    If IsValidIndex(Idx) Then
      Result := tRecipientRec(fList.Items[Idx]^).LocalClient;
  End;

  Procedure TRecipientList.SetIsLocalClient(Idx : Integer; Value : Boolean);
  Begin
    If IsValidIndex(Idx) Then
      tRecipientRec(fList.Items[Idx]^).LocalClient := Value;
  End;
//------------------------------------------------------------------------------
//                        End RecipientList Code
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
//                        Start Global Code
//------------------------------------------------------------------------------
// GetTimezone  added - Roman Evstyunichev {!!0.03}
  Function GetTimeZone: string;{!!0.03}
  var
    TimeZoneInformation: TTimeZoneInformation;
    TZResult: cardinal;
    nBias: integer;
  const
    // CB3 and D3 do not have all of these
    // TODO move these to common unit when unlocked
    TIME_ZONE_ID_UNKNOWN  = 0;
  begin          { GetTimeZone }
    TZResult := GetTimeZoneInformation(TimeZoneInformation);
    Result := 'GMT';
    if (TZResult <> $FFFFFFFF) AND (TZResult <> TIME_ZONE_ID_UNKNOWN) then
    begin
      nBias := TimeZoneInformation.Bias;
      if nBias <> 0 then
      begin
        if nBias < 0
          then Result := '+'
          else Result := '-';
        nBias := Abs(nBias);
        Result := Result + Format('%.2d%.2d', [nBias div 60, nBias mod 60]);
      end;
    end;
  end;         { GetTimeZone }

// Gets RFC-formatted datetime - Roman Evstyunichev {!!0.03}
  Function GetInternetDateTimeStr(ADateTime: TDateTime): string;
  const { RFC Rrquires English Delphi Month names in Local Language}
    MonthNames: array [1..12] of string[3] =
      ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
  var
    Year, Month, Day: word;
    S: string;
  begin   { GetInternetDateTimeStr }
    DecodeDate(ADateTime, Year, Month, Day);
    S := Format('%.2d ', [Day]) + MonthNames[Month] +
      FormatDateTime(' yy hh:nn:ss ', ADateTime);
    Result := S + GetTimeZone;
  end;   { GetInternetDateTimeStr }


  Function FixDirBackSlash(Const aDir : String): String;
  Begin
    If AnsiLastChar(aDir)^ <> '\' Then
      Result := aDir + '\'
    Else
      Result := aDir;
  End;

  Procedure ParseAddress(Const FullAddrStr: String; Var EmailAddr, ClientName: String);
  Var
    iPos: Integer;
  Begin
    EmailAddr  := ''; ClientName  := '';
    If Copy(FullAddrStr, Length(FullAddrStr) , 1) = '>' Then Begin
      iPos := Pos('<', FullAddrStr);
      If iPos > 0 Then Begin
        EmailAddr := Trim(Copy(FullAddrStr, iPos + 1, Length(FullAddrStr) - iPos - 1));
        ClientName := Trim(Copy(FullAddrStr, 1, iPos - 1));
      End;
    End
    Else If Copy(FullAddrStr, Length(FullAddrStr), 1) = ')' Then Begin
      iPos := Pos('(', FullAddrStr);
      If iPos > 0 Then Begin
        ClientName := Trim(Copy(FullAddrStr, iPos + 1, Length(FullAddrStr) - iPos - 1));
        EmailAddr := Trim(Copy(FullAddrStr, 1, iPos - 1));
      End;
    End
    Else EmailAddr := FullAddrStr;
    While Length(ClientName) > 1 Do Begin
      If (ClientName[1] = '"') And (ClientName[Length(ClientName)] = '"') Then
        ClientName := Copy(ClientName, 2, Length(ClientName) - 2)
      Else
        If (ClientName[1] = '''') And (ClientName[Length(ClientName)] = '''') Then
          ClientName := Copy(ClientName, 2, Length(ClientName) - 2)
      Else
        break;
    End;
    If Length(ClientName) = 0 Then
      ClientName := EmailAddr;
  End;


//------------------------------------------------------------------------------
//                        Start SMTP Message Code
//------------------------------------------------------------------------------
  Constructor TSMTPMsg.Create(AOwner: TComponent);
  Begin                           { Create }
    Inherited Create(AOwner);
    fRecipients := TRecipientList.Create(Self);
    fData := TSTringList.Create;
  End;                            { Create }

  Destructor TSMTPMsg.Destroy;
  Begin                           { Destroy }
    FRecipients.Free;
    Fdata.Free;
    Inherited Destroy;
  End;                            { Destroy }

  Procedure TSMTPMsg.Clear;
  Begin
    fRecipients.Clear;
    fData.Clear;
    fSendingDomain := '';
    fFromStr := '';
    fDateTime := 0;
    fMsgId := '';
  End;

//------------------------------------------------------------------------------
//  Start Of TWinshoeSMTPListener Code
//------------------------------------------------------------------------------
  Constructor TWinshoeSMTPListener.Create(AOwner: TComponent);
  Begin                           { Create }
    Inherited Create(AOwner);
    Port :=  WSPORT_SMTP;;
  End;                            { Create }

  Function TWinshoeSMTPListener.DoExecute(Thread: TWinshoeServerThread): Boolean;
  Var
    RcvdStr,
    ArgStr,
    sCmd: String;
    CmdNum : Integer;
    Handled : Boolean;
    SessionMsg : tSMTPMsg;

    Function GetFirstTokenDeleteFromArg(Var s1: String; Const sDelim: String): String;
    Var
      nPos: Integer;
    Begin                         { GetFirstTokenDeleteFromArg }
      nPos := Pos(sDelim, s1);
      If nPos = 0 Then
        nPos := Length(s1) + 1;
      Result := Copy(s1, 1, nPos - 1);
      Delete(s1, 1, nPos);
      S1 := Trim(S1);
    End;                          { GetFirstTokenDeleteFromArg }

  Begin                           { DoExecute }
    Result := Inherited DoExecute(Thread);
    If Result Then
      Exit;
    SessionMsg := tSMTPMsg.Create(Self);
    With Thread.Connection Do Begin
      While Connected Do Begin
        Handled := False;
        RcvdStr := ReadLn;
        ArgStr := RcvdStr;
        sCmd := UpperCase(GetFirstTokenDeleteFromArg(ArgStr,CHAR32));
        CmdNum := Succ(PosInStrArray(Uppercase(sCmd),SMTPCommands));
        Case CmdNum Of
          cHELO : DoCommandHELO(Thread, ArgStr, SessionMsg, Handled);
          cMAIL : DoCommandMAIL(Thread, ArgStr, SessionMsg, Handled);
          cRCPT : DoCommandRCPT(Thread, ArgStr, SessionMsg, Handled);
          cDATA : DoCommandDATA(Thread, SessionMsg, Handled);
          cSEND : DoCommandSEND(Thread, ArgStr, SessionMsg, Handled);
          cSOML : DoCommandSOML(Thread, ArgStr, SessionMsg, Handled);
          cSAML : DoCommandSAML(Thread, ArgStr, SessionMsg, Handled);
          cRSET : DoCommandRSET(Thread, SessionMsg, Handled);
          CVRFY : DoCommandVRFY(Thread, ArgStr, Handled);
          cEXPN : DoCommandEXPN(Thread, ArgStr, Handled);
          cHELP : DoCommandHELP(Thread, ArgStr, Handled);
          cNOOP : DoCommandNOOP(Thread, Handled);
          cQuit : DoCommandQUIT(Thread, Handled);
          cTURN : DoCommandTURN(Thread, SessionMsg, Handled);
          Else DoCommandError(Thread, RcvdStr, Handled);
        End; {Case}
      End; {while}
    End; {with}
    SessionMsg.Free;
  End;                            { DoExecute }

//------------------------------------------------------------------------------
//  Start Of TWinshoeSMTPServer Code
//------------------------------------------------------------------------------
  Constructor TWinshoeSMTPServer.Create(AOwner: TComponent);
  Begin
    Inherited Create(AOwner);
    fLocalDomains := TStringList.Create;
    Randomize;
    UniqueNumber := Random(1000);
  End;

  Destructor TWinShoeSMTPServer.Destroy;
  Begin
    fLocalDomains.Free;
    Inherited Destroy;
  End;

  Procedure TWinshoeSMTPServer.WriteDebugMsg(Const aStr :String);
  Var
    aFile :Text;
  Begin                           { WriteDebugMsg }
    {$I-}
    If Boolean(IoResult) Then;
    AssignFile(aFile,FixDirBackSlash(fMailRootDir) +'Smtp.log');
    Append(aFile);
    If IoResult <> 0 Then
      ReWrite(Afile);
    WriteLn(Afile,DateTimeToStr(Now)+' '+Astr);
    Close(Afile);
    {$I+}
  End;                           { WriteDebugMsg }

  Procedure TWinshoeSMTPServer.SetLocalDomains(Value: TStrings);
  Begin
    FLocalDomains.Assign(Value);
  End;


  Function TWinShoeSMTPServer.IsLocalDomain(Const aDomain : String): Boolean;
  Var
    Idx : Integer;
  Begin                           { IsLocalDomain }
    For Idx := 0 To fLocalDomains.Count -1 Do Begin
      If CompareText(aDomain,fLocalDomains.Strings[Idx]) = 0 Then Begin
        Result := True;
        Exit;
      End;
    End;
    Result := False;
  End;                            { IsLocalDomain }

  Procedure TWinShoeSMTPServer.SetMailBoxIfLocalClient(aIdx : Integer; AnAddress : String; SessionMsg : TSMTPMsg);
  Var
    UserId : String;
    ClientAddress,
    MailBoxPath : String;
    IsLocal,
    Handled : Boolean;

    Function GetEmailAddress: String;
    var
      ClientName : String;
    begin
      ParseAddress(anAddress, Result, ClientName);
      Result := Trim(Result);
    End;

    Function GetUserId : String;
    Var
      aPos : Integer;
      EmailAddress :String;
    Begin                       { GetUserId }
      EmailAddress := GetEmailAddress;
      aPos := Pos('@', EmailAddress);
      If UseDomainDirs Then Begin
        Result := Copy(EmailAddress, Succ(Apos), 255) + '\' + Copy(EmailAddress, 1, Pred(aPos));
      End Else begin
        Result := Copy(EmailAddress, 1, Pred(aPos));
      end;
    End;                        { GetUserId }

  begin
    MailBoxPath := '';
    Handled := False;
    IsLocal := False;
    If Assigned(fOnVerifyClient) Then begin
      ClientAddress := GetEmailAddress;
      fOnVerifyClient(ClientAddress,MailBoxPath, IsLocal, Handled);
      If Handled then Begin
        If IsLocal then Begin
          With SessionMsg.Recipients Do Begin
            SetMailboxDir(aIdx,MailBoxpath);
            SetIsLocalClient(aIdx, True);
          End;
        End;
      End;
    End;
    If Handled = False Then Begin
      UserId := GetUserId;
      If fLogDebug Then
        WriteDeBugMsg('SetMailboxIfLocalClient says Sub dir is '+UserId);
      If DirectoryExists(FixDirBackSlash(fMailRootdir)+'MailBoxes\'+UserId) Then Begin
        { Only a valid user has a mailbox directory }
        With SessionMsg.Recipients Do Begin
          SetMailboxDir(aIdx,FixDirBackSlash(fMailRootDir)+'MailBoxes\'+UserId);
          SetIsLocalClient(aIdx, True);
        End;
      End;
    End;
  End;

  Function TWinShoeSMTPServer.AddressIsLocal(aIdx : Integer; SessionMsg : tSMTPMsg): Boolean;
  Var
    ToStr,
    ActualAddress,
    AddressName : String;
    ActualDomain : String;
    Idx,
    Ipos : Integer;
  Begin                           { AddressIsLocal }
    Result := False;
    ToStr := SessionMsg.Recipients.GetAddress(aIdx);
    If fLogDebug
      Then WriteDebugMsg('AddressIsLocal says toStr is '+ToStr);
    ParseAddress(Tostr,ActualAddress,AddressName);
    ActualDomain := ActualAddress;
    Ipos := Pos('@',ActualDomain);
    If Ipos <> 0 Then
      ActualDomain := Copy(ActualDomain,Succ(Ipos),255);
    If fLogDebug Then
      WriteDebugMsg('AddressIsLocal says Domains.Count '+InttosTr(FLocalDomains.Count));
    If fLocalDomains.Count > 0 Then Begin
      For idx := 0 To fLocalDomains.Count - 1 Do Begin
        If fLogDebug Then
          WriteDebugMsg('AddressIsLocal says actual domain is '+ActualDomain +
                     ' DomainOnFile is '+FLocalDomains.Strings[Idx]);
        If CompareText(ActualDomain,fLocalDomains.Strings[Idx]) = 0 Then begin
          If fLogDebug Then
            WriteDebugMsg('AddressIsLocal says LocalDomain Is True');
          Result := True;
          SessionMsg.Recipients.SetIsLocalDomain(aIdx,True);
          SetMailboxIfLocalClient(aIdx, ActualAddress,SessionMsg);
          Exit;
        End;
      End;
    End;
  End;                            { AddressIsLocal }

Function TWinShoeSMTPServer.AddressStrIsValid(AddrStr: String): Boolean;
Var
  UpAddrStr,
  ActualAddr,NameStr: String;
  Ipos : Integer;
Begin                           { AddressStrIsValid }
  Result := False;
  UpAddrStr := UpperCase(AddrStr);
  Ipos := Pos('TO:',UpaddrStr);
  If IPos <> 0 Then
    Delete(AddrStr,Ipos,3)
  Else Begin
    Ipos := Pos('FROM:',UpAddrStr);
    If Ipos <> 0 Then Delete(AddrStr,Ipos,5);
  End;
  AddrStr := Trim(AddrStr);
  ParseAddress(AddrStr, ActualAddr, NameStr);
  If Length(ActualAddr) > 0 Then Begin
    Result := Pos('@',ActualAddr) <> 0;
  End;
End;                            { AddressStrIsValid }

  Procedure TWinshoeSMTPServer.SetHeaderStrsToValues(HeaderStrs: TStringList);
  Var
    Idx : Integer;
  Begin                       { SetHeaderStrsToValues }
    For Idx := 0 To HeaderStrs.Count -1 Do Begin
      HeaderStrs[Idx] := StringReplace(HeaderStrs[Idx], ': ', '=', []);
    End;                      { SetHeaderStrsToValues }
  End;

  Function TWinshoeSMTPServer.CreateAnEmailFileName(Const LocalName : String) : String;
  Var
    Year, Month, Day: Word;
    Hour, Min, Sec, MSec: Word;

    Function Wd2Str(aWord : Word): String;
    Begin                         { Wd2Str }
      Result := IntToSTr(AWord);
      While Length(Result) < 2 Do Result := '0'+Result;
    End;                          { Wd2Str }

  Begin                           { CreateAnEmailFileName }
     Inc(UniqueNumber);
     DecodeDate(Now, Year, Month, Day);
     DecodeTime(Now, Hour, Min, Sec, MSec);
     Result := Wd2Str(Year)+ Wd2Str(Month)+Wd2Str(Day)+ Wd2Str(Hour)+
               Wd2Str(Min)+ Wd2Str(Sec)+IntToStr(UniqueNumber)+LocalName+'.eml';
  End;                            { CreateAnEmailFileName }

  Function TWinShoeSMTPServer.WriteMesageToFile(Const FiName : String;Idx: Integer; SessionMsg: TSMTPMsg): Integer;
  Var
    TheSender,
    TheReceiver,
    TheName,
    aStr : String;
    f: Text;
    mIdx : Integer;
  Begin
    With SessionMsg Do Begin
      Try
        Try
          If fLogDebug Then
            WriteDeBugMsg('WriteMsgToFile says finame is '+FiName);
          AssignFile(f,FiName);
          ReWrite(F);
          ParseAddress(fFromStr ,TheSender,TheName);
          Astr := 'x-sender: '+ TheSender;
          WriteLn(f,Astr);
          ParseAddress(Recipients.GetAddress(Idx),TheReceiver,TheName);
          Astr := 'x-receiver: '+TheReceiver;
          WriteLn(f,Astr);
          Astr := 'Received: from '+ fSendingDomain +' by '+ LocalName {!!0.03}
                 +' using UUCP Connect SMTP Server Version 1.0'
                 +' for <'+ TheReceiver+  '>; '+GetInternetDateTimeStr(Now);
          WriteLn(F,Astr);
          //{!!0.01 Start} Revised to make sure To: is the intended Recipient for To CC and BC
          // To: Cc: and Bc:  Do not depend on x-receiver
          For midx := 0 to Fdata.Count - 1 do Begin
            If FData.Strings[Midx] = '' then
              Break
            Else
              If CompareText(Copy(FData.Strings[Midx],1,3),'To:') = 0 then begin
                Fdata.Strings[Midx] := 'To: ' +TheReceiver;
                Break;
              End;
          end;
          //{!!0.01 End}
          For mIdx := 0 To Fdata.count - 1 Do Begin
            WriteLn(F,Fdata.Strings[mIdx]);
          End;
          Result := 0;
        Except
          On Exception Do
            Result := 1;
        End;
      Finally
        CloseFile(f);
      End;
    End;
  End;

  Function tWinShoeSMTPServer.WriteMessageToClientDir(Idx: Integer; SessionMsg: TSMTPMsg): Integer;
  Var
    FiName : String;
  Begin
    With SessionMsg Do Begin
      FiName := Recipients.GetMailBoxDir(Idx);
      FiName := FixDirBackSlash(FiName) + CreateAnEMailFileName(LocalName);
      Result :=WriteMesageToFile( FiName ,Idx, SessionMsg);
    End;
  End;

  Function TWinshoeSMTPServer.ForwardMessage(Idx : Integer; SessionMsg: TSMTPMsg): Integer;
  Var
    FiName : String;
  Begin
    With SessionMsg Do Begin
      FiName := FixDirBackSlash(fMailRootDir)+'Pickup\' + CreateAnEMailFileName(LocalName);
      Result := WriteMesageToFile( FiName ,Idx, SessionMsg);
      If Result <> 0 Then
        Result := 2;
    End;
  End;

  Function TWinShoeSMTPServer.WriteMailToUserDirOrForward(Thread: TWinshoeServerThread;
                                                   SessionMsg:tSMTPMsg):Integer;
  Var
    Idx : Integer;
  Begin                           { WriteMailToUserdirOrForward }
    Result := 100;
    With SessionMsg Do Begin
      For Idx := 0 To Recipients.count -1 Do Begin
         If Recipients.IsLocalDomain(Idx) Then Begin
           If Recipients.IsLocalClient(Idx) Then Begin
             Result := WriteMessageToClientDir(Idx,SessionMsg);
           End
           Else
             Result := 0;
           {Valid local domain and Invalid client mail was rejected by RCPT}
         End
         Else Begin
           Result := ForwardMessage(Idx,SessionMsg);
         End;
         If Result <> 0 Then
           Exit;
      End;
    End;
  End;                            { WriteMailToPickupDir }

  Procedure TWinShoeSMTPServer.DoConnect(Thread: TWinshoeServerThread);
  Begin                           { DoConnect }
    Thread.Connection.WriteLn('220 '+LocalName +' Simple Mail Transfer Service Ready');
    If fLogDebug  Then Begin
      WriteDebugMsg('');
      WriteDeBugMsg('');
      WriteDebugMsg('Connect says 220 '+LocalName +' Simple Mail Transfer Service Ready');
    End;
  End;                            { DoConnect }

  Procedure TWinShoeSMTPServer.DoCommandHELO(Thread: TWinshoeServerThread; Domain: String;
                                              SessionMsg: tSMTPMsg;Var Handled : Boolean);
  Begin                           { DoCommandHELO }
    If Assigned(OnCommandHELO) Then
      OnCommandHELO(Thread, Domain,SessionMsg, Handled);
    If Not Handled Then Begin
      With SessionMsg Do Begin
        If Length(SendingDomain) > 0 Then Begin
          Thread.Connection.WriteLn('503 HELO Command is out of sequence');
          If fLogDebug  Then
            WriteDebugMsg('HELO says 503 Bad Command Sequence');
        End
        Else Begin
          SendingDomain := Domain;
          Thread.Connection.WriteLn('250 '+ LocalName);
          If fLogDebug Then
            WriteDebugMsg('HELO says 250 '+LocalName);
        End;
      End;
    End;
  End;                            { DoCommandHELO }

 Procedure TWinShoeSMTPServer.DoCommandMAIL(Thread: TWinshoeServerThread;FromStr: String;
                                            SessionMsg: tSMTPMsg;Var Handled : Boolean);
  Var
    aStr : String;
    aPos : Integer;
  Begin                           { DoCommandMAIL }
    If Assigned(OnCommandMAIL) Then
      OnCommandMAIL(Thread,FromStr,SessionMsg, Handled);
    If Not Handled Then Begin
      SessionMsg.Clear;  // (!!0.02} Some Clients do not call Rset on Sequential Sends
                         // Modification by Roman Evstyunichev... thanks.
      If AddressStrIsValid(FromStr) Then Begin
        If fLogDebug  Then
          WriteDebugMsg('MAIL says 250 OK '+FromStr);
        aStr := UpperCase(FromStr);
        aPos := Pos('FROM:',Astr);
        If aPos <> 0 Then Delete(FromStr,aPos,5);
        FromStr := Trim(FromStr);
        SessionMsg.fFromStr := FromStr;
        Thread.Connection.WriteLn('250 OK');
      End Else Begin
        Thread.Connection.WriteLn('501 Bad From Address');
        If fLogDebug  Then begin
          WriteDebugMsg('MAIL says 501 Bad From Address '+FromStr);
        end;
      End;
    End;
  End;                            { DoCommandMAIL }

  Procedure TWinShoeSMTPServer.DoCommandRCPT(Thread: TWinshoeServerThread; ToStr: String;
                                              SessionMsg: tSMTPMsg; Var Handled : Boolean);
  Var
    aStr : String;
    aRecipient : TRecipientRec;
    aPos,
    aIdx : Integer;
  Begin                           { DoCommandRCPT }
    If Assigned(OnCommandRCPT) Then
      OnCommandRCPT(Thread, ToStr,SessionMsg, Handled);
    If Not Handled Then Begin
      If AddressStrIsValid(ToStr) Then Begin
        FillChar(ARecipient,SizeOf(ARecipient),0);
        astr := UpperCase(tostr);
        aPos := Pos('TO:',Astr);
        If Apos <> 0 Then
          Delete(TosTr,Apos,3);
        ToStr := Trim(TosTr);
        aRecipient.Address := ToStr;
        SessionMsg.Recipients.Add(aRecipient);
        aIdx := SessionMsg.Recipients.Count -1;
        If AddressIsLocal(aIdx,SessionMsg) Then Begin
          If SessionMsg.Recipients.IsLocalClient(aIdx) Then Begin
            Thread.Connection.WriteLn('250 OK');
            If fLogDebug Then
              WriteDebugMsg('RCPT says 250 OK '+Tostr+'Valid Local Address Recieved');
          End
          Else Begin
            Thread.Connection.WriteLn('550 ERR -  Mail Box invalid. Does not exist');
            If fLogDebug Then
              WriteDebugMsg('RCPT says 550 ERR '+Tostr+'NOT Valid Local Client');
          End;
        End
        Else Begin
          If fForwardMail Then Begin
            Thread.Connection.WriteLn('250 OK ');
            If fLogDebug Then
              WriteDebugMsg('RCPT says 250 OK '+Tostr+' Address to Forward Recieved');
          End
          Else Begin
            Thread.Connection.WriteLn('550 Err Address Not configured to forward mail.');
            If fLogDebug  Then
              WriteDebugMsg('RCPT says 550 ERR Address is not local Forward Mail Disabled');
          End;
        End
      End
      Else Begin
        Thread.Connection.WriteLn('501 Syntax Error in RCPT '+TosTr);
        If fLogDebug  Then
          WriteDebugMsg('RCPT says 501 syntax error ' +ToStr);
      End;
    End;
  End;                            { DoCommandRCPT }

  Procedure TWinShoeSMTPServer.DoCommandDATA(Thread: TWinshoeServerThread;
                                              SessionMsg: tSMTPMsg;Var Handled : Boolean);
  Var
    RcvdStr : String;
    Res : Integer;
  Begin                           { DoCommandData }
    If Assigned(OnCommandDATA) Then OnCommandDATA(Thread,SessionMsg, Handled);
    If Not Handled Then Begin
      With Thread.Connection Do Begin
        WriteLn('354 Start Mail Input; End with <CRLF>.<CRLF>');
        If fLogDebug  Then
          WriteDebugMsg('DATA says 354 Start Mail Input; End with <CRLF>.<CRLF>' );
        // (!!0.01} Modification to handle  extra Period and blank line bug
        // Modification by Roman Evstyunichev... thanks.
        repeat
          RcvdStr := ReadLn;
          If fLogDebug  Then
            WriteDebugMsg('DATA says '+ RcvdStr );
          if Length(RcvdStr) > 0 then begin
            if RcvdStr[1] = '.' then Begin
              if Length(RcvdStr) > 1 then
                Delete(RcvdStr, 1, 1)  // Delete additional period
              else begin
                SessionMsg.fData.Delete(SessionMsg.fData.Count - 1);  //Delete previous empty line
                Break;  // End of message
              end;
            end;
          end;
          SessionMsg.fData.add(RcvdStr);
        until False;
        Res :=  WriteMailToUserDirOrForward(Thread, SessionMsg);
        Case Res Of
          0 : Begin
                WriteLn('250 OK');
                If fLogDebug  Then
                  WriteDebugMsg('DATA says 250 OK');
              End;
          1 : Begin
                 WriteLn('451 -ERR Requested Action Aborted. System Disk Error Write to Local MailBox Failed');
                 If fLogDebug Then
                   WriteDebugMsg('DATA says 451 -ERR Disk Error Write to Local Mail Box Failed');
              End;
           2 : Begin
                 WriteLn('451 -ERR Requested Action Aborted. System Disk Error Write Mail Forwarding Failed');
                 If fLogDebug Then
                   WriteDebugMsg('DATA says 451 -ERR Disk Error Write to Pickup Dir Failed');
               End;
          Else Begin
            WriteLn('451 -ERR Requested Action Aborted. Local Error In Processing');
            If fLogDebug Then
              WriteDebugMsg('DATA says 451 -ERR Write to Pickup Dir Failed Res is '+InttoStr(Res));
          End;
        End;
      End;
    End;
  End;                            { DoCommandData }

  Procedure TWinShoeSMTPServer.DoCommandSEND(Thread: TWinshoeServerThread;FromStr: String;
                                              SessionMsg: tSMTPMsg; Var Handled : Boolean);
  Begin                           { DoCommandSEND }
    If Assigned(OnCommandSEND) Then
      OnCommandSEND(Thread, FromStr,SessionMsg, Handled);
    If Not Handled Then Begin
      Thread.Connection.WriteLn('502 SEND Is Not Implemented');
      If fLogDebug  Then
        WriteDebugMsg('SEND says 502 Not yet Implemented');
    End;
  End;                            { DoCommandSEND }

  Procedure TWinShoeSMTPServer.DoCommandSOML(Thread: TWinshoeServerThread; FromStr: String;
                                              SessionMsg: tSMTPMsg; Var Handled : Boolean);
  Begin                           { DoCommandSOML }
    If Assigned(OnCommandSOML) Then OnCommandSOML(Thread, FromStr,SessionMsg, Handled);
    If Not Handled Then Begin
      Thread.Connection.WriteLn('502 SOML Is Not Implemented');
      If fLogDebug  Then
        WriteDebugMsg('SOML says 502 Not yet Implemented');
    End;
  End;                            { DoCommandSOML }

  Procedure TWinShoeSMTPServer.DoCommandSAML(Thread: TWinshoeServerThread; FromStr: String;
                                              SessionMsg: tSMTPMsg;Var Handled : Boolean);
  Begin                           { DoCommandSAML }
    If Assigned(OnCommandSAML) Then OnCommandSAML(Thread,FromStr,SessionMsg, Handled);
    If Not Handled Then Begin
      Thread.Connection.WriteLn('502 SAML Is Not Implemented');
      If fLogDebug  Then
        WriteDebugMsg('SAML says 502 Not yet Implemented');
    End;
  End;                            { DoCommandSAML }

  Procedure TWinShoeSMTPServer.DoCommandRSET(Thread: TWinshoeServerThread;
                                              SessionMsg: tSMTPMsg; Var Handled : Boolean);
  Begin                           { DoCommandRSET }
    If Assigned(OnCommandRSET) Then OnCommandRSET(Thread, SessionMsg, Handled);
    If Not Handled Then Begin
      SessionMsg.Clear;
      Thread.Connection.WriteLn('250 OK Reset Completed');
      If fLogDebug Then
        WriteDebugMsg('RSET says 250 OK');
    End;
  End;                            { DoCommandRSET }

  Procedure TWinShoeSMTPServer.DoCommandVRFY(Thread: TWinshoeServerThread;
                                              aName: String; Var Handled : Boolean);
  Begin                           { DoCommandVRFY }
    If Assigned(OnCommandVRFY) Then
      OnCommandVRFY(Thread,aName, Handled);
    If Not Handled Then Begin
      If DirectoryExists(FixDirBackSlash(FMailRootDir)+'MailBoxes'+'\'+aName) Then Begin
        Thread.Connection.WriteLn('250 aName <'+aname+'@'+LocalName +'> is a valid Client');
        If fLogDebug Then
          WriteDebugMsg('VRFY says 250 '+aname +' is valid client');
      End
      Else Begin
        Thread.Connection.WriteLn('550 '+aname+' does not match any client');
        If fLogDebug Then
          WriteDebugMsg('VRFY says 550 '+aname +' is NOT valid client');
      End;
    End;
  End;                            { DoCommandVRFY }

  Procedure TWinShoeSMTPServer.DoCommandEXPN(Thread: TWinshoeServerThread;
                                              aListName: String; Var Handled : Boolean);
  Begin                           { DoCommandEXPN }
   If Assigned(OnCommandEXPN) Then
     OnCommandEXPN(Thread,aListName, Handled);
    If Not Handled Then Begin
      Thread.Connection.WriteLn('550 EXPN Access Denied to You');
      If fLogDebug  Then
        WriteDebugMsg('EXPN says 550 Access Denied to you');
    End;
  End;                            { DoCommandEXPN }

  Procedure TWinShoeSMTPServer.DoCommandHELP(Thread: TWinshoeServerThread;
                                              aCommand: String; Var Handled : Boolean);
  Begin                           { DoCommandHELP }
    If Assigned(OnCommandHELP) Then
      OnCommandHELP(Thread,aCommand, Handled);
    If Not Handled Then Begin
      Thread.Connection.WriteLn('502 HELP Is Not Implemented');
      If fLogDebug  Then
        WriteDebugMsg('HELP says 502 Not yet Implemented');
    End;
  End;                            { DoCommandHELP }

  Procedure TWinShoeSMTPServer.DoCommandNOOP(Thread: TWinshoeServerThread;
                                              Var Handled : Boolean);
  Begin                           { DoCommandNOOP }
    If Assigned(OnCommandNOOP) Then
      OnCommandNOOP(Thread, Handled);
    If Not Handled Then Begin
      Thread.Connection.WriteLn('250 NOOP Performed');
      If fLogDebug  Then
        WriteDebugMsg('HELP says 250 NOOP Performed');
    End;
  End;                            { DoCommandNOOP }

  Procedure TWinShoeSMTPServer.DoCommandQUIT(Thread: TWinshoeServerThread;
                                              Var Handled : Boolean);
  Begin                          { DoCommandQUIT }
    Try
      If Assigned(OnCommandQUIT) Then
        OnCommandQUIT(Thread, Handled);
      If Not Handled Then Begin
        Thread.Connection.WriteLn('221 '+LocalName
                                +' Service Closing Transmission Channel');
       If fLogDebug Then
         WriteDebugMsg('QUIT says 221 '+LocalName+' Service Closing Xmission Channel');
      End;
    Finally
      Thread.Connection.Disconnect;
    End;
  End;                            { DoCommandQUIT }

  Procedure TWinShoeSMTPServer.DoCommandTURN(Thread: TWinshoeServerThread;
                                              SessionMsg: tSMTPMsg;Var Handled : Boolean);
  Begin                           { DoCommandTURN }
    If Assigned(OnCommandTURN) Then
      OnCommandTURN(Thread, SessionMsg, Handled);
    If Not Handled Then Begin
     Thread.Connection.WriteLn('502 TURN not implemented');
     If fLogDebug Then
       WriteDebugMsg('TURN Says 502 Not Implemented');
    End;
  End;                            { DoCommandTURN }

  Procedure TWinShoeSMTPServer.DoCommandError(Thread: TWinshoeServerThread;
                                               ArgStr: String; Var Handled : Boolean);
  Begin                           { DoCommandError }
    If Assigned(OnCommandError) Then
      OnCommandError(Thread, ArgStr, Handled);
    If Not Handled Then Begin
      Thread.Connection.WriteLn('500 Syntax Error, Command Unrecognized '+ArgStr);
      If fLogDebug Then
        WriteDebugMsg('Command Error says 500 Syntax error, command Unrecognized '+ArgStr);
    End;
  End;                            { DoCommandError }


End.
