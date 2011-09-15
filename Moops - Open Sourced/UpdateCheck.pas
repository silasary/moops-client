unit UpdateCheck;

interface

uses
  SimpHttp, SysUtils, Classes, Common;

type
  EUpdCheck = class(EAbort);

  TucEventType = (ucNoNew,ucNewVersion,ucError);
  TUpdCheckerEvent = procedure(Sender: TObject; EventType: TucEventType) of object;

  TUpdChecker = class(TThread)
  private
    fOwner: TComponent;
    fSimpleHTTP: TSimpleHTTP;
    fOnStatus: TUpdCheckerEvent;
    fEventType: TucEventType;
    procedure DoStatus;
    function IsNewerVersion(CurrentVersion: string): Boolean;
    procedure CheckVersion;
  protected
    procedure Execute; override;
  public
    fGetResult:  TStringStream;
    PostValues:  TStringList;
    ScriptURL:   string;
    Referrer:    string;
    ThisVersion: string;
    MoopsID:     string;
    Changes:     string;

    constructor Create(aOwner: TComponent);
    destructor Destroy; override;

    procedure StartCheck;

    property OnStatus: TUpdCheckerEvent read fOnStatus write fOnStatus;
    property Owner: TComponent read fOwner;
  end;

var
  UpdChecker: TUpdChecker;

implementation

uses
  MainFrm;

constructor TUpdChecker.Create(aOwner: TComponent);
begin
  inherited Create(True);
  fOwner:=aOwner;
  PostValues:=TStringList.Create;
  fSimpleHTTP:=TSimpleHTTP.Create(aOwner);
  fSimpleHTTP.SilentExceptions:=True;
  fGetResult:=TStringStream.Create('');
  fOnStatus:=nil;
  ScriptURL:='';
  ThisVersion:='';
end;

destructor TUpdChecker.Destroy;
begin
  fGetResult.Free;
  fSimpleHTTP.Abort;
  fSimpleHTTP.Free;
  PostValues.Free;
  inherited;
end;

procedure TUpdChecker.DoStatus;
begin
  if Assigned(fOnStatus) then
    fOnStatus(Self,fEventType);
end;

function TUpdChecker.IsNewerVersion(CurrentVersion: string): Boolean;
var
  CurVer: array[1..4] of string;
  ThisVer: array[1..4] of string;

  procedure SplitVersion(Version: string; var VerArray: array of string);
  var
    I, P: Integer;
  begin
    I:=0;
    while I<4 do
    begin
      P:=Pos('.',Version); if P=0 then P:=Length(Version)+1;
      VerArray[I]:=Copy(Version,1,P-1);
      Delete(Version,1,P);
      Inc(I);
    end;
  end;
var
  I: Integer;
begin
  Result:=False;
  SplitVersion(CurrentVersion,CurVer);
  SplitVersion(ThisVersion,ThisVer);
  for I:=1 to 4 do
    if StrToInt(CurVer[I])>StrToInt(ThisVer[I]) then
    begin
      Result:=True; Exit;
    end;
end;

procedure TUpdChecker.CheckVersion;
var
  SL: TStringList;
  CurrentVersion: string;
begin
  SL:=TStringList.Create;
  try
    SL.Text:=fGetResult.DataString;
    if SL.Values['error']='1' then raise EUpdCheck.Create('Returned errorcode 1');
    MoopsID:=SL.Values['id'];
    CurrentVersion:=SL.Values['currentversion'];
    if CurrentVersion='' then raise EUpdCheck.Create('No currentversion returned');
    if IsNewerversion(CurrentVersion) then
      fEventType:=ucNewVersion
    else
      fEventType:=ucNoNew;
    Changes:=DecodeURLVar(SL.Values['changes']);
    Synchronize(DoStatus);
  finally
    SL.Free;
  end;
end;

procedure TUpdChecker.Execute;
{var
  Params: string;}
begin
  repeat
    try
{      PostValues.Insert(0,'');
      PostValues.Insert(0,'');
      PostValues.Insert(0,'Content-type: text/html');
      fSimpleHTTP.PostData:=PostValues;
      fSimpleHTTP.Post(ScriptURL, fGetResult);
      fEventType:=ucNoNew;
      Synchronize(DoStatus);}
      //Params:='id=&moopsversion='+ThisVersion;
//      Params:='name=Martin Poelstra&email=martin@beryllium.nu&country=NL&how=Zelf geprogd&version='+ThisVersion;
      { id= }
      //Params:='id=&version='+ThisVersion;
      { currentversion=
        changes=
      }
      fSimpleHTTP.Referrer:=Referrer;
      fSimpleHTTP.Get(ScriptURL{+'?'+Params}, fGetResult);
      CheckVersion;
    except
      if Assigned(MainForm) and MainForm.BetaMode and Assigned(MainForm.StatusPage) then
      begin
        MainForm.StatusPage.AddToLog('Version check: Exception "'+Exception(ExceptObject).Message+'"');
        MainForm.StatusPage.ReceiveLine('Data was: '#10+fGetResult.DataString+#10);
      end;
      fEventType:=ucError;
      Synchronize(DoStatus);
    end;
    if Terminated then Exit;
    Suspend;
  until Terminated;
end;

procedure TUpdChecker.StartCheck;
begin
  while Suspended do Resume;
end;

end.
