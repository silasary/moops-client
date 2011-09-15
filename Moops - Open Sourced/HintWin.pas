unit HintWin;

interface

uses
  Forms, Controls, Windows;

type
  TSmarterHintWindow = class(THintWindow)
    procedure ActivateHint(Rect: TRect; const AHint: string); override;
  end;

implementation

procedure TSmarterHintWindow.ActivateHint(Rect: TRect; const AHint: string);
begin
  if Rect.Bottom+4 > Screen.DesktopHeight then // make it a hintwindow ABOVE the mouse
  begin
    Rect.Right:=Rect.Right-Rect.Left;
    Rect.Bottom:=Rect.Bottom-Rect.Top;
    GetCursorPos(Rect.TopLeft);
    Rect.Top:=Rect.Top-Rect.Bottom-4;
    Rect.Right:=Rect.Right+Rect.Left;
    Rect.Bottom:=Rect.Bottom+Rect.Top;
  end;
  inherited ActivateHint(Rect,AHint);
end;

initialization
  HintWindowClass:=TSmarterHintWindow;
end.