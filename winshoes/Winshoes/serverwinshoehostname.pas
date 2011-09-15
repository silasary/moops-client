unit serverwinshoehostname;

interface

////////////////////////////////////////////////////////////////////////////////
// Author: Ozz Nixon (RFC 953)
// ..
// 5.13.99 Final Version
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
////////////////////////////////////////////////////////////////////////////////

uses
  Classes,
  ServerWinshoe;

Const
   KnownCommands:Array [1..9] of string=
      (
      'HNAME',
      'HADDR',
      'ALL',
      'HELP',
      'VERSION',
      'ALL-OLD',
      'DOMAINS',
      'ALL-DOM',
      'ALL-INGWAY'
      );

Type
  TGetEvent = procedure(Thread: TWinshoeServerThread) of object;
  TOneParmEvent = procedure(Thread: TWinshoeServerThread;Parm:String) of object;

  TWinshoeHOSTNAMEListener = class(TWinshoeListener)
  private
    FOnCommandHNAME:TOneParmEvent;
    FOnCommandHADDR:TOneParmEvent;
    FOnCommandALL:TGetEvent;
    FOnCommandHELP:TGetEvent;
    FOnCommandVERSION:TGetEvent;
    FOnCommandALLOLD:TGetEvent;
    FOnCommandDOMAINS:TGetEvent;
    FOnCommandALLDOM:TGetEvent;
    FOnCommandALLINGWAY:TGetEvent;
  protected
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnCommandHNAME: TOneParmEvent read fOnCommandHNAME
                                           write fOnCommandHNAME;
    property OnCommandHADDR: TOneParmEvent read fOnCommandHADDR
                                           write fOnCommandHADDR;
    property OnCommandALL: TGetEvent read fOnCommandALL
                                     write fOnCommandALL;
    property OnCommandHELP: TGetEvent read fOnCommandHELP
                                      write fOnCommandHELP;
    property OnCommandVERSION: TGetEvent read fOnCommandVERSION
                                         write fOnCommandVERSION;
    property OnCommandALLOLD: TGetEvent read fOnCommandALLOLD
                                        write fOnCommandALLOLD;
    property OnCommandDOMAINS: TGetEvent read fOnCommandDOMAINS
                                         write fOnCommandDOMAINS;
    property OnCommandALLDOM: TGetEvent read fOnCommandALLDOM
                                        write fOnCommandALLDOM;
    property OnCommandALLINGWAY: TGetEvent read fOnCommandALLINGWAY
                                           write fOnCommandALLINGWAY;
  end;

procedure Register;

implementation

uses
  GlobalWinshoe,
  SysUtils, StringsWinshoe,
  Winshoes;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeHOSTNAMEListener]);
end;

constructor TWinshoeHOSTNAMEListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := 101;
end;

function TWinshoeHOSTNAMEListener.DoExecute(Thread: TWinshoeServerThread): boolean;
Var
   S,sCmd:String;

begin
  result := inherited DoExecute(Thread);
  if result then exit;
  with Thread.Connection do begin
    While Connected do begin
       S:=Readln;
       sCmd := UpperCase(Fetch(s,CHAR32));
       Case Succ(PosInStrArray(Uppercase(sCmd),KnownCommands)) of
           1:{hname}
           if assigned(OnCommandHNAME) then
              OnCommandHNAME(Thread,S);
           2:{haddr}
           if assigned(OnCommandHADDR) then
              OnCommandHADDR(Thread,S);
           3:{all}
           if assigned(OnCommandALL) then
              OnCommandALL(Thread);
           4:{help}
           if assigned(OnCommandHELP) then
              OnCommandHELP(Thread);
           5:{version}
           if assigned(OnCommandVERSION) then
              OnCommandVERSION(Thread);
           6:{all-old}
           if assigned(OnCommandALLOLD) then
              OnCommandALLOLD(Thread);
           7:{domains}
           if assigned(OnCommandDOMAINS) then
              OnCommandDOMAINS(Thread);
           8:{all-dom}
           if assigned(OnCommandALLDOM) then
              OnCommandALLDOM(Thread);
           9:{all-ingway}
           if assigned(OnCommandALLINGWAY) then
              OnCommandALLINGWAY(Thread);
       End; {case}
    End;
    Disconnect;
  end; {with}
end; {doExecute}

end.
