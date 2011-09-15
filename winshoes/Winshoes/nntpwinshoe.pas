unit NNTPWinshoe;

interface

uses
	Classes,
	ServerWinshoe, SystemWinshoe,
	Winshoes, WinshoeMessage, Windows;

{History of Major changes
2000.01.13 MTL - Moved to new Palette Scheme (Winshoes Clients)
1999.08.01 Kudzu
  -Fixed a bug with SetArticle
1999.05.02:
  -Reformatted to include parameters in method implementation
  -Replace Header with Head in GetHeader
1999.05.02:
  -Major Changes
1999.03.14:
  -Changed GetMessage to a function - now returns a Boolean and will
   not raise exepction if message not found
  -Rearranged things - changed some properties
  -Added support for HEAD command
1996.06.13:
  -Added MsgNo property
1996.05.22:
  -GetMessage has changed - Now can accept message ID's
}

{
 AHeid
 1999.08.19
 -Added support for NewGroups and NewNews command's
}

{
  1999.10.23 Mark Holmes
  - Removed the published property ModeReader and replaced it with Mode
  - Please note *** Delphi 3/CB3 *** and below will not be able to support the
    NNTP maximum "article number" which is 4,294,967,295.
  - Changed lLow,lHigh from LongInt to DWORD in TEventNewsGrouplist
    This satisfies the NNTP specification for article numbers.
  - Changed all other article number related fields,properties, etc to DWORD.
    as appropriate
  - Changed the StrToInt calls to StrToCard for all StrToInt dealing with Article
    numbers.
  - Added a check for a response of 450 in the Command routine. Some servers
    may use this in place of 480
  - Added new methods: SendIHAVE, SendCheck, SendTakeThis
  - Added new events: OnSendCheck, OnSendIHAVE, OnSendTakeThis
  - Added function StrToCard(const S: string): DWORD; to support the change
    from integer to DWORD;
  - Added new published property called DoSetMode. DoSetmode can either be true or
    false. If true then the appropriate mode command will be called based upon
    the value of Mode. you can read the result in ModalResult

  1999.12.29 Mark Holmes
  - Added GetOverviewFMT
  - Added SendXHDR
  - Added SendXOVER
}
type

  // Most users of this component should use "mtReader"
  TModeType =(mtStream, mtIHAVE, mtReader);

  TConnectionResult = (crCanPost, crNoPost, crAuthRequired, crTempUnavailable, crRefused);
  TModeSetResult = (mrCanStream, mrNoStream, mrCanIHAVE, mrNoIHAVE, mrCanPost, mrNoPost);

  TEventStreaming = procedure (const MesgID: string; var Accepted: Boolean)of object;
  TNewsTransportEvent = procedure (pMsg: TStringList) of object;
  TEventNewsgroupList = procedure(const sNewsgroup: string; const lLow, lHigh: DWORD;
		const sType: string; var CanContinue: Boolean) of object;

  TEventNewNewsList = procedure(const sMsgID: string; var CanContinue: Boolean) of object;

  TWinshoeNNTP = class(TWinshoeMessageClient)
  private
    FlMsgHigh,
    FlMsgLow,
    FlMsgNo: DWORD;
    FsMsgID: string;
    FlMsgCount : DWORD;
    FOnNewsgroupList,
    FOnNewGroupsList: TEventNewsgroupList;
    FOnNewNewsList: TEventNewNewsList;
    fOnSendCheck: TNewsTransportEvent;
    fOnSendTakethis: TNewsTransportEvent;
    fOnDisconnect: TServerEvent;
    fModeType: TModeType;
    fConectionResult: TConnectionResult;
    fModeResult: TModeSetResult;
    fOnConnect: TServerEvent;
    fOnSendIHAVE: TNewsTransportEvent;
    FbSetMode: Boolean;
    procedure SetModeType(const Value: TModeType);
    procedure setConnectionResult(const Value: TConnectionResult);
    procedure SetModeResult(const Value: TModeSetResult);
  protected
    function Get(const psCmd: string; const plMsgNo: DWORD; const psMsgID: string;
     pMsg: TWinshoeMessage): Boolean;
    function SetArticle(const psCmd: string; const plMsgNo: DWORD; const psMsgID: string): Boolean;

    procedure ProcessGroupList(const psCmd: string; const piResponse: integer;
     const ppListEvent: TEventNewsgroupList);
  public

    constructor Create(AOwner: TComponent); override;
    function Command(const sOut: string; const nResponse: SmallInt; const nLevel: Byte;
     const sMsg: string) : SmallInt; override;
    procedure Connect; override;
    procedure Disconnect; override;
    function GetArticle(const plMsgNo: DWORD; const psMsgID: string;
                              pMsg: TWinshoeMessage) : Boolean;
    function GetBody(const plMsgNo: DWORD; const psMsgID: string;
                           pMsg: TWinshoeMessage) : Boolean;
    function GetHeader(const plMsgNo: DWORD; const psMsgID: string;
                             pMsg: TWinshoeMessage) : Boolean;
    procedure GetNewsgroupList;
    procedure GetNewGroupsList(const pdDate: TDateTime; const pbGMT: boolean;
     const psDistributions: string);
    procedure GetNewNewsList(const psNewsgroups: string; const pdDate: TDateTime;
     const pbGMT: boolean; psDistributions: string);
    function Next: Boolean;
    function Previous: Boolean;
    procedure Send(pMsg: TWinshoeMessage); override;
    function SelectArticle(const plMsgNo: DWORD): Boolean;
    function SelectGroup(const sGroup: string):Boolean;
    procedure SendIHAVE(slMsg: TStringList);
    procedure SendCheck(slMsgID: TStringList; var Responses: TStringList);
    function SendTakeThis(slMsg: TStringList) : String;
    procedure SendXHDR(const Header: string;
      const Parm: String; var Response: TStringList );
    procedure SendXOVER(const Parm : String; var Response: TStringList);
    procedure GetOverviewFMT(var Response: TStringList);
    property MsgID: string read fsMsgID;
    property MsgNo: DWORD read FlMsgNo;
    property MsgHigh: DWORD read FlMsgHigh;
    property MsgLow: DWORD read FlMsgLow;
    property GreetingResult: TConnectionResult read fConectionResult
                                               write setConnectionResult;
    property ModeResult: TModeSetResult read fModeResult write SetModeResult;
    property MsgCount: DWORD read flMsgCount write flMsgCount;
  published
    property Mode : TModeType read fModeType write SetModeType default mtReader;
    property Password;
    property UserID;
    property SetMode : Boolean read FbSetMode write FbSetMode default True;
    property OnDisconnect :TserverEvent read fOnDisconnect write fOnDisconnect;
    property OnConnect: TServerEvent read fOnConnect write fOnConnect;
    property OnSendCheck :TNewsTransportEvent read fOnSendCheck
                                              write fOnSendCheck;
    property OnSendIHAVE: TNewsTransportEvent read fOnSendIHAVE
                                              write fOnSendIHAVE;
    property OnSendTakeThis: TNewsTransportEvent read fOnSendTakethis
                                                 write fOnSendTakethis;
    property OnNewsgroupList: TEventNewsgroupList read FOnNewsgroupList
                                                  write FOnNewsgroupList;
    property OnNewGroupsList: TEventNewsGroupList read FOnNewGroupsList
                                                  write FOnNewGroupsList;
    property OnNewNewsList: TEventNewNewsList read FOnNewNewsList
                                              write FOnNewNewsList;

  end;

