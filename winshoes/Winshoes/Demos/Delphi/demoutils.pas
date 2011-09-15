unit DemoUtils;

interface

uses
  Controls, ComCtrls;

function PadChar(const Source: string; Width: Integer; PadCh: Char) : string;
function LPadChar(const Source: string; Width: Integer; PadCh: Char) : string;
function Pad(const Source: string; Width: Integer) : string;
function LPad(const Source: string; Width: Integer) : string;
function Commaize(Value: Integer) : string;

procedure OpenPrim(S: string);
procedure MailTo(const Address, Subject: string);

function FindChildNode(Item: TTreeNode; const CaptionText: string) : TTreeNode;
function FindItemCaption(ListView: TListView; const Caption: string) : TListItem;
function GetFirstItem(ListView: TListView) : TListItem;
procedure SelectFirstItem(ListView: TListView);

procedure ControlColorCheck(Controls: array of TControl);

implementation

uses
  Windows, ShellApi, SysUtils, Graphics, Forms;

type
  TMyControl = class(TControl);

function PadChar(const Source: string; Width: Integer; PadCh: Char) : string;
begin
  if Length(Source) >= Width then
    Result := Source
  else begin
    SetLength(Result, Width);
    FillChar(Result[1], Width, PadCh);
    Move(Source[1], Result[1], Length(Source));
  end;
end;

function LPadChar(const Source: string; Width: Integer; PadCh: Char) : string;
begin
  if Length(Source) >= Width then
    Result := Source
  else begin
    SetLength(Result, Width);
    FillChar(Result[1], Width, PadCh);
    Move(Source[1], Result[Succ(Width)-Length(Source)], Length(Source));
  end;
end;

function Pad(const Source: string; Width: Integer) : string;
begin
  Result := PadChar(Source, Width, ' ');
end;

function LPad(const Source: string; Width: Integer) : string;
begin
  Result := LPadChar(Source, Width, ' ');
end;

function Commaize(Value: Integer) : string;
begin
  Result := FormatFloat('#,', Value);
end;

procedure OpenPrim(S: string);
begin
  ShellExecute(Application.Handle, nil, PChar(S), nil, nil, SW_SHOWNORMAL);
end;

procedure MailTo(const Address, Subject: string);
begin
  OpenPrim('mailto:' + Address + '?subject=' + Subject);
end;

function FindChildNode(Item: TTreeNode; const CaptionText: string) : TTreeNode;
begin
  Result := Item.GetFirstChild;
  while Assigned(Result) do begin
    if CompareStr(Result.Text, CaptionText) = 0 then
      Exit;

    Result := Result.GetNextChild(Result);
  end;
end;

function FindItemCaption(ListView: TListView; const Caption: string) : TListItem;
var
  Found: Boolean;
  FRefNr, LRefNr, Index: Integer;
begin
  Result := nil;
  if ListView.Items.Count = 0 then Exit;

  Found  := False;
  Index  := 0;
  FRefNr := 0;
  LRefNr := Pred(ListView.Items.Count);

  while (FRefNr <= LRefNr) and not Found do
    begin
      Index := (FRefNr + LRefNr) div 2;

      case AnsiCompareStr(ListView.Items[Index].Caption, Caption) of
       -1 : FRefNr := Succ(Index);
        1 : LRefNr := Pred(Index);
        0 : Found  := True;
      end;
    end;

  if Found then
    Result := ListView.Items[Index];
end;

function GetFirstItem(ListView: TListView) : TListItem;
begin
  Result := ListView.GetNextItem(nil, sdAll, [isNone]);
end;

procedure SelectFirstItem(ListView: TListView);
begin
  ListView.Selected := GetFirstItem(ListView);
  ListView.ItemFocused := ListView.Selected;
end;

procedure ControlColorCheck(Controls: array of TControl);
var
  X: Integer;
begin
  for X := Low(Controls) to High(Controls) do begin
    if TMyControl(Controls[X]).Enabled then
      TMyControl(Controls[X]).Color := clWindow
    else
      TMyControl(Controls[X]).Color := clBtnFace;
  end;
end;

end.
