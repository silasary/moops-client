unit StdPlugins;

interface

uses
  Windows, Classes, SysUtils, FileCtrl, BePlugin, BeChatView, mwMooSyn, Common;

type
  TDisplayPlugin = class(TBePlugin)
    constructor Create(Page: TClientPageBase);
    function HandleLine(var Msg: string): Boolean; override;
  end;

  TTriggerPlugin = class;
  TTriggerProc = procedure(Plugin: TTriggerPlugin) of object;
  TTriggerLocation = (tlStart, tlEnd, tlContains);
  TTriggerAction = (taSkip, taLog, taBeep, taAns, taCustom);
  PTriggerEvent = ^TTriggerEvent;
  TTriggerEvent = record
    Action: TTriggerAction;
    Loc: TTriggerLocation;
    CaseSens: Boolean;
    Txt: string;
  case TTriggerAction of
    taAns: (AnsList: TStringList);
    taCustom: (CustomProc: TTriggerProc);
  end;

  TTriggerPlugin = class(TBePlugin)
    Triggers: TList;
    constructor Create(Page: TClientPageBase);
    destructor Destroy; override;
    function HandleLine(var Msg: string): Boolean; override;
    function InsertTrigger(Index: Integer; EventType: TTriggerAction;
      Location: TTriggerLocation; CaseSens: Boolean; Txt: string): PTriggerEvent;
    procedure CheckTrigger(Trigger: PTriggerEvent);
    function Cmp(Trigger: PTriggerEvent): Boolean;
  end;

  TLogType = (ltInData, ltOutData, ltError, ltInfo);
  TLogCmd = record
    Cmd: string;
    HasDate: Boolean;
    HasTime: Boolean;
  end;
  TLogCmdArray = array[ltInData..ltInfo] of string;
  TLogFilePlugin = class(TBePlugin)
  private
    fLogCmd: array[ltInData..ltInfo] of TLogCmd;
    function StripLine(const Msg: string): string;
    function GetLogCmd(LogType: TLogType): string;
    procedure SetLogCmd(LogType: TLogType; Cmd: string);
  public
    FileName: string;
    FileHandle: Integer;
    VerboseLog: Boolean;
    
    constructor Create(Page: TClientPageBase; LogPriority: Integer);
    function OpenFile(SessionName: string): Boolean;
    function OpenFileEx(AFileName: string): Boolean;
    function HandleLine(var Msg: string): Boolean; override;
    procedure CloseFile;
    procedure SaveLine(LogType: TLogType; Msg: string);
    destructor Destroy; override;

    property LogCmd[LogType: TLogType]: string read GetLogCmd write SetLogCmd;
  end;

  TSimpleEditPlugin = class(TBePlugin)
    ActivePage: TClientPageBase;
    FirstLine: Boolean;
    constructor Create(Page: TClientPageBase);
    function HandleLine(var Msg: string): Boolean; override;
  end;

  TActivityPlugin = class(TBePlugin)
    constructor Create(Page: TClientPageBase);
    function HandleLine(var Msg: string): Boolean; override;
  end;

implementation

uses
  ClientPage, WatcherUnit;

constructor TActivityPlugin.Create(Page: TClientPageBase);
begin
  inherited Create(Page);
  Priority:=ppDisplay;
  PluginName:='ActivityLeds and Watcher';
end;

function TActivityPlugin.HandleLine(var Msg: string): Boolean;
begin
  Result:=False;
  if CPage.TabIndex<>0 then
  begin
    TNetClientPage(CPage).ImageIndex:=imgActive;
    TNetClientPage(CPage).ActiveCount:=LedTime;
  end;
  TellWatcher(CPage.Caption,Msg);
end;

constructor TSimpleEditPlugin.Create(Page: TClientPageBase);
begin
  inherited Create(Page);
  Priority:=ppMcp-10; ActivePage:=nil;
  PluginName:='PseudoMcpEdit';
end;

function TSimpleEditPlugin.HandleLine(var Msg: string): Boolean;
var
  ObjName, ObjUpload: string;
  P1, P2: Integer;
