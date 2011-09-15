unit serverwinshoe;

{
2000-Jan-13 MTL
  -Moved to new Palette Scheme (Winshoes Servers)
2000-Jan-05 - Kudzu
  -Merged Gregor's SSL into core
  -Created SSLOptions property
1999-Dec-12 Gregor Ibic, Intelicom d.o.o.
  -Added SSL capability
07 Aug 1999 Mod. Peter Mee
  -Added PeerPort property as a Word value.
5 Aug 1999  Modified Keith Peter Johnson
  -Placed Disconnect on Listener in OnTerminate as well
   Stops GPF on 95.
1999.04.07 - Kudzu
  -Thread list now in threads property
  -Cleaned up server shutdown and thread termination and abort code
}

interface

Uses
  Classes,
  ExtCtrls,
  MySSLWinshoe,
  ThreadWinshoe,
  Winshoes, WinsockIntf, Windows;

Type
  TWinshoeListener = Class;

  TWinshoeServer = Class(TWinshoeSocket)
  protected
    fwPeerPort: Word;
    fLastRcvTimeStamp: TDateTime;    //Timestamp of latest received command
    fbProcessingTimeout: boolean;     //To avoid double timeout processing
    //
    function GetListener: TWinshoeListener;
  public
    procedure Disconnect; override;
    property LastRcvTimeStamp: TDateTime read fLastRcvTimeStamp write fLastRcvTimeStamp;
    property PeerPort: Word read FwPeerPort;
    property ProcessingTimeout: boolean read fbProcessingTimeout write fbProcessingTimeout;
    function Read(const piLen: Integer): string; override;
    procedure SetHandle(const pHandle: TSocket); virtual;
  published
    property Listener: TWinshoeListener read GetListener;
  end;

  TWinshoeListenerThread = class(TkdzuThread)
  protected
  public
    fListener: TWinshoeListener;
    //
    procedure AfterRun; override;
    procedure Run; override;
  end;

  TWinshoeServerThread = class(TkdzuThread)
  protected
    fSessionData: TObject;
    fConnection: TWinshoeServer;
    //
    procedure AfterRun; override;
    procedure BeforeRun; override;
  public
    DefaultProcessing: Boolean; // Why is this here? NNTP uses it. anyone else?
    //
    constructor Create(pConnection: TWinshoeServer); virtual;
    destructor Destroy; override;
    procedure Run; override;
    //
    property Connection: TWinshoeServer read fConnection;
    property SessionData: TObject read FSessionData write FSessionData;
  end;

  TServerEvent = procedure(Thread: TWinshoeServerThread) of object;
  TTimeoutEvent = procedure(Thread: TWinshoeServerThread; var KeepAlive: boolean) of object;
  TCreateThreadEvent = procedure(pConnection: TWinshoeServer; var pThread: TWinshoeServerThread)
   of object;

  TWinshoeServerThreadList = class(TThreadList)
  protected
    procedure TerminateActualThread(pThread: TWinshoeServerThread);
  public
    procedure TerminateAll;
    function Terminate(pThread: TWinshoeServerThread): Boolean;
  end;

  TWinshoeListener = Class(TWinshoe)
  protected
    fbActive: Boolean;
    fSessionTimer: TTimer;
    fiSessionTimeout: integer;           //Session timeout in minutes
    fOnSessionTimeout: TTimeoutEvent;  //Session timeout event
    fOnExecute, fOnConnect, fOnDisconnect: TServerEvent;
    fOnCreateThread: TCreateThreadEvent;
    fthrdListener: TWinshoeListenerThread;
    fThreads: TWinshoeServerThreadList;
    //
    procedure DoConnect(Thread: TWinshoeServerThread); virtual;
    procedure DoDisconnect(Thread: TWinshoeServerThread); virtual;
    function DoExecute(Thread: TWinshoeServerThread): boolean; virtual;
    procedure Loaded; override;
    procedure CheckSessions(Sender: TObject);
    procedure SetActive(pbValue: Boolean);
    procedure SetSessionTimeout(const piTimeout: integer);
  public
    property Threads: TWinshoeServerThreadList read fThreads;
  published
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //
    property Active: boolean read FbActive write SetActive;
    property SessionTimeout: integer read fiSessionTimeOut write SetSessionTimeOut;
    //
    property OnCreateThread: TCreateThreadEvent read fOnCreateThread write fOnCreateThread;
    property OnExecute: TServerEvent read FOnExecute write FOnExecute;
    property OnConnect: TServerEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TServerEvent read FOnDisconnect write FOnDisconnect;
    property OnSessionTimeout: TTimeoutEvent read FOnSessionTimeout write FOnSessionTimeout;
  end;

