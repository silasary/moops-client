{+-----------------------------------------------------------------------------+
 | Class:       TcbHPSyn
 | Created:     not known
 | Last change: 1999-11-01
 | Author:      Cyrille de Brebisson [cyrille_de-brebisson@aus.hp.com]
 | Description: HP48 assembly syntax highliter
 | Version:     0.57
 | Copyright (c) 1998 Cyrille de Brebisson
 | All rights reserved.
 |
 | Thanks to: Primoz Gabrijelcic
 |
 | See file version.rtf for version history
 +----------------------------------------------------------------------------+}

unit cbHPSyn;

{$I mwEdit.inc}

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Graphics, Registry,
  mwHighlighter, cbUtils, mwLocalStr;

type
  TtkTokenKind = (tkAsmKey, tkAsm, tkAsmComment, tksAsmKey, tksAsm, tksAsmComment, tkRplKey, tkRpl, tkRplComment);

var
  tkTokenName: array [TtkTokenKind] of string = (
                 MWS_AttrAsmKey, MWS_AttrAsm, MWS_AttrAsmComment,
                 MWS_AttrSASMKey, MWS_AttrSASM, MWS_AttrSASMComment,
                 MWS_AttrRplKey, MWS_AttrRpl, MWS_AttrRplComment);

type

  TRangeState = (rsRpl, rsComRpl, rssasm1, rssasm2, rssasm3, rsAsm, rsComAsm2, rsComAsm1);

  TcbHPSyn = Class(TmwCustomHighLighter)
  private
    fTockenKind: TtkTokenKind;
    fRange: TRangeState;
    fLine: String;
    Run: LongInt;
    fTokenPos: Integer;
    fEol: Boolean;
    Attribs: array [TtkTokenKind] of TmwHighLightAttributes;
    FRplKeyWords: TSpeedStringList;
    FAsmKeyWords: TSpeedStringList;
    FSAsmNoField: TSpeedStringList;
    FBaseRange: TRangeState;
    Function GetAttrib(Index: integer): TmwHighLightAttributes;
    Procedure SetAttrib(Index: integer; Value: TmwHighLightAttributes);

    Function NullProc: TtkTokenKind;
    Function SpaceProc: TtkTokenKind;
    Function ParOpenProc: TtkTokenKind;
    Function RplComProc: TtkTokenKind;
    function AsmComProc(c: char): TtkTokenKind;
    Function PersentProc: TtkTokenKind;
    Function IdentProc: TtkTokenKind;
    function SlashProc: TtkTokenKind;
    function SasmProc1: TtkTokenKind;
    function SasmProc2: TtkTokenKind;
    function SasmProc3: TtkTokenKind;
    procedure EndOfToken;
    procedure SetHighLightChange;
    Function Next1: TtkTokenKind;
    procedure Next2(tkk: TtkTokenKind);
    function GetTokenFromRange: TtkTokenKind;
    function StarProc: TtkTokenKind;
  protected
    function GetLanguageName: string; override;
    function GetAttribCount: integer; override;
    function GetAttribute(idx: integer): TmwHighLightAttributes; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;                     override;
    function GetEol: Boolean;               override;
    procedure SetLine(NewValue: String; LineNumber:Integer); override; 
    function GetToken: String;              override;
    function GetTokenPos: Integer;          override;
    procedure Next;                         override;

    function GetTokenAttribute: TmwHighLightAttributes; override;
    function GetTokenKind: integer;                     override;                   

    function GetRange: Pointer;             override;
    procedure SetRange(Value: Pointer);     override;
    procedure ReSetRange;                   override;
    function SaveToRegistry(RootKey: HKEY; Key: string): boolean; override;
    function LoadFromRegistry(RootKey: HKEY; Key: string): boolean; override;
    Procedure Assign(Source: TPersistent); Override;
    Property AsmKeyWords: TSpeedStringList read FAsmKeyWords;
    Property SAsmFoField: TSpeedStringList read FSAsmNoField;
    Property RplKeyWords: TSpeedStringList read FRplKeyWords;
  published
    Property AsmKey    : TmwHighLightAttributes index Ord(tkAsmKey)     read GetAttrib write SetAttrib; 
    Property AsmTxt    : TmwHighLightAttributes index Ord(tkAsm)        read GetAttrib write SetAttrib; 
    Property AsmComment: TmwHighLightAttributes index Ord(tkAsmComment) read GetAttrib write SetAttrib;
    Property sAsmKey    : TmwHighLightAttributes index Ord(tksAsmKey)     read GetAttrib write SetAttrib; 
    Property sAsmTxt    : TmwHighLightAttributes index Ord(tksAsm)        read GetAttrib write SetAttrib; 
    Property sAsmComment: TmwHighLightAttributes index Ord(tksAsmComment) read GetAttrib write SetAttrib;
    Property RplKey    : TmwHighLightAttributes index Ord(tkRplKey)     read GetAttrib write SetAttrib; 
    Property RplTxt    : TmwHighLightAttributes index Ord(tkRpl)        read GetAttrib write SetAttrib; 
    Property RplComment: TmwHighLightAttributes index Ord(tkRplComment) read GetAttrib write SetAttrib; 
    Property BaseRange: TRangeState read FBaseRange write FBaseRange;
  end;

