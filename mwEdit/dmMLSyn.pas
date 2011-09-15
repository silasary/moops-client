{

The contents of this file are subject to the Netscape Public License Version 1.1 (the "License");
you may not use this file except in compliance with the License.

You may obtain a copy of the License at http://www.mozilla.org/NPL/NPL-1_1Final.html

Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND,
either express or implied.

See the License for the specific language governing rights and limitations under the License.

The Original Code is dmMLSyn.pas

The Initial Developer of the Original Code is David H Muir (david@loanhead45.freeserve.co.uk) and portions
written by David H Muir are Copyright © 1999 David H Muir, All Rights Reserved.

Contributor(s): David Muir, Michael Hieke

Version 0.30   Last Edited: 18/11/1999
  David Muir
  + Added new token attributes: tkSyntaxError
  + Unrecognnised characters are highlighted with tkSyntaxError
  + CharacterProc now fixed
Version 0.25   Last Edited: 14/11/1999
  David Muir
  + Changed CharacterProc to only highlight legal Standard ML characters
Version 0.24
  Michael Hieke
  + Cleaned up code by removing many procedures that did the same thing
  David Muir
  + Added "else" part to AmpersandProc
  + Changed AmpersandProc to BasisOpProc for Basis Library Operators
    + And implemented changes to call this for characters '^' and '@' (don't know why I called it Ampersand before)
Version 0.23
  David Muir
  + Changed default colours for the highlight attributes
  + Fixed small bug in "CharacterProc"
Version 0.22
  David Muir
  + Added new Basis: Boolean property activates Basis Library only common operators (List ops @ :: for example)
  + There is still (probably) quite a few standard parts of SML not covered in this highlighter its just I won't
  + have come across it yet!  Feel free to drop me a email giving details: david@loanhead45.freeserve.co.uk
  + A bit of work needs done on the character highlight because only #'f' should be highlighterd rather than
  + #'ff' as only single characters are "legal"
  + (* style comments are working
}

unit dmMLSyn;

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Graphics, Registry,
  mwHighlighter, mwExport, mwLocalStr;

Type
  TtkTokenKind = (
    tkCharacter,
    tkComment,
    tkIdentifier,
    tkKey,
    tkNull,
    tkNumber,
    tkOperator,
    tkSpace,
    tkString,
    tkSymbol,
    tkSyntaxError,
    tkUnknown);

  TRangeState = (rsUnKnown);

  TProcTableProc = procedure of Object;

  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function: TtkTokenKind of Object;

type
  TdmMLSyn = class(TmwCustomHighLighter)
  private
    FBasis: Boolean;
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
    fIdentFuncTable: array[0..145] of TIdentFuncTableFunc;
    fCharacterAttri: TmwHighLightAttributes;
    fCommentAttri: TmwHighLightAttributes;
    fIdentifierAttri: TmwHighLightAttributes;
    fKeyAttri: TmwHighLightAttributes;
    fNumberAttri: TmwHighLightAttributes;
    fOperatorAttri: TmwHighLightAttributes;
    fSpaceAttri: TmwHighLightAttributes;
    fStringAttri: TmwHighLightAttributes;
    fSymbolAttri: TmwHighLightAttributes;
    fSyntaxErrorAttri: TmwHighLightAttributes;
    function IsValidMLCharacter(Ch: Char): Boolean;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: String): Boolean;
    function Func15:TtkTokenKind;
    function Func19:TtkTokenKind;
    function Func20:TtkTokenKind;
    function Func21:TtkTokenKind;
    function Func23:TtkTokenKind;
    function Func26:TtkTokenKind;
    function Func28:TtkTokenKind;
    function Func31:TtkTokenKind;
    function Func35:TtkTokenKind;
    function Func37:TtkTokenKind;
    function Func41:TtkTokenKind;
    function Func43:TtkTokenKind;
    function Func44:TtkTokenKind;
    function Func47:TtkTokenKind;
    function Func50:TtkTokenKind;
    function Func52:TtkTokenKind;
    function Func57:TtkTokenKind;
    function Func59:TtkTokenKind;
    function Func60:TtkTokenKind;
    function Func62:TtkTokenKind;
    function Func66:TtkTokenKind;
    function Func68:TtkTokenKind;
    function Func74:TtkTokenKind;
    function Func76:TtkTokenKind;
    function Func80:TtkTokenKind;
    function Func82:TtkTokenKind;
    function Func88:TtkTokenKind;
    function Func92:TtkTokenKind;
    function Func97:TtkTokenKind;
    function Func101:TtkTokenKind;
    function Func111:TtkTokenKind;
    function Func114:TtkTokenKind;
    function Func126:TtkTokenKind;
    function Func145:TtkTokenKind;
    procedure AsciiCharProc;
    procedure CRProc;
    procedure CharacterProc;
    procedure ColonProc;
    procedure IdentProc;
    procedure LFProc;
    procedure NullProc;
    procedure NumberProc;
    procedure OperatorProc;
    procedure SpaceProc;
    procedure StringProc;
    procedure SymbolProc;
    procedure UnknownProc;
    procedure BasisOpProc;
    procedure RoundBracketOpen;
    function AltFunc: TtkTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PChar): TtkTokenKind;
    procedure MakeMethodTables;
    procedure SetDefaultAttributes;
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
    property CharacterAttri: TmwHighLightAttributes read fCharacterAttri write fCharacterAttri;
    property CommentAttri: TmwHighLightAttributes read fCommentAttri write fCommentAttri;
    property IdentifierAttri: TmwHighLightAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TmwHighLightAttributes read fKeyAttri write fKeyAttri;
    property NumberAttri: TmwHighLightAttributes read fNumberAttri write fNumberAttri;
    property OperatorAttri: TmwHighLightAttributes read fOperatorAttri write fOperatorAttri;
    property SpaceAttri: TmwHighLightAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri: TmwHighLightAttributes read fStringAttri write fStringAttri;
    property SymbolAttri: TmwHighLightAttributes read fSymbolAttri write fSymbolAttri;
    property SyntaxErrorAttri: TmwHighLightAttributes read fSyntaxErrorAttri write fSyntaxErrorAttri;
    property Exporter:TmwCustomExport read FExporter write FExporter;
    property Basis: Boolean read FBasis write FBasis default True;
  end;

