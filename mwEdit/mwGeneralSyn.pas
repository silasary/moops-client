{Created by mwSynGen}
{+--------------------------------------------------------------------------+
 | Unit:        mwGeneralSyn
 | Created:     12.98
 | Last change: 1999-11-11
 | Author:      Martin Waldenburg
 | Copyright    1998, No rights reserved.
 | Description: A general HighLighter for Use with mwCustomEdit.
 |              The KeyWords in the string list KeyWords have to be UpperCase and sorted.
 | Version:     0.73
 | Status       Public Domain
 | DISCLAIMER:  This is provided as is, expressly without a warranty of any kind.
 |              You use it at your own risc.
 |
 | Thanks to: Primoz Gabrijelcic, James Jacobson, Kees van Spelde, Andy Jeffries
 |
 | Version history: see version.rtf
 |
 +--------------------------------------------------------------------------+}
unit mwGeneralSyn;

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Graphics, Registry,
  mwHighlighter, mwLocalStr,
  mwExport;

Type
  TtkTokenKind = (
    tkComment,
    tkIdentifier,
    tkKey,
    tkNull,
    tkNumber,
    tkSpace,
    tkString,
    tkSymbol,
    tkUnknown);
  TCommentStyle = (csAnsiStyle, csPasStyle, csCStyle, csAsmStyle, csBasStyle);
  CommentStyles = Set of TCommentStyle;
  TRangeState = (rsANil, rsAnsi, rsPasStyle, rsCStyle, rsUnKnown);
  TStringDelim = (sdSingleQuote, sdDoubleQuote);

  TProcTableProc = procedure of Object;