procedure Register;

implementation

uses
  GlobalWinshoe
	, StringsWinshoe, SysUtils;

constructor TWinshoeNNTP.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
	Mode := mtReader;
	Port := WSPORT_NNTP;
        SetMode := True;
end;

function TWinshoeNNTP.Command(const sOut: string; const nResponse: SmallInt;
 const nLevel: Byte; const sMsg: string) : SmallInt;
begin
  Result := inherited Command(sOut, -1, nLevel, sMsg);

  if (Result = 480) or (Result = 450) then begin
    inherited Command('AuthInfo User ' + UserID, 381, 0, 'User ID Accepted');
    inherited Command('AuthInfo Pass ' + Password, 281, 0, 'Password Accepted');
    Result := inherited Command(sOut, nResponse, nLevel, sMsg);
  end else if (nResponse > -1) and (Result <> nResponse) then
		raise EWinshoeResponseError.Create(CommandResult);
end;

procedure TWinshoeNNTP.Connect;
begin
  inherited Connect;
  try
    FsCommandResult := ReadLn;
    // Here lets check to see what condition we are in after being greeted by
    // the server. The application utilizing NNTPWinshoe should check the value
    // of GreetingResult to determine if further action is warranted.


    case StrToInt(Copy(FsCommandResult, 1, 3)) of
      200 : GreetingResult := crCanPost;
      201 : GreetingResult := crNoPost;
      400 : GreetingResult := crTempUnavailable;
      // This should never happen because the server should immediately close
      // the connection but just in case ....
      502 : begin
              GreetingResult := crRefused;
              SRaise(EWinshoeConnectRefused);
              Disconnect;
            end;
    end;
    // here we call Setmode on the value stored in mode to make sure we can
    // use the mode we have selected
    {if DoSetMode then}
      case mode of
        mtStream : begin
                     Command('mode stream',-1,0,'');
                     if ResultNo <> 203 then
                       ModeResult := mrNoStream
                     else
                       ModeResult := mrCanStream;
                   end;
        mtReader : begin
                     // We should get the same info we got in the greeting
                     // result but we set mode to reader anyway since the
                     // server may want to do some internal reconfiguration
                     // if it knows that a reader has connected
                     Command('mode reader',-1,0,'');
                     if  ResultNo <> 200 then
                       ModeResult := mrNoPost
                     else
                       ModeResult := mrCanPost;
                   end;

      end;
  finally
  end;
