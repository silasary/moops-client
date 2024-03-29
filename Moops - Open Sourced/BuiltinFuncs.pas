unit BuiltinFuncs;

{$I mwEdit.inc}

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Graphics, Registry,
  mwHighlighter, mwExport, mwLocalStr;

Type
  TmoTokenKind = (
    moBuiltinFunc);

  TRangeState = (rsUnknown);

  TProcTableProc = procedure of Object;

  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function: TmoTokenKind of Object;

type
  TmwMOOSyntax = class(TmwCustomHighLighter)
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
    fIdentFuncTable: array[0..126] of TIdentFuncTableFunc;
    fBuiltinFuncAttri: TmwHighLightAttributes;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: String): Boolean;
    function Func0: TmoTokenKind;
    function Func1: TmoTokenKind;
    function Func2: TmoTokenKind;
    function Func6: TmoTokenKind;
    function Func8: TmoTokenKind;
    function Func10: TmoTokenKind;
    function Func12: TmoTokenKind;
    function Func13: TmoTokenKind;
    function Func16: TmoTokenKind;
    function Func17: TmoTokenKind;
    function Func18: TmoTokenKind;
    function Func22: TmoTokenKind;
    function Func24: TmoTokenKind;
    function Func25: TmoTokenKind;
    function Func26: TmoTokenKind;
    function Func27: TmoTokenKind;
    function Func28: TmoTokenKind;
    function Func29: TmoTokenKind;
    function Func30: TmoTokenKind;
    function Func32: TmoTokenKind;
    function Func33: TmoTokenKind;
    function Func34: TmoTokenKind;
    function Func35: TmoTokenKind;
    function Func36: TmoTokenKind;
    function Func37: TmoTokenKind;
    function Func38: TmoTokenKind;
    function Func40: TmoTokenKind;
    function Func42: TmoTokenKind;
    function Func43: TmoTokenKind;
    function Func45: TmoTokenKind;
    function Func46: TmoTokenKind;
    function Func47: TmoTokenKind;
    function Func48: TmoTokenKind;
    function Func49: TmoTokenKind;
    function Func50: TmoTokenKind;
    function Func51: TmoTokenKind;
    function Func52: TmoTokenKind;
    function Func53: TmoTokenKind;
    function Func55: TmoTokenKind;
    function Func56: TmoTokenKind;
    function Func60: TmoTokenKind;
    function Func62: TmoTokenKind;
    function Func63: TmoTokenKind;
    function Func64: TmoTokenKind;
    function Func65: TmoTokenKind;
    function Func66: TmoTokenKind;
    function Func69: TmoTokenKind;
    function Func70: TmoTokenKind;
    function Func71: TmoTokenKind;
    function Func73: TmoTokenKind;
    function Func74: TmoTokenKind;
    function Func75: TmoTokenKind;
    function Func76: TmoTokenKind;
    function Func78: TmoTokenKind;
    function Func79: TmoTokenKind;
    function Func80: TmoTokenKind;
    function Func81: TmoTokenKind;
    function Func82: TmoTokenKind;
    function Func83: TmoTokenKind;
    function Func85: TmoTokenKind;
    function Func87: TmoTokenKind;
    function Func89: TmoTokenKind;
    function Func92: TmoTokenKind;
    function Func94: TmoTokenKind;
    function Func95: TmoTokenKind;
    function Func96: TmoTokenKind;
    function Func98: TmoTokenKind;
    function Func99: TmoTokenKind;
    function Func100: TmoTokenKind;
    function Func104: TmoTokenKind;
    function Func105: TmoTokenKind;
    function Func108: TmoTokenKind;
    function Func111: TmoTokenKind;
    function Func112: TmoTokenKind;
    function Func114: TmoTokenKind;
    function Func115: TmoTokenKind;
    function Func116: TmoTokenKind;
    function Func121: TmoTokenKind;
    function Func122: TmoTokenKind;
    function Func123: TmoTokenKind;
    function Func124: TmoTokenKind;
    function Func126: TmoTokenKind;
    procedure UnknownProc;
    function AltFunc: TmoTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PChar): TmoTokenKind;
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
    property BuiltinFuncAttri: TmwHighLightAttributes read fBuiltinFuncAttri write fBuiltinFuncAttri;
    property Exporter:TmwCustomExport read FExporter write FExporter;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents(MWS_HighlightersPage, [TmwMOOSyntax]);
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

