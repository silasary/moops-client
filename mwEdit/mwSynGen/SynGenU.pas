{+--------------------------------------------------------------------------+
 | Unit:        SynGenU
 | Created:     12.98
 | Author:      Martin Waldenburg
 | Description: Generator for skeletons of HighLighters to use in mwEdit, drived by a simple grammar.
 | Version:     0.75 Beta
 | Copyright (c) 1998 Martin Waldenburg
 | All rights reserved.
 |
 | Version history:
 |   up to 0.7: source maintained by the autor, version history unknown
 |   0.71:
 |     - Stefan van As
 |       - Fixed bug with uses clause.
 |       - Modified/completed the following procedures: MakeIdentTable,
 |         Create, Destroy, SetLine, UnknownProc, Next, GetEol, GetTokenID,
 |         SetHighLightChange, GetIdentChars, GetAttribCount, GetAttribute,
 |         GetLanguageName, GetCapability, ExportNext.
 |       - Added the following procedures: Register, AssignAttributes.
 |   0.72:
 |     - Michael Hieke
 |       - Improved speed of scanning by declaring the KeyComp parameter as
 |         const. This removes the reference counting for this string parameter.
 |       - Removed OnToken event from the Next function.
 |       - Improved speed of the InitIdent procedure.
 |   0.73:
 |     - Stefan van As
 |       - Added AddAttribute for every attribute member to constructor. This
 |         inserts attribute objects to the mwHighLighter list that holds
 |         pointers to attributes.
 |       - Removed GetAttribCount and GetAttribute (these methods are obsolete
 |         now mwHighLighter enumerates the attributes).
 |       - Removed the attribute destructors and the overriden destructor (is
 |         obsolete now mwHighLighter frees the attributes).
 |       - Deleted the overriden attribute enumeration methods GetAttribCount
 |         and GetAttribute.
 |       - Removed HighLightChange and SetHighLightChange (these methods are
 |         obsolete now mwHighLighter uses DefHighLightChange
 |         and SetAttributesOnChange). Added call
 |         SetAttributesOnChange(DefHighLightChange) to constructor instead.
 |       - Added GetTokenKind method. Needed for mwHighLighter
 |         ScanAllLineTokens method.
 |       - Constructor uses string constants for attribute names as defined
 |         in mwLocalStr.
 |       - Removed obsolete fEOL field and simplified GetEOL method.
 |       - Removed everything related to the fCanvas member (fCanvas, SetCanvas)
 |       - Removed AssignAttributes and attributes assignment from Next method
 |       - Added GetTokenAttribute method (returns the token attribute for the
 |         current token).
 |   0.74:
 |     - Stefan van As
 |       - Uses attribute names, default filters and language names from
 |         mwLocalStr.pas
 |       - Added variable attribute name assignment for Identifier and
 |         Reserved word attributes.
 |       - Added variable attribute assignment for Unknown token.
 |     - Michael Hieke
 |       - Moved Identifiers and mHashTable variables into implemetation section
 |   0.75:
 |     - Michael Hieke
 |       - Added mwEdit.inc file to highlighter source.
 |       - Added PIdentFuncTableFunc type.
 |       - Minor changes to indentation and formatting of created source file.
 |       - Removed fRoundCount field of created highlighter.
 |       - Changed default palette name of created highlighter.
 |
 | LICENCE CONDITIONS
 |
 | USE OF THE ENCLOSED SOFTWARE
 | INDICATES YOUR ASSENT TO THE
 | FOLLOWING LICENCE CONDITIONS.
 |
 | These Licence Conditions are exlusively
 | governed by the Law and Rules of the
 | Federal Republic of Germany.
 |
 | Redistribution and use in source and binary form, with or without
 | modification, are permitted provided that the following conditions
 | are met:
 |
 | 1. Redistributions of source code must retain the above copyright
 |    notice, this list of conditions and the following disclaimer.
 |    If the source is modified, the complete original and unmodified
 |    source code has to distributed with the modified version.
 |
 | 2. Redistributions in binary form must reproduce the above
 |    copyright notice, these licence conditions and the disclaimer
 |    found at the end of this licence agreement in the documentation
 |    and/or other materials provided with the distribution.
 |
 | 3. Software using this code must contain a visible line of credit.
 |
 | 4. If my code is used in a "for profit" product, you have to donate
 |    to a registered charity in an amount that you feel is fair.
 |    You may use it in as many of your products as you like.
 |    Proof of this donation must be provided to the author of
 |    this software.
 |
 | 5. If you for some reasons don't want to give public credit to the
 |    author, you have to donate three times the price of your software
 |    product, or any other product including this component in any way,
 |    but no more than $500 US and not less than $200 US, or the
 |    equivalent thereof in other currency, to a registered charity.
 |    You have to do this for every of your products, which uses this
 |    code separately.
 |    Proof of this donations must be provided to the author of
 |    this software.
 |
 | 6. If you write your own grammars, then the results createt by mwSynGen
 |    are entirely yours.
 |    You don't need to make any donations however credit would be
 |    appreciated.
 |
 | DISCLAIMER:
 |
 | THIS SOFTWARE IS PROVIDED BY THE AUTHOR 'AS IS'.
 |
 | ALL EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 | THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 | PARTICULAR PURPOSE ARE DISCLAIMED.
 |
 | IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 | INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 | (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 | OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 | INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 | WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 | NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 | THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 |
 |  Martin.Waldenburg@T-Online.de
+--------------------------------------------------------------------------+}
unit SynGenU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, mGenLex, ExtCtrls;

var
  mKeyHashTable: array[#0..#255] of Integer;
  mSKeyHashTable: array[#0..#255] of Integer;

type
  TLexKeys = Class
  public
    KeyName: String;
    Key: Integer;
  end;

  TLexCharsets = Class
  public
    SetName: String;
    Charset: String;
    ProcData: String;
    FuncData: String;
  end;

  TGenFrm = class(TForm)
    BtnStart: TButton;
    OpenDialog: TOpenDialog;
    LblFilter: TLabel;
    LblLangName: TLabel;
    CboLangName: TComboBox;
    CboFilter: TComboBox;
    GrpAttrNames: TGroupBox;
    LblIdentifier: TLabel;
    CboAttrIdentifier: TComboBox;
    CboAttrReservedWord: TComboBox;
    LblReservedWord: TLabel;
    LblUnknownTokenAttr: TLabel;
    CboUnknownTokenAttr: TComboBox;
    Bevel1: TBevel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    HashedLabel: TLabel;
    procedure BtnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CboLangNameChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    LexName: String;
    IdentPre: String;
    IdentStart: String;
    IdentContent: String;
    OutFile: TextFile;
    Sensitivity: Boolean;
    Stream: TMemoryStream;
    Lex: TmwGenLex;
    KeyList: TList;
    SetList: TList;
    IdentList: TStringList;
    procedure MakeHashTable;
    procedure MakeSensitiveHashTable;
    procedure FillKeyList;
    procedure OutFileCreate(InName: String);
    procedure ParseCharsets;
    procedure RetriveCharset;
    function KeyHash(ToHash: String): Integer;
    function SensKeyHash(ToHash: String): Integer;
    procedure WriteRest;
  public
  end;

var
  GenFrm: TGenFrm;

implementation

{$R *.DFM}

function CompareKeys(Item1, Item2: Pointer): Integer;
begin
  Result := 0;
  if TLexKeys(Item1).Key < TLexKeys(Item2).Key then Result := -1 else
//    if TLexKeys(Item1).Key = TLexKeys(Item2).Key then Result := 0 else        //mh 1999-12-03
      if TLexKeys(Item1).Key > TLexKeys(Item2).Key then Result := 1;
end;

function CompareSets(Item1, Item2: Pointer): Integer;
begin
  Result := 0;
  if TLexCharsets(Item1).SetName < TLexCharsets(Item2).SetName then Result := -1 else
//    if TLexCharsets(Item1).SetName = TLexCharsets(Item2).SetName then Result := 0 else //mh 1999-12-03
      if TLexCharsets(Item1).SetName > TLexCharsets(Item2).SetName then Result := 1;
end;

procedure TGenFrm.MakeSensitiveHashTable;
var
  I: Char;
begin
  for I := #0 to #255 do
  begin
    Case I in ['_', 'A'..'Z', 'a'..'z'] of
      True:
        begin
          if (I > #64) and (I < #91) then mSKeyHashTable[I] := Ord(I) - 64 else
            if (I > #96) then mSKeyHashTable[I] := Ord(I) - 95;
        end;
    else mSKeyHashTable[I] := 0;
    end;
  end;
end;

procedure TGenFrm.MakeHashTable;
var
  I, J: Char;
begin
  for I := #0 to #255 do
  begin
    J := UpperCase(I)[1];
    Case I in ['_', 'A'..'Z', 'a'..'z'] of
      True: mKeyHashTable[I] := Ord(J) - 64;
    else mKeyHashTable[I] := 0;
    end;
  end;
  mKeyHashTable['.'] := 28;
end;

function TGenFrm.SensKeyHash(ToHash: String): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 1 to Length(ToHash) do
    inc(Result, mSKeyHashTable[ToHash[I]]);
end;

function TGenFrm.KeyHash(ToHash: String): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 1 to Length(ToHash) do
    inc(Result, mKeyHashTable[ToHash[I]]);
  Result:=Result and 127;
end;

procedure TGenFrm.FormCreate(Sender: TObject);
var i: Integer;
begin
  CboLangNameChange(Self);
  for i := GenFrm.ComponentCount - 1 downto 0 do
    if GenFrm.Components[i] is TComboBox then
      if TComboBox(GenFrm.Components[i]).Parent = GrpAttrNames then
      begin
        TComboBox(GenFrm.Components[i]).Items.Clear;
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrAssembler');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrAsm');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrComment');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrIdentifier');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrKey');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrNumber');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrOperator');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrPreprocessor');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrReservedWord');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrSpace');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrSymbol');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrString');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrText');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrAsmComment');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrAsmKey');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrASP');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrDocumentation');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrEscapeAmpersand');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrIllegalChar');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrInvalidSymbol');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrInternalFunction');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrMessage');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrNull');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrPragma');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrRpl');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrRplKey');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrRplComment');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrSecondReservedWord');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrSystemValue');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrUnknownWord');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrValue');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrVariable');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrIcon');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrBrackets');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrMiscellaneous');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrSystem');
        TComboBox(GenFrm.Components[i]).Items.Add('MWS_AttrUser');
      end;
  CboAttrIdentifier.ItemIndex := CboAttrIdentifier.Items.IndexOf('MWS_AttrIdentifier');
  CboAttrReservedWord.ItemIndex := CboAttrReservedWord.Items.IndexOf('MWS_AttrReservedWord');
  CboUnknownTokenAttr.ItemIndex := 0;
  Stream := TMemoryStream.Create;
  Lex := TmwGenLex.Create;
  KeyList := TList.Create;
  SetList := TList.Create;
  IdentList := TStringList.Create;
  MakeHashTable;
  MakeSensitiveHashTable;
