{+-----------------------------------------------------------------------------+
 | Unit:        mwKeyCmdEditor
 | Version:     0.88
 | Last change: 1999-11-07
 +----------------------------------------------------------------------------+}

unit mwKeyCmdEditor;

{$I MWEDIT.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, mwKeyCmds, Menus;

type
  TmwKeystrokeEditorForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    cmbCommand: TComboBox;
    hkKeystroke: THotKey;
    btnOK: TButton;
    btnCancel: TButton;
    bntClearKey: TButton;
    Label4: TLabel;
    hkKeystroke2: THotKey;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bntClearKeyClick(Sender: TObject);
  private
    procedure SetCommand(const Value: TmwEditorCommand);
    procedure SetKeystroke(const Value: TShortcut);
    procedure AddEditorCommand(const S: string);
    function GetCommand: TmwEditorCommand;
    function GetKeystroke: TShortcut;
    function GetKeystroke2: TShortcut;
    procedure SetKeystroke2(const Value: TShortcut);
  public
    property Command: TmwEditorCommand read GetCommand write SetCommand;
    property Keystroke: TShortcut read GetKeystroke write SetKeystroke;
    property Keystroke2: TShortcut read GetKeystroke2 write SetKeystroke2;
  end;

var
  mwKeystrokeEditorForm: TmwKeystrokeEditorForm;

implementation

{$R *.DFM}

{ TForm2 }

procedure TmwKeystrokeEditorForm.SetCommand(const Value: TmwEditorCommand);
begin
  cmbCommand.Text := EditorCommandToCodeString(Value);
end;

procedure TmwKeystrokeEditorForm.SetKeystroke(const Value: TShortcut);
begin
  hkKeystroke.Hotkey := Value;
end;

procedure TmwKeystrokeEditorForm.FormCreate(Sender: TObject);
begin
  GetEditorCommandValues(AddEditorCommand);
end;

procedure TmwKeystrokeEditorForm.AddEditorCommand(const S: string);
begin
  cmbCommand.Items.Add(S);
end;

function TmwKeystrokeEditorForm.GetCommand: TmwEditorCommand;
var
  NewCmd: longint;
begin
  if not IdentToEditorCommand(cmbCommand.Text, NewCmd) then
  begin
     try
       NewCmd := StrToInt(cmbCommand.Text);
     except
       NewCmd := ecNone;
     end;
  end;
  Result := NewCmd;
end;

function TmwKeystrokeEditorForm.GetKeystroke: TShortcut;
begin
  Result := hkKeystroke.HotKey;
end;

procedure TmwKeystrokeEditorForm.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  // THotKey uses backspace to remove the current keystroke.  That would prevent
  // us from assigning backspace to anything.  We have to handle it here.
  if (Key = VK_BACK) and (hkKeystroke.Focused) then
  begin
    hkKeystroke.HotKey := Menus.ShortCut(Key, Shift);
    Key := 0;  // Eat the key so THotKey doesn't get it.
  end;
  if (Key = VK_BACK) and (hkKeystroke2.Focused) then
  begin
    hkKeystroke2.HotKey := Menus.ShortCut(Key, Shift);
    Key := 0;  // Eat the key so THotKey doesn't get it.
  end;
end;

procedure TmwKeystrokeEditorForm.bntClearKeyClick(Sender: TObject);
begin
  hkKeystroke.HotKey := 0;
  hkKeystroke2.HotKey := 0;
end;

function TmwKeystrokeEditorForm.GetKeystroke2: TShortcut;
begin
  Result := hkKeystroke2.HotKey;
end;

procedure TmwKeystrokeEditorForm.SetKeystroke2(const Value: TShortcut);
begin
  hkKeystroke2.Hotkey := Value;
end;

end.
 
