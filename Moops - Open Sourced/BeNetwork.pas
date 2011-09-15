unit BeNetwork;

interface

uses
  Windows, Messages, Forms, Classes, WinSock, ScktComp, Common, SysUtils,
  BeChatView, Winshoes, AskPWFrm;

const
  NetworkDebug: Boolean = False;
  WM_NETWORKDATA = WM_USER + 401;

type
  ENoPass = class(EWinshoeException);

  TSocketState = (stDisconnected,stConnecting,stConnected);
  TncEventType = (ncRead,ncConnecting,ncConnected,ncLoginSent,ncDisconnected,ncError,ncDebug);

  TAuthInfo = record
    User:   string;
    Pass:   string;
    AskPW:  Boolean;
    GotPW:  Boolean;
  end;

  TConnectionMethod = (cmDirect, cmSocks4, cmSocks4A, cmSocks5, cmSimple, cmGlobal);
  TProxySettings = record
    Method:   TConnectionMethod;
    Server:   string;
    Port:     Integer;
    Cmd:      string;
    Auth:     Boolean;
    AuthInfo: TAuthInfo;
  end;

  PNetworkEvent = ^TNetworkEvent;
  TNetworkEvent = record
    EventType: TncEventType;
    EventMsg:  string;
    ErrorCode: Integer; // optional
  end;

  TNetClient = class(TThread)
  private
    fOwner: TComponent;
    fClient: TWinshoeClient;
    fSocketState: TSocketState;
    fBuffer: string;
    fHost: string;
    fPort: Integer;
    fLoginCmd: string;
    fAutoLogin: Boolean;
    fEventList: TThreadList;
    fWindowHandle: Hwnd;
    procedure DoEvent(EventType: TncEventType; const EventMsg: string; ErrorCode: Integer);
  protected
    procedure Execute; override;
  public
    Proxy: TProxySettings;
    AuthInfo: TAuthInfo;
    SessionDescr: string;
    TotalSent, TotalRecv: Integer;

    constructor Create(aOwner: TComponent; aWindowHandle: Hwnd);
    destructor Destroy; override;

    procedure AskPWs;
    procedure Connect;
    procedure ReConnect;
    procedure Disconnect;
    function  CanConnect: Boolean;
    function  Connected: Boolean;
    procedure SendText(const S: string);
    function  GetEvent(var Event: TNetworkEvent): Boolean;
    function  IsConnection(const IP: string; LPort, RPort: Integer; var Msg: string): Boolean;

    property State: TSocketState read fSocketState;
  published
    property AutoLogin: Boolean read fAutoLogin write fAutoLogin;
    property LoginCmd: string read fLoginCmd write fLoginCmd;

    //property User: string read fUser write fUser;
    //property Pass: string read fPass write fPass;

    property Host: string read fHost write fHost;
    property Port: Integer read fPort write fPort;
  end;

var
  GlobalProxy: TProxySettings;

procedure NetworkTraffic(Upload: Boolean; WorldNr: Integer);

implementation

uses
  MainFrm;

procedure NetworkTraffic(Upload: Boolean; WorldNr: Integer);
begin
  MainForm.NetworkTraffic(Upload,WorldNr);
end;

constructor TNetClient.Create(aOwner: TComponent; aWindowHandle: Hwnd);
begin
  inherited Create(True);
  fOwner:=aOwner;
  fBuffer:='';
  fSocketState:=stDisconnected;
  fClient:=TWinshoeClient.Create(fOwner);
  fClient.EOLTerminator:=#10;
  fSocketState:=stDisconnected;
  fHost:='';
  fPort:=0;
  AuthInfo.User:='';
  AuthInfo.Pass:='';
  AuthInfo.AskPW:=False;
  AuthInfo.GotPW:=False;
  fLoginCmd:='';
  fAutoLogin:=True;
  Priority:=tpHigher;
  fEventList:=TThreadList.Create;
  fWindowHandle:=aWindowHandle;
  Proxy.AuthInfo.User:='';
  Proxy.AuthInfo.Pass:='';
  Proxy.AuthInfo.AskPW:=False;
  Proxy.AuthInfo.GotPW:=False;
  SessionDescr:='';
  TotalSent:=0; TotalRecv:=0;
end;