end;

procedure TWinshoeNNTP.Disconnect;
begin
  try
    if Connected then
      WriteLn('Quit');
  finally
    inherited Disconnect;
  end;
end;

{ This procedure gets the overview format as suported by the server }
procedure TWinshoeNNTP.GetOverviewFMT(var Response: TStringList);
var
  s1 : String;
begin
  DoStatus('Getting Overview data ');
  try
    BeginWork(-1);
    try
      Command('list overview.fmt ', 215, 1, 'Overview Format follows');
      s1 := ReadLn;
      while (s1 <> '.') do begin
        Response.Add(s1);
        s1 := ReadLn;
      end;
      finally
        EndWork;
      end;
    except
      on E: Exception do DoStatus(E.Message);
    end;
end;


{ Send the XOVER Command.  XOVER [Range]
  Range can be of the form: Article Number i.e. 1
                            Article Number followed by a dash
                            Article Number followed by a dash and aother number
  Remember to select a group first and to issue a GetOverviewFMT so that you
  can interpret the information sent by the server corectly. }
procedure TWinshoeNNTP.SendXOVER(const Parm : String; var Response: TStringList);
var
  s1 : String;
begin
  DoStatus('Getting Overview data ');
  try
    BeginWork(-1);
    try
      Command('xover ' + Parm, 224, 1, 'XOver Format follows');
      s1 := ReadLn;
      while (s1 <> '.') do begin
        Response.Add(s1);
        s1 := ReadLn;
      end;
      finally
        EndWork;
      end;
    except
      on E: Exception do DoStatus(E.Message);
    end;
end;

{ Send the XHDR Command.  XHDR Header (Range | Message-ID)
  Range can be of the form: Article Number i.e. 1
                            Article Number followed by a dash
                            Article Number followed by a dash and aother number
  Parm is either the Range or the MessageID of the articles you want. They
  are Mutually Exclusive}
procedure TwinshoeNNTP.SendXHDR(const Header: string;
  const Parm: String; var Response: TStringList );
var
  s1 : String;
begin
  { This method will send the XHDR command.
  The programmer is responsible for choosing the correct header. Headers
  that should always work as per RFC 1036 are:

      From
      Date
      Newsgroups
      Subject
      Message-ID
      Path

    These Headers may work... They are optional per RFC1036 and new headers can
    be added at any time as server implementation changes

      Reply-To
      Sender
      Followup-To
      Expires
      References
      Control
      Distribution
      Organization
      Keywords
      Summary
      Approved
      Lines
      Xref
    }
    try
      BeginWork(-1);
      try
        Command('XHDR ' + Header + ' ' + Parm, 221, 0, 'Getting Headers');
        s1 := ReadLn;
        while (s1 <> '.') do begin
          Response.Add(s1);
          s1 := ReadLn;
        end;
      finally
        EndWork;
      end;
    except
      on E: Exception do DoStatus(E.Message);
    end;