procedure TmwMOOSyntax.InitIdent;
var
  I: Integer;
  pF: PIdentFuncTableFunc;
begin
  pF := PIdentFuncTableFunc(@fIdentFuncTable);
  for I := Low(fIdentFuncTable) to High(fIdentFuncTable) do begin
    pF^ := AltFunc;
    Inc(pF);
  end;
  fIdentFuncTable[0] := Func0;
  fIdentFuncTable[1] := Func1;
  fIdentFuncTable[2] := Func2;
  fIdentFuncTable[6] := Func6;
  fIdentFuncTable[8] := Func8;
  fIdentFuncTable[10] := Func10;
  fIdentFuncTable[12] := Func12;
  fIdentFuncTable[13] := Func13;
  fIdentFuncTable[16] := Func16;
  fIdentFuncTable[17] := Func17;
  fIdentFuncTable[18] := Func18;
  fIdentFuncTable[22] := Func22;
  fIdentFuncTable[24] := Func24;
  fIdentFuncTable[25] := Func25;
  fIdentFuncTable[26] := Func26;
  fIdentFuncTable[27] := Func27;
  fIdentFuncTable[28] := Func28;
  fIdentFuncTable[29] := Func29;
  fIdentFuncTable[30] := Func30;
  fIdentFuncTable[32] := Func32;
  fIdentFuncTable[33] := Func33;
  fIdentFuncTable[34] := Func34;
  fIdentFuncTable[35] := Func35;
  fIdentFuncTable[36] := Func36;
  fIdentFuncTable[37] := Func37;
  fIdentFuncTable[38] := Func38;
  fIdentFuncTable[40] := Func40;
  fIdentFuncTable[42] := Func42;
  fIdentFuncTable[43] := Func43;
  fIdentFuncTable[45] := Func45;
  fIdentFuncTable[46] := Func46;
  fIdentFuncTable[47] := Func47;
  fIdentFuncTable[48] := Func48;
  fIdentFuncTable[49] := Func49;
  fIdentFuncTable[50] := Func50;
  fIdentFuncTable[51] := Func51;
  fIdentFuncTable[52] := Func52;
  fIdentFuncTable[53] := Func53;
  fIdentFuncTable[55] := Func55;
  fIdentFuncTable[56] := Func56;
  fIdentFuncTable[60] := Func60;
  fIdentFuncTable[62] := Func62;
  fIdentFuncTable[63] := Func63;
  fIdentFuncTable[64] := Func64;
  fIdentFuncTable[65] := Func65;
  fIdentFuncTable[66] := Func66;
  fIdentFuncTable[69] := Func69;
  fIdentFuncTable[70] := Func70;
  fIdentFuncTable[71] := Func71;
  fIdentFuncTable[73] := Func73;
  fIdentFuncTable[74] := Func74;
  fIdentFuncTable[75] := Func75;
  fIdentFuncTable[76] := Func76;
  fIdentFuncTable[78] := Func78;
  fIdentFuncTable[79] := Func79;
  fIdentFuncTable[80] := Func80;
  fIdentFuncTable[81] := Func81;
  fIdentFuncTable[82] := Func82;
  fIdentFuncTable[83] := Func83;
  fIdentFuncTable[85] := Func85;
  fIdentFuncTable[87] := Func87;
  fIdentFuncTable[89] := Func89;
  fIdentFuncTable[92] := Func92;
  fIdentFuncTable[94] := Func94;
  fIdentFuncTable[95] := Func95;
  fIdentFuncTable[96] := Func96;
  fIdentFuncTable[98] := Func98;
  fIdentFuncTable[99] := Func99;
  fIdentFuncTable[100] := Func100;
  fIdentFuncTable[104] := Func104;
  fIdentFuncTable[105] := Func105;
  fIdentFuncTable[108] := Func108;
  fIdentFuncTable[111] := Func111;
  fIdentFuncTable[112] := Func112;
  fIdentFuncTable[114] := Func114;
  fIdentFuncTable[115] := Func115;
  fIdentFuncTable[116] := Func116;
  fIdentFuncTable[121] := Func121;
  fIdentFuncTable[122] := Func122;
  fIdentFuncTable[123] := Func123;
  fIdentFuncTable[124] := Func124;
  fIdentFuncTable[126] := Func126;
