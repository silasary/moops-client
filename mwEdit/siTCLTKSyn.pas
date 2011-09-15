{---------------------------------------------------------------------------
 TCL/TK Language Syntax Parser

 siTCLTKSyn was created as a plug in component for the Syntax Editor mwEdit
 created by Martin Waldenburg and friends.  For more information on the
 mwEdit project, see the following website:

 http://www.eccentrica.org/gabr/mw/mwedit.htm

 Copyright © 1999, Igor Shitikov.  All Rights Reserved.
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
{---------------------------------------------------------------------------
 Date last modified: 1999-10-27
{---------------------------------------------------------------------------}

{---------------------------------------------------------------------------
 TCL/TK Language Syntax Parser v0.85
{---------------------------------------------------------------------------
 Revision History:
 0.82:    * Primoz Gabrijelcic: Implemented OnToken event.
---------------------------------------------------------------------------}
unit siTCLTKSyn;

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
    tkUnknown,
    tkSecondKey);

  TRangeState = (rsANil, rsAnsi, rsPasStyle, rsCStyle, rsUnKnown);

  TProcTableProc = procedure of Object;

type
  TsiTCLTKSyn = class(TmwCustomHighLighter)
  private
    fRange: TRangeState;
    fLine: PChar;
    fProcTable: array[#0..#255] of TProcTableProc;
    Run: LongInt;
    fTokenPos: Integer;
    FTokenID: TtkTokenKind;
    fLineNumber: Integer;
    fStringAttri: TmwHighLightAttributes;
    fSymbolAttri: TmwHighLightAttributes;
    fKeyAttri: TmwHighLightAttributes;
    fSecondKeyAttri: TmwHighLightAttributes;
    fNumberAttri: TmwHighLightAttributes;
    fCommentAttri: TmwHighLightAttributes;
    fSpaceAttri: TmwHighLightAttributes;
    fIdentifierAttri: TmwHighLightAttributes;
    fKeyWords: TStrings;
    fSecondKeys: TStrings;
    procedure BraceOpenProc;
    procedure PointCommaProc;
    procedure CRProc;
    procedure IdentProc;
    procedure LFProc;
    procedure NullProc;
    procedure NumberProc;
    procedure RoundOpenProc;
    procedure SlashProc;
    procedure SpaceProc;
    procedure StringProc;
    procedure UnknownProc;
    procedure MakeMethodTables;
    procedure AnsiProc;
    procedure PasStyleProc;
    procedure CStyleProc;
    procedure SetKeyWords(const Value: TStrings);
    procedure SetSecondKeys(const Value: TStrings);
  protected
    function GetLanguageName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetEol: Boolean; override;
    function GetRange: Pointer; override;
    function GetTokenID: TtkTokenKind;
    function IsKeyWord(aToken: String): Boolean;
    function IsSecondKeyWord(aToken: String): Boolean;
    procedure SetLine(NewValue: String; LineNumber:Integer); override;
    function GetToken: String; override;
    function GetTokenAttribute: TmwHighLightAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    procedure Next; override;
    procedure SetRange(Value: Pointer); override;
    procedure ReSetRange; override;
    function SaveToRegistry(RootKey: HKEY; Key: string): boolean; override;
    function LoadFromRegistry(RootKey: HKEY; Key: string): boolean; override;
  published
    property CommentAttri: TmwHighLightAttributes read fCommentAttri write fCommentAttri;
    property IdentifierAttri: TmwHighLightAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TmwHighLightAttributes read fKeyAttri write fKeyAttri;
    property KeyWords: TStrings read fKeyWords write SetKeyWords;
    property SecondKeyAttri: TmwHighLightAttributes read fSecondKeyAttri
               write fSecondKeyAttri;
    property SecondKeyWords: TStrings read fSecondKeys write SetSecondKeys;
    property NumberAttri: TmwHighLightAttributes read fNumberAttri write fNumberAttri;
    property SpaceAttri: TmwHighLightAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri: TmwHighLightAttributes read fStringAttri write fStringAttri;
    property SymbolAttri: TmwHighLightAttributes read fSymbolAttri write fSymbolAttri;
  end;

procedure Register;

implementation

const
     TclTkKeysCount = 147;
     TclTkKeys: array[1..TclTkKeysCount] of string = (
                                                      'AFTER',
                                                      'APPEND',
                                                      'ARRAY',
                                                      'BELL',
                                                      'BGERROR',
                                                      'BINARY',
                                                      'BIND',
                                                      'BINDIDPROC',
                                                      'BINDPROC',
                                                      'BINDTAGS',
                                                      'BITMAP',
                                                      'BREAK',
                                                      'BUTTON',
                                                      'CANVAS',
                                                      'CATCH',
                                                      'CD',
                                                      'CHECKBUTTON',
                                                      'CLIPBOARD',
                                                      'CLOCK',
                                                      'CLOSE',
                                                      'CONCAT',
                                                      'CONTINUE',
                                                      'DESTROY',
                                                      'ELSE',
                                                      'ENTRY',
                                                      'EOF',
                                                      'ERROR',
                                                      'EVAL',
                                                      'EVENT',
                                                      'EXEC',
                                                      'EXIT',
                                                      'EXPR',
                                                      'FBLOCKED',
                                                      'FCONFIGURE',
                                                      'FCOPY',
                                                      'FILE',
                                                      'FILEEVENT',
                                                      'FILENAME',
                                                      'FLUSH',
                                                      'FOCUS',
                                                      'FONT',
                                                      'FOR',
                                                      'FOREACH',
                                                      'FORMAT',
                                                      'FRAME',
                                                      'GETS',
                                                      'GLOB',
                                                      'GLOBAL',
                                                      'GRAB',
                                                      'GRID',
                                                      'HISTORY',
                                                      'HTTP',
                                                      'IF',
                                                      'IMAGE',
                                                      'INCR',
                                                      'INFO',
                                                      'INTERP',
                                                      'JOIN',
                                                      'LABEL',
                                                      'LAPPEND',
                                                      'LIBRARY',
                                                      'LINDEX',
                                                      'LINSERT',
                                                      'LIST',
                                                      'LISTBOX',
                                                      'LLENGTH',
                                                      'LOAD',
                                                      'LOADTK',
                                                      'LOWER',
                                                      'LRANGE',
                                                      'LREPLACE',
                                                      'LSEARCH',
                                                      'LSORT',
                                                      'MENU',
                                                      'MESSAGE',
                                                      'NAMESPACE',
                                                      'NAMESPUPD',
                                                      'OPEN',
                                                      'OPTION',
                                                      'OPTIONS',
                                                      'PACK',
                                                      'PACKAGE',
                                                      'PHOTO',
                                                      'PID',
                                                      'PKG_MKINDEX',
                                                      'PLACE',
                                                      'PROC',
                                                      'PUTS',
                                                      'PWD',
                                                      'RADIOBUTTON',
                                                      'RAISE',
                                                      'READ',
                                                      'REGEXP',
                                                      'REGISTRY',
                                                      'REGSUB',
                                                      'RENAME',
                                                      'RESOURCE',
                                                      'RETURN',
                                                      'RGB',
                                                      'SAFEBASE',
                                                      'SCALE',
                                                      'SCAN',
                                                      'SEEK',
                                                      'SELECTION',
                                                      'SEND',
                                                      'SENDOUT',
                                                      'SET',
                                                      'SOCKET',
                                                      'SOURCE',
                                                      'SPLIT',
                                                      'STRING',
                                                      'SUBST',
                                                      'SWITCH',
                                                      'TCL',
                                                      'TCLVARS',
                                                      'TELL',
                                                      'TEXT',
                                                      'THEN',
                                                      'TIME',
                                                      'TK',
                                                      'TK_BISQUE',
                                                      'TK_CHOOSECOLOR',
                                                      'TK_DIALOG',
                                                      'TK_FOCUSFOLLOWSMOUSE',
                                                      'TK_FOCUSNEXT',
                                                      'TK_FOCUSPREV',
                                                      'TK_GETOPENFILE',
                                                      'TK_GETSAVEFILE',
                                                      'TK_MESSAGEBOX',
                                                      'TK_OPTIONMENU',
                                                      'TK_POPUP',
                                                      'TK_SETPALETTE',
                                                      'TKERROR',
                                                      'TKVARS',
                                                      'TKWAIT',
                                                      'TOPLEVEL',
                                                      'TRACE',
                                                      'UNKNOWN',
                                                      'UNSET',
                                                      'UPDATE',
                                                      'UPLEVEL',
                                                      'UPVAR',
                                                      'VARIABLE',
                                                      'VWAIT',
                                                      'WHILE',
                                                      'WINFO',
                                                      'WM');

procedure Register;
begin
  RegisterComponents(MWS_HighlightersPage, [TsiTCLTKSyn]);
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

function TsiTCLTKSyn.IsKeyWord(aToken: String): Boolean;
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

function TsiTCLTKSyn.IsSecondKeyWord(aToken: String): Boolean;
var
  First, Last, I, Compare: Integer;
  Token: String;
begin
  First := 0;
  Last := fSecondKeys.Count - 1;
  Result := False;
  Token := UpperCase(aToken);
  while First <= Last do
  begin
    I := (First + Last) shr 1;
    Compare := CompareStr(fSecondKeys[i], Token);
    if Compare = 0 then
    begin
      Result := True;
      break;
    end
    else
      if Compare < 0 then First := I + 1 else Last := I - 1;
  end;
end; { IsSecondKeyWord }

procedure TsiTCLTKSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      '#': fProcTable[I] := SlashProc{!@#$AsciiCharProc};
      '{': fProcTable[I] := BraceOpenProc;
      ';': fProcTable[I] := PointCommaProc;
      #13: fProcTable[I] := CRProc;
      'A'..'Z', 'a'..'z', '_': fProcTable[I] := IdentProc;
      #10: fProcTable[I] := LFProc;
      #0: fProcTable[I] := NullProc;
      '0'..'9': fProcTable[I] := NumberProc;
      '(': fProcTable[I] := RoundOpenProc;
      '/': fProcTable[I] := SlashProc;
      #1..#9, #11, #12, #14..#32: fProcTable[I] := SpaceProc;
      #34{!@#$#39}: fProcTable[I] := StringProc;
    else fProcTable[I] := UnknownProc;
    end;
end;

constructor TsiTCLTKSyn.Create(AOwner: TComponent);
var
   i: integer;
begin
  fKeyWords := TStringList.Create;
  TStringList(fKeyWords).Sorted := True;
  TStringList(fKeyWords).Duplicates := dupIgnore;
  fSecondKeys := TStringList.Create;
  TStringList(fSecondKeys).Sorted := True;
  TStringList(fSecondKeys).Duplicates := dupIgnore;
  for i := 1 to TclTkKeysCount do
    FKeyWords.Add(TclTkKeys[i]);
  fCommentAttri := TmwHighLightAttributes.Create(MWS_AttrComment);
  fCommentAttri.Style := [fsItalic];
  fIdentifierAttri := TmwHighLightAttributes.Create(MWS_AttrIdentifier);
  fKeyAttri := TmwHighLightAttributes.Create(MWS_AttrReservedWord);
  fKeyAttri.Style := [fsBold];
  fSecondKeyAttri := TmwHighLightAttributes.Create(MWS_AttrSecondReservedWord);
  fSecondKeyAttri.Style := [fsBold];
  fNumberAttri := TmwHighLightAttributes.Create(MWS_AttrNumber);
  fSpaceAttri := TmwHighLightAttributes.Create(MWS_AttrSpace);
  fStringAttri := TmwHighLightAttributes.Create(MWS_AttrString);
  fSymbolAttri := TmwHighLightAttributes.Create(MWS_AttrSymbol);
  inherited Create(AOwner);
  fDefaultFilter := MWS_FilterTclTk;

  AddAttribute(fCommentAttri);
  AddAttribute(fIdentifierAttri);
  AddAttribute(fKeyAttri);
  AddAttribute(fSecondKeyAttri);
  AddAttribute(fNumberAttri);
  AddAttribute(fSpaceAttri);
  AddAttribute(fStringAttri);
  AddAttribute(fSymbolAttri);
  SetAttributesOnChange(DefHighlightChange);

  MakeMethodTables;
  fRange := rsUnknown;
end; { Create }

destructor TsiTCLTKSyn.Destroy;
begin
  fKeyWords.Free;
  fSecondKeys.Free;
  inherited Destroy;
end; { Destroy }

procedure TsiTCLTKSyn.SetLine(NewValue: String; LineNumber:Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end; { SetLine }

procedure TsiTCLTKSyn.AnsiProc;
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

procedure TsiTCLTKSyn.PasStyleProc;
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

procedure TsiTCLTKSyn.CStyleProc;
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

procedure TsiTCLTKSyn.BraceOpenProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
end;

procedure TsiTCLTKSyn.PointCommaProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
end;

procedure TsiTCLTKSyn.CRProc;
begin
  fTokenID := tkSpace;
  Case FLine[Run + 1] of
    #10: inc(Run, 2);
  else inc(Run);
  end;
end;

procedure TsiTCLTKSyn.IdentProc;
begin
  while Identifiers[fLine[Run]] do inc(Run);
  if IsKeyWord(GetToken) then begin
    fTokenId := tkKey;
    Exit;
  end
  else fTokenId := tkIdentifier;
  if IsSecondKeyWord(GetToken)
    then fTokenId := tkSecondKey
    else fTokenId := tkIdentifier;
end;

procedure TsiTCLTKSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TsiTCLTKSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TsiTCLTKSyn.NumberProc;
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

procedure TsiTCLTKSyn.RoundOpenProc;
begin
  inc(Run);
  fTokenId := tkSymbol;
end;

procedure TsiTCLTKSyn.SlashProc;
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
        inc(Run);
        fTokenId := tkSymbol;
      end;
  else
    begin
      fTokenID := tkComment;
      while FLine[Run] <> #0 do
      begin
        case FLine[Run] of
          #10, #13: break;
        end;
        inc(Run);
      end;
    end;
  end;
end;

procedure TsiTCLTKSyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkSpace;
  while FLine[Run] in [#1..#9, #11, #12, #14..#32] do inc(Run);
end;

procedure TsiTCLTKSyn.StringProc;
begin
  fTokenID := tkString;
  if (FLine[Run + 1] = #34{!@#$#39}) and (FLine[Run + 2] = #34{!@#$#39})
    then inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = #34;
  if FLine[Run] <> #0 then inc(Run);
end;

procedure TsiTCLTKSyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnKnown;
end;

procedure TsiTCLTKSyn.Next;
begin
  fTokenPos := Run;
  Case fRange of
    rsAnsi: AnsiProc;
    rsPasStyle: PasStyleProc;
    rsCStyle: CStyleProc;
  else fProcTable[fLine[Run]];
  end;
end;

function TsiTCLTKSyn.GetEol: Boolean;
begin
  Result := False;
  if fTokenId = tkNull then Result := True;
end;

function TsiTCLTKSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

function TsiTCLTKSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TsiTCLTKSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TsiTCLTKSyn.GetTokenAttribute: TmwHighLightAttributes;
begin
  case fTokenID of
    tkComment: Result := fCommentAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkSecondKey: Result := fSecondKeyAttri;
    tkNumber: Result := fNumberAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
    tkSymbol: Result := fSymbolAttri;
    tkUnknown: Result := fSymbolAttri;
    else Result := nil;
  end;
end;

function TsiTCLTKSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TsiTCLTKSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

procedure TsiTCLTKSyn.ReSetRange;
begin
  fRange := rsUnknown;
end;

procedure TsiTCLTKSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

procedure TsiTCLTKSyn.SetKeyWords(const Value: TStrings);
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

procedure TsiTCLTKSyn.SetSecondKeys(const Value: TStrings);
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
  fSecondKeys.Assign(Value);
  DefHighLightChange(nil);
end;

function TsiTCLTKSyn.GetLanguageName: string;
begin
  Result := MWS_LangTclTk;
end;

function TsiTCLTKSyn.LoadFromRegistry(RootKey: HKEY; Key: string): boolean;
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

function TsiTCLTKSyn.SaveToRegistry(RootKey: HKEY; Key: string): boolean;     
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

Initialization
  MakeIdentTable;
end.

