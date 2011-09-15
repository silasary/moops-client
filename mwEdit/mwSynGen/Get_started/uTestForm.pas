unit uTestForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, mwCustomEdit;

type
  TForm1 = class(TForm)
    mwEdit: TmwCustomEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses Sample3;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Button1.Enabled := FALSE;
  mwEdit.Highlighter := TmwSampleSyn.Create(Self);
end;

end.
