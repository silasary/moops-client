unit ServerWinshoeCHARGEN;

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
  TWinshoeCHARGENListener = class(TWinshoeListener)
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
  RegisterComponents('Winshoes Servers', [TWinshoeCHARGENListener]);
end;

constructor TWinshoeCHARGENListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := WSPORT_CHARGEN;
end;

function TWinshoeCHARGENListener.DoExecute(Thread: TWinshoeServerThread): boolean;
var
  Buf:String;
  Counter:Integer;
  Width:Integer;
  Base:Integer;

begin
  result := inherited DoExecute(Thread);
  if result then exit;
  Buf:='';
  While Length(Buf)<94 do
    Buf:=Buf+Chr(Length(Buf)+32); {chargen array}
  Base:=1;
  Counter:=1;
  Width:=1;
  with Thread.Connection do begin
    while Connected do begin
       Write(Copy(Buf,Counter,1));
       Inc(Counter);
       Inc(Width);
       If Width=72 then Begin
          If Connected then Writeln('');
          Width:=1;
          Inc(Base);
          If Base=95 then Base:=1;
          Counter:=Base;
       End;
       If Counter=95 then Counter:=1;
    end; {while}
  end; {with}
end; {doExecute}

end.
