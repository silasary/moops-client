unit McpPlugin;

interface

uses
  Windows, Graphics, Controls, ComCtrls, Classes, SysUtils, Forms, Menus,
  BePlugin, BeChatView, mwMooSyn, StatusUnit, LinkParser;

const
  mdOff     = 0;
  mdError   = 1;
  mdVerbose = 2;

type
  TVersion = record
    Hi, Lo: Byte;
  end;

  TMcpPackageClass = class of TMcpPackage;
  TMcpPackage = class;

  PMcpMultiLine = ^TMcpMultiLine;
  TMcpMultiLine = record
    Tag: string;
    Pkg: TMcpPackage;
    MsgPkg, MsgVerb: string;
    MsgParams: TStringList;
    MsgData: Pointer;
    MultiParams: TStringList;
  end;

  TMcpPlugin = class;
  TMcpCommand = procedure(Mcp: TMcpPlugin);
  TMcpMode = (mcpUnknown, mcpNo, mcpYes);
  TMcpPlugin = class(TBePlugin)
  private
    procedure CreateMultiLine(MultiParams: TStringList);
    procedure FreeMultiLine(Index: Integer);
    function FinishMultiLine: Boolean;
    procedure SetMultiValues(Multi: PMcpMultiLine);
    procedure HandleMultiLine;
    function SplitLine: Boolean; virtual;
  public
    DebugMode: Integer;
    McpMode: TMcpMode;
    AuthKey, MsgPkg, MsgName, MsgVerb: string;
    MsgParams: TStringList;
    MsgData: Pointer;
    Packages: TList;
    MultiLines: TList;
    LocalTags: TStringList;
    MLNotify: Boolean;
    CurrentPkg: TMcpPackage;
    constructor Create(Page: TClientPageBase);
    destructor Destroy; override;
    procedure Debug(Pri: Integer; Msg: string);
    function HandleLine(var Msg: string): Boolean; override;
    procedure StartMcpSession;
    procedure SendMcp(const MsgName: string; MsgArgs: string);
    procedure SendMcpML(const DataTag, MsgArgs: string);
    procedure SendMcpMLEnd(const DataTag: string);
    procedure AddPkg(PkgClass: TMcpPackageClass);
    function ReqParams(Args: array of string): Boolean;
    function StrToOrd(Arg: string; Values: array of string): Integer;
    function GetDebugMultiLine(Index: Integer): string;
    procedure DumpMultiLine(const DataTag: string);
    //procedure SplitVerb(const MsgName: string; var MsgPkg, MsgVerb: string);
    function IsValidCommand(const MsgPkg, MsgVerb: string): Boolean;
    function FindPackage(const MsgPkg: string): TMcpPackage;
    function GetRandomTag: string;
    function NewMultiLine: string;
    procedure ReleaseMultiLine(Tag: string);
  end;

  TMcpPackage = class
    Mcp: TMcpPlugin;
    Supported: Boolean;
    SupVersion, MinVersion, MaxVersion: TVersion;
    PkgName: string;
    constructor Create(Owner: TMcpPlugin); virtual;
    function NotifyML(ML: PMcpMultiLine; const Key, Value: string): Boolean; virtual;
    procedure NotifyMLMessage(ML: PMcpMultiLine); virtual;
    procedure HandleMessage; virtual; abstract;
    function MyVerb(Verb: string): Boolean; virtual; abstract;
    procedure Negotiated; virtual;
  end;

  TMcpNegotiatePkg = class(TMcpPackage)
    constructor Create(Owner: TMcpPlugin); override;
    procedure HandleMessage; override;
    function MyVerb(Verb: string): Boolean; override;
  end;

  TMcpAwnsStatusPkg = class(TMcpPackage)
    Disabled: Boolean;
    constructor Create(Owner: TMcpPlugin); override;
    procedure HandleMessage; override;
    function MyVerb(Verb: string): Boolean; override;
  end;

  PMenuListItem = ^TMenuListItem;
  TMenuListItem = record
    Desc, Cmd: string;
  end;
  TMenuList = class(TList)
    procedure Clear; reintroduce;
    procedure Add(Desc, Cmd: string);
    procedure Delete(Index: Integer);
    procedure GetItem(Index: Integer; var Desc, Cmd: string);
    destructor Destroy; override;
  end;

  TIconMode = (imNormal, imHidden, imBlink, imOn, imOff);
  PIconInfo = ^TIconInfo;
  TIconInfo = record
    Icon:  Integer;
    OnIcon, OffIcon: Integer; // for buttonmode
    Mode:  TIconMode;
    Left:  Integer;
    Width: Integer;
    Hint:  string;
    Cmd0, Cmd1: string;
    Menu:  TMenuList;
  end;

  TMcpStatusPkg = class(TMcpPackage)
  private
    BlinkOn: Boolean;
    Icons: TList;
    procedure DrawIcon(Nr: Integer);
  public
    TrayWidth: Integer;
    CustomImages: TImageList;
    PopupMenu: TPopupMenu;
    constructor Create(Owner: TMcpPlugin); override;
    destructor  Destroy; override;
    procedure HandleMessage; override;
    function  MyVerb(Verb: string): Boolean; override;
    procedure Negotiated; override;

    procedure PaintIcons;
    procedure BlinkIcons(BlinkOn: Boolean);
    procedure UpdateIcons;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);

    procedure FreeIcon(Nr: Integer);
    function  AddIcon: PIconInfo;
    procedure UpdateIcon(Index: Integer);
    procedure ClearIcons;
    function  Pos2Icon(X, Y: Integer): Integer;
    procedure PopupItemClick(Sender: TObject);
    procedure ContextPopup(Index: Integer; MousePos: TPoint);
  end;

  TMcpEditPkg = class(TMcpPackage)
    FirstLine: Boolean;
    constructor Create(Owner: TMcpPlugin); override;
    function NotifyML(ML: PMcpMultiLine; const Key, Value: string): Boolean; override;
    procedure NotifyMLMessage(ML: PMcpMultiLine); override;
    procedure HandleMessage; override;
    function MyVerb(Verb: string): Boolean; override;
    procedure Negotiated; override;

    function SaveLines(CEPage: TClientPageBase): Boolean;
    procedure Load(const ObjName, ObjType: string);
  end;

  TMcpSimpleEdit = class(TMcpPackage)
    FirstLine: Boolean;
    constructor Create(Owner: TMcpPlugin); override;
    function NotifyML(ML: PMcpMultiLine; const Key, Value: string): Boolean; override;
    procedure NotifyMLMessage(ML: PMcpMultiLine); override;
    procedure HandleMessage; override;
    function MyVerb(Verb: string): Boolean; override;
    procedure Negotiated; override;

    function Send(CEPage: TClientPageBase): Boolean;
  end;
 
  TMcpClientPkg = class(TMcpPackage)
    constructor Create(Owner: TMcpPlugin); override;
    function MyVerb(Verb: string): Boolean; override;
  end;

  TMcpVmooClientPkg = class(TMcpPackage)
    Len, Height: Integer;
    constructor Create(Owner: TMcpPlugin); override;
    function MyVerb(Verb: string): Boolean; override;
    procedure HandleMessage; override;
    procedure Negotiated; override;
    procedure UpdateLineLength(ALen, AHeight: Integer);
  end;

  PUserInfo = ^TUserInfo;
  TUserInfo = record
    Nr:     Integer;
    Name:   string;
    Icon:   Integer;
    Idle:   Boolean;
    Away:   Boolean;
    Cloak:  Boolean;
    Values: TStringList;
  end;

  TMcpVmooUserlistPkg = class(TMcpPackage)
    UList: TListView;
    Users: TList;
    IconMapping: array[0..12] of Integer;
    CustomIcons: Boolean;
    Menu: TMenuList;
    PopupMenu: TPopupMenu;
    constructor Create(Owner: TMcpPlugin); override;
    destructor  Destroy; override;
    function  MyVerb(Verb: string): Boolean; override;
    procedure HandleMessage; override;
    procedure Negotiated; override;
    function  NotifyML(ML: PMcpMultiLine; const Key, Value: string): Boolean; override;
    procedure PopulateList(const S: string);

    procedure UpdatePlayer(Nr: Integer; Name: string; Icon, State: Integer; SL: TStringList);
    procedure UpdPlayer(const Value: string);
    function  ParseMenuText(UserNr: Integer; const S: string): string;
    procedure PopupItemClick(Sender: TObject);
    procedure ContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  end;

const
  IconNames: array[0..12] of string = ('','Idle', 'Away', 'Idle+Away', 'Friend', 'Newbie', 'Inhabitant', 'Inhabitant+', 'Schooled', 'Key', 'Star', 'Wizard', 'Moops');

  // User-states
  usRemove    = -1; // remove user
  usUnchanged =  0; // don't change current state-info
  usAdd       =  1; // add user
  usIdle      =  2;
  usUnIdle    =  3;
  usAway      =  4;
  usUnAway    =  5;
  usCloak     =  6;
  usUnCloak   =  7;

function ParseMooLists(var L: TList; S: string): Boolean;
function ParseMooList(var L: TStringList; S: string): Boolean;

implementation

uses
  ClientPage, UpdateCheck, MainFrm;

function ParseMooLists(var L: TList; S: string): Boolean;
var
  I, J: Integer;
  SL: TStringList;
