{-------------------------------------------------------------------------------
 | This unit is copyright Cyrille de Brebisson
 -------------------------------------------------------------------------------
 | Version history:
 |   0.50: source maintained by the autor, version history unknown
 |     - Better support of the completion form when embeded in an MDI
 |       application (thanks to Olivier Deckmyn)
 |     - Added Page up and Page down in the supported keys
 |     - The paint is now done through a bitmat to reduce flickering
 |   0.51: Stefan van As
 |     - Added Menus unit to the uses clause.
 |     - Added FShortCut, SetShortCut and published ShortCut property
 |       (defaults to Ctrl+Space) and ShortCut handling to EditorKeyDown.
 -------------------------------------------------------------------------------}

unit mwCompletionProposal;

interface

uses
  Forms, Classes, StdCtrls, Controls, SysUtils, mwCustomEdit, mwKeyCmds,
  Windows, Graphics, Menus;

type
  TCompletionProposalPaintItem = Function (Key: String; Canvas: TCanvas; x, y: integer): Boolean of object;

  TCompletionProposalForm = class (TForm)
  Protected
    FCurrentString: String;
    FOnKeyPress: TKeyPressEvent;
    FOnKeyDelete: TNotifyEvent;
    FOnPaintItem: TCompletionProposalPaintItem;
    FItemList: TStrings;
    FPosition: Integer;
    FNbLinesInWindow: Integer;
    FFontHeight: integer;
    Scroll: TScrollBar;
    FOnValidate: TNotifyEvent;
    FOnCancel: TNotifyEvent;
    FClSelect: TColor;
    FAnsi: boolean;
    procedure SetCurrentString(const Value: String);
    Procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: char); override;
    Procedure Paint; override;
    procedure ScrollGetFocus(Sender: TObject);
    Procedure Deactivate; override;
    procedure SelectPrec;
    procedure SelectNext;
    procedure ScrollChange(Sender: TObject);
    procedure SetItemList(const Value: TStrings);
    procedure SetPosition(const Value: Integer);
    procedure SetNbLinesInWindow(const Value: Integer);
    Procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    Procedure StringListChange(Sender: TObject);
  private
    Bitmap: TBitmap;  // used for drawing
    fCurrentEditor: TComponent;
  Public
    constructor Create(AOwner: Tcomponent); override;
    destructor destroy; override;
  Published
    Property CurrentString: String read FCurrentString write SetCurrentString;
    Property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    Property OnKeyDelete: TNotifyEvent read FOnKeyDelete write FOnKeyDelete;
    Property OnPaintItem: TCompletionProposalPaintItem read FOnPaintItem write FOnPaintItem;
    Property OnValidate: TNotifyEvent read FOnValidate write FOnValidate;
    Property OnCancel: TNotifyEvent read FOnCancel write FOnCancel;
    Property ItemList: TStrings read FItemList write SetItemList;
    Property Position: Integer read FPosition write SetPosition;
    Property NbLinesInWindow: Integer read FNbLinesInWindow write SetNbLinesInWindow;
    Property ClSelect: TColor read FClSelect write FClSelect;
    Property ffAnsi: boolean read fansi write fansi;
    Property CurrentEditor: tComponent read fCurrentEditor write fCurrentEditor;
  end;

  TCompletionProposal = Class (TComponent)
  private
    Form: TCompletionProposalForm;
    FOnExecute: TNotifyEvent;
    function GetClSelect: TColor;
    procedure SetClSelect(const Value: TColor);
    function GetCurrentString: String;
    function GetItemList: TStrings;
    function GetNbLinesInWindow: Integer;
    function GetOnCancel: TNotifyEvent;
    function GetOnKeyPress: TKeyPressEvent;
    function GetOnPaintItem: TCompletionProposalPaintItem;
    function GetOnValidate: TNotifyEvent;
    function GetPosition: Integer;
    procedure SetCurrentString(const Value: String);
    procedure SetItemList(const Value: TStrings);
    procedure SetNbLinesInWindow(const Value: Integer);
    procedure SetOnCancel(const Value: TNotifyEvent);
    procedure SetOnKeyPress(const Value: TKeyPressEvent);
    procedure SetOnPaintItem(const Value: TCompletionProposalPaintItem);
    procedure SetPosition(const Value: Integer);
    procedure SetOnValidate(const Value: TNotifyEvent);
    function GetOnKeyDelete: TNotifyEvent;
    procedure SetOnKeyDelete(const Value: TNotifyEvent);
    procedure RFAnsi(const Value: boolean);
    function SFAnsi: boolean;
  Public
    Constructor Create(Aowner: TComponent); override;
    Destructor Destroy; Override;
    Procedure Execute(s: string; x, y: integer);
    Property OnKeyPress: TKeyPressEvent read GetOnKeyPress write SetOnKeyPress;
    Property OnKeyDelete: TNotifyEvent read GetOnKeyDelete write SetOnKeyDelete;
    Property OnValidate: TNotifyEvent read GetOnValidate write SetOnValidate;
    Property OnCancel: TNotifyEvent read GetOnCancel write SetOnCancel;
    Property CurrentString: String read GetCurrentString write SetCurrentString;
  Published
    Property OnExecute: TNotifyEvent read FOnExecute Write FOnExecute;
    Property OnPaintItem: TCompletionProposalPaintItem read GetOnPaintItem write SetOnPaintItem;
    Property ItemList: TStrings read GetItemList write SetItemList;
    Property Position: Integer read GetPosition write SetPosition;
    Property NbLinesInWindow: Integer read GetNbLinesInWindow write SetNbLinesInWindow;
    Property ClSelect: TColor read GetClSelect Write SetClSelect;
    Property AnsiStrings: boolean read SFAnsi Write RFAnsi;
  End;

  TMwCompletionProposal = class (TCompletionProposal)
  private
    FShortCut: TShortCut;
    fEditors: TList;
    fEditstuffs: TList;
    FEndOfTokenChr: string;
    procedure SetEditor(const Value: TmwCustomEdit);
    procedure backspace(Senter: TObject);
    procedure Cancel(Senter: TObject);
    procedure Validate(Senter: TObject);
    procedure KeyPress(Sender: TObject; var Key: Char);
    Procedure EditorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    Procedure EditorKeyPress(Sender: TObject; var Key: char);
    Function GetPreviousToken(FEditor: TmwCustomEdit): string;
    function GetFEditor: TmwCustomEdit;
    function GetEditor(i: integer): TmwCustomEdit;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetShortCut(Value: TShortCut);
  public
    Constructor Create(AOwner: TComponent); override;
    destructor destroy; override;
    Property Editors[i: integer]: TmwCustomEdit read GetEditor;
    Procedure AddEditor(Editor: TmwCustomEdit);
    Function RemoveEditor(Editor: TmwCustomEdit): boolean;
    Function EditorsCount: integer;
  published
    property ShortCut: TShortCut read FShortCut write SetShortCut;
    Property Editor: TmwCustomEdit read GetFEditor write SetEditor;
    Property EndOfTokenChr: string read FEndOfTokenChr write FEndOfTokenChr;
  end;

  TmwAutoComplete = class(TComponent)
  private
    FShortCut: TShortCut;
    fEditors: TList;
    fEditstuffs: TList;
    fAutoCompleteList: TStrings;
    FEndOfTokenChr: string;
    Procedure SetAutoCompleteList(List: TStrings);
    function GetEditor(i: integer): TmwCustomEdit;
    function GetEdit: TmwCustomEdit;
    procedure SetEdit(const Value: TmwCustomEdit);
  protected
    procedure SetShortCut(Value: TShortCut);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    Procedure EditorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    Procedure EditorKeyPress(Sender: TObject; var Key: char); virtual;
    Function GetPreviousToken(Editor: tmwCustomEdit): string;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor destroy; override;
    Procedure Execute(token: string; Editor: TmwCustomEdit);
    Property Editors[i: integer]: TmwCustomEdit read GetEditor;
    Procedure AddEditor(Editor: TmwCustomEdit);
    Function RemoveEditor(Editor: TmwCustomEdit): boolean;
    Function EditorsCount: integer;
  published
    Property AutoCompleteList: TStrings read fAutoCompleteList write SetAutoCompleteList;
    Property EndOfTokenChr: string read FEndOfTokenChr write FEndOfTokenChr;
    Property Editor: TmwCustomEdit read GetEdit write SetEdit;
    property ShortCut: TShortCut read FShortCut write SetShortCut;
  end;

  Procedure PretyTextOut(c: TCanvas; x, y: integer; s: String);

  Procedure register;

