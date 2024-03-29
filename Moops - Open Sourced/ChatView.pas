unit ChatView;

interface

uses
  Windows, Forms, Classes, Controls, Messages, Graphics, SysUtils, mwCustomEdit;

const
  cvNone      = -1;
  cvBlack     = 0;
  cvMaroon    = 1;
  cvGreen     = 2;
  cvOlive     = 3;
  cvNavy      = 4;
  cvPurple    = 5;
  cvTeal      = 6;
  cvGray      = 7;
  cvSilver    = 8;
  cvRed       = 9;
  cvLime      = 10;
  cvYellow    = 11;
  cvBlue      = 12;
  cvFuchsia   = 13;
  cvAqua      = 14;
  cvWhite     = 15;
  cvHighColor = 8;
  cvLowColor  = 7;
  cvBlink     = 128;

  cvNormalFg: Byte = cvGray;
  cvNormalBg: Byte = cvBlack;

  SymbolSet: set of Char = [' ','-'(*,'.',',','!','-',')','}',']',':',';','>'*)];

  MaxLineLen: Integer = 1000;

type
  TColorTable = array[0..15] of TColor;
  TFollowMode = (cfOff, cfOn, cfAuto);
  TmwChatView = class(TmwCustomEdit)
  private
    fFollowMode: TFollowMode;
    fColorTable: TColorTable;
    fMaxLines: Integer;
  public
    WordWrap: Integer;
    AnsiColors: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoColor(Fg, Bk: Byte);
    procedure DoBlink(BlinkOn: Boolean);
    procedure SetColor(Nr: Byte; Color: TColor);
    procedure AddLine(S: string);
    procedure UserActivity;
    procedure ScrollPageUp;
    procedure ScrollPageDown;
    property ColorTable: TColorTable read fColorTable write fColorTable;
  published
    property FollowMode: TFollowMode read fFollowMode write fFollowMode;
  end;

  TChatViewHL = class(TmwHighLighter)
  public
    constructor Create(AOwner: TComponent); override;
    function GetEOL: Boolean; override;
    function GetRange: Pointer; override;
    procedure SetLine(NewValue: String; LineNumber: Integer); override;
    function GetToken: string; override;
    function GetTokenAttribute: TmwHighLightAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    procedure Next; override;
    procedure SetRange(Value: Pointer); override;
    procedure ReSetRange; override;
    property CommentAttri: TmwHighLightAttributes read fCommentAttri write fCommentAttri;
  end;

function DoColor(Fg, Bk: Byte): string;

implementation

function DoColor(Fg, Bk: Byte): string;

begin
  Result:=#27'[0;';
  if Fg and cvHighColor>0 then Result:=Result+'1;';
  if Bk and cvBlink>0 then Result:=Result+'5;';
  Result:=Result+IntToStr((Fg and cvLowColor)+30)+';'+IntToStr((Bk and cvLowColor)+40)+'m';
end;

constructor TmwChatView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ReadOnly:=True;
  WordWrap:=1;
  AnsiColors:=True;
  fMaxLines:=500;
  Font.Name:='Courier New';
  Font.Size:=10;
  Font.Color:=fColorTable[cvNormalFg];
  Color:=fColorTable[cvNormalBg];
  RightEdge:=0;
  Gutter.Width:=0;
end;

destructor TmwChatView.Destroy;
begin
  inherited Destroy;
end;

procedure TmwChatView.DoColor(Fg, Bk: Byte);
begin

end;

procedure TmwChatView.DoBlink(BlinkOn: Boolean);
begin

end;

procedure TmwChatView.SetColor(Nr: Byte; Color: TColor);
begin
  fColorTable[Nr]:=Color;
end;

procedure TmwChatView.AddLine(S: string);
begin
  Lines.Add(S);
end;

procedure TmwChatView.UserActivity;
begin

end;

procedure TmwChatView.ScrollPageUp;
begin

end;

procedure TmwChatView.ScrollPageDown;
begin

end;

(*procedure TmwChatView.Clear;
begin

end;*)

end.
