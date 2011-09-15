unit Sample1;

{$I mwEdit.inc}

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Graphics, Registry,
  mwHighlighter, mwExport, mwLocalStr;

Type
  TtkTokenKind = (
    tkComment,
    tkIdentifier,
    tkKey,
    tkNull,
    tkSpace,
    tkUnknown);

  TRangeState = (rsUnknown);

  TProcTableProc = procedure of Object;

  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function: TtkTokenKind of Object;

type
  TmwSampleSyn = class(TmwCustomHighLighter)
  private
    fRange: TRangeState;
    fLine: PChar;
    fLineNumber: Integer;
    fExporter: TmwCustomExport;
    fProcTable: array[#0..#255] of TProcTableProc;
    Run: LongInt;
    fStringLen: Integer;
    fToIdent: PChar;
    fTokenPos: Integer;
    FTokenID: TtkTokenKind;
    fIdentFuncTable: array[0..74] of TIdentFuncTableFunc;
    fCommentAttri: TmwHighLightAttributes;
    fIdentifierAttri: TmwHighLightAttributes;
    fKeyAttri: TmwHighLightAttributes;
    fSpaceAttri: TmwHighLightAttributes;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: String): Boolean;
    function Func74: TtkTokenKind;
    procedure IdentProc;
    procedure NullProc;
    procedure SlashProc;
    procedure SpaceProc;
    procedure UnknownProc;
    function AltFunc: TtkTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PChar): TtkTokenKind;
    procedure MakeMethodTables;
  protected
    function GetIdentChars: TIdentChars; override;
    function GetLanguageName: string; override;
    function GetCapability: THighlighterCapability; override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetEOL: Boolean; override;
    function GetRange: Pointer; override;
    function GetTokenID: TtkTokenKind;
    procedure SetLine(NewValue: String; LineNumber: Integer); override;
    procedure ExportNext; override;
    procedure SetLineForExport(NewValue: String); override;
    function GetToken: String; override;
    function GetTokenAttribute: TmwHighLightAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    procedure Next; override;
    procedure SetRange(Value: Pointer); override;
    procedure ReSetRange; override;
    property IdentChars;
  published
    property CommentAttri: TmwHighLightAttributes read fCommentAttri write fCommentAttri;
    property IdentifierAttri: TmwHighLightAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TmwHighLightAttributes read fKeyAttri write fKeyAttri;
    property SpaceAttri: TmwHighLightAttributes read fSpaceAttri write fSpaceAttri;
    property Exporter:TmwCustomExport read FExporter write FExporter;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents(MWS_HighlightersPage, [TmwSampleSyn]);
end;

