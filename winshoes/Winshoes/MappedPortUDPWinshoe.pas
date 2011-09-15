unit MappedPortUDPWinshoe;

interface

{
13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
2000-Jan-05:
  -Modified by Kudzu to be a general UDP mapped port component
  -Unit renamed
  -OnRequest change to TNotifyEvent
----
  -Original DNS mapped port by Gregor Ibic
}

uses
  Classes,
  UDPWinshoe,
  Winshoes;

type
  TDNSMappedPort = class(TWinshoeUDPListener)
  protected
    fiMappedPort: Integer;
    fsMappedHost: String;
    fOnRequest: TNotifyEvent;
    //
    procedure DoRequestNotify; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoUDPRead(const psData, psPeer: string; const piPort: Integer); override;
  published
    property MappedHost: string read fsMappedHost write fsMappedHost;
    property OnRequest: TNotifyEvent read fOnRequest write fOnRequest;
  end;

// Procs
  procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TDNSMappedPort]);
end;

constructor TDNSMappedPort.Create(AOwner: TComponent);
begin
  inherited;
  Port := 53;
end;

procedure TDNSMappedPort.DoRequestNotify;
begin
  If Assigned(OnRequest) then begin
    OnRequest(Self);
  end;
end;

procedure TDNSMappedPort.DoUDPRead(const psData, psPeer: string; const piPort: Integer);
var
  OutboundClient: TWinshoeUDPClient;
  rcvData: String;
begin
  inherited;

  DoRequestNotify;

  OutboundClient := TWinshoeUDPClient.Create(nil);
  OutboundClient.Host := fsMappedHost;
  OutboundClient.Port := fiMappedPort;
  try
    OutboundClient.Connect;
    OutboundClient.Send(psData);
    rcvData := '';
    rcvData := OutboundClient.Receive;
    try
      if rcvData <> '' then begin
        SendTo(psPeer, piPort, rcvData);
      end;
    finally
      //Disconnect;
    end;
    OutboundClient.Disconnect;
    OutboundClient.Destroy;
  except
    OutboundClient.Destroy;
  end;
end;

end.