implementation

uses
  mwLocalStr, mwSupportProcs;

{ TCompletionProposalForm }

constructor TCompletionProposalForm.Create(AOwner: Tcomponent);
begin
  CreateNew(AOwner);
  FItemList:= TStringList.Create;
  BorderStyle:= bsNone;
  width:=262;
  Scroll:= TScrollBar.Create(self);
  Scroll.Kind:= sbVertical;
  Scroll.OnChange:= ScrollChange;
  Scroll.Parent:= self;
  Scroll.OnEnter:= ScrollGetFocus;
  Visible:= false;
  FFontHeight:= Canvas.TextHeight('Cyrille de Brebisson');
  ClSelect:= clAqua;
  TStringList(FItemList).OnChange:= StringListChange;
  bitmap:= TBitmap.Create;
  NbLinesInWindow:= 6;
End;

procedure TCompletionProposalForm.Deactivate;
begin
  Visible:= False;
end;

destructor TCompletionProposalForm.destroy;
begin
  bitmap.free;
  Scroll.Free;
  FItemList.Free;
  inherited destroy;
end;

procedure TCompletionProposalForm.KeyDown(var Key: Word; Shift: TShiftState);
var
  i: integer;
begin
  case key of
    13: if Assigned(OnValidate) then
          OnValidate(Self);
    27,32: if Assigned(OnCancel) then
          OnCancel(Self);
    // I do not think there is a worst way to do this, but laziness rules :-)
    33: for i:=1 to NbLinesInWindow do SelectPrec;
    34: for i:=1 to NbLinesInWindow do SelectNext;
    38: if ssCtrl in Shift then
           Position:= 0
        else
          SelectPrec;
    40: if ssCtrl in Shift then
           Position:= ItemList.count-1
        else
          SelectNext;
    8:  if Shift=[] then
        Begin
          if Length(CurrentString)<>0 then
            begin
              CurrentString:= copy(CurrentString,1,Length(CurrentString)-1);
              if Assigned(OnKeyDelete) then OnKeyDelete(Self);
            end;
          end;
  end;
  paint;
