{$I MWEDIT.INC}
{---------------------------------------------------------------------------
 Python Language Syntax Parser

 Class:       TodPySyn
 Created:     not known
 Last change: 1999-10-27
 Author:      Olivier Deckmyn
 Version:     1.03 (for version history see version.rtf)

 odPySyn was created as a plug in component for the Syntax Editor mwEdit
 created by Martin Waldenburg and friends.  For more information on the
 mwEdit project, see the following website:

 http://www.eccentrica.org/gabr/mw/mwedit.htm

 Copyright © 1998, Olivier Deckmyn.  All Rights Reserved.
 Portions Copyright Martin Waldenburg.
 Initially Created with mwSynGen by Martin Waldenburg.

 Thanks to: Martin Waldenburg, Primoz Gabrijelcic, James Jacobson.

 Special thanks to Martin Waldenburg.  You are a genius.
{---------------------------------------------------------------------------
 This component can be freely used and distributed. Redistributions of
 source code must retain the above copyright notice. If the source is
 modified, the complete original and unmodified source code has to
 distributed with the modified version.
{---------------------------------------------------------------------------
 Please note:  This source code is provided as a teaching tool. If you
 decide that you want to use whole routines or modules directly in an
 application that you are creating, please give credit where it is due.
{---------------------------------------------------------------------------}
unit odPySyn;

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Graphics, Registry,
  mwHighlighter, mwLocalStr;

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

  TRangeState = (rsANil, rsComment, rsUnKnown);

  TProcTableProc = procedure of Object;
  TIdentFuncTableFunc = function: TtkTokenKind of Object;

type
  TodPySyn = class(TmwCustomHighLighter)
  private
    fRange: TRangeState;
    fLine: PChar;
    fLineNumber: Integer;
    fProcTable: array[#0..#255] of TProcTableProc;
    Run: LongInt;
    fStringLen: Integer;
    fToIdent: PChar;
    fTokenPos: Integer;
    FTokenID: TtkTokenKind;
    fIdentFuncTable: array[0..101] of TIdentFuncTableFunc;
    fStringAttri: TmwHighLightAttributes;
    fNumberAttri: TmwHighLightAttributes;
    fKeyAttri: TmwHighLightAttributes;
    fSymbolAttri: TmwHighLightAttributes;
    fCommentAttri: TmwHighLightAttributes;
    fIdentifierAttri: TmwHighLightAttributes;
    fSpaceAttri: TmwHighLightAttributes;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: String): Boolean;
    function Func15:TtkTokenKind;
    function Func21:TtkTokenKind;
    function Func23:TtkTokenKind;
    function Func31:TtkTokenKind;
    function Func32:TtkTokenKind;
    function Func33:TtkTokenKind;
    function Func37:TtkTokenKind;
    function Func39:TtkTokenKind;
    function Func41:TtkTokenKind;
    function Func45:TtkTokenKind;
    function Func49:TtkTokenKind;
    function Func52:TtkTokenKind;
    function Func54:TtkTokenKind;
    function Func55:TtkTokenKind;
    function Func57:TtkTokenKind;
    function Func63:TtkTokenKind;
    function Func73:TtkTokenKind;
    function Func77:TtkTokenKind;
    function Func79:TtkTokenKind;
    function Func91:TtkTokenKind;
    function Func96:TtkTokenKind;
    function Func101:TtkTokenKind;
    procedure SymbolProc;
    procedure CRProc;
    procedure CommentProc;
    procedure GreaterProc;
    procedure IdentProc;
    procedure IntegerProc;
    procedure LFProc;
    procedure LowerProc;
    procedure NullProc;
    procedure NumberProc;
    procedure PointProc;
    procedure SpaceProc;
    procedure StringProc;
    procedure String2Proc;
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
    function GetEol: Boolean; override;
    function GetRange: Pointer; override;
    function GetTokenID: TtkTokenKind;
    procedure SetLine(NewValue: String; LineNumber:Integer); override;
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
    property NumberAttri: TmwHighLightAttributes read fNumberAttri write fNumberAttri;
    property SpaceAttri: TmwHighLightAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri: TmwHighLightAttributes read fStringAttri write fStringAttri;
    property SymbolAttri: TmwHighLightAttributes read fSymbolAttri write fSymbolAttri;
  end;

  procedure Register;

implementation

procedure Register;
begin
  RegisterComponents(MWS_HighlightersPage, [TodPySyn]);
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
    Case I in ['_','A'..'Z','a'..'z'] of
      True: mHashTable[I] := Ord(J) - 64
    else mHashTable[I] := 0;
    end;
  end;
end;

procedure TodPySyn.InitIdent;
var
  I: Integer;
begin
  for I := 0 to 101 do
    Case I of
      15: fIdentFuncTable[I] := Func15;
      21: fIdentFuncTable[I] := Func21;
      23: fIdentFuncTable[I] := Func23;
      31: fIdentFuncTable[I] := Func31;
      32: fIdentFuncTable[I] := Func32;
      33: fIdentFuncTable[I] := Func33;
      37: fIdentFuncTable[I] := Func37;
      39: fIdentFuncTable[I] := Func39;
      41: fIdentFuncTable[I] := Func41;
      45: fIdentFuncTable[I] := Func45;
      49: fIdentFuncTable[I] := Func49;
      52: fIdentFuncTable[I] := Func52;
      54: fIdentFuncTable[I] := Func54;
      55: fIdentFuncTable[I] := Func55;
      57: fIdentFuncTable[I] := Func57;
      63: fIdentFuncTable[I] := Func63;
      73: fIdentFuncTable[I] := Func73;
      77: fIdentFuncTable[I] := Func77;
      79: fIdentFuncTable[I] := Func79;
      91: fIdentFuncTable[I] := Func91;
      96: fIdentFuncTable[I] := Func96;
      101: fIdentFuncTable[I] := Func101;
    else fIdentFuncTable[I] := AltFunc;
    end;
end;

function TodPySyn.KeyHash(ToHash: PChar): Integer;
begin
  Result := 0;
  while ToHash^ in ['_', '0'..'9', 'a'..'z', 'A'..'Z'] do
  begin
    inc(Result, mHashTable[ToHash^]);
    inc(ToHash);
  end;
  fStringLen := ToHash - fToIdent;
end; { KeyHash }

function TodPySyn.KeyComp(const aKey: String): Boolean;
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
end; { KeyComp }

function TodPySyn.Func15: TtkTokenKind;
begin
  if KeyComp('Def') then Result := tkKey else
    if KeyComp('If') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func21: TtkTokenKind;
begin
  if KeyComp('Del') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func23: TtkTokenKind;
begin
  if KeyComp('In') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func31: TtkTokenKind;
begin
  if KeyComp('Len') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func32: TtkTokenKind;
begin
  if KeyComp('Elif') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func33: TtkTokenKind;
begin
  if KeyComp('Lambda') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func37: TtkTokenKind;
begin
  if KeyComp('Break') then Result := tkKey else
    if KeyComp('Exec') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func39: TtkTokenKind;
begin
  if KeyComp('For') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func41: TtkTokenKind;
begin
  if KeyComp('Else') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func45: TtkTokenKind;
begin
  if KeyComp('Range') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func49: TtkTokenKind;
begin
  if KeyComp('Global') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func52: TtkTokenKind;
begin
  if KeyComp('Raise') then Result := tkKey else
    if KeyComp('From') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func54: TtkTokenKind;
begin
  if KeyComp('Class') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func55: TtkTokenKind;
begin
  if KeyComp('Pass') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func57: TtkTokenKind;
begin
  if KeyComp('While') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func63: TtkTokenKind;
begin
  if KeyComp('Try') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func73: TtkTokenKind;
begin
  if KeyComp('Except') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func77: TtkTokenKind;
begin
  if KeyComp('Print') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func79: TtkTokenKind;
begin
  if KeyComp('Finally') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func91: TtkTokenKind;
begin
  if KeyComp('Import') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func96: TtkTokenKind;
begin
  if KeyComp('Return') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.Func101: TtkTokenKind;
begin
  if KeyComp('Continue') then Result := tkKey else Result := tkIdentifier;
end;

function TodPySyn.AltFunc: TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TodPySyn.IdentKind(MayBe: PChar): TtkTokenKind;
var
  HashKey: Integer;
begin
  fToIdent := MayBe;
  HashKey := KeyHash(MayBe);
  if HashKey < 102 then Result := fIdentFuncTable[HashKey] else Result := tkIdentifier;
end;

procedure TodPySyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      '@',
      '&',
      '}',
      '{',
      ':',
      ',',
      ']',
      '[',
      '*',
      '^',
      ')',
      '(',
      ';',
      '/',
      '=',
      '-',
      '+': fProcTable[I] := SymbolProc;

      #13: fProcTable[I] := CRProc;
      '#': fProcTable[I] := CommentProc;
      '>': fProcTable[I] := GreaterProc;
      'A'..'Z', 'a'..'z', '_': fProcTable[I] := IdentProc;
      '$': fProcTable[I] := IntegerProc;
      #10: fProcTable[I] := LFProc;
      '<': fProcTable[I] := LowerProc;
      #0: fProcTable[I] := NullProc;
      '0'..'9': fProcTable[I] := NumberProc;
      '.': fProcTable[I] := PointProc;
      #1..#9, #11, #12, #14..#32: fProcTable[I] := SpaceProc;
      #39: fProcTable[I] := StringProc;
      '"': fProcTable[I] := String2Proc;
    else fProcTable[I] := UnknownProc;
    end;
end;

constructor TodPySyn.Create(AOwner: TComponent);
begin
  fCommentAttri := TmwHighLightAttributes.Create(MWS_AttrComment);
  fCommentAttri.Foreground := clTeal;
  fCommentAttri.Style:= [fsItalic];
  fIdentifierAttri := TmwHighLightAttributes.Create(MWS_AttrIdentifier);
  fKeyAttri := TmwHighLightAttributes.Create(MWS_AttrReservedWord);
  fKeyAttri.Style:= [fsBold];
  fNumberAttri := TmwHighLightAttributes.Create(MWS_AttrNumber);
  fNumberAttri.Foreground := clBlue;
  fSpaceAttri := TmwHighLightAttributes.Create(MWS_AttrSpace);
  fStringAttri := TmwHighLightAttributes.Create(MWS_AttrString);
  fStringAttri.Foreground := clBlue;
  fSymbolAttri := TmwHighLightAttributes.Create(MWS_AttrSymbol);
  fRange := rsUnknown;

  inherited Create(AOwner);

  AddAttribute(fCommentAttri);
  AddAttribute(fIdentifierAttri);
  AddAttribute(fKeyAttri);
  AddAttribute(fNumberAttri);
  AddAttribute(fSpaceAttri);
  AddAttribute(fStringAttri);
  AddAttribute(fSymbolAttri);
  SetAttributesOnChange(DefHighlightChange);

  InitIdent;
  MakeMethodTables;
  fDefaultFilter := MWS_FilterPython;
end; { Create }

procedure TodPySyn.SetLine(NewValue: String; LineNumber:Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end; { SetLine }

procedure TodPySyn.SymbolProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
end;

procedure TodPySyn.CRProc;
begin
  fTokenID := tkSpace;
  Case FLine[Run + 1] of
    #10: inc(Run, 2);
  else inc(Run);
  end;
end;

procedure TodPySyn.CommentProc;
begin
  fTokenID := tkComment;
  inc(Run);
  while not (FLine[Run] in [#13,#10,#0]) do inc(Run);
end;

procedure TodPySyn.GreaterProc;
begin
  Case FLine[Run + 1] of
    '=':
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
end;

procedure TodPySyn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
end;

procedure TodPySyn.IntegerProc;
begin
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in ['0'..'9', 'A'..'F', 'a'..'f'] do inc(Run);
end;

procedure TodPySyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TodPySyn.LowerProc;
begin
  case FLine[Run + 1] of
    '=':
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
    '>':
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end
  else
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
end;

procedure TodPySyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TodPySyn.NumberProc;
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

procedure TodPySyn.PointProc;
begin
  case FLine[Run + 1] of
    '.':
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
    ')':
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
end;

procedure TodPySyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkSpace;
  while FLine[Run] in [#1..#9, #11, #12, #14..#32] do inc(Run);
end;

procedure TodPySyn.String2Proc;
begin
  fTokenID := tkString;
  if (FLine[Run + 1] = '"') and (FLine[Run + 2] = '"') then inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = '"';
  if FLine[Run] <> #0 then inc(Run);
end;

procedure TodPySyn.StringProc;
begin
  fTokenID := tkString;
  if (FLine[Run + 1] = #39) and (FLine[Run + 2] = #39) then inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = #39;
  if FLine[Run] <> #0 then inc(Run);
end;

procedure TodPySyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TodPySyn.Next;
begin
  fTokenPos := Run;
  fProcTable[fLine[Run]];
end;

function TodPySyn.GetEol: Boolean;
begin
  Result := fTokenId = tkNull;
end;

function TodPySyn.GetRange: Pointer;
begin
 Result := Pointer(fRange);
end;

function TodPySyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TodPySyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TodPySyn.GetTokenAttribute: TmwHighLightAttributes;
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

function TodPySyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TodPySyn.GetTokenPos: Integer;
begin
 Result := fTokenPos;
end;

procedure TodPySyn.ReSetRange;
begin
  fRange:= rsUnknown;
end;

procedure TodPySyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TodPySyn.GetIdentChars: TIdentChars;
begin
  Result := ['_', '0'..'9', 'a'..'z', 'A'..'Z'];
end;

function TodPySyn.GetLanguageName: string;
begin
  Result := MWS_LangPython;
end;

function TodPySyn.GetCapability: THighlighterCapability;
begin
  Result := inherited GetCapability + [hcUserSettings];
end;

Initialization
  MakeIdentTable;
end.

