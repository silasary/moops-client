unit StatusUnit;

interface

uses
  ComCtrls, Classes;

const
  MooTip = -1;
  MoopsIco = 39;
  NormalTipSpeed = 60;

type
  PLiveTipData = ^TLiveTipData;
  TLiveTipData = record
    Expire:   Integer;
    Priority: Integer;
    Mode:     Integer;
  end;

  TStatusManager = class
    MooTips:      TStringList;
    LiveTips:     TStringList;
    MooIco:       Integer;
    NormalExpire: Integer;
    ActMsg:       string;
    ActIco:       Integer;
    StatusExpire: Integer;
    StatusIco:    Integer;
    StatusText:   string;

    constructor Create;
    destructor  Destroy; override;

    procedure FreeLiveTip(Index: Integer);
    function  GetLiveTip: Integer;
    procedure Update(var Msg, Cmd: string; var Ico: Integer; UpdExpire: Boolean);
    procedure AddMoopsTip(const S: string);
    procedure AddMooTip(const S: string);
    procedure AddLiveTip(const S: string; Expire, Priority, Icon: Integer);
    procedure SetStatus(const S: string; Expire, Icon: Integer);
  end;

var
  MoopsTips: TStringList;

implementation

constructor TStatusManager.Create;
begin
  inherited Create;
  MooTips:=TStringList.Create;
  LiveTips:=TStringList.Create;
  NormalExpire:=NormalTipSpeed;
  MooIco:=26; ActMsg:='Ready'; ActIco:=MoopsIco;
  StatusExpire:=0; StatusIco:=0; StatusText:='';
end;

destructor TStatusManager.Destroy;
begin
  while LiveTips.Count>0 do FreeLiveTip(0);
  MooTips.Free;
  LiveTips.Free;
  inherited Destroy;
end;

procedure TStatusManager.FreeLiveTip(Index: Integer);
begin
  FreeMem(PLiveTipData(LiveTips.Objects[Index]));
  LiveTips.Delete(Index);
end;

function TStatusManager.GetLiveTip: Integer;
var
  I, CurPri: Integer;
begin
  Result:=-1; CurPri:=-1;
  for I:=LiveTips.Count-1 downto 0 do
    with PLiveTipData(LiveTips.Objects[I])^ do
    begin
      if Expire<=0 then FreeLiveTip(I)
      else   if Priority>CurPri then
      begin
        Result:=I;
        CurPri:=Priority;
      end;
    end;
end;

procedure TStatusManager.Update(var Msg, Cmd: string; var Ico: Integer; UpdExpire: Boolean);
var
  I: Integer;
begin
  if StatusExpire>0 then
  begin
    Msg:=StatusText;
    Ico:=StatusIco;
    if Ico=MooTip then Ico:=MooIco;
    if UpdExpire then Dec(StatusExpire);
  end
  else
  begin
    I:=GetLiveTip;
    if I>=0 then
    begin
      Msg:=LiveTips[I];
      with PLiveTipData(LiveTips.Objects[I])^ do
      begin
        if Mode=MooTip then
          Ico:=MooIco
        else
          Ico:=Mode;
        if UpdExpire then Dec(Expire);
      end;
    end
    else
    begin
      if UpdExpire then Inc(NormalExpire);
      if NormalExpire>NormalTipSpeed then
      begin
        NormalExpire:=0;
        if (MoopsTips.Count>0) or (MooTips.Count>0) then
        begin
          I:=Random(MoopsTips.Count+MooTips.Count);
          if I>=MoopsTips.Count then
          begin
            ActIco:=MooIco;
            ActMsg:=MooTips[I-MoopsTips.Count]
          end
          else
          begin
            ActIco:=MoopsIco;
            ActMsg:=MoopsTips[I];
          end;
        end
        else
          begin ActIco:=MoopsIco; ActMsg:=''; end;
      end;
      Msg:=ActMsg; Ico:=ActIco;
    end;
  end;
  I:=Pos(#254,Msg);
  if I=0 then
    Cmd:=''
  else
    begin Cmd:=Copy(Msg,I+1,Length(Msg)); Msg:=Copy(Msg,1,I-1); end;
end;

procedure TStatusManager.AddMoopsTip(const S: string);
begin
  MoopsTips.Add(S);
end;

procedure TStatusManager.AddMooTip(const S: string);
begin
  MooTips.Add(S);
end;

procedure TStatusManager.AddLiveTip(const S: string; Expire, Priority, Icon: Integer);
var
  LT: PLiveTipData;
begin
  GetMem(LT,SizeOf(TLiveTipData));
  LT.Priority:=Priority;
  LT.Expire:=Expire;
  LT.Mode:=Icon;
  LiveTips.AddObject(S,TObject(LT));
end;

procedure TStatusManager.SetStatus(const S: string; Expire, Icon: Integer);
begin
  StatusText:=S; StatusIco:=Icon;
  if Expire<=0 then Expire:=20;
  StatusExpire:=Expire;
end;

initialization
  MoopsTips:=TStringList.Create;
  //MoopsTips.Add('Tip: For more information about Auto-Follow click here.');
  MoopsTips.Add('Tip: Did you ever take a look at the website? You''ll probably find the answer of your question there! (Click here)'#254'url:http://www.beryllium.net/moops');
  MoopsTips.Add('Tip: You don''t have to do a Copy after selecting text, Moops already does that for you.');
  MoopsTips.Add('Tip: Use F6 to switch to the next world (Shift-F6 for previous world).');
  MoopsTips.Add('Tip: Use F5 to switch to the next editor window in this world (Shift-F5 for the previous one).');
  MoopsTips.Add('Tip: Want to select text IN a hyperlink? Hold down Shift and start selecting.');
  MoopsTips.Add('Tip: You can click this statusbar to view additional information on the text currently displayed.');
  MoopsTips.Add('Tip: Click the statusbar (this bar) to go to urls shown in it.'#254'url:http://www.beryllium.net/moops');
  MoopsTips.Add('Tip: Moops has a built-in help-system! (Click here)'#254'clnt:/help');
  MoopsTips.Add('Tip: You can resize the input-bar to accommodate very long lines.');
finalization
  MoopsTips.Free;
end.