end;

function TmwMOOSyntax.KeyHash(ToHash: PChar): Integer;
begin
  Result := 0;
  while ToHash^ in ['_', '0'..'9', 'a'..'z', 'A'..'Z'] do
  begin
    inc(Result, mHashTable[ToHash^]);
    inc(ToHash);
  end;
  fStringLen := ToHash - fToIdent;
end;

function TmwMOOSyntax.KeyComp(const aKey: String): Boolean;
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

function TmwMOOSyntax.Func0: TmoTokenKind;
begin
  if KeyComp('value_hash') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func1: TmoTokenKind;
begin
  if KeyComp('delete_verb') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func2: TmoTokenKind;
begin
  if KeyComp('output_delimiters') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func6: TmoTokenKind;
begin
  if KeyComp('is_clear_property') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func8: TmoTokenKind;
begin
  if KeyComp('decode_binary') then Result := moBuiltinFunc else
    if KeyComp('binary_hash') then Result := moBuiltinFunc else
      if KeyComp('task_stack') then Result := moBuiltinFunc else
        if KeyComp('ticks_left') then Result := moBuiltinFunc else
          if KeyComp('is_player') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func10: TmoTokenKind;
begin
  if KeyComp('dump_database') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func12: TmoTokenKind;
begin
  if KeyComp('idle_seconds') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func13: TmoTokenKind;
begin
  if KeyComp('properties') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func16: TmoTokenKind;
begin
  if KeyComp('queue_info') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func17: TmoTokenKind;
begin
  if KeyComp('listinsert') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func18: TmoTokenKind;
begin
  if KeyComp('encode_binary') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func22: TmoTokenKind;
begin
  if KeyComp('abs') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func24: TmoTokenKind;
begin
  if KeyComp('server_log') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func25: TmoTokenKind;
begin
  if KeyComp('caller_perms') then Result := moBuiltinFunc else
    if KeyComp('seconds_left') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func26: TmoTokenKind;
begin
  if KeyComp('string_hash') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func27: TmoTokenKind;
begin
  if KeyComp('set_property_info') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func28: TmoTokenKind;
begin
  if KeyComp('read') then Result := moBuiltinFunc else
    if KeyComp('substitute') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func29: TmoTokenKind;
begin
  if KeyComp('object_bytes') then Result := moBuiltinFunc else
    if KeyComp('ceil') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func30: TmoTokenKind;
begin
  if KeyComp('force_input') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func32: TmoTokenKind;
begin
  if KeyComp('boot_player') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func33: TmoTokenKind;
begin
  if KeyComp('call_function') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func34: TmoTokenKind;
begin
  if KeyComp('log') then Result := moBuiltinFunc else
    if KeyComp('log10') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func35: TmoTokenKind;
begin
  if KeyComp('value_bytes') then Result := moBuiltinFunc else
    if KeyComp('tan') then Result := moBuiltinFunc else
      if KeyComp('notify_ansi') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func36: TmoTokenKind;
begin
  if KeyComp('atan') then Result := moBuiltinFunc else
    if KeyComp('min') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func37: TmoTokenKind;
begin
  if KeyComp('cos') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func38: TmoTokenKind;
begin
  if KeyComp('max') then Result := moBuiltinFunc else
    if KeyComp('acos') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func40: TmoTokenKind;
begin
  if KeyComp('eval') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func42: TmoTokenKind;
begin
  if KeyComp('sin') then Result := moBuiltinFunc else
    if KeyComp('db_disk_size') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func43: TmoTokenKind;
begin
  if KeyComp('asin') then Result := moBuiltinFunc else
    if KeyComp('tanh') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func45: TmoTokenKind;
begin
  if KeyComp('memory_usage') then Result := moBuiltinFunc else
    if KeyComp('add_property') then Result := moBuiltinFunc else
      if KeyComp('exp') then Result := moBuiltinFunc else
        if KeyComp('cosh') then Result := moBuiltinFunc else
          if KeyComp('match') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func46: TmoTokenKind;
begin
  if KeyComp('queued_tasks') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func47: TmoTokenKind;
begin
  if KeyComp('time') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func48: TmoTokenKind;
begin
  if KeyComp('valid') then Result := moBuiltinFunc else
    if KeyComp('connection_name') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func49: TmoTokenKind;