end;

procedure TCompletionProposalForm.KeyPress(var Key: char);
begin
  case key of    //
    #33..'z': Begin
                CurrentString:= CurrentString+key;
                if Assigned(OnKeyPress) then
                  OnKeyPress(self, Key);
              end;
    #8: CurrentString:= CurrentString+key;
    else if Assigned(OnCancel) then OnCancel(Self);
  end;    // case
  paint;
end;

procedure TCompletionProposalForm.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  y:= (y-1) div FFontHeight;
  Position:= Scroll.Position+y;
end;

procedure TCompletionProposalForm.Paint;
var
  i: integer;
begin
  // update scrool bar
  if ItemList.Count-NbLinesInWindow<0 then
    Scroll.Max:= 0
  else
    Scroll.Max:= ItemList.Count-NbLinesInWindow;
  Position:= Position;
  Scroll.LargeChange:= NbLinesInWindow;

  // draw a rectangle around the window
  Canvas.Pen.Color:= ClBlack;
  Canvas.Moveto(0, 0);
  Canvas.LineTo(Width-1, 0);
  Canvas.LineTo(Width-1, Height-1);
  Canvas.LineTo(0, Height-1);
  Canvas.LineTo(0, 0);

  with bitmap do
  begin
    canvas.pen.color:= color;
    canvas.brush.color:= color;
    canvas.Rectangle(0,0,Width,Height);
    For i:= 0 to min(NbLinesInWindow-1,ItemList.Count-1) do
    Begin
      if i+Scroll.Position=Position then
      Begin
        Canvas.Brush.Color:= ClSelect;
        Canvas.Pen.Color:= ClSelect;
        Canvas.Rectangle(0, FFontHeight*i, width, FFontHeight*(i+1));
        Canvas.Pen.Color:= ClBlack;
      end else
        Canvas.Brush.Color:= Color;

      if not Assigned(OnPaintItem) or not OnPaintItem(ItemList[Scroll.Position+i], Canvas, 0, FFontHeight*i) then
        Canvas.TextOut(0, FFontHeight*i, ItemList[Scroll.Position+i]);
    end;
  end;
  canvas.Draw(1, 1, bitmap);
