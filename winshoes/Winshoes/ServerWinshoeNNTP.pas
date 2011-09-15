unit ServerWinshoeNNTP;

interface

////////////////////////////////////////////////////////////////////////////////
// Author: Ozz Nixon
// ..
// This layer actually parses the commands, fires the events.
// The implementation of this protocol requires that the
// "server app" actually does the 'writeln' of the data back
// to the client.
//
// All of the server components do nothing more than parse
// the commands from the client and fire events.
////////////////////////////////////////////////////////////////////////////////
{
******************************************************************************
Date        Author Change.
--------------------------------------------------------------------------------
19-Jun-1999 Brad   Added support for Netscape by fixing a few bugs.
28-Jul-1999 Mark   Added 2 new events Takethis and Check in support of NNTP
                   Transport extensions to stream newsfeeds.
01-Aug-1999 Mark   Removed the calls to NoAngleBrackets.
07 Aug 1999 Pete Mee  Altered the automatic UpperCase for sCMD.
13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
}
uses
  Classes,
  ServerWinshoe;

Const
   KnownCommands:Array [1..23] of string=
   {from RFC977}
      ('ARTICLE',
       'BODY',
       'HEAD',
       'STAT',
       'GROUP',
       'LIST',
       'HELP',
       'IHAVE',
       'LAST',
       'NEWGROUPS',
       'NEWNEWS',
       'NEXT',
       'POST',
       'QUIT',
       'SLAVE',
       'AUTHINFO',
   {microsoft news reader requires these!}
       'XOVER',
       'XHDR',
   {from testing other servers}
       'DATE',     {returns "111 YYYYMMDDHHNNSS"}
       'LISTGROUP', {returns all the article numbers for specified group}
       'MODE',      {for the MODE command}
       'TAKETHIS',  {streaming nntp}
       'CHECK'      {streaming nntp need this to go with takethis}
       );

