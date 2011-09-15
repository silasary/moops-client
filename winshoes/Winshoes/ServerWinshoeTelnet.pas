// CHANGES
//
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
//
unit ServerWinshoeTelnet;

interface

uses
  Classes
  , ServerWinshoe
  , Windows;

type
  TTelnetData = class
  public
    Username, Password: String;
    HUserToken: THandle;
  end;

  TAuthenticationEvent = function(Thread: TWinshoeServerThread; const psUsername
   , psPassword: string): Boolean of object;

  TWinshoeTelnetListener = class(TWinshoeListener)
  private
    fiLoginAttempts: Integer;
    FOnAuthentication: TAuthenticationEvent;
    fsLoginMessage: String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    function DoAuthenticate(Thread: TWinshoeServerThread; const psUsername, psPassword: string)
     : boolean; virtual;
    procedure DoConnect(Thread: TWinshoeServerThread); override;
  published
    property LoginAttempts: Integer read fiLoginAttempts write fiLoginAttempts;
    property LoginMessage: String read fsLoginMessage write fsLoginMessage;
    property OnAuthentication: TAuthenticationEvent read FOnAuthentication write FOnAuthentication;
  end;

// Procs
  procedure Register;

var
  tmpthread: TWinshoeServerThread;

implementation

uses
  SysUtils;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeTelnetListener]);
end;

constructor TWinshoeTelnetListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  LoginAttempts := 3;
  LoginMessage := 'Winshoes Telnet Server';
  Port := 23;
end;

function TWinshoeTelnetListener.DoAuthenticate;
begin
  if not assigned(OnAuthentication) then
    raise Exception.Create('No authentication handler has been specified.');
  result := OnAuthentication(Thread, psUsername, psPassword);
end;

procedure TWinshoeTelnetListener.DoConnect(Thread: TWinshoeServerThread);
Var
  Data: TTelnetData;
  i: integer;
begin
  try
    inherited;
    if Thread.SessionData = nil then begin
      Data := TTelnetData.Create;
      Thread.SessionData := Data;
    end else begin
      Data := Thread.SessionData as TTelnetData;
    end;
    with Thread.Connection do begin
      WriteLn(LoginMessage);
      WriteLn('');
      for i := 1 to LoginAttempts do begin
        Write('Username: ');
        Data.Username := ReadLnAndEcho('');
        Write('Password: ');
        Data.Password := ReadLnAndEcho('*');
        WriteLn('');
        Read(1); //Kill LF
        //
        if DoAuthenticate(Thread, Data.Username, Data.Password) then
          break;

        WriteLn('Invalid Login.');
        if i = 3 then
          raise Exception.Create('Allowed login attempts exceeded, good bye.');
      end;
    end;
  except
    on E: Exception do begin
      Thread.Connection.WriteLn(E.Message);
      Thread.Connection.Disconnect;
    end;
  end;
end;

end.
