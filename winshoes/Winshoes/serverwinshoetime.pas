unit ServerWinshoeTIME;

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
  TWinshoeTIMEListener = class(TWinshoeListener)
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
  RegisterComponents('Winshoes Servers', [TWinshoeTIMEListener]);
end;

constructor TWinshoeTIMEListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := WSPORT_TIME;
end;

function TWinshoeTIMEListener.DoExecute(Thread: TWinshoeServerThread): boolean;
Var
   WI:Integer;
   Ws:String[4];
begin
  result := inherited DoExecute(Thread);
  if result then exit;
  with Thread.Connection do begin
    If Connected then Begin
       WI:=((Trunc(Date)+2)*(24*60*60))+DateTimeToTimeStamp(Now).Time;
       SetLength(Ws,4);
       Move(WI,WS[1],4);
    End;
    Disconnect;
  end; {with}
end; {doExecute}

end.
