unit serverwinshoeqotd;

interface

////////////////////////////////////////////////////////////////////////////////
// Author: Ozz Nixon (RFC 865) [less than 512 characters total, multiple lines OK!]
// ..
// 5.13.99 Final Version
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
////////////////////////////////////////////////////////////////////////////////

uses
  Classes,
  ServerWinshoe;

Type
  TGetEvent = procedure(Thread: TWinshoeServerThread) of object;

  TWinshoeQOTDListener = class(TWinshoeListener)
  private
    fOnCommandQOTD:TGetEvent;
  protected
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnCommandQOTD: TGetEvent read fOnCommandQOTD
                                      write fOnCommandQOTD;
  end;

procedure Register;

implementation

uses
  GlobalWinshoe,
  SysUtils,
  Winshoes;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeQOTDListener]);
end;

constructor TWinshoeQOTDListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := WSPORT_QOTD;
end;

function TWinshoeQOTDListener.DoExecute(Thread: TWinshoeServerThread): boolean;
begin
  result := inherited DoExecute(Thread);
  if result then exit;
  with Thread.Connection do begin
    If Connected then begin
       if assigned(OnCommandQOTD) then
          OnCommandQOTD(Thread);
    End;
    Disconnect;
  end; {with}
end; {doExecute}

end.
