// CHANGES
//
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)

unit MappedPortWinshoe;

interface

uses
  ServerWinshoe
  , Winshoes;

type
  TWinshoeMappedPortData = class
  public
    OutboundClient: TWinshoeClient;
  end;

  TWinshoeMappedPort = class(TWinshoeListener)
  private
    fiMappedPort: Integer;
    fsMappedHost: String;
  protected
    procedure DoConnect(Thread: TWinshoeServerThread); override;
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
  public
  published
    property MappedHost: string read fsMappedHost write fsMappedHost;
    property MappedPort: Integer read fiMappedPort write fiMappedPort;
  end;

// Procs
  procedure Register;

implementation

uses
  Classes
  , WinsockIntf;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeMappedPort]);
end;

procedure TWinshoeMappedPort.DoConnect(Thread: TWinshoeServerThread);
begin
  inherited;
  Thread.SessionData := TWinshoeMappedPortData.Create;
  TWinshoeMappedPortData(Thread.SessionData).OutboundClient := TWinshoeClient.Create(nil);
  with TWinshoeMappedPortData(Thread.SessionData).OutboundClient do begin
    Port := MappedPort;
    Host := MappedHost;
    {TODO Handle connect failures}
    Connect;
  end;
end;

function TWinshoeMappedPort.DoExecute(Thread: TWinshoeServerThread): boolean;
var
  FDRead: TFDSet;
  OutClient: TWinshoeClient;
begin
  {TODO Cache this info - no need to reconstruct each time}
  OutClient := TWinshoeMappedPortData(Thread.SessionData).OutboundClient;
  try
    result := false;
    FDRead.fd_count := 2;
    FDRead.fd_array[0] := Thread.Connection.Handle;
    FDRead.fd_array[1] := OutClient.Handle;

    if WinsockInterface.Select(0, @FDRead, nil, nil, nil) > 0 then begin
      if Thread.Connection.Readable(1) then
        OutClient.Write(Thread.Connection.ReadBuffer);
      if OutClient.Readable(1) then
        Thread.Connection.Write(OutClient.ReadBuffer);
    end;
  finally
    if not OutClient.Connected then
      Thread.Connection.Disconnect;
  end;
end;

end.
