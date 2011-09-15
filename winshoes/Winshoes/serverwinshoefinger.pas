unit serverwinshoefinger;

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
  TGetEvent = procedure(Thread: TWinshoeServerThread;UserName:String) of object;

  TWinshoeFINGERListener = class(TWinshoeListener)
  private
    FOnCommandFinger:TGetEvent;
  protected
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnCommandFinger: TGetEvent read fOnCommandFinger
                                        write fOnCommandFinger;
  end;

procedure Register;

implementation

uses
  GlobalWinshoe,
  SysUtils,
  Winshoes;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeFINGERListener]);
end;

constructor TWinshoeFINGERListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := WSPORT_FINGER;
end;

function TWinshoeFINGERListener.DoExecute(Thread: TWinshoeServerThread): boolean;
Var
   S:String;
begin
  result := inherited DoExecute(Thread);
  if result then exit;
  with Thread.Connection do begin
    If Connected then begin
       S:=Readln;
       if assigned(OnCommandFinger) then
         OnCommandFinger(Thread,S)
    End;
    Disconnect;
  end; {with}
end; {doExecute}

end.