end;

function TWinshoeNNTP.SelectGroup(const sGroup: string) : Boolean;
var
  s1: string;
begin
  DoStatus('Selecting ' + sGroup);
  Command('Group ' + sGroup, 211, 1, 'Selected');
  if ResultNo <> 211 then begin
    Result := False;
    Exit;
  end else
    Result := True;

  s1 := Copy(FsCommandResult, 5, Maxint);
  FlMsgCount := StrToCard(Fetch(s1, ' '));
  FlMsgLow := StrToCard(Fetch(s1, ' '));
  FlMsgHigh := StrToCard(Fetch(s1, ' '));
end;

function TWinshoeNNTP.Get(const psCmd: string; const plMsgNo: DWORD; const psMsgID: string;
 pMsg: TWinshoeMessage): Boolean;
begin
  Result := SetArticle(psCmd, plMsgNo, psMsgID);

  if Result then begin
    pMsg.Clear;
    // Catch Header
    if ResultNo in [220, 221] then begin
      ReceiveHeader(pMsg, siif(ResultNo = 220, '', '.'));
    end;
    // Catch Body
    if ResultNo in [220, 222] then
      ReceiveBody(pMsg);
  end;
end;


{ This method will send messages via the IHAVE command.
The IHAVE command first sends the message ID and waits for a response from the
server prior to sending the header and body. This command is of no practical
use for NNTP client readers as readers are generally denied the privelege
to execute the IHAVE command. this is a news transport command. So use this
when you are implementing a NNTP server send unit }

procedure TWinshoeNNTP.SendIHAVE(slMsg: TStringList);
var
  i     : Integer;
  MsgID : String;
  Temp  : String;
begin
  // check for a predefined method handler if not execute the default
  if not Assigned(FOnSendIHAVE) then begin
    // Since we are merely forwarding messages we have already received
    // it is assumed that the required header fields and body are already in place
    // If you don't wish to make this assumption utilize the onSendIHAVE event
    // and do your custom verification.

    // We need to get the message ID from the stringlist because it's required
    // that we send it s part of the IHAVE command
    for i := 0 to Pred(slMsg.Count) do
      if Pos('Message-ID',slMsg.Strings[i]) > 0 then begin
        MsgID := slMsg.Strings[i];
        Temp := Fetch(MsgID,':');
        Break;
      end;
    DoStatus('Transferring Message with IHAVE: ' + MsgID + 'to: '+ Host);

    Command('IHAVE ' + MsgID,335, 0, '');
    // Now we send the entire article both header and body
    for i := 0 to Pred(slMsg.Count) do
        WriteLn(slMsg[i]);
    WriteLn('.');
    Temp := Readln;
  end;
end;

{ This method is simple we are going to send a check command. The check command
sends a message ID to the server and you do not have to wait for a response
from the server before sending the next check command. you should keep track of
the results though since this will dictate which articles you will actually
send the server via the Takethis command. It is not a requirement to send the
Check command prior to Takethis}

procedure TWinshoeNNTP.SendCheck(slMsgID: TStringList;
  var Responses: TStringList);
var
  i        : Integer;
begin
  // a string list rather than a simple string is used because you should be
  // sending more than one message id at a time. It's too expensive to make a
  // procedure call 20 times as opposed to doing a little work beforehand to fill
  // the sringlist with message-ids. For example you could store a list of
  // message id's in a file and send them later
  // just a thought... You could also write out the values in Responses to file
  // send send those messages later as well since they are the messages that
  // the peer currently would accept but no guarantee it will accept them later.
  if not Assigned(FOnSendCheck) then begin
    for i := 0 to Pred(slMsgID.Count) do
      Writeln('CHECK '+ slMsgID.Strings[i]);
    for i := 0 to Pred(slMsgID.Count) do begin
      // build a list of message id's to send
      if assigned(Responses) then
        Responses.Add(ReadLn)
      else
        raise Exception.Create('Stringlist not initialized!');
    end;
  end;