begin
  if ActivePage=nil then
    if (Copy(Msg,1,8)='#$# edit') then
    begin
      Result:=True;
      P1:=Pos('name: ',Msg);
      P2:=Pos('upload: ',Msg);
      if (P1=0) or (P2=0) then begin CommanderMsg('Error in "#$# edit", can''t load verb/property'); Exit; end;
      ObjName:=Copy(Msg,P1+6,P2-P1-7);
      ObjUpload:=Copy(Msg,P2+8,Length(Msg));
      ActivePage:=TNetClientPage(CPage).OpenEditor(ObjName);
      with TEditClientPage(ActivePage) do
      begin
        if LowerCase(Copy(ObjUpload,1,8))='@program' then
        begin
          EditWin.HighLighter:=mwMooHighLighter;
          TextType:='verb';
        end
        else if LowerCase(Copy(ObjUpload,1,4))='@set' then
          TextType:='property';

        InitLoading(ObjName);
        UploadCmd:=ObjUpload;
      end;
      FirstLine:=True;
      Exit;
    end
    else
      begin Result:=False; Exit; end;
  Result:=True;
  if Msg='.' then // End of file
  begin
    TEditClientPage(ActivePage).FinishLoading;
    ActivePage:=nil;
  end
  else
    if not FirstLine then
      TEditClientPage(ActivePage).EditWin.Lines.Add(Msg)
    else
    begin
      TEditClientPage(ActivePage).EditWin.Lines[0]:=Msg;
      FirstLine:=False;
    end;
end;

constructor TDisplayPlugin.Create(Page: TClientPageBase);
begin
  inherited Create(Page);
  Priority:=ppDisplay; PluginName:='Display';
end;

function TDisplayPlugin.HandleLine(var Msg: string): Boolean;
begin
  Result:=False;
  if Copy(Msg,1,3)='#$"' then Msg:=Copy(Msg,4,Length(Msg)-3);
  AddToChat(Msg);
end;

constructor TTriggerPlugin.Create(Page: TClientPageBase);
begin
  inherited Create(Page);
  Triggers:=TList.Create;
  PluginName:='Trigger';
end;

destructor TTriggerPlugin.Destroy;
var
  I: Integer;
begin
  for I:=0 to Triggers.Count-1 do
    FreeMem(Triggers[I]);
  Triggers.Free;
  inherited Destroy;
end;

function TTriggerPlugin.Cmp(Trigger: PTriggerEvent): Boolean;
begin
  if Trigger.Loc=tlStart then
    if Trigger.CaseSens then
      Result:=Copy(ActMsg,1,Length(Trigger.Txt))=Trigger.Txt
    else
      Result:=Copy(ActMsgLC,1,Length(Trigger.Txt))=Trigger.Txt
  else if Trigger.Loc=tlEnd then
    if Trigger.CaseSens then
      Result:=Copy(ActMsg,Length(ActMsg)-Length(Trigger.Txt)+1,Length(Trigger.Txt))=Trigger.Txt
    else
      Result:=Copy(ActMsgLC,Length(ActMsg)-Length(Trigger.Txt)+1,Length(Trigger.Txt))=Trigger.Txt
  else
    if Trigger.CaseSens then
      Result:=Pos(Trigger.Txt,ActMsg)>0
    else
      Result:=Pos(Trigger.Txt,ActMsgLC)>0;
end;

procedure TTriggerPlugin.CheckTrigger(Trigger: PTriggerEvent);
begin
  if not Cmp(Trigger) then Exit;
  case Trigger.Action of
    taSkip:   ActMsg:='';
    taLog:    AddToLog(ActMsg);
    taBeep:   Beep;
    taAns:    if Assigned(Trigger.AnsList) then SendLine(RndStr(Trigger.AnsList));
    taCustom: if Assigned(Trigger.CustomProc) then Trigger.CustomProc(Self);
  end;
end;

function TTriggerPlugin.HandleLine(var Msg: string): Boolean;
var
  I: Integer;
begin
  Result:=inherited HandleLine(Msg);
  for I:=0 to Triggers.Count-1 do CheckTrigger(Triggers[I]);
  Msg:=ActMsg;
end;

function TTriggerPlugin.InsertTrigger(Index: Integer; EventType: TTriggerAction;
  Location: TTriggerLocation; CaseSens: Boolean; Txt: string): PTriggerEvent;
