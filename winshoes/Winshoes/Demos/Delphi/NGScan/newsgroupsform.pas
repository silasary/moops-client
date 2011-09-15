unit NewsgroupsForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RootProp, ComCtrls, StdCtrls, ExtCtrls, Mask;

type
  TformNewsgroups = class(TformRootProp)
    tshtGeneral: TTabSheet;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    editNewsgroupDesc: TEdit;
    Label3: TLabel;
    Bevel2: TBevel;
    Label4: TLabel;
    medtHiMsg: TMaskEdit;
    cboxSubscribed: TCheckBox;
    Image1: TImage;
    procedure DetermineProtection(Sender: TObject); override;
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
  FolderList;

{$R *.DFM}

constructor TformNewsgroups.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataClass := TNewsgroupData;
end;

procedure TformNewsgroups.DetermineProtection(Sender: TObject);
begin
  {}
end;

procedure TformNewsgroups.SetPropertyCaption(Sender: TObject);
begin
  Caption := editNewsgroupDesc.Text + ' Properties';
end;

procedure TformNewsgroups.WorkDataToComponents;
begin
  with TNewsgroupData(FWorkData) do begin
    editNewsgroupDesc.Text := NewsgroupDesc;
    cboxSubscribed.Checked := Subscribed;
    medtHiMsg.Text := IntToStr(HiMsg);
  end;

  SetPropertyCaption(nil);
end;

procedure TformNewsgroups.ComponentsToWorkData;
begin
  with TNewsgroupData(FWorkData) do begin
    NewsgroupDesc := editNewsgroupDesc.Text;
    Subscribed := cboxSubscribed.Checked;
    HiMsg := StrToInt(medtHiMsg.Text);
  end;
end;

function TformNewsgroups.ValidDefinition : Boolean;
begin
  Result := False;

  if medtHiMsg.Text = '' then begin
    FocusRequiredMsg('Last article retrieved', medtHiMsg);
    Exit;
  end;

  {-Perform clean up}
  if editNewsgroupDesc.Text = '' then
    editNewsgroupDesc.Text := TNewsgroupData(FWorkData).NewsgroupName;
 
  Result := True;
end;

end.
