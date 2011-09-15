unit ListingForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, FolderList, Winshoes, WinshoeMessage, NNTPWinshoe;

type
  TformListing = class(TForm)
    NNTP: TWinshoeNNTP;
    Animate1: TAnimate;
    butnCancel: TButton;
    lablStatus: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure NNTPNewsgroupList(const sNewsgroup: string;
      const lLow, lHigh: Integer; const sType: string; var CanContinue: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure butnCancelClick(Sender: TObject);
    procedure NNTPStatus(Sender: TComponent; const sOut: String);
  private
    FHostData: THostData;
    FDownloadCount: Integer;
    FCanContinue: Boolean;
    procedure SetHostData(Value: THostData);
  protected
    procedure SetStatusCaption(Value: string);
  public
    property HostData: THostData read FHostData write SetHostData;
  end;

implementation

uses
  Datamodule;

{$R *.DFM}

procedure TformListing.SetHostData(Value: THostData);
begin
  FHostData := Value;
  with NNTP do begin
    Host     := FHostData.HostName;
    Port     := FHostData.Port;
    UserID   := FHostData.UserID;
    Password := FHostData.Password;
  end;

  Caption := 'Downloading Newsgroups from '+FHostData.HostName;
  FCanContinue := True;
end;

procedure TformListing.SetStatusCaption(Value: string);
begin
  lablStatus.Caption := Value;
  lablStatus.Update;
end;

procedure TformListing.NNTPNewsgroupList(const sNewsgroup: string;
  const lLow, lHigh: Integer; const sType: string; var CanContinue: Boolean);
begin
  Inc(FDownloadCount);
  SetStatusCaption(Format('Downloading newsgroups: %d received...', [FDownloadCount]));

  with dataMain, tablNewsgroups do begin
    if not FindKey([FHostData.HostID, sNewsgroup]) then begin
      Append;
      tablNewsgroupsNewsgroup_Name.Value := sNewsgroup;
      tablNewsgroupsNewsgroup_Desc.Value := sNewsgroup;
      tablNewsgroupsHost_ID.Value        := FHostData.HostID;
      tablNewsgroupsSubscribed.Value     := False;
      tablNewsgroupsMsg_High.Value       := lHigh;
      Post;
    end;
  end;

  Application.ProcessMessages;
  CanContinue := FCanContinue;
end;

procedure TformListing.FormActivate(Sender: TObject);
begin
  Refresh;
  dataMain.tablNewsgroups.IndexName := 'IX_HostNewsgroup';
  try
    Animate1.Active := True;
    with NNTP do begin
      Connect;
      try
        GetNewsgroupList;
      finally
        Disconnect;
        SetStatusCaption('Updating display, please wait...');
      end;
    end;
  finally
    dataMain.tablNewsgroups.IndexName := '';
  end;
end;

procedure TformListing.butnCancelClick(Sender: TObject);
begin
  FCanContinue := False;
end;

procedure TformListing.NNTPStatus(Sender: TComponent; const sOut: String);
begin
  SetStatusCaption(Trim(sOut));
end;

end.
