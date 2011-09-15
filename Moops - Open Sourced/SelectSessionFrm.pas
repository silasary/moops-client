unit SelectSessionFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, IniFiles, Common, SessionOptFrm, Menus, CheckLst,
  Placemnt;

const
  WM_OPENSESSION = WM_USER + 203;

type
  TSelectSessionForm = class(TForm)
    Label1: TLabel;
    OkButton: TBitBtn;
    CancelButton: TBitBtn;
    NewButton: TBitBtn;
    DelButton: TBitBtn;
    ShowOnStartupBox: TCheckBox;
    EditButton: TBitBtn;
    SessionList: TCheckListBox;
    AutoButton: TBitBtn;
    FormPlacement: TFormPlacement;
    procedure SessionListDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SessionListKeyPress(Sender: TObject; var Key: Char);
    procedure SessionListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure AutoButtonClick(Sender: TObject);
    procedure SessionListClickCheck(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SessionNames: TStringList;
    procedure RefreshList;
    function SelectSession(var FileName: string): Boolean;
    procedure AutoStart;
  end;

var
  SelectSessionForm: TSelectSessionForm;

implementation

uses MainFrm;

{$R *.DFM}

procedure TSelectSessionForm.SessionListDblClick(Sender: TObject);
begin
  if OKButton.Enabled then
    OKButton.Click;
end;

procedure TSelectSessionForm.FormActivate(Sender: TObject);
begin
  RefreshList;
end;

procedure TSelectSessionForm.RefreshList;
var
  SR: TSearchRec;
  I, OldIndex: Integer;
  Ini: TIniFile;
  BaseName, Txt: string;
  Item: TMenuItem;
begin
  OldIndex:=SessionList.ItemIndex;
  if OldIndex<0 then OldIndex:=0;
  SessionList.Items.Clear;
  SessionNames.Clear;
  BaseName:=AppDir+'Sessions\';
  if FindFirst(BaseName+'*.mse',faAnyFile,SR)=0 then
  begin
    SessionNames.Add(BaseName+SR.Name);
    while FindNext(SR) = 0 do SessionNames.Add(BaseName+SR.Name);
    FindClose(SR);
  end;
  for I:=0 to SessionNames.Count-1 do
  begin
    Ini:=TIniFile.Create(SessionNames[I]);
    try
      Txt:=Ini.ReadString('Session','Description','');
      if Txt='' then Txt:='(no description)';
      SessionList.Items.Add(Txt);
      SessionList.Checked[SessionList.Items.Count-1]:=Ini.ReadBool('Session','AutoStart',False);
    finally
      Ini.Free;
    end;
  end;
  if OldIndex<SessionList.Items.Count then SessionList.ItemIndex:=OldIndex;
  SessionListClick(nil); // to update the buttons

  // now update the menu in MainForm
  with MainForm.SessionsMenu do
  begin
    for I:=Count-1 downto 0 do
      Items[I].Free;
    Item:=TMenuItem.Create(Self);
    Item.Action:=MainForm.SesCurEdit;
    Add(Item);
    Item:=TMenuItem.Create(Self);
    Item.Action:=MainForm.SesNewSession;
    Add(Item);
    Item:=TMenuItem.Create(Self);
    Item.Caption:='-';
    Add(Item);
  end;
  for I:=0 to SessionList.Items.Count-1 do
  begin
    Item:=TMenuItem.Create(Self);
    Item.Caption:=SessionList.Items[I];
    Item.OnClick:=MainForm.SessionsMenuItemClick;
    Item.Tag:=I;
    MainForm.SessionsMenu.Add(Item);
  end;
end;

procedure TSelectSessionForm.SessionListKeyPress(Sender: TObject;
  var Key: Char);
begin
  SessionListClick(Sender);
end;

procedure TSelectSessionForm.SessionListClick(Sender: TObject);
begin
  OKButton.Enabled:=SessionList.ItemIndex>=0;
  EditButton.Enabled:=SessionList.ItemIndex>=0;
  DelButton.Enabled:=SessionList.ItemIndex>=0;
end;

procedure TSelectSessionForm.FormCreate(Sender: TObject);
begin
  FormPlacement.IniFileName:=AppDir+'Moops.ini';
  SessionNames:=TStringList.Create;
end;

procedure TSelectSessionForm.FormDestroy(Sender: TObject);
begin
  SessionNames.Free;
end;

function TSelectSessionForm.SelectSession(var FileName: string): Boolean;
var
  I: Integer;
  Empty: Boolean;
begin
  RefreshList;

  if SessionList.Items.Count=0 then
    NewButtonClick(nil);

  Empty:=True;
  for I:=0 to SessionList.Items.Count-1 do
    if SessionList.Checked[I] then begin Empty:=False; Break; end;
  if Empty then
    ActiveControl:=OKButton
  else
    ActiveControl:=AutoButton;

  if ShowModal=mrOk then
    FileName:=SessionNames[SessionList.ItemIndex]
  else
    FileName:='';
  Result:=FileName<>'';
end;

procedure TSelectSessionForm.NewButtonClick(Sender: TObject);
begin
  SessionOptForm.SetDefaults;
  SessionOptForm.ShowModal;
  RefreshList;
end;

procedure TSelectSessionForm.EditButtonClick(Sender: TObject);
begin
  if SessionOptForm.LoadSession(SessionNames[SessionList.ItemIndex]) then
  begin
    SessionOptForm.ShowModal;
    RefreshList;
  end;
end;

procedure TSelectSessionForm.DelButtonClick(Sender: TObject);
begin
  if Application.MessageBox('Are you SURE you want to delete this session?','Moops!',MB_YESNO+MB_ICONWARNING)=IDYES then
  begin
    if not DeleteFile(SessionNames[SessionList.ItemIndex]) then
      Application.MessageBox('Error deleting session!','Moops!',MB_ICONERROR);
    RefreshList;
  end;
end;

procedure TSelectSessionForm.AutoButtonClick(Sender: TObject);
var
  I: Integer;
  Empty: Boolean;
begin
  Empty:=True;
  for I:=0 to SessionList.Items.Count-1 do
    if SessionList.Checked[I] then
    begin
      MainForm.LoadSession(SessionNames[I]);
      Empty:=False;
    end;
  if Empty then
  begin
    Application.MessageBox('Please select the checkboxes of the sessions you would like to be loaded with AutoStart.','Moops!',MB_ICONINFORMATION);
    ModalResult:=mrNone;
  end;
end;

procedure TSelectSessionForm.AutoStart;
var
  I: Integer;
begin
  RefreshList;
  Application.ProcessMessages;
  for I:=0 to SessionList.Items.Count-1 do
    if SessionList.Checked[I] then
      MainForm.LoadSession(SessionNames[I]);
end;

procedure TSelectSessionForm.SessionListClickCheck(Sender: TObject);
begin
  with SessionOptForm do
  begin
    UpdateMainForm:=False;
    LoadSession(SessionNames[SessionList.ItemIndex]);
    AutoStartBox.Checked:=SessionList.Checked[SessionList.ItemIndex];
    SaveSession(SessionNames[SessionList.ItemIndex]);
    UpdateMainForm:=True;
  end;
end;

end.