end;

{ This method is in support of so called streaming NNTP. It works like IHAVE
except you need not wait for a response from the server before you send the
next article. You should go over Responses later to determine how many articles
were actually accepted. you then can adjust the max number of takethis commands
to send t any one time to a particular site}

function TWinshoeNNTP.SendTakeThis(slMsg: TStringList) : String;
var
  i        : Integer;
  MsgID    : String;
  Temp     : String;
begin
  if not Assigned(FOnSendTakeThis) then begin
    // Since we are merely forwarding messages we have already received
    // it is assumed that the required header fields and body are already in place
    // If you don't wish to make this assumption utilize the onSendITakethis event
    // and do your custom verification.

    // we check the value of moderesult if setmode is true. If the condition is
    // satisfied then choose the IHAVE route since we probably can do that
    // quit because we can't send via takethis anyway

    if (Setmode) and (ModeResult = mrNoStream) then begin
      Dostatus('Swiching mode from Streaming to IHAVE: Streaming not supported');
      Mode := mtIHAVE;
      // call the IHAVE routine. all subsequent calls to takethis will fail but
      // go out via IHAVE
      SendIHAVE(slMsg);
      Exit;
    end;
    // We need to get the message ID from the stringlist because it's required
    // that we send it s part of the TAKETHIS command

    for i := 0 to Pred(slMsg.Count) do
      if Pos('Message-ID',slMsg.Strings[i]) > 0 then begin
        MsgID := slMsg.Strings[i];
        Temp := Fetch(MsgID,':');
        Break;
      end;
    DoStatus('Transferring Message with TAKETHIS: ' + MsgID + 'to: '+ Host);
    try
      Writeln('TAKETHIS ' + MsgID);
      for i := 0 to Pred(slMsg.Count) do
        WriteLn(slMsg[i]);
      WriteLn('.');
    finally
      Result := Readln;
    end;
  end;
end;

procedure TWinshoeNNTP.Send(pMsg: TWinshoeMessage);
begin
  DoStatus('Posting Message: ' + pMsg.Too.Text + ' : ' + pMsg.Subject);

  Command('Post', 340, 0, '');
  //Header
  with pMsg.Headers do begin
    Values['Lines'] := IntToStr(pMsg.Text.Count);
    Values['X-Library'] := 'WinShoes ' + Version;
    Values['X-NewsReader'] := XProgram;
  end;

  pMsg.SetDynamicHeaders;
  WriteHeaders(pMsg.Headers);

  inherited;

  DoStatus('Waiting for acceptance');
  Command('.', 240, 2, 'Message accepted');
end;


procedure TWinshoeNNTP.ProcessGroupList(const psCmd: string; const piResponse: integer;
 const ppListEvent: TEventNewsgroupList);
var
  s1, sNewsgroup: string;
  lLo, lHi      : DWORD;
  CanContinue   : Boolean;
begin
  try
    BeginWork(-1);
    try
      Command(psCmd, piResponse, 1, 'Retrieving Newsgroup List');
      s1 := ReadLn;
      CanContinue := True;
      while (s1 <> '.') and CanContinue do begin
        sNewsgroup := Fetch(s1, ' ');
        lHi := StrToCard(Fetch(s1, ' '));
        lLo := StrToCard(Fetch(s1, ' '));
        ppListEvent(sNewsgroup, lLo, lHi, s1, CanContinue);
        s1 := ReadLn;
      end;
    finally
      EndWork;
    end;
  except
    on E: Exception do DoStatus(E.Message);
  end;
end;

procedure TWinshoeNNTP.GetNewsgroupList;
begin
  if not Assigned(FOnNewsgroupList) then
    raise Exception.Create('No OnNewsgroupList event has been defined.');

  ProcessGroupList('List', 215, FOnNewsgroupList);
end;

procedure TWinshoeNNTP.GetNewGroupsList(const pdDate: TDateTime; const pbGMT: boolean;
 const psDistributions: string);
var
  sDist, sDateTime: string;