procedure Register;

implementation

uses
  SysUtils, SSLSupportWinshoes;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeListener]);
end;

constructor TWinshoeListener.Create(AOwner: TComponent);
begin
  inherited;
  fThreads := TWinshoeServerThreadList.Create;
  fSessionTimer := TTimer.Create(self);
end;

destructor TWinshoeListener.Destroy;
begin
  Active := False;
  Threads.TerminateAll;
  Threads.Free;
  inherited Destroy;
end;

procedure TWinshoeListener.CheckSessions(Sender: TObject);
var
  KeepAlive: boolean;
  i: integer;
  list, listTimeout: TList;
  Thread: TWinshoeServerThread;
begin
  listTimeout := TList.Create; try
    List := Threads.LockList; try
      for i := Pred(list.Count) DownTo 0 do begin
        if ((Now - TWinshoeServerThread(List[i]).Connection.LastRcvTimeStamp) >= SessionTimeOut / 1440)
         and not TWinshoeServerThread(List[i]).Connection.ProcessingTimeout then begin
          KeepAlive := false;
          if assigned(fOnSessionTimeOut) then begin
            Thread := TWinshoeServerThread(List[i]);
            Thread.Connection.ProcessingTimeout := true;
            OnSessionTimeout(Thread, KeepAlive);
            Thread.Connection.ProcessingTimeout := false;
          end;
          if KeepAlive then begin
            TWinshoeServerThread(List[i]).Connection.LastRcvTimeStamp := Now;
          end else begin
            listTimeOut.Add(list[i]);
            list.Delete(i);
          end;
        end;
      end;
    finally Threads.UnlockList end;
    // Now terminate the threads - we have to terminate while the ThreadList is unlocked,
    // so we delay and terminate off of listTimeout instead of the locked copy above
    for i := 0 to pred(listTimeout.count) do begin
      TWinshoeServerThread(listTimeout[i]).TerminateAndWaitFor;
    end;
  finally listTimeout.free end
end;

procedure TWinshoeListener.DoConnect(Thread: TWinshoeServerThread);
begin
  If Assigned(OnConnect) then begin
    OnConnect(Thread);
  end;
end;

procedure TWinshoeListener.DoDisconnect(Thread: TWinshoeServerThread);
begin
  If Assigned(OnDisconnect) then begin
    OnDisconnect(Thread);
  end;
end;

function TWinshoeListener.DoExecute;
begin
  result := assigned(OnExecute);
  if result then begin
    OnExecute(Thread);
  end;
end;

procedure TWinshoeListener.Loaded;
begin
  inherited Loaded;
  if Active then begin
    fbActive := False;
    SetActive(True);
  end;
end;

procedure TWinshoeListener.SetActive(pbValue: Boolean);
begin
  if fbActive = pbValue then begin
    exit;
  end;

  if not ((csLoading in ComponentState) or (csDesigning in ComponentState)) then begin
    if pbValue then begin
      AllocateSocket(SOCK_STREAM);
      Bind;
      Listen;
      fthrdListener := TWinshoeListenerThread.Create(True);
      fthrdListener.fListener := Self;
      if SSLEnabled then begin
      	CreateSSLContext(sslmServer);
      end;
      fthrdListener.Resume;
    end else begin
		  fSSLContext.Free;
      fSSLContext := nil;
      // Must be here also to allow Termination to trigger
      fthrdListener.fListener.Disconnect;
      fthrdListener.TerminateAndWaitFor;
      fthrdListener.Free;
    end;
  end;
  fbActive := pbValue;
end;

procedure TWinshoeListenerThread.AfterRun;
begin
  inherited;
  fListener.Disconnect;
end;

procedure TWinshoeListenerThread.Run;
var
  i: Integer;
  NewHandle: TSocket;
  Addr: TSockAddr;
  Server: TWinshoeServer;
  Thread: TWinshoeServerThread;