begin
  Result:=False;
  S:=Trim(S);
  if (Length(S)<2) or (S[1]<>'{') or (S[Length(S)]<>'}') then Exit;
  Delete(S,1,1); Delete(S,Length(S),1);
  S:=Trim(S);
  while S<>'' do
  begin
    if (S<>'') and (S[1]='0') then
    begin
      Delete(S,1,1); S:=Trim(S); L.Add(nil);
    end
    else
    begin
      if (Length(S)<2) or (S[1]<>'{') then Exit;
      Delete(S,1,1); S:=Trim(S);
      SL:=TStringList.Create;
      L.Add(SL);
      if S[1]='}' then Delete(S,1,1)
      else
        while True do
        begin
          if S[1]='"' then // string
          begin
            FindQuotedString(S,2,I);
            if I=0 then Exit;
            SL.Add(UnEscape(Copy(S,2,I-2)));
          end (*else if S[1]='#' then // object
          begin
            I:=Pos(',',S)-1; if I=-1 then I:=Length(S)+1;
            J:=Pos('}',S)-1; if J=-1 then J:=Length(S)+1;
            if J<I then I:=J;
            SL.Add(Trim(Copy(S,2,I-1)));
          end*)
          else // number
          begin
            I:=Pos(',',S)-1; if I=-1 then I:=Length(S)+1;
            J:=Pos('}',S)-1; if J=-1 then J:=Length(S)+1;
            if J<I then I:=J;
            SL.Add(Trim(Copy(S,1,I)));
          end;
          Delete(S,1,I); S:=Trim(S);
          if (S<>'') and (S[1]=',') then begin Delete(S,1,1); S:=Trim(S); end;
          if (S<>'') and (S[1]='}') then begin Delete(S,1,1); S:=Trim(S); Break; end;
        end;
    end;
    {Delete(S,1,I); S:=Trim(S);}
    if (S<>'') and (S[1]=',') then begin Delete(S,1,1); S:=Trim(S); end;
  end;
  Result:=True;
end;

function ParseMooList(var L: TStringList; S: string): Boolean;
var
  I: Integer;
begin
  Result:=False;
  if (Length(S)<2) or (S[1]<>'{') or (S[Length(S)]<>'}') then Exit;
  Delete(S,1,1); Delete(S,Length(S),1);
  while Length(S)>0 do
  begin
    if S[1]='"' then // string
    begin
      FindQuotedString(S,2,I);
      if I=0 then Exit;
      L.Add(UnEscape(Copy(S,2,I-2)));
    end (*else if S[1]='#' then // object
    begin
      I:=Pos(',',S)-1; if I=-1 then I:=Length(S)+1;
      L.Add(Trim(Copy(S,2,I-1)));
    end*)
    else // number
    begin
      I:=Pos(',',S)-1; if I=-1 then I:=Length(S)+1;
      L.Add(Trim(Copy(S,1,I)));
    end;
    Delete(S,1,I); S:=Trim(S);
    if (S<>'') and (S[1]=',') then begin Delete(S,1,1); S:=Trim(S); end;
  end;
  Result:=True;
end;

function ObjToInt(S: string): Integer;
begin
  if (S='') or (S[1]<>'#') then raise(Exception.Create('Invalid objectnumber'));
  try
    Delete(S,1,1);
    Result:=StrToInt(S);
  except
    raise(Exception.Create('Invalid objectnumber'));
  end;
end;

procedure TMenuList.GetItem(Index: Integer; var Desc, Cmd: string);
begin
  if Index>=Count then
  begin
    Desc:='';
    Cmd:='';
  end
  else
  begin
    Desc:=PMenuListItem(Items[Index])^.Desc;
    Cmd:=PMenuListItem(Items[Index])^.Cmd;
  end;
end;

procedure TMenuList.Add(Desc, Cmd: string);
var
  I: PMenuListItem;
begin
  GetMem(I,SizeOf(TMenuListItem));
  Initialize(I^);
  I.Desc:=Desc;
  I.Cmd:=Cmd;
  inherited Add(I);
end;

procedure TMenuList.Delete(Index: Integer);
begin
  if Index>=Count then Exit;
  with PMenuListItem(Items[Index])^ do
  begin
    SetLength(Desc,0);
    SetLength(Cmd,0);
  end;
  FreeMem(Items[Index]);
  inherited Delete(Index);
end;

procedure TMenuList.Clear;
begin
  while Count>0 do Delete(0);
end;

destructor TMenuList.Destroy;
begin
  Clear;
  inherited;
end;

function GetVersion(Hi, Lo: Byte): TVersion;
begin
  Result.Hi:=Hi;
  Result.Lo:=Lo;
end;

function StrToVersion(const S: string): TVersion;
var
  P: Integer;
begin
  try
    P:=Pos('.',S); if P=0 then Abort;
    Result:=GetVersion(StrToInt(Copy(S,1,P-1)),StrToInt(Copy(S,P+1,Length(S))));
  except
    Result:=GetVersion(0,0);
  end;
end;

function VerGrEq(Ver1, Ver2: TVersion): Boolean;
begin
  Result:=(Ver1.Hi>Ver2.Hi) or ((Ver1.Hi=Ver2.Hi) and (Ver1.Lo>=Ver2.Lo));
end;

function MinVer(Ver1, Ver2: TVersion): TVersion;
begin
  if Ver1.Hi<Ver2.Hi then
    Result:=Ver1
  else if Ver1.Hi>Ver2.Hi then
    Result:=Ver2
  else if Ver1.Lo<Ver2.Lo then
    Result:=Ver1
  else if Ver1.Lo>Ver2.Lo then
    Result:=Ver2
  else
    Result:=Ver1;
end;

function VerSupported(SrvMax, SrvMin, CltMax, CltMin: TVersion; var Supver: TVersion): Boolean;
begin
  Result:=True;
  if VerGrEq(CltMax,SrvMin) and VerGrEq(SrvMax,CltMin) then
    SupVer:=MinVer(SrvMax,CltMax)
  else
    Result:=False;
end;

constructor TMcpPackage.Create(Owner: TMcpPlugin);
begin
  inherited Create;
  Supported:=False;
  Mcp:=Owner;
  PkgName:='';
end;

function TMcpPackage.NotifyML(ML: PMcpMultiLine; const Key, Value: string): Boolean;
begin
  Result:=False;
end;

procedure TMcpPackage.NotifyMLMessage(ML: PMcpMultiLine);
begin
end;

procedure TMcpPackage.Negotiated;
begin
end;

constructor TMcpNegotiatePkg.Create(Owner: TMcpPlugin);
begin
  inherited Create(Owner);
  MinVersion:=GetVersion(1,0); MaxVersion:=GetVersion(2,0);
  PkgName:='mcp-negotiate';
end;

procedure TMcpNegotiatePkg.HandleMessage;
var
  Pkg: TMcpPackage;
  MaxVer, MinVer: TVersion;
begin
  if Mcp.MsgVerb='can' then
  begin
    if not Mcp.ReqParams(['package','min-version','max-version']) then Exit;
//    Mcp.AddToLog('Package: '+Mcp.MsgParams.Values['package']
//      +' ('+Mcp.MsgParams.Values['min-version']+'-'
//      +Mcp.MsgParams.Values['max-version']+')');
    MaxVer:=StrToVersion(Mcp.MsgParams.Values['max-version']);
    MinVer:=StrToVersion(Mcp.MsgParams.Values['min-version']);
    Pkg:=Mcp.FindPackage(Mcp.MsgParams.Values['package']);
    if Pkg=nil then
      Mcp.Debug(mdError,'Package "'+Mcp.MsgParams.Values['package']+'" not supported')
    else
    begin
      Pkg.Supported:=VerSupported(MaxVer,MinVer,Pkg.MaxVersion,Pkg.MinVersion,Pkg.SupVersion);
      if Pkg.Supported then
      begin
        Pkg.Negotiated;
        Mcp.Debug(mdError,'Package "'+Mcp.MsgParams.Values['package']+'" supported, using version '+IntToStr(Pkg.SupVersion.Hi)+'.'+IntToStr(Pkg.SupVersion.Lo));
      end
      else
        Mcp.Debug(mdError,'Package "'+Mcp.MsgParams.Values['package']+'" not supported');
    end;
  end;
end;

function TMcpNegotiatePkg.MyVerb(Verb: string): Boolean;
begin
  Result:=(Verb='can') or (Verb='end');
end;

constructor TMcpStatusPkg.Create(Owner: TMcpPlugin);
begin
  inherited Create(Owner);
  MinVersion:=GetVersion(1,0); MaxVersion:=GetVersion(1,1);
  PkgName:='dns-net-beryllium-status';
  TrayWidth:=0;
  BlinkOn:=False;
  Icons:=TList.Create;
  CustomImages:=TImageList.Create(Mcp.CPage);
  PopupMenu:=TPopupMenu.Create(Mcp.CPage);
end;

procedure TMcpStatusPkg.ClearIcons;
begin
{ TODO -oMartin -cMcpStatus : Icons in 1 hap destroyen }
  while Icons.Count>0 do FreeIcon(0);
end;

destructor TMcpStatusPkg.Destroy;
begin
  ClearIcons;
  CustomImages.Free;
  PopupMenu.Free;
  Icons.Free;
  inherited;
end;

procedure TMcpStatusPkg.UpdateIcon(Index: Integer);
var
  I: Integer;
  Icon: PIconInfo;
  L: TList;
