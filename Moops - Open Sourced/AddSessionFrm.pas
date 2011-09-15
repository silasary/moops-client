unit AddSessionFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls;

type
  TAddSessionForm = class(TForm)
    NewRadio: TRadioButton;
    Label1: TLabel;
    OpenRadio: TRadioButton;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    FileNameLabel: TLabel;
    FileNameEdit: TEdit;
    BrowseButton: TSpeedButton;
    DescrLabel: TLabel;
    DescrEdit: TEdit;
    OpenDialog: TOpenDialog;
    procedure NewRadioClick(Sender: TObject);
    procedure OpenRadioClick(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure BrowseButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function AddSession(var FileName, Descr: string): Boolean;
    function CreateSession(var FileName, Descr: string): Boolean;
  end;

var
  AddSessionForm: TAddSessionForm;

implementation

uses CreateSessionFrm;

{$R *.DFM}

function TAddSessionForm.CreateSession(var FileName, Descr: string): Boolean;
begin
  Result:=CreateSessionForm.CreateSession(FileName,Descr);
end;

function TAddSessionForm.AddSession(var FileName, Descr: string): Boolean;
begin
  EditChange(nil);
  FileName:='';
  Descr:='';
  Result:=ShowModal=mrOk;
  if Result then
    if NewRadio.Checked then
      Result:=CreateSession(FileName,Descr)
    else
    begin
      FileName:=FileNameEdit.Text;
      if Copy(LowerCase(FileName),Length(FileName)-3,4)='.msc' then
        Delete(FileName,Length(FileName)-3,4);
      Descr:=DescrEdit.Text;
    end
end;

procedure TAddSessionForm.NewRadioClick(Sender: TObject);
begin
  FileNameLabel.Enabled:=False;
  FileNameEdit.Enabled:=False;
  BrowseButton.Enabled:=False;
  DescrLabel.Enabled:=False;
  DescrEdit.Enabled:=False;
  FileNameEdit.Color:=clBtnFace;
  DescrEdit.Color:=clBtnFace;
  EditChange(Sender);
end;

procedure TAddSessionForm.OpenRadioClick(Sender: TObject);
begin
  FileNameLabel.Enabled:=True;
  FileNameEdit.Enabled:=True;
  BrowseButton.Enabled:=True;
  DescrLabel.Enabled:=True;
  DescrEdit.Enabled:=True;
  FileNameEdit.Color:=clWindow;
  DescrEdit.Color:=clWindow;
  EditChange(Sender);
end;

procedure TAddSessionForm.EditChange(Sender: TObject);
begin
  OkButton.Enabled:=(NewRadio.Checked) or ((FileNameEdit.Text<>'') and (DescrEdit.Text<>''));
end;

procedure TAddSessionForm.BrowseButtonClick(Sender: TObject);
begin
  OpenDialog.FileName:=FileNameEdit.Text;
  if OpenDialog.Execute then
    FileNameEdit.Text:=OpenDialog.FileName;
end;

end.
