{
 Class:       TcwCACSyn
 Created:     1998-12-27
 Last change: 1999-10-27
 Author:      Carlos Wijders (ctfbs@sr.net)
 Description: CA-Clipper syntax highliter
 Version:     0.25
 Copyright (c) 1999 Carlos Wijders
 All rights reserved.

 Thanks to: Primoz Gabrijelcic, Andy Jeffries

 Version history: see version.rtf
}

unit cwCACSyn;

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Graphics, Registry,
  mwHighlighter, mwLocalStr;

type
  TtkTokenKind = (
    tkComment,
    tkDirective,
    tkIdentifier,
    tkKey,
    tkNull,
    tkNumber,
    tkSpace,
    tkString,
    tkOperator,
    tkUnknown);

  TRangeState = (rsANil, rsCStyle, rsUnKnown);

  TProcTableProc = procedure of object;
  TIdentFuncTableFunc = function: TtkTokenKind of object;

  TcwCACSyn = class(TmwCustomHighLighter)
  private
    fRange: TRangeState;
    fLine: PChar;
    fProcTable: array[#0..#255] of TProcTableProc;
    Run: LongInt;
    fStringLen: Integer;
    fToIdent: PChar;
    fTokenPos: Integer;
    FTokenID: TtkTokenKind;
    fEol: Boolean;
    fLineNumber: Integer;
    fStringAttri: TmwHighLightAttributes;
    fOperatorAttri: TmwHighLightAttributes;
    fKeyAttri: TmwHighLightAttributes;
    fNumberAttri: TmwHighLightAttributes;
    fCommentAttri: TmwHighLightAttributes;
    fSpaceAttri: TmwHighLightAttributes;
    fIdentifierAttri: TmwHighLightAttributes;
    fDirecAttri: TmwHighLightAttributes;

    fIdentFuncTable: array[0..124] of TIdentFuncTableFunc;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: string): Boolean;
    function Func10: TtkTokenKind;
    function Func15: TtkTokenKind;
    function Func19: TtkTokenKind;
    function Func21: TtkTokenKind;
    function Func22: TtkTokenKind;
    function Func23: TtkTokenKind;
    function Func24: TtkTokenKind;
    function Func26: TtkTokenKind;
    function Func28: TtkTokenKind;
    function Func29: TtkTokenKind;
    function Func30: TtkTokenKind;
    function Func31: TtkTokenKind;
    function Func32: TtkTokenKind;
    function Func33: TtkTokenKind;
    function Func34: TtkTokenKind;
    function Func35: TtkTokenKind;
    function Func36: TtkTokenKind;
    function Func37: TtkTokenKind;
    function Func38: TtkTokenKind;
    function Func39: TtkTokenKind;
    function Func40: TtkTokenKind;
    function Func41: TtkTokenKind;
    function Func42: TtkTokenKind;
    function Func43: TtkTokenKind;
    function Func44: TtkTokenKind;
    function Func45: TtkTokenKind;
    function Func46: TtkTokenKind;
    function Func47: TtkTokenKind;
    function Func48: TtkTokenKind;
    function Func49: TtkTokenKind;
    function Func51: TtkTokenKind;
    function Func52: TtkTokenKind;
    function Func53: TtkTokenKind;
    function Func54: TtkTokenKind;
    function Func55: TtkTokenKind;
    function Func56: TtkTokenKind;
    function Func57: TtkTokenKind;
    function Func58: TtkTokenKind;
    function Func59: TtkTokenKind;
    function Func60: TtkTokenKind;
    function Func63: TtkTokenKind;
    function Func64: TtkTokenKind;
    function Func65: TtkTokenKind;
    function Func66: TtkTokenKind;
    function Func67: TtkTokenKind;
    function Func68: TtkTokenKind;
    function Func69: TtkTokenKind;
    function Func70: TtkTokenKind;
    function Func72: TtkTokenKind;
    function Func73: TtkTokenKind;
    function Func74: TtkTokenKind;
    function Func76: TtkTokenKind;
    function Func77: TtkTokenKind;
    function Func78: TtkTokenKind;
    function Func79: TtkTokenKind;
    function Func80: TtkTokenKind;
    function Func81: TtkTokenKind;
    function Func86: TtkTokenKind;
    function Func87: TtkTokenKind;
    function Func89: TtkTokenKind;
    function Func91: TtkTokenKind;
    function Func94: TtkTokenKind;
    function Func96: TtkTokenKind;
    function Func98: TtkTokenKind;
    function Func99: TtkTokenKind;
    function Func100: TtkTokenKind;
    function Func101: TtkTokenKind;
    function Func102: TtkTokenKind;
    function Func105: TtkTokenKind;
    function Func116: TtkTokenKind;
    function Func124: TtkTokenKind;
    procedure StarProc;
    procedure CRProc;
    procedure IdentProc;
    procedure LFProc;
    procedure NullProc;
    procedure NumberProc;
    procedure SlashProc;
    procedure SpaceProc;
    procedure SymbolProc;
    procedure StringProc;
    procedure DirectiveProc;
    procedure UnknownProc;
    function AltFunc: TtkTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PChar): TtkTokenKind;
    procedure MakeMethodTables;

    procedure CStyleProc;
  protected
    function GetLanguageName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetEol: Boolean; override;
    function GetRange: Pointer; override;
    function GetTokenID: TtkTokenKind;
    procedure SetLine(NewValue: string; LineNumber: Integer); override;
    function GetToken: string; override;
    function GetTokenAttribute: TmwHighLightAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    procedure Next; override;
    procedure SetRange(Value: Pointer); override;
    procedure ReSetRange; override;

  published
    property CommentAttri: TmwHighLightAttributes read fCommentAttri write fCommentAttri;
    property IdentifierAttri: TmwHighLightAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TmwHighLightAttributes read fKeyAttri write fKeyAttri;
    property NumberAttri: TmwHighLightAttributes read fNumberAttri write fNumberAttri;
    property SpaceAttri: TmwHighLightAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri: TmwHighLightAttributes read fStringAttri write fStringAttri;
    property OperatorAttri: TmwHighLightAttributes read fOperatorAttri write fOperatorAttri;
    property DirecAttri: TmwHighLightAttributes read fDirecAttri write fDirecAttri;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents(MWS_HighlightersPage, [TcwCACSyn]);
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
    case I of
      '_', '0'..'9', 'a'..'z', 'A'..'Z': Identifiers[I] := True;
    else Identifiers[I] := False;
    end;
    J := UpperCase(I)[1];
    case I in ['_', 'a'..'z', 'A'..'Z'] of
      True: mHashTable[I] := Ord(J) - 64
    else mHashTable[I] := 0;
    end;
  end;
