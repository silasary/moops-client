interface

uses
  Windows, Forms, Classes, Controls, Messages, Graphics, SysUtils;

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

  SymbolSet: set of Char = [' ','-'(*,'.',',','!','-',')','}',']',':',';','>'*)];

  MaxLineLen: Integer = 1000;

  WM_MOUSEWHEEL = $020A;

type
  TColorTable = array[0..15] of TColor;
  TFollowMode = (cfOff, cfOn, cfAuto);
  TChatView = class(TCustomControl)
  private
    fCharHeight: Integer;
    fCharWidth: Integer;
    fFontAttr: TFontStyles;
    fNeedScrollUpdate: Boolean;
    fTopLine: Integer; // Number of first visible line
    fLeftChar: Integer;
    fLineCount: Integer; // Number of lines in window
    fWidthCount: Integer; // Width in characters
    fLines: TStringList;
    fFollowMode: TFollowMode;
    fSeenLine: Integer; // Used for UserActivity (Auto-Follow)
    fLastTime: TTimeStamp;
    fXOffset: Integer;
    fClientWidth: Integer;
    fMaxLines: Integer;
    fBoldMode, fBlinkMode: Boolean;
    fBlinkOn: Byte; { 0 = paintall, 1 = paintnormal, 2 = painthidden }
    fFgColor, fBkColor: Byte;
    fBlinkFont: Boolean; // used by DoPaint
    fColorTable: TColorTable;
    fUpdateLock: Integer;
    fMouseWheelAccumulator: integer;
    fSelected: Boolean;
    procedure PaintLine(Line, Location: Integer);
    procedure WMHScroll(var Message: TWMScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMScroll); message WM_VSCROLL;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
    procedure WMMouseWheel(var Msg: TMessage); message WM_MOUSEWHEEL;
    procedure UpdateScrollBars;
    function GetColor: Byte;
    procedure SetAttrs(const S: string);
    function GetAnsiMode(S: string): string;
    procedure SetFontColor(C: Byte);
    procedure DoScroll;
    procedure DelLine(I: Integer);
    function IsAway: Boolean;
    procedure FontChange(Sender: TObject);
    procedure DoPaint;
    function SkipFont(Line: Integer; S: string): string;
  public
    fSelStart: TPoint;
    fSelEnd: TPoint;
    AnsiColors: Boolean;
    AutoAwayTime: Integer; // Time in seconds
    WordWrap: Integer;
    ClientFollow: TFollowMode;
    NormalFg: Byte;
    NormalBg: Byte;
    constructor Create(AOwner: TComponent); override;
    procedure SizeOrFontChanged;
    procedure Paint; override;
    (*procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;*)
    procedure UserActivity; // Called when useractivity is detected (eg keypress)
    procedure AddLine(S: string);
    procedure SetTopLine(Value: Integer);
    procedure SetLeftChar(Value: Integer);
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Clear;
    procedure ChangeFont(AFont: TFont);
    procedure SetColor(Nr: Byte; Color: TColor);
    procedure DoColor(Fg, Bk: Byte);
    procedure DoBlink(BlinkOn: Boolean);
    procedure ScrollPageUp;
    procedure ScrollPageDown;
    property TopLine: Integer read fTopLine write SetTopLine;
    property LeftChar: Integer read fLeftChar write SetLeftChar;
    property MaxLines: Integer read fMaxLines write fMaxLines;
    property ColorTable: TColorTable read fColorTable write fColorTable;
    property LineLen: Integer read fCharWidth;
  published
    property FollowMode: TFollowMode read fFollowMode write fFollowMode;
    property Font;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
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