end;

procedure TCompletionProposalForm.ScrollChange(Sender: TObject);
begin
  if Position < Scroll.Position then
    Position:= Scroll.Position
  else if Position > Scroll.Position+NbLinesInWindow-1 then
    Position:= Scroll.Position+NbLinesInWindow-1;
  Paint;
end;

procedure TCompletionProposalForm.ScrollGetFocus(Sender: TObject);
begin
  ActiveControl:= nil;
end;

procedure TCompletionProposalForm.SelectNext;
begin
  if Position<ItemList.Count-1 then
    Position:= Position+1;
end;

procedure TCompletionProposalForm.SelectPrec;
begin
  if Position>0 then
    Position:= Position-1;
end;

procedure TCompletionProposalForm.SetCurrentString(const Value: String);
var
  i: integer;
begin
  FCurrentString := Value;
  i:= 0;
  if ffansi then
    while (i<=ItemList.count-1) and (AnsiCompareText(ItemList[i],Value)<0) do
      inc(i)
  else
    while (i<=ItemList.count-1) and (ItemList[i]<Value) do
      inc(i);
  if i<=ItemList.Count-1 then
    Position:= i;
end;

procedure TCompletionProposalForm.SetItemList(const Value: TStrings);
begin
  FItemList.Assign(Value);
end;

procedure TCompletionProposalForm.SetNbLinesInWindow(const Value: Integer);
begin
  FNbLinesInWindow := Value;
  Height:= fFontHeight * NbLinesInWindow + 2;
  Scroll.top:= 2;
  Scroll.left:= ClientWidth-Scroll.Width-2;
  Scroll.Height:= Height-4;
  bitmap.Width:= Scroll.left-2;
  bitmap.height:= Height-2;
end;

procedure TCompletionProposalForm.SetPosition(const Value: Integer);
begin
  if Value<=ItemList.Count-1 then
  Begin
    if FPosition<>Value then
    Begin
      FPosition := Value;
      if Position<Scroll.Position then
        Scroll.Position:= Position
      else
        if Scroll.Position < Position-NbLinesInWindow+1 then
          Scroll.Position:= Position-NbLinesInWindow+1;
      invalidate;
    end;
  end;
end;

procedure TCompletionProposalForm.StringListChange(Sender: TObject);
begin
  if ItemList.Count-NbLinesInWindow<0 then
    Scroll.Max:= 0
  else
    Scroll.Max:= ItemList.Count-NbLinesInWindow;
  Position:= Position;
end;

{ TCompletionProposal }

constructor TCompletionProposal.Create(Aowner: TComponent);
begin
  Inherited Create(AOwner);
  Form:= TCompletionProposalForm.Create(Self);
end;

destructor TCompletionProposal.Destroy;
begin
  form.Free;
  Inherited Destroy;
end;

procedure TCompletionProposal.Execute(s: string; x, y: integer);
begin
  form.top:= y;
  form.left:= x;
  CurrentString:= s;
  if assigned(OnExecute) then
    OnExecute(Self);
  form.Show;
end;

function TCompletionProposal.GetCurrentString: String;
begin
  result:= Form.CurrentString;
end;

function TCompletionProposal.GetItemList: TStrings;
begin
  result:= Form.ItemList;
end;

function TCompletionProposal.GetNbLinesInWindow: Integer;
begin
  Result:= Form.NbLinesInWindow;
end;

function TCompletionProposal.GetOnCancel: TNotifyEvent;
begin
  Result:= Form.OnCancel;
end;

function TCompletionProposal.GetOnKeyPress: TKeyPressEvent;
begin
  Result:= Form.OnKeyPress;