end;

procedure TcwCACSyn.InitIdent;
var
  I: Integer;
begin
  for I := 0 to 124 do
    case I of
      10: fIdentFuncTable[I] := Func10;
      15: fIdentFuncTable[I] := Func15;
      19: fIdentFuncTable[I] := Func19;
      21: fIdentFuncTable[I] := Func21;
      22: fIdentFuncTable[I] := Func22;
      23: fIdentFuncTable[I] := Func23;
      24: fIdentFuncTable[I] := Func24;
      26: fIdentFuncTable[I] := Func26;
      28: fIdentFuncTable[I] := Func28;
      29: fIdentFuncTable[I] := Func29;
      30: fIdentFuncTable[I] := Func30;
      31: fIdentFuncTable[I] := Func31;
      32: fIdentFuncTable[I] := Func32;
      33: fIdentFuncTable[I] := Func33;
      34: fIdentFuncTable[I] := Func34;
      35: fIdentFuncTable[I] := Func35;
      36: fIdentFuncTable[I] := Func36;
      37: fIdentFuncTable[I] := Func37;
      38: fIdentFuncTable[I] := Func38;
      39: fIdentFuncTable[I] := Func39;
      40: fIdentFuncTable[I] := Func40;
      41: fIdentFuncTable[I] := Func41;
      42: fIdentFuncTable[I] := Func42;
      43: fIdentFuncTable[I] := Func43;
      44: fIdentFuncTable[I] := Func44;
      45: fIdentFuncTable[I] := Func45;
      46: fIdentFuncTable[I] := Func46;
      47: fIdentFuncTable[I] := Func47;
      48: fIdentFuncTable[I] := Func48;
      49: fIdentFuncTable[I] := Func49;
      51: fIdentFuncTable[I] := Func51;
      52: fIdentFuncTable[I] := Func52;
      53: fIdentFuncTable[I] := Func53;
      54: fIdentFuncTable[I] := Func54;
      55: fIdentFuncTable[I] := Func55;
      56: fIdentFuncTable[I] := Func56;
      57: fIdentFuncTable[I] := Func57;
      58: fIdentFuncTable[I] := Func58;
      59: fIdentFuncTable[I] := Func59;
      60: fIdentFuncTable[I] := Func60;
      63: fIdentFuncTable[I] := Func63;
      64: fIdentFuncTable[I] := Func64;
      65: fIdentFuncTable[I] := Func65;
      66: fIdentFuncTable[I] := Func66;
      67: fIdentFuncTable[I] := Func67;
      68: fIdentFuncTable[I] := Func68;
      69: fIdentFuncTable[I] := Func69;
      70: fIdentFuncTable[I] := Func70;
      72: fIdentFuncTable[I] := Func72;
      73: fIdentFuncTable[I] := Func73;
      74: fIdentFuncTable[I] := Func74;
      76: fIdentFuncTable[I] := Func76;
      77: fIdentFuncTable[I] := Func77;
      78: fIdentFuncTable[I] := Func78;
      79: fIdentFuncTable[I] := Func79;
      80: fIdentFuncTable[I] := Func80;
      81: fIdentFuncTable[I] := Func81;
      86: fIdentFuncTable[I] := Func86;
      87: fIdentFuncTable[I] := Func87;
      89: fIdentFuncTable[I] := Func89;
      91: fIdentFuncTable[I] := Func91;
      94: fIdentFuncTable[I] := Func94;
      96: fIdentFuncTable[I] := Func96;
      98: fIdentFuncTable[I] := Func98;
      99: fIdentFuncTable[I] := Func99;
      100: fIdentFuncTable[I] := Func100;
      101: fIdentFuncTable[I] := Func101;
      102: fIdentFuncTable[I] := Func102;
      105: fIdentFuncTable[I] := Func105;
      116: fIdentFuncTable[I] := Func116;
      124: fIdentFuncTable[I] := Func124;
    else fIdentFuncTable[I] := AltFunc;
    end;
