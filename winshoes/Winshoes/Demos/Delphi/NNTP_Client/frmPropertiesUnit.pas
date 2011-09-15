unit frmPropertiesUnit;
{
  History
    15 july 1999 - Initial release
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, inifiles;

type
  TfrmProperties = class(TForm)
    Label1: TLabel;
    editServer: TEdit;
    Label2: TLabel;
    editPort: TEdit;
    btnAccept: TButton;
    btnCancel: TButton;
    editUserName: TEdit;
    Label3: TLabel;
    editPassword: TEdit;
    Label4: TLabel;
    procedure btnAcceptClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FPort: integer;
    FUsername: string;
    FPassword: string;
    FServer: string;

    FIniFile: TIniFile;

    procedure SaveValues;
    procedure LoadValues;
  public
    { Public declarations }
    property Server: string read FServer;
    property Port: integer read FPort;
    property Username: string read FUsername;
    property Password: string read FPassword;
  end;

var
  frmProperties: TfrmProperties;

implementation

{$R *.DFM}

{ TfrmProperties }

procedure TfrmProperties.SaveValues;
begin
  FServer:= editServer.Text;
  FPort:= StrToInt(editPort.Text);
  FUsername:= editUsername.Text;
  FPassword:= editPassword.Text;

  with FIniFile do
  begin
    WriteString('server settings', 'server', FServer);
    WriteInteger('server settings', 'port', FPort);
    WriteString('server settings', 'username', FUsername);
    WriteString('server settings', 'password', FPassword);
  end;
end;

procedure TfrmProperties.LoadValues;
begin
  with FIniFile do
  begin
    FServer:= ReadString('server settings', 'server', '');
    FPort:= ReadInteger('server settings', 'port', 119);
    FUsername:= ReadString('server settings', 'username', '');
    FPassword:= ReadString('server settings', 'password', '');
  end;

  editServer.Text:= FServer;
  editPort.Text:= IntToStr(FPort);
  editUsername.Text:= FUsername;
  editPassword.Text:= FPassword;
end;

procedure TfrmProperties.btnAcceptClick(Sender: TObject);
begin
  SaveValues;
  ModalResult:= 0;
  Close;
end;

procedure TfrmProperties.btnCancelClick(Sender: TObject);
begin
  ModalResult:= -1;
  Close;
end;

procedure TfrmProperties.FormCreate(Sender: TObject);
begin
  FIniFile:= TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));

  LoadValues;
end;

procedure TfrmProperties.FormDestroy(Sender: TObject);
begin
  FIniFile.Free;
end;

end.
