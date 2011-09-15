unit cvtMainFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, BeChatView_new;

type
  TMainForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ChatView: TChatView;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ChatView:=TChatView.Create(Self);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ChatView.Free;
end;

end.
