unit ServerWinshoeIRC;

interface

////////////////////////////////////////////////////////////////////////////////
// RFC 1459 - Internet Relay Chat
// ..
// Author: Ozz Nixon
// ..
// 5.13.99 First Version
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
////////////////////////////////////////////////////////////////////////////////

uses
  Classes,
  ServerWinshoe;

Const
   KnownCommands:Array [1..40] of string=
      (
       'ADMIN',
       'AWAY',
       'CONNECT',
       'ERROR',
       'INFO',
       'INVITE',
       'ISON',
       'JOIN',
       'KICK',
       'KILL',
       'LINKS',
       'LIST',
       'MODE',
       'NAMES',
       'NICK',
       'NOTICE',
       'OPER',
       'PART',
       'PASS',
       'PING',
       'PONG',
       'PRIVMSG',
       'QUIT',
       'REHASH',
       'RESTART',
       'SERVER',
       'SQUIT',
       'STATS',
       'SUMMON',
       'TIME',
       'TOPIC',
       'TRACE',
       'USER',
       'USERHOST',
       'USERS',
       'VERSION',
       'WALLOPS',
       'WHO',
       'WHOIS',
       'WHOWAS'
       );

Type
  TGetEvent = procedure(Thread: TWinshoeServerThread) of object;
  TOtherEvent = procedure(Thread: TWinshoeServerThread;Command,Parm:String) of object;
  TOneParmEvent = procedure(Thread: TWinshoeServerThread;Parm:String) of object;
  TTwoParmEvent = procedure(Thread: TWinshoeServerThread;Parm1,Parm2:String) of object;
  TThreeParmEvent = procedure(Thread: TWinshoeServerThread;Parm1,Parm2,Parm3:String) of object;
  TFiveParmEvent = procedure(Thread: TWinshoeServerThread;Parm1,Parm2,Parm3,Parm4,Parm5:String) of object;
  TUserEvent = procedure(Thread: TWinshoeServerThread;UserName,HostName,ServerName,RealName:String) of object;
  TServerEvent = procedure(Thread: TWinshoeServerThread;ServerName,Hopcount,Info:String) of object;

  TWinshowIRCListener = class(TWinshoeListener)
  private
{other support}
    fOnCommandOther:TOtherEvent;
    fOnCommandPass:TOneParmEvent;
    fOnCommandNick:TTwoParmEvent;
    fOnCommandUser:TUserEvent;
    fOnCommandServer:TServerEvent;
    fOnCommandOper:TTwoParmEvent;
    fOnCommandQuit:TOneParmEvent;
    fOnCommandSQuit:TTwoParmEvent;
    fOnCommandJoin:TTwoParmEvent;
    fOnCommandPart:TOneParmEvent;
    fOnCommandMode:TFiveParmEvent;
    fOnCommandTopic:TTwoParmEvent;
    fOnCommandNames:TOneParmEvent;
    fOnCommandList:TTwoParmEvent;
    fOnCommandInvite:TTwoParmEvent;
    fOnCommandKick:TThreeParmEvent;
    fOnCommandVersion:TOneParmEvent;
    fOnCommandStats:TTwoParmEvent;
    fOnCommandLinks:TTwoParmEvent;
    fOnCommandTime:TOneParmEvent;
    fOnCommandConnect:TThreeParmEvent;
    fOnCommandTrace:TOneParmEvent;
    fOnCommandAdmin:TOneParmEvent;
    fOnCommandInfo:TOneParmEvent;
    fOnCommandPrivMsg:TTwoParmEvent;
    fOnCommandNotice:TTwoParmEvent;
    fOnCommandWho:TTwoParmEvent;
    fOnCommandWhoIs:TTwoParmEvent;
    fOnCommandWhoWas:TThreeParmEvent;
    fOnCommandKill:TTwoParmEvent;
    fOnCommandPing:TTwoParmEvent;
    fOnCommandPong:TTwoParmEvent;
    fOnCommandError:TOneParmEvent;
    fOnCommandAway:TOneParmEvent;
    fOnCommandRehash:TGetEvent;
    fOnCommandRestart:TGetEvent;
    fOnCommandSummon:TTwoParmEvent;
    fOnCommandUsers:TOneParmEvent;
    fOnCommandWallops:TOneParmEvent;
    fOnCommandUserHost:TOneParmEvent;
    fOnCommandIsOn:TOneParmEvent;
  protected
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnCommandPass: TOneParmEvent read fOnCommandPass
                                          write fOnCommandPass;
    property OnCommandNick: TTwoParmEvent read fOnCommandNick
                                          write fOnCommandNick;
    property OnCommandUser: TUserEvent read fOnCommandUser
                                       write fOnCommandUser;
    property OnCommandServer: TServerEvent read fOnCommandServer
                                           write fOnCommandServer;
    property OnCommandOper: TTwoParmEvent read fOnCommandOper
                                          write fOnCommandOper;
    property OnCommandQuit: TOneParmEvent read fOnCommandQuit
                                          write fOnCommandQuit;
    property OnCommandSQuit: TTwoParmEvent read fOnCommandSQuit
                                          write fOnCommandSQuit;
    property OnCommandJoin: TTwoParmEvent read fOnCommandJoin
                                          write fOnCommandJoin;
    property OnCommandPart: TOneParmEvent read fOnCommandPart
                                          write fOnCommandPart;
    property OnCommandMode: TFiveParmEvent read fOnCommandMode
                                           write fOnCommandMode;
    property OnCommandTopic: TTwoParmEvent read fOnCommandTopic
                                           write fOnCommandTopic;
    property OnCommandNames: TOneParmEvent read fOnCommandNames
                                           write fOnCommandNames;
    property OnCommandList: TTwoParmEvent read fOnCommandList
                                          write fOnCommandList;
    property OnCommandInvite: TTwoParmEvent read fOnCommandInvite
                                            write fOnCommandInvite;
    property OnCommandKick: TThreeParmEvent read fOnCommandKick
                                            write fOnCommandKick;
    property OnCommandVersion: TOneParmEvent read fOnCommandVersion
                                             write fOnCommandVersion;
    property OnCommandStats: TTwoParmEvent read fOnCommandStats
                                           write fOnCommandStats;
    property OnCommandLinks: TTwoParmEvent read fOnCommandLinks
                                           write fOnCommandLinks;
    property OnCommandTime: TOneParmEvent read fOnCommandTime
                                          write fOnCommandTime;
    property OnCommandConnect: TThreeParmEvent read fOnCommandConnect
                                               write fOnCommandConnect;
    property OnCommandTrace: TOneParmEvent read fOnCommandTrace
                                           write fOnCommandTrace;
    property OnCommandAdmin: TOneParmEvent read fOnCommandAdmin
                                           write fOnCommandAdmin;
    property OnCommandInfo: TOneParmEvent read fOnCommandInfo
                                           write fOnCommandInfo;
    property OnCommandPrivMsg: TTwoParmEvent read fOnCommandPrivMsg
                                             write fOnCommandPrivMsg;
    property OnCommandNotice: TTwoParmEvent read fOnCommandNotice
                                             write fOnCommandNotice;
    property OnCommandWho: TTwoParmEvent read fOnCommandWho
                                         write fOnCommandWho;
    property OnCommandWhoIs: TTwoParmEvent read fOnCommandWhoIs
                                           write fOnCommandWhoIs;
    property OnCommandWhoWas: TThreeParmEvent read fOnCommandWhoWas
                                              write fOnCommandWhoWas;
    property OnCommandKill: TTwoParmEvent read fOnCommandKill
                                          write fOnCommandKill;
    property OnCommandPing: TTwoParmEvent read fOnCommandPing
                                          write fOnCommandPing;
    property OnCommandPong: TTwoParmEvent read fOnCommandPong
                                          write fOnCommandPong;
    property OnCommandError: TOneParmEvent read fOnCommandError
                                           write fOnCommandError;
    property OnCommandAway: TOneParmEvent read fOnCommandAway
                                          write fOnCommandAway;
    property OnCommandRehash: TGetEvent read fOnCommandRehash
                                        write fOnCommandRehash;
    property OnCommandRestart: TGetEvent read fOnCommandRestart
                                         write fOnCommandRestart;
    property OnCommandSummon: TTwoParmEvent read fOnCommandSummon
                                            write fOnCommandSummon;
    property OnCommandUsers: TOneParmEvent read fOnCommandUsers
                                           write fOnCommandUsers;
    property OnCommandWallops: TOneParmEvent read fOnCommandWallops
                                             write fOnCommandWallops;
    property OnCommandUserHost: TOneParmEvent read fOnCommandUserHost
                                              write fOnCommandUserHost;
    property OnCommandIsOn: TOneParmEvent read fOnCommandIsOn
                                          write fOnCommandIsOn;
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
  RegisterComponents('Winshoes Servers', [TWinshowIRCListener]);