end;

function TCompletionProposal.GetOnPaintItem: TCompletionProposalPaintItem;
begin
  Result:= Form.OnPaintItem;
end;

function TCompletionProposal.GetOnValidate: TNotifyEvent;
begin
  Result:= Form.OnValidate;
end;

function TCompletionProposal.GetPosition: Integer;
begin
  Result:= Form.Position;
end;

procedure TCompletionProposal.SetCurrentString(const Value: String);
begin
  form.CurrentString:= Value;
end;

procedure TCompletionProposal.SetItemList(const Value: TStrings);
begin
  form.ItemList:= Value;
end;

procedure TCompletionProposal.SetNbLinesInWindow(const Value: Integer);
begin
  form.NbLinesInWindow:= Value;
end;

procedure TCompletionProposal.SetOnCancel(const Value: TNotifyEvent);
begin
  form.OnCancel:= Value;
end;

procedure TCompletionProposal.SetOnKeyPress(const Value: TKeyPressEvent);
begin
  form.OnKeyPress:= Value;
end;

procedure TCompletionProposal.SetOnPaintItem(const Value: TCompletionProposalPaintItem);
begin
  form.OnPaintItem:= Value;
end;

procedure TCompletionProposal.SetPosition(const Value: Integer);
begin
  form.Position:= Value;
end;

procedure TCompletionProposal.SetOnValidate(const Value: TNotifyEvent);
begin
  form.OnValidate:= Value;
end;

function TCompletionProposal.GetClSelect: TColor;
begin
  Result:= Form.ClSelect;
end;

procedure TCompletionProposal.SetClSelect(const Value: TColor);
begin
  Form.ClSelect:= Value;
end;

function TCompletionProposal.GetOnKeyDelete: TNotifyEvent;
begin
  result:= Form.OnKeyDelete;
end;

procedure TCompletionProposal.SetOnKeyDelete(const Value: TNotifyEvent);
begin
  form.OnKeyDelete:= Value;
end;

procedure TCompletionProposal.RFAnsi(const Value: boolean);
begin
  form.ffAnsi:= value;
end;

function TCompletionProposal.SFAnsi: boolean;
begin
  result:= form.ffansi;
end;

procedure Register;
begin
  RegisterComponents(MWS_ComponentsPage,
                     [TMwCompletionProposal, TmwAutoComplete]);
end;

Procedure PretyTextOut(c: TCanvas; x, y: integer; s: String);
var
  i: integer;
  b: TBrush;
  f: TFont;
Begin
  b:= TBrush.Create;
  b.Assign(c.Brush);
  f:= TFont.Create;
  f.Assign(c.Font);
  try
    i:= 1;
    while i<=Length(s) do
      case s[i] of
        #1: Begin C.Font.Color:= ord(s[i+1])+ord(s[i+2])*256+ord(s[i+3])*65536; inc(i, 4); end;
        #2: Begin C.Brush.Color:= ord(s[i+1])+ord(s[i+2])*256+ord(s[i+3])*65536; inc(i, 4); end;
        #3: Begin
              case s[i+1] of
                'B': c.Font.Style:= c.Font.Style+[fsBold];
                'b': c.Font.Style:= c.Font.Style-[fsBold];
                'U': c.Font.Style:= c.Font.Style+[fsUnderline];
                'u': c.Font.Style:= c.Font.Style-[fsUnderline];
                'I': c.Font.Style:= c.Font.Style+[fsItalic];
                'i': c.Font.Style:= c.Font.Style-[fsItalic];
              end;
              inc(i, 2);
            end;
        else
          C.TextOut(x, y, s[i]);
          x:= x+c.TextWidth(s[i]);
          inc(i);
      end;
  except
  end;
  c.Font.Assign(f);
  f.Free;
  c.Brush.Assign(b);
  b.Free;
end;

{ TMwCompletionProposal }

type
  TRecordUsedToStoreEachEditorVars = record
    kp: TKeyPressEvent;
    kd: TKeyEvent;
    NoNextKey: boolean;
  end;
  PRecordUsedToStoreEachEditorVars = ^TRecordUsedToStoreEachEditorVars;

