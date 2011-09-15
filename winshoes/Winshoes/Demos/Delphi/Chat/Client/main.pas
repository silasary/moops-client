//=============================================
//  Chat Client
//=============================================
// Date - Name
//     Comments
//
// 19990305 - scott.shelton@usa.net
//     Initial Development
//
//=============================================
unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Winshoes, StdCtrls, serverwinshoe, ComCtrls, ExtCtrls;

type
  TFormClient = class(TForm)
    Client: TWinshoeClient;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditNick: TEdit;
    EditHost: TEdit;
    EditPort: TEdit;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    MemoIncomingMessages: TMemo;
    Panel2: TPanel;
    MemoSend: TMemo;
    ButtonConnect: TButton;
    ButtonDisconnect: TButton;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Image1: TImage;
    procedure ButtonConnectClick(Sender: TObject);
    procedure ButtonDisconnectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MemoSendKeyPress(Sender: TObject; var Key: Char);
  private
  public
  end;

  TRecvThread = class(TThread)
  private
    Msg : String;
    procedure NewMail;
  protected
    procedure Execute; override;
  end;


var
  FormClient: TFormClient;
  RecvThread : TRecvThread;
  ClientStatusFlag : Boolean;

implementation
{$R *.DFM}

{ Connects to a Server and creates the Thread that will receive
  incoming messages
}
procedure TFormClient.ButtonConnectClick(Sender: TObject);
begin
  try
    Client.Host := EditHost.Text;
    Client.Port := StrToInt(EditPort.Text);
    Client.Connect;
    Client.Writeln('Welcome To: ' + EditNick.Text);
    RecvThread := TRecvThread.Create(FalsE);
    ClientStatusFlag := True;
    EditNick.ReadOnly := True;
    EditHost.ReadOnly := True;
    EditPort.ReadOnly := True;
  finally
  end;
end;
{  Disconnects from server and Terminates the receive thread
}
procedure TFormClient.ButtonDisconnectClick(Sender: TObject);
begin
  if ClientStatusFlag
    then
      begin
        EditNick.ReadOnly := True;
        EditHost.ReadOnly := True;
        EditPort.ReadOnly := True;
        ClientStatusFlag := False;
        RecvThread.Terminate;
        repeat
          Application.ProcessMessages;
        until RecvThread.Terminated;
        Client.Disconnect;
      end;
end;
{ this thread will loop until the Terminate method is called
  elsewhere in the program.  The synchronize method is used
  because errors will occur if a thread tries to directly update
  a vcl component
}

procedure TRecvThread.Execute;
begin
  while not RecvThread.Terminated do begin
    try
      Msg := FormClient.Client.ReadLn;
      Synchronize(NewMail);
    except
      RecvThread.Terminate;
    end;
  end;
end;


procedure TRecvThread.NewMail;
begin
  FormClient.MemoIncomingMessages.Lines.Add(Msg);
end;

procedure TFormClient.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ButtonDisconnect.Click;
  Action := caFree;
end;

{
when the users presses enter, it will send each line in the
outgoing memo box to the server
}
procedure TFormClient.MemoSendKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13
    then
      begin
        while ( MemoSend.Lines.Count > 0 )
          do
            try
              Client.WriteLn(EditNick.Text + ': ' + MemoSend.Lines.Strings[0]);
              MemoSend.Lines.Delete(0);
              Key := #0;
              MemoSend.Lines.Clear;
            except
              MemoSend.Lines.Clear;
            end;
     end;
end;

end.
