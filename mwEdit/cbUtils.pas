{+-----------------------------------------------------------------------------+
 | Unit:        cbUtils
 | Created:     12.98
 | Last change: 1999-10-28
 | Author:      Cyrille de Brebisson [cyrille_de-brebisson@aus.hp.com]
 | Description: fast string list class implementation
 | Version:     0.52
 | Copyright (c) 1998 Cyrille de Brebisson
 | All rights reserved.
 |
 | Thanks to: Primoz Gabrijelcic
 |
 | Version history:
 |   up to 0.5: source maintained by the autor, version history unknown
 |   0.51:
 |     - Primoz Gabrijelcic
 |       - Fixed code to compile with Delphi 2 and 3 (pretty much untested). 
 +----------------------------------------------------------------------------+}

{$IFOPT R+} {$DEFINE SetR} {$ELSE} {$UNDEF SetR} {$ENDIF}

unit cbUtils;

{$I mwEdit.inc}

interface

uses classes;

const
  NbSubList = 128;

Type
  TSpeedStringList = class;

  TSpeedListObject = class
  protected
    FName: String;
    FSpeedList: TSpeedStringList;
    fobject: tobject;
    procedure SetName(const Value: String); virtual;
  public
    Property Name: String read FName write SetName;
    constructor create(name: string);
    destructor destroy; override;
    property SpeedList: TSpeedStringList read FSpeedList write FSpeedList;
    property pointer: tobject read fobject write fobject;
  end;

  PSpeedListObjects = ^TSpeedListObjects;
  TSpeedListObjects = array [0..0] of TSpeedListObject;

  TSpeedStringList = class
  private
    function GetText: string;
    procedure SetText(const Value: string);
    function GetInObject(Index: Integer): TObject;
    procedure SetInObject(Index: Integer; const Value: TObject);
  Protected
    FOnChange: TNotifyEvent;
    SumOfUsed: array [0..NbSubList-1] of integer;
    datasUsed: array [0..NbSubList-1] of integer;
    datas: array [0..NbSubList-1] of PSpeedListObjects;
    lengthDatas: array [0..NbSubList-1] of integer;
    procedure Changed; virtual;
    function Get(Index: Integer): string; virtual;
    function GetObject(Index: Integer): TSpeedListObject;
    function GetCount: integer;
    Function GetStringList: TStrings;
    Procedure SetStringList(const value: TStrings);
  public
    Procedure NameChange(const obj: TSpeedListObject; const NewName: String);
    Procedure ObjectDeleted(const obj: TSpeedListObject);

    destructor Destroy; override;
    constructor create;
{$IFDEF MWE_COMPILER_4_UP}
    function Add(const Value: TSpeedListObject): Integer; overload;
    function Add(const Value: String): TSpeedListObject; overload;
{$ELSE}
    function AddObj(const Value: TSpeedListObject): Integer;
    function Add(const Value: String): TSpeedListObject;
{$ENDIF}
    procedure Clear;
    function Find(const name: String): TSpeedListObject;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Objects[Index: Integer]: TSpeedListObject read GetObject;
    property inobject[Index: Integer]: TObject read GetInObject Write SetInObject;
    property Strings[Index: Integer]: string read Get; default;
    property count: integer read GetCount;
    Property StringList: TStrings read GetStringList write SetStringList;
    property text: string read GetText write SetText;
  end;

implementation

function StringCrc(S: string): integer;
var
  i :integer;
begin
  result:=0;
  for i:=1 to length(s) do
  begin
    result:= (result shr 4) xor (((result xor ord(s[i])) and $F) * $1081);
    result:= (result shr 4) xor (((result xor (ord(s[i]) shr 4)) and $F) * $1081);
  end;
end;

{ TSpeedListObject }

{$R-}

constructor TSpeedListObject.create(name: string);
begin
  inherited create;
  FName:= name;
end;

destructor TSpeedListObject.destroy;
begin
  if FSpeedList<>nil then
    FSpeedList.ObjectDeleted(Self);
  inherited destroy;
end;

procedure TSpeedListObject.SetName(const Value: String);
begin
  FName := Value;
  if FSpeedList<>nil then
    FSpeedList.NameChange(Self, Value);
end;

{ TSpeedStringList }

{$IFDEF MWE_COMPILER_4_UP}
function TSpeedStringList.Add(const Value: TSpeedListObject): Integer;
{$ELSE}
function TSpeedStringList.AddObj(const Value: TSpeedListObject): Integer;
{$ENDIF}
var
  crc: integer;
  i: integer;
begin
  crc:= StringCrc(Value.Name) mod High(Datas)+1;
  if DatasUsed[crc]=lengthDatas[crc] then begin
    ReallocMem(datas[crc], (lengthDatas[crc]*2+1)*SizeOf(datas[1][0]));
    lengthDatas[crc] := lengthDatas[crc]*2+1;
  end;
  Datas[crc][DatasUsed[crc]]:= Value;
  result:= SumOfUsed[crc]+DatasUsed[crc];
  inc(DatasUsed[crc]);
  for i:= crc+1 to High(SumOfUsed) do
    inc(SumOfUsed[i]);
  Value.SpeedList:= Self;
end;

function TSpeedStringList.Add(const Value: String): TSpeedListObject;
begin
  result:= TSpeedListObject.Create(value);
{$IFDEF MWE_COMPILER_4_UP}
  Add(Result);
{$ELSE}
  AddObj(Result);
{$ENDIF}
end;

