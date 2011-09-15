unit serverwinshoewhois;

interface

////////////////////////////////////////////////////////////////////////////////
// Author: Ozz Nixon (RFC 954)
// ..
//
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
//
// 5.13.99 Final Version
//       ?         [responds with the following]
//    Please enter a name or a NIC handle, such as "Smith" or "SRI-NIC".
//    Starting with a period forces a name-only search; starting with
//    exclamation point forces handle-only.  Examples:
//       Smith     [looks for name or handle SMITH]
//       !SRI-NIC  [looks for handle SRI-NIC only]
//       .Smith, John
//                 [looks for name JOHN SMITH only]
//
//    Adding "..." to the argument will match anything from that point,
//    e.g. "ZU..." will match ZUL, ZUM, etc.
//
//    To search for mailboxes, use one of these forms:
//
//       Smith@    [looks for mailboxes with username SMITH]
//       @Host     [looks for mailboxes on HOST]
//       Smith@Host
//
////////////////////////////////////////////////////////////////////////////////

uses
  Classes,
  ServerWinshoe;

Type
  TGetEvent = procedure(Thread: TWinshoeServerThread;Lookup:String) of object;

  TWinshoeWHOISListener = class(TWinshoeListener)
  private
    FOnCommandLOOKUP:TGetEvent;
  protected
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnCommandLOOKUP: TGetEvent read fOnCommandLOOKUP
                                        write fOnCommandLOOKUP;
  end;

procedure Register;

implementation

uses
  GlobalWinshoe,
  SysUtils,
  Winshoes;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeWHOISListener]);
end;

constructor TWinshoeWHOISListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := 101;
end;

function TWinshoeWHOISListener.DoExecute(Thread: TWinshoeServerThread): boolean;
Var
   S: String;
begin
  result := inherited DoExecute(Thread);
  if result then exit;
  with Thread.Connection do begin
    While Connected do begin
       S:=Readln;
       If Connected then begin
          if assigned(OnCommandLOOKUP) then
             OnCommandLOOKUP(Thread,S);
       End; {case}
    End;
    Disconnect;
  end; {with}
end; {doExecute}

end.
