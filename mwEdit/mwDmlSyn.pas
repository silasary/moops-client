{+--------------------------------------------------------------------------+
 |                GEMBASE Syntax Parser v0.51                               |
 +--------------------------------------------------------------------------+
 | Description:   GEMBASE syntax parser for use with mwCustomEdit.
 | Ross Systems is a leading provider of enterprise business solutions
 | for some of the most prestigious process manufacturing, healthcare and
 | public sector organizations in the world.
 | Their software Renaissance CS, is an integrated enterprise resource
 | planning (ERP) and supply chain management (SCM) solution.
 | (Just like Baan, JD-Edwards OneWorld, SAP, PeopleSoft)
 | Gembase is a 4GL programming language of Renaissance CS.
 | For more info please visit: www.rossinc.com
 +--------------------------------------------------------------------------+
 | Unit:            mwDMLSyn
 | Created:         1999-10-04
 | Last change:     1999-11-14
 | Author:          Peter Adam (adamp@extra.hu)
 | Copyright        (c) 1999 All rights reserved
 |                  (Large!) Portions Copyright Martin Waldenburg
 | Version:         0.52
 | Status:          Public Domain
 | DISCLAIMER:      This is provided as is, expressly without a warranty of any
 |                  kind. You use it at your own risc.
 +--------------------------------------------------------------------------+
 | Known problems:  There are no metadata qualifiers
 +--------------------------------------------------------------------------+
 | Revision History:
 | 0.50:    Initial version.
 | 0.51:    Optimisations, thanks to Michael Hieke
 | 0.52:    Made compatible with pointer type checking
 +--------------------------------------------------------------------------+}

{$I MWEDIT.INC}

unit mwDmlSyn;

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Graphics, Registry,
  mwHighlighter, mwLocalStr, mwExport;

type
  TtkTokenKind = (
    tkBlock,
    tkComment,
    tkForm,
    tkKey,
    tkQualifier,
    tkFunction,
    tkVariable,
    tkString,
    tkIdentifier,
    tkNumber,
    tkSpecial,
    tkNull,
    tkSpace,
    tkSymbol,
    tkUnknown);

  TRangeState = (rsANil, rsAdd, rsFind, rsUnKnown);

  TProcTableProc = procedure of object;
  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function: TtkTokenKind of object;

  TmwDmlSyn = class(TmwCustomHighLighter)
  private
    fRange: TRangeState;
    fLine: PChar;
    fLineNumber: Integer;
    fProcTable: array[#0..#255] of TProcTableProc;
    Run: LongInt;
    Temp: PChar;
    fStringLen: Integer;
    fToIdent: PChar;
    fIdentFuncTable: array[0..327] of TIdentFuncTableFunc;
    fTokenPos: Integer;
    FTokenID: TtkTokenKind;
    fFormAttri: TmwHighLightAttributes;
    fBlockAttri: TmwHighLightAttributes;
    fKeyAttri: TmwHighLightAttributes;
    fQualiAttri: TmwHighLightAttributes;
    fCommentAttri: TmwHighLightAttributes;
    fFunctionAttri: TmwHighLightAttributes;
    fVariableAttri: TmwHighLightAttributes;
    fSpecialAttri: TmwHighLightAttributes;
    fStringAttri: TmwHighLightAttributes;
    fNumberAttri: TmwHighLightAttributes;
    fSymbolAttri: TmwHighLightAttributes;
    fIdentifierAttri: TmwHighLightAttributes;
    fSpaceAttri: TmwHighLightAttributes;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: String): Boolean;
    function Func9: TtkTokenKind;
    function Func15: TtkTokenKind;
    function Func17: TtkTokenKind;
    function Func19: TtkTokenKind;
    function Func22: TtkTokenKind;
    function Func23: TtkTokenKind;
    function Func24: TtkTokenKind;
    function Func26: TtkTokenKind;
    function Func27: TtkTokenKind;
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
    function Func40: TtkTokenKind;
    function Func41: TtkTokenKind;
    function Func42: TtkTokenKind;
    function Func43: TtkTokenKind;
    function Func45: TtkTokenKind;
    function Func47: TtkTokenKind;
    function Func48: TtkTokenKind;
    function Func49: TtkTokenKind;
    function Func50: TtkTokenKind;
    function Func51: TtkTokenKind;
    function Func52: TtkTokenKind;
    function Func53: TtkTokenKind;
    function Func54: TtkTokenKind;
    function Func56: TtkTokenKind;
    function Func57: TtkTokenKind;
    function Func58: TtkTokenKind;
    function Func60: TtkTokenKind;
    function Func62: TtkTokenKind;
    function Func64: TtkTokenKind;
    function Func65: TtkTokenKind;
    function Func66: TtkTokenKind;
    function Func67: TtkTokenKind;
    function Func68: TtkTokenKind;
    function Func69: TtkTokenKind;
    function Func70: TtkTokenKind;
    function Func71: TtkTokenKind;
    function Func72: TtkTokenKind;
    function Func73: TtkTokenKind;
    function Func74: TtkTokenKind;
    function Func75: TtkTokenKind;
    function Func76: TtkTokenKind;
    function Func77: TtkTokenKind;
    function Func78: TtkTokenKind;
    function Func79: TtkTokenKind;
    function Func81: TtkTokenKind;
    function Func82: TtkTokenKind;
    function Func83: TtkTokenKind;
    function Func84: TtkTokenKind;
    function Func85: TtkTokenKind;
    function Func86: TtkTokenKind;
    function Func87: TtkTokenKind;
    function Func89: TtkTokenKind;
    function Func91: TtkTokenKind;
    function Func92: TtkTokenKind;
    function Func93: TtkTokenKind;
    function Func94: TtkTokenKind;
    function Func96: TtkTokenKind;
    function Func97: TtkTokenKind;
    function Func98: TtkTokenKind;
    function Func99: TtkTokenKind;
    function Func100: TtkTokenKind;
    function Func101: TtkTokenKind;
    function Func102: TtkTokenKind;
    function Func103: TtkTokenKind;
    function Func104: TtkTokenKind;
    function Func106: TtkTokenKind;
    function Func108: TtkTokenKind;
    function Func110: TtkTokenKind;
    function Func111: TtkTokenKind;
    function Func113: TtkTokenKind;
    function Func116: TtkTokenKind;
    function Func117: TtkTokenKind;
    function Func120: TtkTokenKind;
    function Func121: TtkTokenKind;
    function Func122: TtkTokenKind;
    function Func123: TtkTokenKind;
    function Func124: TtkTokenKind;
    function Func125: TtkTokenKind;
    function Func126: TtkTokenKind;
    function Func127: TtkTokenKind;
    function Func128: TtkTokenKind;
    function Func129: TtkTokenKind;
    function Func131: TtkTokenKind;
    function Func132: TtkTokenKind;
    function Func134: TtkTokenKind;
    function Func135: TtkTokenKind;
    function Func136: TtkTokenKind;
    function Func137: TtkTokenKind;
    function Func138: TtkTokenKind;
    function Func139: TtkTokenKind;
    function Func140: TtkTokenKind;
    function Func141: TtkTokenKind;
    function Func142: TtkTokenKind;
    function Func144: TtkTokenKind;
    function Func146: TtkTokenKind;
    function Func148: TtkTokenKind;
    function Func150: TtkTokenKind;
    function Func152: TtkTokenKind;
    function Func153: TtkTokenKind;
    function Func154: TtkTokenKind;
    function Func155: TtkTokenKind;
    function Func156: TtkTokenKind;
    function Func157: TtkTokenKind;
    function Func163: TtkTokenKind;
    function Func164: TtkTokenKind;
    function Func166: TtkTokenKind;
    function Func169: TtkTokenKind;
    function Func173: TtkTokenKind;
    function Func174: TtkTokenKind;
    function Func175: TtkTokenKind;
    function Func176: TtkTokenKind;
    function Func178: TtkTokenKind;
    function Func179: TtkTokenKind;
    function Func182: TtkTokenKind;
    function Func183: TtkTokenKind;
    function Func184: TtkTokenKind;
    function Func185: TtkTokenKind;
    function Func187: TtkTokenKind;
    function Func188: TtkTokenKind;
    function Func203: TtkTokenKind;
    function Func206: TtkTokenKind;
    function Func216: TtkTokenKind;
    function Func219: TtkTokenKind;
    function Func221: TtkTokenKind;
    function Func232: TtkTokenKind;
    function Func234: TtkTokenKind;
    function Func235: TtkTokenKind;
    function Func243: TtkTokenKind;
    function Func244: TtkTokenKind;
    function Func255: TtkTokenKind;
    function Func313: TtkTokenKind;
    function Func327: TtkTokenKind;
    function AltFunc: TtkTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PChar): TtkTokenKind;
    procedure MakeMethodTables;
    procedure SymbolProc;
    procedure AddressOpProc;
    procedure AsciiCharProc;
    procedure CRProc;
    procedure GreaterProc;
    procedure IdentProc;
    procedure LFProc;
    procedure LowerProc;
    procedure NullProc;
    procedure NumberProc;
    procedure PointProc;
    procedure SpaceProc;
    procedure StringProc;
    procedure UnknownProc;
    procedure RemProc;
    function IsQuali: boolean;
    function IsSpecial: Boolean;
  protected
    function GetIdentChars: TIdentChars; override;
    function GetLanguageName: string; override;
    function GetCapability: THighlighterCapability; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExportNext;override;
    procedure SetLineForExport(NewValue: String);override;
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
  published
    property FormAttri: TmwHighLightAttributes read fFormAttri write fFormAttri;
    property BlockAttri: TmwHighLightAttributes read fBlockAttri
                                                write fBlockAttri;
    property KeyAttri: TmwHighLightAttributes read fKeyAttri write fKeyAttri;
    property QualiAttri: TmwHighLightAttributes read fQualiAttri
                                                write fQualiAttri;
    property CommentAttri: TmwHighLightAttributes read fCommentAttri
                                                  write fCommentAttri;
    property FunctionAttri: TmwHighLightAttributes read fFunctionAttri
                                                   write fFunctionAttri;
    property VariableAttri: TmwHighLightAttributes read fVariableAttri
                                                   write fVariableAttri;
    property SpecialAttri: TmwHighLightAttributes read fSpecialAttri
                                                  write fSpecialAttri;
    property IdentifierAttri: TmwHighLightAttributes read fIdentifierAttri
                                                     write fIdentifierAttri;
    property NumberAttri: TmwHighLightAttributes read fNumberAttri
                                                 write fNumberAttri;
    property SpaceAttri: TmwHighLightAttributes read fSpaceAttri
                                                write fSpaceAttri;
    property StringAttri: TmwHighLightAttributes read fStringAttri
                                                 write fStringAttri;
    property SymbolAttri: TmwHighLightAttributes read fSymbolAttri
                                                 write fSymbolAttri;
  end;