var
  Identifiers: array[#0..#255] of ByteBool;
  mHashTable: array[#0..#255] of Integer;

procedure MakeIdentTable;
var
  I, J: Char;
begin
  for I := #0 to #255 do
  begin
    Case I of
      '_', '0'..'9', 'a'..'z', 'A'..'Z': Identifiers[I] := True;
      else Identifiers[I] := False;
    end;
    J := UpCase(I);
    Case I in ['_', 'A'..'Z', 'a'..'z'] of
      True: mHashTable[I] := Ord(J) - 64
      else mHashTable[I] := 0;
    end;
  end;
end;

procedure TmwSampleSyn.InitIdent;
var
  I: Integer;
  pF: PIdentFuncTableFunc;
begin
  pF := PIdentFuncTableFunc(@fIdentFuncTable);
  for I := Low(fIdentFuncTable) to High(fIdentFuncTable) do begin
    pF^ := AltFunc;
    Inc(pF);
  end;
  fIdentFuncTable[74] := Func74;
end;

function TmwSampleSyn.KeyHash(ToHash: PChar): Integer;
begin
  Result := 0;
  while ToHash^ in ['_', '0'..'9', 'a'..'z', 'A'..'Z'] do
  begin
    inc(Result, mHashTable[ToHash^]);
    inc(ToHash);
  end;
  fStringLen := ToHash - fToIdent;
end;

function TmwSampleSyn.KeyComp(const aKey: String): Boolean;
var
  I: Integer;
  Temp: PChar;
begin
  Temp := fToIdent;
  if Length(aKey) = fStringLen then
  begin
    Result := True;
    for i := 1 to fStringLen do
    begin
      if mHashTable[Temp^] <> mHashTable[aKey[i]] then
      begin
        Result := False;
        break;
      end;
      inc(Temp);
    end;
  end else Result := False;
end;

function TmwSampleSyn.Func74: TtkTokenKind;
begin
  if KeyComp('mwEdit') then Result := tkKey else Result := tkIdentifier;
end;

function TmwSampleSyn.AltFunc: TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TmwSampleSyn.IdentKind(MayBe: PChar): TtkTokenKind;
var
  HashKey: Integer;
begin
  fToIdent := MayBe;
  HashKey := KeyHash(MayBe);
  if HashKey < 75 then Result := fIdentFuncTable[HashKey] else Result := tkIdentifier;
end;

procedure TmwSampleSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      'A'..'Z', 'a'..'z', '_': fProcTable[I] := IdentProc;
      #0: fProcTable[I] := NullProc;
      '/': fProcTable[I] := SlashProc;
      #1..#32: fProcTable[I] := SpaceProc;
      else fProcTable[I] := UnknownProc;
    end;
end;

constructor TmwSampleSyn.Create(AOwner: TComponent);
begin
  fCommentAttri := TmwHighLightAttributes.Create(MWS_AttrComment);
  fIdentifierAttri := TmwHighLightAttributes.Create(MWS_AttrIdentifier);
  fKeyAttri := TmwHighLightAttributes.Create(MWS_AttrReservedWord);
  fSpaceAttri := TmwHighLightAttributes.Create(MWS_AttrSpace);
  inherited Create(AOwner);
  AddAttribute(fCommentAttri);
  AddAttribute(fIdentifierAttri);
  AddAttribute(fKeyAttri);
  AddAttribute(fSpaceAttri);
  SetAttributesOnChange(DefHighlightChange);
  InitIdent;
  MakeMethodTables;
  fDefaultFilter := 'All files (*.*)|*.*';
  fRange := rsUnknown;
end;

procedure TmwSampleSyn.SetLine(NewValue: String; LineNumber: Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end;

procedure TmwSampleSyn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
end;

procedure TmwSampleSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TmwSampleSyn.SlashProc;
begin
  Inc(Run);
  if fLine[Run] = '/' then
  begin
    fTokenID := tkComment;
    repeat
      Inc(Run);
    until fLine[Run] in [#0, #10, #13];
  end else
    fTokenID := tkUnknown;
end;

procedure TmwSampleSyn.SpaceProc;
begin
  fTokenID := tkSpace;
  repeat
    inc(Run);
  until not (fLine[Run] in [#1..#32]);
end;

procedure TmwSampleSyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TmwSampleSyn.Next;
begin
  fTokenPos := Run;
  fProcTable[fLine[Run]];
end;

function TmwSampleSyn.GetEOL: Boolean;
begin
  Result := fTokenID = tkNull;
end;

function TmwSampleSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

function TmwSampleSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TmwSampleSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TmwSampleSyn.GetTokenAttribute: TmwHighLightAttributes;
begin
  case GetTokenID of
    tkComment: Result := fCommentAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkSpace: Result := fSpaceAttri;
    tkUnknown: Result := fIdentifierAttri;
    else Result := nil;
  end;
end;

function TmwSampleSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TmwSampleSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

procedure TmwSampleSyn.ReSetRange;
begin
  fRange := rsUnknown;
end;

procedure TmwSampleSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TmwSampleSyn.GetIdentChars: TIdentChars;
begin
  Result := ['_', '0'..'9', 'a'..'z', 'A'..'Z'];
end;

function TmwSampleSyn.GetLanguageName: string;
begin
  Result := 'Sample';
end;

function TmwSampleSyn.GetCapability: THighlighterCapability;
begin
  Result := inherited GetCapability + [hcUserSettings, hcExportable];
end;

procedure TmwSampleSyn.SetLineForExport(NewValue: String);
begin
  fLine := PChar(NewValue);
  Run := 0;
  ExportNext;
end;

procedure TmwSampleSyn.ExportNext;
begin
  fTokenPos := Run;
  fProcTable[fLine[Run]];
  if Assigned(Exporter) then
    Case GetTokenID of
      tkComment: TmwCustomExport(Exporter).FormatToken(GetToken, fCommentAttri, True, False);
      tkIdentifier: TmwCustomExport(Exporter).FormatToken(GetToken, fIdentifierAttri, False, False);
      tkKey: TmwCustomExport(Exporter).FormatToken(GetToken, fKeyAttri, False, False);
      tkSpace: TmwCustomExport(Exporter).FormatToken(GetToken, fSpaceAttri, False, True);
    end;
end;

Initialization
  MakeIdentTable;
end.
