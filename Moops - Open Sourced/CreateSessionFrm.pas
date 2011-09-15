unit CreateSessionFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Common;

type
  TCreateSessionForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ProxyBox: TCheckBox;
    LogBox: TCheckBox;
    FileNameEdit: TEdit;
    Label4: TLabel;
    DescrEdit: TEdit;
    ServerEdit: TEdit;
    PortEdit: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    ProxyServer: TEdit;
    ProxyPort: TEdit;
    Label7: TLabel;
    UserEdit: TEdit;
    Label8: TLabel;
    PassEdit: TEdit;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    Label9: TLabel;
    ProxyCmd: TEdit;
    Label10: TLabel;
    procedure ProxyBoxClick(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function CreateSession(var FileName, Descr: string): Boolean;
  end;

var
  CreateSessionForm: TCreateSessionForm;

implementation

{$R *.DFM}

function TCreateSessionForm.CreateSession(var FileName, Descr: string): Boolean;
begin
  EditChange(nil);
  Result:=ShowModal=mrOk;
  if Result then
  begin
    FileName:=FileNameEdit.Text;
    Descr:=DescrEdit.Text;
  end;
end;

procedure TCreateSessionForm.ProxyBoxClick(Sender: TObject);
begin
  Label5.Enabled:=ProxyBox.Checked;
  Label6.Enabled:=ProxyBox.Checked;
  Label10.Enabled:=ProxyBox.Checked;
  ProxyServer.Enabled:=ProxyBox.Checked;
  ProxyPort.Enabled:=ProxyBox.Checked;
  ProxyCmd.Enabled:=ProxyBox.Checked;
  if ProxyBox.Checked then
  begin
    ProxyServer.Color:=clWindow;
    ProxyPort.Color:=clWindow;
    ProxyCmd.Color:=clWindow;
  end
  else
  begin
    ProxyServer.Color:=clBtnFace;
    ProxyPort.Color:=clBtnFace;
    ProxyCmd.Color:=clBtnFace;
  end;
  EditChange(Sender);
end;

procedure TCreateSessionForm.EditChange(Sender: TObject);
begin
  OKButton.Enabled:=(FileNameEdit.Text<>'') and (DescrEdit.Text<>'') and
    (UserEdit.Text<>'') and (PassEdit.Text<>'') and
    (ServerEdit.Text<>'') and (PortEdit.Text<>'');
  if ProxyBox.Checked and ((ProxyServer.Text='') or (ProxyPort.Text='')) then
    OKButton.Enabled:=False;
end;

procedure TCreateSessionForm.OKButtonClick(Sender: TObject);
var
  S: TStringList;
begin
  S:=TStringList.Create;
  try
    try
      S.Add('/new '''+DescrEdit.Text+'''');
      if LogBox.Checked then
      begin
        S.Add('/logrotate '''+FileNameEdit.Text+'''');
        S.Add('/logtofile '''+FileNameEdit.Text+'''');
      end;
      if ProxyBox.Checked then
      begin
        S.Add('/connect '''+ProxyServer.Text+''' '+ProxyPort.Text);
        S.Add(ProxyCmd.Text+' '+ServerEdit.Text+' '+PortEdit.Text);
      end
      else
        S.Add('/connect '''+ServerEdit.Text+''' '+PortEdit.Text);
      S.Add('/cryptlogin '''+UserEdit.Text+''' '''+PwToStr(PassEdit.Text)+'''');
      S.SaveToFile(FileNameEdit.Text+'.msc');
    finally
      S.Free;
    end;
  except
    ModalResult:=mrNone;
    ShowMessage('Error creating "'+FileNameEdit.Text+'.msc"');
  end;
end;

end.