begin
  if (Index<0) or (Index>Icons.Count-1) then Exit;
  Icon:=Icons[Index];
  try
    if Mcp.MsgParams.IndexOfName('width')>-1 then
    begin
      Icon.Width:=StrToInt(Mcp.MsgParams.Values['width']);
      if Icon.Width<16 then Icon.Width:=16;
      if Icon.Width>32 then Icon.WIdth:=32;
    end;

    if Mcp.MsgParams.IndexOfName('hint')>-1 then
      Icon.Hint:=Mcp.MsgParams.Values['hint'];

    if Mcp.MsgParams.IndexOfName('cmd')>-1 then
      Icon.Cmd0:=Mcp.MsgParams.Values['cmd'];

    if Mcp.MsgParams.IndexOfName('cmd0')>-1 then
      Icon.Cmd0:=Mcp.MsgParams.Values['cmd0'];

    if Mcp.MsgParams.IndexOfName('cmd1')>-1 then
      Icon.Cmd1:=Mcp.MsgParams.Values['cmd1'];

    if Mcp.MsgParams.IndexOfName('img0')>-1 then
    begin
      Icon.OnIcon:=StrToInt(Mcp.MsgParams.Values['img0']);
      if (Icon.OnIcon<=-MainForm.TrayImages.Count)
        or (Icon.OnIcon>=CustomImages.Count) then Icon.OnIcon:=0;
    end;

    if Mcp.MsgParams.IndexOfName('img')>-1 then
    begin
      Icon.OnIcon:=StrToInt(Mcp.MsgParams.Values['img']);
      if (Icon.OnIcon<=-MainForm.TrayImages.Count)
        or (Icon.OnIcon>=CustomImages.Count) then Icon.OnIcon:=0;
    end;

    if Mcp.MsgParams.IndexOfName('img1')>-1 then
    begin
      Icon.OffIcon:=StrToInt(Mcp.MsgParams.Values['img1']);
      if (Icon.OffIcon<=-MainForm.TrayImages.Count)
        or (Icon.OffIcon>=CustomImages.Count) then Icon.OffIcon:=0;
    end;

    if Mcp.MsgParams.IndexOfName('menu')>-1 then
    begin
      Icon.Menu.Clear;
      L:=TList.Create;
      try
        if not ParseMooLists(L,Mcp.MsgParams.Values['menu']) then Abort;
        for I:=0 to L.Count-1 do
          if L[I]=nil then
            Icon.Menu.Add('-','')
          else
            with TStringList(L[I]) do
              if Count=2 then
                Icon.Menu.Add(Strings[0],Strings[1]);
      finally
        for I:=0 to L.Count-1 do
          TStringList(L[I]).Free;
        L.Free;
      end;
    end;

    if Mcp.MsgParams.IndexOfName('mode')>-1 then
    begin
      I:=Mcp.StrToOrd(Mcp.MsgParams.Values['mode'],['normal','inv','blink','on','off']);
      if I=-1 then I:=0;
      Icon.Mode:=TIconMode(I);
    end;
  except
    Mcp.Debug(mdError,'Invalid arguments in UpdateIcon');
  end;
  UpdateIcons;
end;

procedure TMcpStatusPkg.HandleMessage;
var
  I: Integer;
  T, C: string;
  Ready: Boolean;