end;

function TcwCACSyn.KeyHash(ToHash: PChar): Integer;
begin
  Result := 0;
  while ToHash^ in ['_', '0'..'9', 'a'..'z', 'A'..'Z'] do
  begin
    inc(Result, mHashTable[ToHash^]);
    inc(ToHash);
  end;
  fStringLen := ToHash - fToIdent;
end;                                                                            { KeyHash }

function TcwCACSyn.KeyComp(const aKey: string): Boolean;
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
end;                                                                            { KeyComp }

function TcwCACSyn.Func10: TtkTokenKind;
begin
  if KeyComp('AADD') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func15: TtkTokenKind;
begin
  if KeyComp('IF') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func19: TtkTokenKind;
begin
  if KeyComp('AND') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func21: TtkTokenKind;
begin
  if KeyComp('AT') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func22: TtkTokenKind;
begin
  if KeyComp('GO') then Result := tkKey else
    if KeyComp('ABS') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func23: TtkTokenKind;
begin
  if KeyComp('BOF') then Result := tkKey else
    if KeyComp('ASC') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func24: TtkTokenKind;
begin
  if KeyComp('IIF') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func26: TtkTokenKind;
begin
  if KeyComp('EOF') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func28: TtkTokenKind;
begin
  if KeyComp('READ') then Result := tkKey else
    if KeyComp('CALL') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func29: TtkTokenKind;
