unit ServerWinshoeDICT;

interface

////////////////////////////////////////////////////////////////////////////////
// RFC 2229 - Dictionary Protocol (Structure).
// ..
// Author: Ozz Nixon
// ..
// 5.13.99 Final Version
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
////////////////////////////////////////////////////////////////////////////////

uses
  Classes,
  ServerWinshoe;

Const
   KnownCommands:Array [1..10] of string=
      (
       'AUTH',
       'CLIENT',
       'DEFINE',
       'HELP',
       'MATCH',
       'OPTION',
       'QUIT',
       'SASLAUTH',
       'SHOW',
       'STATUS'
       );

Type
  TGetEvent = procedure(Thread: TWinshoeServerThread) of object;
  TOtherEvent = procedure(Thread: TWinshoeServerThread;Command,Parm:String) of object;
  TDefineEvent = procedure(Thread: TWinshoeServerThread;Database,WordToFind:String) of object;
  TMatchEvent = procedure(Thread: TWinshoeServerThread;Database,Strategy,WordToFind:String) of object;
  TShowEvent = procedure(Thread: TWinshoeServerThread;Command:String) of object;
  TAuthEvent = procedure(Thread: TWinshoeServerThread;Username,authstring:String) of object;

  TWinshoeDICTListener = class(TWinshoeListener)
  private
{other support}
    fOnCommandHELP:TGetEvent;
    fOnCommandDEFINE:TDefineEvent;
    fOnCommandMATCH:TMatchEvent;
    fOnCommandQUIT:TGetEvent;
    fOnCommandSHOW:TShowEvent;
    fOnCommandAUTH, fOnCommandSASLAuth:TAuthEvent;
    fOnCommandOption:TOtherEvent;
    fOnCommandSTAT:TGetEvent;
    fOnCommandCLIENT:TShowEvent;
    fOnCommandOther:TOtherEvent;
  protected
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnCommandHelp: TGetEvent read fOnCommandHelp
                                      write fOnCommandHelp;
    property OnCommandDefine: TDefineEvent read fOnCommandDefine
                                           write fOnCommandDefine;
    property OnCommandMatch: TMatchEvent read fOnCommandMatch
                                         write fOnCommandMatch;
    property OnCommandQuit: TGetEvent read fOnCommandQuit
                                      write fOnCommandQuit;
    property OnCommandShow: TShowEvent read fOnCommandShow
                                       write fOnCommandShow;
    property OnCommandAuth: TAuthEvent read fOnCommandAuth
                                       write fOnCommandAuth;
    property OnCommandSASLAuth: TAuthEvent read fOnCommandSASLAuth
                                          write fOnCommandSASLAuth;
    property OnCommandOption: TOtherEvent read fOnCommandOption
                                           write fOnCommandOption;
    property OnCommandStatus: TGetEvent read fOnCommandStat
                                        write fOnCommandStat;
    property OnCommandClient: TShowEvent read fOnCommandClient
                                         write fOnCommandClient;
    property OnCommandOther: TOtherEvent read fOnCommandOther
                                         write fOnCommandOther;
  end;

procedure Register;

implementation

uses
  GlobalWinshoe,
  SysUtils, StringsWinshoe,
  Winshoes;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeDICTListener]);
end;

constructor TWinshoeDICTListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := WSPORT_DICT;
end;

function TWinshoeDICTListener.DoExecute(Thread: TWinshoeServerThread): boolean;
var
  s,sCmd,sCmd2:String;

  procedure NotHandled;
  begin
    Thread.Connection.Writeln('500 command not recognized');
  end;

begin
  result := inherited DoExecute(Thread);
  if result then exit;
  with Thread.Connection do begin
    while Connected do begin
      s := ReadLn;
        sCmd := UpperCase(Fetch(s,CHAR32));
        Case Succ(PosInStrArray(Uppercase(sCmd),KnownCommands)) of
           1:{auth}
             if assigned(OnCommandAuth) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandAuth(Thread,sCmd2,S);
             end
             Else
               NotHandled;
           2:{client}
             if assigned(OnCommandClient) then
               OnCommandClient(Thread,S)
             Else
               NotHandled;
           3:{define}
             if assigned(OnCommandHelp) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandHelp(Thread);
             end Else
               NotHandled;
           4:{help}
             if assigned(OnCommandHelp) then
               OnCommandHelp(Thread)
             Else
               NotHandled;
           5:{match}
             if assigned(OnCommandMatch) then Begin
               sCmd := UpperCase(Fetch(s,CHAR32));
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandMatch(Thread,sCmd,sCmd2,S);
             End
             Else
               NotHandled;
           6:{option}
             if assigned(OnCommandOption) then
               OnCommandOption(Thread,s, '')
             Else
               NotHandled;
           7:{quit}
             if assigned(OnCommandQuit) then
               OnCommandQuit(Thread)
             Else
               NotHandled;
           8:{saslauth}
             if assigned(OnCommandSASLAuth) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandSASLAuth(Thread, sCmd2, s);
             end Else
               NotHandled;
           9:{show}
             if assigned(OnCommandShow) then
               OnCommandShow(Thread,s)
             Else
               NotHandled;
          10:{status}
             if assigned(OnCommandStatus) then
               OnCommandStatus(Thread)
             Else
               NotHandled;
           else begin
             if assigned(OnCommandOther) then OnCommandOther(Thread,sCmd,S);
           end;
        end; {end case}
    end; {while}
  end; {with}
end; {doExecute}

end.