begin
  if Mcp.MsgVerb='ico_add' then
  begin
    if not Mcp.ReqParams(['mode','img0']) then Exit;
    if AddIcon=nil then Exit;
    UpdateIcon(Icons.Count-1);
  end
  else if Mcp.MsgVerb='ico_del' then
  begin
    if not Mcp.ReqParams(['index']) then Exit;
    try
      FreeIcon(StrToInt(Mcp.MsgParams.Values['index']));
    except
    end;
  end
  else if Mcp.MsgVerb='ico_upd' then
  begin
    if not Mcp.ReqParams(['index']) then Exit;
    try
      UpdateIcon(StrToInt(Mcp.MsgParams.Values['index']));
    except
    end;
  end
  else if Mcp.MsgVerb='ico_clr' then
    ClearIcons
  else if Mcp.MsgVerb='msg_add' then
  begin
    if not Mcp.ReqParams(['text','cmd','cache']) then Exit;
    repeat
      Ready:=True;
      I:=Mcp.MsgParams.IndexOf('text');
      if I>=0 then
      begin
        Ready:=False;
        T:=Mcp.MsgParams[I];
        Mcp.MsgParams.Delete(I);
        I:=Mcp.MsgParams.IndexOf('cmd');
        if I<0 then
          C:=''
        else
        begin
          C:=Mcp.MsgParams[I];
          Mcp.MsgParams.Delete(I);
        end;
        TNetClientPage(MCP.CPage).StatusMan.AddMooTip(T+#254+C)
      end;
    until Ready;
  end
  else if Mcp.MsgVerb='msg_clear' then
  begin
    TNetClientPage(MCP.CPage).StatusMan.MooTips.Clear;
  end
  else if Mcp.MsgVerb='msg_force' then
  begin
    if not Mcp.ReqParams(['text','cmd']) then Exit;
    TNetClientPage(MCP.CPage).StatusMan.SetStatus(Mcp.MsgParams.Values['text']+#254+Mcp.MsgParams.Values['cmd'],40,MooTip);
    TNetClientPage(MCP.CPage).StatusChanged;
  end;
end;

function TMcpStatusPkg.MyVerb(Verb: string): Boolean;
begin
  Result:=(Verb='msg_add') or (Verb='msg_force') or (Verb='msg_clear')
    or (Verb='ico_add') or (Verb='ico_del') or (Verb='ico_upd') or (Verb='ico_clr');
end;

procedure TMcpStatusPkg.BlinkIcons(BlinkOn: Boolean);
var
  I: Integer;
begin
  for I:=0 to Icons.Count-1 do
    with PIconInfo(Icons[I])^ do
      if Mode=imBlink then
      begin
        if BlinkOn then Icon:=OnIcon else Icon:=OffIcon;
        DrawIcon(I);
      end;
end;

procedure TMcpStatusPkg.UpdateIcons;
var
  I, W: Integer;
begin
  W:=0;
  for I:=0 to Icons.Count-1 do
    with PIconInfo(Icons[I])^ do
    begin
      Left:=W; if Mode<>imHidden then Inc(W,Width);
      if (Mode=imNormal) or (Mode=imOn) then Icon:=OnIcon;
      if Mode=imOff then Icon:=OffIcon;
      if (Mode=imBlink) and (Icon<>OnIcon) and (Icon<>OffIcon) then Icon:=OnIcon;
    end;
  TrayWidth:=W;
  MainForm.StatusResized;
end;

function TMcpStatusPkg.Pos2Icon(X, Y: Integer): Integer;
var
  I: Integer;
begin
  for I:=0 to Icons.Count-1 do
    with PIconInfo(Icons[I])^ do
      if (Mode<>imHidden) and (X>=Left) and (X<=Left+16) then begin Result:=I; Exit; end;
  Result:=-1;
end;

procedure TMcpStatusPkg.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  Cmd: string;
  Icon: PIconInfo;
begin
  I:=Pos2Icon(X,Y);
  if I=-1 then Exit;

  if (Button=mbLeft) or (Button=mbMiddle) then
  begin
    Icon:=Icons[I];
    if Icon.Mode=imOn then
    begin
      Cmd:=Icon.Cmd1; Icon.Mode:=imOff; Icon.Icon:=Icon.OffIcon; DrawIcon(I);
    end
    else if Icon.Mode=imOff then
    begin
      Cmd:=Icon.Cmd0; Icon.Mode:=imOn; Icon.Icon:=Icon.OnIcon; DrawIcon(I);
    end
    else
      Cmd:=Icon.Cmd0;
    Mcp.SendMcp(PkgName+'-ico_exec','index: '+IntToStr(I)+' cmd: "'+EnQuote(Cmd)+'"');
    MainForm.ActivatePage(TClientPage(MCP.CPage));
  end
  else
    ContextPopup(I,Point(X,Y));
end;

procedure TMcpStatusPkg.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  P: TPoint;
  S: string;
begin
  I:=Pos2Icon(X,Y);
  if I=-1 then S:=''
  else S:=PIconInfo(Icons[I])^.Hint;

  if MainForm.TrayBox.Hint<>S then
  begin
    MainForm.TrayBox.Hint:=S;
    if S='' then
      Application.HideHint
    else
    begin
      P:=MainForm.ClientToScreen(Point(X,3));
      Application.ActivateHint(P);
    end;
  end;
end;

procedure TMcpStatusPkg.FreeIcon(Nr: Integer);
var
  Icon: PIconInfo;
begin
  if (Nr<0) or (Nr>=Icons.Count) then Exit;
  Icon:=Icons[Nr];
  Icons.Delete(Nr);
  SetLength(Icon.Hint,0);
  SetLength(Icon.Cmd0,0);
  SetLength(Icon.Cmd1,0);
  Icon.Menu.Free;
  FreeMem(Icon);
  UpdateIcons;
end;

function TMcpStatusPkg.AddIcon: PIconInfo;
begin
  // maximum of 20 icons/moo
  if Icons.Count=20 then begin Result:=nil; Exit; end;
  GetMem(Result,SizeOf(TIconInfo));
  Initialize(Result^);
  Result.Menu:=TMenuList.Create;
  Result.Width:=16;
  Icons.Add(Result);
end;

procedure TMcpStatusPkg.DrawIcon(Nr: Integer);
var
  R: TRect;
begin
  if (Nr<0) or (Nr>=Icons.Count) then Exit;
  with PIconInfo(Icons[Nr])^ do
  begin
    R.Left:=PIconInfo(Icons[Nr]).Left+1;
    R.Top:=1;
    R.Right:=R.Left+16;
    R.Bottom:=R.Top+16;
    MainForm.TrayBox.Canvas.FillRect(R);
    if Icon<=0 then
      MainForm.TrayImages.Draw(MainForm.TrayBox.Canvas,R.Left,R.Top,-Icon)
    else
      MainForm.TrayImages.Draw(MainForm.TrayBox.Canvas,R.Left,R.Top,Icon);
  end;
end;

procedure TMcpStatusPkg.PaintIcons;
var
  I: Integer;
begin
  for I:=0 to Icons.Count-1 do DrawIcon(I);
end;

procedure TMcpStatusPkg.Negotiated;
begin
  TMcpAwnsStatusPkg(Mcp.FindPackage('dns-com-awns-status')).Disabled:=True;
  Mcp.Debug(mdError,'Package "dns-com-awns-status" disabled.');
  Mcp.SendMcp('dns-net-beryllium-status-msg_get','type: update from: '
    +IntToStr(TNetClientPage(MCP.CPage).StatusMan.MooTips.Count));
end;

procedure TMcpStatusPkg.PopupItemClick(Sender: TObject);
var
  Desc, Cmd: string;
begin
  try
    PIconInfo(Icons[TComponent(Sender).Tag]).Menu.GetItem(TMenuItem(Sender).MenuIndex,Desc,Cmd);
    MainForm.ActivatePage(TClientPage(MCP.CPage));
    Mcp.SendMcp(PkgName+'-ico_exec','index: '+IntToStr(TComponent(Sender).Tag)+' cmd: "'+EnQuote(Cmd)+'"');
  except
  end;
end;

procedure TMcpStatusPkg.ContextPopup(Index: Integer; MousePos: TPoint);
var
  Icon: PIconInfo;
  I: Integer;
  Item: TMenuItem;
  Desc, Cmd: string;
begin
  if (Index<0) or (Index>=Icons.Count) then Exit;
  Icon:=Icons[Index];
  if Icon.Menu.Count=0 then Exit;
  try
    PopupMenu.Free;
    PopupMenu:=TPopupMenu.Create(Mcp.CPage);
    for I:=0 to Icon.Menu.Count-1 do
    begin
      Item:=TMenuItem.Create(PopupMenu);
      Icon.Menu.GetItem(I,Desc,Cmd);
      Item.Tag:=Index;
      Item.Caption:=Desc;
      if Item.Caption<>'-' then Item.OnClick:=PopupItemClick;
      PopupMenu.Items.Add(Item)
    end;
    MousePos:=MainForm.TrayBox.ClientToScreen(MousePos);
    PopupMenu.Popup(MousePos.X,MousePos.Y);
  except
  end;
end;

constructor TMcpVmooClientPkg.Create(Owner: TMcpPlugin);
begin
  inherited Create(Owner);
  MinVersion:=GetVersion(1,0); MaxVersion:=GetVersion(1,0);
  PkgName:='dns-com-vmoo-client';
end;

function TMcpVmooClientPkg.MyVerb(Verb: string): Boolean;
begin
  Result:=Verb='disconnect';
end;

procedure TMcpVmooClientPkg.UpdateLineLength(ALen, AHeight: Integer);
begin
  if (Len=ALen) and (Height=AHeight) then Exit;
  Len:=ALen;
  Height:=AHeight;
  if Supported then Mcp.SendMcp(PkgName+'-screensize','cols: '+IntToStr(Len)+' rows: '+IntToStr(Height));
end;

procedure TMcpVmooClientPkg.HandleMessage;
begin
end;

procedure TMcpVmooClientPkg.Negotiated;
  function StripVersion(const S: string): string;
  var
    P: Integer;
  begin
    Result:=S;
    repeat
      P:=Pos('.',Result);
      if P>0 then Delete(Result,P,1);
    until P=0;
  end;
var
  I: Integer;
begin
  Mcp.SendMcp(PkgName+'-info',
    'name: "Moops!" '+
    'text-version: "'+UpdChecker.ThisVersion+'" '+
    'internal-version: "'+StripVersion(UpdChecker.ThisVersion)+'" '+
    'reg-id: 0 '+// "'+UpdChecker.MoopsID+'" '+
    'flags: lm' // Links, Moops Links.  Don't send p, since we're not using a proxy.
  );
  I:=Height; Height:=-1;
  UpdateLineLength(Len,I);
end;

constructor TMcpVmooUserlistPkg.Create(Owner: TMcpPlugin);
var
  I: Integer;
begin
  inherited Create(Owner);
  MinVersion:=GetVersion(1,0); MaxVersion:=GetVersion(1,1);
  PkgName:='dns-com-vmoo-userlist';
  for I:=Low(IconMapping) to High(IconMapping) do IconMapping[I]:=I;
  Users:=TList.Create;
  Menu:=TMenuList.Create;
  PopupMenu:=TPopupMenu.Create(Mcp.CPage);
end;

destructor TMcpVmooUserlistPkg.Destroy;
begin
  while Users.Count>0 do
  begin
    FreeMem(Users[0]); Users.Delete(0);
  end;
  Users.Free;
  Menu.Free;
  PopupMenu.Free;
  inherited Destroy;
end;

function TMcpVmooUserlistPkg.MyVerb(Verb: string): Boolean;
begin
  Result:=(Verb='') or (Verb='friends') or (Verb='gaglist') or (Verb='icon-url') or (Verb='menu') or (Verb='you');
end;

procedure TMcpVmooUserlistPkg.HandleMessage;
var
  L: TList;
  I: Integer;
begin
  if Mcp.MsgVerb='menu' then
  begin
    if not Mcp.ReqParams(['menu']) then Exit;
    Menu.Clear;
    L:=TList.Create;
    try
      if not ParseMooLists(L,Mcp.MsgParams.Values['menu']) then Abort;
      for I:=0 to L.Count-1 do
        if L[I]=nil then
          Menu.Add('-','')
        else
          with TStringList(L[I]) do
            if Count=2 then
              Menu.Add(Strings[0],Strings[1]);
    finally
      for I:=0 to L.Count-1 do
        TStringList(L[I]).Free;
      L.Free;
    end;
  end;
  if Mcp.MsgVerb='icon-url' then
  begin
    if not Mcp.ReqParams(['url']) then Exit;
  end;
end;

procedure TMcpVmooUserlistPkg.Negotiated;
begin
  UList:=TNetClientPage(Mcp.CPage).UList;
  TNetClientPage(Mcp.CPage).ShowUserList;
end;

procedure TMcpVmooUserlistPkg.PopulateList(const S: string);
var
  L: TList;
  I: Integer;
begin
  L:=TList.Create;
  try
    if not ParseMooLists(L,S) then Abort;

    while Users.Count>0 do
    begin
      SetLength(PUserInfo(Users[0]).Name,0);
      PUserInfo(Users[0]).Values.Free;
      FreeMem(Users[0]); Users.Delete(0);
    end;
    UList.Items.Clear;
    for I:=0 to L.Count-1 do
      with TStringList(L[I]) do
        if Count>2 then
          UpdatePlayer(ObjToInt(Strings[0]),Strings[1],StrToInt(Strings[2]),usAdd,L[I]);
  finally
    for I:=0 to L.Count-1 do
      TStringList(L[I]).Free;
    L.Free;
  end;
end;

function TMcpVmooUserlistPkg.ParseMenuText(UserNr: Integer; const S: string): string;
var
  I, J, P: Integer;
  User: PUserInfo;
  Tmp: string;
begin
  User:=nil;
  for I:=0 to Users.Count-1 do
    if PUserInfo(Users[I]).Nr=UserNr then begin User:=Users[I]; Break; end;
  if User=nil then Exit;
  I:=1;
  Result:=S;
  while I<Length(Result)-2 do
    if Copy(Result,I,2)='$(' then
    begin
      P:=0;
      for J:=I+2 to Length(Result) do if Result[J]=')' then begin P:=J; Break; end;
      if P>0 then
      begin
        if Copy(Result,I+2,J-I-2)='n' then
        begin
          Result:=Copy(Result,1,I-1)+#13#10+Copy(Result,J+1,Length(Result));
          Inc(I,2);
        end
        else
          try
            Tmp:=User.Values[StrToInt(Copy(Result,I+2,J-I-2))-1];
            Result:=Copy(Result,1,I-1)+Tmp+Copy(Result,J+1,Length(Result));
            Inc(I,Length(Tmp));
          except
            Inc(I,2);
          end;
      end
      else Inc(I,2);
    end
    else Inc(I);
end;

procedure TMcpVmooUserlistPkg.PopupItemClick(Sender: TObject);
var
  Desc, Cmd: string;
begin
  Menu.GetItem(TMenuItem(Sender).MenuIndex,Desc,Cmd);
  Mcp.CPage.SendLine(ParseMenuText(TComponent(Sender).Tag,Cmd));
end;

procedure TMcpVmooUserlistPkg.ContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  User: PUserInfo;
  I: Integer;
  Item: TMenuItem;
  Desc, Cmd: string;
begin
  if (Menu.Count=0) or (UList.Selected=nil) then Exit;
  User:=nil;
  for I:=0 to Users.Count-1 do
    if PUserInfo(Users[I]).Nr=Integer(UList.Selected.Data) then begin User:=Users[I]; Break; end;
  if User=nil then Exit;
  try
    PopupMenu.Free;
    PopupMenu:=TPopupMenu.Create(Mcp.CPage);
    for I:=0 to Menu.Count-1 do
    begin
      Item:=TMenuItem.Create(PopupMenu);
      Menu.GetItem(I,Desc,Cmd);
      Item.Tag:=Integer(UList.Selected.Data);
      Item.Caption:=ParseMenuText(Item.Tag,Desc);
      if Item.Caption<>'-' then Item.OnClick:=PopupItemClick;
      PopupMenu.Items.Add(Item)
    end;
    MousePos:=UList.ClientToScreen(MousePos);
    PopupMenu.Popup(MousePos.X,MousePos.Y);
    Handled:=True;
  except
  end;
end;

procedure TMcpVmooUserlistPkg.UpdatePlayer(Nr: Integer; Name: string; Icon, State: Integer; SL: TStringList);
var
  I: Integer;
  User: PUserInfo;
  Item: TListItem;
  function GetImageIndex: Integer;
  begin
    if User.Away then
      if User.Idle then
        Result:=3
      else
        Result:=2
    else if User.Idle then
      Result:=1
    else
    begin
      Result:=User.Icon;
      if Result<0 then Result:=0;
      if Result>12 then Result:=0;
      Result:=IconMapping[Result];
    end;
  end;
begin
  User:=nil;
  for I:=0 to Users.Count-1 do
    if PUserInfo(Users[I]).Nr=Nr then begin User:=Users[I]; Break; end;
  if User=nil then
    if State<>usAdd then Exit
    else
    begin
      GetMem(User,SizeOf(TUserInfo));
      Initialize(User.Name);
      User.Name:=Name;
      User.Nr:=Nr;
      User.Icon:=Icon;
      User.Idle:=State=usIdle;
      User.Away:=State=usAway;
      User.Cloak:=State=usCloak;
      User.Values:=TStringList.Create;
      if SL<>nil then User.Values.AddStrings(SL);
      Users.Add(User);
      if not User.Cloak then
        with UList.Items.Add do
        begin
          Caption:=User.Name+' (#'+IntToStr(User.Nr)+')';
          ImageIndex:=GetImageIndex;
          Data:=Pointer(User.Nr);
        end;
      Exit;
    end;
  Item:=nil;
  for I:=0 to UList.Items.Count-1 do
    if Integer(UList.Items[I].Data)=User.Nr then begin Item:=UList.Items[I]; Break; end;
  if State=usRemove then
  begin
    if Item<>nil then Item.Free;
    Users.Remove(User);
    User.Values.Free;
    SetLength(User.Name,0);
    FreeMem(User);
    Exit;
  end;
  // update existing user
  if Name<>'' then User.Name:=Name;
  if Icon>-1 then User.Icon:=Icon;
  case State of
    usIdle:    User.Idle:=True;
    usUnIdle:  User.Idle:=False;
    usAway:    User.Away:=True;
    usUnAway:  User.Away:=False;
    usCloak:   User.Cloak:=True;
    usUnCloak: User.Cloak:=False;
  end;
  if User.Cloak then
  begin
    if Item<>nil then Item.Free;
    Exit;
  end;
  I:=GetImageIndex;
  if Item=nil then
    with UList.Items.Add do
    begin
      Caption:=User.Name+' (#'+IntToStr(User.Nr)+')';
      ImageIndex:=GetImageIndex;
      Data:=Pointer(User.Nr);
    end
  else
  begin
    if I<>Item.ImageIndex then Item.ImageIndex:=I;
    if User.Name+' (#'+IntToStr(User.Nr)+')'<>Item.Caption then Item.Caption:=User.Name+' (#'+IntToStr(User.Nr)+')';
  end;
  if SL<>nil then User.Values.AddStrings(SL);
end;

procedure TMcpVmooUserlistPkg.UpdPlayer(const Value: string);
var
  SL: TStringList;
  I:  Integer;
begin
  if Length(Value)<3 then Exit;
  SL:=TStringList.Create;
  try
    if not ParseMooList(SL,Copy(Value,2,Length(Value))) then Abort;
    case Value[1] of
      '+': UpdatePlayer(ObjToInt(SL[0]),SL[1],StrToInt(SL[2]),usAdd,SL);
      '*': UpdatePlayer(ObjToInt(SL[0]),SL[1],StrToInt(SL[2]),usUnchanged,SL);
      '-': for I:=0 to SL.Count-1 do UpdatePlayer(ObjToInt(SL[I]),'',-1,usRemove,nil);
      '<': for I:=0 to SL.Count-1 do UpdatePlayer(ObjToInt(SL[I]),'',-1,usIdle,nil);
      '>': for I:=0 to SL.Count-1 do UpdatePlayer(ObjToInt(SL[I]),'',-1,usUnIdle,nil);
      '[': for I:=0 to SL.Count-1 do UpdatePlayer(ObjToInt(SL[I]),'',-1,usAway,nil);
      ']': for I:=0 to SL.Count-1 do UpdatePlayer(ObjToInt(SL[I]),'',-1,usUnAway,nil);
      '(': for I:=0 to SL.Count-1 do UpdatePlayer(ObjToInt(SL[I]),'',-1,usCloak,nil);
      ')': for I:=0 to SL.Count-1 do UpdatePlayer(ObjToInt(SL[I]),'',-1,usUnCloak,nil);
    end;
  finally
    SL.Free;
  end;
end;

function ItemSortFunc(Item1, Item2: TListItem; ParamSort: Integer): Integer; stdcall;
var
  I1, I2: Integer;
begin
  I1:=Item1.ImageIndex; if I1>3 then I1:=0;
  I2:=Item2.ImageIndex; if I2>3 then I2:=0;
  if I1=1 then I1:=2 else if I1=2 then I1:=1;
  if I2=1 then I2:=2 else if I2=2 then I2:=1;
  if I1>I2 then Result:=1
  else if I1=I2 then Result:=0
  else Result:=-1;
end;

function TMcpVmooUserlistPkg.NotifyML(ML: PMcpMultiLine; const Key, Value: string): Boolean;
var
  SL: TStringList;
  I, J: Integer;
begin
  Result:=True;
  if Key='d' then
  begin
    if Length(Value)<3 then Exit;
    UList.Items.BeginUpdate;
    try
      if Value[1]='=' then PopulateList(Copy(Value,2,Length(Value)))
      else UpdPlayer(Value);
    except
    end;
    UList.CustomSort(@ItemSortFunc,0);
    UList.Items.EndUpdate;
  end
  else if Key='fields' then
  begin
    // Do nothing
{    SL:=TStringList.Create; if not ParseMooList(SL,Value) then Exit;
    UList.Columns.BeginUpdate;
    UList.Columns.Clear;
    for I:=0 to SL.Count-1 do
      with UList.Columns.Add do
      begin
        Caption:=SL[I];
        AutoSize:=True;
        MinWidth:=16;
      end;
    SL.Free;
    UList.Columns.EndUpdate;}
  end
  else if Key='icons' then
  begin
    SL:=TStringList.Create; SL.Add('');
    if ParseMooList(SL,Value) then
      for I:=1 to SL.Count-1 do
        if I>High(IconMapping) then Break
        else
        begin
          IconMapping[I]:=0;
          for J:=Low(IconNames) to High(IconNames) do
            if IconNames[J]=SL[I] then begin IconMapping[I]:=J; Break; end;
        end;
    SL.Free;
  end;
end;

constructor TMcpAwnsStatusPkg.Create(Owner: TMcpPlugin);
begin
  inherited Create(Owner);
  MinVersion:=GetVersion(1,0); MaxVersion:=GetVersion(1,0);
  PkgName:='dns-com-awns-status';
  Disabled:=False;
end;

procedure TMcpAwnsStatusPkg.HandleMessage;
begin
  if Disabled then Exit;
  if not Mcp.ReqParams(['text']) then Exit;
  TNetClientPage(MCP.CPage).StatusMan.SetStatus(Mcp.MsgParams.Values['text'],50,MooTip);
  TNetClientPage(MCP.CPage).StatusChanged;
end;

function TMcpAwnsStatusPkg.MyVerb(Verb: string): Boolean;
begin
  Result:=True;
end;

constructor TMcpEditPkg.Create(Owner: TMcpPlugin);
begin
  inherited Create(Owner);
  MinVersion:=GetVersion(1,0); MaxVersion:=GetVersion(1,0);
  PkgName:='dns-net-beryllium-edit';
end;

procedure TMcpEditPkg.Negotiated;
begin
  FreePlugin(TNetClientPage(Mcp.CPage).Plugins,'TSimpleEditPlugin')
end;

procedure TMcpEditPkg.Load(const ObjName, ObjType: string);
begin
  if Supported then
    Mcp.SendMcp('dns-net-beryllium-edit-open','name: "'+ObjName+'" type: "'+ObjType+'"')
  else
    if ObjType='verb' then
      Mcp.SendLine('@edit '+ObjName)
    else
      Mcp.SendLine('@notedit '+ObjName);
end;

function TMcpEditPkg.SaveLines(CEPage: TClientPageBase): Boolean;
var
  I: Integer;
  MLTag: string;
begin
  Result:=False;
  with TEditClientPage(CEPage) do
  begin
    SetStatus('Saving...');
    if Supported then // Send through multilines
    begin
      MLTag:=Mcp.NewMultiLine;
      Mcp.SendMcp('dns-net-beryllium-edit-save','name: "'+FileName+'" type: "'+TextType+'" contents*: "" _data-tag: "'+MLTag+'"');
      for I:=0 to EditWin.Lines.Count-1 do
        Mcp.SendMcpML(MLTag,'contents: '+EditWin.Lines[I]);
      Mcp.SendMcpMLEnd(MLTag);
      SetStatus('Sent lines, waiting for reply...');
    end
    else
    begin
      if UploadCmd='' then begin CommanderMsg('> Can''t save to this server, don''t know the upload-command :('); Exit; end;
      Mcp.SendLine(UploadCmd);
      for I:=0 to EditWin.Lines.Count-1 do
        if EditWin.Lines[I]='.' then
          Mcp.SendLine('. ')
        else
          Mcp.SendLine(EditWin.Lines[I]);
      Mcp.SendLine('.');
      SetStatus('Ready');
      if CloseAfterSave then Close;
    end;
  end;
  Result:=True;
end;

function TMcpEditPkg.NotifyML(ML: PMcpMultiLine; const Key, Value: string): Boolean;
begin
  Result:=True;
  if Key='contents' then
    if Assigned(ML.MsgData) then
      if not FirstLine then
        TEditClientPage(ML.MsgData).EditWin.Lines.Add(Value)
      else
      begin
        FirstLine:=False;
        TEditClientPage(ML.MsgData).EditWin.Lines[0]:=Value;
      end;
end;

procedure TMcpEditPkg.NotifyMLMessage(ML: PMcpMultiLine);
begin
  if Mcp.MsgVerb='open' then
  begin
    if not Mcp.ReqParams(['name','type']) then Exit;
    if LowerCase(Mcp.MsgParams.Values['type'])='error' then Exit;
    if ML.MultiParams.IndexOf('contents')=-1 then Exit;
    ML.MsgData:=TNetClientPage(Mcp.CPage).OpenEditor(Mcp.MsgParams.Values['name']);
    FirstLine:=True;
    with TEditClientPage(ML.MsgData) do
    begin
      TextType:=LowerCase(Mcp.MsgParams.Values['type']);
      InitLoading(Mcp.MsgParams.Values['name']);
      if TextType='verb' then
        EditWin.HighLighter:=mwMooHighLighter;
    end;
  end;
end;

procedure TMcpEditPkg.HandleMessage;
begin
  if not Mcp.ReqParams(['name','type']) then Exit;
  if LowerCase(Mcp.MsgParams.Values['type'])='error' then
  begin
    TNetClientPage(Mcp.CPage).CommanderMsg('Couldn''t load '+Mcp.MsgParams.Values['name']+' ('+Mcp.MsgParams.Values['reason']+')');
  end
  else
    TEditClientPage(Mcp.MsgData).FinishLoading;
end;

function TMcpEditPkg.MyVerb(Verb: string): Boolean;
begin
  Result:=Verb='open';
end;

constructor TMcpClientPkg.Create(Owner: TMcpPlugin);
begin
  inherited Create(Owner);
  MinVersion:=GetVersion(1,0); MaxVersion:=GetVersion(1,0);
  PkgName:='dns-net-beryllium-client';
end;

function TMcpClientPkg.MyVerb(Verb: string): Boolean;
begin
  Result:=False;
//  Result:=(Verb='can') or (Verb='');
end;

(*procedure mcClient(Mcp: TMcpPlugin);
begin
  if Mcp.MsgVerb='wrapon' then
    Inc(Mcp.CPage.ChatView.WordWrap)
  else if Mcp.MsgVerb='wrapoff' then
    Dec(Mcp.CPage.ChatView.WordWrap)
  else if Mcp.MsgVerb='followon' then
    Mcp.CPage.ChatView.ClientFollow:=cfOn
  else if Mcp.MsgVerb='followoff' then
    Mcp.CPage.ChatView.ClientFollow:=cfOff
  else if Mcp.MsgVerb='followauto' then
    Mcp.CPage.ChatView.ClientFollow:=cfAuto
  else if Mcp.MsgVerb='setcolor' then
  begin
    if not Mcp.ReqParams(['fg','bg']) then Exit;
    Mcp.CPage.ChatView.DoColor(StrToInt(Mcp.MsgParams.Values['fg']),StrToInt(Mcp.MsgParams.Values['bg']));
  end;
end;*)

constructor TMcpPlugin.Create(Page: TClientPageBase);
begin
  inherited Create(Page);
  DebugMode:=mdOff;
  McpMode:=mcpUnknown;
  AuthKey:='';
  MsgParams:=TStringList.Create;
  Packages:=TList.Create;
  AddPkg(TMcpEditPkg);
  AddPkg(TMcpNegotiatePkg);
  AddPkg(TMcpEditPkg);
  AddPkg(TMcpSimpleEdit);
  AddPkg(TMcpAwnsStatusPkg);
  AddPkg(TMcpStatusPkg);
  AddPkg(TMcpVmooClientPkg);
  AddPkg(TMcpVmooUserlistPkg);
  Priority:=ppMcp;
  MultiLines:=TList.Create;
  LocalTags:=TStringList.Create;
  PluginName:='Mcp';
end;

procedure TMcpPlugin.StartMcpSession;
var
  CurVer: TVersion;
begin
{ TODO -omartin -cmcp : better compliance with standard }
  if not ReqParams(['version','to']) then Exit;
  if not VerSupported(
           StrToVersion(MsgParams.Values['to']),
           StrToVersion(MsgParams.Values['version']),
           GetVersion(2,1),GetVersion(2,1),CurVer) then
  begin
    Debug(mdVerbose,'Versions do not match');
    Exit;
  end;
  AuthKey:=GetRandomTag;
//  AuthKey:='1234';
  SendLineDirect('#$#mcp authentication-key: '+AuthKey+' version: 2.1 to: 2.1');
  if DebugMode=mdVerbose then
    Debug(mdVerbose,'> (#$#mcp authentication-key: '+AuthKey+' version: 2.1 to: 2.1)');
  McpMode:=mcpYes;
  SendMcp('mcp-negotiate-can','package: mcp-negotiate min-version: 1.0 max-version: 2.0');
  SendMcp('mcp-negotiate-can','package: dns-com-awns-status min-version: 1.0 max-version: 1.0');
//  if DebugMode=mdVerbose then
//  begin
    SendMcp('mcp-negotiate-can','package: dns-net-beryllium-status min-version: 1.0 max-version: 1.0');
    SendMcp('mcp-negotiate-can','package: dns-com-vmoo-client min-version: 1.0 max-version: 1.0');
    SendMcp('mcp-negotiate-can','package: dns-com-vmoo-userlist min-version: 1.0 max-version: 1.1');
//    SendMcp('mcp-negotiate-can','package: dns-org-mud-moo-simpleedit min-version: 1.0 max-version: 1.0');
  //SendMcp('mcp-negotiate-can','package: dns-net-beryllium-client min-version: 1.0 max-version: 1.0');
//  end;
//  SendMcp('mcp-negotiate-can','package: dns-net-beryllium-userlist min-version: 1.0 max-version: 1.0');
//  if DebugMode<>mdVerbose then
//    SendMcp('mcp-negotiate-can','package: dns-net-beryllium-client min-version: 1.0 max-version: 1.0');
//  SendMcp('mcp-negotiate-can','package: dns-net-beryllium-client min-version: 1.0 max-version: 1.0');
//  SendMcp('mcp-negotiate-can','package: dns-net-beryllium-edit min-version: 1.0 max-version: 1.0');
  SendMcp('mcp-negotiate-end','');
end;

procedure TMcpPlugin.AddPkg(PkgClass: TMcpPackageClass);
begin
  Packages.Add(PkgClass.Create(Self));
end;

destructor TMcpPlugin.Destroy;
var
  I: Integer;
begin
  for I:=MultiLines.Count-1 downto 0 do
    FreeMultiLine(I);
  MultiLines.Free;
  while Packages.Count>0 do
  begin
    TMcpPackage(Packages[0]).Free;
    Packages.Delete(0);
  end;
  Packages.Free;
  MsgParams.Free;
  LocalTags.Free;
  inherited Destroy;
end;

function TMcpPlugin.GetRandomTag: string;
var
  B: Byte;
const
  TagString = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxys0123456789-~`!@#$%^&()=+{}[]|'';?/><.,';
begin
  Randomize;
  Result:='';
  while Length(Result)<6 do
  begin
    B:=Random(Length(TagString))+1;
    Result:=Result+TagString[B];
  end;
end;

function TMcpPlugin.NewMultiLine: string;
begin
  repeat
    Result:=GetRandomTag;
  until LocalTags.IndexOf(Result)=-1;
  LocalTags.Add(Result);
end;

procedure TMcpPlugin.ReleaseMultiLine(Tag: string);
var
  I: Integer;
begin
  I:=LocalTags.IndexOf(Tag);
  if I>-1 then LocalTags.Delete(I);
end;

procedure TMcpPlugin.FreeMultiLine(Index: Integer);
begin
  SetLength(PMcpMultiLine(MultiLines[Index]).Tag,0);
  SetLength(PMcpMultiLine(MultiLines[Index]).MsgVerb,0);
  SetLength(PMcpMultiLine(MultiLines[Index]).MsgPkg,0);
  PMcpMultiLine(MultiLines[Index]).MsgParams.Free;
  PMcpMultiLine(MultiLines[Index]).MultiParams.Free;
  FreeMem(PMcpMultiLine(MultiLines[Index]));
  MultiLines.Delete(Index);
end;

function TMcpPlugin.GetDebugMultiLine(Index: Integer): string;
begin
  with PMcpMultiLine(MultiLines[Index])^ do
    Result:='<@[clnt:/dump-ml '+Tag+']'+Tag+'@[/]> '+MsgPkg+'-'+MsgVerb+' ('+IntToStr(MsgParams.Count+MultiParams.Count)+' params)';
end;

procedure TMcpPlugin.DumpMultiLine(const DataTag: string);
var
  I, J: Integer;
begin
  for I:=0 to MultiLines.Count-1 do
    with PMcpMultiLine(MultiLines[I])^ do
      if Tag=DataTag then
      begin
        CommanderMsg('Tag: '+DataTag);
        CommanderMsg('Pkg: '+MsgPkg);
        CommanderMsg('Verb: '+MsgVerb);
        CommanderMsg('Non-ML params:');
        for J:=0 to MsgParams.Count-1 do
          CommanderMsg('  ('+MsgParams[J]+')');
        CommanderMsg('ML params:');
        for J:=0 to MultiParams.Count-1 do
          CommanderMsg('  ('+MultiParams[J]+')');
        Exit;
      end;
  CommanderMsg('"'+DataTag+'" not found in multilines initiated by server.');
end;

procedure TMcpPlugin.CreateMultiLine(MultiParams: TStringList);
var
  ML: PMcpMultiLine;
  I, TagIndex: Integer;
  Tag: string;
begin
  TagIndex:=MsgParams.IndexOfName('_data-tag');
  if TagIndex=-1 then begin Debug(mdError,'Multiline: No _data-tag given while initializing multitag.'); Exit; end;
  Tag:=MsgParams.Values['_data-tag'];
  if CurrentPkg=nil then
  begin
    Debug(mdError,'Package unknown ('+MsgPkg+')'); Exit;
  end;
  if not CurrentPkg.MyVerb(MsgVerb) then
  begin
    Debug(mdError,'Command unknown ('+MsgPkg+'-'+MsgVerb+')');
    Exit;
  end;
  for I:=0 to MultiLines.Count-1 do
    if PMcpMultiLine(MultiLines[I])^.Tag=Tag then
      begin Debug(mdError,'Multiline: Tag already taken.'); Exit; end;
  GetMem(ML,SizeOf(TMcpMultiLine));
  Pointer(ML.Tag):=nil;
  Pointer(ML.MsgPkg):=nil;
  Pointer(ML.MsgVerb):=nil;
  ML.Pkg:=CurrentPkg;
  ML.MsgPkg:=MsgPkg;
  ML.MsgVerb:=MsgVerb;
  ML.Tag:=Tag;
  ML.MsgData:=nil;
  MsgParams.Delete(TagIndex);
  ML.MsgParams:=TStringList.Create;
  ML.MsgParams.AddStrings(MsgParams);
  ML.MultiParams:=MultiParams;
  MultiLines.Add(ML);
  CurrentPkg.NotifyMLMessage(ML);
end;

function TMcpPlugin.FinishMultiLine: Boolean;
var
  ActTag: string;
  P: Integer;
begin
  Result:=False;
  Delete(ActMsg,1,1);
  Delete(ActMsgLC,1,1);
  if (ActMsg='') or (ActMsg[1]<>' ') then begin Debug(mdError,'Invalid multiline'); Exit; end;
  Delete(ActMsg,1,1);
  Delete(ActMsgLC,1,1);
  P:=Pos(' ',ActMsg);
  if P>0 then Debug(mdVerbose,'Warning: Multiline end has additional text')
  else P:=Length(ActMsg)+1;
  ActTag:=Copy(ActMsg,1,P-1);
  ActMsg:=Copy(ActMsg,P+1,Length(ActMsg));
  for P:=0 to MultiLines.Count-1 do
    if PMcpMultiLine(MultiLines[P]).Tag=ActTag then
    begin
      MsgPkg:=PMcpMultiLine(MultiLines[P]).MsgPkg;
      MsgVerb:=PMcpMultiLine(MultiLines[P]).MsgVerb;
      MsgName:=MsgPkg+'-'+MsgVerb;
      MsgData:=PMcpMultiLine(MultiLines[P]).MsgData;
      MsgParams.Clear;
      MsgParams.AddStrings(PMcpMultiLine(MultiLines[P]).MsgParams);
      FreeMultiLine(P);
      Result:=True;
      Exit;
    end;
  Debug(mdError,'Multiline: Data-tag not found.');
end;

function TMcpPlugin.ReqParams(Args: array of string): Boolean;
var
  I: Integer;
begin
  Result:=False;
  for I:=Low(Args) to High(Args) do
  begin
    if MsgParams.IndexOfName(Args[I])=-1 then
      begin Debug(mdError,'Parameter '''+Args[I]+''' is required in command ('+MsgName+').'); Exit; end;
  end;
  Result:=True;
end;

function TMcpPlugin.StrToOrd(Arg: string; Values: array of string): Integer;
var
  I: Integer;
begin
  Result:=-1; Arg:=LowerCase(Arg);
  for I:=Low(Values) to High(Values) do
    if Values[I]=Arg then begin Result:=I; Exit; end;
end;

procedure TMcpPlugin.SendMcpMLEnd(const DataTag: string);
begin
  SendLineDirect('#$#: '+DataTag);
  Debug(mdVerbose,'> (#$#: '+DataTag+')');
end;

procedure TMcpPlugin.SendMcpML(const DataTag, MsgArgs: string);
begin
  SendLineDirect('#$#* '+DataTag+' '+MsgArgs);
  Debug(mdVerbose,'> (#$#* '+DataTag+' '+MsgArgs+')');
end;

procedure TMcpPlugin.SendMcp(const MsgName: string; MsgArgs: string);
begin
  if MsgArgs<>'' then MsgArgs:=' '+MsgArgs;
  SendLineDirect('#$#'+MsgName+' '+AuthKey+MsgArgs);
  Debug(mdVerbose,'> (#$#'+MsgName+' '+AuthKey+MsgArgs+')');
end;

procedure TMcpPlugin.Debug(Pri: Integer; Msg: string);
begin
  if DebugMode=mdOff then Exit;
  if (DebugMode=mdError) and (Pri=mdVerbose) then Exit;
  AddToLog('MCP: '+Msg);
end;

procedure TMcpPlugin.SetMultiValues(Multi: PMcpMultiLine);
var
  I: Integer;
  ActKey, ActValue: string;
begin
  I:=Pos(': ',ActMsg);
  if I=0 then begin Debug(mdError,'Multiline: no key-name'); Exit; end;
  ActKey:=Copy(ActMsgLC,1,I-1);
  ActValue:=Copy(ActMsg,I+2,Length(ActMsg));

  if Multi.MultiParams.IndexOf(ActKey)=-1 then begin Debug(mdError,'Multiline: not a multiline key'); Exit; end;
  if not Multi.Pkg.NotifyML(Multi,ActKey,ActValue) then
    Multi.MsgParams.Add(ActKey+'='+ActValue);
end;

procedure TMcpPlugin.HandleMultiLine;
var
  ActTag: string;
  P: Integer;
begin
  Delete(ActMsg,1,1);
  Delete(ActMsgLC,1,1);
  if (ActMsg='') or (ActMsg[1]<>' ') then begin Debug(mdError,'Invalid multiline'); Exit; end;
  Delete(ActMsg,1,1);
  Delete(ActMsgLC,1,1);
  P:=Pos(' ',ActMsg);
  if P=0 then begin Debug(mdError,'Multiline: no data-tag found'); Exit; end;
  ActTag:=Copy(ActMsg,1,P-1);
  ActMsg:=Copy(ActMsg,P+1,Length(ActMsg));
  ActMsgLC:=Copy(ActMsgLC,P+1,Length(ActMsgLC));
  for P:=0 to MultiLines.Count-1 do
    if PMcpMultiLine(MultiLines[P]).Tag=ActTag then
    begin
      SetMultiValues(MultiLines[P]); Exit;
    end;
  Debug(mdError,'Multiline: Data-tag not found.');
end;

function TMcpPlugin.SplitLine: Boolean;
var
  P: Integer;
  MsgAuth: string;
  ActKey, ActVal: string;
  MultiLine: Boolean;
  MultiLines: TStringList;
begin
  Result:=False; MultiLines:=nil;
  if ActMsg='' then begin Debug(mdError,'Empty message'); Exit; end;
  if ActMsg[1]='*' then begin HandleMultiLine; Exit; end;
  if ActMsg[1]=':' then begin Result:=FinishMultiLine; Exit; end;

  // Extract message-name
  P:=Pos(' ',ActMsgLC);
  if P=0 then begin Debug(mdError,'Space expected after message-name'); Exit; end;
  MsgName:=Copy(ActMsgLC,1,P-1);
  if MsgName='' then begin Debug(mdError,'No message-name'); Exit; end;
  MsgVerb:=''; MsgPkg:=''; MsgData:=nil;
  ActMsg:=Copy(ActMsg,P+1,Length(ActMsg));
  ActMsgLC:=Copy(ActMsgLC,P+1,Length(ActMsgLC));

  CurrentPkg:=FindPackage(MsgName);
  if CurrentPkg<>nil then
  begin
    MsgPkg:=CurrentPkg.PkgName;
    MsgVerb:=Copy(MsgName,Length(MsgPkg)+2,Length(MsgName));
  end;

  // Extract authentication
  if MsgName<>'mcp' then
  begin
    P:=Pos(' ',ActMsgLC);
    if P=0 then P:=Length(ActMsg)+1;
    MsgAuth:=Copy(ActMsg,1,P-1);
    if MsgAuth='' then begin Debug(mdError,'No authentication key'); Exit; end;
    if MsgAuth<>AuthKey then begin Debug(mdError,'Incorrect authentication key ('+MsgAuth+')'); Exit; end;
    ActMsg:=Copy(ActMsg,P+1,Length(ActMsg));
    ActMsgLC:=Copy(ActMsgLC,P+1,Length(ActMsgLC));
  end;

  // Extract parameters
  MsgParams.Clear;
  while Length(ActMsg)>0 do
  begin
    MultiLine:=False;
    // Extract keyword
    P:=Pos(': ',ActMsgLC);
    if P=0 then begin Debug(mdError,'Error in keyword (no ": " found)'); Exit; end;
    ActKey:=Copy(ActMsgLC,1,P-1);
    if ActKey='' then begin Debug(mdError,'Empty keyword'); Exit; end;
    if ActKey[Length(ActKey)]='*' then // Multiline
    begin
      if MultiLines=nil then MultiLines:=TStringList.Create;
      MultiLine:=True;
      MultiLines.Add(Copy(ActKey,1,Length(ActKey)-1));
    end;
    ActMsg:=Copy(ActMsg,P+2,Length(ActMsg));
    ActMsgLC:=Copy(ActMsgLC,P+2,Length(ActMsgLC));

    // Extract value
    if Length(ActMsg)>0 then
      if ActMsg[1]='"' then // Quoted value
      begin
        Delete(ActMsg,1,1);
        Delete(ActMsgLC,1,1);
        //P:=Pos('"',ActMsg);
        FindQuotedString(ActMsg,1,P);
        if P=0 then Debug(mdError,'Unterminated string');
        ActVal:=UnEscape(Copy(ActMsg,1,P-1));
        ActMsg:=Copy(ActMsg,P+2,Length(ActMsg));
        ActMsgLC:=Copy(ActMsgLC,P+2,Length(ActMsgLC));
      end
    else
    begin
      P:=Pos(' ',ActMsgLC);
      //if (P=Length(ActMsg)) then Debug(mdVerbose,'Warning: Trailing spaces should be discarded');
      if P=0 then P:=Length(ActMsg)+1;
      ActVal:=Copy(ActMsg,1,P-1);
      if ActVal='' then begin Debug(mdError,'Empty value'); Exit; end;
      ActMsg:=Copy(ActMsg,P+1,Length(ActMsg));
      ActMsgLC:=Copy(ActMsgLC,P+1,Length(ActMsgLC));
    end;
    if MultiLine and (ActVal<>'') then
      Debug(mdVerbose,'Warning: Values of multiline keys are ignored')
    else if not MultiLine then
      MsgParams.Add(ActKey+'='+ActVal);
  end;
//  for P:=0 to MsgParams.Count-1 do
//    AddToLog('('+MsgParams[P]+')');
  if MultiLines<>nil then
    CreateMultiLine(MultiLines)
  else
    Result:=True;
end;

function TMcpPlugin.HandleLine(var Msg: string): Boolean;
begin
  Result:=False;
  if Copy(Msg,1,7)=#27'[0m#$#' then
    Delete(Msg,1,4)
  else if not (Copy(Msg,1,3)='#$#') then Exit;
  Result:=True;
  try
    ActMsg:=Copy(Msg,4,Length(Msg)-3);
    ActMsgLC:=LowerCase(ActMsg);
    Debug(mdVerbose,'< ('+Msg+')');
    if SplitLine then
      if MsgName='mcp' then StartMcpSession
      else
      begin
        if CurrentPkg=nil then
          Debug(mdError,'Package unknown (Full command was '''+MsgName+''')')
        else
        begin
          if not CurrentPkg.MyVerb(MsgVerb) then
            Debug(mdError,'Command unknown ('+MsgPkg+'-'+MsgVerb+')')
          else
            try
              CurrentPkg.HandleMessage;
            except
              Debug(mdError,'Error executing ('+MsgPkg+'-'+MsgVerb+')');
            end;
        end;
      end;
  except
    Debug(mdError,'Unexpected error in MCP');
  end;
end;

{procedure TMcpPlugin.SplitVerb(const MsgName: string; var MsgPkg, MsgVerb: string);
var
  P: Integer;
begin
  for P:=Length(MsgName) downto 1 do
    if MsgName[P]='-' then
    begin
      MsgVerb:=Copy(MsgName,P+1,Length(MsgName));
      MsgPkg:=Copy(MsgName,1,P-1);
      Exit;
    end;
  MsgPkg:=MsgName;
  MsgVerb:='';
end;}

function TMcpPlugin.IsValidCommand(const MsgPkg, Msgverb: string): Boolean;
var
  I: Integer;
begin
  Result:=False;
  for I:=0 to Packages.Count-1 do
    if (TMcpPackage(Packages[I]).PkgName=MsgPkg) and TMcpPackage(Packages[I]).MyVerb(MsgVerb) then
      begin Result:=True; Exit; end;
end;

function TMcpPlugin.FindPackage(const MsgPkg: string): TMcpPackage;
var
  I: Integer;
begin
  Result:=nil;
  for I:=0 to Packages.Count-1 do
    if Copy(MsgPkg,1,Length(TMcpPackage(Packages[I]).PkgName))=TMcpPackage(Packages[I]).PkgName then
      begin Result:=Packages[I]; Exit; end;
end;
    
constructor TMcpSimpleEdit.Create(Owner: TMcpPlugin);
begin
  inherited Create(Owner);
  MinVersion:=GetVersion(1,0); MaxVersion:=GetVersion(1,0);
  PkgName:='dns-org-mud-moo-simpleedit';
end;

procedure TMcpSimpleEdit.Negotiated;
begin

end;

function TMcpSimpleEdit.Send(CEPage: TClientPageBase): Boolean;
var
  I: Integer;
  MLTag: string;
begin
  Result:=False;
  with TEditClientPage(CEPage) do
  begin
    SetStatus('Saving...');
    if Supported then // Send through multilines
    begin
      MLTag:=Mcp.NewMultiLine;
      Mcp.SendMcp('dns-org-mud-moo-simpleedit-set','reference: ' + SimpleEditReference + 'name: "'+FileName+'" type: "'+TextType+'" contents*: "" _data-tag: "'+MLTag+'"');
      for I:=0 to EditWin.Lines.Count-1 do
        Mcp.SendMcpML(MLTag,'contents: '+EditWin.Lines[I]);
      Mcp.SendMcpMLEnd(MLTag);
    end
    else
    begin
      if UploadCmd='' then begin CommanderMsg('> Can''t save to this server, don''t know the upload-command :('); Exit; end;
      Mcp.SendLine(UploadCmd);
      for I:=0 to EditWin.Lines.Count-1 do
        if EditWin.Lines[I]='.' then
          Mcp.SendLine('. ')
        else
          Mcp.SendLine(EditWin.Lines[I]);
      Mcp.SendLine('.');
      SetStatus('Ready');
      if CloseAfterSave then Close;
    end;
  end;
  Result:=True;
end;

function TMcpSimpleEdit.NotifyML(ML: PMcpMultiLine; const Key, Value: string): Boolean;
begin
  Result:=True;
  if Key='contents' then
    if Assigned(ML.MsgData) then
      if not FirstLine then
        TEditClientPage(ML.MsgData).EditWin.Lines.Add(Value)
      else
      begin
        FirstLine:=False;
        TEditClientPage(ML.MsgData).EditWin.Lines[0]:=Value;
      end;
end;

procedure TMcpSimpleEdit.NotifyMLMessage(ML: PMcpMultiLine);
begin
  if Mcp.MsgVerb='content' then
  begin
    if not Mcp.ReqParams(['name','type']) then Exit;
    if LowerCase(Mcp.MsgParams.Values['type'])='error' then Exit;
    if ML.MultiParams.IndexOf('contents')=-1 then Exit;
    ML.MsgData:=TNetClientPage(Mcp.CPage).OpenEditor(Mcp.MsgParams.Values['name']);
    FirstLine:=True;
    with TEditClientPage(ML.MsgData) do
    begin
      TextType:=LowerCase(Mcp.MsgParams.Values['type']);
      InitLoading(Mcp.MsgParams.Values['name']);
      if TextType='verb' then
        EditWin.HighLighter:=mwMooHighLighter;
    end;
  end;
end;

procedure TMcpSimpleEdit.HandleMessage;
begin
  if not Mcp.ReqParams(['name','type', 'reference']) then Exit;
  if LowerCase(Mcp.MsgParams.Values['type'])='error' then
  begin
    TNetClientPage(Mcp.CPage).CommanderMsg('Couldn''t load '+Mcp.MsgParams.Values['name']+' ('+Mcp.MsgParams.Values['reason']+')');
  end
  else
    TEditClientPage(Mcp.MsgData).FinishLoading;
end;

function TMcpSimpleEdit.MyVerb(Verb: string): Boolean;
begin
  Result:=Verb='content';
end;
    

end.