procedure Register;

implementation

var
  Identifiers: array[#0..#255] of ByteBool;
  mHashTable: array[#0..#255] of Integer;

procedure Register;
begin
  RegisterComponents(MWS_HighlightersPage, [TmwDmlSyn]);
end;

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
    Case I of
      'a'..'z', 'A'..'Z', '_': mHashTable[I] := Ord(J) - 64;
    else mHashTable[Char(I)] := 0;
    end;
  end;
end;

procedure TmwDmlSyn.InitIdent;
var
  I: Integer;
  pF: PIdentFuncTableFunc;
begin
  pF := PIdentFuncTableFunc(@fIdentFuncTable);
  for I := Low(fIdentFuncTable) to High(fIdentFuncTable) do begin
    pF^ := AltFunc;
    Inc(pF);
  end;
  fIdentFuncTable[9] := Func9;
  fIdentFuncTable[15] := Func15;
  fIdentFuncTable[17] := Func17;
  fIdentFuncTable[19] := Func19;
  fIdentFuncTable[22] := Func22;
  fIdentFuncTable[23] := Func23;
  fIdentFuncTable[24] := Func24;
  fIdentFuncTable[26] := Func26;
  fIdentFuncTable[27] := Func27;
  fIdentFuncTable[28] := Func28;
  fIdentFuncTable[29] := Func29;
  fIdentFuncTable[30] := Func30;
  fIdentFuncTable[31] := Func31;
  fIdentFuncTable[32] := Func32;
  fIdentFuncTable[33] := Func33;
  fIdentFuncTable[34] := Func34;
  fIdentFuncTable[35] := Func35;
  fIdentFuncTable[36] := Func36;
  fIdentFuncTable[37] := Func37;
  fIdentFuncTable[38] := Func38;
  fIdentFuncTable[40] := Func40;
  fIdentFuncTable[41] := Func41;
  fIdentFuncTable[42] := Func42;
  fIdentFuncTable[43] := Func43;
  fIdentFuncTable[45] := Func45;
  fIdentFuncTable[47] := Func47;
  fIdentFuncTable[48] := Func48;
  fIdentFuncTable[49] := Func49;
  fIdentFuncTable[50] := Func50;
  fIdentFuncTable[51] := Func51;
  fIdentFuncTable[52] := Func52;
  fIdentFuncTable[53] := Func53;
  fIdentFuncTable[54] := Func54;
  fIdentFuncTable[56] := Func56;
  fIdentFuncTable[57] := Func57;
  fIdentFuncTable[58] := Func58;
  fIdentFuncTable[60] := Func60;
  fIdentFuncTable[62] := Func62;
  fIdentFuncTable[64] := Func64;
  fIdentFuncTable[65] := Func65;
  fIdentFuncTable[66] := Func66;
  fIdentFuncTable[67] := Func67;
  fIdentFuncTable[68] := Func68;
  fIdentFuncTable[69] := Func69;
  fIdentFuncTable[70] := Func70;
  fIdentFuncTable[71] := Func71;
  fIdentFuncTable[72] := Func72;
  fIdentFuncTable[73] := Func73;
  fIdentFuncTable[74] := Func74;
  fIdentFuncTable[75] := Func75;
  fIdentFuncTable[76] := Func76;
  fIdentFuncTable[77] := Func77;
  fIdentFuncTable[78] := Func78;
  fIdentFuncTable[79] := Func79;
  fIdentFuncTable[81] := Func81;
  fIdentFuncTable[82] := Func82;
  fIdentFuncTable[83] := Func83;
  fIdentFuncTable[84] := Func84;
  fIdentFuncTable[85] := Func85;
  fIdentFuncTable[86] := Func86;
  fIdentFuncTable[87] := Func87;
  fIdentFuncTable[89] := Func89;
  fIdentFuncTable[91] := Func91;
  fIdentFuncTable[92] := Func92;
  fIdentFuncTable[93] := Func93;
  fIdentFuncTable[94] := Func94;
  fIdentFuncTable[96] := Func96;
  fIdentFuncTable[97] := Func97;
  fIdentFuncTable[98] := Func98;
  fIdentFuncTable[99] := Func99;
  fIdentFuncTable[100] := Func100;
  fIdentFuncTable[101] := Func101;
  fIdentFuncTable[102] := Func102;
  fIdentFuncTable[103] := Func103;
  fIdentFuncTable[104] := Func104;
  fIdentFuncTable[106] := Func106;
  fIdentFuncTable[108] := Func108;
  fIdentFuncTable[110] := Func110;
  fIdentFuncTable[111] := Func111;
  fIdentFuncTable[113] := Func113;
  fIdentFuncTable[116] := Func116;
  fIdentFuncTable[117] := Func117;
  fIdentFuncTable[120] := Func120;
  fIdentFuncTable[121] := Func121;
  fIdentFuncTable[122] := Func122;
  fIdentFuncTable[123] := Func123;
  fIdentFuncTable[124] := Func124;
  fIdentFuncTable[125] := Func125;
  fIdentFuncTable[126] := Func126;
  fIdentFuncTable[127] := Func127;
  fIdentFuncTable[128] := Func128;
  fIdentFuncTable[129] := Func129;
  fIdentFuncTable[131] := Func131;
  fIdentFuncTable[132] := Func132;
  fIdentFuncTable[134] := Func134;
  fIdentFuncTable[135] := Func135;
  fIdentFuncTable[136] := Func136;
  fIdentFuncTable[137] := Func137;
  fIdentFuncTable[138] := Func138;
  fIdentFuncTable[139] := Func139;
  fIdentFuncTable[140] := Func140;
  fIdentFuncTable[141] := Func141;
  fIdentFuncTable[142] := Func142;
  fIdentFuncTable[144] := Func144;
  fIdentFuncTable[146] := Func146;
  fIdentFuncTable[148] := Func148;
  fIdentFuncTable[150] := Func150;
  fIdentFuncTable[152] := Func152;
  fIdentFuncTable[153] := Func153;
  fIdentFuncTable[154] := Func154;
  fIdentFuncTable[155] := Func155;
  fIdentFuncTable[156] := Func156;
  fIdentFuncTable[157] := Func157;
  fIdentFuncTable[163] := Func163;
  fIdentFuncTable[164] := Func164;
  fIdentFuncTable[166] := Func166;
  fIdentFuncTable[169] := Func169;
  fIdentFuncTable[173] := Func173;
  fIdentFuncTable[174] := Func174;
  fIdentFuncTable[175] := Func175;
  fIdentFuncTable[176] := Func176;
  fIdentFuncTable[178] := Func178;
  fIdentFuncTable[179] := Func179;
  fIdentFuncTable[182] := Func182;
  fIdentFuncTable[183] := Func183;
  fIdentFuncTable[184] := Func184;
  fIdentFuncTable[185] := Func185;
  fIdentFuncTable[187] := Func187;
  fIdentFuncTable[188] := Func188;
  fIdentFuncTable[203] := Func203;
  fIdentFuncTable[206] := Func206;
  fIdentFuncTable[216] := Func216;
  fIdentFuncTable[219] := Func219;
  fIdentFuncTable[221] := Func221;
  fIdentFuncTable[232] := Func232;
  fIdentFuncTable[234] := Func234;
  fIdentFuncTable[235] := Func235;
  fIdentFuncTable[243] := Func243;
  fIdentFuncTable[244] := Func244;
  fIdentFuncTable[255] := Func255;
  fIdentFuncTable[313] := Func313;
  fIdentFuncTable[327] := Func327;
end;

function TmwDmlSyn.IsQuali: boolean;
begin
  Result:= False;
  if Run > 0 then
    if fLine[Run-1]= '/' then Result:= True;
end;

function TmwDmlSyn.IsSpecial: boolean;
begin
  Result:= False;
  if Run > 0 then
    if fLine[Run-1]= '%' then Result:= True;
end;

function TmwDmlSyn.KeyHash(ToHash: PChar): Integer;
begin
  Result := 0;
  while ToHash^ in ['a'..'z', 'A'..'Z', '_'] do
  begin
    inc(Result, mHashTable[ToHash^]);
    inc(ToHash);
  end;
  if ToHash^ in ['_', '0'..'9'] then inc(ToHash);
  fStringLen := ToHash - fToIdent;
end; { KeyHash }

function TmwDmlSyn.KeyComp(const aKey: String): Boolean;
var
  I: Integer;
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

function TmwDmlSyn.Func9: TtkTokenKind;
begin
  if KeyComp('Add') then
  begin
    if IsSpecial then Result := tkSpecial
    else begin
      Result := tkKey;
      fRange := rsAdd;
    end;
  end else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func15: TtkTokenKind;
begin
  if KeyComp('If') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func17: TtkTokenKind;
begin
  if KeyComp('Back') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func19: TtkTokenKind;
begin
  if KeyComp('Dcl') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func22: TtkTokenKind;
begin
  if KeyComp('Abs') then Result := tkFunction else Result := tkIdentifier;
end;

function TmwDmlSyn.Func23: TtkTokenKind;
begin
  if KeyComp('In') and (fRange = rsFind) then
  begin
    Result := tkKey;
    fRange:= rsUnKnown;
  end else Result := tkIdentifier;
end;

function TmwDmlSyn.Func24: TtkTokenKind;
begin
  if KeyComp('Cli') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func26: TtkTokenKind;
begin
  if KeyComp('Mid') then Result := tkFunction else Result := tkIdentifier;
end;

function TmwDmlSyn.Func27: TtkTokenKind;
begin
  if KeyComp('Base') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func28: TtkTokenKind;
begin
  if KeyComp('Tag') and IsQuali then Result := tkQualifier else
    if KeyComp('Case') then Result := tkKey else
      if KeyComp('Call') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func29: TtkTokenKind;
begin
  if KeyComp('Chr') then Result := tkFunction else
    if KeyComp('Ceil') then Result := tkFunction else Result := tkIdentifier;
end;

function TmwDmlSyn.Func30: TtkTokenKind;
begin
  if KeyComp('Check') and IsQuali then Result := tkQualifier else
    if KeyComp('Col') then begin
      if IsQuali then Result := tkQualifier else
        if IsSpecial then Result := tkSpecial else Result := tkIdentifier;
    end else
      if KeyComp('Date') then Result := tkFunction else Result := tkIdentifier;
end;

function TmwDmlSyn.Func31: TtkTokenKind;
begin
  if KeyComp('Len') then begin
    if IsQuali then Result := tkQualifier else Result := tkFunction;
  end else
    if KeyComp('Dir') then Result := tkKey else
      if KeyComp('Bell') and IsQuali then Result := tkQualifier else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func32: TtkTokenKind;
begin
  if KeyComp('Mod') then Result := tkFunction else
    if KeyComp('Load') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func33: TtkTokenKind;
begin
  if KeyComp('Find') then
  begin
    Result := tkKey;
    fRange := rsFind;
  end else Result := tkIdentifier;
end;

function TmwDmlSyn.Func34: TtkTokenKind;
begin
  if KeyComp('Log') then begin
    if IsQuali then Result := tkQualifier else Result := tkFunction;
  end else if KeyComp('Batch') and IsQuali then Result := tkQualifier else
    if KeyComp('Log10') then Result := tkFunction else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func35: TtkTokenKind;
begin
  if KeyComp('Tan') then Result := tkFunction else
    if KeyComp('To') and (fRange=rsAdd) then
    begin
      Result := tkKey;
      fRange := rsUnKnown;
    end else
      if KeyComp('Mail') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func36: TtkTokenKind;
begin
  if KeyComp('Atan2') then Result := tkFunction else
    if KeyComp('Atan') then Result := tkFunction else Result := tkIdentifier;
end;

function TmwDmlSyn.Func37: TtkTokenKind;
begin
  if KeyComp('Break') and IsQuali then Result := tkQualifier else
    if KeyComp('Break0') and IsQuali then Result := tkQualifier else
      if KeyComp('Cos') then Result := tkFunction else Result := tkIdentifier;
end;

function TmwDmlSyn.Func38: TtkTokenKind;
begin
  if KeyComp('Acos') then Result := tkFunction else
    if KeyComp('Edit') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func40: TtkTokenKind;
begin
  if KeyComp('Line') then Result := tkKey else
    if KeyComp('Table') and IsQuali then Result := tkQualifier else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func41: TtkTokenKind;
begin
  if KeyComp('Else') then Result := tkKey else
    if KeyComp('Lock') and IsQuali then Result := tkQualifier else
      if KeyComp('Ascii') then Result := tkFunction else Result := tkIdentifier;
end;

function TmwDmlSyn.Func42: TtkTokenKind;
begin
  if KeyComp('Send') then Result := tkKey else
    if KeyComp('Sin') then Result := tkFunction else
      if KeyComp('New') and IsQuali then Result := tkQualifier else
        if KeyComp('Fetch') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func43: TtkTokenKind;
begin
  if KeyComp('Asin') then Result := tkFunction else
    if KeyComp('Int') then Result := tkFunction else
      if KeyComp('Left') then Result := tkFunction else
        if KeyComp('Tanh') then Result := tkFunction else
          Result := tkIdentifier;
end;

function TmwDmlSyn.Func45: TtkTokenKind;
begin
  if KeyComp('Cosh') then Result := tkFunction else Result := tkIdentifier;
end;

function TmwDmlSyn.Func47: TtkTokenKind;
begin
  if KeyComp('Item') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func48: TtkTokenKind;
begin
  if KeyComp('Heading') and IsQuali then Result := tkQualifier else
    if KeyComp('Erase') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func49: TtkTokenKind;
begin
  if KeyComp('Days') then Result := tkFunction else
    if KeyComp('Lov') and IsQuali then Result := tkQualifier else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func50: TtkTokenKind;
begin
  if KeyComp('Pos') and IsQuali then Result := tkQualifier else
    if KeyComp('Sinh') then Result := tkFunction else
      if KeyComp('Open') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func51: TtkTokenKind;
begin
  if KeyComp('Files') then Result := tkKey else
    if KeyComp('Opt') and IsQuali then Result := tkQualifier else
      if KeyComp('Delete') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func52: TtkTokenKind;
begin
  if KeyComp('Form') then begin
    if IsSpecial then Result := tkSpecial else Result := tkForm;
  end else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func53: TtkTokenKind;
begin
  if KeyComp('Wait') and IsQuali then Result := tkQualifier else
    if KeyComp('Menu') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func54: TtkTokenKind;
begin
  if KeyComp('Close') then Result := tkKey else
    if KeyComp('Search') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func56: TtkTokenKind;
begin
  if KeyComp('Domain') and IsQuali then Result := tkQualifier else
    if KeyComp('Row') and IsQuali then Result := tkQualifier else
      if KeyComp('Row') and IsSpecial then Result := tkSpecial else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func57: TtkTokenKind;
begin
  if KeyComp('While') then Result := tkKey else
    if KeyComp('Height') and IsQuali then Result := tkQualifier else
      if KeyComp('Goto') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func58: TtkTokenKind;
begin
  if KeyComp('Exit') and IsQuali then Result := tkQualifier else
    if KeyComp('Exit') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func60: TtkTokenKind;
begin
  if KeyComp('List') then Result := tkKey else
    if KeyComp('With') and IsQuali then Result := tkQualifier else
      if KeyComp('Trim') then Result := tkFunction else
        if KeyComp('Nobell') and IsQuali then Result := tkFunction else
          if KeyComp('Lheading') and IsQuali then Result := tkQualifier else
            if KeyComp('Remain') and IsQuali then Result := tkQualifier else
              Result := tkIdentifier;
end;

function TmwDmlSyn.Func62: TtkTokenKind;
begin
  if KeyComp('Right') then Result := tkFunction else
    if KeyComp('Pause') and IsQuali then Result := tkQualifier else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func64: TtkTokenKind;
begin
  if KeyComp('Width') and IsQuali then Result := tkQualifier else
    if KeyComp('Expand') then Result := tkFunction else Result := tkIdentifier;
end;

function TmwDmlSyn.Func65: TtkTokenKind;
begin
  if KeyComp('Finish') then Result := tkKey else
    if KeyComp('Release') then Result := tkKey else
      if KeyComp('Random') then Result := tkKey else
        if KeyComp('Repeat') then begin
          if IsQuali then Result := tkQualifier else Result := tkKey;
        end else
          Result := tkIdentifier;
end;

function TmwDmlSyn.Func66: TtkTokenKind;
begin
  if KeyComp('Rheading') and IsQuali then Result := tkQualifier else
    if KeyComp('Floor') then Result := tkKey else
      if KeyComp('Title') then begin
        if IsQuali then Result := tkQualifier else Result := tkKey;
      end else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func67: TtkTokenKind;
begin
  if KeyComp('Unload') then Result := tkKey else
    if KeyComp('Receive') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func68: TtkTokenKind;
begin
  if KeyComp('Total') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func69: TtkTokenKind;
begin
  if KeyComp('Message') then Result := tkKey else
    if KeyComp('End_if') then Result := tkKey else
      if KeyComp('Text') then begin
        if IsSpecial then Result := tkSpecial else Result := tkKey;
      end else if KeyComp('End_if') then Result := tkKey else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func70: TtkTokenKind;
begin
  if KeyComp('Using') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func71: TtkTokenKind;
begin
  if KeyComp('Target') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func72: TtkTokenKind;
begin
  if KeyComp('First') and IsQuali then Result := tkQualifier else
    if KeyComp('Failure') then begin
      if IsQuali then Result := tkQualifier else
        if IsSpecial then Result := tkSpecial else Result := tkIdentifier;
    end else
      if KeyComp('Ltrim') then Result := tkFunction else
        if KeyComp('Round') then Result := tkFunction else
          Result := tkIdentifier;
end;

function TmwDmlSyn.Func73: TtkTokenKind;
begin
  if KeyComp('Commit') then Result := tkKey else
    if KeyComp('Compile') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func74: TtkTokenKind;
begin
  if KeyComp('Sqrt') then Result := tkFunction else
    if KeyComp('Error') then begin
      if IsQuali then Result := tkQualifier else Result := tkKey;
    end else
      if KeyComp('Rollback') then Result := tkKey else
        if KeyComp('Connect') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func75: TtkTokenKind;
begin
  if KeyComp('Generate') then Result := tkKey else
    if KeyComp('Write') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func76: TtkTokenKind;
begin
  if KeyComp('Invoke') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func77: TtkTokenKind;
begin
  if KeyComp('Noerase') and IsQuali then Result := tkQualifier else
   if KeyComp('Noheading') and IsQuali then Result := tkQualifier else
    if KeyComp('Account') and IsSpecial then Result := tkSpecial else
      if KeyComp('Print') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func78: TtkTokenKind;
begin
  if KeyComp('Confirm') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func79: TtkTokenKind;
begin
  if KeyComp('Seconds') then Result := tkFunction else Result := tkIdentifier;
end;

function TmwDmlSyn.Func81: TtkTokenKind;
begin
  if KeyComp('Source') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func82: TtkTokenKind;
begin
  if KeyComp('End_case') then Result := tkKey else
    if KeyComp('Switch') and IsQuali then Result := tkQualifier else
      if KeyComp('Nowait') and IsQuali then Result := tkQualifier else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func83: TtkTokenKind;
begin
  if KeyComp('Execute') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func84: TtkTokenKind;
begin
  if KeyComp('Trigger') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func85: TtkTokenKind;
begin
  if KeyComp('Facility') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func86: TtkTokenKind;
begin
  if KeyComp('Footing') and IsQuali then Result := tkQualifier else
    if KeyComp('Query') then Result := tkKey else
      if KeyComp('Display') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func87: TtkTokenKind;
begin
  if KeyComp('String') then Result := tkFunction else
    if KeyComp('Else_if') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func89: TtkTokenKind;
begin
  if KeyComp('Sequence') and IsQuali then Result := tkQualifier else
    if KeyComp('Success') then begin
      if IsQuali then Result := tkQualifier else
        if IsSpecial then Result := tkSpecial else Result := tkIdentifier;
    end else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func91: TtkTokenKind;
begin
  if KeyComp('Perform') then Result := tkKey else
    if KeyComp('Use_if') and IsQuali then Result := tkQualifier else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func92: TtkTokenKind;
begin
  if KeyComp('Report') then Result := tkKey else
    if KeyComp('Add_form') and IsQuali then Result := tkQualifier else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func93: TtkTokenKind;
begin
  if KeyComp('Item_if') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func94: TtkTokenKind;
begin
  if KeyComp('Norepeat') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func96: TtkTokenKind;
begin
  if KeyComp('Begin_case') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func97: TtkTokenKind;
begin
  if KeyComp('Protect') and IsQuali then Result := tkQualifier else
    if KeyComp('End_block') then Result := tkBlock else Result := tkIdentifier;
end;

function TmwDmlSyn.Func98: TtkTokenKind;
begin
  if KeyComp('Lfooting') and IsQuali then Result := tkQualifier else
    if KeyComp('Prompt') and IsQuali then Result := tkQualifier else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func99: TtkTokenKind;
begin
  if KeyComp('Identifier') and IsQuali then Result := tkQualifier else
    if KeyComp('Send_data') then Result := tkKey else
      if KeyComp('Read_line') then Result := tkKey else
        if KeyComp('External') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func100: TtkTokenKind;
begin
  if KeyComp('Status') then begin
    if IsQuali then Result := tkQualifier else
      if IsSpecial then Result := tkSpecial else Result := tkIdentifier;
  end else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func101: TtkTokenKind;
begin
  if KeyComp('Continue') and IsQuali then Result := tkQualifier else
    if KeyComp('System') and IsQuali then Result := tkQualifier else
      if KeyComp('Transfer') then Result := tkKey else
        if KeyComp('Lowercase') then Result := tkFunction else
          Result := tkIdentifier;
end;

function TmwDmlSyn.Func102: TtkTokenKind;
begin
  if KeyComp('Selection') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func103: TtkTokenKind;
begin
  if KeyComp('Noerror') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func104: TtkTokenKind;
begin
  if KeyComp('Secondary') and IsQuali then Result := tkQualifier else
    if KeyComp('Uppercase') then Result := tkFunction else
      if KeyComp('Rfooting') then Result := tkQualifier else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func106: TtkTokenKind;
begin
  if KeyComp('End_form') then Result := tkForm else
    if KeyComp('Lov_data') and IsQuali then Result := tkQualifier else
      if KeyComp('Disconnect') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func108: TtkTokenKind;
begin
  if KeyComp('Options') and IsQuali then Result := tkQualifier else
    if KeyComp('Compress') then Result := tkFunction else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func110: TtkTokenKind;
begin
  if KeyComp('End_row') and IsQuali then Result := tkQualifier else
    if KeyComp('Lov_col') and IsQuali then Result := tkQualifier else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func111: TtkTokenKind;
begin
  if KeyComp('End_while') then Result := tkKey else
    if KeyComp('Begin_block') then Result := tkBlock else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func113: TtkTokenKind;
begin
  if KeyComp('Send_table') then Result := tkKey else
    if KeyComp('Output') and IsQuali then Result := tkQualifier else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func116: TtkTokenKind;
begin
  if KeyComp('Find_form') and IsQuali then Result := tkQualifier else
    if KeyComp('Nototals') and IsSpecial then Result := tkSpecial else
      if KeyComp('No_domain') and IsQuali then Result := tkQualifier else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func117: TtkTokenKind;
begin
  if KeyComp('Check_domain') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func120: TtkTokenKind;
begin
  if KeyComp('Statistic') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func121: TtkTokenKind;
begin
  if KeyComp('Item_block') then Result := tkBlock else Result := tkIdentifier;
end;

function TmwDmlSyn.Func122: TtkTokenKind;
begin
  if KeyComp('Top_line') and IsSpecial then Result := tkSpecial else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func123: TtkTokenKind;
begin
  if KeyComp('Severity') and IsQuali then Result := tkQualifier else
    if KeyComp('Joined_to') and IsQuali then Result := tkQualifier else
      if KeyComp('Table_form') then Result := tkForm else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func124: TtkTokenKind;
begin
  if KeyComp('Begin_row') and IsQuali then Result := tkQualifier else
    if KeyComp('Utilities') then Result := tkKey else
      if KeyComp('Receive_data') then Result := tkKey else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func125: TtkTokenKind;
begin
  if KeyComp('Read_only') and IsQuali then Result := tkQualifier else
    if KeyComp('Table_search') then Result := tkKey else
      if KeyComp('Tag_length') and IsQuali then Result := tkQualifier else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func126: TtkTokenKind;
begin
  if KeyComp('Reduced_to') and IsQuali then Result := tkQualifier else
    if KeyComp('Actual_break') and IsSpecial then Result := tkSpecial else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func127: TtkTokenKind;
begin
  if KeyComp('Source_if') and IsQuali then Result := tkQualifier else
    if KeyComp('Menu_block') then Result := tkBlock else Result := tkIdentifier;
end;

function TmwDmlSyn.Func128: TtkTokenKind;
begin
  if KeyComp('Clear_buffer') then Result := tkKey else
    if KeyComp('Default_tag') and IsQuali then Result := tkQualifier else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func129: TtkTokenKind;
begin
  if KeyComp('Nostatus') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func131: TtkTokenKind;
begin
  if KeyComp('Heading_form') then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func132: TtkTokenKind;
begin
  if KeyComp('Description') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func134: TtkTokenKind;
begin
  if KeyComp('Delete_form') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func135: TtkTokenKind;
begin
  if KeyComp('Nolov_data') and IsQuali then Result := tkQualifier else
    if KeyComp('Attributes') and IsQuali then Result := tkQualifier else
      if KeyComp('User_key') and IsQuali then Result := tkQualifier else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func136: TtkTokenKind;
begin
  if KeyComp('Menu_form') then Result := tkForm else
    if KeyComp('Pause_block') then Result := tkBlock else
      if KeyComp('Lov_row') and IsQuali then Result := tkQualifier else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func137: TtkTokenKind;
begin
  if KeyComp('Lov_height') and IsQuali then Result := tkQualifier else
    if KeyComp('End_execute') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func138: TtkTokenKind;
begin
  if KeyComp('Receive_table') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func139: TtkTokenKind;
begin
  if KeyComp('Sorted_by') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func140: TtkTokenKind;
begin
  if KeyComp('Date_seconds') then Result := tkFunction else
    if KeyComp('Reposition') then Result := tkKey else
      if KeyComp('Switch_base') and IsQuali then Result := tkQualifier else
        if KeyComp('Lines_after') and IsQuali then Result := tkQualifier else
          if KeyComp('Lov_with') and IsQuali then Result := tkQualifier else
            if KeyComp('Lines_after') and IsSpecial then Result := tkSpecial
              else if KeyComp('Stream_name') and IsQuali then
                Result := tkQualifier
              else Result := tkIdentifier;
end;

function TmwDmlSyn.Func141: TtkTokenKind;
begin
  if KeyComp('Lines_before') and IsQuali then Result := tkQualifier else
    if KeyComp('Lines_after') and IsSpecial then Result := tkSpecial else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func142: TtkTokenKind;
begin
  if KeyComp('Send_message') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func144: TtkTokenKind;
begin
  if KeyComp('Grouped_by') and IsQuali then Result := tkQualifier else
    if KeyComp('Lov_width') and IsQuali then Result := tkQualifier else
      if KeyComp('Row_height') and IsQuali then Result := tkQualifier else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func146: TtkTokenKind;
begin
  if KeyComp('Write_line') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func148: TtkTokenKind;
begin
  if KeyComp('Commit_rate') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func150: TtkTokenKind;
begin
  if KeyComp('Open_text') then Result := tkKey else
    if KeyComp('Nounderlines') then begin
      if IsQuali then Result := tkQualifier else
        if IsSpecial then Result := tkSpecial else Result := tkIdentifier;
    end else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func152: TtkTokenKind;
begin
  if KeyComp('Lov_first') and IsQuali then Result := tkQualifier else
    if KeyComp('Yesno_block') then Result := tkBlock else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func153: TtkTokenKind;
begin
  if KeyComp('Tsuppress') and IsSpecial then Result := tkSpecial else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func154: TtkTokenKind;
begin
  if KeyComp('Documentation') then Result := tkKey else
    if KeyComp('Input_block') then Result := tkBlock else
      if KeyComp('Close_text') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func155: TtkTokenKind;
begin
  if KeyComp('Modify_form') and IsQuali then Result := tkQualifier else
    if KeyComp('Input_mask') and IsQuali then Result := tkQualifier else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func156: TtkTokenKind;
begin
  if KeyComp('Bottom_line') and IsSpecial then Result := tkSpecial else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func157: TtkTokenKind;
begin
  if KeyComp('Lov_noheading') and IsQuali then Result := tkQualifier else
    if KeyComp('Noclear_buffer') and IsQuali then Result := tkQualifier else
      if KeyComp('Day_of_week') then Result := tkFunction else
        Result := tkIdentifier;
end;

function TmwDmlSyn.Func163: TtkTokenKind;
begin
  if KeyComp('Lov_nosearch') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func164: TtkTokenKind;
begin
  if KeyComp('Compress_all') then Result := tkFunction else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func166: TtkTokenKind;
begin
  if KeyComp('Text_only') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func169: TtkTokenKind;
begin
  if KeyComp('Query_form') then Result := tkForm else
    if KeyComp('Footing_form') and IsQuali then Result := tkQualifier else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func173: TtkTokenKind;
begin
  if KeyComp('Nodeadlock_exit') and IsQuali then Result := tkQualifier else
    if KeyComp('Rewind_text') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func174: TtkTokenKind;
begin
  if KeyComp('Exit_forward') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func175: TtkTokenKind;
begin
  if KeyComp('Report_form') then Result := tkForm else Result := tkIdentifier;
end;

function TmwDmlSyn.Func176: TtkTokenKind;
begin
  if KeyComp('Column_headings') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func178: TtkTokenKind;
begin
  if KeyComp('Column_spacing') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func179: TtkTokenKind;
begin
  if KeyComp('Alternate_form') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func182: TtkTokenKind;
begin
  if KeyComp('Lov_selection') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func183: TtkTokenKind;
begin
  if KeyComp('Display_length') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func184: TtkTokenKind;
begin
  if KeyComp('Lov_secondary') and IsQuali then Result := tkQualifier else
    if KeyComp('Cross_reference') then Result := tkKey else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func185: TtkTokenKind;
begin
  if KeyComp('Start_stream') then Result := tkKey else Result := tkIdentifier;
end;

function TmwDmlSyn.Func187: TtkTokenKind;
begin
  if KeyComp('Output_block') then Result := tkBlock else Result := tkIdentifier;
end;

function TmwDmlSyn.Func188: TtkTokenKind;
begin
  if KeyComp('Output_mask') and IsQuali then Result := tkQualifier else
    if KeyComp('Procedure_form') then Result := tkForm else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func203: TtkTokenKind;
begin
  if KeyComp('Noexit_forward') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func206: TtkTokenKind;
begin
  if KeyComp('Lov_reduced_to') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func216: TtkTokenKind;
begin
  if KeyComp('Receive_arguments') then Result := tkKey else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func219: TtkTokenKind;
begin
  if KeyComp('Lov_sorted_by') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func221: TtkTokenKind;
begin
  if KeyComp('End_disable_trigger') then Result := tkKey else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func232: TtkTokenKind;
begin
  if KeyComp('Lov_auto_select') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func234: TtkTokenKind;
begin
  if KeyComp('Binary_to_poly') then Result := tkFunction else
    if KeyComp('Poly_to_binary') then Result := tkFunction else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func235: TtkTokenKind;
begin
  if KeyComp('Begin_disable_trigger') then Result := tkKey else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func243: TtkTokenKind;
begin
  if KeyComp('Start_transaction') then Result := tkKey else
    if KeyComp('Absolute_position') and IsQuali then Result := tkQualifier else
      Result := tkIdentifier;
end;

function TmwDmlSyn.Func244: TtkTokenKind;
begin
  if KeyComp('Column_heading_row') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func255: TtkTokenKind;
begin
  if KeyComp('Input_row_height') and IsQuali then Result := tkQualifier else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func313: TtkTokenKind;
begin
  if KeyComp('End_signal_to_status') then Result := tkKey else
    Result := tkIdentifier;
end;

function TmwDmlSyn.Func327: TtkTokenKind;
begin
  if KeyComp('Begin_signal_to_status') then Result := tkKey else
    Result := tkIdentifier;
end;

function TmwDmlSyn.AltFunc: TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TmwDmlSyn.IdentKind(MayBe: PChar): TtkTokenKind;
var
  HashKey: Integer;
begin
  fToIdent := MayBe;
  HashKey := KeyHash(MayBe);
  if HashKey < 328 then Result := fIdentFuncTable[HashKey] else
    Result := tkIdentifier;
end;

procedure TmwDmlSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      #0: fProcTable[I] := NullProc;
      #10: fProcTable[I] := LFProc;
      #13: fProcTable[I] := CRProc;
      #1..#9, #11, #12, #14..#32:
        fProcTable[I] := SpaceProc;
      '#': fProcTable[I] := AsciiCharProc;
      '"': fProcTable[I] := StringProc;
      '0'..'9': fProcTable[I] := NumberProc;
      'A'..'Z', 'a'..'z', '_':
        fProcTable[I] := IdentProc;
      '{': fProcTable[I] := SymbolProc;
      '}': fProcTable[I] := SymbolProc;
      '!': fProcTable[I] := RemProc;
      '.': fProcTable[I] := PointProc;
      '<': fProcTable[I] := LowerProc;
      '>': fProcTable[I] := GreaterProc;
      '@': fProcTable[I] := AddressOpProc;
      #39, '&', '('..'-', '/', ':', ';', '=', '?', '['..'^', '`', '~':
        fProcTable[I] := SymbolProc;
    else fProcTable[I] := UnknownProc;
    end;
end;

constructor TmwDmlSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fFormAttri:= TmwHighLightAttributes.Create(MWS_AttrForm);
  fFormAttri.Style:= [fsBold];
  fFormAttri.Foreground:= clBlue;
  AddAttribute(fFormAttri);
  fBlockAttri:= TmwHighLightAttributes.Create(MWS_AttrBlock);
  fBlockAttri.Style:= [fsBold];
  fBlockAttri.Foreground:= clGreen;
  AddAttribute(fBlockAttri);
  fKeyAttri := TmwHighLightAttributes.Create(MWS_AttrKey);
  fKeyAttri.Style:= [fsBold];
  AddAttribute(fKeyAttri);
  fCommentAttri := TmwHighLightAttributes.Create(MWS_AttrComment);
  fCommentAttri.Style:= [fsBold];
  fCommentAttri.Foreground:= clRed;
  AddAttribute(fCommentAttri);
  fQualiAttri:= TmwHighLightAttributes.Create(MWS_AttrQualifier);
  fQualiAttri.Style:= [fsItalic];
  fQualiAttri.Foreground:= clGreen;
  AddAttribute(fQualiAttri);
  fFunctionAttri:= TmwHighLightAttributes.Create(MWS_AttrFunction);
  fFunctionAttri.Style:= [fsItalic];
  fFunctionAttri.Foreground:= clBlack;
  AddAttribute(fFunctionAttri);
  fVariableAttri:= TmwHighLightAttributes.Create(MWS_AttrVariable);
  fVariableAttri.Style:= [fsBold, fsItalic];
  fVariableAttri.Foreground:= clBlack;
  AddAttribute(fVariableAttri);
  fSpecialAttri:= TmwHighLightAttributes.Create(MWS_AttrSpecialVariable);
  fSpecialAttri.Style:= [fsItalic];
  fSpecialAttri.Foreground:= clBlack;
  AddAttribute(fSpecialAttri);
  fIdentifierAttri := TmwHighLightAttributes.Create(MWS_AttrIdentifier);
  AddAttribute(fIdentifierAttri);
  fNumberAttri := TmwHighLightAttributes.Create(MWS_AttrNumber);
  AddAttribute(fNumberAttri);
  fSpaceAttri := TmwHighLightAttributes.Create(MWS_AttrSpace);
  AddAttribute(fSpaceAttri);
  fStringAttri := TmwHighLightAttributes.Create(MWS_AttrString);
  AddAttribute(fStringAttri);
  fSymbolAttri := TmwHighLightAttributes.Create(MWS_AttrSymbol);
  AddAttribute(fSymbolAttri);
  SetAttributesOnChange(DefHighlightChange);

  InitIdent;
  MakeMethodTables;
  fRange := rsUnknown;

  fDefaultFilter := MWS_FilterGembase;
end;

procedure TmwDmlSyn.SetLine(NewValue: String; LineNumber:Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end;

procedure TmwDmlSyn.AddressOpProc;
begin
  fTokenID := tkSymbol;
  Inc(Run);
  if fLine[Run] = '@' then Inc(Run);
end;

procedure TmwDmlSyn.AsciiCharProc;
begin
  // variables...
  fTokenID := tkVariable;
  repeat
    inc(Run);
  until not (FLine[Run] in ['_', '0'..'9', 'a'..'z', 'A'..'Z']);
end;

procedure TmwDmlSyn.SymbolProc;
begin
  inc(Run);
  fTokenId := tkSymbol;
end;

procedure TmwDmlSyn.CRProc;
begin
  fTokenID := tkSpace;
  inc(Run);
  if FLine[Run] = #10 then inc(Run);
end;

procedure TmwDmlSyn.GreaterProc;
begin
  fTokenID := tkSymbol;
  Inc(Run);
  if FLine[Run] = '=' then Inc(Run);
end;

procedure TmwDmlSyn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
end;

procedure TmwDmlSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TmwDmlSyn.LowerProc;
begin
  fTokenID := tkSymbol;
  inc(Run);
  if (fLine[Run]= '=') or (fLine[Run]= '>') then Inc(Run);
end;

procedure TmwDmlSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TmwDmlSyn.NumberProc;
begin
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in ['0'..'9', '.'] do
  begin
    case FLine[Run] of
      '.':
        if FLine[Run + 1] = '.' then break;
    end;
    inc(Run);
  end;
end;

procedure TmwDmlSyn.PointProc;
begin
  fTokenID := tkSymbol;
  inc(Run);
  if (fLine[Run]='.') or (fLine[Run]=')') then inc(Run);
end;

procedure TmwDmlSyn.RemProc;
var
  p: PChar;
begin
  p := PChar(@fLine[Run - 1]);
  while p >= fLine do begin
    if not (p^ in [#9, #32]) then begin
      inc(Run);
      fTokenID := tkSymbol;
      exit;
    end;
    Dec(p);
  end;
  // it is a comment...
  fTokenID := tkComment;
  p := PChar(@fLine[Run]);
  repeat
    Inc(p);
  until p^ in [#0, #10, #13];
  Run := p - fLine;
end;

procedure TmwDmlSyn.SpaceProc;
var p: PChar;
begin
  fTokenID := tkSpace;
  p := PChar(@fLine[Run]);
  repeat
    Inc(p);
  until (p^ > #32) or (p^ in [#0, #10, #13]);
  Run := p - fLine;
end;

procedure TmwDmlSyn.StringProc;
begin
  fTokenID := tkString;
  if (FLine[Run + 1] = '"') and (FLine[Run + 2] = '"') then inc(Run, 2);
  repeat
    inc(Run);
  until (FLine[Run] in ['"', #0, #10, #13]);

  if FLine[Run] <> #0 then inc(Run);
end;

procedure TmwDmlSyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TmwDmlSyn.Next;
begin
  fTokenPos := Run;
  fProcTable[fLine[Run]];
end;

function TmwDmlSyn.GetEol: Boolean;
begin
  Result := fTokenID = tkNull;
end;

function TmwDmlSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TmwDmlSyn.GetTokenID: TtkTokenKind;
begin
  Result:= fTokenId;
end;

function TmwDmlSyn.GetTokenAttribute: TmwHighLightAttributes;
begin
  case GetTokenID of
    tkForm: Result := fFormAttri;
    tkBlock: Result := fBlockAttri;
    tkKey: Result := fKeyAttri;
    tkComment: Result := fCommentAttri;
    tkQualifier: Result := fQualiAttri;
    tkFunction: Result := fFunctionAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkNumber: Result := fNumberAttri;
    tkSpecial: Result := fSpecialAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
    tkVariable: Result := fVariableAttri;
    tkSymbol: Result := fSymbolAttri;
    tkUnknown: Result := fSymbolAttri;
    else Result := nil;
  end;
end;

function TmwDmlSyn.GetTokenKind: integer;
begin
  Result := Ord(GetTokenID);
end;

function TmwDmlSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

function TmwDmlSyn.GetRange: Pointer;
begin
 Result := Pointer(fRange);
end;

procedure TmwDmlSyn.SetRange(Value: Pointer);
begin
 fRange := TRangeState(Value);
end;

procedure TmwDmlSyn.ReSetRange;
begin
  fRange:= rsUnknown;
end;

function TmwDmlSyn.GetLanguageName: string;
begin
  Result := MWS_LangGembase;
end;

function TmwDmlSyn.GetIdentChars: TIdentChars;
begin
  Result := ['_', '0'..'9', 'a'..'z', 'A'..'Z'];
end;

function TmwDmlSyn.GetCapability: THighlighterCapability;
begin
  Result := inherited GetCapability + [hcUserSettings];
end;

procedure TmwDmlSyn.SetLineForExport(NewValue: String);
begin
  fLine := PChar(NewValue);
  Run := 0;
  ExportNext;
end;

procedure TmwDmlSyn.ExportNext;
begin
  fTokenPos := Run;
  fProcTable[fLine[Run]];

  if Assigned(Exporter) then
    with TmwCustomExport(Exporter) do begin
      Case GetTokenID of
        tkBlock: FormatToken(GetToken, fBlockAttri, False, False);
        tkComment: FormatToken(GetToken, fCommentAttri, True, False);
        tkForm: FormatToken(GetToken, fFormAttri, False,False);
        tkKey: FormatToken(GetToken, fKeyAttri, False,False);
        tkQualifier: FormatToken(GetToken, fQualiAttri, False,False);
        tkFunction: FormatToken(GetToken, fFunctionAttri, False,False);
        tkVariable: FormatToken(GetToken, fVariableAttri, False,False);
        tkString: FormatToken(GetToken, fStringAttri, True,False);
        tkIdentifier: FormatToken(GetToken, fIdentifierAttri, False,False);
        tkNumber: FormatToken(GetToken, fNumberAttri, False,False);
        tkSpecial: FormatToken(GetToken, fSpecialAttri, False,False);
        tkSpace: FormatToken(GetToken, fSpaceAttri, False,True);
        tkSymbol: FormatToken(GetToken, fSymbolAttri, False,False);
      end;
    end; //with
end;

initialization
  MakeIdentTable;
end.