begin
  if not Assigned(FOnNewGroupsList) then
    raise Exception.Create('No OnNewGroupsList event has been defined.');

  sDateTime:= FormatDateTime('yymmdd hhmmss', pdDate);

  if pbGMT then
    sDateTime:= sDateTime + ' GMT';

  if psDistributions <> '' then
    sDist:= ' <' + psDistributions + '>';

  ProcessGroupList('Newgroups ' + sDateTime + sDist, 231, FOnNewGroupsList);
end;

procedure TWinshoeNNTP.GetNewNewsList(const psNewsgroups: string;
const pdDate: TDateTime; const pbGMT: boolean; psDistributions: string);
var
  sDist, sDateTime: string;
  s1: string;
  CanContinue: Boolean;
begin
  if not Assigned(FOnNewNewsList) then
    raise Exception.Create('No OnNewNewsList event has been defined.');

  sDateTime:= FormatDateTime('yymmdd hhmmss', pdDate);

  if pbGMT then
    sDateTime:= sDateTime + ' GMT';

  if psDistributions <> '' then
    sDist:= ' <' + psDistributions + '>';

    try
      BeginWork(-1);
      try
        Command('Newnews ' + psNewsgroups + ' ' + sDateTime + sDist, 230, 1, 'Retrieving New Articles List');
        s1 := ReadLn;
        CanContinue := True;
        while (s1 <> '.') and CanContinue do begin
          FOnNewNewsList(s1, CanContinue);
          s1 := ReadLn;
        end;
      finally
        EndWork;
    end;
	except
    on E: Exception do DoStatus(E.Message);
  end;
end;

function TWinshoeNNTP.GetArticle(const plMsgNo: DWORD; const psMsgID: string;
 pMsg: TWinshoeMessage) : Boolean;
begin
  Result := Get('Article', plMsgNo, psMsgID, pMsg);
end;

function TWinshoeNNTP.GetBody(const plMsgNo: DWORD; const psMsgID: string;
 pMsg: TWinshoeMessage) : Boolean;
begin
  Result := Get('Body', plMsgNo, psMsgID, pMsg);
end;

function TWinshoeNNTP.GetHeader(const plMsgNo: DWORD; const psMsgID: string;
 pMsg: TWinshoeMessage) : Boolean;
begin
  Result := Get('Head', plMsgNo, psMsgID, pMsg);
end;

function TWinshoeNNTP.Next: Boolean;
begin
  Result := SetArticle('Next', 0, '');
end;

function TWinshoeNNTP.Previous: Boolean;
begin
  Result := SetArticle('Last', 0, '');
end;

function TWinshoeNNTP.SelectArticle(const plMsgNo: DWORD): Boolean;
begin
  Result := SetArticle('Stat', plMsgNo, '');
end;

function TWinshoeNNTP.SetArticle(const psCmd: string; const plMsgNo: DWORD;
 const psMsgID: string) : Boolean;
var
  s: string;
begin
  if plMsgNo >= 1 then
    Command(psCmd + ' ' + IntToStr(plMsgNo), -1,	0, '')
  else if psMsgID <> '' then
    Command(psCmd + ' <' + psMsgID + '>', -1,	0, '')
  else // Retrieve / Set currently selected atricle
    Command(psCmd, -1,	0, '');

  if ResultNo in [220, 221, 222, 223] then begin
    if psMsgID = '' then begin
      s := CommandResult;
      Fetch(s, ' ');
      flMsgNo := StrToCard(Fetch(s, ' '));
      fsMsgID := s;
    end;
    Result := True;
  end else if (ResultNo = 421) or (ResultNo = 422)
   or (ResultNo = 423) or (ResultNo = 430) then begin
    // 421 no next article in this group
    // 422 no previous article in this group
    // 423 no such article number in this group
    // 430 no such article found
    Result := False;
  end else begin
		raise EWinshoeResponseError.Create(CommandResult);
  end;
end;

procedure TWinshoeNNTP.SetModeType(const Value: TModeType);
begin
  fModeType := Value;
end;

procedure TWinshoeNNTP.setConnectionResult(const Value: TConnectionResult);
begin
  fConectionResult := Value;
end;

procedure TWinshoeNNTP.SetModeResult(const Value: TModeSetResult);
begin
  fModeResult := Value;
end;

procedure Register;
begin
  RegisterComponents('Winshoes Clients', [TWinshoeNNTP]);
end;


end.
