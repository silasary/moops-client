{+-----------------------------------------------------------------------------+
 | Unit:        mwEditPropertyReg
 | Created:     1999-10-31
 | Version:     0.88
 | Last change: 1999-10-31
 |
 | Property editors for the mwEdit component suite
 | (moved into this unit to separate design-time only code)
 +----------------------------------------------------------------------------+}

unit mwEditPropertyReg;

{$I mwEdit.inc}

interface

procedure Register;

implementation

uses
  Classes, DsgnIntf, Dialogs, Forms, Graphics, Controls, 
  mwCustomEdit, mwKeyCmds, mwKeyCmdsEditor;

type
  TmwEditorFontProperty = class(TFontProperty)
  public
    procedure Edit; override;
  end;

  TmwEditorCommandProperty = class(TIntegerProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TmwKeyStrokesProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

{ TmwEditorFontProperty }

procedure TmwEditorFontProperty.Edit;
const
  { context ids for the Font editor }
  hcDFontEditor = 25000;
var
  FontDialog: TFontDialog;
begin
  FontDialog := TFontDialog.Create(Application);
  try
    FontDialog.Font := TFont(GetOrdValue);
    FontDialog.HelpContext := hcDFontEditor;
    FontDialog.Options := FontDialog.Options + [fdShowHelp, fdForceFontExist,
       fdFixedPitchOnly];
    if FontDialog.Execute then
      SetOrdValue(Longint(FontDialog.Font));
  finally
    FontDialog.Free;
  end;
end;

{ TmwEditorCommandProperty }

procedure TmwEditorCommandProperty.Edit;
begin
  ShowMessage('I''m thinking that this will show a dialog that has a list'#13#10+
     'of all editor commands and a description of them to choose from.');
end;

function TmwEditorCommandProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog, paValueList, paRevertable];
end;

function TmwEditorCommandProperty.GetValue: string;
begin
  Result := EditorCommandToCodeString(TmwEditorCommand(GetOrdValue));
end;

procedure TmwEditorCommandProperty.GetValues(Proc: TGetStrProc);
begin
  GetEditorCommandValues(Proc);
end;

procedure TmwEditorCommandProperty.SetValue(const Value: string);
var
  NewValue: longint;
begin
  if IdentToEditorCommand(Value, NewValue) then
    SetOrdValue(NewValue)
  else
    inherited SetValue(Value);
end;

{ TmwKeyStrokesProperty }

procedure TmwKeyStrokesProperty.Edit;
var
  Dlg: TmwKeystrokesEditorForm;
begin
  Application.CreateForm(TmwKeystrokesEditorForm, Dlg);
  try
    Dlg.Caption := Self.GetName;
    Dlg.Keystrokes := TmwKeystrokes(GetOrdValue);
    if Dlg.ShowModal = mrOk then
    begin
      { SetOrdValue will operate on all selected propertiy values }
      SetOrdValue(Longint(Dlg.Keystrokes));
      Modified;
    end;
  finally
    Dlg.Free;
  end;
end;

function TmwKeyStrokesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

{ Register }

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TFont), TmwCustomEdit,
     'Font', TmwEditorFontProperty);
  RegisterPropertyEditor(TypeInfo(TmwEditorCommand), NIL,
     'Command', TmwEditorCommandProperty);
  RegisterPropertyEditor(TypeInfo(TmwKeystrokes), NIL, '',
     TmwKeyStrokesProperty);
end;

end.