procedure TMwCompletionProposal.backspace(Senter: TObject);
begin
  if (senter as TCompletionProposalForm).CurrentEditor <> nil then
    ((senter as TCompletionProposalForm).CurrentEditor as TmwCustomEdit).CommandProcessor(ecDeleteLastChar,#0,nil);
end;

procedure TMwCompletionProposal.Cancel(Senter: TObject);
begin
  if (senter as TCompletionProposalForm).CurrentEditor <> nil then
  begin
    if (((senter as TCompletionProposalForm).CurrentEditor as TmwCustomEdit).Owner) is TWinControl
    then TWinControl(((senter as TCompletionProposalForm).CurrentEditor as TmwCustomEdit).Owner).SetFocus;
    ((senter as TCompletionProposalForm).CurrentEditor as TmwCustomEdit).SetFocus;
  end;
end;

procedure TMwCompletionProposal.Validate(Senter: TObject);
begin
  if (senter as TCompletionProposalForm).CurrentEditor <> nil then
    with ((senter as TCompletionProposalForm).CurrentEditor as TmwCustomEdit) do
    Begin
      BlockBegin:= Point(CaretX - length(CurrentString) , CaretY);
      BlockEnd:= Point(CaretX, CaretY);
      SelText:= ItemList[position];
      SetFocus;
    end;
end;

Procedure TMwCompletionProposal.KeyPress(Sender: TObject; var Key: Char);
Begin
  if (sender as TCompletionProposalForm).CurrentEditor <> nil then
    with ((sender as TCompletionProposalForm).CurrentEditor as TmwCustomEdit) do
      CommandProcessor(ecChar, Key, NIL);
end;

procedure TMwCompletionProposal.SetEditor(const Value: TmwCustomEdit);
begin
  AddEditor(Value);
end;

procedure TMwCompletionProposal.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (fEditors.indexOf(AComponent)<>-1) then
    RemoveEditor(AComponent as tmwCustomEdit);
end;

Constructor TMwCompletionProposal.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  Form.OnKeyPress:= KeyPress;
  Form.OnKeyDelete:= backspace;
  Form.OnValidate:= validate;
  Form.OnCancel:= Cancel;
  FEndOfTokenChr:= '()[].';
  fEditors:= TList.Create;
  fEditstuffs:= TList.Create;
  fShortCut := Menus.ShortCut(Ord(' '), [ssCtrl]);
end;

procedure TMwCompletionProposal.SetShortCut(Value: TShortCut);
begin
  FShortCut := Value;
end;

procedure TMwCompletionProposal.EditorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  p: TPoint;
  i: integer;
  ShortCutKey: Word;
  ShortCutShift: TShiftState;
begin
  ShortCutToKey(FShortCut, ShortCutKey, ShortCutShift);
  i:= fEditors.indexOf(Sender);
  if i<>-1 then
    with sender as TmwCustomEdit do
    begin
      if (Shift = ShortCutShift) and (Key = ShortCutKey) then
      Begin
        p := ClientToScreen(Point(CaretXPix, CaretYPix+LineHeight));
        Form.CurrentEditor:= Sender as TmwCustomEdit;
        Execute(GetPreviousToken(Sender as TmwCustomEdit), p.x, p.y);
        Key:= 0;
        TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).NoNextKey:= true;
      End;
      if assigned(TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).kd) then
        TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).kd(sender, key, shift);
    end;
end;

function TMwCompletionProposal.GetPreviousToken(FEditor: TmwCustomEdit): string;
var
  s: String;
  i: integer;
begin
  if FEditor <> nil then
  Begin
    s:= FEditor.LineText;
    i:= FEditor.CaretX-1;
    if i>length(s) then
      result:= ''
    else begin
      while (i>0) and (s[i]>' ') and (pos (s[i], FEndOfTokenChr)=0) do dec(i);
      result:= copy(s, i+1, FEditor.CaretX-i-1);
    end;
  end else result:= '';
end;

procedure TMwCompletionProposal.EditorKeyPress(Sender: TObject; var Key: char);
var
  i: integer;
