unit SenderThread;

interface

uses
  Classes
  , GlobalWinshoe
  , SMTPWinshoe
  , WinshoeMessage;

type
  TSenderThread = class(TThread)
  private
    OldStatusEvent: TStringEvent;
  public
    SMTP: TWinshoeSMTP;
    Msg: TWinshoeMessage;
    StatusMsg: String;
    //
    procedure Execute; override;
    procedure Status;
    procedure StatusEvent(Sender: TComponent; const psMsg: String);
  end;

implementation

procedure TSenderThread.Execute;
begin
  OldStatusEvent := SMTP.OnStatus; try
    SMTP.OnStatus := StatusEvent;

    SMTP.Send(Msg);
    Terminate;
  finally SMTP.OnStatus := OldStatusEvent; end
end;

procedure TSenderThread.Status;
begin
  if assigned(OldStatusEvent) then
    OldStatusEvent(SMTP, StatusMsg);
end;

procedure TSenderThread.StatusEvent(Sender: TComponent; const psMsg: String);
begin
  StatusMsg := psMsg;
  Synchronize(Status);
end;

end.