begin
  if KeyComp('function_info') then Result := moBuiltinFunc else
    if KeyComp('flush_input') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func50: TmoTokenKind;
begin
  if KeyComp('ctime') then Result := moBuiltinFunc else
    if KeyComp('sinh') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func51: TmoTokenKind;
begin
  if KeyComp('set_connection_option') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func52: TmoTokenKind;
begin
  if KeyComp('buffered_output_length') then Result := moBuiltinFunc else
    if KeyComp('raise') then Result := moBuiltinFunc else
      if KeyComp('create') then Result := moBuiltinFunc else
        if KeyComp('set_verb_code') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func53: TmoTokenKind;
begin
  if KeyComp('setadd') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func55: TmoTokenKind;
begin
  if KeyComp('pass') then Result := moBuiltinFunc else
    if KeyComp('move') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func56: TmoTokenKind;
begin
  if KeyComp('index') then Result := moBuiltinFunc else
    if KeyComp('equal') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func60: TmoTokenKind;
begin
  if KeyComp('nis_password') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func62: TmoTokenKind;
begin
  if KeyComp('toobj') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func63: TmoTokenKind;
begin
  if KeyComp('rmatch') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func64: TmoTokenKind;
begin
  if KeyComp('bf-index') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func65: TmoTokenKind;
begin
  if KeyComp('connected_seconds') then Result := moBuiltinFunc else
    if KeyComp('random') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func66: TmoTokenKind;
begin
  if KeyComp('length') then Result := moBuiltinFunc else
    if KeyComp('floor') then Result := moBuiltinFunc else
      if KeyComp('verbs') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func69: TmoTokenKind;
begin
  if KeyComp('set_verb_info') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func70: TmoTokenKind;
begin
  if KeyComp('set_verb_args') then Result := moBuiltinFunc else
    if KeyComp('callers') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func71: TmoTokenKind;
begin
  if KeyComp('recycle') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func73: TmoTokenKind;
begin
  if KeyComp('children') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func74: TmoTokenKind;
begin
  if KeyComp('sqrt') then Result := moBuiltinFunc else
    if KeyComp('parent') then Result := moBuiltinFunc else
      if KeyComp('open_network_connection') then Result := moBuiltinFunc else
        if KeyComp('rindex') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func75: TmoTokenKind;
begin
  if KeyComp('clear_property') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func76: TmoTokenKind;
begin
  if KeyComp('trunc') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func78: TmoTokenKind;
begin
  if KeyComp('uudecode') then Result := moBuiltinFunc else
    if KeyComp('toint') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func79: TmoTokenKind;
begin
  if KeyComp('listen') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func80: TmoTokenKind;
begin
  if KeyComp('property_info') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func81: TmoTokenKind;
begin
  if KeyComp('set_player_flag') then Result := moBuiltinFunc else
    if KeyComp('resume') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func82: TmoTokenKind;
begin
  if KeyComp('connected_players') then Result := moBuiltinFunc else
    if KeyComp('crypt') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func83: TmoTokenKind;
begin
  if KeyComp('tonum') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func85: TmoTokenKind;
begin
  if KeyComp('chparent') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func87: TmoTokenKind;
begin
  if KeyComp('add_verb') then Result := moBuiltinFunc else
    if KeyComp('delete_property') then Result := moBuiltinFunc else
      if KeyComp('typeof') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func89: TmoTokenKind;
begin
  if KeyComp('tofloat') then Result := moBuiltinFunc else
    if KeyComp('notify') then Result := moBuiltinFunc else
      if KeyComp('strcmp') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func92: TmoTokenKind;
begin
  if KeyComp('server_version') then Result := moBuiltinFunc else
    if KeyComp('tostr') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func94: TmoTokenKind;
begin
  if KeyComp('reset_max_object') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func95: TmoTokenKind;
begin
  if KeyComp('task_id') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func96: TmoTokenKind;
begin
  if KeyComp('renumber') then Result := moBuiltinFunc else
    if KeyComp('players') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func98: TmoTokenKind;
begin
  if KeyComp('suspend') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func99: TmoTokenKind;
begin
  if KeyComp('strsub') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func100: TmoTokenKind;
begin
  if KeyComp('set_task_perms') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func104: TmoTokenKind;
begin
  if KeyComp('listset') then Result := moBuiltinFunc else
    if KeyComp('connection_option') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func105: TmoTokenKind;
