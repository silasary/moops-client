//=============================================
//  Chat Server
//=============================================
// Date - Name
//     Comments
//
// 19990305 - scott.shelton@usa.net
//     Initial Development
//     Cannot resolve Exception  on Close
//
//=============================================
unit main;

interface

uses
  Windows, Messages, syncobjs, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Winshoes, serverwinshoe, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormServer = class(TForm)
    Server: TWinshoeListener;
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    Label1: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    LabelClients: TLabel;
    procedure ServerExecute(Thread: TWinshoeServerThread);
    procedure FormCreate(Sender: TObject);
  private
    procedure IncrementClientCount;
    procedure DecrementClientCount;
    procedure Broadcast ( MsgToSend : String ) ;
  public
end;

var
  FormServer: TFormServer;

implementation
{$R *.DFM}

{
  ServerExecute is called when the server acquires a new
  connection.  Since the connection is a thread, unless we
  place it in a loop it would terminate after the first
  message is processed. 
}
procedure TFormServer.ServerExecute(Thread: TWinshoeServerThread);
begin
  Thread.Synchronize(IncrementClientCount);
  try
    while Thread.Connection.Connected do
      Broadcast(Thread.Connection.ReadLn);
  finally Thread.Synchronize(DecrementClientCount); end;
end;
{
  Broadcast will send any message that is received to all
  threads that are connected.  Pointers to these threads
  are contained in a TList
}
procedure TFormServer.Broadcast ( MsgToSend : String ) ;
var
  x : Integer;
  ClientList: TList;
begin
  ClientList := Server.Threads.LockList; try
    for x := 0 to ClientList.Count - 1
      do
        TWinshoeServerThread(ClientList.Items[x]).Connection.Writeln(MsgToSend);
  finally Server.Threads.UnlockList; end;
end;

{
  FormCreate will activate the server and create/initialize any required
  variables
}
procedure TFormServer.FormCreate(Sender: TObject);
begin
  statusBar1.SimpleText := Server.LocalAddress + ':8088';
  Server.Active := True;
end;

procedure TFormServer.DecrementClientCount;
begin
  LabelClients.Caption := IntToStr(StrToIntDef(LabelClients.Caption, 0) - 1);
end;

procedure TFormServer.IncrementClientCount;
begin
  LabelClients.Caption := IntToStr(StrToInt(LabelClients.Caption) + 1);
end;

end.
