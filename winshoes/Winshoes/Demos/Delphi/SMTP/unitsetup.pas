unit UnitSetup;

interface

uses
  Windows, Messages, IniFiles, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls;

type
  TFormSetup = class(TForm)
    Panel1: TPanel;
    StatusBar: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    EditServer: TEdit;
    EditAddress: TEdit;
    ButtonDone: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonDoneClick(Sender: TObject);
  private
    procedure ReadInifile;
    procedure WriteIniFile;
  public
  end;

var
  FormSetup: TFormSetup;

implementation
{$R *.DFM}

procedure TFormSetup.FormCreate(Sender: TObject);
begin
  ReadIniFile;
end;

procedure TFormSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteIniFile;
end;

procedure TFormSetup.ReadIniFile;
begin
  with TIniFile.Create(ChangeFileExt(Application.EXEName, '.ini')) do try
    EditServer.Text := ReadString('SETUP','Server','');
    EditAddress.Text := ReadString('SETUP','Email','your.address@goes.here');
  finally Free; end;
end;

procedure TFormSetup.WriteIniFile;
begin
  with TIniFile.Create(ChangeFileExt(Application.EXEName, '.ini')) do try
    WriteString('SETUP','Server',EditServer.Text);
    WriteString('SETUP','Email',EditAddress.Text);
  finally Free; end;
end;

procedure TFormSetup.ButtonDoneClick(Sender: TObject);
begin
  Close;
end;

end.
