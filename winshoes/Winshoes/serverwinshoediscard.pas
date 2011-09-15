unit ServerWinshoeDISCARD;

interface

////////////////////////////////////////////////////////////////////////////////
// Author: Ozz Nixon
// ..
// 5.13.99 Final Version
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
////////////////////////////////////////////////////////////////////////////////

uses
  Classes,
  ServerWinshoe;

Type
  TWinshoeDISCARDListener = class(TWinshoeListener)
  private
  protected
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
  end;

// Procs
  procedure Register;

implementation

uses
  GlobalWinshoe,
  SysUtils,
  Winshoes;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeDISCARDListener]);
end;

constructor TWinshoeDISCARDListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := WSPORT_DISCARD;
end;

function TWinshoeDISCARDListener.DoExecute(Thread: TWinshoeServerThread): boolean;
begin
  result := inherited DoExecute(Thread);
  if result then exit;
  with Thread.Connection do begin
    while Connected do begin
       Thread.Connection.Read(1); {discard it}
    end; {while}
  end; {with}
end; {doExecute}

end.
