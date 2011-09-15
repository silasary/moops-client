unit Sample3;

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
    tkString,
    tkUnknown);

  TRangeState = (rsUnknown, rsComment); // TRangeState = (rsUnKnown);           // manual change

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
    fIdentFuncTable: array[0..79] of TIdentFuncTableFunc;
    fCommentAttri: TmwHighLightAttributes;
    fIdentifierAttri: TmwHighLightAttributes;
    fKeyAttri: TmwHighLightAttributes;
    fSpaceAttri: TmwHighLightAttributes;
    fStringAttri: TmwHighLightAttributes;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: String): Boolean;
    function Func76: TtkTokenKind;
    function Func79: TtkTokenKind;
    procedure CommentProc;                                                      // manual change
    procedure IdentProc;
    procedure NullProc;
    procedure SlashProc;
    procedure SpaceProc;
    procedure StringProc;
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
    property StringAttri: TmwHighLightAttributes read fStringAttri write fStringAttri;
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
  I: Char;
begin
  for I := #0 to #255 do
  begin
    Case I of
      '_', '0'..'9', 'a'..'z', 'A'..'Z': Identifiers[I] := True;
      else Identifiers[I] := False;
    end;
    Case I in ['_', 'A'..'Z', 'a'..'z'] of
      True:
        begin
          if (I > #64) and (I < #91) then mHashTable[I] := Ord(I) - 64 else
            if (I > #96) then mHashTable[I] := Ord(I) - 95;
        end;
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
  fIdentFuncTable[76] := Func76;
  fIdentFuncTable[79] := Func79;
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
      if Temp^ <> aKey[i] then
      begin
        Result := False;
        break;
      end;
      inc(Temp);
    end;
  end else Result := False;
end;

function TmwSampleSyn.Func76: TtkTokenKind;
begin
  if KeyComp('mwEDIT') then Result := tkKey else Result := tkIdentifier;
end;

function TmwSampleSyn.Func79: TtkTokenKind;
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
  if HashKey < 80 then Result := fIdentFuncTable[HashKey] else Result := tkIdentifier;
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
      '"': fProcTable[I] := StringProc;
      else fProcTable[I] := UnknownProc;
    end;
end;

constructor TmwSampleSyn.Create(AOwner: TComponent);
begin
  fCommentAttri := TmwHighLightAttributes.Create(MWS_AttrComment);
  fCommentAttri.Foreground := clGrayText;                                       // manual change
  fCommentAttri.Style := [fsItalic];                                            // manual change
  fIdentifierAttri := TmwHighLightAttributes.Create(MWS_AttrIdentifier);
  fIdentifierAttri.Foreground := clBlue;                                        // manual change
  fKeyAttri := TmwHighLightAttributes.Create(MWS_AttrReservedWord);
  fKeyAttri.Style := [fsBold];                                                  // manual change
  fSpaceAttri := TmwHighLightAttributes.Create(MWS_AttrSpace);
  fStringAttri := TmwHighLightAttributes.Create(MWS_AttrString);
  fStringAttri.Foreground := clGreen;                                           // manual change
  inherited Create(AOwner);
  AddAttribute(fCommentAttri);
  AddAttribute(fIdentifierAttri);
  AddAttribute(fKeyAttri);
  AddAttribute(fSpaceAttri);
  AddAttribute(fStringAttri);
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

procedure TmwSampleSyn.CommentProc;                                             // manual change
begin
  fTokenID := tkComment;
  while fLine[Run] <> #0 do begin
    if (fLine[Run] = '*') and (fLine[Run + 1] = '/') then
    begin
      Inc(Run, 2);
      fRange := rsUnknown;
      break;
    end;
    Inc(Run);
  end;
end;                                                                            // end manual change

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
  case fLine[Run] of
    '/':
      begin
        fTokenID := tkComment;
        repeat
          Inc(Run);
        until fLine[Run] = #0;
      end;
    '*':
      begin
        Inc(Run);
        fRange := rsComment;
        CommentProc;
      end;
    else fTokenID := tkUnknown;
  end;
end;

procedure TmwSampleSyn.SpaceProc;
begin
  fTokenID := tkSpace;
  repeat
    inc(Run);
  until not (fLine[Run] in [#1..#32]);
end;

procedure TmwSampleSyn.StringProc;
begin
  fTokenID := tkString;
  Inc(Run);
  repeat
    if fLine[Run] = '"' then
    begin
      Inc(Run);
      if fLine[Run] <> '"' then break;
    end;
    Inc(Run);
  until fLine[Run] in [#0, #10, #13];
end;

procedure TmwSampleSyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TmwSampleSyn.Next;
begin
  fTokenPos := Run;
  // fProcTable[fLine[Run]];                                                    // manual change
  if fRange = rsComment then
    if fLine[Run] = #0 then
      NullProc
    else
      CommentProc
  else
    fProcTable[fLine[Run]];                                                     // end manual change
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
    tkString: Result := fStringAttri;
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
      tkString: TmwCustomExport(Exporter).FormatToken(GetToken, fStringAttri, True, False);
    end;
end;

Initialization
  MakeIdentTable;
end.
