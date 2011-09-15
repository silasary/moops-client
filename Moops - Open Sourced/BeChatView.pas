unit BeChatView;

interface

{DEFINE DEBUG}

uses
  Windows, Forms, Classes, Controls, Messages, Graphics, SysUtils, ExtCtrls, uTextDrawer,
  ClipBrd, ImgManager, IniFiles, Common, LinkParser {$IFDEF DEBUG}, MoopsDebug{$ENDIF};

const
  cvNone       = -1;
  cvBlack      = 0;
  cvMaroon     = 1;
  cvGreen      = 2;
  cvOlive      = 3;
  cvNavy       = 4;
  cvPurple     = 5;
  cvTeal       = 6;
  cvGray       = 7;
  cvSilver     = 8;
  cvRed        = 9;
  cvLime       = 10;
  cvYellow     = 11;
  cvBlue       = 12;
  cvFuchsia    = 13;
  cvAqua       = 14;
  cvWhite      = 15;
  cvNormal     = 16;
  cvNormalBold = 8;
  cvHighColor  = 8;
  cvLowColor   = 7+16;
  cvBlink      = 32;
  cvUnderline  = 64;
  cvReverse    = 128;
  cvNewLine    = 8192;
  cvNoWrap     = 16384;
  cvFastBg     = 32768;

  ColorNames: array[0..15] of string =
    ('Black','Maroon','Green','Olive','Navy','Purple','Teal','Gray',
     'Silver','Red','Lime','Yellow','Blue','Fuchsia','Aqua','White');

  SymbolSet: set of Char = [' ','-'];

  MaxLineLen: Integer = 1024;

  WM_MOUSEWHEEL = $020A;

type
  TLinkData = record
    IsLink: Boolean;
    LinkType: Byte;
    LinkData: string;
    LinkText: string;
    XPos, YPos: Integer;
    ActColor: Integer;
    //FontStyles: TFontStyles;
    //FgColor, BgColor: TColor;
  end;

  TColorTable = array[-1..15] of TColor;
  TFollowMode = (cfOff, cfOn, cfAuto);
  TLinkClickProc = procedure(Sender: TObject; LinkData: TLinkData; Button, X, Y: Integer) of object;

  TChatView = class(TCustomControl)
  private
    fTheImage: TBitmap;
    //fOrigImage: TImage;
    fImgData: PImageData;
    fHasImage: Boolean;
    fFontDummy: TFont;
    fTextDrawer: TheTextDrawer;
    fCharHeight: Integer;
    fCharWidth: Integer;
    fNeedScrollUpdate: Boolean;
    fHorizScrollBar: Boolean;
    fTopLine: Integer; // Number of first visible line
    fLeftChar: Integer;
    fLineCount: Integer; // Number of lines in window
    fWidthCount: Integer; // Width in characters
    fLines: TStringList;
    fIndentLen, fActIndentLen: Integer;
    fIndentText, fActIndentText: string;
    fFollowMode: TFollowMode;
    fSeenLine: Integer; // Used for UserActivity (Auto-Follow)
    fLastTime: TTimeStamp;
    fXOffset, fYOffset: Integer;
    fClientWidth: Integer;
    fClientHeight: Integer;
    fMaxLines: Integer;
    fBoldMode, fBgBoldMode, fBlinkMode, fUnderMode, fReverseMode: Byte;
    fNoWrapMode: Boolean;
    fBlinkOn: Byte; // 0 = paintall, 1 = paintnormal, 2 = painthidden

    fFgColor, fBkColor: Byte;
    fBlinkFont, fTransparentText, fFastBg: Boolean; // used by DoPaint
    fNormalFg, fNormalBg: TColor; // used for link 'backup'
    fNormalStyles, fActStyles: TFontStyles;
    fNormalBlink: Boolean;
    fInSelection: Boolean;
    fSelBoundary: Byte;
    fActFg, fActBg: TColor;
    fActColor: Integer;

    fFgColorTable: TColorTable;
    fBgColorTable: TColorTable;
    fUpdateLock: Integer;
    fMouseWheelAccumulator: integer;

    fHasSelection, fSelecting: Boolean;
    fAutoCopy: Boolean;
    fSelDown: TPoint; // position where selection started
    fSelStart: TPoint;
    fSelEnd: TPoint;
    fDisableSelect: Boolean;

    MMoveTimer: TTimer;
    fLastKeyState: Integer;
    fCurrentLD: TLinkData;

    procedure MMoveTimerTimer(Sender: TObject);
    procedure StartMMoveTimer(LastKeyState: Integer);
    procedure StopMMoveTimer;
    function HandleCode(Start: PChar): PChar;
    procedure PaintPart(Start, Stop: PChar; var SkipChars: Integer; var R: TRect; IsEOL: Boolean);
    procedure DoPaintLine(const S: string; var R: TRect);
    procedure PaintLine(Line, Location: Integer);
    procedure PaintLines(Start, Stop: Integer);
    procedure WMHScroll(var Message: TWMScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMScroll); message WM_VSCROLL;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
    procedure WMMouseWheel(var Msg: TMessage); message WM_MOUSEWHEEL;
    procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonDown(var Msg: TMessage); message WM_RBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TMessage); message WM_LBUTTONUP;
    procedure DrawLink(Active: Boolean; LD: TLinkData);
    procedure UpdateScrollBars;
    function GetColor: Integer;
    procedure SetAttrs(const S: string);
    function GetAnsiMode(S: string): string;
    procedure SetFontColor(C: Integer);
    procedure SetLinkColor(C: Integer);
    procedure DoScroll(LinesAdded: Integer);
    procedure DelLine(I: Integer);
    function IsAway: Boolean;
    procedure FontChange(Sender: TObject);
    procedure DoPaint;
    function WrapLine(const InitialData: Integer; const S: string): Integer; // returns number of lines added
    procedure ReWrapLines;
    function GetLinkData(X, Y: Integer): TLinkData;
    procedure SetSelEnd(X, Y: Integer);
    procedure UnSelect;
    procedure DoCopyToClipboard(const SText: string);
    procedure SetHorizScrollBar(Value: Boolean);
    procedure SetIndentText(const Value: string);
    procedure ParseLine(var S: string);
    function GetLineCount: Integer;
    function GetLineBytes: Integer;
  public
    AnsiColors: Integer; // 0 = raw data, 1 = filter out, 2 = enabled
    AutoAwayTime: Integer; // Time in seconds
    WordWrap: Integer;
    NormalFg, NormalBg: Integer;
    NormalFgBold, NormalBgBold: Integer;
    SelectionFg, SelectionBg: Integer;
    UseBoldFont: Boolean;
    BoldHighColor: Boolean;
    AllHighColors: Byte;
    StatusText: string;
    ScrollThrough: Boolean;
    ScrollLock: Boolean;
    EnableBlink, EnableBeep: Boolean;

    HttpLinkColor: Integer;
    ClntCmdColor: Integer;
    MooCmdColor: Integer;

    OnLinkClick: TLinkClickProc;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetStatus(const Msg: string);
    procedure SizeOrFontChanged;
    procedure Paint; override;
    procedure UserActivity; // Called when useractivity is detected (eg keypress)
    procedure AddLine(S: string);
    procedure AddLines(S: string);
    procedure SetTopLine(Value: Integer);
    procedure SetLeftChar(Value: Integer);
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Clear;
    procedure ChangeFont(AFont: TFont);
    procedure SetFgColor(Nr: Byte; Color: TColor);
    procedure SetBgColor(Nr: Byte; Color: TColor);
    procedure DoColor(Fg, Bk: Byte);
    procedure DoBlink(BlinkOn: Boolean);
    procedure ScrollPageUp;
    procedure ScrollPageDown;
    procedure SetImage(Name: string; ImgStyle: Integer; ImgOpacity: Integer);
    procedure CopyToClipBoard;
    {procedure LoadFromIni(IniFile: TIniFile);
    procedure SaveToIni(IniFile: TIniFile);}
    procedure ReInitImage;
    function  GetLineText(LineNr: Integer): string;
    procedure LoadFromIni(Ini: TIniFile);
    property TopLine: Integer read fTopLine write SetTopLine;
    property LeftChar: Integer read fLeftChar write SetLeftChar;
    property MaxLines: Integer read fMaxLines write fMaxLines;
    property FgColorTable: TColorTable read fFgColorTable write fFgColorTable;
    property BgColorTable: TColorTable read fBgColorTable write fBgColorTable;
    property LineLen: Integer read fWidthCount;
    property RowLen: Integer read fLineCount;
    property HorizScrollBar: Boolean read fHorizScrollBar write SetHorizScrollBar;
    property IndentText: string read fIndentText write SetIndentText;
    property ActLineCount: Integer read GetLineCount;
    property ActLineBytes: Integer read GetLineBytes;
    property CharHeight: Integer read fCharHeight;
    property CharWidth: Integer read fCharWidth;
  published
    property FollowMode: TFollowMode read fFollowMode write fFollowMode;
    property Font;
    property HasSelection: Boolean read fHasSelection;
    property AutoCopy: Boolean read fAutoCopy write fAutoCopy;
    property DisableSelect: Boolean read fDisableSelect write fDisableSelect;
    property OnMouseDown;
    property OnClick;
    property OnMouseMove;
    property OnMouseUp;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

