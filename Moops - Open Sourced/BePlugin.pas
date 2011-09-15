unit BePlugin;

interface

uses
  Classes, Controls, ComCtrls, ExtCtrls, SysUtils, Forms, Messages, BeChatView{, ChatView};

const
  ppMcp     = 100;
  ppNormal  = 150;
  ppDisplay = 200;

type
  TClientPageBase = class(TPanel)
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
  private
    fCaption: string;
  public
    PageList: TList;
    ChatView: TChatView;
    TabIndex: Integer;
    constructor Create(AOwner: TComponent; APageList: TList); reintroduce;
    destructor Destroy; override;
    procedure SetCaption(const S: string); virtual;
    procedure AddToLog(Msg: string); virtual; abstract;
    procedure AddToChat(const Msg: string); virtual;
    procedure CommanderMsg(const Msg: string); virtual;
    procedure SendLine(const Msg: string); virtual;
    procedure SendLineDirect(const Msg: string); virtual;
    property Caption: string read fCaption write SetCaption;
  end;

  TBePlugin = class
    CPage: TClientPageBase;
    ActMsg, ActMsgLC: string;
    Priority: Integer;
    PluginName: string;
    PluginActive: Boolean;
    constructor Create(Page: TClientPageBase);
    function HandleLine(var Msg: string): Boolean; virtual;
    procedure AddToLog(const Msg: string); virtual;
    procedure AddToChat(const Msg: string); virtual;
    procedure CommanderMsg(const Msg: string); virtual;
    procedure SendLine(const Msg: string); virtual;
    procedure SendLineDirect(const Msg: string); virtual;
    function RndStr(StrList: TStringList): string; virtual;
  end;

procedure AddPlugin(Plugins: TList; Plugin: TBePlugin);
procedure FreePlugin(Plugins: TList; const ClassName: string);

implementation

uses
  MainFrm, ClientPage;

procedure FreePlugin(Plugins: TList; const ClassName: string);
var
  I: Integer;
  P: TBePlugin;
begin
  for I:=0 to Plugins.Count-1 do
    if TBePlugin(Plugins[I]).ClassNameIs(ClassName) then
    begin
      P:=Plugins[I];
      Plugins.Delete(I);
      P.Free;
    end;
end;

procedure AddPlugin(Plugins: TList; Plugin: TBePlugin);
var
  I: Integer;
begin
  for I:=0 to Plugins.Count-1 do
    if TBePlugin(Plugins[I]).Priority>=Plugin.Priority then
    begin
      Plugins.Insert(I,Plugin); Exit;
    end;
  Plugins.Add(Plugin);
end;

constructor TClientPageBase.Create(AOwner: TComponent; APageList: TList);
begin
  inherited Create(AOwner);
  BevelInner:=bvNone;
  BevelOuter:=bvNone;
  FullRepaint:=False;
  Parent:=MainForm.PagesPanel;{TWinControl(AOwner);}
  Align:=alClient;
  PageList:=APageList;
  PageList.Add(Self);
  TabIndex:=PageList.Count-1;
end;

destructor TClientPageBase.Destroy;
var
  I: Integer;
begin
  PageList.Remove(Self);
  for I:=0 to PageList.Count-1 do
    TClientPageBase(PageList[I]).TabIndex:=I;
  inherited Destroy;
end;

procedure TClientPageBase.WMEraseBkgnd(var Message: TMessage);
begin
  Message.Result:=1;
end;

procedure TClientPageBase.SetCaption(const S: string);
begin
  fCaption:=S;
  MainForm.UpdateCaption;
end;

procedure TClientPageBase.AddToChat(const Msg: string);
begin
end;

procedure TClientPageBase.CommanderMsg(const Msg: string);
begin
end;

procedure TClientPageBase.SendLine(const Msg: string);
begin
end;

procedure TClientPageBase.SendLineDirect(const Msg: string);
begin
end;

constructor TBePlugin.Create(Page: TClientPageBase);
begin
  inherited Create;
  CPage:=Page;
  Priority:=ppNormal;
  PluginActive:=True;
  PluginName:='';
  ActMsg:=''; ActMsgLC:='';
end;

function TBePlugin.HandleLine(var Msg: string): Boolean;
begin
  ActMsg:=Msg; ActMsgLC:=LowerCase(Msg);
  Result:=False;
end;

procedure TBePlugin.AddToLog(const Msg: string);
begin
  CPage.AddToLog(Msg);
end;

procedure TBePlugin.AddToChat(const Msg: string);
begin
  CPage.AddToChat(Msg);
end;

procedure TBePlugin.Commandermsg(const Msg: string);
begin
  CPage.CommanderMsg(Msg);
end;

procedure TBePlugin.SendLine(const Msg: string);
begin
  CPage.SendLine(Msg);
end;

procedure TBePlugin.SendLineDirect(const Msg: string);
begin
  CPage.SendLineDirect(Msg);
end;

function TBePlugin.RndStr(StrList: TStringList): string;
begin
  Result:=StrList[Random(StrList.Count)];
end;

end.