end;

procedure TGenFrm.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  Lex.Free;
  Stream.Free;
  IdentList.Free;
  for I := 0 to KeyList.Count - 1 do TObject(KeyList[I]).Free;
  KeyList.Free;
  for I := 0 to SetList.Count - 1 do TObject(SetList[I]).Free;
  SetList.Free;
end;

procedure TGenFrm.BtnStartClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    Stream.Clear;
    Stream.LoadFromFile(OpenDialog.FileName);
    Lex.Origin := Stream.Memory;
    Lex.Tokenize;
    while Lex.RunId <> IDIdentifier do Lex.Next;
    LexName := Lex.RunToken;
    Lex.Next;
    while Lex.RunId <> IDIdentifier do Lex.Next;
    IdentPre := Lex.RunToken;
    OutFileCreate(OpenDialog.FileName);
    while not (Lex.RunId in [IdSensitive, IdIdentStart]) do Lex.Next;
    if Lex.RunId = IdSensitive then Sensitivity := True else Sensitivity := False;
    Lex.Next;
    while Lex.RunId <> IDCharSet do Lex.Next;
    IdentStart := Lex.RunToken;
    Lex.Next;
    while Lex.RunId <> IDCharSet do Lex.Next;
    IdentContent := Lex.RunToken;
    while Lex.RunId <> IDKeys do Lex.Next;
    FillKeyList;
    while Lex.RunId <> IDChars do Lex.Next;
    ParseCharsets;
    WriteRest;
    while Lex.RunId <> IdNull do
    begin
      Lex.Next;
    end;
    CloseFile(OutFile);
  end;
  Close;