const
  DefaultColorTable: TColorTable = (clNone,
                                    clBlack,clMaroon,clGreen,clOlive,clNavy,clPurple,clTeal,clGray,
                                    clSilver,clRed,clLime,clYellow,clBlue,clFuchsia,clAqua,clWhite);

function DoColor(Fg, Bg: Byte): string;
function DoColorEx(Fg, Bg: Byte; UnderLine, Blink: Boolean): string;

implementation

{uses
  MainFrm;}

function DoColor(Fg, Bg: Byte): string;
begin
  Result:=#27'[0;';
  if Fg and cvHighColor>0 then Result:=Result+'1;';
  if Bg and cvHighColor>0 then Result:=Result+'9;';
  if Fg and cvNormal=0 then Result:=Result+IntToStr((Fg and cvLowColor)+30)+';';
  if Bg and cvNormal=0 then Result:=Result+IntToStr((Bg and cvLowColor)+40)+';';
  Result:=Copy(Result,1,Length(Result)-1)+'m';
end;

function DoColorEx(Fg, Bg: Byte; UnderLine, Blink: Boolean): string;
begin
  Result:=#27'[0;';
  if Fg and cvHighColor>0 then Result:=Result+'1;';
  if Bg and cvHighColor>0 then Result:=Result+'9;';
  if Fg and cvNormal=0 then Result:=Result+IntToStr((Fg and cvLowColor)+30)+';';
  if Bg and cvNormal=0 then Result:=Result+IntToStr((Bg and cvLowColor)+40)+';';
  if Blink then Result:=Result+'5;';
  Result:=Copy(Result,1,Length(Result)-1)+'m';
end;

function StripLine(const S: string): string;
var
  P: Integer;