begin
  if KeyComp('CHR') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func30: TtkTokenKind;
begin
  if KeyComp('DAY') then Result := tkKey else
    if KeyComp('DATE') then Result := tkKey else
      if KeyComp('COL') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func31: TtkTokenKind;
begin
  if KeyComp('PACK') then Result := tkKey else
    if KeyComp('LEN') then Result := tkKey else
      if KeyComp('DIR') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func32: TtkTokenKind;
begin
  if KeyComp('GET') then Result := tkKey else
    if KeyComp('FILE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func33: TtkTokenKind;
begin
  if KeyComp('FIND') then Result := tkKey else
    if KeyComp('OR') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func34: TtkTokenKind;
begin
  if KeyComp('LOG') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func35: TtkTokenKind;
begin
  if KeyComp('VAL') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func36: TtkTokenKind;
begin
  if KeyComp('FIELD') then Result := tkKey else
    if KeyComp('MIN') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func37: TtkTokenKind;
begin
  if KeyComp('BEGIN') then Result := tkKey else
    if KeyComp('BREAK') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func38: TtkTokenKind;
begin
  if KeyComp('ENDIF') then Result := tkKey else
    if KeyComp('CANCEL') then Result := tkKey else
      if KeyComp('MAX') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func39: TtkTokenKind;
begin
  if KeyComp('CLEAR') then Result := tkKey else
    if KeyComp('FOR') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func40: TtkTokenKind;
begin
  if KeyComp('SEEK') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func41: TtkTokenKind;
begin
  if KeyComp('ELSE') then Result := tkKey else
    if KeyComp('LOCK') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func42: TtkTokenKind;
begin
  if KeyComp('ENDDO') then Result := tkKey else
    if KeyComp('CTOD') then Result := tkKey else
      if KeyComp('DOW') then Result := tkKey else
        if KeyComp('DTOC') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func43: TtkTokenKind;
begin
  if KeyComp('LOCAL') then Result := tkKey else
    if KeyComp('INT') then Result := tkKey else
      if KeyComp('EJECT') then Result := tkKey else
        if KeyComp('ZAP') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func44: TtkTokenKind;
begin
  if KeyComp('SPACE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func45: TtkTokenKind;
begin
  if KeyComp('SAY') then Result := tkKey else
    if KeyComp('EXP') then Result := tkKey else
      if KeyComp('CDOW') then Result := tkKey else
        if KeyComp('USE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func46: TtkTokenKind;
begin
  if KeyComp('PCOL') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func47: TtkTokenKind;
begin
  if KeyComp('FLOCK') then Result := tkKey else
    if KeyComp('TIME') then Result := tkKey else
      if KeyComp('SAVE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func48: TtkTokenKind;
begin
  if KeyComp('DECLARE') then Result := tkKey else
    if KeyComp('ERASE') then Result := tkKey else
      if KeyComp('JOIN') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func49: TtkTokenKind;
begin
  if KeyComp('NOT') then Result := tkKey else
    if KeyComp('YEAR') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func51: TtkTokenKind;
begin
  if KeyComp('RECALL') then Result := tkKey else
    if KeyComp('DELETE') then Result := tkKey else
      if KeyComp('ENDCASE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func52: TtkTokenKind;
begin
  if KeyComp('INIT') then Result := tkKey else
    if KeyComp('CREATE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func53: TtkTokenKind;
begin
  if KeyComp('WAIT') then Result := tkKey else
    if KeyComp('SUM') then Result := tkKey else
      if KeyComp('RUN') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func54: TtkTokenKind;
begin
  if KeyComp('CLOSE') then Result := tkKey else
    if KeyComp('NOTE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func55: TtkTokenKind;
begin
  if KeyComp('DELETED') then Result := tkKey else
    if KeyComp('SKIP') then Result := tkKey else
      if KeyComp('RECNO') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func56: TtkTokenKind;
begin
  if KeyComp('ROW') then Result := tkKey else
    if KeyComp('INDEX') then Result := tkKey else
      if KeyComp('LOCATE') then Result := tkKey else
        if KeyComp('RENAME') then Result := tkKey else
          if KeyComp('ELSEIF') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func57: TtkTokenKind;
begin
  if KeyComp('WHILE') then Result := tkKey else
    if KeyComp('STR') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func58: TtkTokenKind;
begin
  if KeyComp('EXIT') then Result := tkKey else
    if KeyComp('DTOS') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func59: TtkTokenKind;
begin
  if KeyComp('RLOCK') then Result := tkKey else
    if KeyComp('COPY') then Result := tkKey else
      if KeyComp('AVERAGE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func60: TtkTokenKind;
begin
  if KeyComp('REPLACE') then Result := tkKey else
    if KeyComp('LIST') then Result := tkKey else
      if KeyComp('TRIM') then Result := tkKey else
        if KeyComp('WORD') then Result := tkKey else
          if KeyComp('FOUND') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func63: TtkTokenKind;
begin
  if KeyComp('PUBLIC') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func64: TtkTokenKind;
begin
  if KeyComp('SELECT') then Result := tkKey else
    if KeyComp('SELECT') then Result := tkKey else
      if KeyComp('INKEY') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func65: TtkTokenKind;
begin
  if KeyComp('RELEASE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func66: TtkTokenKind;
begin
  if KeyComp('TYPE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func67: TtkTokenKind;
begin
  if KeyComp('UPDATE') then Result := tkKey else
    if KeyComp('QUIT') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func68: TtkTokenKind;
begin
  if KeyComp('TOTAL') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func69: TtkTokenKind;
begin
  if KeyComp('TEXT') then Result := tkKey else
    if KeyComp('FIELDNAME') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func70: TtkTokenKind;
begin
  if KeyComp('MONTH') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func72: TtkTokenKind;
begin
  if KeyComp('ROUND') then Result := tkKey else
    if KeyComp('LTRIM') then Result := tkKey else
      if KeyComp('MEMVAR') then Result := tkKey else
        if KeyComp('SORT') then Result := tkKey else
          if KeyComp('STATIC') then Result := tkKey else
            if KeyComp('PROW') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func73: TtkTokenKind;
begin
  if KeyComp('LOWER') then Result := tkKey else
    if KeyComp('COUNT') then Result := tkKey else
      if KeyComp('COMMIT') then Result := tkKey else
        if KeyComp('CMONTH') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func74: TtkTokenKind;
begin
  if KeyComp('SQRT') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func76: TtkTokenKind;
begin
  if KeyComp('UPPER') then Result := tkKey else
    if KeyComp('UNLOCK') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func77: TtkTokenKind;
begin
  if KeyComp('STORE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func78: TtkTokenKind;
begin
  if KeyComp('RTRIM') then Result := tkKey else
    if KeyComp('LASTREC') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func79: TtkTokenKind;
begin
  if KeyComp('EMPTY') then Result := tkKey else
    if KeyComp('FCOUNT') then Result := tkKey else
      if KeyComp('SECONDS') then Result := tkKey else
        if KeyComp('REINDEX') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func80: TtkTokenKind;
begin
  if KeyComp('INPUT') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func81: TtkTokenKind;
begin
  if KeyComp('KEYBOARD') then Result := tkKey else
    if KeyComp('DEVPOS') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func86: TtkTokenKind;
begin
  if KeyComp('DISPLAY') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func87: TtkTokenKind;
begin
  if KeyComp('ANNOUNCE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func89: TtkTokenKind;
begin
  if KeyComp('PCOUNT') then Result := tkKey else
    if KeyComp('REPLICATE') then Result := tkKey else
      if KeyComp('SEQUENCE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func91: TtkTokenKind;
begin
  if KeyComp('PRIVATE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func94: TtkTokenKind;
begin
  if KeyComp('SETPOS') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func96: TtkTokenKind;
begin
  if KeyComp('RETURN') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func98: TtkTokenKind;
begin
  if KeyComp('PROMPT') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func99: TtkTokenKind;
begin
  if KeyComp('RECCOUNT') then Result := tkKey else
    if KeyComp('EXTERNAL') then Result := tkKey else
      if KeyComp('SUBSTR') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func100: TtkTokenKind;
begin
  if KeyComp('RESTORE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func101: TtkTokenKind;
begin
  if KeyComp('CONTINUE') then Result := tkKey else
    if KeyComp('VALTYPE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func102: TtkTokenKind;
begin
  if KeyComp('FUNCTION') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func105: TtkTokenKind;
begin
  if KeyComp('REQUEST') then Result := tkKey else
    if KeyComp('PROCEDURE') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func116: TtkTokenKind;
begin
  if KeyComp('PARAMETERS') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.Func124: TtkTokenKind;
begin
  if KeyComp('TRANSFORM') then Result := tkKey else Result := tkIdentifier;
end;

function TcwCACSyn.AltFunc: TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TcwCACSyn.IdentKind(MayBe: PChar): TtkTokenKind;
var
  HashKey: Integer;
begin
  fToIdent := MayBe;
  HashKey := KeyHash(MayBe);
  if HashKey < 125 then Result := fIdentFuncTable[HashKey] else Result := tkIdentifier;
end;

procedure TcwCACSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      '@': fProcTable[I] := SymbolProc;
      '&': fProcTable[I] := SymbolProc;
      '{': fProcTable[I] := SymbolProc;
      '}': fProcTable[I] := SymbolProc;
      #13: fProcTable[I] := CRProc;
      ':': fProcTable[I] := SymbolProc;
      ',': fProcTable[I] := SymbolProc;
      '#': fProcTable[I] := DirectiveProc;
      '=': fProcTable[I] := SymbolProc;
      '>': fProcTable[I] := SymbolProc;
      'A'..'Z', 'a'..'z': fProcTable[I] := IdentProc;
      '$': fProcTable[I] := SymbolProc;
      #10: fProcTable[I] := LFProc;
      '<': fProcTable[I] := SymbolProc;
      '-': fProcTable[I] := SymbolProc;
      '!': fProcTable[I] := SymbolProc;
      #0: fProcTable[I] := NullProc;
      '0'..'9': fProcTable[I] := NumberProc;
      '+': fProcTable[I] := SymbolProc;
      '.': fProcTable[I] := SymbolProc;
      '?': fProcTable[I] := SymbolProc;
      ')': fProcTable[I] := SymbolProc;
      '(': fProcTable[I] := SymbolProc;
      ';': fProcTable[I] := SymbolProc;
      '/': fProcTable[I] := SlashProc;
      #1..#9, #11, #12, #14..#32: fProcTable[I] := SpaceProc;
      ']': fProcTable[I] := SymbolProc;
      '[': fProcTable[I] := SymbolProc;
      '*': fProcTable[I] := StarProc;
      #39, #34: fProcTable[I] := StringProc;
    else fProcTable[I] := UnknownProc;
    end;
end;

constructor TcwCACSyn.Create(AOwner: TComponent);
begin
  fCommentAttri := TmwHighLightAttributes.Create(MWS_AttrComment);
  fCommentAttri.Style := [fsItalic];
  fIdentifierAttri := TmwHighLightAttributes.Create(MWS_AttrIdentifier);
  fKeyAttri := TmwHighLightAttributes.Create(MWS_AttrReservedWord);
  fKeyAttri.Style := [fsBold];
  fNumberAttri := TmwHighLightAttributes.Create(MWS_AttrNumber);
  fSpaceAttri := TmwHighLightAttributes.Create(MWS_AttrSpace);
  fStringAttri := TmwHighLightAttributes.Create(MWS_AttrString);
  fOperatorAttri := TmwHighLightAttributes.Create(MWS_AttrOperator);
  fDirecAttri := TmwHighLightAttributes.Create(MWS_AttrPreprocessor);
  inherited Create(AOwner);

  AddAttribute(fCommentAttri);
  AddAttribute(fIdentifierAttri);
  AddAttribute(fKeyAttri);
  AddAttribute(fNumberAttri);
  AddAttribute(fSpaceAttri);
  AddAttribute(fStringAttri);
  AddAttribute(fOperatorAttri);
  AddAttribute(fDirecAttri);

  InitIdent;
  SetAttributesOnChange(DefHighlightChange);
  MakeMethodTables;
  fRange := rsUnknown;
  fDefaultFilter := MWS_FilterCAClipper;
end;                                                                            { Create }

procedure TcwCACSyn.SetLine(NewValue: string; LineNumber: Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fEol := False;
  fLineNumber := LineNumber;
  Next;
end;                                                                            { SetLine }

procedure TcwCACSyn.CStyleProc;
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

procedure TcwCACSyn.CRProc;
begin
  fTokenID := tkSpace;
  case FLine[Run + 1] of
    #10: inc(Run, 2);
  else inc(Run);
  end;
end;

procedure TcwCACSyn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
end;

procedure TcwCACSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TcwCACSyn.NullProc;
begin
  fTokenID := tkNull;
  fEol := True;
end;

procedure TcwCACSyn.NumberProc;
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

procedure TcwCACSyn.SlashProc;
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
        fTokenID := tkComment;
        fRange := rsCStyle;
        inc(Run, 2);
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
  else
    begin
      inc(Run);
      fTokenID := tkOperator;
    end;
  end;
end;

procedure TcwCACSyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkSpace;
  while FLine[Run] in [#1..#9, #11, #12, #14..#32] do inc(Run);
end;

procedure TcwCACSyn.SymbolProc;
begin
  inc(Run);
  fTokenID := tkOperator;
end;

procedure TcwCACSyn.StringProc;
var
  ActiveStr: string[1];
begin
  fTokenID := tkString;
  ActiveStr := FLine[Run];
  if ((FLine[Run + 1] = #39) and (FLine[Run + 2] = #39)) or
    ((FLine[Run + 1] = #34) and (FLine[Run + 2] = #34)) then inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until (FLine[Run] = ActiveStr);
  if FLine[Run] <> #0 then inc(Run);
end;

procedure TcwCACSyn.DirectiveProc;
begin
  fTokenID := tkDirective;
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
      '/': if FLine[Run + 1] = '/' then break;
      #34, #39: break;
    end;
    inc(Run);
  until FLine[Run] = #0;
end;

procedure TcwCACSyn.UnknownProc;
begin
  inc(Run);
end;

procedure TcwCACSyn.Next;
begin
  fTokenPos := Run;
  case fRange of
    rsCStyle: CStyleProc;
  else fProcTable[fLine[Run]];
  end;
end;

function TcwCACSyn.GetEol: Boolean;
begin
  Result := fTokenId = tkNull;
end;

function TcwCACSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

function TcwCACSyn.GetToken: string;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TcwCACSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TcwCACSyn.GetTokenAttribute: TmwHighLightAttributes;
begin
  case fTokenID of
    tkComment: Result := fCommentAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkNumber: Result := fNumberAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
    tkDirective: Result := fDirecAttri;
    tkOperator: Result := fOperatorAttri;
    tkUnknown: Result := fOperatorAttri;
    else Result := nil;
  end;
end;

function TcwCACSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TcwCACSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

procedure TcwCACSyn.ReSetRange;
begin
  fRange := rsUnknown;
end;

procedure TcwCACSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TcwCACSyn.GetLanguageName: string;
begin
  Result := MWS_LangCAClipper;
end;

{Begin cw 1999-5-7}

procedure TcwCACSyn.StarProc;
begin

// if Run is 0 there could be an access violation
  if (Run = 0) or (fLine[Run - 1] in [#0, #10, #13]) then
  begin
    fTokenID := tkComment;
    repeat
      Inc(Run);
    until fLine[Run] in [#0, #10, #13];
  end else begin

    inc(Run);
    fTokenID := tkOperator;
  end;
end;

initialization
  MakeIdentTable;
end.