begin
  // Update to retrieve info from Addr and save it
  i := SizeOf(Addr);
  NewHandle := WinsockInterface.Accept(fListener.Handle, @Addr, @i);
  // True if we need to stop listening
  if fListener.CheckForSocketError2(NewHandle, [WSAEINTR]) then begin
    // Must terminate self - sometimes thread would rerun before SetActive called TerminateAndWaitFor
    Terminate;
    exit;
  end;
  // Has potential to be be freed twice - need to fix this
  Server := TWinshoeServer.Create(fListener);
  with Server do begin
    SetHandle(NewHandle);
    BoundIP := fListener.BoundIP;
    fsPeerAddress := TWinshoe.TInAddrToString(Addr.sin_addr);
    fwPeerPort := Addr.sin_port;
    LastRcvTimeStamp := Now;      //Added for session timeout support
    ProcessingTimeout := False;
    SSLEnabled := fListener.SSLEnabled;
    if SSLEnabled then begin
      fSSLSocket := TWinshoeSSLSocket.Create;
      fSSLSocket.Accept(NewHandle, fListener.fSSLContext);
    end;
  end;

  // Create Thread
  Thread := nil;
  if assigned(fListener.OnCreateThread) then begin
    fListener.OnCreateThread(Server, Thread);
  end;
  if Thread = nil then begin
    Thread := TWinshoeServerThread.Create(Server);
  end;
  //
  fListener.Threads.Add(Thread);
  Thread.Resume;
end;

constructor TWinshoeServerThread.Create;
begin
  fConnection := pConnection;
  // Must be after, thread starts running immediately
  inherited Create(True);
end;

destructor TWinshoeServerThread.Destroy;
begin
  Connection.Free;
  SessionData.Free;
  inherited;
end;

procedure TWinshoeServerThread.Run;
begin
  try
    Connection.Listener.DoExecute(Self);
  except
    on E: EWinshoeSocketError do begin
      case E.LastError of
        10054: Connection.Disconnect;
      end;
    end;
    on EWinshoeClosedSocket do ;
  else
    raise;
  end;
  if not Connection.Connected then begin
    Terminate;
  end;
end;

procedure TWinshoeServerThread.AfterRun;
begin
  // Other things are done in destructor
  with Connection.Listener do begin
    DoDisconnect(Self);
    Threads.Terminate(Self);
  end;
end;

procedure TWinshoeServerThread.BeforeRun;
begin
  Connection.Listener.DoConnect(Self);
end;

procedure TWinshoeServer.Disconnect;
begin
  fwPeerPort := 0;
  inherited;
end;

function TWinshoeServer.GetListener: TWinshoeListener;
begin
  result := Owner as TWinshoeListener;
end;

function TWinshoeServer.Read(const piLen: Integer): string;
begin
  LastRcvTimeStamp := Now;    //this should update the timestamp
  Result := inherited Read(piLen);
end;

procedure TWinshoeServer.SetHandle(const pHandle: TSocket);
begin
  fHandle := pHandle;
end;

procedure TWinshoeListener.SetSessionTimeout(const piTimeout: integer);
begin
  if piTimeOut < 0 then begin
    raise Exception.Create('Invliad SessionTimeout value.');
  end;

  fSessionTimer.Free;
  fSessionTimer := nil;
  if piTimeOut > 0 then begin
    fSessionTimer := TTimer.Create(Self);
    with fSessionTimer do begin
      Interval := 50000;
      OnTimer := CheckSessions;
    end
  end;
  fiSessionTimeOut := piTimeOut;
end;

function TWinshoeServerThreadList.Terminate(pThread: TWinshoeServerThread): Boolean;
var
  list: TList;
begin
  list := LockList; Try
    Result := list.Remove(pThread) <> -1;
  finally UnlockList; end;
  if result then begin
    TerminateActualThread(pThread);
  end;
end;

procedure TWinshoeServerThreadList.TerminateActualThread(pThread: TWinshoeServerThread);
begin
  // If not called by the thread that is being terminated, wait for it.
  // otherwise it will free itself after termination
  pThread.Connection.Disconnect;
  if GetCurrentThreadID <> pThread.ThreadID then begin
    pThread.TerminateAndWaitFor;
    pThread.Free;
  end else begin
    pThread.FreeOnTerminate := True;
  end;
end;

procedure TWinshoeServerThreadList.TerminateAll;
var
  list: TList;
  pThread: TWinshoeServerThread;
begin
  repeat
    list := LockList; Try
      pThread := nil;
      if list.Count > 0 then begin
        pThread := TWinshoeServerThread(list[0]);
        list.Delete(0);
      end;
    finally UnlockList; end;
    if pThread <> nil then begin
      TerminateActualThread(pThread);
    end;
  until pThread = nil;
end;

end.