procedure Register;

{$I mwEdit.inc} { Needed for Compiler Directives }

implementation

procedure Register;
begin
  RegisterComponents(MWS_HighlightersPage, [TdmMLSyn]);
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
    Case I in ['_', 'A'..'Z', 'a'..'z'] of
      True: mHashTable[I] := Ord(J) - 64
    else mHashTable[I] := 0;
    end;
  end;
end;

function TdmMLSyn.IsValidMLCharacter(Ch: Char): Boolean;
begin
  if (Ch in ['A'..'Z', 'a'..'z', '0'..'9']) then Result := True
  else case Ch of
    '\','|',',','.','<','>','/','?',':',';','@','#','~','[','{',']','}','_','-','=','+',
    '!','"','£','$','%','^','&','*','(',')': Result := True
    else Result := False;
  end;
end; { IsValidMLCharacter }

procedure TdmMLSyn.InitIdent;
var
  I: Integer;
  pF: PIdentFuncTableFunc;
begin
  pF := PIdentFuncTableFunc(@fIdentFuncTable);
  for I := Low(fIdentFuncTable) to High(fIdentFuncTable) do begin
    pF^ := AltFunc;
    Inc(pF);
  end;
  fIdentFuncTable[15] := Func15;
  fIdentFuncTable[19] := Func19;
  fIdentFuncTable[20] := Func20;
  fIdentFuncTable[21] := Func21;
  fIdentFuncTable[23] := Func23;
  fIdentFuncTable[26] := Func26;
  fIdentFuncTable[28] := Func28;
  fIdentFuncTable[31] := Func31;
  fIdentFuncTable[35] := Func35;
  fIdentFuncTable[37] := Func37;
  fIdentFuncTable[41] := Func41;
  fIdentFuncTable[43] := Func43;
  fIdentFuncTable[44] := Func44;
  fIdentFuncTable[47] := Func47;
  fIdentFuncTable[50] := Func50;
  fIdentFuncTable[52] := Func52;
  fIdentFuncTable[57] := Func57;
  fIdentFuncTable[59] := Func59;
  fIdentFuncTable[60] := Func60;
  fIdentFuncTable[62] := Func62;
  fIdentFuncTable[66] := Func66;
  fIdentFuncTable[68] := Func68;
  fIdentFuncTable[74] := Func74;
  fIdentFuncTable[76] := Func76;
  fIdentFuncTable[80] := Func80;
  fIdentFuncTable[82] := Func82;
  fIdentFuncTable[88] := Func88;
  fIdentFuncTable[92] := Func92;
  fIdentFuncTable[97] := Func97;
  fIdentFuncTable[101] := Func101;
  fIdentFuncTable[111] := Func111;
  fIdentFuncTable[114] := Func114;
  fIdentFuncTable[126] := Func126;
  fIdentFuncTable[145] := Func145;
