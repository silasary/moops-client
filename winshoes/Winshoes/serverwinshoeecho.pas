unit ServerWinshoeECHO;

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
  TWinshoeECHOListener = class(TWinshoeListener)
  private
  protected
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
  end;

procedure Register;

implementation

uses
  GlobalWinshoe,
  SysUtils,
  Winshoes;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeECHOListener]);
end;

constructor TWinshoeECHOListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := WSPORT_ECHO;
end;

function TWinshoeECHOListener.DoExecute(Thread: TWinshoeServerThread): boolean;
var
  Buf:String;

begin
  result := inherited DoExecute(Thread);
  if result then exit;
  with Thread.Connection do begin
    while Connected do begin
       Buf:=Read(1);
       If Connected then Write(Buf);
    end; {while}
  end; {with}
end; {doExecute}

end.
