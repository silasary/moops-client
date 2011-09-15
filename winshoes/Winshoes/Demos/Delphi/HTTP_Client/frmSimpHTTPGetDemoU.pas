 unit frmSimpHTTPGetDemoU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, simphttp, WinInetControl, ComCtrls,
  SimpFTP;

type
  TfrmSimpHTTPGetDemo = class(TForm)
    SimpleHTTP1: TSimpleHTTP;
    memHead: TMemo;
    memBody: TMemo;
    pnlAddress: TPanel;
    btnGet: TButton;
    edtURL: TEdit;
    Splitter1: TSplitter;
    stbMain: TStatusBar;
    pbMain: TProgressBar;
    procedure btnGetClick(Sender: TObject);
    procedure edtURLKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure stbMainDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
  private
  public
  end;

var
  frmSimpHTTPGetDemo: TfrmSimpHTTPGetDemo;

implementation
{$R *.DFM}

procedure TfrmSimpHTTPGetDemo.btnGetClick(Sender: TObject);
var
  ssResult: TStringStream;
begin
  Screen.Cursor := crHourGlass;
  try
    ssResult := TStringStream.Create('');
    try
      with SimpleHTTP1 do begin
        Head(edtURL.Text);
        memHead.Text := HTTPHeaderInfo.RawHeader;
        Get(edtURL.Text, ssResult);
        memBody.Text := AdjustLineBreaks(ssResult.DataString);
      end;
    finally
      ssResult.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmSimpHTTPGetDemo.edtURLKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_RETURN then
    btnGetClick(edtURL);
end;


procedure TfrmSimpHTTPGetDemo.FormCreate(Sender: TObject);
begin
  SimpleHTTP1.ConnectTimeOut := 5000;
  pbMain.Parent := stbMain;
end;

procedure TfrmSimpHTTPGetDemo.stbMainDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  newRect: TRect;
begin
  If Panel.Index <> 1 then
    exit;

  newRect := Rect;
  InflateRect(newRect, 1, 1);
  pbMain.BoundsRect := newRect;
end;


end.