end;

constructor TWinshowIRCListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := 6667;
end;

function TWinshowIRCListener.DoExecute(Thread: TWinshoeServerThread): boolean;
var
  s,sCmd,sCmd2,sCmd3,sCmd4:String;

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
           1:{ADMIN}
             if assigned(OnCommandAdmin) then begin
               OnCommandAdmin(Thread,S);
             end
             Else
               NotHandled;
           2:{AWAY}
             if assigned(OnCommandAway) then begin
               OnCommandAway(Thread,S);
             end
             Else
               NotHandled;
           3:{CONNECT}
             if assigned(OnCommandConnect) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               sCmd3 := UpperCase(Fetch(s,CHAR32));
               OnCommandConnect(Thread,sCmd2,sCmd3,S);
             end
             Else
               NotHandled;
           4:{ERROR}
             if assigned(OnCommandError) then begin
               OnCommandError(Thread,S);
             end
             Else
               NotHandled;
           5:{INFO}
             if assigned(OnCommandInfo) then begin
               OnCommandInfo(Thread,S);
             end
             Else
               NotHandled;
           6:{INVITE}
             if assigned(OnCommandInvite) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandInvite(Thread,sCmd2,S);
             end
             Else
               NotHandled;
           7:{ISON}
             if assigned(OnCommandIsOn) then begin
               OnCommandIsOn(Thread,S);
             end
             Else
               NotHandled;
           8:{JOIN}
             if assigned(OnCommandJoin) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandJoin(Thread,sCmd2,S);
             end
             Else
               NotHandled;
           9:{KICK}
             if assigned(OnCommandKick) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               sCmd3 := UpperCase(Fetch(s,CHAR32));
               OnCommandKick(Thread,sCmd2,sCmd3,S);
             end
             Else
               NotHandled;
          10:{KILL}
             if assigned(OnCommandKill) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandKill(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          11:{LINKS}
             if assigned(OnCommandLinks) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandLinks(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          12:{LIST}
             if assigned(OnCommandList) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandList(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          13:{MODE}
             if assigned(OnCommandMode) then begin
               sCmd := UpperCase(Fetch(s,CHAR32));
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               sCmd3 := UpperCase(Fetch(s,CHAR32));
               sCmd4 := UpperCase(Fetch(s,CHAR32));
               OnCommandMode(Thread,sCmd,sCmd2,sCmd3,sCmd4,S);
             end
             Else
               NotHandled;
          14:{NAMES}
             if assigned(OnCommandNames) then begin
               OnCommandNames(Thread,S);
             end
             Else
               NotHandled;
          15:{NICK}
             if assigned(OnCommandNick) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandNick(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          16:{NOTICE}
             if assigned(OnCommandNotice) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandNotice(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          17:{OPER}
             if assigned(OnCommandOper) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandOper(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          18:{PART}
             if assigned(OnCommandPart) then begin
               OnCommandPart(Thread,S);
             end
             Else
               NotHandled;
          19:{PASS}
             if assigned(OnCommandPass) then begin
               OnCommandPass(Thread,S);
             end
             Else
               NotHandled;
          20:{PING}
             if assigned(OnCommandPing) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandPing(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          21:{PONG}
             if assigned(OnCommandPong) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandPong(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          22:{PRIVMSG}
             if assigned(OnCommandPrivMsg) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandPrivMsg(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          23:{QUIT}
             if assigned(OnCommandQuit) then begin
               OnCommandQuit(Thread,s);
             end
             Else
               NotHandled;
          24:{REHASH}
             if assigned(OnCommandRehash) then begin
               OnCommandRehash(Thread);
             end
             Else
               NotHandled;
          25:{RESTART}
             if assigned(OnCommandRestart) then begin
               OnCommandRestart(Thread);
             end
             Else
               NotHandled;
          26:{SERVER}
             if assigned(OnCommandServer) then begin
               sCmd := UpperCase(Fetch(s,CHAR32));
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandServer(Thread,sCmd,sCmd2,S);
             end
             Else
               NotHandled;
          27:{SQUIT}
             if assigned(OnCommandSQuit) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandSQuit(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          28:{STAT}
             if assigned(OnCommandStats) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandStats(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          29:{SUMMON}
             if assigned(OnCommandSummon) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandSummon(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          30:{TIME}
             if assigned(OnCommandTime) then begin
               OnCommandTime(Thread,S);
             end
             Else
               NotHandled;
          31:{TOPIC}
             if assigned(OnCommandTopic) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandTopic(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          32:{TRACE}
             if assigned(OnCommandTrace) then begin
               OnCommandTrace(Thread,S);
             end
             Else
               NotHandled;
          33:{USER}
             if assigned(OnCommandUser) then begin
               sCmd := UpperCase(Fetch(s,CHAR32));
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               sCmd3 := UpperCase(Fetch(s,CHAR32));
               OnCommandUser(Thread,sCmd,sCmd2,sCmd3,S);
             end
             Else
               NotHandled;
          34:{USERHOST}
             if assigned(OnCommandUserHost) then begin
               OnCommandUserHost(Thread,S);
             end
             Else
               NotHandled;
          35:{USERS}
             if assigned(OnCommandUsers) then begin
               OnCommandUsers(Thread,S);
             end
             Else
               NotHandled;
          36:{VERSION}
             if assigned(OnCommandVersion) then begin
               OnCommandVersion(Thread,S);
             end
             Else
               NotHandled;
          37:{WALLOPS}
             if assigned(OnCommandWallops) then begin
               OnCommandWallops(Thread,S);
             end
             Else
               NotHandled;
          38:{WHO}
             if assigned(OnCommandWho) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandWho(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          39:{WHOIS}
             if assigned(OnCommandWhoIs) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               OnCommandWhoIs(Thread,sCmd2,S);
             end
             Else
               NotHandled;
          40:{WHOWAS}
             if assigned(OnCommandWhoWas) then begin
               sCmd2 := UpperCase(Fetch(s,CHAR32));
               sCmd3 := UpperCase(Fetch(s,CHAR32));
               OnCommandWhoWas(Thread,sCmd2,sCmd3,S);
             end
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
