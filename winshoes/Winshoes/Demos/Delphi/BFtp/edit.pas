unit edit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TformEdit = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    btedFile: TEdit;
    ledtServer: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ledtUsername: TEdit;
    ledtDestination: TEdit;
		Label6: TLabel;
    ledtPassword: TEdit;
    procedure BitBtn1Click(Sender: TObject);
  private
	public
		procedure LoadFile(const psFile: String);
	end;

var
	formEdit: TformEdit;

implementation
{$R *.DFM}

procedure TFormEdit.LoadFile;
begin
	btedFile.Text := psFile;
	with TStringList.Create do try
		if FileExists(psFile) then
			LoadFromFile(psFile);
		ledtServer.Text := Values['Server'];
		if ledtServer.Text = '' then
			ledtServer.Text := 'www.virocity.net';
		ledtUsername.Text := Values['User'];
		ledtPassword.Text := Values['Password'];
		ledtDestination.Text := Values['Dest'];
		if ledtDestination.Text = '' then
			ledtDestination.Text := '/';
	finally free; end;
end;

procedure TformEdit.BitBtn1Click(Sender: TObject);
begin
	with TStringList.Create do try
		Values['Server'] := ledtServer.Text;
		Values['User'] := ledtUsername.Text;
		Values['Password'] := ledtPassword.Text;
		Values['Dest'] := ledtDestination.Text;
		SaveToFile(btedFile.Text);
	finally free; end;
end;

end.
