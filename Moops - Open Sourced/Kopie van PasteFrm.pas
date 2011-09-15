unit PasteFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ClipBrd;

type
  TPasteForm = class(TForm)
    Label1: TLabel;
    CmdCombo: TComboBox;
    Label2: TLabel;
    PrefixEdit: TEdit;
    Label3: TLabel;
    TextMemo: TMemo;
    Label4: TLabel;
    EndEdit: TEdit;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PasteForm: TPasteForm;

implementation

{$R *.DFM}

procedure TPasteForm.FormShow(Sender: TObject);
begin
  TextMemo.Clear;
  if Clipboard.HasFormat(CF_TEXT) then
    TextMemo.Text:=ClipBoard.AsText;
end;

end.
