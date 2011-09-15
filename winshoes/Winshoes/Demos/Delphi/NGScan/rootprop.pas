unit RootProp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, FolderList;

type
  TformRootProp = class(TForm)
    panlButtons: TPanel;
    butnOk: TButton;
    butnCancel: TButton;
    butnApply: TButton;
    Panel1: TPanel;
    pctlMain: TPageControl;
    procedure DetermineProtection(Sender: TObject); virtual;
    procedure butnCancelClick(Sender: TObject);
    procedure OkApplyClick(Sender: TObject);
  private
    FChangesPosted: Boolean;
  protected
    FOrigData: TObjectData;
    FWorkData: TObjectData;
    FDataClass: TObjectDataClass;
    procedure PositionFocus(Control: TWinControl);
    procedure FocusRequiredMsg(const LabelText: string; Control: TWinControl);
    function ApplyCheck : Boolean;
    procedure SetOrigData(Value: TObjectData);
    procedure WorkDataToComponents; virtual; abstract;
    procedure ComponentsToWorkData; virtual; abstract;
    function ValidDefinition : Boolean; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    property OrigData: TObjectData read FOrigData write SetOrigData;
    property ChangesPosted: Boolean read FChangesPosted;
  end;

implementation

uses
  DemoUtils;
  
{$R *.DFM}

constructor TformRootProp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataClass := TObjectData;
end;

procedure TformRootProp.PositionFocus(Control: TWinControl);
var
  Cmp: TWinControl;
begin
  Cmp := Control.Parent;
  while Assigned(Cmp) do begin
    if Cmp is TTabSheet then begin
      TTabSheet(Cmp).PageControl.ActivePage := TTabSheet(Cmp);
      Control.SetFocus;
      Exit;
    end else
      Cmp := Cmp.Parent;
  end;
end;

procedure TformRootProp.FocusRequiredMsg(const LabelText: string; Control: TWinControl);
begin
  PositionFocus(Control);
  MessageDlg(LabelText + ' is a required field, please specify.', mtWarning, [mbOk], 0);
end;

function TformRootProp.ApplyCheck : Boolean;
begin
  Result := ValidDefinition;
  if Result then begin
    ComponentsToWorkData;
    FWorkData.Save;
    FOrigData.Assign(FWorkData);
    FChangesPosted := True;
    FOrigData.DataUpdate;
  end;
end;

procedure TformRootProp.SetOrigData(Value: TObjectData);
begin
  FOrigData := Value;
  if Assigned(FWorkData) then
    FWorkData.Free;

  FWorkData := FDataClass.Create(FOrigData.RefID);
  FWorkData.Assign(FOrigData);
  WorkDataToComponents;
end;

procedure TformRootProp.DetermineProtection(Sender: TObject);
begin
  {}
end;

procedure TformRootProp.butnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TformRootProp.OkApplyClick(Sender: TObject);
begin
  if ApplyCheck then begin
    if Sender = butnOk then
      Close;
  end;
end;

end.
