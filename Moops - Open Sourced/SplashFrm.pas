unit SplashFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  jpeg, ExtCtrls;

type
  TSplashForm = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure Image1Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MoopsInitialized: Boolean = False;
  SplashForm: TSplashForm;

implementation

uses
  MainFrm;

{$R *.DFM}

procedure TSplashForm.Image1Click(Sender: TObject);
begin
  Close;
end;

procedure TSplashForm.Image1DblClick(Sender: TObject);
begin
  Close;
end;

procedure TSplashForm.Timer1Timer(Sender: TObject);
begin
  Close;
end;

procedure TSplashForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not MoopsInitialized then
  begin
    MoopsInitialized:=True;
    PostMessage(MainForm.Handle,WM_INITMOOPS2,0,0);
  end;
  Action:=caFree;
end;

procedure TSplashForm.FormCreate(Sender: TObject);
begin
  if not MoopsInitialized then
    PostMessage(MainForm.Handle,WM_INITMOOPS,0,0);
end;

end.
