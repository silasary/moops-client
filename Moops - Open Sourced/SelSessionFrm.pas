unit SelSessionFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

const
  WM_OPENSESSION = WM_USER + 202;

type
  PScriptSession = ^TScriptSession;
  TScriptSession = record
    FileName: string;
  end;

  TSelSessionForm = class(TForm)
    Label1: TLabel;
    ScriptList: TListBox;
    OkButton: TBitBtn;
    CancelButton: TBitBtn;
    AddButton: TBitBtn;
    DelButton: TBitBtn;
    ShowOnStartupBox: TCheckBox;
    procedure ScriptListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScriptListKeyPress(Sender: TObject; var Key: Char);
    procedure AddButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure ScriptListDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoAdd(const FileName, Descr: string);
  public
    { Public declarations }
    procedure AddSession(const S: string);
    function SelectSession(var FileName: string): Boolean;
    procedure UpdateButtons;
    procedure FreeItem(Nr: Integer);
    procedure ClearAll;
  end;

var
  SelSessionForm: TSelSessionForm;

implementation

uses
  MainFrm, AddSessionFrm;

{$R *.DFM}

procedure TSelSessionForm.UpdateButtons;
begin
  OKButton.Enabled:=ScriptList.Items.Count>0;
  DelButton.Enabled:=ScriptList.ItemIndex>-1;
end;

procedure TSelSessionForm.DoAdd(const FileName, Descr: string);
var
  Session: PScriptSession;
begin
  GetMem(Session,SizeOf(TScriptSession));
  Pointer(Session.FileName):=nil;
  Session.FileName:=FileName;
  ScriptList.Items.AddObject(Descr,Pointer(Session));
  ScriptList.ItemIndex:=ScriptList.Items.Count-1;
end;

procedure TSelSessionForm.AddSession(const S: string);
var
  P: Integer;
  Descr, FileName: string;
begin
  P:=Pos('=',S);
  if P=0 then Exit;
  FileName:=Copy(S,1,P-1);
  Descr:=Copy(S,P+1,Length(S));
  if FileName='ShowOnStartup' then Exit; // This is the checkbox
  DoAdd(FileName,Descr);
  UpdateButtons;
end;

function TSelSessionForm.SelectSession(var FileName: string): Boolean;
begin
  if ScriptList.Items.Count=0 then
    AddButtonClick(nil);
  UpdateButtons;
  ScriptList.ItemIndex:=0;
  if ShowModal=mrOk then
    FileName:=PScriptSession(ScriptList.Items.Objects[ScriptList.ItemIndex])^.FileName
  else
    FileName:='';
  Result:=FileName<>'';
end;

procedure TSelSessionForm.ScriptListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  UpdateButtons;
end;

procedure TSelSessionForm.ScriptListKeyPress(Sender: TObject;
  var Key: Char);
begin
  UpdateButtons;
end;

procedure TSelSessionForm.AddButtonClick(Sender: TObject);
var
  FileName, Descr: string;
begin
  if AddSessionForm.AddSession(FileName,Descr) then
    DoAdd(FileName,Descr);
end;

procedure TSelSessionForm.DelButtonClick(Sender: TObject);
begin
  FreeItem(ScriptList.ItemIndex);
end;

procedure TSelSessionForm.FreeItem(Nr: Integer);
var
  Session: PScriptSession;
begin
  Session:=Pointer(ScriptList.Items.Objects[Nr]);
  ScriptList.Items.Delete(Nr);
  SetLength(Session.FileName,0);
  FreeMem(Session);
  UpdateButtons;
end;

procedure TSelSessionForm.ClearAll;
begin
  while ScriptList.Items.Count>0 do
    FreeItem(ScriptList.Items.Count-1);
end;

procedure TSelSessionForm.ScriptListDblClick(Sender: TObject);
begin
  if OKButton.Enabled then
    OKButton.Click;
end;

end.