Type
  TGetEvent = procedure(Thread: TWinshoeServerThread) of object;
  TOtherEvent = procedure(Thread: TWinshoeServerThread;Command:String;Parm:String;var Handled:Boolean) of object;
  TDoByIDEvent = procedure(Thread: TWinshoeServerThread;ActualID:string) of object;
  TDoByNoEvent = procedure(Thread: TWinshoeServerThread;ActualNumber:integer) of object;
  TGroupEvent = procedure(Thread: TWinshoeServerThread;Group:string) of object;
  TNewsEvent = procedure(Thread: TWinshoeServerThread;Parm:String) of object;
  TDataEvent = procedure(Thread: TWinshoeServerThread;Data:TObject) of object;

  TWinshoeNNTPListener = class(TWinshoeListener)
  private
    fOnCommandAuthInfo:TOtherEvent;                {authinfo user [data] or authinfo pass [data]}
    fOnCommandArticleID:TDoByIDEvent;              {article <message-id>}
    fOnCommandArticleNO:TDoByNoEvent;              {article 7872}
    fOnCommandBodyID:TDoByIDEvent;                 {body <message-id>}
    fOnCommandBodyNO:TDoByNoEvent;                 {body 7872}
    fOnCommandHeadID:TDoByIDEvent;                 {head <message-id>}
    fOnCommandHeadNO:TDoByNoEvent;                 {head 7872}
    fOnCommandStatID:TDoByIDEvent;                 {stat <message-id>} {useless!}
    fOnCommandStatNO:TDoByNoEvent;                 {stat 7872}
    fOnCommandGroup:TGroupEvent;                   {group net.news}
    fOnCommandList:TNewsEvent;                     {list [optional parm]}
    fOnCommandHelp:TGetEvent;                      {help}
    fOnCommandIHave:TDoByIDEvent;                  {ihave <message-id>}
    fOnCommandLast:TGetEvent;                      {last}
    fOnCommandMode:TNewsEvent;                     {mode reader}
    fOnCommandNewGroups:TNewsEvent;               {newsgroups yymmdd hhmmss [GMT] <distributions>}
    fOnCommandNewNews:TNewsEvent;                  {newnews newsgroups yymmdd hhmmss [GMT] <distributions>}
    fOnCommandNext:TGetEvent;                      {next}
    fOnCommandPost:TGetEvent;                      {post}
    fOnCommandQuit:TGetEvent;                      {quit}
    fOnCommandSlave:TGetEvent;                     {slave}
{not in RFC977}
    fOnCommandXOver:TNewsEvent;                    {xover start#-stop#}
    fOnCommandXHDR:TNewsEvent;                     {xhdr header start#-stop#}
    fOnCommandDate:TGetEvent;                      {date}
    fOnCommandListgroup:TNewsEvent;                {listgroup net.news}
    fOnCommandTakeThis:TDoByIDEvent;               {nntp transport ext}
    fOnCommandCheck:TDoByIDEvent;                  {nntp transport ext}
{other support}
    fOnCommandOther:TOtherEvent;
  protected
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnCommandAuthInfo: TOtherEvent read fOnCommandAuthInfo
                                            write fOnCommandAuthInfo;
    property OnCommandArticleID: TDoByIDEvent read fOnCommandArticleID
                                              write fOnCommandArticleID;
    property OnCommandArticleNo: TDoByNoEvent read fOnCommandArticleNo
                                              write fOnCommandArticleNo;
    property OnCommandBodyID: TDoByIDEvent read fOnCommandBodyID
                                           write fOnCommandBodyID;
    property OnCommandBodyNo: TDoByNoEvent read fOnCommandBodyNo
                                           write fOnCommandBodyNo;
    property OnCommandCheck: TDoByIDEvent read fOnCommandCheck
                                           write fOnCommandCheck;
    property OnCommandHeadID: TDoByIDEvent read fOnCommandHeadID
                                           write fOnCommandHeadID;
    property OnCommandHeadNo: TDoByNoEvent read fOnCommandHeadNo
                                           write fOnCommandHeadNo;
    property OnCommandStatID: TDoByIDEvent read fOnCommandStatID
                                           write fOnCommandStatID;
    property OnCommandStatNo: TDoByNoEvent read fOnCommandStatNo
                                           write fOnCommandStatNo;
    property OnCommandGroup: TGroupEvent read fOnCommandGroup
                                         write fOnCommandGroup;
    property OnCommandList: TNewsEvent read fOnCommandList
                                       write fOnCommandList;
    property OnCommandHelp: TGetEvent read fOnCommandHelp
                                      write fOnCommandHelp;
    property OnCommandIHave: TDoByIDEvent read fOnCommandIHave
                                          write fOnCommandIHave;
    property OnCommandLast: TGetEvent read fOnCommandLast
                                      write fOnCommandLast;
    property OnCommandMode: TNewsEvent read fOnCommandMode
                                      write fOnCommandMode;
    property OnCommandNewGroups: TNewsEvent read fOnCommandNewGroups
                                             write fOnCommandNewGroups;
    property OnCommandNewNews: TNewsEvent read fOnCommandNewNews
                                          write fOnCommandNewNews;
    property OnCommandNext: TGetEvent read fOnCommandNext
                                      write fOnCommandNext;
    property OnCommandPost: TGetEvent read fOnCommandPost
                                      write fOnCommandPost;
    property OnCommandQuit: TGetEvent read fOnCommandQuit
                                      write fOnCommandQuit;
    property OnCommandSlave: TGetEvent read fOnCommandSlave
                                       write fOnCommandSlave;
    property OnCommandTakeThis : TDoByIDEvent read fOnCommandTakeThis
                                              write fOnCommandTakeThis;
    property OnCommandXOver: TNewsEvent read fOnCommandXOver
                                        write fOnCommandXOver;
    property OnCommandXHDR: TNewsEvent read fOnCommandXHDR
                                       write fOnCommandXHDR;
    property OnCommandDate: TGetEvent read fOnCommandDate
                                      write fOnCommandDate;
    property OnCommandListgroup: TNewsEvent read fOnCommandListGroup
                                            write fOnCommandListGroup;

    property OnCommandOther: TOtherEvent read fOnCommandOther
                                         write fOnCommandOther;
  end;

// Procs
  procedure Register;

implementation

uses
  GlobalWinshoe,
  StringsWinshoe, SysUtils,
  Winshoes;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeNNTPListener]);
end;

constructor TWinshoeNNTPListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := WSPORT_NNTP;
end;

function TWinshoeNNTPListener.DoExecute(Thread: TWinshoeServerThread): boolean;
var
  i:integer;
  s,sCmd:String;
  WasHandled:Boolean;

  procedure NotHandled(CMD:String);
  begin
    Thread.Connection.Writeln('500 command not recognized ('+ CMD +')');
  end;


  function isNumericString(Str: String) : Boolean;
  begin
    if Length(str) = 0 then Result := False
                       else Result := IsNumeric(Str[1]);
  end;

begin
  result:=inherited DoExecute(Thread);
  if result then exit;

  with Thread.Connection do begin
    while Connected do begin
try
      s:=ReadLn;
except
      exit;