end;

procedure TGenFrm.FillKeyList;
var
  aLexKey: TLexKeys;
  aString: String;
begin
  Lex.Next;
  while Lex.RunId <> IdStop do
  begin
    while Lex.RunId in [IdSpace, IdBraceOpen, IdCRLF] do Lex.Next;
    if Lex.RunId <> IdStop then
    begin
      aString:= '';
      while not (Lex.RunId in [IdSpace, IdBraceOpen, IdCRLF]) do
      begin
        aString:= aString + Lex.RunToken;
        Lex.Next;
      end;
      aLexKey := TLexKeys.Create;
      aLexKey.KeyName := aString;
      if Sensitivity then aLexKey.Key := SensKeyHash(aLexKey.KeyName) else
        aLexKey.Key := KeyHash(aLexKey.KeyName);
      KeyList.Add(aLexKey);
    end else break;
    Lex.Next;
  end;
  Lex.Next;
  while Lex.RunId <> IdStop do
  begin
    while Lex.RunId in [IdSpace, IdBraceOpen, IdCRLF, IDUnknown] do Lex.Next;
    if Lex.RunId <> IdStop then IdentList.Add(IdentPre + Lex.RunToken) else break;
    Lex.Next;
  end;
  KeyList.Sort(CompareKeys);
end;

procedure TGenFrm.OutFileCreate(InName: String);
var
  OutName, UName: String;