procedure Register;

implementation

Const
  DefaultAsmKeyWords : String = '!RPL'#13#10'ENDCODE'#13#10'{'#13#10'}'#13#10+
                                'GOTO'#13#10'GOSUB'#13#10'GOSBVL'#13#10'GOVLNG'#13#10'GOLONG'#13#10'SKIP'+
                                #13#10'SKIPYES'+#13#10'->'#13#10'SKUB'#13#10'SKUBL'#13#10'SKC'#13#10'SKNC'#13#10'SKELSE'+
                                #13#10'SKEC'#13#10'SKENC'#13#10'SKLSE'#13#10+'GOTOL'#13#10'GOSUBL'#13#10+
                                'RTN'#13#10'RTNC'#13#10'RTNNC'#13#10'RTNSC'#13#10'RTNCC'#13#10'RTNSXM'#13#10'RTI';
  OtherAsmKeyWords: array [0..5] of string = ('UP', 'EXIT', 'UPC', 'EXITC', 'UPNC', 'EXITNC');
{$IFNDEF MWE_COMPILER_3_UP}
  DefaultRplKeyWords: string =
{$ELSE}
  DefaultRplKeyWords =
{$ENDIF}
                        'CODEM'#13#10'ASSEMBLEM'#13#10'CODE'#13#10'ASSEMBLE'#13#10'IT'#13#10'ITE'#13#10'case'#13#10'::'#13#10';'#13#10'?SEMI'#13#10''''#13#10'#=case'#13#10'{'#13#10'}'#13#10'NAMELESS'#13#10'LOCAL'#13#10'LOCALNAME'#13#10'LABEL'#13#10 +
                        'LOCALLABEL'#13#10'xNAME'#13#10'tNAME'+'COLA'#13#10'NULLNAME'#13#10'xROMID'#13#10'#0=ITE'#13#10'#<ITE'#13#10'#=ITE'#13#10'#>ITE'#13#10'2''RCOLARPITE'#13#10'ANDITE'#13#10'COLAITE'#13#10'COLARPITE'#13#10'DUP#0=ITE'#13#10 +
                        'EQITE'#13#10'ITE'#13#10'RPITE'#13#10'SysITE'#13#10'UNxSYMRPITE'#13#10'UserITE'#13#10'snnSYMRPITE'#13#10'snsSYMRPITE'#13#10'ssnSYMRPITE'#13#10'sssSYMRPITE'#13#10'$_EXIT'#13#10'DA1OK?NOTIT'#13#10'DA2aOK?NOTIT'#13#10 +
                        'DA2bOK?NOTIT'#13#10'DA3OK?NOTIT'#13#10'DO#EXIT'#13#10'DO$EXIT'#13#10'DO%EXIT'#13#10'DOHXSEXIT'#13#10'DUP#0=IT'#13#10'EQIT'#13#10'GCDHEULPEXIT'#13#10'GSPLIT'#13#10'NOT_IT'#13#10'POINTEXIT'#13#10'POLYARIT'#13#10'RPIT'#13#10 +
                        'parleftIT'#13#10'parrightIT'#13#10''''#13#10'IT'#13#10'ITE'#13#10'SEMI'#13#10'UNTIL'#13#10'LOOP'#13#10'?SEMI'#13#10'NOT?SEMI'#13#10'#0=case'#13#10'#1=case'#13#10'#<>case'#13#10'#<case'#13#10'#=case'#13#10'#=casedrop'#13#10 +
                        '#=casedrpfls'#13#10'#>2case'#13#10'#>33case'#13#10'#>case'#13#10'%-1=case'#13#10'%0=case'#13#10'%1=case'#13#10'%2=case'#13#10'AEQ1stcase'#13#10'AEQopscase'#13#10'ANDNOTcase'#13#10'ANDcase'#13#10'C%-1=case'#13#10 +
                        'C%0=case'#13#10'C%1=case'#13#10'C%2=case'#13#10'COLANOTcase'#13#10'COLAcase'#13#10'DUP#0=case'#13#10'EQUALNOTcase'#13#10'EQUALcase'#13#10'EQUALcasedrop'#13#10'EQUALcasedrp'#13#10'EQcase'#13#10'EQcaseDROP'#13#10 +
                        'EQcasedrop'#13#10'EnvNGcase'#13#10'M-1stcasechs'#13#10'MEQ*case'#13#10'MEQ+case'#13#10'MEQ-case'#13#10'MEQ/case'#13#10'MEQ1stcase'#13#10'MEQCHScase'#13#10'MEQFCNcase'#13#10'MEQINVcase'#13#10'MEQSQcase'#13#10'MEQ^case'#13#10 +
                        'MEQopscase'#13#10'Mid1stcase'#13#10'NOTBAKcase'#13#10'NOTLIBcase'#13#10'NOTLISTcase'#13#10'NOTMATRIXcase'#13#10'NOTROMPcase'#13#10'NOTSECOcase'#13#10'NOTTYPEcase'#13#10'NOTcase'#13#10'NOTcase2DROP'#13#10'NOTcase2drop'#13#10 +
                        'NOTcaseDROP'#13#10'NOTcaseFALSE'#13#10'NOTcaseTRUE'#13#10'NOTcasedrop'#13#10'NULLargcase'#13#10'NcaseSIZEERR'#13#10'NcaseTYPEERR'#13#10'NoEdit?case'#13#10'ORcase'#13#10'OVER#=case'#13#10'REALcase'#13#10'REQcase'#13#10 +
                        'REQcasedrop'#13#10'Z-1=case'#13#10'Z0=case'#13#10'Z1=case'#13#10'accNBAKcase'#13#10'accNLIBcase'#13#10'case'#13#10'case2DROP'#13#10'case2drop'#13#10'case2drpfls'#13#10'caseDEADKEY'#13#10'caseDROP'#13#10'caseDoBadKey'#13#10 +
                        'caseDrpBadKy'#13#10'caseERRJMP'#13#10'caseFALSE'#13#10'caseSIZEERR'#13#10'caseTRUE'#13#10'casedrop'#13#10'casedrpfls'#13#10'casedrptru'#13#10'caseout'#13#10'cxcasecheck'#13#10'dARRYcase'#13#10'dIDNTNcase'#13#10'dLISTcase'#13#10 +
                        'dMATRIXcase'#13#10'dREALNcase'#13#10'dREALcase'#13#10'dZINTNcase'#13#10'delimcase'#13#10'estcase'#13#10'idntcase'#13#10'idntlamcase'#13#10'j#-1=case'#13#10'j#0=case'#13#10'j#1=case'#13#10'j%-1=case'#13#10'j%0=case'#13#10 +
                        'j%1=case'#13#10'jEQcase'#13#10'jZ-1=case'#13#10'jZ0=case'#13#10'jZ1=case'#13#10'namelscase'#13#10'need''case'#13#10'negrealcase'#13#10'ngsizecase'#13#10'nonopcase'#13#10'nonrmcase'#13#10'num#-1=case'#13#10'num#0=case'#13#10 +
                        'num#1=case'#13#10'num-1=case'#13#10'num0=case'#13#10'num0case'#13#10'num1=case'#13#10'num2=case'#13#10'numb1stcase'#13#10'rebuildcase'#13#10'tok=casedrop'#13#10'wildcase'#13#10'zerdercase'#13#10;
  SasmNoField : string = 'LOOP'#13#10'RTNSXM'#13#10'RTN'#13#10'RTNSC'#13#10'RTNCC'#13#10'SETDEC'#13#10'SETHEX'#13#10'RSTK=C'#13#10'C=RSTK'#13#10'CLRST'#13#10'C=ST'#13#10'ST=C'#13#10'CSTEX'#13#10+
                         'RTI'#13#10'R0=A'#13#10'R1=A'#13#10'R2=A'#13#10'R3=A'#13#10'R4=A'#13#10'R0=C'#13#10'R1=C'#13#10'R2=C'#13#10'R3=C'#13#10'R4=C'#13#10'A=R0'#13#10'A=R1'#13#10'A=R2'#13#10'A=R3'#13#10'A=R4'#13#10+
                         'C=R0'#13#10'C=R1'#13#10'C=R2'#13#10'C=R3'#13#10'C=R4'#13#10'AR0EX'#13#10'AR1EX'#13#10'AR2EX'#13#10'AR3EX'#13#10'AR4EX'#13#10'CR0EX'#13#10'CR1EX'#13#10'CR2EX'#13#10'CR3EX'#13#10'CR4EX'#13#10+
                         'D0=A'#13#10'D0=C'#13#10'D1=A'#13#10'D1=C'#13#10'AD0EX'#13#10'AD1EX'#13#10'CD0EX'#13#10'CD1EX'#13#10'D0=AS'#13#10'D1=AS'#13#10'D0=CS'#13#10'D1=CD'#13#10'CD1XS'#13#10'CD0XS'#13#10'AD1XS'#13#10'AD0XS'#13#10+
                         'RTNC'#13#10'RTNNC'#13#10'OUT=CS'#13#10'OUT=C'#13#10'A=IN'#13#10'C=IN'#13#10'SHUTDN'#13#10'INTON'#13#10'C=ID'#13#10'CONFIG'#13#10'UNCNFG'#13#10'RSI'#13#10'PC=(A)'#13#10'PC=(C)'#13#10'INTOFF'#13#10+
                         'C+P+1'#13#10'RESET'#13#10'SREQ?'#13#10'ASLC'#13#10'BSLC'#13#10'CSLC'#13#10'DSLC'#13#10'ASRC'#13#10'BSRC'#13#10'CSRC'#13#10'DSRC'#13#10'ASRB'#13#10'BSRB'#13#10'CSRB'#13#10'DSRB'#13#10'PC=A'#13#10'PC=C'#13#10+
                         'A=PC'#13#10'C=PC'#13#10'APCEX'#13#10'CPCEX'#13#10'XM=0'#13#10'SB=0'#13#10'SR=0'#13#10'MP=0'#13#10'CLRHST'#13#10'?XM=0'#13#10'?SR=0'#13#10'?MP=0'#13#10'?SB=0'#13#10'RTNYES'#13#10'SKIPYES{'#13#10'{'#13#10'}'#13#10'UP'#13#10'EXIT'#13#10'EXITNC'#13#10'EXITC'#13#10'UPC'#13#10'UPNC'+
                         '}SKELSE{'#13#10'SKC{'#13#10'SKNC{'#13#10'SKUB{'#13#10'SKUBL{'#13#10'SKIPC{'#13#10'SKIPNC{'#13#10'EXIT2'#13#10'EXIT3'#13#10'UP2'#13#10'UP3'#13#10'}SKLSE{'#13#10'}SKEC{'#13#10'}SKENC{'#13#10;

