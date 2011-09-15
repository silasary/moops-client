unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Winshoes, serverwinshoe, ExtCtrls, StdCtrls, Buttons, ServerWinshoeTunnel;

type
  TForm1 = class(TForm)
    MasterTunnel1: TMasterTunnel;
    SlaveTunnel1: TSlaveTunnel;
    Panel1: TPanel;
    btnStart: TBitBtn;
    btnStop: TBitBtn;
    Panel2: TPanel;
    Panel3: TPanel;
    lblSlaves: TLabel;
    Label3: TLabel;
    lblServices: TLabel;
    Label4: TLabel;
    tmrRefresh: TTimer;
    lblClients: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    procedure tmrRefreshTimer(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.tmrRefreshTimer(Sender: TObject);
begin
  if SlaveTunnel1.Active then begin
    lblClients.Caption := IntToStr(SlaveTunnel1.NumClients);
  end;

  if MasterTunnel1.Active then begin
    lblSlaves.Caption := IntToStr(MasterTunnel1.NumSlaves);
    lblServices.Caption := IntToStr(MasterTunnel1.NumServices);
  end;
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  btnStart.Enabled := False;
  btnStop.Enabled := True;
  MasterTunnel1.Active := True;
  SlaveTunnel1.Active := True;
  tmrRefresh.Enabled := True;
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  tmrRefresh.Enabled := False;
  btnStart.Enabled := True;
  btnStop.Enabled := False;
  SlaveTunnel1.Active := False;
  sleep(100); // only for Master to realize that something happened
              // before printing to the screen. It is not needed in real
              // app
  if MasterTunnel1.Active then begin
    lblSlaves.Caption := IntToStr(MasterTunnel1.NumSlaves);
    lblServices.Caption := IntToStr(MasterTunnel1.NumServices);
  end;
  MasterTunnel1.Active := False;
end;

end.
