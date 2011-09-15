{+--------------------------------------------------------------------------+
 | Unit:        mkGalaxySyn
 | Created:     05.99
 | Last change: 1999-10-27
 | Author:      Martijn van der Kooij
 | Copyright    1998, No rights reserved.
 | Description: A galaxy HighLighter for Use with mwCustomEdit.
 |              The KeyWords in the string list KeyWords have to be UpperCase and sorted.
 |              Galaxy is a PBEM game for 10 to 500+ players.
 |              To see it working: http://members.tripod.com/~erisande/kooij.html
 | Version:     0.73
 | Status       Public Domain
 | DISCLAIMER:  This is provided as is, expressly without a warranty of any kind.
 |              You use it at your own risc.
 |
 | Thanks to: Martin Waldenburg, Primoz Gabrijelcic
 +--------------------------------------------------------------------------+}
unit mkGalaxySyn;

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
    tkSpace,
    tkMessage,
    tkUnknown);
  TRangeState = (rsUnKnown, rsMessageStyle);
  TProcTableProc = procedure of Object;

type
  TmkGalaxySyn = class(TmwCustomHighLighter)
  private
    fRange: TRangeState;
    fLine: PChar;
    fProcTable: array[#0..#255] of TProcTableProc;
    Run: LongInt;
    fTokenPos: Integer;
    FTokenID: TtkTokenKind;
    fLineNumber : Integer;
    fMessageAttri: TmwHighLightAttributes;
    fSymbolAttri: TmwHighLightAttributes;
    fKeyAttri: TmwHighLightAttributes;
    fCommentAttri: TmwHighLightAttributes;
    fSpaceAttri: TmwHighLightAttributes;
    fIdentifierAttri: TmwHighLightAttributes;
    fKeyWords: TStrings;
    procedure PointCommaProc;
    procedure CRProc;
    procedure IdentProc;
    procedure LFProc;
    procedure NullProc;
    procedure SpaceProc;
    procedure StringProc;
    procedure UnknownProc;
    procedure MakeMethodTables;
    function IsKeyWord(aToken: String): Boolean;
    procedure MessageStyleProc;
    procedure SetKeyWords(const Value: TStrings);
  protected
    function GetLanguageName: string; override;
    function GetCapability: THighlighterCapability; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExportNext;override;
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
    property CommentAttri: TmwHighLightAttributes read fCommentAttri write fCommentAttri;
    property IdentifierAttri: TmwHighLightAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TmwHighLightAttributes read fKeyAttri write fKeyAttri;
    property KeyWords: TStrings read fKeyWords write SetKeyWords;
    property SpaceAttri: TmwHighLightAttributes read fSpaceAttri write fSpaceAttri;
    property MessageAttri: TmwHighLightAttributes read fMessageAttri write fMessageAttri;
  end;

procedure Register;

implementation

uses mwExport;

procedure Register;
begin
  RegisterComponents(MWS_HighlightersPage, [TmkGalaxySyn]);
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
      '_', '0'..'9', 'a'..'z', 'A'..'Z', '#': Identifiers[I] := True;
    else Identifiers[I] := False;
    end;
    J := UpperCase(I)[1];
    Case I in ['_', 'a'..'z', 'A'..'Z'] of
      True: mHashTable[I] := Ord(J) - 64
    else mHashTable[I] := 0;
    end;
  end;
end;

function TmkGalaxySyn.IsKeyWord(aToken: String): Boolean;
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

procedure TmkGalaxySyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      ';': fProcTable[I] := PointCommaProc;                                      
      #13: fProcTable[I] := CRProc;
      '#','A'..'Z', 'a'..'z', '_': fProcTable[I] := IdentProc;
      #10: fProcTable[I] := LFProc;
      #0: fProcTable[I] := NullProc;
      #1..#9, #11, #12, #14..#32: fProcTable[I] := SpaceProc;
      '@': fProcTable[I] := StringProc;
    else fProcTable[I] := UnknownProc;
    end;
end;

constructor TmkGalaxySyn.Create(AOwner: TComponent);
begin
  fKeyWords := TStringList.Create;
  TStringList(fKeyWords).Sorted := True;
  TStringList(fKeyWords).Duplicates := dupIgnore;
  TStringList(fKeyWords).CommaText :=
    '#END,#GALAXY,A,ANONYMOUS,AUTOUNLOAD,B,BATTLEPROTOCOL,C,CAP,CARGO,COL,' +
    'COMPRESS,D,DRIVE,E,EMP,F,FLEET,FLEETTABLES,G,GALAXYTV,GPLUS,GROUPFORECAST,' +
    'H,I,J,L,M,MACHINEREPORT,MAT,N,NAMECASE,NO,O,OPTIONS,P,PLANETFORECAST,' +
    'PRODTABLE,PRODUCE,Q,R,ROUTESFORECAST,S,SEND,SHIELDS,SHIPTYPEFORECAST,' +
    'SORTGROUPS,T,TWOCOL,U,UNDERSCORES,V,W,WAR,WEAPONS,X,Y,Z';
  fCommentAttri := TmwHighLightAttributes.Create(MWS_AttrComment);
  fCommentAttri.Style := [fsItalic];
  fIdentifierAttri := TmwHighLightAttributes.Create(MWS_AttrIdentifier);
  fKeyAttri := TmwHighLightAttributes.Create(MWS_AttrReservedWord);
  fKeyAttri.Style := [fsBold];
  fSpaceAttri := TmwHighLightAttributes.Create(MWS_AttrSpace);
  fMessageAttri := TmwHighLightAttributes.Create(MWS_AttrMessage);
  fSymbolAttri := TmwHighLightAttributes.Create(MWS_AttrSymbol);
  inherited Create(AOwner);

  AddAttribute(fCommentAttri);
  AddAttribute(fIdentifierAttri);
  AddAttribute(fKeyAttri);
  AddAttribute(fSpaceAttri);
  AddAttribute(fMessageAttri);
  AddAttribute(fSymbolAttri);
  SetAttributesOnChange(DefHighlightChange);

  MakeMethodTables;
  fRange := rsUnknown;
  fDefaultFilter := MWS_FilterGalaxy;
end; { Create }

destructor TmkGalaxySyn.Destroy;
begin
  fKeyWords.Free;
  inherited Destroy;
end; { Destroy }

procedure TmkGalaxySyn.SetLine(NewValue: String; LineNumber:Integer);          
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end; { SetLine }

procedure TmkGalaxySyn.MessageStyleProc;
begin
  fTokenID := tkMessage;
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

  if (Run = 0) and (FLine[Run] = '@') then begin
    fRange := rsUnKnown;
    inc(Run);
  end else
    while FLine[Run] <> #0 do
      inc(Run);
end;

procedure TmkGalaxySyn.PointCommaProc;                                         
begin
  fTokenID := tkComment;
  fRange := rsUnknown;
  inc(Run);
  while FLine[Run] <> #0 do begin
    fTokenID := tkComment;
    inc(Run);
  end;
end;

procedure TmkGalaxySyn.CRProc;
begin
  fTokenID := tkSpace;
  Case FLine[Run + 1] of
    #10: inc(Run, 2);
  else inc(Run);
  end;
end;

procedure TmkGalaxySyn.IdentProc;
begin
  while Identifiers[fLine[Run]] do inc(Run);
  if IsKeyWord(GetToken) then fTokenId := tkKey else fTokenId := tkIdentifier;
end;

procedure TmkGalaxySyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TmkGalaxySyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TmkGalaxySyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkSpace;
  while FLine[Run] in [#1..#9, #11, #12, #14..#32] do inc(Run);
end;

procedure TmkGalaxySyn.StringProc;
begin
  if (Run = 0) and (fTokenID <> tkMessage) then begin
    fTokenID := tkMessage;
    fRange := rsMessageStyle;
  end;
  inc(Run);
end;

procedure TmkGalaxySyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnKnown;
end;

procedure TmkGalaxySyn.Next;
begin
  fTokenPos := Run;
  Case fRange of
    rsMessageStyle: MessageStyleProc;
  else fProcTable[fLine[Run]];
  end;
end;

function TmkGalaxySyn.GetEol: Boolean;
begin
  Result := fTokenId = tkNull;
end;

function TmkGalaxySyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

function TmkGalaxySyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TmkGalaxySyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TmkGalaxySyn.GetTokenAttribute: TmwHighLightAttributes;
begin
  case fTokenID of
    tkComment: Result := fCommentAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkSpace: Result := fSpaceAttri;
    tkMessage: Result := fMessageAttri;
    tkUnknown: Result := fSymbolAttri;
    else Result := nil;
  end;
end;

function TmkGalaxySyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TmkGalaxySyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

procedure TmkGalaxySyn.ReSetRange;
begin
  fRange := rsUnknown;
end;

procedure TmkGalaxySyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

procedure TmkGalaxySyn.SetKeyWords(const Value: TStrings);
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

function TmkGalaxySyn.GetLanguageName: string;
begin
  Result := MWS_LangGalaxy;
end;

function TmkGalaxySyn.LoadFromRegistry(RootKey: HKEY; Key: string): boolean;
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

function TmkGalaxySyn.SaveToRegistry(RootKey: HKEY; Key: string): boolean;     
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

procedure TmkGalaxySyn.ExportNext;
begin
  fTokenPos := Run;
  Case fRange of
    rsMessageStyle: MessageStyleProc;
  else fProcTable[fLine[Run]];
  end;
  if Assigned(Exporter) then
    with TmwCustomExport(Exporter) do begin
      Case GetTokenID of
        tkComment: FormatToken(GetToken, fCommentAttri, True,False);
        tkIdentifier:FormatToken(GetToken, fIdentifierAttri, False,False);
        tkKey:FormatToken(GetToken, fKeyAttri, False,False);
        {Needed to catch Line breaks}
        tkNull:FormatToken('', nil, False,False);
        tkSpace:FormatToken(GetToken, fSpaceAttri, False,True);
        tkMessage:FormatToken(GetToken, fMessageAttri, True,False);
        tkUnknown:FormatToken(GetToken, fSymbolAttri, True,False);
      end;
    end; //with
end;

procedure TmkGalaxySyn.SetLineForExport(NewValue: String);
begin
  fLine := PChar(NewValue);
  Run := 0;
  ExportNext;
end;

function TmkGalaxySyn.GetCapability: THighlighterCapability;
begin
  Result := inherited GetCapability + [hcExportable];
end;

Initialization
  MakeIdentTable;
end.