procedure Register;
begin
  RegisterComponents(MWS_HighlightersPage, [TcbHPSyn]);
end;

constructor TcbHPSyn.Create(AOwner: TComponent);
Var
  i: TtkTokenKind;
  j, k: integer;
begin
  for i:= low(TtkTokenKind) to High(TtkTokenKind) do
    Attribs[i]:= TmwHighLightAttributes.Create(tkTokenName[i]);
  inherited Create(AOwner);
  SetHighlightChange;
  FAsmKeyWords:= TSpeedStringList.Create;
  FAsmKeyWords.Text:= DefaultAsmKeyWords;
  for j:= low(OtherAsmKeyWords) to High(OtherAsmKeyWords) do
  Begin
{$IFNDEF MWE_COMPILER_4_UP}
    FAsmKeyWords.AddObj(TSpeedListObject.Create(OtherAsmKeyWords[j]));
    for k:= 1 to 8 do
      FAsmKeyWords.AddObj(TSpeedListObject.Create(OtherAsmKeyWords[j]+IntToStr(k)));
{$ELSE}
    FAsmKeyWords.Add(TSpeedListObject.Create(OtherAsmKeyWords[j]));
    for k:= 1 to 8 do
      FAsmKeyWords.Add(TSpeedListObject.Create(OtherAsmKeyWords[j]+IntToStr(k)));
{$ENDIF}
  end;
  FRplKeyWords:= TSpeedStringList.Create;
  FRplKeyWords.Text:= DefaultRplKeyWords;
  FSAsmNoField:= TSpeedStringList.Create;
  FSAsmNoField.Text:= SAsmNoField;
  BaseRange:= rsRpl;
  fRange := rsRpl;
  fDefaultFilter := 'HP48 files (*.s,*.sou,*.a,*.hp)|*.S;*.SOU;*.A;*.HP';