type
  TmwGeneralSyn = class(TmwCustomHighLighter)
  private
    fRange: TRangeState;
    fLine: PChar;
    fProcTable: array[#0..#255] of TProcTableProc;
    Run: LongInt;
    fTokenPos: Integer;
    fTokenID: TtkTokenKind;
    fLineNumber : Integer;
    fStringAttri: TmwHighLightAttributes;
    fSymbolAttri: TmwHighLightAttributes;
    fKeyAttri: TmwHighLightAttributes;
    fNumberAttri: TmwHighLightAttributes;
    fCommentAttri: TmwHighLightAttributes;
    fSpaceAttri: TmwHighLightAttributes;
    fIdentifierAttri: TmwHighLightAttributes;
    fKeyWords: TStrings;
    fComments: CommentStyles;
    fStringDelimCh: char;
    fIdentChars: TIdentChars;
    procedure AsciiCharProc;
    procedure BraceOpenProc;
    procedure PointCommaProc;
    procedure CRProc;
    procedure IdentProc;
    procedure IntegerProc;
    procedure LFProc;
    procedure NullProc;
    procedure NumberProc;
    procedure RoundOpenProc;
    procedure SlashProc;
    procedure SpaceProc;
    procedure StringProc;
    procedure UnknownProc;
    procedure MakeMethodTables;
    function IsKeyWord(aToken: String): Boolean;
    procedure AnsiProc;
    procedure PasStyleProc;
    procedure CStyleProc;
    procedure SetKeyWords(const Value: TStrings);
    procedure SetComments(Value: CommentStyles);
    function GetStringDelim: TStringDelim;
    procedure SetStringDelim(const Value: TStringDelim);
    function GetIdentifierChars: string;
    procedure SetIdentifierChars(const Value: string);
  protected
    function GetLanguageName: string; override;
    function GetIdentChars: TIdentChars; override;
    function GetCapability: THighlighterCapability; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExportNext;override;
    destructor Destroy; override;
    function GetEol: Boolean; override;
    function GetRange: Pointer; override;
    function GetTokenID: TtkTokenKind;
    procedure SetLine(NewValue: String; LineNumber:Integer); override;
    function GetToken: String; override;
    function GetTokenAttribute: TmwHighLightAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    procedure Next; override;
    procedure SetLineForExport(NewValue: String); override;
    procedure SetRange(Value: Pointer); override;
    procedure ReSetRange; override;
    function SaveToRegistry(RootKey: HKEY; Key: string): boolean; override;
    function LoadFromRegistry(RootKey: HKEY; Key: string): boolean; override;
  published
    property Comments: CommentStyles read fComments write SetComments;
    property CommentAttri: TmwHighLightAttributes read fCommentAttri write fCommentAttri;
    property IdentifierAttri: TmwHighLightAttributes read fIdentifierAttri write fIdentifierAttri;
    property IdentifierChars: string read GetIdentifierChars write SetIdentifierChars;
    property KeyAttri: TmwHighLightAttributes read fKeyAttri write fKeyAttri;
    property KeyWords: TStrings read fKeyWords write SetKeyWords;
    property NumberAttri: TmwHighLightAttributes read fNumberAttri write fNumberAttri;
    property SpaceAttri: TmwHighLightAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri: TmwHighLightAttributes read fStringAttri write fStringAttri;
    property SymbolAttri: TmwHighLightAttributes read fSymbolAttri write fSymbolAttri;
    property StringDelim: TStringDelim read GetStringDelim write SetStringDelim
               default sdSingleQuote;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents(MWS_HighlightersPage, [TmwGeneralSyn]);
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
    J := UpperCase(I)[1];
    Case I in ['_', 'a'..'z', 'A'..'Z'] of
      True: mHashTable[I] := Ord(J) - 64
    else mHashTable[I] := 0;
    end;
  end;
end;

function TmwGeneralSyn.IsKeyWord(aToken: String): Boolean;
var
  First, Last, I, Compare: Integer;
  Token: String;
begin
  First := 0;
  Last := fKeywords.Count - 1;
  Result := False;
  Token := UpperCase(aToken);
  while First <= Last do
  begin
    I := (First + Last) shr 1;
    Compare := CompareStr(fKeywords[i], Token);
    if Compare = 0 then
    begin
      Result := True;
      break;
    end
    else
      if Compare < 0 then First := I + 1 else Last := I - 1;
  end;
end; { IsKeyWord }

procedure TmwGeneralSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      '#': fProcTable[I] := AsciiCharProc;
      '{': fProcTable[I] := BraceOpenProc;
      ';': fProcTable[I] := PointCommaProc;                                      
      #13: fProcTable[I] := CRProc;
      'A'..'Z', 'a'..'z', '_': fProcTable[I] := IdentProc;
      '$': fProcTable[I] := IntegerProc;
      #10: fProcTable[I] := LFProc;
      #0: fProcTable[I] := NullProc;
      '0'..'9': fProcTable[I] := NumberProc;
      '(': fProcTable[I] := RoundOpenProc;
      '/': fProcTable[I] := SlashProc;
      #1..#9, #11, #12, #14..#32: fProcTable[I] := SpaceProc;
    else fProcTable[I] := UnknownProc;
    end;
  fProcTable[fStringDelimCh] := StringProc;
end;

function TmwGeneralSyn.GetCapability: THighlighterCapability;
begin
  Result := inherited GetCapability + [hcExportable];
end;

constructor TmwGeneralSyn.Create(AOwner: TComponent);
begin
  fKeyWords := TStringList.Create;
  TStringList(fKeyWords).Sorted := True;
  TStringList(fKeyWords).Duplicates := dupIgnore;
  fCommentAttri := TmwHighLightAttributes.Create(MWS_AttrComment);
  fCommentAttri.Style := [fsItalic];
  fIdentifierAttri := TmwHighLightAttributes.Create(MWS_AttrIdentifier);
  fKeyAttri := TmwHighLightAttributes.Create(MWS_AttrReservedWord);
  fKeyAttri.Style := [fsBold];
  fNumberAttri := TmwHighLightAttributes.Create(MWS_AttrNumber);
  fSpaceAttri := TmwHighLightAttributes.Create(MWS_AttrSpace);
  fStringAttri := TmwHighLightAttributes.Create(MWS_AttrString);
  fSymbolAttri := TmwHighLightAttributes.Create(MWS_AttrSymbol);
  inherited Create(AOwner);

  AddAttribute(fCommentAttri);
  AddAttribute(fIdentifierAttri);
  AddAttribute(fKeyAttri);
  AddAttribute(fNumberAttri);
  AddAttribute(fSpaceAttri);
  AddAttribute(fStringAttri);
  AddAttribute(fSymbolAttri);
  SetAttributesOnChange(DefHighlightChange);

  fStringDelimCh := '''';
  fIdentChars := inherited GetIdentChars;
  MakeMethodTables;
  fRange := rsUnknown;
end; { Create }

destructor TmwGeneralSyn.Destroy;
begin
  fKeyWords.Free;
  inherited Destroy;
end; { Destroy }

procedure TmwGeneralSyn.SetLine(NewValue: String; LineNumber:Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end; { SetLine }

procedure TmwGeneralSyn.AnsiProc;
begin
  fTokenID := tkComment;
  case FLine[Run] of
    #0:
      begin
        NullProc;
        exit;
      end;
    #10:
      begin
        LFProc;
        exit;
      end;

    #13:
      begin
        CRProc;
        exit;
      end;
  end;

  while fLine[Run] <> #0 do
    case fLine[Run] of
      '*':
        if fLine[Run + 1] = ')' then
        begin
          fRange := rsUnKnown;
          inc(Run, 2);
          break;
        end else inc(Run);
      #10: break;

      #13: break;
    else inc(Run);
    end;
end;

procedure TmwGeneralSyn.PasStyleProc;
begin
  fTokenID := tkComment;
  case FLine[Run] of
    #0:
      begin
        NullProc;
        exit;
      end;
    #10:
      begin
        LFProc;
        exit;
      end;

    #13:
      begin
        CRProc;
        exit;
      end;
  end;

  while FLine[Run] <> #0 do
    case FLine[Run] of
      '}':
        begin
          fRange := rsUnKnown;
          inc(Run);
          break;
        end;
      #10: break;

      #13: break;
    else inc(Run);
    end;
end;

procedure TmwGeneralSyn.CStyleProc;
begin
  fTokenID := tkComment;
  case FLine[Run] of
    #0:
      begin
        NullProc;
        exit;
      end;
    #10:
      begin
        LFProc;
        exit;
      end;

    #13:
      begin
        CRProc;
        exit;
      end;
  end;

  while fLine[Run] <> #0 do
    case fLine[Run] of
      '*':
        if fLine[Run + 1] = '/' then
        begin
          fRange := rsUnKnown;
          inc(Run, 2);
          break;
        end else inc(Run);
      #10: break;

      #13: break;
    else inc(Run);
    end;
end;

procedure TmwGeneralSyn.AsciiCharProc;
begin
  fTokenID := tkString;
  inc(Run);
  while FLine[Run] in ['0'..'9'] do inc(Run);
end;

procedure TmwGeneralSyn.BraceOpenProc;
begin
  if csPasStyle in fComments then
  begin
    fTokenID := tkComment;
    fRange := rsPasStyle;
    inc(Run);
    while FLine[Run] <> #0 do
      case FLine[Run] of
        '}':
          begin
            fRange := rsUnKnown;
            inc(Run);
            break;
          end;
        #10: break;

        #13: break;
      else inc(Run);
      end;
  end else
  begin
    inc(Run);
    fTokenID := tkSymbol;
  end;
end;

procedure TmwGeneralSyn.PointCommaProc;
begin
  if (csASmStyle in fComments) or (csBasStyle in fComments) then
  begin
    fTokenID := tkComment;
    fRange := rsUnknown;
    inc(Run);
    while FLine[Run] <> #0 do
      begin
        fTokenID := tkComment;
        inc(Run);
      end;
  end else
  begin
    inc(Run);
    fTokenID := tkSymbol;
  end;
end;

procedure TmwGeneralSyn.CRProc;
begin
  fTokenID := tkSpace;
  Inc(Run);
  if fLine[Run] = #10 then Inc(Run);
end;

procedure TmwGeneralSyn.IdentProc;
begin
  while Identifiers[fLine[Run]] do inc(Run);
  if IsKeyWord(GetToken) then fTokenId := tkKey else fTokenId := tkIdentifier;
end;

procedure TmwGeneralSyn.IntegerProc;
begin
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in ['0'..'9', 'A'..'F', 'a'..'f'] do inc(Run);
end;

procedure TmwGeneralSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TmwGeneralSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TmwGeneralSyn.NumberProc;
begin
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in ['0'..'9', '.', 'e', 'E'] do
  begin
    case FLine[Run] of
      '.':
        if FLine[Run + 1] = '.' then break;
    end;
    inc(Run);
  end;
end;

procedure TmwGeneralSyn.RoundOpenProc;
begin
  inc(Run);
  if csAnsiStyle in fComments then
  begin
    case fLine[Run] of
      '*':
        begin
          fTokenID := tkComment;
          fRange := rsAnsi;
          inc(Run);
          while fLine[Run] <> #0 do
            case fLine[Run] of
              '*':
                if fLine[Run + 1] = ')' then
                begin
                  fRange := rsUnKnown;
                  inc(Run, 2);
                  break;
                end else inc(Run);
              #10: break;
              #13: break;
            else inc(Run);
            end;
        end;
      '.':
        begin
          inc(Run);
          fTokenID := tkSymbol;
        end;
    else
      begin
        FTokenID := tkSymbol;
      end;
    end;
  end else fTokenId := tkSymbol;
end;

procedure TmwGeneralSyn.SlashProc;
begin
  case FLine[Run + 1] of
    '/':
      begin
        inc(Run, 2);
        fTokenID := tkComment;
        while FLine[Run] <> #0 do
        begin
          case FLine[Run] of
            #10, #13: break;
          end;
          inc(Run);
        end;
      end;
    '*':
      begin
        if csCStyle in fComments then
        begin
          fTokenID := tkComment;
          fRange := rsCStyle;
          inc(Run);
          while fLine[Run] <> #0 do
            case fLine[Run] of
              '*':
                if fLine[Run + 1] = '/' then
                begin
                  fRange := rsUnKnown;
                  inc(Run, 2);
                  break;
                end else inc(Run);
              #10: break;
              #13: break;
            else inc(Run);
            end;
        end
        else
          begin
            inc(Run);    
            fTokenId := tkSymbol;
          end;
      end;
  else
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
end;

procedure TmwGeneralSyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkSpace;
  while FLine[Run] in [#1..#9, #11, #12, #14..#32] do inc(Run);
end;

procedure TmwGeneralSyn.StringProc;
begin
  fTokenID := tkString;
  if (fLine[Run + 1] = fStringDelimCh) and (fLine[Run + 2] = fStringDelimCh) then Inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = fStringDelimCh;
  if FLine[Run] <> #0 then inc(Run);
end;

procedure TmwGeneralSyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnKnown;
end;

procedure TmwGeneralSyn.Next;
begin
  fTokenPos := Run;
  Case fRange of
    rsAnsi: AnsiProc;
    rsPasStyle: PasStyleProc;
    rsCStyle: CStyleProc;
  else fProcTable[fLine[Run]];
  end;
end;

function TmwGeneralSyn.GetEol: Boolean;
begin
  Result := fTokenId = tkNull;                                        
end;

function TmwGeneralSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

function TmwGeneralSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TmwGeneralSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TmwGeneralSyn.GetTokenAttribute: TmwHighLightAttributes;
begin
  case fTokenID of
    tkComment: Result := fCommentAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkNumber: Result := fNumberAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
    tkSymbol: Result := fSymbolAttri;
    tkUnknown: Result := fSymbolAttri;
    else Result := nil;
  end;
end;

function TmwGeneralSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TmwGeneralSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

procedure TmwGeneralSyn.ReSetRange;
begin
  fRange := rsUnknown;
end;

procedure TmwGeneralSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

procedure TmwGeneralSyn.SetKeyWords(const Value: TStrings);
var
  i: Integer;
begin
  if Value <> nil then
    begin 
      Value.BeginUpdate;
      for i := 0 to Value.Count - 1 do
        Value[i] := UpperCase(Value[i]);
      Value.EndUpdate;
    end;
  fKeyWords.Assign(Value);
  DefHighLightChange(nil);
end;

procedure TmwGeneralSyn.SetComments(Value: CommentStyles);
begin
  fComments := Value;
  DefHighLightChange(nil);
end;

function TmwGeneralSyn.GetLanguageName: string;
begin
  Result := MWS_LangGeneral;
end;

function TmwGeneralSyn.LoadFromRegistry(RootKey: HKEY; Key: string): boolean;
var
  r: TBetterRegistry;
begin
  r:= TBetterRegistry.Create;
  try
    r.RootKey := RootKey;
    if r.OpenKeyReadOnly(Key) then begin
      if r.ValueExists('KeyWords') then KeyWords.Text:= r.ReadString('KeyWords');
      Result := inherited LoadFromRegistry(RootKey, Key);
    end
    else Result := false;
  finally r.Free; end;
end;

function TmwGeneralSyn.SaveToRegistry(RootKey: HKEY; Key: string): boolean;
var
  r: TBetterRegistry;
begin
  r:= TBetterRegistry.Create;
  try
    r.RootKey := RootKey;
    if r.OpenKey(Key,true) then begin
      Result := true;
      r.WriteString('KeyWords', KeyWords.Text);
      Result := inherited SaveToRegistry(RootKey, Key);
    end
    else Result := false;
  finally r.Free; end;
end;

function TmwGeneralSyn.GetStringDelim: TStringDelim;
begin
  if fStringDelimCh = ''''
    then Result := sdSingleQuote
    else Result := sdDoubleQuote;
end;

procedure TmwGeneralSyn.SetStringDelim(const Value: TStringDelim);
var
  newCh: char;
begin
  case Value of
    sdSingleQuote: newCh := '''';
    else newCh := '"';
  end; //case
  if newCh <> fStringDelimCh then begin
    fStringDelimCh := newCh;
    MakeMethodTables;
  end;
end;

function TmwGeneralSyn.GetIdentifierChars: string;
var
  ch: char;
  s: shortstring;
begin
  s := '';
  for ch := #0 to #255 do
    if ch in fIdentChars then s := s + ch;
  Result := s;
end;

procedure TmwGeneralSyn.SetIdentifierChars(const Value: string);
var
  i: integer;
begin
  fIdentChars := [];
  for i := 1 to Length(Value) do begin
    fIdentChars := fIdentChars + [Value[i]];
  end; //for
end;

function TmwGeneralSyn.GetIdentChars: TIdentChars;
begin
  Result := fIdentChars;
end;

procedure TmwGeneralSyn.SetLineForExport(NewValue: String);
begin
  fLine := PChar(NewValue);
  Run := 0;
  ExportNext;
end; { SetLineForExport }

procedure TmwGeneralSyn.ExportNext;
begin
  fTokenPos := Run;
  Case fRange of
    rsAnsi: AnsiProc;
    rsPasStyle: PasStyleProc;
    rsCStyle: CStyleProc;
  else fProcTable[fLine[Run]];
  end;
  if Assigned(Exporter) then
    with TmwCustomExport(Exporter) do begin
      Case GetTokenID of
        tkComment:FormatToken(GetToken, fCommentAttri, True,False);
        tkIdentifier:FormatToken(GetToken, fIdentifierAttri, False,False);
        tkKey:FormatToken(GetToken, fKeyAttri, False,False);
        tkNumber:FormatToken(GetToken, fNumberAttri, False,False);
        {Needed to catch Line breaks}
        tkNull:FormatToken('', nil, False,False);
        tkSpace:FormatToken(GetToken, fSpaceAttri, False,True);
        tkString:FormatToken(GetToken, fStringAttri, True,False);
        tkSymbol:FormatToken(GetToken, fSymbolAttri,True,False);
        tkUnknown:FormatToken(GetToken, fSymbolAttri, True,False);
      end;
    end; //with
end;

Initialization
  MakeIdentTable;
end.

