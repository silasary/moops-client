unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    editHost: TEdit;
    Button1: TButton;
    lablResultIP: TLabel;
    Label2: TLabel;
    editIP: TEdit;
    Button2: TButton;
    lablResultHost: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation
{$R *.DFM}

uses
  Winshoes;

procedure TForm1.Button1Click(Sender: TObject);
var
  sIP: string;
begin
  Screen.Cursor := crHourglass; try
    TWinshoe.ResolveHost(editHost.Text, sIP);
    lablResultIP.Caption := 'The IP address is ' + sIP;
    editIP.Text := sIP;
  finally Screen.Cursor := crDefault; end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  sHost: string;
begin
  Screen.Cursor := crHourglass; try
    sHost := TWinshoe.ResolveIP(editIP.Text);
    if sHost = '' then begin
      ShowMessage('No host record found. (Not all IPs can be reversed to their host)');
    end else begin
      lablResultHost.Caption := 'The host name is ' + sHost;
      editHost.Text := sHost;
    end;
  finally Screen.Cursor := crDefault; end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet1;
end;

end.