function TNetClient.IsConnection(const IP: string; LPort, RPort: Integer; var Msg: string): Boolean;
begin
  Result:=Connected and (fClient.PeerAddress=IP) and (fClient.Port=RPort);
  if Connected then Msg:='Connected, ' else Msg:='Not connected, ';
  Msg:=Msg+fClient.PeerAddress+':'+IP+' '+IntToStr(fClient.Port)+':'+IntToStr(RPort);
  //MainForm.StatusPage.AddToLog('Ident-debug: '+IP+':'+fClient.PeerAddress+' '+IntToStr(RPort)+':'+IntToStr(fClient.Port));
{ TODO -oMartin -cIdent : LPort sjekken in ident }
end;

destructor TNetClient.Destroy;
var
  Event: TNetworkEvent;
begin
  Disconnect;
  while not Suspended do Application.ProcessMessages;
  fClient.Free;
  while GetEvent(Event) do ;
  fEventList.Free;
  inherited Destroy;
end;

procedure TNetClient.DoEvent(EventType: TncEventType; const EventMsg: string; ErrorCode: Integer);
var
  Event: ^TNetworkEvent;
begin
  New(Event);
  Event.EventType:=EventType;
  Event.EventMsg:=EventMsg;
  Event.ErrorCode:=ErrorCode;
  if EventType=ncRead then Inc(TotalRecv,Length(EventMsg)+2);
  fEventList.Add(Event);
  PostMessage(fWindowHandle,WM_NETWORKDATA,0,0);
end;

procedure TNetClient.Execute;
var
  S: string;
  Prox: TProxySettings;
