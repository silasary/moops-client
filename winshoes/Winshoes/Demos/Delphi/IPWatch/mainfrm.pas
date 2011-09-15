unit mainfrm;

////////////////////////////////////////////////////////////////////////////////
// *************************************************************
// Demo for IPWatch. Simple component determines Online status,
// returns current IP address, and keeps history on IP's issued.
// *************************************************************
// ..
// Author: Dave Nosker
//         AfterWave Technologies
//         (allbyte@jetlink.net)
// ..
// 5.20.99 First Version
// 5.22.99 Fixed Ip History not displaying Total on startup.
////////////////////////////////////////////////////////////////////////////////

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ipwatchwinshoe, Buttons;

type
  TMainForm = class(TForm)
    WinshoeIPWatch1: TWinshoeIPWatch;
    HistLb: TListBox;
    HistoryPanel: TPanel;
    ToolBarPanel: TPanel;
    HideHistBtn: TSpeedButton;
    ShowHistBtn: TSpeedButton;
    MinimizeAppBtn: TSpeedButton;
    StayOnTopBtn: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    OnLineDisplay: TPanel;
    IPDisplay: TPanel;
    PrevIp: TPanel;
    NumHist: TPanel;
    procedure WinshoeIPWatch1StatusChanged(Sender: TObject);
    procedure HistBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StayOnTopBtnClick(Sender: TObject);
    procedure MinimizeAppBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FHistoryShowing : Boolean;
    procedure SetHeightLarge(DoLarge : Boolean);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.SetHeightLarge(DoLarge : Boolean);
begin
  if DoLarge then
    ClientHeight := ToolBarPanel.Height + HistoryPanel.Height + 80
  else
    ClientHeight := ToolBarPanel.Height + HistoryPanel.Height + 2;
end;


procedure TMainForm.WinshoeIPWatch1StatusChanged(Sender: TObject);
begin
  if WinshoeIPWatch1.IsOnline then
   begin
    OnLineDisplay.Font.Color := clLime;
    OnLineDisplay.Caption := 'Online';
    IPDisplay.Visible := true;
    IPDisplay.Caption := WinshoeIPWatch1.CurrentIP;
    Caption := WinshoeIPWatch1.CurrentIP;
   end
  else
   begin
    IPDisplay.Visible := false;
    OnLineDisplay.Font.Color := clwhite;
    OnLineDisplay.Caption := 'Offline';
    Caption := 'Offline';
   end;
   Application.Title := Caption;
   with WinshoeIPWatch1 do
   begin
     NumHist.Caption := IntToStr(IPHistoryList.count);
     if PreviousIP <> '' then PrevIp.Caption := PreviousIP;
     // Update HistLb to reflect items in history list...
     if IPHistoryList.Count > 0 then
     begin
       HistLb.Clear;
       HistLb.Items.Text := IPHistoryList.Text;
       ShowHistBtn.Enabled := True;
     end;
   end;
end;

procedure TMainForm.HistBtnClick(Sender: TObject);
begin
  if Sender = ShowHistBtn then
  begin
    if FHistoryShowing then Exit;
    SetHeightLarge(True);
    // Make sure bottom is completely visible...
    if (Top + Height) > Screen.Height then
      Top := Screen.Height - Height;
  end
  else
  begin
    if not FHistoryShowing then Exit;
    SetHeightLarge(False);
  end;
  FHistoryShowing := not FHistoryShowing;
  HistLb.Visible := not HistLb.Visible;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  SetHeightLarge(False);
  FHistoryShowing := False;
  Application.Title := 'IpWatchDemo';
  HistLb.Items.Text := WinshoeIPWatch1.IPHistoryList.Text;
  NumHist.Caption := IntToStr(WinshoeIPWatch1.IPHistoryList.count);
  PrevIp.Caption := WinshoeIPWatch1.PreviousIP;
end;

procedure TMainForm.StayOnTopBtnClick(Sender: TObject);
begin
  if StayOnTopBtn.Down then
    FormStyle:= fsStayOnTop
  else FormStyle:= fsNormal;
end;

procedure TMainForm.MinimizeAppBtnClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
 // Force the first showings position to Bottom
 // left of the screen...
 Top := Screen.Height - (Height+30);
 Left := 20;
end;

end.