constructor TChatView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AnsiColors:=True;
  AutoAwayTime:=0;
  //AutoAwayTime:=10;
  fMaxLines:=500;
  fTopLine:=0; fLeftChar:=0; fFollowMode:=cfAuto;
  fSeenLine:=0; fXOffset:=3;
  Font.Name:='Courier New';
  Font.Size:=10;
  fNeedScrollUpdate:=True;
  fLines:=TStringList.Create;
  fUpdateLock:=0;
  NormalFg:=cvGray; NormalBg:=cvBlack;
  fBoldMode:=False; fFgColor:=NormalFg; fBkColor:=NormalBg; fBlinkMode:=False;
  fColorTable[cvBlack]:=clBlack;
  fColorTable[cvMaroon]:=clMaroon;
  fColorTable[cvGreen]:=clGreen;
  fColorTable[cvOlive]:=clOlive;
  fColorTable[cvNavy]:=clNavy;
  fColorTable[cvPurple]:=clPurple;
  fColorTable[cvTeal]:=clTeal;
  fColorTable[cvGray]:=clGray;
  fColorTable[cvSilver]:=clSilver;
  fColorTable[cvRed]:=clRed;
  fColorTable[cvLime]:=clLime;
  fColorTable[cvYellow]:=clYellow;
  fColorTable[cvBlue]:=clBlue;
  fColorTable[cvFuchsia]:=clFuchsia;
  fColorTable[cvAqua]:=clAqua;
  fColorTable[cvWhite]:=clWhite;
  Font.Color:=ColorTable[NormalFg];
  Color:=ColorTable[NormalBg];
  Font.OnChange:=FontChange;
  WordWrap:=1;
  fSelected:=False;
  fSelStart.X:=-1;
  fSelEnd.X:=-1;
  fSelStart.Y:=-1;
  fSelEnd.Y:=-1;
end;

procedure TChatView.DoColor(Fg, Bk: Byte);
begin
  fBlinkMode:=Bk and cvHighColor>0;
  fBoldMode:=Fg and cvHighColor>0;
  fFgColor:=Fg and cvLowColor;
  fBkColor:=Bk and cvLowColor;
end;

procedure TChatView.SetColor(Nr: Byte; Color: TColor);
begin
  fColorTable[Nr]:=Color;
end;

procedure TChatView.Clear;
begin
  BeginUpdate;
  fLines.Clear; fSeenLine:=0; fTopLine:=0; fNeedScrollUpdate:=True;
  EndUpdate;
end;

procedure TChatView.BeginUpdate;
begin
  Inc(fUpdateLock);
  fLines.BeginUpdate;
end;

procedure TChatView.EndUpdate;
begin
  fLines.EndUpdate;
  Dec(fUpdateLock);
  if fUpdateLock=0 then Invalidate;//Repaint;
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

function TChatView.GetColor: Byte;
begin
  if fBoldMode then
    fFgColor:=fFgColor or cvHighColor
  else
    fFgColor:=fFgColor and cvLowColor;
  fBkColor:=fBkColor and cvLowColor;
  if fBlinkMode then
    Result:=(fFgColor+(fBkColor shl 4)) or cvBlink
  else
    Result:=fFgColor+(fBkColor shl 4);
end;

procedure TChatView.SetAttrs(const S: string);
var
  Temp: Byte;
begin
  // Misc
  if S='0' then begin DoColor(NormalFg,NormalBg); {fFgColor:=cvNormalFg; fBkColor:=cvNormalBg; fBoldMode:=False; fBlinkMode:=False;} end;
  if S='1' then fBoldMode:=True;
  if S='5' then fBlinkMode:=True;
  if S='7' then begin Temp:=fFgColor; fFgColor:=fBkColor; fBkColor:=Temp; end;
  // Foreground
  if S='30' then fFgColor:=cvBlack;
  if S='31' then fFgColor:=cvMaroon;
  if S='32' then fFgColor:=cvGreen;
  if S='33' then fFgColor:=cvOlive;
  if S='34' then fFgColor:=cvNavy;
  if S='35' then fFgColor:=cvPurple;
  if S='36' then fFgColor:=cvTeal;
  if S='37' then fFgColor:=cvGray;
  // Background
  if S='40' then fBkColor:=cvBlack;
  if S='41' then fBkColor:=cvMaroon;
  if S='42' then fBkColor:=cvGreen;
  if S='43' then fBkColor:=cvOlive;
  if S='44' then fBkColor:=cvNavy;
  if S='45' then fBkColor:=cvPurple;
  if S='46' then fBkColor:=cvTeal;
  if S='47' then fBkColor:=cvGray;
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
  Result:=#254+Chr(GetColor);
