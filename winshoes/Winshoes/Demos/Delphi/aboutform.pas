unit AboutForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TformAbout = class(TForm)
    lablTitle: TLabel;
    Label2: TLabel;
    lablAuthorName: TLabel;
    lablAuthorAddress: TLabel;
    Image1: TImage;
    Label5: TLabel;
    lablKudzu: TLabel;
    butnClose: TButton;
    procedure MailToClick(Sender: TObject);
  private
  public
  end;

implementation

uses
  DemoUtils;

{$R *.DFM}

procedure TformAbout.MailToClick(Sender: TObject);
begin
  if Sender = lablAuthorAddress then
    MailTo(lablAuthorAddress.Caption, lablTitle.Caption)
  else if Sender = lablKudzu then
    MailTo('kudzu@pbe.com', lablTitle.Caption);
end;

end.
 