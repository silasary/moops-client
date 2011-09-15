unit WinshoeGUIIntegrator;

interface

{
NOTE - This unit must NOT appear in any Winshoes uses clauses. This is a ONE way relationship
and is linked in IF the user uses this component. This is done to preserve the isolation from the
massive FORMS unit.

13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)

}

uses
  Classes,
  Winshoes;

type
  TWinshoeGUIIntegrator = class(TWinshoeGUIIntegratorBase)
  private
  protected
    fbApplicationHasPriority: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Process; override;
  published
    property ApplicationHasPriority: Boolean read fbApplicationHasPriority
     write fbApplicationHasPriority;
  end;

// Procs
  procedure Register;

implementation

uses
  Forms,
  SysUtils,
  Windows;

procedure Register;
begin
  RegisterComponents('Winshoes Misc', [TWinshoeGUIIntegrator]);
end;

constructor TWinshoeGUIIntegrator.Create(AOwner: TComponent);
begin
  inherited;
  fbApplicationHasPriority := True;
end;

procedure TWinshoeGUIIntegrator.Process;
{TODO - Much of this can be made slightly faster by moving certain checks into the Winshoe component
 itself}
var
  Msg: TMsg;
begin
  inherited;
  // Only process if calling client is in the main thread
  if GetCurrentThreadID <> MainThreadID then
    exit;

  if ApplicationHasPriority then begin
    Application.ProcessMessages;
  end else begin
    // This guarantees it won't ever call Application.Idle
    if PeekMessage(Msg, 0, 0, 0, PM_NOREMOVE) then
      Application.HandleMessage;
  end;
end;

end.
