unit lpd_demo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  Winshoes, serverwinshoe, ServerWinshoeLPD, ServerWinshoeTelnet;

type
  TfrmLPD = class(TForm)
    WinshoeLPDListener1: TWinshoeLPDListener;
    Memo1: TMemo;
    procedure WinshoeLPDListener1Log(Sender: TComponent;
      const sOut: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLPD: TfrmLPD;

implementation

{$R *.DFM}

procedure TfrmLPD.WinshoeLPDListener1Log(Sender: TComponent;
  const sOut: String);
begin
Memo1.Lines.Add(sOut);
end;

end.
