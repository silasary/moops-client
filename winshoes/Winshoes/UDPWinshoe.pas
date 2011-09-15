unit UDPWinshoe;
{
2000.02.03 - FIX Receive function BUG! By Victor.Ho
2000.01.13 -  MTL
  -  Moved to new Palette Scheme (Winshoes Clients and Winshoes Servers)
2000.01.05 - Kudzu
	- ReceiveTimeout property added
  - Renamed Receive to ReceiveWithTimeout and reimplemented Receive
  - Modified ReceiveWithTimeout to handle -1
1999.11.22 Addition Gregor Ibic, gregor.ibic@intelicom-sp.si
  - Added Timeout parameter to TWinshoeUDPClient which controls the timeout
    of the RecvFrom function. Is set different from 0 it set up to timeout
    after n milliseconds.
1999.11.15 Modification Gregor Ibic, gregor.ibic@intelicom-sp.si
  - Fixed the Active status bug. Now, if set in design time, UDPListener
    starts OK.
}
interface

uses
  Classes
  , Messages
  , ThreadWinshoe
  , Windows, Winshoes, WinsockIntf;

type
	TUDPReadEvent = procedure(Sender: TObject; const psData, psPeer: string; const piPort: Integer)
   of object;

  TWinshoeUDP = class(TWinshoe)
  protected
    FiUDPSize: Integer;
    fsUDPBuffer: string;
    //
    procedure CheckUDPBuffer;
    class procedure SendToPrimitive(pHandle: THandle; pAddr_Remote: TSockAddrIn; psData: string);
    procedure SetUDPSize(const iValue: Integer);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UDPSize: Integer read FiUDPSize write SetUDPSize;
  end;

  TWinshoeUDPListener = class;

  TWinshoeUDPListenerThread = class(TkdzuThread)
  protected
    fsData, fsPeer: string;
    fiPort: integer;
  public
    fListener: TWinshoeUDPListener;
    //
    procedure Run; override;
    procedure UDPRead;
  published
  end;

  TWinshoeUDPListener = class(TWinshoeUDP)
  protected
    fbActive: Boolean;
    fOnUDPRead: TUDPReadEvent;
    fthrdListener: TWinshoeUDPListenerThread;
    //
    procedure Loaded; override;
    procedure SetActive(const bValue: Boolean);
  public
    destructor Destroy; override;
    procedure DoUDPRead(const psData, psPeer: string; const piPort: Integer); virtual;
    procedure SendTo(const psIP: string; const piPort: Integer; const psData: string);
  published
    property Active: boolean read FbActive write SetActive default False;
    property OnUDPRead: TUDPReadEvent read FOnUDPRead write FOnUDPRead;
  end;

	TWinshoeUDPClient = class(TWinshoeUDP)
	protected
    fsHost, fsPeerAddress: String;
    fnReceiveTimeout: Integer;
   	fAddr_Remote: TSockAddrin;
	public
    procedure Connect;
    constructor Create(anOwner: TComponent); override;
    function Receive: string;
    function ReceiveWithTimeout(const piMSec: Integer): string;
    function Readable(const piMSec: Integer): boolean;
		procedure Send(psData: string);
    //
    property PeerAddress: string read fsPeerAddress write fsPeerAddress;
	published
    property Host: string read fsHost write fsHost;
    property ReceiveTimeout: Integer read fnReceiveTimeout write fnReceiveTimeout;
	end;

// Procs
  procedure Register;

implementation

uses
  GlobalWinshoe
  , SysUtils;

procedure Register;
begin
  RegisterComponents('Winshoes Clients', [TWinshoeUDPClient]);
  RegisterComponents('Winshoes Servers', [TWinshoeUDPListener]);
end;

procedure TWinshoeUDP.CheckUDPBuffer;
begin
  // In case dynamically created
  if Length(fsUDPBuffer) = 0 then
    SetUDPSize(FiUDPSize);
end;

procedure TWinshoeUDPClient.Connect;
begin
  if Connected then
    raise EWinshoeAlreadyConnected.Create('Already connected.');

	AllocateSocket(SOCK_DGRAM); try
    with fAddr_Remote do begin
      sin_family := PF_INET;
      sin_port := WinsockInterface.HToNS(Port);
      sin_addr.S_addr := ResolveHost(fsHost, fsPeerAddress);;
    end;
  except
    On E: Exception do begin
      Disconnect;
      raise;
    end;
  end;
end;

constructor TWinshoeUDPClient.Create(anOwner: TComponent);
begin
  inherited;
	ReceiveTimeout := -1;
end;

function TWinshoeUDPClient.Readable;
var
  tmTo: TTimeVal;
  FDRead: TFDSet;
begin
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


function TWinshoeUDPClient.Receive: string;
begin
	Result:=ReceiveWithTimeout(ReceiveTimeout); //FIXED Victor.Ho
end;

function TWinshoeUDPClient.ReceiveWithTimeout(const piMSec: Integer): string;
var
  i, iByteCount: Integer;
  AddrVoid: TSockAddrIn;