begin
  Result:=S;
  repeat
    P:=Pos(#254,Result);
    if P>0 then
      if Byte(Result[P+1]) and 128>0 then Delete(Result,P,3)
      else Delete(Result,P,Byte(Result[P+2]));
  until P=0;
end;

constructor TChatView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MMoveTimer:=nil;
  BoldHighColor:=False;
  fHasImage:=False;
  fAutoCopy:=True;
  ScrollThrough:=True;
  ScrollLock:=False;
  EnableBlink:=True;
  EnableBeep:=True;
  AnsiColors:=2;
  AutoAwayTime:=0;
  //AutoAwayTime:=10;
  fMaxLines:=1000;
  fTopLine:=0; fLeftChar:=0; fFollowMode:=cfAuto;
  fSeenLine:=0; fXOffset:=3; fYOffset:=0;

  UseBoldFont:=False;
  fFontDummy:=TFont.Create;
  fFontDummy.Name:='Courier New';
  fFontDummy.Size:=10;
  fFontDummy.CharSet:=DEFAULT_CHARSET;
  fTextDrawer:=TheTextDrawer.Create([fsBold], fFontDummy);
  Font.Assign(fFontDummy);

  AllHighColors:=0;
  fHorizScrollBar:=True;
  fNeedScrollUpdate:=True;
  fLines:=TStringList.Create;
  fUpdateLock:=0;
  NormalFg:=cvGray; NormalBg:=cvBlack;
  NormalFgBold:=cvWhite; NormalBgBold:=cvGray;
  fBoldMode:=0; fBgBoldMode:=0; fFgColor:=cvNormal; fBkColor:=cvNormal;
  fBlinkMode:=0; fUnderMode:=0;
  fReverseMode:=0;
  fFgColorTable:=DefaultColorTable;
  fBgColorTable:=fFgColorTable;
  Color:=BgColorTable[NormalBg];
  Font.Color:=FgColorTable[NormalFg];
  Font.OnChange:=FontChange;
  WordWrap:=1;
  fIndentText:=''; fActIndentText:=''; fIndentLen:=0; fActIndentLen:=0;
  fHasSelection:=False;
  fSelStart.X:=-1;
  fSelEnd.X:=-1;
  fSelStart.Y:=-1;
  fSelEnd.Y:=-1;
  fAutoCopy:=True;
  fDisableSelect:=False;
  SelectionFg:=cvBlack; SelectionBg:=cvGray;
  fImgData:=nil;
  fTheImage:=TBitmap.Create;

  HttpLinkColor:={cvUnderline or} cvNormal or (cvNormal shl 8);
  ClntCmdColor:={cvUnderline or} cvNormal or (cvNormal shl 8);
  MooCmdColor:={cvUnderline or} cvNormal or (cvNormal shl 8);

  StatusText:='';
  OnLinkClick:=nil;
  fCurrentLD.IsLink:=False;
end;

destructor TChatView.Destroy;
begin
  //ImgManager.
  SetImage('',0,0);
  fTheImage.Destroy;
  fLines.Free;
  fTextDrawer.Free;
  fFontDummy.Free;
  inherited Destroy;
end;

procedure TChatView.SetHorizScrollBar(Value: Boolean);
begin
  if Value=fHorizScrollBar then Exit;
  fHorizScrollBar:=Value;
  ShowScrollBar(Handle,SB_HORZ,Value);
end;

procedure TChatView.SetIndentText(const Value: string);
begin
  if Value=fIndentText then Exit;
  fIndentText:=Value; fIndentLen:=Length(fIndentText);
  RewrapLines;
  fActIndentText:=Value; fActIndentLen:=Length(fActIndentText);
end;

procedure TChatView.DoColor(Fg, Bk: Byte);
begin
  fBgBoldMode:=Bk and cvHighColor;
  fBoldMode:=Fg and cvHighColor;
  fFgColor:=Fg and cvLowColor;
  fBkColor:=Bk and cvLowColor;
  fUnderMode:=0; fReverseMode:=0; fBlinkMode:=0;
end;

procedure TChatView.SetFgColor(Nr: Byte; Color: TColor);
begin
  fFgColorTable[Nr]:=Color;
end;

procedure TChatView.SetBgColor(Nr: Byte; Color: TColor);
begin
  fBgColorTable[Nr]:=Color;
end;

procedure TChatView.Clear;
begin
  BeginUpdate;
  fLines.Clear; fSeenLine:=0; fTopLine:=0; fNeedScrollUpdate:=True;
  fHasSelection:=False;
  fSelStart.X:=-1;
  fSelEnd.X:=-1;
  fSelStart.Y:=-1;
  fSelEnd.Y:=-1;
  EndUpdate;
end;

procedure TChatView.BeginUpdate;
begin
  fLines.BeginUpdate;
  Inc(fUpdateLock);
end;

procedure TChatView.EndUpdate;
begin
  Dec(fUpdateLock);
  fLines.EndUpdate;
  if fUpdateLock=0 then Invalidate;
end;

function TChatView.IsAway: Boolean;
begin
  Result:=Int64(DateTimeToTimeStamp(Now))-Int64(fLastTime)>(AutoAwayTime*1000);
end;

procedure TChatView.UserActivity;
begin
  fLastTime:=DateTimeToTimeStamp(Now);
  fSeenLine:=fLines.Count-1;
end;

function TChatView.GetColor: Integer;
begin
  {if fReverseMode then
    Result:=(fFgColor shl 8) or fBkColor or fBlinkMode or fUnderMode
  else}
    Result:=(fBkColor shl 8) or fFgColor or fBlinkMode or fUnderMode or fReverseMode;
end;

procedure TChatView.SetAttrs(const S: string);
begin
  // Misc
  if S='0' then begin DoColor(cvNormal,cvNormal); end;
  if S='1' then begin fBoldMode:=cvHighColor; fFgColor:=fFgColor or fBoldMode; end;
  if S='4' then fUnderMode:=cvUnderline;
  if S='5' then fBlinkMode:=cvBlink;
  if S='7' then fReverseMode:=cvReverse;
  if S='9' then begin fBgBoldMode:=cvHighColor; fBkColor:=fBkColor or fBgBoldMode; end;
  // Foreground
  if S='30' then fFgColor:=cvBlack or fBoldMode;
  if S='31' then fFgColor:=cvMaroon or fBoldMode;
  if S='32' then fFgColor:=cvGreen or fBoldMode;
  if S='33' then fFgColor:=cvOlive or fBoldMode;
  if S='34' then fFgColor:=cvNavy or fBoldMode;
  if S='35' then fFgColor:=cvPurple or fBoldMode;
  if S='36' then fFgColor:=cvTeal or fBoldMode;
  if S='37' then fFgColor:=cvGray or fBoldMode;
  // Background
  if S='40' then fBkColor:=cvBlack or fBgBoldMode;
  if S='41' then fBkColor:=cvMaroon or fBgBoldMode;
  if S='42' then fBkColor:=cvGreen or fBgBoldMode;
  if S='43' then fBkColor:=cvOlive or fBgBoldMode;
  if S='44' then fBkColor:=cvNavy or fBgBoldMode;
  if S='45' then fBkColor:=cvPurple or fBgBoldMode;
  if S='46' then fBkColor:=cvTeal or fBgBoldMode;
  if S='47' then fBkColor:=cvGray or fBgBoldMode;
  // Special
  if S='50' then fNoWrapMode:=True;
end;

function TChatView.GetAnsiMode(S: string): string;
var
  P: Integer;
begin
  Result:='';
  repeat
    P:=Pos(';',S);
    if P>0 then
    begin
      SetAttrs(Copy(S,1,P-1));
      S:=Copy(S,P+1,Length(S));
    end;
  until P=0;
  SetAttrs(S);
  P:=GetColor;
  Result:=#254+Chr(128+(P shr 8))+Chr(P and $FF);
end;

procedure TChatView.DelLine(I: Integer);
begin
  if (I<0) or (I>=fLines.Count) then Exit;
  fLines.Delete(I);
  Dec(fSeenLine); if fSeenLine<0 then fSeenLine:=0;
  Dec(fTopLine); if fTopLine<0 then TopLine:=0;
  if fHasSelection or fSelecting then
  begin
    if I<=fSelStart.Y then Dec(fSelStart.Y);
    if fSelStart.Y<0 then begin fSelStart.Y:=0; fSelStart.X:=0; end;
    if I<=fSelEnd.Y then Dec(fSelEnd.Y);
    if fSelEnd.Y<0 then begin fSelEnd.Y:=0; fSelEnd.X:=0; end;
    if I<=fSelDown.Y then Dec(fSelDown.Y);
    if fSelDown.Y<0 then begin fSelDown.Y:=0; fSelDown.X:=0; end;
    fHasSelection:=(fSelStart.X<>fSelEnd.X) or (fSelStart.Y<>fSelEnd.Y);
    if not fHasSelection then
    begin
      fSelStart.X:=-1;
      fSelEnd.X:=-1;
      fSelStart.Y:=-1;
      fSelEnd.Y:=-1;
    end;
  end;
  if fCurrentLD.IsLink then
    if I=fCurrentLD.YPos then fCurrentLD.IsLink:=False
    else if I<fCurrentLD.YPos then Dec(fCurrentLD.YPos);
end;

function TChatView.WrapLine(const InitialData: Integer; const S: string): Integer;
var
  LineStart, LineStop, LineBreak, L: PChar;
  ActLineColor, NewLineColor, CurrentColor, LineLen, FastBg: Integer;
  TempStr: string;
  LinkMode: Boolean;
begin
  if InitialData and cvNoWrap>0 then begin Result:=1; fLines.AddObject(S,TObject(InitialData or cvNewLine)); Exit; end;
  Result:=1;
  LineStart:=@S[1]; LineStop:=LineStart; L:=LineStart+Length(S); LineLen:=0;
  ActLineColor:=InitialData and (not (cvNewLine or cvFastBg)); CurrentColor:=ActLineColor; NewLineColor:=ActLineColor; LineBreak:=nil;
  LinkMode:=False; FastBg:=cvFastBg;
  while LineStop<L do
  begin
    if LineStop^=#254 then
    begin
      if Byte((LineStop+1)^) and 128>0 then // colorcode
      begin
        CurrentColor:=(Byte((LineStop+1)^) shl 8) + (Byte((LineStop+2)^));
        if Byte((LineStop+1)^) and cvNormal=0 then FastBg:=0;
        Inc(LineStop,3);
      end
      else
      begin
        LinkMode:=(LineStop+1)^<>#0;
        Inc(LineStop,Byte((LineStop+2)^));
      end;
    end
    else
    begin
      Inc(LineLen);

      if (LineStop^ in [' ','-']) and (not LinkMode) then begin NewLineColor:=CurrentColor; LineBreak:=LineStop+1; end; // set breakpoint

      if (LineBreak<>nil) and (
        (((LineStop+1)^='-') and (LineLen>=fWidthCount)) or (LineLen>fWidthCount)
        ) then // wrap it
      begin
          while (LineBreak<L) and (LineBreak^=' ') do Inc(LineBreak);
        LineLen:=LineStop+1-LineBreak+fIndentLen;
        SetString(TempStr,LineStart,LineBreak-LineStart);
        if (fIndentText='') or (Result=1) then
          fLines.AddObject(TempStr,TObject(ActLineColor or FastBg))
        else
          fLines.AddObject(fIndentText+TempStr,TObject(ActLineColor or FastBg));
        Inc(Result);
        ActLineColor:=NewLineColor;
        SetLength(TempStr,0);
        LineStart:=LineBreak; LineBreak:=nil;
        if ActLineColor and cvNormal>0 then FastBg:=cvFastBg;
      end;

      Inc(LineStop);
    end;
  end;
  SetString(TempStr,LineStart,L-LineStart);
  if (fIndentText='') or (Result=1) then
    fLines.AddObject(TempStr,TObject(ActLineColor or cvNewLine or FastBg))
  else
    fLines.AddObject(fIndentText+TempStr,TObject(ActLineColor or cvNewLine or FastBg));
  SetLength(TempStr,0);
end;

procedure TChatView.ReWrapLines;
var
  OldLines: TStringList;
  S: string;
  I, InitialData: Integer;
begin
  OldLines:=fLines;
  fLines:=TStringList.Create;
  I:=0;
  while I<OldLines.Count do
  begin
    S:=''; InitialData:=Integer(OldLines.Objects[I]);
    while (I<OldLines.Count) and (Integer(OldLines.Objects[I]) and cvNewLine=0) do
    begin
      if (fActIndentLen=0) or (S='') then
        S:=S+OldLines[I]
      else
        S:=S+Copy(OldLines[I],fActIndentLen+1,MaxLineLen);
      Inc(I);
    end;
    if I<OldLines.Count then
      if (fActIndentLen=0) or (S='') then
        S:=S+OldLines[I]
      else
        S:=S+Copy(OldLines[I],fActIndentLen+1,MaxLineLen);

    WrapLine(InitialData,S);
    Inc(I);
  end;
  OldLines.Free;
end;

procedure TChatView.AddLine(S: string);
var
  I, LineColor, RealLen: Integer;
begin
  BeginUpdate;
  try
    RealLen:=0;
    LineColor:=GetColor; fNoWrapMode:=False;
    ParseLine(S);
    I:=1;
    if fLines.Count-fTopLine<=fLineCount then try Invalidate; except end;
    while I<=Length(S) do
    begin
        if S[I]=#254 then
          if Ord(S[I+1]) and 128=0 then Inc(I,Ord(S[I+2])-1)
          else Inc(I,2)
        else if S[I]=#7 then
        begin
          if EnableBeep then Beep;
          S:=Copy(S,1,I-1)+Copy(S,I+1,Length(S));
          Dec(I);
        end
        else if S[I]=#9 then
        begin
          S:=Copy(S,1,I-1)+Copy('        ',1,8-(RealLen mod 8))+Copy(S,I+1,Length(S));
          Dec(I);
        end
        else
          Inc(RealLen);
      Inc(I);
    end;
    if (WordWrap<=0) or fNoWrapMode then LineColor:=LineColor or cvNoWrap;
    DoScroll(WrapLine(LineColor,S));
    while fLines.Count>MaxLines do DelLine(0);
  finally
    Inc(fUpdateLock); // avoid Invalidate if not needed
    EndUpdate;
    Dec(fUpdateLock);
  end;
end;

procedure TChatView.ParseLine(var S: string);
var
  IL, TempIL: TIeeuwLink;
  I, J, P: Integer;
begin
  IL.Start:=0; IL.Stop:=0; IL.Kind:=ilEnd;

  I:=1;
  while I<=Length(S) do
  begin
    if S[I]=#254 then S[I]:=' '
    else if (S[I]=#27) and (AnsiColors>0) and (I<Length(S)) and (S[I+1]='[') then
    begin
      P:=0;
      for J:=I+2 to Length(S) do if S[J]='m' then begin P:=J; Break; end;
      if P>0 then
        if AnsiColors=2 then
        begin
          S:=Copy(S,1,I-1)
             +GetAnsiMode(Copy(S,I+2,P-I-2))
             +Copy(S,P+1,Length(S));
          Inc(I,2);
        end
        else
          S:=Copy(S,1,I-1)+Copy(S,P+1,Length(S));
    end
    else if (S[I]='@') and (IL.Kind<>ilStop) then
    begin
      TempIL:=GetIeeuwLink(S,I);
      if TempIL.Kind<>ilNone then // it's an ieeuwlink
      begin
        IL:=TempIL;
        I:=ReplaceLink(S,IL);
      end
      else // it's probably an emailaddress
        if (IL.Kind=ilEnd) and IsMail(TempIL,S,I) then // if currently in a link or no mailaddr > do nothing
          I:=ReplaceMail(S,TempIL);
    end
    else if (S[I]=':') and (Copy(S,I+1,2)='//') then // maybe an url
    begin
      if (IL.Kind=ilEnd) and IsUrl(TempIL,S,I) then I:=ReplaceUrl(S,TempIL);
    end
    else if (S[I]='.') then
      if Copy(S,I-3,3)='www' then // maybe a www-url
      begin
        if (IL.Kind=ilEnd) and IsWwwUrl(TempIL,S,I) then I:=ReplaceUrl(S,TempIL);
      end
      else if Copy(S,I-3,3)='ftp' then // maybe an ftp-url
      begin
        if (IL.Kind=ilEnd) and IsFtpUrl(TempIL,S,I) then I:=ReplaceUrl(S,TempIL);
      end;
    Inc(I);
  end;
{ TODO -oMartin -cLinkparser : news:message maken }
end;

procedure TChatView.SizeOrFontChanged;
begin
  with fTextDrawer do
  begin
    UseBoldFont:=fsBold in Self.Font.Style;
    BaseFont:=Self.Font;
    BaseStyle:=Self.Font.Style;
    fCharWidth:=CharWidth;
    fCharHeight:=CharHeight {+ fExtraLineSpacing};
  end;

  fClientWidth:=ClientWidth;
  fClientHeight:=ClientHeight;
  fLineCount:=Trunc(ClientHeight/fCharHeight);
  fWidthCount:=Trunc((fClientWidth-fXOffset)/fCharWidth){+1};

  ReInitImage;
  Invalidate;
  fNeedScrollUpdate:=True;
end;

procedure TChatView.UpdateScrollBars;
var
  ScrollInfo: TScrollInfo;
begin
  // Show scrollbars
  ScrollInfo.cbSize := SizeOf(ScrollInfo);
  ScrollInfo.fMask := SIF_ALL or SIF_DISABLENOSCROLL;
  ScrollInfo.nMin := 0;
  ScrollInfo.nTrackPos := 0;
  ScrollInfo.nMax := fLines.Count-1;
  ScrollInfo.nPage := fLineCount;
  ScrollInfo.nPos := fTopLine;
  SetScrollInfo(Handle, SB_VERT, ScrollInfo, True);
  if HorizScrollBar then
  begin
    ScrollInfo.nMax := MaxLineLen;
    ScrollInfo.nPage := fWidthCount;
    ScrollInfo.nPos := fLeftChar;
    SetScrollInfo(Handle, SB_HORZ, ScrollInfo, True);
  end
  else
  begin
    ScrollInfo.fMask := SIF_ALL;
    ScrollInfo.nMax := 0;
    ScrollInfo.nPage := 0;
    ScrollInfo.nPos := 0;
    SetScrollInfo(Handle, SB_HORZ, ScrollInfo, True);
  end;
  fNeedScrollUpdate:=False;
end;

procedure TChatView.DoScroll(LinesAdded: Integer);
var
  TL: Integer;
begin
  fNeedScrollUpdate:=True;
  if ScrollLock or fSelecting or (fFollowMode=cfOff) then Exit;
  if (fLines.Count>fLineCount) then
    if (fFollowMode=cfAuto) and (fTopLine<fLines.Count-fLineCount-LinesAdded) then Exit;
  TL:=fLines.Count-fLineCount;
  if fFollowMode=cfAuto then
    if not IsAway then
      fSeenLine:=fLines.Count-1
    else if (TL>fSeenLine) then TL:=fSeenLine;
  if TL<0 then TL:=0;
  if TopLine<TL then TopLine:=TL;
end;

procedure TChatView.SetImage(Name: string; ImgStyle: Integer; ImgOpacity: Integer);
begin
  if Name<>'' then
  begin
    ChDir(AppDir);
    Name:=ExpandFileName(Name);
  end;
  if ((fImgData=nil) and (Name=''))
    or ((fImgData<>nil) and (ImageManager.GetFileName(fImgData.ImgID)=Name)) then
    Exit;
  Invalidate;
  if fImgData<>nil then ImageManager.ReleaseImage(fImgData);
  fTheImage.FreeImage;
  fHasImage:=Name<>'';
  if not fHasImage then
  begin
    fImgData:=nil;
    Exit;
  end;
  fImgData:=ImageManager.RegisterImage(Name);
  if fImgData.ImgID=-1 then // Error occured
  begin
    ImageManager.ReleaseImage(fImgData);
    fImgData:=nil; fHasImage:=False;
    Application.MessageBox(PChar('Error opening '''+Name+''''),'Moops!',0);
    Exit;
  end;
  fImgData.Mode:=ImgStyle;
  fImgData.Opacity:=ImgOpacity;
  ReInitImage;
end;

procedure TChatView.ReInitImage;
begin
  if fImgData=nil then Exit;
  fTheImage.Canvas.Brush.Color:=fBgColorTable[NormalBg];
  fTheImage.Canvas.FillRect(ClientRect);
  fImgData.Canvas:=fTheImage.Canvas;
  fImgData.Bounds:=ClientRect;
  fTheImage.Width:=ClientWidth;
  fTheImage.Height:=ClientHeight;
  ImageManager.Draw(fImgData);
end;

function TChatView.GetLineCount: Integer;
begin
  Result:=fLines.Count;
end;

function TChatView.GetLineBytes: Integer;
begin
  Result:=Length(fLines.Text);
end;

procedure TChatView.SetFontColor(C: Integer);
const
  FontStyle: array[False..True,False..True] of TFontStyles = (
    ([],[fsBold]),
    ([fsUnderLine],[fsUnderLine,fsBold])
  );
var
  F, B: Integer;
begin
  fActColor:=C;

  fBlinkFont:=(C and cvBlink)>0;
  fNormalBlink:=fBlinkFont;

  B:=(C shr 8) and 31;
  fTransparentText:=fHasImage and (B and cvNormal>0) and (C and cvReverse=0);
  if fTransparentText then
    B:=-1 // clNone
  else
    if B and cvNormal>0 then
      if B and cvHighColor>0 then B:=NormalBgBold else B:=NormalBg;

  F:=C and 31;
  if F and cvNormal>0 then
    if F and cvHighColor>0 then F:=NormalFgBold else F:=NormalFg;

  fNormalStyles:=FontStyle[(C and cvUnderline)>0,UseBoldFont or (BoldHighColor and (F and cvHighColor>0))];
  fActStyles:=fNormalStyles;
  fTextDrawer.SetStyle(fNormalStyles);

  if C and cvReverse>0 then
  begin // swap the colors
    C:=B; B:=F; F:=C;
  end;

  if F>-1 then F:=F or AllHighColors;

  fNormalFg:=fFgColorTable[F];
  fNormalBg:=fBgColorTable[B];

  if fBlinkFont and (fBlinkOn=2) then // hide foreground-text?
    if fTransparentText then
      fNormalFg:=clNone // clNone
    else
      fNormalFg:=fNormalBg;

  if fInSelection then
  begin
    fTextDrawer.SetForeColor(fFgColorTable[SelectionFg]);
    fTextDrawer.SetBackColor(fBgColorTable[SelectionBg]);
  end
  else
  begin
    fTextDrawer.SetForeColor(fNormalFg);
    fTextDrawer.SetBackColor(fNormalBg);
  end;

  fActFg:=fNormalFg; fActBg:=fNormalBg;
end;

procedure TChatView.SetLinkColor(C: Integer);
const
  FontStyle: array[False..True,False..True] of TFontStyles = (
    ([],[fsBold]),
    ([fsUnderLine],[fsUnderLine,fsBold])
  );
begin
  if (C and cvBlink)>0 then fBlinkFont:=True else fBlinkFont:=fNormalBlink;
  if (C and cvUnderline)>0 then
    fActStyles:=fNormalStyles+FontStyle[True,UseBoldFont or (BoldHighColor and (C and cvHighColor>0))]
  else
    fActStyles:=fNormalStyles;
  fTextDrawer.SetStyle(fActStyles);

  // background
  if (C shr 8) and cvNormal>0 then
    fActBg:=fNormalBg
  else
    fActBg:=fBgColorTable[(C shr 8) and 31];

  if fInSelection then
    fTextDrawer.SetBackColor(fBgColorTable[SelectionBg])
  else
    fTextDrawer.SetBackColor(fActBg);

  // foreground
  if C and cvNormal>0 then
    fActFg:=fNormalFg
  else
    if fBlinkFont and (fBlinkOn=2) then
      fActFg:=fActBg
    else
      fActFg:=fFgColorTable[(C and 31) or AllHighColors];

  if fInSelection then
    fTextDrawer.SetForeColor(fFgColorTable[SelectionFg])
  else
    fTextDrawer.SetForeColor(fActFg);
end;

procedure TChatView.PaintPart(Start, Stop: PChar; var SkipChars: Integer; var R: TRect; IsEOL: Boolean);
begin
  // handle fLeftChar
  if SkipChars>0 then
    if Stop-Start>SkipChars then
    begin
      Inc(Start,SkipChars); SkipChars:=0;
    end
    else
    begin
      Dec(SkipChars,Stop-Start); Start:=Stop; if not IsEOL then Exit;
    end;

  // now let's paint!
  if IsEOL then
    R.Right:=fClientWidth
  else if Stop>Start then
    R.Right:=R.Left+fCharWidth*(Stop-Start)
  else // nothing to paint / area to clear
    Exit;

  if (fBlinkOn=0) or fBlinkFont then
  begin
    if fTransparentText or fFastBg then
    begin
      if not fFastBg then BitBlt(fTextDrawer.CurrentDC,R.Left,R.Top,R.Right-R.Left,R.Bottom-R.Top,fTheImage.Canvas.Handle,R.Left,R.Top,SRCCOPY);
      if fTextDrawer.ForeColor<>clNone then
        fTextDrawer.ExtTextOut(R.Left, R.Top, ETO_CLIPPED, R, Start, Stop-Start);
    end
    else
      fTextDrawer.ExtTextOut(R.Left, R.Top, ETO_CLIPPED or ETO_OPAQUE, R, Start, Stop-Start)
  end;

  R.Left:=R.Right;
end;

procedure TChatView.DoPaintLine(const S: string; var R: TRect);
var
  P1, P2, L: PChar;
  SkipChars, X: Integer;

  procedure PaintIt;
  begin
    if P2>P1 then PaintPart(P1,P2,SkipChars,R,False);
    P1:=P2;
    if R.Left>fClientWidth then Exit;
    if fInSelection then
    begin
      fTextDrawer.SetForeColor(fFgColorTable[SelectionFg]);
      fTextDrawer.SetBackColor(fBgColorTable[SelectionBg]);
    end
    else
    begin
      fTextDrawer.SetForeColor(fActFg);
      fTextDrawer.SetBackColor(fActBg);
    end
  end;

  procedure CheckBoundary;
  begin
    if fSelBoundary and 1>0 then // start of comment
      if X=fSelStart.X then
      begin
        fInSelection:=True; PaintIt;
      end;
    if fSelBoundary and 2>0 then // end of comment
      if X=fSelEnd.X then
      begin
        fInSelection:=False; PaintIt;
      end;
  end;

begin
  {$IFDEF DEBUG}
  SendStatus(0,'DoPaintLine - Enter');
  {$ENDIF}
  P1:=@S[1]; P2:=P1; L:=P1+Length(S); SkipChars:=fLeftChar; X:=0;
  while P2<L do
  begin
    if (P2^=#254) then
    begin
      if P2>P1 then PaintPart(P1,P2,SkipChars,R,False);
      P1:=HandleCode(P2); P2:=P1;
      if R.Left>fClientWidth then Exit;
    end
    else
    begin
      if fSelBoundary>0 then CheckBoundary;
      Inc(P2); Inc(X);
    end;
  end;
  PaintPart(P1,L-1+1,SkipChars,R,True);
  {$IFDEF DEBUG}
  SendStatus(0,'DoPaintLine - Exit');
  {$ENDIF}
end;

function TChatView.HandleCode(Start: PChar): PChar;
begin
  if Byte((Start+1)^) and 128>0 then // formatting option (color)
  begin
    SetFontColor((Byte((Start+1)^) shl 8) + (Byte((Start+2)^)));
    Result:=Start+3;
  end
  else // extended syntax (links, etc)
  begin
    Result:=Start+Byte((Start+2)^);
    case (Start+1)^ of
      #0: begin
            if fInSelection then
            begin
              fTextDrawer.SetForeColor(fFgColorTable[SelectionFg]);
              fTextDrawer.SetBackColor(fBgColorTable[SelectionBg]);
            end
            else
            begin
              fTextDrawer.SetForeColor(fNormalFg);
              fTextDrawer.SetBackColor(fNormalBg);
            end;
            fTextDrawer.Style:=fNormalStyles;
            fBlinkFont:=fNormalBlink;
          end;
      #1: SetLinkColor(HttpLinkColor);
      #2: SetLinkColor(ClntCmdColor);
      #3: SetLinkColor(MooCmdColor);
    end;
  end;
end;

procedure TChatView.PaintLine(Line, Location: Integer);
var
  R: TRect;
  LineData: Integer;
begin
  if (Line<0) or (Location<0) then Exit;
  R.Top:=Location*fCharHeight+fYOffset; R.Bottom:=R.Top+fCharHeight; R.Left:=fXOffset;
  if Line>=fLines.Count then
  begin
    if fBlinkOn<>0 then Exit;
    R.Right:=fClientWidth;
    if fHasImage then
      BitBlt(fTextDrawer.CurrentDC,R.Left,R.Top,R.Right-R.Left,R.Bottom-R.Top,fTheImage.Canvas.Handle,R.Left,R.Top,SRCCOPY)
    else
      FillRect(fTextDrawer.CurrentDC,R,Canvas.Brush.Handle);
  end
  else
  begin
    if Line=fSelStart.Y then fSelBoundary:=1 else fSelBoundary:=0;
    if Line=fSelEnd.Y then Inc(fSelBoundary,2);
    fInSelection:=(Line>fSelStart.Y) and (Line<fSelEnd.Y) or (fSelBoundary=2);
    LineData:=Integer(fLines.Objects[Line]);
    SetFontColor(LineData);
    if (LineData and cvFastBg>0) and (fBlinkOn=0) then
    begin
      fFastBg:=True;
      {if fBlinkOn=0 then
      begin}
        R.Right:=fClientWidth;
        if fHasImage then
          BitBlt(fTextDrawer.CurrentDC,R.Left,R.Top,R.Right-R.Left,R.Bottom-R.Top,fTheImage.Canvas.Handle,R.Left,R.Top,SRCCOPY)
        else
          FillRect(fTextDrawer.CurrentDC,R,Canvas.Brush.Handle);
      {end;}
    end
    else
      fFastBg:=False;
    DoPaintLine(fLines[Line],R);
  end;
end;

procedure TChatView.PaintLines(Start, Stop: Integer);
var
  I: Integer;
  R: TRect;
  dc: HDC;
begin
  {$IFDEF DEBUG}
  SendStatus(0,'PaintLines - Enter');
  {$ENDIF}
  if fBlinkOn=0 then // fill left boundary
  begin
    Canvas.Brush.Color:=fBgColorTable[NormalBg];
    R.Left:=0; R.Right:=fXOffset; R.Top:=Start*fCharHeight; R.Bottom:=(Stop+1)*fCharHeight;
    if fHasImage then
      Canvas.CopyRect(R,fTheImage.Canvas,R)
    else
      Canvas.FillRect(R);
  end;
  {$IFDEF DEBUG}
  SendStatus(0,'PaintLines - Start drawing');
  {$ENDIF}
  dc:=Canvas.Handle;
  fTextDrawer.BeginDrawing(dc);
  for I:=Start to Stop do
    PaintLine(I+fTopLine,I);
  fTextDrawer.EndDrawing;
  {$IFDEF DEBUG}
  SendStatus(0,'PaintLines - Exit');
  {$ENDIF}
end;

procedure TChatView.Paint;
begin
  fBlinkOn:=0;
  DoPaint;
end;

procedure TChatView.DoBlink(BlinkOn: Boolean);
begin
  if not EnableBlink then Exit;
  if BlinkOn then fBlinkOn:=1 else fBlinkOn:=2;
  DoPaint;
  fBlinkOn:=0;
end;

procedure TChatView.DoPaint;
var
  Start, Stop: Integer;
begin
  if fUpdateLock>0 then Exit;
  if fNeedScrollUpdate then UpdateScrollBars;

  Start:=Canvas.ClipRect.Top div fCharHeight;
  Stop:=(Canvas.ClipRect.Bottom div fCharHeight)+1;
  PaintLines(Start,Stop);
end;

procedure TChatView.SetTopLine(Value: Integer);
begin
  if ScrollThrough then
  begin
    if Value>=fLines.Count then Value:=fLines.Count-1;
  end
  else
    if Value>fLines.Count-fLineCount then Value:=fLines.Count-fLineCount;
  if Value<0 then Value:=0;
  if Value <> fTopLine then
  begin
    fTopLine := Value;
    Invalidate;
    fNeedScrollUpdate:=True;
  end;
end;

procedure TChatView.SetLeftChar(Value: Integer);
begin
  if Value>MaxLineLen then Value:=MaxLineLen;
  if Value<0 then Value:=0;
  if Value <> fLeftChar then
  begin
    fLeftChar := Value;
    Invalidate;
    fNeedScrollUpdate:=True;
  end;
end;

procedure TChatView.ScrollPageUp;
begin
  TopLine:=TopLine-(fLineCount div 2);
end;

procedure TChatView.ScrollPageDown;
begin
  TopLine:=TopLine+(fLineCount div 2);
end;

procedure TChatView.WMHScroll(var Message: TWMScroll);
begin
  case Message.ScrollCode of
      // Scrolls to start / end of the line
    SB_TOP: LeftChar := 1;
    SB_BOTTOM: LeftChar := MaxLineLen-fWidthCount;
      // Scrolls one char left / right
    SB_LINEDOWN: LeftChar := LeftChar + 1;
    SB_LINEUP: LeftChar := LeftChar - 1;
      // Scrolls one page of chars left / right
    SB_PAGEDOWN: LeftChar := LeftChar + (fWidthCount div 2);
    SB_PAGEUP: LeftChar := LeftChar - (fWidthCount div 2);
      // Scrolls to the current scroll bar position
    SB_THUMBPOSITION,
    SB_THUMBTRACK: LeftChar := Message.Pos;
      // Ends scroll = do nothing
  end;
  Update;
  UserActivity;
end;

procedure TChatView.WMVScroll(var Message: TWMScroll);
begin
  UserActivity;
  case Message.ScrollCode of
      // Scrolls to start / end of the text
    SB_TOP: TopLine := 0;
    SB_BOTTOM: TopLine := fLines.Count-1;
      // Scrolls one line up / down
    SB_LINEDOWN: TopLine := TopLine + 1;
    SB_LINEUP: TopLine := TopLine - 1;
      // Scrolls one page of lines up / down
    SB_PAGEDOWN: TopLine := TopLine + (fLineCount div 2);
    SB_PAGEUP: TopLine := TopLine - (fLineCount div 2);
      // Scrolls to the current scroll bar position
    SB_THUMBPOSITION,
    SB_THUMBTRACK: TopLine := Message.Pos;
      // Ends scrolling
    SB_ENDSCROLL:
  end;
  Update;
  UserActivity;
end;

procedure TChatView.WMSize(var Message: TWMSize);
begin
  inherited;
  RewrapLines;
  TopLine:=fLines.Count-fLineCount;
  SizeOrFontChanged;
//  SetImage(fOrigImage);
  ReInitImage;
{  if fImgData<>nil then
  begin
    fImgData.Mode:=imStretch;
    fImgData.Bounds:=ClientRect;
    fImgData.Shade:=100;
    ImageManager.Draw(fImgData);
    Invalidate;
  end;}
end;

procedure TChatView.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    Style := Style or WS_VSCROLL or WS_HSCROLL
      or WS_CLIPCHILDREN;
    if NewStyleControls and Ctl3D then begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
end;

procedure TChatView.WMEraseBkgnd(var Message: TMessage);
begin
  Message.Result:=1;
end;

procedure TChatView.ChangeFont(AFont: TFont);
begin
  Font.Assign(AFont);
  SizeOrFontChanged;
end;

procedure TChatView.FontChange(Sender: TObject);
begin
  SizeOrFontChanged;
end;

procedure TChatView.WMMouseWheel(var Msg: TMessage);
var
  nDelta: integer;
  nWheelClicks: integer;
begin
  inherited;
  if GetKeyState(VK_CONTROL) >= 0 then nDelta := Mouse.WheelScrollLines
  else nDelta := fLineCount div 2;

  Inc(fMouseWheelAccumulator, SmallInt(Msg.wParamHi));
  nWheelClicks := fMouseWheelAccumulator div WHEEL_DELTA;
  fMouseWheelAccumulator := fMouseWheelAccumulator mod WHEEL_DELTA;
  if (nDelta = integer(WHEEL_PAGESCROLL)) or (nDelta > fLineCount) then
    nDelta := fLineCount;
  TopLine := TopLine - (nDelta * nWheelClicks);
end;

procedure TChatView.SetStatus(const Msg: string);
begin
  if StatusText=Msg then Exit;
  StatusText:=Msg;
  Application.OnHint(Self);
end;

function TChatView.GetLinkData(X, Y: Integer): TLinkData;
var
  LineStart, P, DataStart, TextStart, TextStop, L: PChar;
  OldX: Integer;
begin
  Result.IsLink:=False;
  Result.YPos:=Y;
  OldX:=X;
  if (Y<0) or (Y>=fLines.Count) then Exit;
  LineStart:=@fLines[Y][1]; P:=LineStart; L:=LineStart+Length(fLines[Y]);
  DataStart:=LineStart; TextStart:=LineStart;
  SetFontColor(Integer(fLines.Objects[Y]));
  while (P<L) and (X>=0) do
  begin
    if P^=#254 then
    begin
      if Byte((P+1)^) and 128=0 then // links!
      begin
        if (P+1)^=#0 then
          Result.IsLink:=False
        else
        begin
          case (P+1)^ of
            #1: SetLinkColor(HttpLinkColor);
            #2: SetLinkColor(ClntCmdColor);
            #3: SetLinkColor(MooCmdColor);
          end;
          Result.IsLink:=True;
          Result.ActColor:=fActColor;
          Result.LinkType:=Byte((P+1)^);
          DataStart:=P+3; TextStart:=P+Byte((P+2)^);
          Result.XPos:=OldX-X;
        end;
      end;
      P:=HandleCode(P);
    end
    else
    begin
      Inc(P); Dec(X);
    end;
  end;
  if X>=0 then Result.IsLink:=False;
  if Result.IsLink then
  begin
    //Result.FontStyles:=fActStyles;
    //Result.FgColor:=fActFg;
    //Result.BgColor:=fActBg;
    //Result.ActColor:=fActColor;
    TextStop:=L;
    while P<L do
      if (P^=#254) and ((P+1)^=#0) then
      begin
        TextStop:=P; Break;
      end
      else Inc(P);
    SetString(Result.LinkData,DataStart,TextStart-DataStart);
    SetString(Result.LinkText,TextStart,TextStop-TextStart);
  end;
end;

procedure TChatView.DrawLink(Active: Boolean; LD: TLinkData);
var
  R: TRect;
  SC: Integer;
  dc: HDC;
  Start: PChar;
  P1, P2, L: PChar;
begin
  R.Top:=(LD.YPos-fTopLine)*fCharHeight+fYOffset; R.Bottom:=R.Top+fCharHeight;
  if LD.XPos-fLeftChar<0 then
  begin
    R.Left:=fXOffset;
    SC:=0; Start:=@LD.LinkText[(fLeftChar-LD.XPos)+1];
  end
  else
  begin
    SC:=0;
    R.Left:=(LD.XPos-fLeftChar)*fCharWidth+fXOffset;
    Start:=@LD.LinkText[1];
  end;
  //R.Right:=R.Left+fCharWidth*(@LD.LinkText[Length(LD.LinkText)+1]-Start);
  R.Right:=R.Left+fCharWidth*Length(StripLine(LD.LinkText));
  fFastBG:=False;
  dc:=Canvas.Handle;
  fTextDrawer.BeginDrawing(dc);
  SetFontColor(LD.ActColor);
  if Active then SetLinkColor(cvUnderline or cvNormal or (cvNormal shl 8));

  //PaintPart(Start,@LD.LinkText[Length(LD.LinkText)+1],SC,R,False);

  {$IFDEF DEBUG}
  SendStatus(0,'Drawlink - 1');
  {$ENDIF}
  P1:=Start; P2:=P1; L:=P1+Length(LD.LinkText);
  while P2<L do
  begin
    if (P2^=#254) then
    begin
      if P2>P1 then PaintPart(P1,P2,SC,R,False);
      P1:=HandleCode(P2); P2:=P1;
      if Active then SetLinkColor(cvUnderline or cvNormal or (cvNormal shl 8));
      if R.Left>fClientWidth then Exit;
    end
    else
    begin
      Inc(P2);
    end;
  end;
  PaintPart(P1,L-1+1,SC,R,False);
  {$IFDEF DEBUG}
  SendStatus(0,'Drawlink - 2');
  {$ENDIF}

  fTextDrawer.EndDrawing;
end;

procedure TChatView.MMoveTimerTimer(Sender: TObject);
var
  Msg: TWMMouseMove;
  P: TPoint;
begin
  GetCursorPos(P);
  P:=ScreenToClient(P);
  Msg.XPos:=P.X;
  Msg.YPos:=P.Y;
  Msg.Keys:=fLastKeyState;
  WMMouseMove(Msg);
end;

procedure TChatView.StartMMoveTimer(LastKeyState: Integer);
begin
  fLastKeyState:=LastKeyState;
  if MMoveTimer=nil then
  begin
    MMoveTimer:=TTimer.Create(Self);
    with MMoveTimer do
    begin
      Enabled:=True; Interval:=10; OnTimer:=MMoveTimerTimer;
    end;
  end;
end;

procedure TChatView.StopMMoveTimer;
begin
  if MMoveTimer<>nil then
  begin
    MMoveTimer.Free; MMoveTimer:=nil;
  end;
end;

procedure TChatView.WMMouseMove(var Msg: TWMMouseMove);
var
  X, Y: Integer;
  LD: TLinkData;
  S: string;
begin
  inherited;

  {$IFDEF DEBUG}
  if fSelecting then SendStatus(0,'WMMouseMove - 1');
  {$ENDIF}
  X:=Msg.XPos;
  Y:=Msg.YPos;

  if fSelecting then
  begin
    if X<5 then
      if fLeftChar>0 then
      begin
        Dec(fLeftChar,1);
        fNeedScrollUpdate:=True;
        Invalidate;
      end;
    if X>fClientWidth-5 then
      if fLeftChar<1024 then
      begin
        Inc(fLeftChar,1);
        fNeedScrollUpdate:=True;
        Invalidate;
      end;
    if Y<5 then TopLine:=TopLine-1;
    if Y>fClientHeight-5 then TopLine:=TopLine+1;
  end;

  {$IFDEF DEBUG}
  if fSelecting then SendStatus(0,'WMMouseMove - 2');
  {$ENDIF}
  X:=((X-fXOffset) div fCharWidth)+fLeftChar;
  if (Y<fYOffset) and (fTopLine=0) then
    Y:=-1
  else
    Y:=((Y-fYOffset) div fCharHeight)+fTopLine;

  if fSelecting then
  begin
    {$IFDEF DEBUG}
    SendStatus(0,'WMMouseMove - 3');
    {$ENDIF}
    SetCapture(Handle);
    SetSelEnd(X,Y);
    {$IFDEF DEBUG}
    SendStatus(0,'WMMouseMove - 4');
    {$ENDIF}
    Exit;
  end;

  // check for links:
  if fHasSelection or (Msg.Keys and (MK_LBUTTON or MK_MBUTTON or MK_RBUTTON)>0) then Exit;

  LD:=GetLinkData(X,Y);
  if LD.IsLink and (GetAsyncKeyState(VK_SHIFT)>=0) then
  begin
    if IsValidUrl(LD.LinkType,LD.LinkData,S) then
      SetStatus(LD.LinkData)
    else
      SetStatus(LD.LinkData+' (rejected: '+S+')');

    Cursor:=crHandPoint;
    if (fCurrentLD.IsLink<>LD.IsLink) or (fCurrentLD.XPos<>LD.XPos) or (fCurrentLD.YPos<>LD.YPos) then
    begin
      if fCurrentLD.IsLink then DrawLink(False,fCurrentLD);
      fCurrentLD:=LD;
      DrawLink(True,LD);
      StartMMoveTimer(Msg.Keys);
    end;
  end
  else
  begin
    if fCurrentLD.IsLink then
    begin
      DrawLink(False,fCurrentLD);
      fCurrentLD.IsLink:=False;
      StopMMoveTimer;
    end;
    Cursor:=crDefault;
    SetStatus('');
  end;
end;

procedure TChatView.WMLButtonDown(var Msg: TWMLButtonDown);
var
  X, Y: Integer;
  LD: TLinkData;
  P: TPoint;
begin
  if fHasSelection then UnSelect;

  // check for links:
  X:=((Msg.XPos-fXOffset) div fCharWidth)+fLeftChar;
  Y:=((Msg.YPos-fYOffset) div fCharHeight)+fTopLine;
  LD:=GetLinkData(X,Y);
  if LD.IsLink and (GetAsyncKeyState(VK_SHIFT)>=0) then
  begin
    P.X:=Msg.XPos;
    P.Y:=Msg.YPos;
    P:=ClientToScreen(P);
    if Assigned(OnLinkClick) then OnLinkClick(Self,LD,MK_LBUTTON,P.X,P.Y);
  end
  else if not fDisableSelect then
  begin
    inherited;
    if Y<0 then begin X:=0; Y:=0; end;
    if X<0 then X:=0;
    if Y>=fLines.Count then begin X:=1024; Y:=fLines.Count-1; end;
    fSelecting:=True; fSelStart.X:=X; fSelStart.Y:=Y; fSelEnd:=fSelStart; fSelDown:=fSelStart;
    fHasSelection:=False;
    SetCapture(Handle);
    StartMMoveTimer(Msg.Keys);
  end
  else
    inherited;
end;

procedure TChatView.WMRButtonDown(var Msg: TMessage);
var
  X, Y: Integer;
  LD: TLinkData;
  P: TPoint;
begin
  if fSelecting then Exit;

  // check for links:
  X:=((LOWORD(Msg.lParam)-fXOffset) div fCharWidth)+fLeftChar;
  Y:=((HIWORD(Msg.lParam)-fYOffset) div fCharHeight)+fTopLine;
  LD:=GetLinkData(X,Y);
  if LD.IsLink then
  begin
    P.X:=LOWORD(Msg.lParam);
    P.Y:=HIWORD(Msg.lParam);
    P:=ClientToScreen(P);
    if Assigned(OnLinkClick) then OnLinkClick(Self,LD,MK_RBUTTON,P.X,P.Y);
  end
  else
    inherited;
end;

procedure TChatView.WMLButtonUp(var Msg: TMessage);
begin
  if not fSelecting then begin inherited; Exit; end;
  StopMMoveTimer;
  fSelecting:=False;
  ReleaseCapture;
  if fHasSelection and AutoCopy then CopyToClipBoard;
end;

procedure TChatView.SetSelEnd(X, Y: Integer);
var
  DragP, P: TPoint;
begin
  if Y<0 then begin X:=0; Y:=0; end;
  if X<0 then X:=0;
  if Y>=fLines.Count then begin X:=1024; Y:=fLines.Count-1; end;

  // find dragging end
  if (fSelStart.X=fSelDown.X) and (fSelStart.Y=fSelDown.Y) then
    DragP:=fSelEnd
  else
    DragP:=fSelStart;

  fSelStart:=fSelDown;
  fSelEnd.X:=X;
  fSelEnd.Y:=Y;

  if (fSelStart.Y>fSelEnd.Y) or ((fSelStart.Y=fSelEnd.Y) and (fSelStart.X>fSelEnd.X)) then // swap
  begin
    P:=fSelStart; fSelStart:=fSelEnd; fSelEnd:=P;
  end;
  fHasSelection:=(fSelStart.X<>fSelEnd.X) or (fSelStart.Y<>fSelEnd.Y);

  if DragP.Y<Y then
    PaintLines(DragP.Y-fTopLine,Y-fTopLine)
  else if (DragP.Y>Y) or (DragP.X<>X) then
    PaintLines(Y-fTopLine,DragP.Y-fTopLine)
end;

procedure TChatView.UnSelect;
begin
  fHasSelection:=False;
  fSelEnd.X:=0; fSelEnd.Y:=0;
  fSelStart.X:=0; fSelStart.Y:=0;
  Invalidate;
end;

procedure TChatView.DoCopyToClipboard(const SText: string);
var
  Mem: HGLOBAL;
  P: PChar;
  SLen: integer;
begin
  if SText <> '' then begin
    SLen := Length(SText);
    // Open and Close are the only TClipboard methods we use because TClipboard
    // is very hard (impossible) to work with if you want to put more than one
    // format on it at a time.
    Clipboard.Open;
    try
      // Clear anything already on the clipboard.
      EmptyClipboard;
      // Put it on the clipboard as normal text format so it can be pasted into
      // things like notepad or Delphi.
      Mem := GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE, SLen + 1);
      if Mem <> 0 then begin
        P := GlobalLock(Mem);
        try
          if P <> nil then begin
            Move(PChar(SText)^, P^, SLen + 1);
            // Put it on the clipboard in text format
            SetClipboardData(CF_TEXT, Mem);
          end;
        finally
          GlobalUnlock(Mem);
        end;
      end;
      // Don't free Mem!  It belongs to the clipboard now, and it will free it
      // when it is done with it.
    finally
      Clipboard.Close;
    end;
  end;
end;

procedure TChatView.CopyToClipBoard;
  function CheckEOL(Y: Integer): string;
  begin
    if Integer(fLines.Objects[Y]) and cvNewLine>0 then
      Result:=#13#10
    else
      Result:='';
  end;
var
  S: string;
  I: Integer;
begin
  if not fHasSelection then Exit;

  if fSelStart.Y=fSelEnd.Y then
  begin
    if (fSelStart.Y<0) or (fSelStart.Y>=fLines.Count) then Exit;
    DoCopyToClipBoard(Copy(StripLine(fLines[fSelStart.Y]),fSelStart.X+1,fSelEnd.X-fSelStart.X));
    Exit;
  end;

  if (fSelStart.Y>=0) and (fSelStart.Y<fLines.Count) then
    S:=Copy(StripLine(fLines[fSelStart.Y]),fSelStart.X+1,Length(fLines[fSelStart.Y]))+CheckEOL(fSelStart.Y)
  else
    S:='';

  for I:=fSelStart.Y+1 to fSelEnd.Y-1 do
    if (I>=0) and (I<fLines.Count) then S:=S+StripLine(Copy(fLines[I],fIndentLen+1,2000))+CheckEOL(I);

  if (fSelEnd.Y<>fSelStart.Y) and (fSelEnd.Y>=0) and (fSelEnd.Y<fLines.Count) then
    S:=S+Copy(StripLine(Copy(fLines[fSelEnd.Y],fIndentLen+1,2000)),1,fSelEnd.X);

  if S<>'' then if S[Length(S)]=#10 then Delete(S,Length(S),1);
  if S<>'' then if S[Length(S)]=#13 then Delete(S,Length(S),1);
  DoCopyToClipBoard(S);
end;

function TChatView.GetLineText(LineNr: Integer): string;
begin
  Result:=StripLine(fLines[LineNr]);
end;

procedure TChatView.AddLines(S: string);
var
  Line: string;
  P: Integer;
begin
  repeat
    P:=Pos(#10,S);
    if P>0 then
    begin
      Line:=Copy(S,1,P-1);
      Delete(S,1,P);
      if (S<>'') and (S[1]=#13) then Delete(S,1,1);
      if (Line<>'') and (Line[Length(Line)]=#13) then Delete(Line,Length(Line),1);
      AddLine(Line);
    end;
  until P=0;
  AddLine(S);
end;

procedure TChatView.LoadFromIni(Ini: TIniFile);
var
  I: Integer;
begin
  for I:=0 to 15 do
    SetFgColor(I,Ini.ReadInteger('FgColor',ColorNames[I],FgColorTable[I]));

  for I:=0 to 15 do
    SetBgColor(I,Ini.ReadInteger('BgColor',ColorNames[I],BgColorTable[I]));

  if Ini.ReadBool('Window','IndentLines',False) then
    IndentText:=DecodeURLVar(Ini.ReadString('Window','IndentText','>'))
  else
    IndentText:='';

  HorizScrollBar:=Ini.ReadBool('Window','HorScrollBar',True);
  AutoCopy:=Ini.ReadBool('Window','AutoCopy',True);
  ScrollThrough:=Ini.ReadBool('Window','ScrollThrough',True);

  if Ini.ReadBool('Font','TextFontBold',False) then
    Font.Style:=[fsBold]
  else
    Font.Style:=[];
  Font.Name:=Ini.ReadString('Font','TextFontName','Courier');
  Font.Size:=Ini.ReadInteger('Font','TextFontSize',10);

  AnsiColors:=2-Ini.ReadInteger('Ansi','AnsiMode',0);

  SelectionFg:=Ini.ReadInteger('Color','SelFg',cvBlack);
  SelectionBg:=Ini.ReadInteger('Color','SelBg',cvSilver);
  EnableBlink:=Ini.ReadBool('Ansi','EnableBlink',True);
  EnableBeep:=Ini.ReadBool('Ansi','EnableBeep',True);

  NormalFg:=Ini.ReadInteger('FgColor','Normal',cvGray);
  NormalFgBold:=Ini.ReadInteger('FgColor','Bold',cvWhite);
  BoldHighColor:=Ini.ReadBool('FgColor','BoldHigh',False);
  if Ini.ReadBool('FgColor','AllHigh',False) then
    AllHighColors:=8
  else
    AllHighColors:=0;
  case Ini.ReadInteger('Background','Type',0) of
    0: SetImage('',0,0);
    1: SetImage(
         Ini.ReadString('BackGround','ImgFileName',''),
         Ini.ReadInteger('BackGround','ImgStyle',imStretch),
         Ini.ReadInteger('BackGround','ImgOpacity',100));
  end;

  NormalBg:=Ini.ReadInteger('BgColor','Normal',cvBlack);
  NormalBgBold:=Ini.ReadInteger('BgColor','Bold',cvSilver);
end;

end.
