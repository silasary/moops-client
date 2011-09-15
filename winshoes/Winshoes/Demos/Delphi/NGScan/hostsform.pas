unit HostsForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RootProp, ComCtrls, StdCtrls, ExtCtrls, Mask;

type
  TformHosts = class(TformRootProp)
    tshtGeneral: TTabSheet;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    editHostDesc: TEdit;
    Bevel2: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    editFullName: TEdit;
    Label5: TLabel;
    editOrganization: TEdit;
    Label6: TLabel;
    editEmail: TEdit;
    Label7: TLabel;
    editReply: TEdit;
    cboxIncludeDuringScan: TCheckBox;
    tshtServer: TTabSheet;
    Label8: TLabel;
    Bevel3: TBevel;
    Label9: TLabel;
    editHostName: TEdit;
    cboxLoginRequired: TCheckBox;
    lablUserID: TLabel;
    editUserID: TEdit;
    lablPassword: TLabel;
    editPassword: TEdit;
    tshtAdvanced: TTabSheet;
    Label12: TLabel;
    Bevel4: TBevel;
    Label13: TLabel;
    medtPort: TMaskEdit;
    butnUseDefault: TButton;
    Image1: TImage;
    procedure DetermineProtection(Sender: TObject); override;
    procedure butnUseDefaultClick(Sender: TObject);
    procedure medtPortChange(Sender: TObject);
    procedure SetPropertyCaption(Sender: TObject);
  private
  protected
    procedure WorkDataToComponents; override;
    procedure ComponentsToWorkData; override;
    function ValidDefinition : Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  FolderList, Datamodule, DemoUtils;

{$R *.DFM}

constructor TformHosts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataClass := THostData;
end;

procedure TformHosts.DetermineProtection(Sender: TObject);
begin
  editUserID.Enabled   := cboxLoginRequired.Checked;
  editPassword.Enabled := cboxLoginRequired.Checked;
  lablUserID.Enabled   := cboxLoginRequired.Checked;
  lablPassword.Enabled := cboxLoginRequired.Checked;
  ControlColorCheck([editUserID, editPassword]);
end;

procedure TformHosts.SetPropertyCaption(Sender: TObject);
begin
  Caption := editHostDesc.Text + ' Properties';
end;

procedure TformHosts.WorkDataToComponents;
begin
  with THostData(FWorkData) do begin
    editHostName.Text := HostName;
    editHostDesc.Text := HostDesc;
    editFullName.Text := FullName;
    editOrganization.Text := Organization;
    editEmail.Text := Email;
    editReply.Text := Reply;
    cboxIncludeDuringScan.Checked := IncludeDuringScan;
    medtPort.Text := IntToStr(Port);
    cboxLoginRequired.Checked := LoginRequired;
    editUserID.Text := UserID;
    editPassword.Text := Password;
  end;

  SetPropertyCaption(nil);
end;

procedure TformHosts.ComponentsToWorkData;
begin
  with THostData(FWorkData) do begin
    HostName := editHostName.Text;
    HostDesc := editHostDesc.Text;
    FullName := editFullName.Text;
    Organization := editOrganization.Text;
    Email := editEmail.Text;
    Reply := editReply.Text;
    IncludeDuringScan := cboxIncludeDuringScan.Checked;
    Port := StrToInt(medtPort.Text);
    LoginRequired := cboxLoginRequired.Checked;
    UserID := editUserID.Text;
    Password := editPassword.Text;
  end;
end;

function TformHosts.ValidDefinition : Boolean;
begin
  Result := False;

  if editFullName.Text = '' then begin
    FocusRequiredMsg('Name', editFullName);
    Exit;
  end;

  if editEmail.Text = '' then begin
    FocusRequiredMsg('E-mail address', editEmail);
    Exit;
  end;

  if editHostName.Text = '' then begin
    FocusRequiredMsg('Server name', editHostName);
    Exit;
  end;

  if cboxLoginRequired.Checked then begin
    if editUserID.Text = '' then begin
      FocusRequiredMsg('Account Name', editUserID);
      Exit;
    end;

    if editPassword.Text = '' then begin
      FocusRequiredMsg('Password', editPassword);
      Exit;
    end;
  end;

  if medtPort.Text = '' then begin
    FocusRequiredMsg('News (NNTP)', medtPort);
    Exit;
  end;

  {-Perform clean up}
  if editHostDesc.Text = '' then editHostDesc.Text := editHostName.Text;
  if editReply.Text = '' then editReply.Text := editEmail.Text;

  Result := True;
end;

procedure TformHosts.butnUseDefaultClick(Sender: TObject);
begin
  medtPort.Text := '119';
end;

procedure TformHosts.medtPortChange(Sender: TObject);
begin
  medtPort.Text := Trim(medtPort.Text);
end;

end.