begin
  GetMem(Result,SizeOf(TTriggerEvent));
  Result.Action:=EventType;
  Result.Loc:=Location;
  Result.CaseSens:=CaseSens;
  if not CaseSens then Txt:=LowerCase(Txt);
  Pointer(Result.Txt):=nil; Result.Txt:=Txt;
  Result.AnsList:=nil;
  Result.CustomProc:=nil;
  if Index=-1 then
    Triggers.Add(Result)
  else
    Triggers.Insert(Index,Result);
end;

constructor TLogFilePlugin.Create(Page: TClientPageBase; LogPriority: Integer);
begin
  inherited Create(Page);
  Priority:=LogPriority;
  PluginName:='LogFile';
  LogCmd[ltInData]:='< %text%';
  LogCmd[ltOutData]:='> %text%';
  LogCmd[ltError]:='! %text%';
  LogCmd[ltInfo]:='# %text%';
  VerboseLog:=False;
end;

function TLogFilePlugin.GetLogCmd(LogType: TLogType): string;
begin
  Result:=fLogCmd[LogType].Cmd;
end;

procedure TLogFilePlugin.SetLogCmd(LogType: TLogType; Cmd: string);
begin
  fLogCmd[LogType].Cmd:=Cmd;
  fLogCmd[LogType].HasDate:=Pos('%date%',Cmd)>0;
  fLogCmd[LogType].HasTime:=Pos('%time%',Cmd)>0;
end;

function TLogFilePlugin.StripLine(const Msg: string): string;
var
  I, J: Integer;
begin
  Result:=Msg; if VerboseLog then Exit;
  I:=1;
  while I<=Length(Result) do
    if (Result[I]=#27) and (I<Length(Result)) and (Result[I+1]='[') then
    begin
      Inc(I);
      for J:=I to Length(Result) do
        if Result[J]='m' then
        begin
          Dec(I);
          Delete(Result,I,J-I+1);
          Break;
        end;
    end
    else if Result[I]=#7 then Delete(Result,I,1)
    else
      Inc(I);
end;

function TLogFilePlugin.HandleLine(var Msg: string): Boolean;
begin
  Result:=False;
  if FileName<>'' then SaveLine(ltInData,StripLine(Msg));
end;

procedure TLogFilePlugin.SaveLine(LogType: TLogType; Msg: string);
var
  S: string;
begin
  if (FileName='') or (LogCmd[LogType]='') then Exit;
  S:=fLogCmd[LogType].Cmd;
  if fLogCmd[LogType].HasDate then
    S:=StringReplace(S,'%date%',FormatDateTime('dd-mm-yyyy',Date),[rfReplaceAll,rfIgnoreCase]);
  if fLogCmd[LogType].HasTime then
    S:=StringReplace(S,'%time%',FormatDateTime('hh:nn:ss',Time),[rfReplaceAll,rfIgnoreCase]);
  S:=StringReplace(S,'%text%',Msg,[rfReplaceAll,rfIgnoreCase])+#13#10;

  if FileWrite(FileHandle,PChar(S)^,Length(S))=-1 then
  begin
    CloseFile;
    CommanderMsg('Log error: Cannot write to "'+FileName+'", logging disabled.');
  end;
end;

function TLogFilePlugin.OpenFile(SessionName: string): Boolean;
begin
  ForceDirectories(AppDir+'Logs\'+SessionName);
  Result:=OpenFileEx(AppDir+'Logs\'+SessionName+'\'+FormatDateTime('yyyy-mm-dd',Now)+'.log');
end;

function TLogFilePlugin.OpenFileEx(AFileName: string): Boolean;
begin
  FileName:=AFileName;
  FileHandle:=Integer(CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE,
    FILE_SHARE_READ, nil, OPEN_ALWAYS,
    FILE_ATTRIBUTE_NORMAL, 0));
  Result:=FileHandle<>-1;
  if Result then
    FileSeek(FileHandle,0,2)
  else
  begin
    CommanderMsg('LogToFile: Error opening '+FileName);
    FileName:='';
  end;
end;

procedure TLogFilePlugin.CloseFile;
begin
  if FileName<>'' then
    try
      FileName:='';
      FileClose(FileHandle);
    except
      CommanderMsg('LogToFile: Error closing '+FileName);
    end;
end;

destructor TLogFilePlugin.Destroy;
begin
  CloseFile;
  inherited Destroy;
end;

end.
