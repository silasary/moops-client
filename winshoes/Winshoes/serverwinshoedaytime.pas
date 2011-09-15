unit ServerWinshoeDAYTIME;

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
  TWinshoeDAYTIMEListener = class(TWinshoeListener)
  private
    FTimeZone:String;
  protected
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    Property TimeZone:String read FTimeZone
                             write FTimeZone;
  end;

procedure Register;

implementation

uses
  GlobalWinshoe,
  SysUtils,
  Winshoes;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeDAYTIMEListener]);
end;

constructor TWinshoeDAYTIMEListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := WSPORT_DAYTIME;
  FTimeZone:='EST';
end;

function TWinshoeDAYTIMEListener.DoExecute(Thread: TWinshoeServerThread): boolean;
begin
  result := inherited DoExecute(Thread);
  if result then exit;
  with Thread.Connection do begin
    If Connected then
       Writeln(FormatDateTime('dddd, mmmm dd, yyyy hh:nn:ss',Now)+'-'+FTimeZone);
    Disconnect;
  end; {with}
end; {doExecute}

end.
