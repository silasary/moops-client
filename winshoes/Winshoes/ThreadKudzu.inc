interface

uses
  Classes, Windows;

type
  //TODO: Add Synchro with params method
  TkdzuThread = class(TThread)
  private
  protected
    procedure Execute; override;
    procedure Run; virtual; abstract;
    procedure AfterRun; virtual; // Not abstract - otherwise it is required
    procedure BeforeRun; virtual; // Not abstract - otherwise it is required
  public
    procedure Synchronize(Method: TThreadMethod);
    procedure TerminateAndWaitFor; virtual;
  end;

implementation

uses
  SysUtils;

procedure TkdzuThread.TerminateAndWaitFor;
begin
  Terminate;
  WaitFor;
end;

procedure TkdzuThread.AfterRun;
begin
end;

procedure TkdzuThread.BeforeRun;
begin
end;

procedure TkdzuThread.Execute;
begin
  try
    BeforeRun; try
      while not Terminated do
        Run;
    finally AfterRun; end;
  except
    {TODO log into a prop - if left unhandled - crashes bad - esp 95 is fatal}
  end;
end;

procedure TkdzuThread.Synchronize(Method: TThreadMethod);
begin
  inherited Synchronize(Method);
end;