end;

procedure TChatView.DelLine(I: Integer);
begin
  if (I<0) or (I>=fLines.Count) then Exit;
  fLines.Delete(I);
  Dec(fSeenLine); if fSeenLine<0 then fSeenLine:=0;
  Dec(fTopLine); if fTopLine<0 then fTopLine:=0;
end;

procedure TChatView.AddLine(S: string);
var
  I, Mode, LineStart, LineColor, TokenStart, BreakPos, RealLen: Integer;
begin
  { TODO -omartin -cchatview : Linelen sjekken }
  { TODO -omartin -cchatview : Tabs implementeren }
  BeginUpdate;
  Mode:=0; RealLen:=0; BreakPos:=1; TokenStart:=1; LineStart:=1; LineColor:=GetColor;
  I:=1; S:=S+' '; // Trick to get simple wordwrap
  while I<=Length(S) do
  begin
    if Mode=1 then // Ansi color
      if S[I]='[' then begin Mode:=2; TokenStart:=I+1; end
      else Mode:=0
    else if Mode=2 then
    begin
      if S[I]='m' then // End of ansi color
      begin
        S:=Copy(S,1,TokenStart-3)
           +GetAnsiMode(Copy(S,TokenStart,I-TokenStart))
           +Copy(S,I+1,Length(S));
        I:=TokenStart-1;
        Mode:=0;
      end
    end
    else
      if (S[I]=#27) and AnsiColors then Mode:=1
      else if (S[I] in [#7]) then
      begin
        S:=Copy(S,1,I-1)+Copy(S,I+1,Length(S));
        Dec(I);
      end
      else
      begin
        Inc(RealLen);
        if S[I] in SymbolSet then BreakPos:=I;
        if (WordWrap>0) and (((S[I]=' ') and (RealLen>fWidthCount)) or (RealLen>=fWidthCount)) then // Wordwrap
        begin
          fLines.AddObject(Copy(S,LineStart,BreakPos-LineStart+1),Pointer(LineColor));
          DoScroll;
          LineStart:=BreakPos+1; LineColor:=GetColor; RealLen:=0; BreakPos:=I;
        end;
      end;
    Inc(I);
  end;
  fLines.AddObject(Copy(S,LineStart,I-LineStart+1),Pointer(LineColor));
  while fLines.Count>MaxLines do DelLine(0);
  DoScroll;
  EndUpdate;
end;

(*procedure TChatView.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  fNeedScrollUpdate:=True;
end;*)

procedure TChatView.SizeOrFontChanged;
begin
  // Initialize canvas
  Canvas.Font.Assign(Font);
  Canvas.Brush.Color:=Color;
  // Initialize vars
  fCharHeight:=Canvas.TextHeight('H');
  fCharWidth:=Abs(Canvas.TextWidth('W'));
  fFontAttr:=Font.Style;
  fClientWidth:=ClientWidth;
  fLineCount:=Trunc(ClientHeight/fCharHeight);
  fWidthCount:=Trunc((fClientWidth-fXOffset)/fCharWidth);
  Canvas.Brush.Color:=Color;
  Canvas.FillRect(ClientRect);
  Repaint;
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
  ScrollInfo.nMax := MaxLineLen;
  ScrollInfo.nPage := fWidthCount;
  ScrollInfo.nPos := fLeftChar;
  SetScrollInfo(Handle, SB_HORZ, ScrollInfo, True);
  fNeedScrollUpdate:=False;
end;

procedure TChatView.DoScroll;
var
  TL: Integer;
begin
  fNeedScrollUpdate:=True;
  if fFollowMode=cfOff then Exit;
  if (fLines.Count>fLineCount) then
    if (fFollowMode=cfAuto) and (fTopLine<fLines.Count-fLineCount-1) then Exit;
  TL:=fLines.Count-fLineCount;
  if fFollowMode=cfAuto then
    if not IsAway then
      fSeenLine:=fLines.Count-1
    else if (TL>fSeenLine) then TL:=fSeenLine;
  if TL<0 then TL:=0;
  if TopLine<TL then TopLine:=TL;
end;

procedure TChatView.SetFontColor(C: Byte);
begin
  fBlinkFont:=C and cvBlink>0;
  if fBlinkFont and (fBlinkOn=2) then
    Canvas.Font.Color:=fColorTable[(C shr 4) and cvLowColor]
  else
    Canvas.Font.Color:=fColorTable[C and 15];
  Canvas.Brush.Color:=fColorTable[(C shr 4) and cvLowColor];
end;

function TChatView.SkipFont(Line: Integer; S: string): string;
var
  W, I, L: Integer;
begin
  L:=Length(S);
  I:=1; W:=0;
  while I<=L do
  begin
    if S[I]=#254 then begin Inc(I); if I<=L then SetFontColor(Ord(S[I])); end
    else
    begin
      Inc(W);
      if W>=fLeftChar then begin Result:=Copy(S,I+1,L); Exit; end;
    end;
    Inc(I);
  end;
  Result:='';
end;



procedure TChatView.PaintLine(Line, Location: Integer);
var
  R: TRect;
  P, I, L, E, X: Integer;
  S: string;
  C: TColor;
  SwapColors: Boolean;
begin
  if (Line<0) or (Location<0) then Exit;
  R.Top:=Location*fCharHeight; R.Bottom:=R.Top+fCharHeight;
  if Line>=fLines.Count then
  begin
    Canvas.Brush.Color:=fColorTable[NormalBg];
    R.Left:=0; R.Right:=fClientWidth;
    if fBlinkOn=0 then Canvas.FillRect(R);
  end
  else
  begin
    Canvas.Brush.Color:=fColorTable[NormalBg];
    R.Left:=0; R.Right:=fXOffset;
    if fBlinkOn=0 then Canvas.FillRect(R);
    Canvas.MoveTo(fXOffset,R.Top);

    SetFontColor(Integer(fLines.Objects[Line]));
    S:=fLines[Line]; if fLeftChar>0 then S:=SkipFont(Line, S);

    if (Line<fSelStart.Y) or (Line>fSelEnd.Y) then SwapColors:=False
    else
      if (Line>fSelStart.Y) and (Line<fSelEnd.Y) then SwapColors:=True
      else if (fSelStart.Y=fSelEnd.Y) then SwapColors:=(fLeftChar>=fSelStart.X) and (fLeftChar-1<=fSelEnd.X)
      else if Line=fSelStart.Y then SwapColors:=fLeftChar>=fSelStart.X
      else SwapColors:=fLeftChar-1<=fSelEnd.X;
    if SwapColors then
      begin C:=Canvas.Font.Color; Canvas.Font.Color:=Canvas.Brush.Color; Canvas.Brush.Color:=C; end;
{    if ((Line>fSelStart.Y) and (Line<fSelEnd.Y)) or
      ((Line=fSelStart.Y) and (fLeftChar>=fSelStart.X)) or
      ((Line=fSelEnd.Y) and (fLeftChar<fSelEnd.X)) then // Swap colors:
      begin C:=Canvas.Font.Color; Canvas.Font.Color:=Canvas.Brush.Color; Canvas.Brush.Color:=C; end;}

    P:=1; X:=0; L:=Length(S);
    repeat
      I:=P;
      while (I<L) and (S[I]<>#254)
        and (not ((Line=fSelStart.Y) and (I=fSelStart.X)))
        and (not ((Line=fSelEnd.Y) and (I=fSelEnd.X))) do
      begin
        Inc(I); if S[I]<>#254 then Inc(X);
      end;
      if I<=L then
      begin
        if S[I]=#254 then E:=0 else E:=1;
        if (fBlinkOn=0) or fBlinkFont then
          Canvas.TextOut(Canvas.PenPos.X,R.Top,Copy(S,P,I-P+E))
        else
          Canvas.MoveTo(Canvas.PenPos.X+Canvas.TextWidth(Copy(S,P,I-P+E)),Canvas.PenPos.Y);

        if (Line<fSelStart.Y) or (Line>fSelEnd.Y) then SwapColors:=False
        else
          if (Line>fSelStart.Y) and (Line<fSelEnd.Y) then SwapColors:=True
          else if (fSelStart.Y=fSelEnd.Y) then SwapColors:=(X>=fSelStart.X) and (X-1<=fSelEnd.X)
          else if Line=fSelStart.Y then SwapColors:=X>=fSelStart.X
          else SwapColors:=X-1<=fSelEnd.X;
//        SwapColors:=((Line>fSelStart.Y) and (Line<fSelEnd.Y)) or
//          ((Line=fSelStart.Y) and (I>=fSelStart.X));
//        if (Line=fSelEnd.Y) and (I>=fSelEnd.X) then SwapColors:=False;

        if S[I]=#254 then
          begin SetFontColor(Ord(S[I+1])); P:=I+2; Inc(I,2); end
        else
          begin P:=I+1; Inc(I); end;
        if SwapColors then
          begin C:=Canvas.Font.Color; Canvas.Font.Color:=Canvas.Brush.Color; Canvas.Brush.Color:=C; end;
      end;
      if Canvas.PenPos.X>fClientWidth then Break;
    until I>=L;
    if ((fBlinkOn=0) or fBlinkFont) and (Canvas.PenPos.X<fClientWidth) then
      Canvas.TextOut(Canvas.PenPos.X,R.Top,Copy(S,P,Length(S)));

    R.Left:=Canvas.PenPos.X; R.Right:=fClientWidth;
    if fBlinkOn=0 then Canvas.FillRect(R);
  end;
end;

procedure TChatView.Paint;
begin
  fBlinkOn:=0;
  DoPaint;
end;

procedure TChatView.DoBlink(BlinkOn: Boolean);
begin
  if BlinkOn then fBlinkOn:=1 else fBlinkOn:=2;
  DoPaint;
  fBlinkOn:=0;
end;

procedure TChatView.DoPaint;
var
  I, Start, Stop: Integer;
begin
  if fUpdateLock>0 then Exit;
  if fNeedScrollUpdate then UpdateScrollBars;

  Start:=Canvas.ClipRect.Top div fCharHeight;
  Stop:=(Canvas.ClipRect.Bottom div fCharHeight)+1;
  for I:=Start to Stop do
    PaintLine(I+fTopLine,I);
end;

procedure TChatView.SetTopLine(Value: Integer);
//var
//  Delta: Integer;
begin
  if Value>=fLines.Count then Value:=fLines.Count-1;
  if Value<0 then Value:=0;
  if Value <> fTopLine then
  begin
//    Delta := fTopLine - Value;
    fTopLine := Value;
//    if Abs(Delta) < fLineCount then
//      ScrollWindow(Handle, 0, fCharHeight * Delta, nil, nil)
//    else
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
  SizeOrFontChanged;
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
  if GetKeyState(VK_CONTROL) >= 0 then nDelta := Mouse.WheelScrollLines
  else nDelta := fLineCount div 2;

  Inc(fMouseWheelAccumulator, SmallInt(Msg.wParamHi));
  nWheelClicks := fMouseWheelAccumulator div WHEEL_DELTA;
  fMouseWheelAccumulator := fMouseWheelAccumulator mod WHEEL_DELTA;
  if (nDelta = integer(WHEEL_PAGESCROLL)) or (nDelta > fLineCount) then
    nDelta := fLineCount;
  TopLine := TopLine - (nDelta * nWheelClicks);
//  Update;
end;