begin
  while not Terminated do
  begin
    // Resume is called by another thread

    (*// First clear eventlist and socket to remove crap from previous sessions
    L:=fEventList.LockList;
    try
      while L.Count>0 do
      begin
        Dispose(PNetworkEvent(L[0]));
        L.Delete(0);
      end;
    finally
      fEventList.UnlockList;
    end;*)

    try
      AskPWs;
      if Proxy.Method=cmGlobal then
        Prox:=GlobalProxy
      else
        Prox:=Proxy;

      if (Prox.Method=cmSimple) or (Prox.Method=cmDirect) then
        fClient.SocksVersion:=svNoSocks
      else
      begin
        case Prox.Method of
          cmSocks4:  fClient.SocksVersion:=svSocks4;
          cmSocks4A: fClient.SocksVersion:=svSocks4A;
          cmSocks5:  fClient.SocksVersion:=svSocks5;
        end;
        fClient.SocksHost:=Prox.Server;
        fClient.SocksPort:=Prox.Port;
        fClient.SocksUserID:=Prox.AuthInfo.User;
        fClient.SocksPassword:=Prox.AuthInfo.Pass;
        if Prox.Auth then
          fClient.SocksAuthentication:=saUsernamePassword
        else
          fClient.SocksAuthentication:=saNoAuthentication;
      end;

      if Prox.Method=cmSimple then
      begin
        fClient.Host:=Prox.Server;
        fClient.Port:=Prox.Port;
      end
      else
      begin
        fClient.Host:=fHost;
        fClient.Port:=fPort;
      end;

      fSocketState:=stConnecting;
      DoEvent(ncConnecting,'',0);
      fClient.Connect;
      fSocketState:=stConnected;
      DoEvent(ncConnected,'',0);

      if Prox.Method=cmSimple then
      begin
        S:=StringReplace(Prox.Cmd,'%user%',Prox.AuthInfo.User,[rfReplaceAll,rfIgnoreCase]);
        S:=StringReplace(S,'%newline%',#13#10,[rfReplaceAll,rfIgnoreCase]);
        S:=StringReplace(S,'%pass%',Prox.AuthInfo.Pass,[rfReplaceAll,rfIgnoreCase]);
        S:=StringReplace(S,'%server%',fHost,[rfReplaceAll,rfIgnoreCase]);
        S:=StringReplace(S,'%port%',IntToStr(fPort),[rfReplaceAll,rfIgnoreCase]);
        fClient.WriteLn(S);
      end;

      if fAutoLogin and (AuthInfo.User<>'') then
      begin
        S:=StringReplace(fLoginCmd,'%user%',AuthInfo.User,[rfReplaceAll,rfIgnoreCase]);
        S:=StringReplace(S,'%newline%',#13#10,[rfReplaceAll,rfIgnoreCase]);
        S:=StringReplace(S,'%pass%',AuthInfo.Pass,[rfReplaceAll,rfIgnoreCase]);
        if (AuthInfo.Pass='') and (S<>'') and (S[Length(S)]=' ') then Delete(S,Length(S),1);
        fClient.WriteLn(S);
        DoEvent(ncLoginSent,'',0);
      end;

      while not Terminated do
        // ReadBuffer will give an exception WSAENOTSOCK if the remote end closes the
        // connection. That's ok.
        DoEvent(ncRead,fClient.ReadBuffer,0);

    except
      on E: ENoPass do begin Suspend; Continue; end;
      on E: EWinshoeSocketError do
        if (E.LastError<>WSAENOTSOCK) or NetworkDebug then
          DoEvent(ncError,E.Message,E.LastError);
      on E: Exception do DoEvent(ncError,E.Message,0);
    end;
    try
      fSocketState:=stDisconnected;
      fClient.CloseSocket;
      fSocketState:=stDisconnected;
    except
    end;
    DoEvent(ncDisconnected,'',0);

    Suspend;
  end;
end;

procedure TNetClient.AskPWs;
var
  Prox: TProxySettings;
  Msg: string;
begin
  if Proxy.Method=cmGlobal then
  begin
    Prox:=GlobalProxy;
    Msg:='Global proxy-server';
  end
  else
  begin
    Prox:=Proxy;
    Msg:='Proxy-server of '+SessionDescr;
  end;
  if (Prox.Method<>cmDirect) and Prox.Auth and (Prox.Server<>'') and (Prox.Port<>0)
    and Prox.AuthInfo.AskPW and (not Prox.AuthInfo.GotPW) then
  begin
    Prox.AuthInfo.GotPW:=AskPW(Msg,Prox.Server+':'+IntToStr(Prox.Port),Prox.AuthInfo.User,Prox.AuthInfo.Pass);
    if not Prox.AuthInfo.GotPW then raise(ENoPass.Create(''));
  end;
  if Proxy.Method=cmGlobal then
    GlobalProxy:=Prox
  else
    Proxy:=Prox;

  if AuthInfo.AskPW and (fHost<>'') and (fPort<>0) and (not AuthInfo.GotPW) then
  begin
    AuthInfo.GotPW:=AskPW(SessionDescr,fHost+':'+IntToStr(fPort),AuthInfo.User,AuthInfo.Pass);
    if not AuthInfo.GotPW then raise(ENoPass.Create(''));
  end;
end;

procedure TNetClient.Connect;
begin
  if fSocketState<>stDisconnected then Exit;
  try
    AskPWs;
  except
    on E: ENoPass do Exit;
  end;
  while Suspended do Resume;
end;

procedure TNetClient.ReConnect;
begin
  if Connected then Disconnect;
  Connect;
end;

procedure TNetClient.Disconnect;
begin
  if fSocketState=stDisconnected then Exit;
  try
    fClient.CloseSocket;
  except
  end;
end;

function  TNetClient.CanConnect: Boolean;
begin
  Result:=(fHost<>'') and (fPort<>0);
end;

function  TNetClient.Connected: Boolean;
begin
  Result:=fSocketState=stConnected;
end;

procedure TNetClient.SendText(const S: string);
begin
  Inc(TotalSent,Length(S)+2);
  fClient.Write(S+#13#10);
end;

function TNetClient.GetEvent(var Event: TNetworkEvent): Boolean;
var
  L: TList;
  P: ^TNetworkEvent;
begin
  L:=fEventList.LockList;
  Result:=L.Count>0;
  if not Result then begin fEventList.UnlockList; Exit; end;
  try
    P:=L[0];
    L.Delete(0);
    Event:=P^;
    Dispose(P);
    if Event.EventType=ncRead then
      while (L.Count>0) and (TNetworkEvent(L[0]^).EventType=ncRead) do
      begin
        P:=L[0];
        L.Delete(0);
        Event.EventMsg:=Event.EventMsg+P^.EventMsg;
        Dispose(P);
      end;
  finally
    fEventList.UnlockList;
  end;
end;

end.
