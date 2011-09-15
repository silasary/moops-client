unit frmArticleUnit;
{
  History
    15 july 1999 - Initial release
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  WinshoeMessage, StdCtrls;

type
  TfrmArticle = class(TForm)
    wsMessage: TWinshoeMessage;
    editFrom: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    editSubject: TEdit;
    btnCancel: TButton;
    btnSend: TButton;
    GroupBox1: TGroupBox;
    memoArticle: TMemo;
    editNewsgroups: TEdit;
    procedure btnSendClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmArticle: TfrmArticle;

implementation

{$R *.DFM}

procedure TfrmArticle.btnCancelClick(Sender: TObject);
begin
  ModalResult:= -1;
end;

procedure TfrmArticle.btnSendClick(Sender: TObject);
begin
  with wsMessage do // fill the message object, and prepare for posting
  begin
    From:= editFrom.Text;
    Newsgroups.Commatext := editNewsgroups.Text;
    Subject:= editSubject.Text;
    Text.Text:= memoArticle.Lines.Text;
  end;

  ModalResult:= 1;
end;

procedure TfrmArticle.FormHide(Sender: TObject);
begin
// flush out whats written in the components except
// editFrom, so the user wont have to enter it each time
  editNewsgroups.Text:= '';
  editSubject.Text:= '';
  memoArticle.Clear;
end;

end.