begin
  CheckUDPBuffer;
  i := SizeOf(AddrVoid);

	if piMsec <> -1 then begin
    if not Readable(piMSec) then begin
      Result := '';
      exit;
    end;
  end;
  iByteCount := WinsockInterface.RecvFrom(Handle, fsUDPBuffer[1], Length(fsUDPBuffer), 0, AddrVoid
   , i);
 	CheckForSocketError(iByteCount);
  if iByteCount = 0 then begin
    raise EWinshoeException.Create('Receive Error = 0.');
  end;

  result := Copy(fsUDPBuffer,1, iByteCount);
end;

procedure TWinshoeUDPClient.Send;
begin
  SendToPrimitive(Handle, fAddr_Remote, psData);
end;

procedure TWinshoeUDPListener.Loaded;
begin
  inherited Loaded;
  if Active then begin
    fbActive := False;
    SetActive(True);
  end;
end;

procedure TWinshoeUDPListener.SetActive;
begin
  if fbActive = bValue then
    exit;
  if not ((csLoading in ComponentState) or (csDesigning in ComponentState)) then begin
    if bValue then begin
      CheckUDPBuffer;
      AllocateSocket(SOCK_DGRAM);
      Bind;
      //
      fthrdListener := TWinshoeUDPListenerThread.Create(True);
      fthrdListener.fListener := Self;
      fthrdListener.FreeOnTerminate := True;
      fthrdListener.Resume;
    end else begin
      // Necessary here - cancels the recvfrom in the listener thread
      Disconnect;
      // No listener is created if in design mode
      if fthrdListener <> nil then begin
	      // Is Free on Terminate - dont free thread.
	      fthrdListener.TerminateAndWaitFor;
      end;
    end;
  end;
  fbActive := bValue;
end;

constructor TWinshoeUDP.Create(AOwner: TComponent);
begin
  inherited;
  fiUDPSize := WinsockInterface.MaxUDPSize;
end;

class procedure TWinshoeUDP.SendToPrimitive;
var
	iBytesOut: Integer;
begin
  iBytesOut := WinsockInterface.SendTo(pHandle, psData[1], Length(psData), 0, pAddr_Remote
   , sizeof(pAddr_Remote));
  if iBytesOut = 0 then begin
    raise Exception.Create('0 bytes were sent.')
  end else if iBytesOut = SOCKET_ERROR then begin
    if WinsockInterface.WSAGetLastError() = WSAEMSGSIZE then
      raise Exception.Create('Package Size Too Big')
    else
      CheckForSocketError(SOCKET_ERROR);
  end else if iBytesOut <> Length(psData) then begin
    raise Exception.Create('Not all bytes sent.');
  end;
end;

procedure TWinshoeUDP.SetUDPSize;
begin
  if iValue > WinsockInterface.MaxUDPSize then
    raise EWinshoeException.Create('Max UDP size is: ' + IntToStr(WinsockInterface.MaxUDPSize));
  FiUDPSize := iValue;
  if not (csDesigning in ComponentState) then
    SetLength(fsUDPBuffer, fiUDPSize);
end;

destructor TWinshoeUDPListener.destroy;
begin
  Active := False;
  inherited Destroy;
end;

procedure TWinshoeUDPListener.DoUDPRead(const psData, psPeer: string; const piPort: Integer);
begin
  if assigned(OnUDPRead) then begin
    OnUDPRead(Self, psData, psPeer, piPort);
  end;
end;

procedure TWinshoeUDPListener.SendTo;
var
  Addr_Remote: TSockAddrIn;
begin
  addr_remote.sin_family := PF_INET;
  addr_remote.sin_port := WinsockInterface.htons(piPort);
  addr_remote.sin_addr.S_addr := TWinshoe.ResolveHost(psIP, sVoid);
  SendToPrimitive(Handle, addr_remote, psData);
end;

procedure TWinshoeUDPListenerThread.Run;
var
  i, iByteCount: Integer;
  addr_remote: TSockAddrin;
begin
  i := SizeOf(addr_remote);
  iByteCount := WinsockInterface.RecvFrom(fListener.Handle, fListener.fsUDPBuffer[1]
   , Length(fListener.fsUDPBuffer), 0, addr_remote, i);
  // Thread may be terminated
  fListener.CheckForSocketError2(iByteCount, [10004, 10038]);
  // Thread may be terminated
  if fListener.Connected then begin
    if iByteCount = 0 then begin
      raise EWinshoeException.Create('RecvFrom Error = 0.');
    end;

    fsData := Copy(fListener.fsUDPBuffer, 1, iByteCount);
    fsPeer := String(TWinshoe.TInAddrToString(addr_remote.sin_addr));
    fiPort := WinsockInterface.NToHS(addr_remote.sin_port);
    Synchronize(UDPRead);
  end else begin
    Terminate;
  end;
end;

procedure TWinshoeUDPListenerThread.UDPRead;
begin
  fListener.DoUDPRead(fsData, fsPeer, fiPort);
end;

end.
