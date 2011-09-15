// TITLE:       Pop3 Demo for Winshoes Pop3 Component
// DATE:        8-JULY-1999
// AUTHOR:      Hadi Hariri
// UNIT NAME:   msg.pas
// FORM NAME:   fmMESSAGE
// UTILITY:     View the body and attachments of a message
unit msg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfmMESSAGE = class(TForm)
    meBODY: TMemo;
    lbATTACH: TListBox;
    btSAVE: TButton;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    procedure btSAVEClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMESSAGE: TfmMESSAGE;

implementation

uses main;

{$R *.DFM}

procedure TfmMESSAGE.btSAVEClick(Sender: TObject);
var
    intIndex : integer ;
begin
    // Find selected
    for intIndex := 0 to lbATTACH.Items.Count - 1 do
        if lbATTACH.Selected [ intIndex ] then
            begin
                SaveDialog1.FileName := lbATTACH.Items[intIndex];
                if SaveDialog1.Execute then
                    fmMAIN.Msg.Attachments[intIndex].SaveToFile ( SaveDialog1.FileName );
            end ;

end;

end.