end; { Create }

destructor TcbHPSyn.Destroy;
var
  i: TtkTokenKind;
begin
  for i:= low(TtkTokenKind) to High(TtkTokenKind) do
    Attribs[i].Free;
  FAsmKeyWords.Free;
  FRplKeyWords.Free;
  FSAsmNoField.free;
  inherited Destroy;
end; { Destroy }

procedure TcbHPSyn.SetLine(NewValue: String; LineNumber:Integer);
begin
  fLine := PChar(NewValue);
  Run := 1;
  fEol := False;
  Next;
end; { SetLine }

function TcbHPSyn.AsmComProc(c: char): TtkTokenKind;
begin
  Result := tkAsmComment;
  If (Run>Length(fLine)) then
    Result:= NullProc
  else
    while Run<=Length(FLine) do
      if ((run=1) or (fLine[run-1]<=' ')) and
         (fLine[Run]='*') and
         ((run<Length(fLine)) and (fLine[run+1]=c)) and
         ((run+1=Length(fLine)) or (fLine[run+2]<=' ')) then
      Begin
        inc(run, 2);
        fRange := rsAsm;
        break;
      end else
        inc(Run);
end;

function TcbHPSyn.RplComProc: TtkTokenKind;
begin
  Result := tkRplComment;
  If (Run>Length(fLine)) then
    Result:= NullProc
  else
    while Run<=Length(FLine) do
      if fLine[Run]=')' then
      Begin
        inc(run);
        fRange := rsRpl;
        break;
      end else
        inc(Run);