begin
  OutName := ExtractFileName(InName);
  Delete(OutName, Length(OutName) - 3, 4);
  Uname := OutName;
  OutName := OutName + '.pas';
  AssignFile(OutFile, OutName);
  rewrite(OutFile);
  Writeln(OutFile, 'unit ' + Uname + ';' + #13#10);
  Writeln(OutFile, '{$I mwEdit.inc}'#13#10);                                    //mh 1999-12-03
  Writeln(OutFile, 'interface' + #13#10);
  Writeln(OutFile, 'uses');
  Writeln(OutFile, '  SysUtils, Windows, Messages, Classes, Controls, Graphics, Registry,');
  Writeln(OutFile, '  mwHighlighter, mwExport, mwLocalStr;' + #13#10);
{begin}                                                                         //mh 1999-11-01
//  Writeln(OutFile, 'var');
//  Writeln(OutFile, '  Identifiers: array[#0..#255] of ByteBool;');
//  Writeln(OutFile, '  mHashTable: array[#0..#255] of Integer;' + #13#10);
{end}                                                                           //mh 1999-11-01
  Writeln(OutFile, 'Type');
  Writeln(OutFile, '  T' + IdentPre + 'TokenKind = (');
end;

procedure TGenFrm.ParseCharsets;
begin
  Lex.Next;
  while Lex.RunId <> IdStop do
  begin
    Case Lex.RunId of
      IdCharset: RetriveCharset;
    else Lex.Next;
    end;
  end;
end;

procedure TGenFrm.RetriveCharset;
var
  aSet: TLexCharsets;
begin
  aSet := TLexCharsets.Create;
  aSet.Charset := Lex.RunToken;
  while Lex.RunId <> IDIdentifier do Lex.Next;
  aSet.SetName := Lex.RunToken;
  while Lex.RunId <> IDBeginProc do Lex.Next;
  Lex.Next;
  while Lex.RunId in [IdCRLF, IdSpace]do Lex.Next;
  while not(Lex.RunId=IdEndProc)do
  begin
    aSet.ProcData:=aSet.ProcData+Lex.RunToken;
    Lex.Next;
  end;
  SetList.Add(aSet);
  Lex.Next;
end;

procedure TGenFrm.WriteRest;
var
  I                                                                 : Integer;
  KeyString, NameString, Space, Tags, AttrName, FilterName, LangName: string;
begin
  IdentList.Sort;
  SetList.Sort(CompareSets);
  I := 0;
  while I < IdentList.Count - 1 do
  begin
    Writeln(OutFile, '    ' + IdentList[I] + ',');
    inc(I);
  end;
  Writeln(OutFile, '    ' + IdentList[I] + ');');
  Writeln(OutFile, '');
  Writeln(OutFile, '  TRangeState = (rsUnknown);');
  Writeln(OutFile, '');
  Writeln(OutFile, '  TProcTableProc = procedure of Object;');
  Writeln(OutFile, '');
  Writeln(OutFile, '  PIdentFuncTableFunc = ^TIdentFuncTableFunc;');            //mh 1999-12-03
  Writeln(OutFile, '  TIdentFuncTableFunc = function: T' + IdentPre + 'TokenKind of Object;');
  Writeln(OutFile, '');
  Writeln(OutFile, 'type');
  Writeln(OutFile, '  ' + LexName + ' = class(TmwCustomHighLighter)');
  Writeln(OutFile, '  private');
  Writeln(OutFile, '    fRange: TRangeState;');
  Writeln(OutFile, '    fLine: PChar;');
  Writeln(OutFile, '    fLineNumber: Integer;');
  Writeln(OutFile, '    fExporter: TmwCustomExport;');
  Writeln(OutFile, '    fProcTable: array[#0..#255] of TProcTableProc;');
  Writeln(OutFile, '    Run: LongInt;');
//  Writeln(OutFile, '    fRoundCount: Integer;');                              //mh 1999-12-03
  Writeln(OutFile, '    fStringLen: Integer;');
  Writeln(OutFile, '    fToIdent: PChar;');
  Writeln(OutFile, '    fTokenPos: Integer;');
  Writeln(OutFile, '    FTokenID: TtkTokenKind;');
  KeyString := IntToStr(TLexKeys(KeyList[KeyList.Count - 1]).Key);
  Writeln(OutFile, '    fIdentFuncTable: array[0..' + KeyString + '] of TIdentFuncTableFunc;');

  I := 0;
  while I < IdentList.Count do
  begin
    if (IdentList[I] <> IdentPre + 'Null') and (IdentList[I] <> IdentPre + 'Unknown') then
      Writeln(OutFile, '    f' + Copy(IdentList[I], Length(IdentPre) + 1, Length(IdentList[I])) + 'Attri: TmwHighLightAttributes;');
    inc(I);
  end;

  Writeln(OutFile, '    function KeyHash(ToHash: PChar): Integer;');
  Writeln(OutFile, '    function KeyComp(const aKey: String): Boolean;');

  I := 0;
  while I < KeyList.Count do
  begin
    if I = 0 then
      Writeln(OutFile, '    function Func' + IntToStr(TLexKeys(KeyList[I]).Key) + ': T' + IdentPre + 'TokenKind;') else
      if (TLexKeys(KeyList[I - 1]).Key <> TLexKeys(KeyList[I]).Key) then
        Writeln(OutFile, '    function Func' + IntToStr(TLexKeys(KeyList[I]).Key) + ': T' + IdentPre + 'TokenKind;');
    inc(I);
  end;

  I := 0;
  while I < SetList.Count do
  begin
    Writeln(OutFile, '    procedure ' + TLexCharsets(SetList[I]).SetName + 'Proc;');
    inc(I);
  end;

  Writeln(OutFile, '    procedure UnknownProc;');
  Writeln(OutFile, '    function AltFunc: T' + IdentPre + 'TokenKind;');
  Writeln(OutFile, '    procedure InitIdent;');
  Writeln(OutFile, '    function IdentKind(MayBe: PChar): T' + IdentPre + 'TokenKind;');
  Writeln(OutFile, '    procedure MakeMethodTables;');
  Writeln(OutFile, '  protected');
  Writeln(OutFile, '    function GetIdentChars: TIdentChars; override;');
  Writeln(OutFile, '    function GetLanguageName: string; override;');
  Writeln(OutFile, '    function GetCapability: THighlighterCapability; override;');
  Writeln(OutFile, '  public');
  Writeln(OutFile, '    constructor Create(AOwner: TComponent); override;');
  Writeln(OutFile, '    function GetEOL: Boolean; override;');
  Writeln(OutFile, '    function GetRange: Pointer; override;');
  Writeln(OutFile, '    function GetTokenID: TtkTokenKind;');
  Writeln(OutFile, '    procedure SetLine(NewValue: String; LineNumber: Integer); override;');
  Writeln(OutFile, '    procedure ExportNext; override;');
  Writeln(OutFile, '    procedure SetLineForExport(NewValue: String); override;');
  Writeln(OutFile, '    function GetToken: String; override;');
  Writeln(OutFile, '    function GetTokenAttribute: TmwHighLightAttributes; override;');
  Writeln(OutFile, '    function GetTokenKind: integer; override;');
  Writeln(OutFile, '    function GetTokenPos: Integer; override;');
  Writeln(OutFile, '    procedure Next; override;');
  Writeln(OutFile, '    procedure SetRange(Value: Pointer); override;');
  Writeln(OutFile, '    procedure ReSetRange; override;');
  Writeln(OutFile, '    property IdentChars;');
  Writeln(OutFile, '  published');

  I := 0;
  while I < IdentList.Count do
  begin
    if (IdentList[I] <> IdentPre + 'Null') and (IdentList[I] <> IdentPre + 'Unknown') then
      Writeln(OutFile, '    property ' + Copy(IdentList[I], Length(IdentPre) + 1, Length(IdentList[I]))
      + 'Attri: TmwHighLightAttributes read f' + Copy(IdentList[I], Length(IdentPre) + 1, Length(IdentList[I])) +
      'Attri write f' + Copy(IdentList[I], Length(IdentPre) + 1, Length(IdentList[I]))+ 'Attri;');
    inc(I);
  end;

  Writeln(OutFile, '    property Exporter:TmwCustomExport read FExporter write FExporter;');
  Writeln(OutFile, '  end;');
  Writeln(OutFile, '');
  Writeln(OutFile, 'procedure Register;');
  Writeln(OutFile, '');
  Writeln(OutFile, 'implementation');
  Writeln(OutFile, '');
  Writeln(OutFile, 'procedure Register;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  RegisterComponents(MWS_HighlightersPage, [' + LexName + ']);');
  Writeln(OutFile, 'end;'#13#10);
{begin}                                                                         //mh 1999-11-01
  Writeln(OutFile, 'var');
  Writeln(OutFile, '  Identifiers: array[#0..#255] of ByteBool;');
  Writeln(OutFile, '  mHashTable: array[#0..#255] of Integer;'#13#10);
{end}                                                                           //mh 1999-11-01
  if Sensitivity then
  begin
    Writeln(OutFile, 'procedure MakeIdentTable;');
    Writeln(OutFile, 'var');
    Writeln(OutFile, '  I: Char;');
    Writeln(OutFile, 'begin');
    Writeln(OutFile, '  for I := #0 to #255 do');
    Writeln(OutFile, '  begin');
    Writeln(OutFile, '    Case I of');
    Writeln(OutFile, '      ' + IdentContent + ': Identifiers[I] := True;');
    Writeln(OutFile, '      else Identifiers[I] := False;');
    Writeln(OutFile, '    end;');
    Writeln(OutFile, '    Case I in [''_'', ''A''..''Z'', ''a''..''z''] of');
    Writeln(OutFile, '      True:');
    Writeln(OutFile, '        begin');
    Writeln(OutFile, '          if (I > #64) and (I < #91) then mHashTable[I] := Ord(I) - 64 else');
    Writeln(OutFile, '            if (I > #96) then mHashTable[I] := Ord(I) - 95;');
    Writeln(OutFile, '        end;');
    Writeln(OutFile, '      else mHashTable[I] := 0;');
    Writeln(OutFile, '    end;');
    Writeln(OutFile, '  end;');
    Writeln(OutFile, 'end;');
    Writeln(OutFile, '');
  end else
  begin
    Writeln(OutFile, 'procedure MakeIdentTable;');
    Writeln(OutFile, 'var');
    Writeln(OutFile, '  I, J: Char;');
    Writeln(OutFile, 'begin');
    Writeln(OutFile, '  for I := #0 to #255 do');
    Writeln(OutFile, '  begin');
    Writeln(OutFile, '    Case I of');
    Writeln(OutFile, '      ' + IdentContent + ': Identifiers[I] := True;');
    Writeln(OutFile, '      else Identifiers[I] := False;');
    Writeln(OutFile, '    end;');
    Writeln(OutFile, '    J := UpCase(I);');                                    //mh 1999-12-03
    Writeln(OutFile, '    Case I in [''_'', ''A''..''Z'', ''a''..''z''] of');
    Writeln(OutFile, '      True: mHashTable[I] := Ord(J) - 64');
    Writeln(OutFile, '      else mHashTable[I] := 0;');
    Writeln(OutFile, '    end;');
    Writeln(OutFile, '  end;');
    Writeln(OutFile, 'end;');
    Writeln(OutFile, '');
  end;

  Writeln(OutFile, 'procedure ' + LexName + '.InitIdent;');
  Writeln(OutFile, 'var');
  Writeln(OutFile, '  I: Integer;');
  Writeln(OutFile, '  pF: PIdentFuncTableFunc;');                               //mh 1999-12-03
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  pF := PIdentFuncTableFunc(@fIdentFuncTable);');           //mh 1999-12-03
  Writeln(OutFile, '  for I := Low(fIdentFuncTable) to High(fIdentFuncTable) do begin');
  Writeln(OutFile, '    pF^ := AltFunc;');
  Writeln(OutFile, '    Inc(pF);');
  Writeln(OutFile, '  end;');

  I := 0;
  while I < KeyList.Count do
  begin
    if I < KeyList.Count - 1 then
      while TLexKeys(KeyList[I]).Key = TLexKeys(KeyList[I + 1]).Key do
      begin
        inc(I);
        if I >= KeyList.Count - 1 then break;
      end;
    KeyString := IntToStr(TLexKeys(KeyList[I]).Key);
    Writeln(OutFile, '  fIdentFuncTable[' + KeyString + '] := Func' + KeyString + ';');
    inc(I);
  end;

  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'function ' + LexName + '.KeyHash(ToHash: PChar): Integer;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  Result := 0;');
  Writeln(OutFile, '  while ToHash^ in [' + IdentContent + '] do');
  Writeln(OutFile, '  begin');
  Writeln(OutFile, '    inc(Result, mHashTable[ToHash^]);');
  Writeln(OutFile, '    inc(ToHash);');
  Writeln(OutFile, '  end;');
  Writeln(OutFile, '  fStringLen := ToHash - fToIdent;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  if Sensitivity then
  begin
    Writeln(OutFile, 'function ' + LexName + '.KeyComp(const aKey: String): Boolean;');
    Writeln(OutFile, 'var');
    Writeln(OutFile, '  I: Integer;');
    Writeln(OutFile, '  Temp: PChar;');
    Writeln(OutFile, 'begin');
    Writeln(OutFile, '  Temp := fToIdent;');
    Writeln(OutFile, '  if Length(aKey) = fStringLen then');
    Writeln(OutFile, '  begin');
    Writeln(OutFile, '    Result := True;');
    Writeln(OutFile, '    for i := 1 to fStringLen do');
    Writeln(OutFile, '    begin');
    Writeln(OutFile, '      if Temp^ <> aKey[i] then');
    Writeln(OutFile, '      begin');
    Writeln(OutFile, '        Result := False;');
    Writeln(OutFile, '        break;');
    Writeln(OutFile, '      end;');
    Writeln(OutFile, '      inc(Temp);');
    Writeln(OutFile, '    end;');
    Writeln(OutFile, '  end else Result := False;');
    Writeln(OutFile, 'end;');
    Writeln(OutFile, '');
  end else
  begin
    Writeln(OutFile, 'function ' + LexName + '.KeyComp(const aKey: String): Boolean;');
    Writeln(OutFile, 'var');
    Writeln(OutFile, '  I: Integer;');
    Writeln(OutFile, '  Temp: PChar;');
    Writeln(OutFile, 'begin');
    Writeln(OutFile, '  Temp := fToIdent;');
    Writeln(OutFile, '  if Length(aKey) = fStringLen then');
    Writeln(OutFile, '  begin');
    Writeln(OutFile, '    Result := True;');
    Writeln(OutFile, '    for i := 1 to fStringLen do');
    Writeln(OutFile, '    begin');
    Writeln(OutFile, '      if mHashTable[Temp^] <> mHashTable[aKey[i]] then');
    Writeln(OutFile, '      begin');
    Writeln(OutFile, '        Result := False;');
    Writeln(OutFile, '        break;');
    Writeln(OutFile, '      end;');
    Writeln(OutFile, '      inc(Temp);');
    Writeln(OutFile, '    end;');
    Writeln(OutFile, '  end else Result := False;');
    Writeln(OutFile, 'end;');
    Writeln(OutFile, '');
  end;

  I := 0;
  while I < KeyList.Count do
  begin
    KeyString := IntToStr(TLexKeys(KeyList[I]).Key);
    Writeln(OutFile, 'function ' + LexName + '.Func' + KeyString + ': T' + IdentPre + 'TokenKind;');
    Writeln(OutFile, 'begin');
    KeyString := '';
    if I < KeyList.Count - 1 then
      while TLexKeys(KeyList[I]).Key = TLexKeys(KeyList[I + 1]).Key do
      begin
        NameString := TLexKeys(KeyList[I]).KeyName;
        Writeln(OutFile, KeyString + '  if KeyComp(' + #39 + NameString + #39 + ') then Result := ' + IdentPre + 'AsmInstr' + ' else');
        inc(I);
        KeyString := KeyString + '  ';
        if I >= KeyList.Count - 1 then break;
      end;
    NameString := TLexKeys(KeyList[I]).KeyName;
    Writeln(OutFile, KeyString + '  if KeyComp(' + #39 + NameString + #39 + ') then Result := ' + IdentPre + 'AsmInstr' + ' else Result := ' + IdentPre + 'Identifier;');
    Writeln(OutFile, 'end;');
    Writeln(OutFile, '');
    inc(I);
  end;

  Writeln(OutFile, 'function ' + LexName + '.AltFunc: T' + IdentPre + 'TokenKind;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  Result := ' + IdentPre + 'Identifier;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  KeyString := IntToStr(TLexKeys(KeyList[KeyList.Count - 1]).Key + 1);

  Writeln(OutFile, 'function ' + LexName + '.IdentKind(MayBe: PChar): T' + IdentPre + 'TokenKind;');
  Writeln(OutFile, 'var');
  Writeln(OutFile, '  HashKey: Integer;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  fToIdent := MayBe;');
  Writeln(OutFile, '  HashKey := KeyHash(MayBe);');
  Writeln(OutFile, '  if HashKey < ' + KeyString + ' then Result := fIdentFuncTable[HashKey] else Result := ' + IdentPre + 'Identifier;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'procedure ' + LexName + '.MakeMethodTables;');
  Writeln(OutFile, 'var');
  Writeln(OutFile, '  I: Char;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  for I := #0 to #255 do');
  Writeln(OutFile, '    case I of');

  I := 0;
  while I < SetList.Count do
  begin
    Writeln(OutFile, '      ' + TLexCharsets(SetList[I]).Charset + ': fProcTable[I] := '+
     TLexCharsets(SetList[I]).SetName+'Proc;');
    inc(I);
  end;

  Writeln(OutFile, '      else fProcTable[I] := UnknownProc;');
  Writeln(OutFile, '    end;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'constructor ' + LexName + '.Create(AOwner: TComponent);');
  Writeln(OutFile, 'begin');

  I := 0;
  while I < IdentList.Count do
  begin
    if Copy(IdentList[I], Length(IdentPre) + 1, Length(IdentList[I])) = 'Key' then
      AttrName := CboAttrReservedWord.Text
    else
      if Copy(IdentList[I], Length(IdentPre) + 1, Length(IdentList[I])) = 'Identifier' then
        AttrName := CboAttrIdentifier.Text
      else
        AttrName := 'MWS_Attr' + Copy(IdentList[I], Length(IdentPre) + 1, Length(IdentList[I]));
    if (IdentList[I] <> IdentPre + 'Null') and (IdentList[I] <> IdentPre + 'Unknown') then
      Writeln(OutFile, '  f' + Copy(IdentList[I], Length(IdentPre) + 1, Length(IdentList[I]))
      + 'Attri := TmwHighLightAttributes.Create(' + AttrName + ');');
    inc(I);
  end;

  Writeln(OutFile, '  inherited Create(AOwner);');

  I := 0;
  while I < IdentList.Count do
  begin
    if (IdentList[I] <> IdentPre + 'Null') and (IdentList[I] <> IdentPre + 'Unknown') then
      Writeln(OutFile, '  AddAttribute(f' + Copy(IdentList[I], Length(IdentPre) + 1, Length(IdentList[I]))
      + 'Attri);');
    inc(I);
  end;

  Writeln(OutFile, '  SetAttributesOnChange(DefHighlightChange);');
  Writeln(OutFile, '  InitIdent;');
  Writeln(OutFile, '  MakeMethodTables;');
  case CboFilter.ItemIndex of
    -1: FilterName := #39 + CboFilter.Text + #39;
    0 : FilterName := 'MWS_FilterPascal';
    1 : FilterName := 'MWS_FilterHP48';
    2 : FilterName := 'MWS_FilterCAClipper';
    3 : FilterName := 'MWS_FilterCPP';
    4 : FilterName := 'MWS_FilterJava';
    5 : FilterName := 'MWS_FilterPerl';
    6 : FilterName := 'MWS_FilterAWK';
    7 : FilterName := 'MWS_FilterHTML';
    8 : FilterName := 'MWS_FilterVBScript';
    9 : FilterName := 'MWS_FilterGalaxy';
    10: FilterName := 'MWS_FilterPython';
    11: FilterName := 'MWS_FilterSQL';
    12: FilterName := 'MWS_FilterHP';
    13: FilterName := 'MWS_FilterTclTk';
    14: FilterName := 'MWS_FilterRTF';
    15: FilterName := 'MWS_FilterBatch';
    16: FilterName := 'MWS_FilterDFM';
    17: FilterName := 'MWS_FilterX86Asm';
  end;
  Writeln(OutFile, '  fDefaultFilter := ' + FilterName + ';');
  Writeln(OutFile, '  fRange := rsUnknown;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'procedure ' + LexName + '.SetLine(NewValue: String; LineNumber: Integer);');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  fLine := PChar(NewValue);');
  Writeln(OutFile, '  Run := 0;');
  Writeln(OutFile, '  fLineNumber := LineNumber;');
  Writeln(OutFile, '  Next;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  I := 0;
  while I < SetList.Count do
  begin
    Writeln(OutFile, 'procedure '+LexName+'.'+TLexCharsets(SetList[I]).SetName+'Proc;');
    Writeln(OutFile, 'begin');
    Write(OutFile, '  '+TLexCharsets(SetList[I]).ProcData);
    Writeln(OutFile, 'end;');
    Writeln(OutFile, '');
    inc(I);
  end;

  Writeln(OutFile, 'procedure ' + LexName + '.UnknownProc;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  inc(Run);');
  Writeln(OutFile, '  fTokenID := ' + IdentPre + 'Unknown;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'procedure ' + LexName + '.Next;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  fTokenPos := Run;');
  Writeln(OutFile, '  fProcTable[fLine[Run]];');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'function ' + LexName + '.GetEOL: Boolean;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  Result := fTokenID = tkNull;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'function ' + LexName + '.GetRange: Pointer;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  Result := Pointer(fRange);');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'function ' + LexName + '.GetToken: String;');
  Writeln(OutFile, 'var');
  Writeln(OutFile, '  Len: LongInt;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  Len := Run - fTokenPos;');
  Writeln(OutFile, '  SetString(Result, (FLine + fTokenPos), Len);');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'function ' + LexName + '.GetTokenID: TtkTokenKind;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  Result := fTokenId;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'function ' + LexName + '.GetTokenAttribute: TmwHighLightAttributes;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  case GetTokenID of');

  I := 0;
  while I < IdentList.Count do
  begin
    if (IdentList[I] <> IdentPre + 'Null') and (IdentList[I] <> IdentPre + 'Unknown') then
      Writeln(OutFile, '    ' + IdentList[I] + ': Result := f' +
      Copy(IdentList[I], Length(IdentPre) + 1, Length(IdentList[I])) + 'Attri;');
    inc(I);
  end;
  Writeln(OutFile, '    ' + IdentPre + 'Unknown: Result := f' + CboUnknownTokenAttr.Text + 'Attri;');

  Writeln(OutFile, '    else Result := nil;');
  Writeln(OutFile, '  end;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'function ' + LexName + '.GetTokenKind: integer;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  Result := Ord(fTokenId);');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'function ' + LexName + '.GetTokenPos: Integer;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  Result := fTokenPos;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'procedure ' + LexName + '.ReSetRange;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  fRange := rsUnknown;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'procedure ' + LexName + '.SetRange(Value: Pointer);');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  fRange := TRangeState(Value);');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'function ' + LexName + '.GetIdentChars: TIdentChars;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  Result := [' + IdentContent + '];');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'function ' + LexName + '.GetLanguageName: string;');
  Writeln(OutFile, 'begin');
  case CboLangName.ItemIndex of
    -1: LangName := #39 + CboLangName.Text + #39;
    0 : LangName := 'MWS_LangHP48';
    1 : LangName := 'MWS_LangCAClipper';
    2 : LangName := 'MWS_LangCPP';
    3 : LangName := 'MWS_LangJava';
    4 : LangName := 'MWS_LangPerl';
    5 : LangName := 'MWS_LangBatch';
    6 : LangName := 'MWS_LangDfm';
    7 : LangName := 'MWS_LangAWK';
    8 : LangName := 'MWS_LangHTML';
    9 : LangName := 'MWS_LangVBSScript';
    10 : LangName := 'MWS_LangGalaxy';
    11 : LangName := 'MWS_LangGeneral';
    12 : LangName := 'MWS_LangPascal';
    13 : LangName := 'MWS_LangX86Asm';
    14 : LangName := 'MWS_LangPython';
    15 : LangName := 'MWS_LangTclTk';
    16 : LangName := 'MWS_LangSQL';
  end;
  Writeln(OutFile, '  Result := ' + LangName + ';');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'function ' + LexName + '.GetCapability: THighlighterCapability;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  Result := inherited GetCapability + [hcUserSettings, hcExportable];');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'procedure ' + LexName + '.SetLineForExport(NewValue: String);');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  fLine := PChar(NewValue);');
  Writeln(OutFile, '  Run := 0;');
  Writeln(OutFile, '  ExportNext;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'procedure ' + LexName + '.ExportNext;');
  Writeln(OutFile, 'begin');
  Writeln(OutFile, '  fTokenPos := Run;');
  Writeln(OutFile, '  fProcTable[fLine[Run]];');
  Writeln(OutFile, '  if Assigned(Exporter) then');
  Writeln(OutFile, '    Case GetTokenID of');

  I := 0;
  while I < IdentList.Count do
  begin
    if (IdentList[I] <> IdentPre + 'Null') and (IdentList[I] <> IdentPre + 'Unknown') then
    begin
      if (IdentList[I] = IdentPre + 'Space') then Space := 'True' else Space := 'False';
      if (IdentList[I] = IdentPre + 'Comment') or (IdentList[I] = IdentPre + 'String') or (IdentList[I] = IdentPre + 'Symbol') then Tags := 'True' else Tags := 'False';
      Writeln(OutFile, '      ' + IdentList[I] + ': TmwCustomExport(Exporter).FormatToken(GetToken, f' + Copy(IdentList[I], Length(IdentPre) + 1, Length(IdentList[I])) + 'Attri, ' + Tags + ', ' + Space + ');');
    end;
    inc(I);
  end;

  Writeln(OutFile, '    end;');
  Writeln(OutFile, 'end;');
  Writeln(OutFile, '');

  Writeln(OutFile, 'Initialization');
  Writeln(OutFile, '  MakeIdentTable;');
  Writeln(OutFile, 'end.');

end;

procedure TGenFrm.CboLangNameChange(Sender: TObject);
begin
  if (CboLangName.Text <> '') and (CboFilter.Text <> '') then
    BtnStart.Enabled := True
  else
    BtnStart.Enabled := False;
end;

procedure TGenFrm.Edit1Change(Sender: TObject);
begin
  HashedLabel.Caption:=IntToStr(KeyHash(Edit1.Text));
end;

end.