begin
  if KeyComp('verb_code') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func108: TmoTokenKind;
begin
  if KeyComp('disassemble') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func111: TmoTokenKind;
begin
  if KeyComp('floatstr') then Result := moBuiltinFunc else
    if KeyComp('listdelete') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func112: TmoTokenKind;
begin
  if KeyComp('toliteral') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func114: TmoTokenKind;
begin
  if KeyComp('unlisten') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func115: TmoTokenKind;
begin
  if KeyComp('is_member') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func116: TmoTokenKind;
begin
  if KeyComp('listappend') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func121: TmoTokenKind;
begin
  if KeyComp('listeners') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func122: TmoTokenKind;
begin
  if KeyComp('verb_info') then Result := moBuiltinFunc else
    if KeyComp('setremove') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func123: TmoTokenKind;
begin
  if KeyComp('verb_args') then Result := moBuiltinFunc else
    if KeyComp('connection_options') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func124: TmoTokenKind;
begin
  if KeyComp('shutdown') then Result := moBuiltinFunc else
    if KeyComp('max_object') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.Func126: TmoTokenKind;
begin
  if KeyComp('kill_task') then Result := moBuiltinFunc else Result := moIdentifier;
end;

function TmwMOOSyntax.AltFunc: TmoTokenKind;
begin
  Result := moIdentifier;
end;

function TmwMOOSyntax.IdentKind(MayBe: PChar): TmoTokenKind;
var
  HashKey: Integer;
begin
  fToIdent := MayBe;
  HashKey := KeyHash(MayBe);
  if HashKey < 127 then Result := fIdentFuncTable[HashKey] else Result := moIdentifier;
end;

procedure TmwMOOSyntax.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      else fProcTable[I] := UnknownProc;
    end;
end;

constructor TmwMOOSyntax.Create(AOwner: TComponent);
begin
  fBuiltinFuncAttri := TmwHighLightAttributes.Create(MWS_AttrBuiltinFunc);
  inherited Create(AOwner);
  AddAttribute(fBuiltinFuncAttri);
  SetAttributesOnChange(DefHighlightChange);
  InitIdent;
  MakeMethodTables;
  fDefaultFilter := 'All files (*.*)|*.*';
  fRange := rsUnknown;
end;

procedure TmwMOOSyntax.SetLine(NewValue: String; LineNumber: Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end;

procedure TmwMOOSyntax.UnknownProc;
begin
  inc(Run);
  fTokenID := moUnknown;
end;

procedure TmwMOOSyntax.Next;
begin
  fTokenPos := Run;
  fProcTable[fLine[Run]];
end;

function TmwMOOSyntax.GetEOL: Boolean;
begin
  Result := fTokenID = tkNull;
end;

function TmwMOOSyntax.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

function TmwMOOSyntax.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TmwMOOSyntax.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TmwMOOSyntax.GetTokenAttribute: TmwHighLightAttributes;
begin
  case GetTokenID of
    moBuiltinFunc: Result := fBuiltinFuncAttri;
    moUnknown: Result := fIdentifierAttri;
    else Result := nil;
  end;
end;

function TmwMOOSyntax.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TmwMOOSyntax.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

procedure TmwMOOSyntax.ReSetRange;
begin
  fRange := rsUnknown;
end;

procedure TmwMOOSyntax.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TmwMOOSyntax.GetIdentChars: TIdentChars;
begin
  Result := ['_', '0'..'9', 'a'..'z', 'A'..'Z'];
end;

function TmwMOOSyntax.GetLanguageName: string;
begin
  Result := 'moo';
end;

function TmwMOOSyntax.GetCapability: THighlighterCapability;
begin
  Result := inherited GetCapability + [hcUserSettings, hcExportable];
end;

procedure TmwMOOSyntax.SetLineForExport(NewValue: String);
begin
  fLine := PChar(NewValue);
  Run := 0;
  ExportNext;
end;

procedure TmwMOOSyntax.ExportNext;
begin
  fTokenPos := Run;
  fProcTable[fLine[Run]];
  if Assigned(Exporter) then
    Case GetTokenID of
      moBuiltinFunc: TmwCustomExport(Exporter).FormatToken(GetToken, fBuiltinFuncAttri, False, False);
    end;
end;

Initialization
  MakeIdentTable;
end.
