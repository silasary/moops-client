// CHANGES
//
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
//

unit TelnetWinshoe;

interface

uses
  Classes
  , Winshoes;

type
  TWinshoeTelnet = class(TWinshoeClient)
  public
    constructor Create(AOwner: TComponent); override;
  end;

// Procs
  procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Winshoes Clients', [TWinshoeTelnet]);
end;

constructor TWinshoeTelnet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := 23;
end;

end.