end;

function TcbHPSyn.SlashProc: TtkTokenKind;
begin
  if fRange = rsRpl then
    Result:= IdentProc
  else
    if ((Run=1) or (fLine[Run-1]<=' ')) and
       (fLine[Run]='/') and
       (run<Length(fLine)) and
       (fLine[run+1]='*') and
       ((run+1=Length(fLine)) or (fLine[Run+2]<=' ')) then
    Begin
      inc(Run,2);
      Result := tkAsmComment;
      fRange := rsComAsm2;
    end
    else
    if (run<Length(fLine)) and (fLine[Run+1]='/') then
    Begin
      inc(Run,2);
      Result := tkAsmComment;
      while (run<=Length(fLine)) do
        if FLine[Run] in [#10, #13] then
        begin
          inc(Run);
          break;
        end else
          inc(Run);
    end else
      Result:= IdentProc
end;

Function TcbHPSyn.ParOpenProc: TtkTokenKind;
begin
  if fRange = rsRpl then
    if ((Run=1) and ((Length(fLine)=1) or (fLine[Run+1]<=' '))) or
       ((fLine[Run-1]<=' ') and ((Length(fLine)=Run) or (fLine[Run+1]<=' '))) then
    Begin
      inc(Run);
      Result := tkRplComment;
      fRange := rsComRpl;
    end
    else
      Result:= IdentProc
  else
    if ((run=1) or (fLine[run-1]<=' ')) and
       (fline[Run]='(') and
       (run<Length(fLine)) and
       (fLine[run+1]='*') and
       ((run+2>Length(fLine)) or (fLine[run+2]<=' ')) then
    Begin
      inc(Run,2);
      Result := tkAsmComment;
      fRange := rsComAsm1;
    end else
      Result:= IdentProc
end;

Function TcbHPSyn.PersentProc: TtkTokenKind;
begin
  if fRange = rsAsm then
  Begin
    inc(Run);
    Result := tkAsmComment;
    while (run<=Length(fLine)) do
      case FLine[Run] of
        #10, #13:
          begin
            inc(Run);
            break;
          end;
      else inc(Run);
      end;
  end else
    Result:= IdentProc;
end;

function TcbHPSyn.StarProc: TtkTokenKind;
begin
  if fRange = rsRpl then
  Begin
    inc(Run);
    Result := tkRplComment;
    while (run<=Length(fLine)) do
      case FLine[Run] of
        #10, #13:
          begin
            inc(Run);
            break;
          end;
      else inc(Run);
      end;
  end else
    Result:= IdentProc;
end;

function TcbHPSyn.IdentProc: TtkTokenKind;
var
  i: integer;
  s: string;
begin
  i:= Run;
  EndOfToken;
  s:= Copy(fLine, i, run-i);
  if fRange = rsAsm then
    if FAsmKeyWords.Find(s)<>nil then
      if (s='!RPL') or (s='ENDCODE') then
      Begin
        fRange := rsRpl;
        result:= tkAsmKey;
      end else
        result:= tkAsmKey
    else
      if fLine[i]<>'*' then
        result:= tkAsm
      else
        result:= tkAsmKey
  else
    if FRplKeyWords.Find(s)<>nil then
      if (s='CODEM') or (s='ASSEMBLEM') then
      Begin
        fRange := rsAsm;
        result:= tkAsmKey;
      end else
        if (s='CODE') or (s='ASSEMBLE') then
        Begin
          fRange := rssAsm1;
          result:= tksAsmKey;
        end else
          result:= tkRplKey
    else
      result:= tkRpl;
end;

function TcbHPSyn.GetTokenFromRange: TtkTokenKind;
begin
  case frange of
    rsAsm                 : result:= tkAsm;
    rssAsm1               : result:= tksAsmKey;
    rssAsm2               : result:= tksAsm;
    rssAsm3               : result:= tksAsmComment;
    rsRpl                 : result:= tkRpl;
    rsComRpl              : result:= tkRplComment;
    rsComAsm1, rsComAsm2  : result:= tkAsmComment;
    else result:= TkAsm;
  end;
end;

Function TcbHPSyn.NullProc: TtkTokenKind;
begin
  Result := GetTokenFromRange;
  fEol := True;
end;

Function TcbHPSyn.SpaceProc: TtkTokenKind;
begin
  inc(Run);
  while (Run<=Length(FLine)) and (FLine[Run] in [#1..#32]) do inc(Run);
  result:= GetTokenFromRange;
end;

Function TcbHPSyn.Next1: TtkTokenKind;
begin
  fTokenPos := Run;
  if Run>Length(fLine) then      result:= NullProc
  else if fRange = rsComRpl then result:= RplComProc
  else if fRange = rsComAsm1 then result:= AsmComProc(')')
  else if fRange = rsComAsm2 then result:= AsmComProc('/')
  else if frange = rssasm1   then result:= SasmProc1
  else if frange = rssasm2   then result:= sasmproc2
  else if frange = rssasm3   then result:= sasmproc3
  else if fLine[Run] in [#1..#32] then result:= SpaceProc
  else if fLine[Run] = '(' then  result:= ParOpenProc
  else if fLine[Run] = '%' then  result:= PersentProc
  else if fLine[Run] = '/' then  result:= SlashProc
  else if (run=1) and (fRange = rsRpl) and (fLine[1]='*') then result:= StarProc
  else result:= IdentProc;
end;

procedure TcbHPSyn.Next2(tkk: TtkTokenKind);
begin
  fTockenKind:= tkk;
end;

procedure TcbHPSyn.Next;
begin
  Next2(Next1);
end;

function TcbHPSyn.GetEol: Boolean;
begin
  Result:= fEol;
end;

function TcbHPSyn.GetToken: String;
var
  Len: LongInt;
  a: PChar;
begin
  a:= @(fLine[fTokenPos]);
  Len := Run - fTokenPos;
  SetString(Result, a, Len);
end;

function TcbHPSyn.GetTokenPos: Integer;
begin
 Result := fTokenPos-1;
end;

function TcbHPSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

procedure TcbHPSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

procedure TcbHPSyn.ReSetRange;
begin
  fRange := BaseRange;
end;

function TcbHPSyn.GetAttrib(Index: integer): TmwHighLightAttributes;
begin
  Result:= Attribs[TtkTokenKind(Index)];
end;

procedure TcbHPSyn.SetAttrib(Index: integer; Value: TmwHighLightAttributes);
begin
  Attribs[TtkTokenKind(Index)].Assign(Value);
end;

procedure TcbHPSyn.EndOfToken;
begin
  while (Run<=Length(fLine)) and (FLine[Run]>' ') do
    Inc(Run);
end;

function TcbHPSyn.LoadFromRegistry(RootKey: HKEY; Key: string): boolean;
var
  r: TBetterRegistry;
begin
  r:= TBetterRegistry.Create;
  try
    r.RootKey := RootKey;
    if r.OpenKeyReadOnly(Key) then begin
      if r.ValueExists('AsmKeyWordList')
        then AsmKeywords.Text:= r.ReadString({'HPSyntax',} 'AsmKeyWordList'{, AsmKeywords.Text});
      if r.ValueExists('RplKeyWordList')
        then RplKeywords.Text:= r.ReadString({'HPSyntax',} 'RplKeyWordList'{, RplKeywords.Text});
      Result := inherited LoadFromRegistry(RootKey, Key);
    end
    else Result := false;
  finally r.Free; end;
end;

function TcbHPSyn.SaveToRegistry(RootKey: HKEY; Key: string): boolean;
var
  r: TBetterRegistry;
begin
  r:= TBetterRegistry.Create;
  try
    r.RootKey := RootKey;
    if r.OpenKey(Key,true) then begin
      Result := true;
      r.WriteString({'HPSyntax',} 'AsmKeyWordList', AsmKeywords.Text);
      r.WriteString({'HPSyntax',} 'RplKeyWordList', RplKeywords.Text);
      Result := inherited SaveToRegistry(RootKey, Key);
    end
    else Result := false;
  finally r.Free; end;
end;

procedure TcbHPSyn.Assign(Source: TPersistent);
var
  i: TtkTokenKind;
begin
  if Source is TcbHPSyn then
  Begin
    for i:= Low(Attribs) to High(Attribs) do
    Begin
      Attribs[i].Background    := TcbHPSyn(source).Attribs[i].Background;
      Attribs[i].Foreground    := TcbHPSyn(source).Attribs[i].Foreground;
      Attribs[i].Style := TcbHPSyn(source).Attribs[i].Style;
    end;
    AsmKeyWords.Text:= TcbHPSyn(source).AsmKeyWords.Text;
    RplKeyWords.Text:= TcbHPSyn(source).RplKeyWords.Text;
  end else
    inherited Assign(Source);
end;

function TcbHPSyn.GetAttribCount: integer;
begin
  Result := Ord(High(Attribs))-Ord(Low(Attribs))+1;
end;

function TcbHPSyn.GetAttribute(idx: integer): TmwHighLightAttributes;
begin // sorted by name
  if (idx <= Ord(High(TtkTokenKind))) then Result := Attribs[TtkTokenKind(idx)]
                                      else Result := nil;
end;

function TcbHPSyn.GetLanguageName: string;
begin
  Result := 'HP48';
end;

procedure TcbHPSyn.SetHighLightChange;
var
  i: TtkTokenKind;
begin
  for i:= Low(Attribs) to High(Attribs) do
    Attribs[i].OnChange := DefHighLightChange;
end;

function TcbHPSyn.SasmProc1: TtkTokenKind;
var
  i: integer;
  s: string;
begin
  Result := tksAsmKey;
  if run>Length(fLine) then
    exit;
  if FLine[Run]='*' then
  begin
    frange:= rssasm3;
    result:= tksAsmComment;
    exit;
  end;
  if FLine[Run]>=' ' then
  Begin
    i:= run;
    while (run<=Length(fLine)) and (FLine[run]>' ') do inc(run);
    s:= Copy(fLine, i, run-i);
    if (s='RPL') or (s='ENDCODE') then
    Begin
      frange:= rsRpl;
      exit;
    end;
  end;
  while (run<=Length(fLine)) and (FLine[run]<=' ') and (FLine[run]<>#10) do inc(run);
  if run<=Length(fLine) then
    frange:= rssasm2
  else
    frange:= rssasm1;
end;

function TcbHPSyn.SasmProc2: TtkTokenKind;
var
  i: integer;
  s: string;
begin
  Result := tksAsm;
  while (run<=Length(fLine)) and (FLine[run]<=' ') and (fline[run]<>#10) do inc(run);
  if run>30 then
  Begin
    frange:= rssasm3;
    exit;
  end;
  i:= run;
  while (run<=Length(fLine)) and (FLine[run]>' ') do inc(run);
  s:= Copy(fLine, i, run-i);
  if (s='ENDCODE') or (s='RPL') then
  Begin
    frange:= rsRpl;
    result:= tksAsmKey;
  end else begin
    if FSAsmNoField.Find(s)=nil then
    Begin
      while (run<=Length(fLine)) and (FLine[run]<=' ') and (FLine[run]<>#10) do inc(run);
      while (run<=Length(fLine)) and (FLine[run]>' ') do inc(run);
      while (run<=Length(fLine)) and (FLine[run]<=' ') and (FLine[run]<>#10) do inc(run);
    end;
    if run<=Length(fLine) then
      frange:= rssasm3
    else
      frange:= rssasm1;
  end;
end;

function TcbHPSyn.SasmProc3: TtkTokenKind;
begin
  Result := tksAsmComment;
  while (run<=Length(fLine)) and (FLine[run]<>#10) do inc(run);
  if run<=Length(fLine) then inc(run);
  frange:= rssasm1;
end;

function TcbHPSyn.GetTokenAttribute: TmwHighLightAttributes;
begin
  Result := GetAttrib(Ord(fTockenKind));
end;

function TcbHPSyn.GetTokenKind: integer;
begin
  Result := Ord(fTockenKind);
end;

end.