end;

function TdmMLSyn.KeyHash(ToHash: PChar): Integer;
begin
  Result := 0;
  while ToHash^ in ['_', '0'..'9', 'a'..'z', 'A'..'Z'] do
  begin
    inc(Result, mHashTable[ToHash^]);
    inc(ToHash);
  end;
  fStringLen := ToHash - fToIdent;
end;

function TdmMLSyn.KeyComp(const aKey: String): Boolean;
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

function TdmMLSyn.Func15: TtkTokenKind;
begin
  if KeyComp('if') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func19: TtkTokenKind;
begin
  if KeyComp('do') then Result := tkKey else
    if KeyComp('and') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func20: TtkTokenKind;
begin
  if KeyComp('as') then Result := tkKey else
    if KeyComp('fn') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func21: TtkTokenKind;
begin
  if KeyComp('of') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func23: TtkTokenKind;
begin
  if KeyComp('in') then Result := tkKey else
    if KeyComp('end') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func26: TtkTokenKind;
begin
  if KeyComp('rec') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func28: TtkTokenKind;
begin
  if KeyComp('case') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func31: TtkTokenKind;
begin
  if KeyComp('op') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func35: TtkTokenKind;
begin
  if KeyComp('val') then Result := tkKey else
    if KeyComp('sig') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func37: TtkTokenKind;
begin
  if KeyComp('let') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func41: TtkTokenKind;
begin
  if KeyComp('fun') then Result := tkKey else
    if KeyComp('else') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func43: TtkTokenKind;
begin
  if KeyComp('local') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func44: TtkTokenKind;
begin
  if KeyComp('handle') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func47: TtkTokenKind;
begin
  if KeyComp('then') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func50: TtkTokenKind;
begin
  if KeyComp('open') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func52: TtkTokenKind;
begin
  if KeyComp('raise') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func57: TtkTokenKind;
begin
  if KeyComp('while') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func59: TtkTokenKind;
begin
  if KeyComp('where') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func60: TtkTokenKind;
begin
  if KeyComp('with') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func62: TtkTokenKind;
begin
  if KeyComp('infix') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func66: TtkTokenKind;
begin
  if KeyComp('andalso') then Result := tkKey else
    if KeyComp('type') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func68: TtkTokenKind;
begin
  if KeyComp('include') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func74: TtkTokenKind;
begin
  if KeyComp('orelse') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func76: TtkTokenKind;
begin
  if KeyComp('sharing') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func80: TtkTokenKind;
begin
  if KeyComp('infixr') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func82: TtkTokenKind;
begin
  if KeyComp('nonfix') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func88: TtkTokenKind;
begin
  if KeyComp('abstype') then Result := tkKey else
    if KeyComp('eqtype') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func92: TtkTokenKind;
begin
  if KeyComp('datatype') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func97: TtkTokenKind;
begin
  if KeyComp('functor') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func101: TtkTokenKind;
begin
  if KeyComp('struct') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func111: TtkTokenKind;
begin
  if KeyComp('exception') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func114: TtkTokenKind;
begin
  if KeyComp('signature') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func126: TtkTokenKind;
begin
  if KeyComp('withtype') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.Func145: TtkTokenKind;
begin
  if KeyComp('structure') then Result := tkKey else Result := tkIdentifier;
end;

function TdmMLSyn.AltFunc: TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TdmMLSyn.IdentKind(MayBe: PChar): TtkTokenKind;
var
  HashKey: Integer;
begin
  fToIdent := MayBe;
  HashKey := KeyHash(MayBe);
  if HashKey < 146 then Result := fIdentFuncTable[HashKey] else Result := tkIdentifier;
end;

procedure TdmMLSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      #39: fProcTable[I] := AsciiCharProc;
      #13: fProcTable[I] := CRProc;
      '#': fProcTable[I] := CharacterProc;
      ':': fProcTable[I] := ColonProc;
      'A'..'Z', 'a'..'z', '_': fProcTable[I] := IdentProc;
      #10: fProcTable[I] := LFProc;
      #0: fProcTable[I] := NullProc;
      '0'..'9': fProcTable[I] := NumberProc;
      #1..#9, #11, #12, #14..#32: fProcTable[I] := SpaceProc;
      '"': fProcTable[I] := StringProc;
      '@', '^': fProcTable[I] := BasisOpProc;
      '(': fProcTable[I] := RoundBracketOpen;
      '+', '-', '~', '*', '/', '=', '<', '>':  fProcTable[i] := OperatorProc;
      ',', '.',  ';': fProcTable[I] := SymbolProc;
    else fProcTable[I] := UnknownProc;
    end;
