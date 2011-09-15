unit PasteFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ClipBrd;

type
  TPasteForm = class(TForm)
    Label1: TLabel;
    CmdCombo: TComboBox;
    Label3: TLabel;
    TextMemo: TMemo;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    RawPasteBox: TCheckBox;
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
