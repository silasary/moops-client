unit ImgManager;

//////////////////////////////////////////////////
//|  ImageManager unit 1.0                     |//
//|  Copyright (C) Martin Poelstra 2000        |//
//|  Beryllium Engineering (www.beryllium.nu)  |//
//////////////////////////////////////////////////

interface

uses
  Windows, Classes, Graphics, SysUtils;

const
  imNormalCenter  = 0; // normal, centered
  imNormalLeftTop = 1; // normal, not centered
  imStretch       = 2; // just stretch
  imStretchAspect = 3; // stretch, but keep aspect ratio (not implemented)
  imTile          = 4; // tiled (repeated)

type
  PImageData = ^TImageData;
  TImageData = record
    ImgID: Integer;  // Handle of image in ImageManager

    Mode:      Integer; // drawing mode
    Opacity:   Integer; // 100 = pure image, 0 = pure BackColor
    BackColor: TColor;  

    Bounds: TRect;   // size of image that has to be drawn
    Canvas: TCanvas; // the destination canvas
  end;

  PImgListItem = ^TImgListItem;
  TImgListItem = record
    ImgID:    Integer;
    RefCount: Integer;
    FileName: string; // uppercase (for windows at least) version of the FULL filename
    Picture:  TPicture; // of course, this is what it's all about
  end;

  TImageManager = class
  private
    ImgList: TList;
    NewIDCounter: Integer;
    function CreateListItem(const FileName: string): PImgListItem;
    procedure DestroyListItem(LI: PImgListItem);
  public
    constructor Create;
    destructor Destroy; override;

    function  RegisterImage(FileName: string): PImageData;
    procedure ReleaseImage(ImgData: PImageData); // also frees ImgData

    function GetFileName(ImgID: Integer): string;

    procedure Draw(ImgData: PImageData);
  end;

var
  ImageManager: TImageManager;

{
  Little note: the ImgID is declared as an integer. Every newly created handle is chosen by
  using the last assigned one, incremented by 1. So, if you go on long enough, this handle will
  overflow. That's right. Well, I don't bother to much about that: you can load approx 2 milion images,
  so I guess you won't reach that anyway. I don't think Windows will run that long, so please don't
  bother me with comments about it :)
}

implementation

constructor TImageManager.Create;
begin
  inherited Create;
  ImgList:=TList.Create;
  NewIDCounter:=0;
end;

destructor TImageManager.Destroy;
begin
  while ImgList.Count>0 do DestroyListItem(ImgList[ImgList.Count-1]);
  ImgList.Free;
  inherited Destroy;
end;

function TImageManager.CreateListItem(const FileName: string): PImgListItem;
begin
  New(Result);
  Result.RefCount:=1;
  Result.FileName:=FileName;
  Result.Picture:=TPicture.Create;
  try
    Result.Picture.LoadFromFile(FileName);
    Result.ImgID:=NewIDCounter; Inc(NewIDCounter);
    ImgList.Insert(0,Result);
  except
    Result.ImgID:=-1; // error occured
  end;
end;

procedure TImageManager.DestroyListItem(LI: PImgListItem);
var
  I: Integer;
begin
  for I:=ImgList.Count-1 downto 0 do
    if ImgList[I]=LI then ImgList.Delete(I);
  LI.Picture.Free;
  SetLength(LI.FileName,0);
  Dispose(LI);
end;

function TImageManager.RegisterImage(FileName: string): PImageData;
var
  I: Integer;
  LI: PImgListItem;
begin
  FileName:=UpperCase(ExpandFileName(FileName));
  New(Result);
  Result.Mode:=imNormalCenter;
  Result.Opacity:=100;
  Result.BackColor:=clBlack;
  Result.Bounds.Left:=0;
  Result.Bounds.Top:=0;
  Result.Bounds.Right:=100;
  Result.Bounds.Bottom:=100;
  // find if it is already loaded:
  for I:=0 to ImgList.Count-1 do
    if PImgListItem(ImgList[I]).FileName=FileName then
      with PImgListItem(ImgList[I])^ do
      begin
        Inc(RefCount);
        Result.ImgID:=ImgID;
        Exit;
      end;
  // hmmm, it isn't, let's try to load it then
  LI:=CreateListItem(FileName);
  if LI.ImgID=-1 then // couldn't load it
  begin
    Result.ImgID:=-1;
    DestroyListItem(LI);
    Exit;
  end;
  Result.ImgID:=LI.ImgID;
end;

procedure TImageManager.ReleaseImage(ImgData: PImageData); // also frees ImgData
var
  I: Integer;
begin
  for I:=0 to ImgList.Count-1 do
    if PImgListItem(ImgList[I]).ImgID=ImgData.ImgID then
      with PImgListItem(ImgList[I])^ do
      begin
        Dec(RefCount);
        if RefCount<=0 then DestroyListItem(ImgList[I]);
        Dispose(ImgData);
        Exit;
      end;
  Dispose(ImgData); // shouldn't come here at all...
end;

procedure TImageManager.Draw(ImgData: PImageData);
var
  P: PImgListItem;
  I: Integer;
  SR, DR: TRect; // source and destination rectangle
begin
  P:=nil;
  // let's find it:
  for I:=0 to ImgList.Count-1 do
    if PImgListItem(ImgList[I]).ImgID=ImgData.ImgID then
    begin
      P:=ImgList[I]; Break;
    end;
  if P=nil then // Panic!
  begin
    ImgData.Canvas.Brush.Color:=clBlack;
    ImgData.Canvas.FillRect(ImgData.Bounds);
    Exit;
  end;
  case ImgData.Mode of
    imNormalCenter:
      ImgData.Canvas.Draw(
        ImgData.Bounds.Left+((ImgData.Bounds.Right-ImgData.Bounds.Left-P.Picture.Width) div 2),
        ImgData.Bounds.Top+((ImgData.Bounds.Bottom-ImgData.Bounds.Top-P.Picture.Height) div 2),
        P.Picture.Graphic
      );
    imStretch:
        ImgData.Canvas.StretchDraw(ImgData.Bounds,P.Picture.Graphic);
    imTile:
      begin
        SR.Right:=P.Picture.Width; SR.Bottom:=P.Picture.Height;
        DR.Top:=ImgData.Bounds.Top;
        repeat
          DR.Left:=ImgData.Bounds.Left;
          repeat
            ImgData.Canvas.Draw(DR.Left,DR.Top,P.Picture.Graphic);
            Inc(DR.Left,SR.Right);
          until DR.Left>ImgData.Bounds.Right;
          Inc(DR.Top,SR.Bottom);
        until DR.Top>ImgData.Bounds.Bottom;
      end;
{ TODO -omartin -cImgManager : StrectDrawAspect maken }
  else // imNormalLeftTop
    ImgData.Canvas.Draw(0,0,P.Picture.Graphic);
  end;
end;

function TImageManager.GetFileName(ImgID: Integer): string;
var
  I: Integer;
begin
  // let's find it:
  for I:=0 to ImgList.Count-1 do
    if PImgListItem(ImgList[I]).ImgID=ImgID then
    begin
      Result:=PImgListItem(ImgList[I]).FileName; Exit;
    end;
  Result:='';
end;

initialization
  ImageManager:=TImageManager.Create;
finalization
  ImageManager.Free;
end.