end;

procedure TdmMLSyn.SetDefaultAttributes;
begin
  fCharacterAttri.Foreground := clBlue;
  fCommentAttri.Style := [fsItalic];
  fCommentAttri.Foreground := clNavy;
  fKeyAttri.Style := [fsBold];
  fKeyAttri.Foreground := clGreen;
  fNumberAttri.Foreground := clRed;
  fOperatorAttri.Foreground := clMaroon;
  fStringAttri.Foreground := clBlue;
  fSyntaxErrorAttri.Foreground := clRed;
  fSyntaxErrorAttri.Style := [fsBold];
end; { TdmMLSyn.SetDefaultAttributes }

constructor TdmMLSyn.Create(AOwner: TComponent);
begin
  fCharacterAttri := TmwHighLightAttributes.Create(MWS_AttrCharacter);
  fCommentAttri := TmwHighLightAttributes.Create(MWS_AttrComment);
  fIdentifierAttri := TmwHighLightAttributes.Create(MWS_AttrIdentifier);
  fKeyAttri := TmwHighLightAttributes.Create(MWS_AttrReservedWord);
  fNumberAttri := TmwHighLightAttributes.Create(MWS_AttrNumber);
  fOperatorAttri := TmwHighLightAttributes.Create(MWS_AttrOperator);
  fSpaceAttri := TmwHighLightAttributes.Create(MWS_AttrSpace);
  fStringAttri := TmwHighLightAttributes.Create(MWS_AttrString);
  fSymbolAttri := TmwHighLightAttributes.Create(MWS_AttrSymbol);
  fSyntaxErrorAttri := TmwHighLightAttributes.Create(MWS_AttrSyntaxError);
  inherited Create(AOwner);
  AddAttribute(fCharacterAttri);
  AddAttribute(fCommentAttri);
  AddAttribute(fIdentifierAttri);
  AddAttribute(fKeyAttri);
  AddAttribute(fNumberAttri);
  AddAttribute(fOperatorAttri);
  AddAttribute(fSpaceAttri);
  AddAttribute(fStringAttri);
  AddAttribute(fSymbolAttri);
  AddAttribute(fSyntaxErrorAttri);
  SetAttributesOnChange(DefHighlightChange);
  InitIdent;
  MakeMethodTables;
  fDefaultFilter := MWS_FilterML;
  fRange := rsUnknown;
  Basis := True;
  SetDefaultAttributes;
end;