procedure TSpeedStringList.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TSpeedStringList.Clear;
var
  i, j: integer;
begin
  for i:= low(datas) to high(datas) do
  Begin
    for j:= 0{low(datas[i])} to DatasUsed[i]-1 do
      datas[i][j].free;
    datasUsed[i]:= 0;
    ReallocMem(datas[i],0);
    lengthDatas[i] := 0;
    SumOfUsed[i]:= 0;
  end;
  Changed;
end;

constructor TSpeedStringList.create;
var
  i: integer;
begin
  inherited Create;
  for i:= Low(Datas) to high(datas) do
  Begin
    SumOfUsed[i]:= 0;
    DatasUsed[i]:= 0;
    lengthDatas[i] := 0;
    datas[i] := nil;
  end;
end;

destructor TSpeedStringList.Destroy;
begin
  Clear;
  inherited destroy;
end;

function TSpeedStringList.Find(const name: String): TSpeedListObject;
var
  crc: integer;
  i: integer;
begin
  crc:= StringCrc(name) mod High(Datas)+1;
  for i:= 0 to DatasUsed[crc]-1 do
    if Datas[crc][i].name = name then
    Begin
      result:= Datas[crc][i];
      exit;
    end;
  result:= nil;
end;

function TSpeedStringList.Get(Index: Integer): string;
var
  i: integer;
begin
  for i:=low(SumOfUsed)+1 to High(SumOfUsed) do
    if Index>SumOfUsed[i] then
    Begin
      result:= Datas[i-1][Index-SumOfUsed[i-1]].name;
      exit;
    end;
  result:= '';
end;

function TSpeedStringList.GetCount: integer;
begin
  result:= SumOfUsed[High(datas)]+DatasUsed[High(Datas)];
end;

function TSpeedStringList.GetInObject(Index: Integer): TObject;
var
  i: integer;
begin
  for i:=low(SumOfUsed)+1 to High(SumOfUsed) do
    if Index>SumOfUSed[i] then
    Begin
      result:= Datas[i-1][Index-SumOfUsed[i-1]].pointer;
      exit;
    end;
  result:= nil;
end;

function TSpeedStringList.GetObject(Index: Integer): TSpeedListObject;
var
  i: integer;
begin
  for i:=low(SumOfUsed)+1 to High(SumOfUsed) do
    if Index>SumOfUSed[i] then
    Begin
      result:= Datas[i-1][Index-SumOfUsed[i-1]];
      exit;
    end;
  result:= nil;
end;

function TSpeedStringList.GetStringList: TStrings;
var
  i, j: integer;
begin
  result:= TStringList.Create;
  for i:= Low(Datas) to High(Datas) do
    for j:= 0{Low(Datas[i])} to DatasUsed[i]-1 do
      result.add(datas[i][j].name);
end;

function TSpeedStringList.GetText: string;
begin
  with StringList do
  Begin
    result:= Text;
    free;
  end;
end;

procedure TSpeedStringList.NameChange(const Obj: TSpeedListObject; const NewName: String);
var
  crc: integer;
  i: integer;
  j: integer;
begin
  crc:= StringCrc(obj.Name) mod High(Datas)+1;
  for i:= 0 to DatasUsed[crc]-1 do
    if Datas[crc][i] = Obj then
    Begin
      for j:= i+1 to DatasUsed[crc]-1 do
        Datas[i-1]:= Datas[i];
      for j:= crc+1 to High(Datas) do
        dec(SumOfUsed[j]);
      if DatasUsed[crc]<lengthDatas[crc] div 2 then begin
        ReallocMem(Datas[crc],DatasUsed[crc]*SizeOf(Datas[crc][0]));
        lengthDatas[crc] := DatasUsed[crc];
      end;
{$IFDEF MWE_COMPILER_4_UP}
  Add(Obj);
{$ELSE}
  AddObj(Obj);
{$ENDIF}
      exit;
    end;
end;

procedure TSpeedStringList.ObjectDeleted(const obj: TSpeedListObject);
var
  crc: integer;
  i: integer;
  j: integer;
begin
  crc:= StringCrc(obj.Name) mod High(Datas)+1;
  for i:= 0 to DatasUsed[crc]-1 do
    if Datas[crc][i] = Obj then
    Begin
      for j:= i+1 to DatasUsed[crc]-1 do
        Datas[i-1]:= Datas[i];
      for j:= crc+1 to High(Datas) do
        dec(SumOfUsed[j]);
      Obj.FSpeedList:= nil;
      exit;
    end;
end;

procedure TSpeedStringList.SetInObject(Index: Integer;
  const Value: TObject);
var
  i: integer;
begin
  for i:=low(SumOfUsed)+1 to High(SumOfUsed) do
    if Index>SumOfUSed[i] then
    Begin
      Datas[i-1][Index-SumOfUsed[i-1]].pointer:= value;
      exit;
    end;
end;

procedure TSpeedStringList.SetStringList(const value: TStrings);
var
  i: integer;
begin
  clear;
  for i:= 0 to Value.Count-1 do
{$IFDEF MWE_COMPILER_4_UP}
    Add(TSpeedListObject.Create(value[i]));
{$ELSE}
    AddObj(TSpeedListObject.Create(value[i]));
{$ENDIF}
end;

procedure TSpeedStringList.SetText(const Value: string);
var
  s: TStrings;
begin
  s:= TStringList.Create;
  try
    s.Text:= Value;
    StringList:= s;
  finally
    s.Free;
  end;
end;

end.
