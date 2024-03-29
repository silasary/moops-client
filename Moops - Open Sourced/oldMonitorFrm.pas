unit MonitorFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BeChatview, ExtCtrls;

type
  TMonitorForm = class(TForm)
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ChatView: TChatView;

    procedure AddLine(const World, Line: string);
    procedure ChatViewClick(Sender: TObject);
  end;

var
  MonitorForm: TMonitorForm = nil;

procedure ShowMonitor;
procedure HideMonitor;

implementation

{$R *.DFM}

uses
  MainFrm, ClientPage;

procedure ShowMonitor;
var
  Handle: HWND;
  Msg: PChar;
  Err: DWord;
begin
  Handle := CreateWindowEx(
    0,
    'MainWClass',           // class name
    'Main Window',          // window name
    WS_OVERLAPPEDWINDOW or  // overlapped window
        WS_HSCROLL or       // horizontal scroll bar
        WS_VSCROLL,         // vertical scroll bar
    0,          // default horizontal position
    0,          // default vertical position
    100,          // default width
    100,          // default height
    0,                      // no parent or owner window
    0,                      // class menu used
    Application.Handle,     // instance handle
    nil);                   // no window creation data

  Msg:=nil;
  Err:=GetLastError;
  FormatMessage(
    FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM,
    nil,
    Err,
    (SUBLANG_DEFAULT shl 10) or LANG_NEUTRAL, // Default language
    Msg,
    0,
    nil
  );

  Application.MessageBox(Msg,'Bla',0);

  if Handle=0 then Exit;

  ShowWindow(Handle,SW_SHOWDEFAULT);
  UpdateWindow(Handle);
//  MonitorPanel.Show;
{  if MonitorForm<>nil then Exit;
  Application.CreateForm(TMonitorForm,MonitorForm);}
end;

procedure HideMonitor;
begin
{  if MonitorForm=nil then Exit;
  MonitorForm.Free;
  MonitorForm:=nil;}
end;

procedure TMonitorForm.AddLine(const World, Line: string);
begin
  ChatView.AddLine('['+World+'] '+Line);
end;

procedure TMonitorForm.FormCreate(Sender: TObject);
begin
  Top:=0; Left:=150; Width:=Screen.DesktopWidth-250;
  ChatView:=TChatView.Create(Self);
  ChatView.Parent:=Self;
  ChatView.Align:=alClient;
  ChatView.Font.Size:=8;
  ChatView.AddLine(DoColor(cvYellow,cvGray)+'[Kanaal]'+DoColor(cvNormal,cvNormal)+' ET zegt, "Dit is een teststring"');
  ChatView.HorizScrollBar:=False;
  ChatView.FollowMode:=cfOn;
  ChatView.EnableBeep:=False;
  ChatView.DisableSelect:=True;
  ChatView.OnClick:=ChatViewClick;
  Height:=ChatView.CharHeight+4;
  ChatView.WordWrap:=0;
end;

procedure TMonitorForm.FormDestroy(Sender: TObject);
begin
  ChatView.Free;
end;

procedure TMonitorForm.ChatViewClick(Sender: TObject);
var
  S: string;
  I: Integer;
begin
  Application.BringToFront;
  if ChatView.ActLineCount=0 then Exit;
  S:=ChatView.GetLineText(ChatView.TopLine);
  S:=Copy(S,2,Pos(']',S)-2);
  with MainForm do
    for I:=0 to ClientPages.Count-1 do
      if TNetClientPage(ClientPages[I]).Caption=S then
      begin
        ActivatePage(ClientPages[I]);
        Exit;
      end;
end;

procedure TMonitorForm.FormShow(Sender: TObject);
begin
  SetWindowPos(
    WindowHandle,HWND_TOPMOST,0,0,0,0,
    SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOOWNERZORDER or
    SWP_NOREPOSITION or SWP_NOSIZE
  );
end;

end.