procedure TdmMLSyn.SetLine(NewValue: String; LineNumber: Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end;

procedure TdmMLSyn.AsciiCharProc;
begin
  fTokenID := tkString;
  repeat
    Inc(Run);
  until fLine[Run] in [#0, #10, #13, #39];
  if fLine[Run] = #39 then inc(Run);
end;

procedure TdmMLSyn.CRProc;
begin
  fTokenID := tkSpace;
  Case FLine[Run + 1] of
    #10: inc(Run, 2);
  else inc(Run);
  end;
end;

procedure TdmMLSyn.CharacterProc;
begin
  if (FLine[Run+1] = '"') and IsValidMLCharacter(FLine[Run+2]) and (FLine[Run+3] = '"') then begin
    fTokenID := tkCharacter;
    inc(Run, 4);
  end
  else begin
    fTokenID := tkSyntaxError;
    if (FLine[Run+1] = '"') then Inc(Run);
    if IsValidMLCharacter(FLine[Run+1]) then Inc(Run);
    if (FLine[Run+1] = '"') then Inc(Run);
    inc(Run);
  end;
end;

procedure TdmMLSyn.ColonProc;
begin
  inc(Run);
  if Basis and (fLine[Run] = ':') then begin
    fTokenID := tkOperator;
    inc(Run);
  end
  else fTokenID := tkSymbol;
end;

procedure TdmMLSyn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
end;

procedure TdmMLSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TdmMLSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TdmMLSyn.NumberProc;
begin
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in
      ['0'..'9', '.', 'u', 'U', 'l', 'L', 'x', 'X', 'e', 'E', 'f', 'F'] do
  begin
    case FLine[Run] of
      '.':  if FLine[Run + 1] = '.' then break;
    end;
    inc(Run);
  end;
end;

procedure TdmMLSyn.OperatorProc;
begin
  inc(Run);
  fTokenID := tkOperator;
end;

procedure TdmMLSyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkSpace;
  while FLine[Run] in [#1..#9, #11, #12, #14..#32] do inc(Run);
end;

procedure TdmMLSyn.StringProc;
begin
  fTokenID := tkString;
  if (FLine[Run + 1] = #34) and (FLine[Run + 2] = #34) then inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
      #92:
        if FLine[Run + 1] = #10 then inc(Run);
    end;
    inc(Run);
  until FLine[Run] = #34;
  if FLine[Run] <> #0 then inc(Run);
end;

procedure TdmMLSyn.SymbolProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
end;

procedure TdmMLSyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TdmMLSyn.BasisOpProc;
begin
  inc(Run);
  if Basis then fTokenID := tkOperator else fTokenID := tkIdentifier;
end;

procedure TdmMLSyn.RoundBracketOpen;
begin
  Inc(Run);
  if (FLine[Run] = '*') then begin
    fTokenID := tkComment;
    inc(Run);
    while fLine[Run] <> #0 do
      case fLine[Run] of
        '*': if fLine[Run + 1] = ')' then begin
               inc(Run, 2);
               break;
             end
             else inc(Run);
        #10: break;
        #13: break;
        else inc(Run);
      end
  end
  else fTokenID := tkIdentifier;
end;

procedure TdmMLSyn.Next;
begin
  fTokenPos := Run;
  fProcTable[fLine[Run]];
end;

function TdmMLSyn.GetEOL: Boolean;
begin
  Result := fTokenID = tkNull;
end;

function TdmMLSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

function TdmMLSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TdmMLSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TdmMLSyn.GetTokenAttribute: TmwHighLightAttributes;
begin
  case GetTokenID of
    tkCharacter: Result := fCharacterAttri;
    tkComment: Result := fCommentAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkNumber: Result := fNumberAttri;
    tkOperator: Result := fOperatorAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
    tkSymbol: Result := fSymbolAttri;
    tkSyntaxError: Result := fSyntaxErrorAttri;
    tkUnknown: Result := fIdentifierAttri;
  else Result := nil;
  end;
end;

function TdmMLSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TdmMLSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

procedure TdmMLSyn.ReSetRange;
begin
  fRange := rsUnknown;
end;

procedure TdmMLSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TdmMLSyn.GetIdentChars: TIdentChars;
begin
  Result := ['_', '0'..'9', 'a'..'z', 'A'..'Z'];
end;

function TdmMLSyn.GetLanguageName: string;
begin
  Result := MWS_LangML;
end;

function TdmMLSyn.GetCapability: THighlighterCapability;
begin
  Result := inherited GetCapability + [hcUserSettings, hcExportable];
end;

procedure TdmMLSyn.SetLineForExport(NewValue: String);
begin
  fLine := PChar(NewValue);
  Run := 0;
  ExportNext;
end;

procedure TdmMLSyn.ExportNext;
begin
  fTokenPos := Run;
  fProcTable[fLine[Run]];
  if Assigned(Exporter) then
    Case GetTokenID of
      tkCharacter: TmwCustomExport(Exporter).FormatToken(GetToken, fCharacterAttri, False, False);
      tkComment: TmwCustomExport(Exporter).FormatToken(GetToken, fCommentAttri, True, False);
      tkIdentifier: TmwCustomExport(Exporter).FormatToken(GetToken, fIdentifierAttri, False, False);
      tkKey: TmwCustomExport(Exporter).FormatToken(GetToken, fKeyAttri, False, False);
      tkNumber: TmwCustomExport(Exporter).FormatToken(GetToken, fNumberAttri, False, False);
      tkOperator: TmwCustomExport(Exporter).FormatToken(GetToken, fOperatorAttri, False, False);
      tkSpace: TmwCustomExport(Exporter).FormatToken(GetToken, fSpaceAttri, False, True);
      tkString: TmwCustomExport(Exporter).FormatToken(GetToken, fStringAttri, True, False);
      tkSymbol: TmwCustomExport(Exporter).FormatToken(GetToken, fSymbolAttri, True, False);
      tkSyntaxError: TmwCustomExport(Exporter).FormatToken(GetToken, fSyntaxErrorAttri, False, False);
    end;
end;

initialization
  MakeIdentTable;
end.