begin
  i:= fEditors.IndexOf(Sender);
  if i<>-1 then
  begin
    if TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).NoNextKey then
    Begin
      key:= #0;
      TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).NoNextKey:= false;
    end;
    if assigned(TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).kp) then
      TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).kp(sender, key);
  end;
end;

destructor TMwCompletionProposal.destroy;
begin
  while fEditors.Count<>0 do
    RemoveEditor(tmwCustomEdit(fEditors.last));
  fEditors.Free;
  fEditstuffs.free;
  inherited;
end;

function TMwCompletionProposal.GetFEditor: TmwCustomEdit;
begin
  if EditorsCount>0 then
    result:= Editors[0]
  else
    result:= nil;
end;

procedure TMwCompletionProposal.AddEditor(Editor: TmwCustomEdit);
var
  p: PRecordUsedToStoreEachEditorVars;
begin
  if fEditors.IndexOf(Editor)=-1 then
  Begin
    fEditors.Add(Editor);
    new(p);
    p.kp:=Editor.OnKeyPress;
    p.kd:=Editor.OnKeyDown;
    p.NoNextKey:= false;
    fEditstuffs.add(p);
    Editor.FreeNotification(self);
    if not (csDesigning in ComponentState) then
    Begin
      Editor.OnKeyDown:= EditorKeyDown;
      Editor.OnKeyPress:= EditorKeyPress;
    end;
  end;
end;

function TMwCompletionProposal.EditorsCount: integer;
begin
  result:= fEditors.count;
end;

function TMwCompletionProposal.GetEditor(i: integer): TmwCustomEdit;
begin
  if (i<0) or (i>=EditorsCount) then
    result:= nil
  else
    result:= TmwCustomEdit(fEditors[i]);
end;

function TMwCompletionProposal.RemoveEditor(Editor: TmwCustomEdit): boolean;
var
  i: integer;
begin
  i:= fEditors.Remove(Editor);
  result:= i<>-1;
  if result then
  begin;
    dispose(fEditstuffs[i]);
    fEditstuffs.delete(i);
  end;
end;

{ TmwAutoComplete }

procedure TmwAutoComplete.AddEditor(Editor: TmwCustomEdit);
var
  p: PRecordUsedToStoreEachEditorVars;
begin
  if fEditors.IndexOf(Editor)=-1 then
  Begin
    fEditors.Add(Editor);
    new(p);
    p.kp:=Editor.OnKeyPress;
    p.kd:=Editor.OnKeyDown;
    p.NoNextKey:= false;
    fEditstuffs.add(p);
    Editor.FreeNotification(self);
    if not (csDesigning in ComponentState) then
    Begin
      Editor.OnKeyDown:= EditorKeyDown;
      Editor.OnKeyPress:= EditorKeyPress;
    end;
  end;
end;

constructor TmwAutoComplete.Create(AOwner: TComponent);
begin
  inherited;
  fEditors:= TList.Create;
  fEditstuffs:= TList.Create;
  FEndOfTokenChr:= '()[].';
  fAutoCompleteList:= TStringList.Create;
  fShortCut := Menus.ShortCut(Ord(' '), [ssShift]);
end;

procedure TmwAutoComplete.SetShortCut(Value: TShortCut);
begin
  FShortCut := Value;
end;

destructor TmwAutoComplete.destroy;
begin
  while feditors.count<>0 do
    RemoveEditor(feditors.last);
  fEditors.free;
  fEditstuffs.free;
  fAutoCompleteList.free;
  Inherited;
end;

procedure TmwAutoComplete.EditorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: integer;
  ShortCutKey: Word;
  ShortCutShift: TShiftState;
begin
  ShortCutToKey(FShortCut, ShortCutKey, ShortCutShift);
  i:= fEditors.IndexOf(Sender);
  if i<>-1 then
  begin
    if (Shift = ShortCutShift) and (Key = ShortCutKey) then
    Begin
      Execute(GetPreviousToken(Sender as TmwCustomEdit), Sender as TmwCustomEdit);
      Key:= 0;
      TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).NoNextKey:= true;
    End;
    if assigned(TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).kd) then
      TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).kd(sender, key, Shift);
  end;
end;

