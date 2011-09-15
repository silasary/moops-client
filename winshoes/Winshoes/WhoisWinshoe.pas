unit WhoisWinshoe;

{
13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)

1999-Jan-05 - Kudzu
  -Cleaned uses clause
  -Changed result type
  -Eliminated Response prop
  -Fixed a bug in Whois
  -Added Try..finally
  -other various mods
----
  -Originally by Hadi Hariri
}

interface

uses
	Classes,
  Winshoes;

type
  TWinshoeWHOIS = class(TWinshoeClient)
  public
    constructor Create(anOwner: TComponent); override;
    function WhoIs(asDomain: string): string;
  end;

// Procs
	procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Winshoes Clients', [TWinshoeWHOIS]);
end;

{ TWinshoeWHOIS }

constructor TWinshoeWHOIS.Create(anOwner: TComponent);
begin
  inherited;
  Host := 'whois.internic.net';
  Port := WSPORT_WHOIS;
end;

function TWinshoeWHOIS.WhoIs(asDomain: string): string;
begin
  Connect; try
    Result := '' ;
    WriteLn(asDomain);
    while Connected do begin
      Result := Result + ReadBuffer;
    end;
  finally Disconnect; end;
end;

end.