end;
//      Thread.DefaultProcessing:=i<1;
      sCmd := Fetch(s,CHAR32);
      i:=Succ(PosInStrArray(UpperCase(sCmd),KnownCommands));
      Case i of
        1:{article}
          If isNumericString(s) then Begin
            if Assigned(OnCommandArticleNo) then
              OnCommandArticleNo(Thread, StrToInt(S))
            else
              NotHandled(sCmd);
          End
          Else Begin
            if Assigned(OnCommandArticleID) then
              OnCommandArticleID(Thread, S)
            else
              NotHandled(sCmd);
          End;
        2:{body}
          If isNumericString(s) then Begin
            if assigned(OnCommandBodyNo) then
              OnCommandBodyNo(Thread,StrToInt(S))
            Else
              NotHandled(sCmd);
          End
          Else Begin
            if assigned(OnCommandBodyID) then
              OnCommandBodyID(Thread,S)
            Else
              NotHandled(sCmd);
          End;
        3:{head}
          If isNumericString(s) then Begin
            if assigned(OnCommandHeadNo) then
              OnCommandHeadNo(Thread,StrToInt(S))
            Else
              NotHandled(sCmd);
          End
          Else Begin
            if assigned(OnCommandHeadID) then
              OnCommandHeadID(Thread,S)
            Else
              NotHandled(sCmd);
          End;
        4:{stat}
          If isNumericString(s) then Begin
            if assigned(OnCommandStatNo) then
              OnCommandStatNo(Thread,StrToInt(S))
            Else
              NotHandled(sCmd);
          End
          Else Begin
            if assigned(OnCommandStatID) then
              OnCommandStatID(Thread,S)
            Else
              NotHandled(sCmd);
          End;
        5:{group}
          if assigned(OnCommandGroup) then
            OnCommandGroup(Thread,S)
          Else
            NotHandled(sCmd);
        6:{list}
          if assigned(OnCommandList) then
            OnCommandList(Thread,S)
          Else
            NotHandled(sCmd);
        7:{help}
          if assigned(OnCommandHelp) then
            OnCommandHelp(Thread)
          Else
            NotHandled(sCmd);
        8:{ihave}
          if assigned(OnCommandIHave) then
            OnCommandIHave(Thread,S)
          Else
            NotHandled(sCmd);
        9:{last}
          if assigned(OnCommandLast) then
            OnCommandLast(Thread)
          Else
            NotHandled(sCmd);
       10:{newgroups}
          if assigned(OnCommandNewGroups) then
            OnCommandNewGroups(Thread,S)
          Else
            NotHandled(sCmd);
       11:{newsgroups}
          if assigned(OnCommandNewNews) then
            OnCommandNewNews(Thread,S)
          Else
            NotHandled(sCmd);
       12:{next}
          if assigned(OnCommandNext) then
            OnCommandNext(Thread)
          Else
            NotHandled(sCmd);
       13:{post}
          if assigned(OnCommandPost) then
            OnCommandPost(Thread)
          Else
            NotHandled(sCmd);
       14:{quit} begin
          if assigned(OnCommandQuit) then
            OnCommandQuit(Thread);
          if Thread.DefaultProcessing then
            Thread.Connection.WriteLn('205 Goodbye');
          Thread.Connection.Disconnect;
          end;
       15:{slave}
          if assigned(OnCommandSlave) then
            OnCommandSlave(Thread)
          Else
            NotHandled(sCmd);
       16:{authinfo}
          if assigned(OnCommandAuthInfo) then Begin
            sCmd := UpperCase(Fetch(s,CHAR32));
            WasHandled:=False;
            OnCommandAuthInfo(Thread,SCmd,S,WasHandled);
            If Not WasHandled then NotHandled(sCmd);
          End
          Else
            NotHandled(sCmd);
       17:{xover}
          if assigned(OnCommandXOver) then
            OnCommandXOver(Thread,S)
          Else
            NotHandled(sCmd);
       18:{xhdr}
          if assigned(OnCommandXHDR) then
            OnCommandXHDR(Thread,S)
          Else
            NotHandled(sCmd);
       19:{date}
          if assigned(OnCommandDate) then
            OnCommandDate(Thread)
          Else
            NotHandled(sCmd);
       20:{listgroup}
          if assigned(OnCommandListGroup) then
            OnCommandListGroup(Thread,S)
          Else
            NotHandled(sCmd);
       21: {mode}
          if assigned(OnCommandMode) then
             OnCommandMode(Thread,S)
          else
            NotHandled(sCmd);
       22: if assigned(OnCommandTakeThis) then
            OnCommandTakeThis(Thread,S)
          Else
            NotHandled(sCmd);
       23: if assigned(OnCommandCheck) then
            OnCommandCheck(Thread,S)
          Else
            NotHandled(sCmd);
        else begin
          if assigned(OnCommandOther) then Begin
            WasHandled:=False;
            OnCommandOther(Thread,sCmd,S,WasHandled);
            If Not WasHandled then NotHandled(sCmd);
          end
          else
            NotHandled(sCmd);
        end;
      end; {end case}
    end; {while}
  end; {with}
end; {doExecute}

end.
