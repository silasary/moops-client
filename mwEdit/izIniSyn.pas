{+-----------------------------------------------------------------------------+
 | Class:       TizIniSyn
 | Created:     1999-11-02
 | Last change: 1999-11-07
 | Author:      Igor P. Zenkov
 | Description: INI Files Syntax Highliter
 |
 | Version:     0.4 (for version history see version.rtf)
 | Copyright:   (c) 1999 Igor P. Zenkov
 |              No rights reserved.
 |
 | Thanks to:   Primoz Gabrijelcic, Martin Waldenburg and Michael Hieke
 |
 | Notes:       This code is based on lbVBSSyn.pas Highliter
 +--------------------------------------------------------------------------+}

unit izIniSyn;

{$I mwEdit.inc}

interface

uses
  Classes,        // TComponent
  Graphics,       // fsItalic
  mwHighlighter,  // TmwCustomHighLighter
  mwLocalStr;     // string constants

type
  TtkTokenKind = (
    tkComment,
    tkText,
    tkSection,
    tkKey,
    tkNull,
    tkNumber,
    tkSpace,
    tkString,
    tkSymbol,
    tkUnknown);

  TRangeState = (rsANil, rsUnKnown);

  TProcTableProc = procedure of object;

type
  TizIniSyn = class(TmwCustomHighLighter)
  private
    fRange: TRangeState;
    fLine: PChar;
    fLineNumber: Integer;
    fProcTable: array[#0..#255] of TProcTableProc;
    Run: LongInt;
    fTokenPos: Integer;
    FTokenID: TtkTokenKind;
    fCommentAttri: TmwHighLightAttributes;
    fTextAttri: TmwHighLightAttributes;
    fSectionAttri: TmwHighLightAttributes;
    fKeyAttri: TmwHighLightAttributes;
    fNumberAttri: TmwHighLightAttributes;
    fSpaceAttri: TmwHighLightAttributes;
    fStringAttri: TmwHighLightAttributes;
    fSymbolAttri: TmwHighLightAttributes;

    procedure SectionOpenProc;
    procedure KeyProc;
    procedure CRProc;
    procedure EqualProc;
    procedure TextProc;
    procedure LFProc;
    procedure NullProc;
    procedure NumberProc;
    procedure SemiColonProc;
    procedure SpaceProc;
    procedure StringProc;  // ""
    procedure StringProc1; // ''
    procedure MakeMethodTables;
  protected
    {General Stuff}
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
    property LanguageName;
    property AttrCount;
    property Attribute;
    property Capability;
  published

    property CommentAttri: TmwHighLightAttributes read fCommentAttri write fCommentAttri;
    property TextAttri   : TmwHighLightAttributes read fTextAttri write fTextAttri;
    property SectionAttri: TmwHighLightAttributes read fSectionAttri write fSectionAttri;
    property KeyAttri    : TmwHighLightAttributes read fKeyAttri write fKeyAttri;
    property NumberAttri : TmwHighLightAttributes read fNumberAttri write fNumberAttri;
    property SpaceAttri  : TmwHighLightAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri : TmwHighLightAttributes read fStringAttri write fStringAttri;
    property SymbolAttri : TmwHighLightAttributes read fSymbolAttri write fSymbolAttri;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents(MWS_HighlightersPage, [TizIniSyn]);
end;

procedure TizIniSyn.MakeMethodTables;
var
  i: Char;
begin
  for i := #0 to #255 do
    case i of
      #0      : fProcTable[i] := NullProc;
      #10 {LF}: fProcTable[i] := LFProc;
      #13 {CR}: fProcTable[i] := CRProc;
      #34 {"} : fProcTable[i] := StringProc;
      #39 {'} : fProcTable[i] := StringProc1;
      '0'..'9': fProcTable[i] := NumberProc;
      #59 {;} : fProcTable[i] := SemiColonProc;
      #61 {=} : fProcTable[i] := EqualProc;
      #91 {[} : fProcTable[i] := SectionOpenProc;
      #1..#9, #11, #12, #14..#32: fProcTable[i] := SpaceProc;
    else
      fProcTable[i] := TextProc;
    end;
end;

constructor TizIniSyn.Create(AOwner: TComponent);
begin
  fCommentAttri            := TmwHighLightAttributes.Create(MWS_AttrComment);
  fCommentAttri.Style      := [fsItalic];
  fCommentAttri.Foreground := clGreen;
  fTextAttri               := TmwHighLightAttributes.Create(MWS_AttrText);
  fSectionAttri            := TmwHighLightAttributes.Create(MWS_AttrSection);
  fSectionAttri.Style      := [fsBold];
  fKeyAttri                := TmwHighLightAttributes.Create(MWS_AttrKey);
  fNumberAttri             := TmwHighLightAttributes.Create(MWS_AttrNumber);
  fSpaceAttri              := TmwHighLightAttributes.Create(MWS_AttrSpace);
  fStringAttri             := TmwHighLightAttributes.Create(MWS_AttrString);
  fSymbolAttri             := TmwHighLightAttributes.Create(MWS_AttrSymbol);

  inherited Create(AOwner);

  AddAttribute(fCommentAttri);
  AddAttribute(fTextAttri);
  AddAttribute(fSectionAttri);
  AddAttribute(fKeyAttri);
  AddAttribute(fNumberAttri);
  AddAttribute(fSpaceAttri);
  AddAttribute(fStringAttri);
  AddAttribute(fSymbolAttri);
  SetAttributesOnChange(DefHighlightChange);

  fRange              := rsUnknown;
  fDefaultFilter      := MWS_FilterINI;

  MakeMethodTables;
end; { Create }

procedure TizIniSyn.SetLine(NewValue: String; LineNumber:Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end; { SetLine }

procedure TizIniSyn.SectionOpenProc;
begin
  // if it is not column 0 mark as tkText and get out of here
  if Run > 0 then
  begin
    fTokenID := tkText;
    inc(Run);
    Exit;
  end;

  // this is column 0 ok it is a Section
  fTokenID := tkSection;
  inc(Run);
  while FLine[Run] <> #0 do
    case FLine[Run] of
      ']': begin inc(Run); break end;
      #10: break;
      #13: break;
    else inc(Run);
    end;
end;

procedure TizIniSyn.CRProc;
begin
  fTokenID := tkSpace;
  Case FLine[Run + 1] of
    #10: inc(Run, 2);
  else inc(Run);
  end;
end;

procedure TizIniSyn.EqualProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
end;

procedure TizIniSyn.KeyProc;
begin
  fTokenID := tkKey;
  inc(Run);
  while FLine[Run] <> #0 do
    case FLine[Run] of
      '=': break;
      #10: break;
      #13: break;
    else inc(Run);
    end;
end;

procedure TizIniSyn.TextProc;
begin
  if Run = 0 then
    KeyProc
  else begin
    fTokenID := tkText;
    inc(Run);
  end;
end;

procedure TizIniSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TizIniSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TizIniSyn.NumberProc;
begin
  if Run = 0 then
    KeyProc
  else begin
    inc(Run);
    fTokenID := tkNumber;
    while FLine[Run] in ['0'..'9', '.', 'e', 'E'] do inc(Run);
  end;
end;

// ;
procedure TizIniSyn.SemiColonProc;
begin
  // if it is not column 0 mark as tkText and get out of here
  if Run > 0 then
  begin
    fTokenID := tkText;
    inc(Run);
    Exit;
  end;

  // this is column 0 ok it is a comment
  fTokenID := tkComment;
  inc(Run);
  while FLine[Run] <> #0 do
    case FLine[Run] of
      #10: break;
      #13: break;
    else inc(Run);
    end;
end;

procedure TizIniSyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkSpace;
  while FLine[Run] in [#1..#9, #11, #12, #14..#32] do inc(Run);
end;

// ""
procedure TizIniSyn.StringProc;
begin
  fTokenID := tkString;
  if (FLine[Run + 1] = #34) and (FLine[Run + 2] = #34) then inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = #34;
  if FLine[Run] <> #0 then inc(Run);
end;

// ''
procedure TizIniSyn.StringProc1;
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

procedure TizIniSyn.Next;
begin
  fTokenPos := Run;
  fProcTable[fLine[Run]];
end;

function TizIniSyn.GetEol: Boolean;
begin
  Result := fTokenId = tkNull;
end;

function TizIniSyn.GetRange: Pointer;
begin
 Result := Pointer(fRange);
end;

function TizIniSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TizIniSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TizIniSyn.GetTokenAttribute: TmwHighLightAttributes;
begin
  case fTokenID of
    tkComment: Result := fCommentAttri;
    tkText   : Result := fTextAttri;
    tkSection: Result := fSectionAttri;
    tkKey    : Result := fKeyAttri;
    tkNumber : Result := fNumberAttri;
    tkSpace  : Result := fSpaceAttri;
    tkString : Result := fStringAttri;
    tkSymbol : Result := fSymbolAttri;
    tkUnknown: Result := fTextAttri;
    else Result := nil;
  end;
end;

function TizIniSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TizIniSyn.GetTokenPos: Integer;
begin
 Result := fTokenPos;
end;

procedure TizIniSyn.ReSetRange;
begin
  fRange:= rsUnknown;
end;

procedure TizIniSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TizIniSyn.GetCapability: THighlighterCapability;
begin
  Result := inherited GetCapability + [hcUserSettings];
end;

function TizIniSyn.GetIdentChars: TIdentChars;
begin
  Result := ['_', '0'..'9', 'a'..'z', 'A'..'Z'];
end;

function TizIniSyn.GetLanguageName: string;
begin
  Result := MWS_LangINI;
end;

end.