procedure TmwAutoComplete.EditorKeyPress(Sender: TObject; var Key: char);
var
  i: integer;
begin
  i:= fEditors.IndexOf(Sender);
  if i<>-1 then
  begin
    if TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).NoNextKey then
    Begin
      key:= #0;
      TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).NoNextKey:= false;
    end;
    if assigned(TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).kp) then
      TRecordUsedToStoreEachEditorVars(fEditstuffs[i]^).kp(sender, key);
  end;
end;

function TmwAutoComplete.EditorsCount: integer;
begin
  result:= fEditors.count;
end;

procedure TmwAutoComplete.Execute(token: string; Editor: TmwCustomEdit);
Var
  Temp: string;
  i, j, prevspace: integer;
  StartOfBlock: tpoint;
Begin
  i:= AutoCompleteList.IndexOf(token);
  if i<>-1 then
  Begin
    TRecordUsedToStoreEachEditorVars(fEditstuffs[fEditors.IndexOf(Editor)]^).NoNextKey:= true;
    for j:= 1 to length(token) do
      Editor.CommandProcessor(ecDeleteLastChar, ' ', nil);
    inc(i);
    StartOfBlock:= Point(-1, -1);
    PrevSpace:= 0;
    while (i<AutoCompleteList.Count) and
          (length(AutoCompleteList[i])>0) and
          (AutoCompleteList[i][1]='=') do
    Begin
      for j:= 0 to PrevSpace-1 do
        Editor.CommandProcessor(ecDeleteLastChar, ' ', nil);
      Temp:= AutoCompleteList[i];
      PrevSpace:= 0;
      while (length(temp)>=PrevSpace+2) and (temp[PrevSpace+2]<=' ') do
        inc(PrevSpace);
      for j:=2 to length(Temp) do
      Begin
        Editor.CommandProcessor(ecChar, Temp[j], nil);
        if Temp[j]='|' then
          StartOfBlock:= Editor.CaretXY
      end;
      inc(i);
      if (i<AutoCompleteList.Count) and
         (length(AutoCompleteList[i])>0) and
         (AutoCompleteList[i][1]='=') then
         Editor.CommandProcessor(ecLineBreak, ' ', nil);
    end;
    if (StartOfBlock.x<>-1) and (StartOfBlock.y<>-1) then
    Begin
      Editor.CaretXY:= StartOfBlock;
      Editor.CommandProcessor(ecDeleteLastChar, ' ', nil);
    end;
  end;
end;

function TmwAutoComplete.GetEdit: TmwCustomEdit;
begin
  if EditorsCount>0 then
    result:= Editors[0]
  else
    result:= nil;
end;

function TmwAutoComplete.GetEditor(i: integer): TmwCustomEdit;
begin
  if (i<0) or (i>=EditorsCount) then
    result:= nil
  else
    result:= TmwCustomEdit(fEditors[i]);
end;

function TmwAutoComplete.GetPreviousToken(Editor: tmwCustomEdit): string;
var
  s: String;
  i: integer;
begin
  if Editor <> nil then
  Begin
    s:= Editor.LineText;
    i:= Editor.CaretX-1;
    if i>length(s) then
      result:= ''
    else begin
      while (i>0) and (s[i]>' ') and (pos(s[i], FEndOfTokenChr)=0) do dec(i);
      result:= copy(s, i+1, Editor.CaretX-i-1);
    end;
  end else result:= '';
end;

procedure TmwAutoComplete.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (fEditors.indexOf(AComponent)<>-1) then
    RemoveEditor(AComponent as tmwCustomEdit);
end;

function TmwAutoComplete.RemoveEditor(Editor: TmwCustomEdit): boolean;
var
  i: integer;
begin
  i:= fEditors.Remove(Editor);
  result:= i<>-1;
  if result then
  begin;
    dispose(fEditstuffs[i]);
    fEditstuffs.delete(i);
  end;
end;

procedure TmwAutoComplete.SetAutoCompleteList(List: TStrings);
begin
  fAutoCompleteList.Assign(List);
end;

procedure TmwAutoComplete.SetEdit(const Value: TmwCustomEdit);
begin
  AddEditor(Value);
end;

end.
