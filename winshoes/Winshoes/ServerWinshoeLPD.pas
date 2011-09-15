unit ServerWinshoeLPD;

// Short description:
// The intention of this components to create LPD Application in Delphi
// which receive print data sent from LPR (Line Printer Requester) clients.
// The implementation does not support queue management beyond
// saving incomuing data file to "Queue directories".
//
// RFCs and other Documents:
// - RFC
//   http://www.cis.ohio-state.edu/htbin/rfc/rfc1179.html
// - General LPD security problems
//   http://www.insecure.org/sploits/lpd.protocol.problems.html
// - Borland Technical Informations:
//   TI1647D Implementing TCollection
//
// Original Author:
//   michael.justin@postkasten.de (aka betasoft@kagi@com)
//
// Tested with:
// - WinLPR 1.0
//
// - WinLPR 4.2a
//   http://ich210.ich.kfa-juelich.de/wlprspl/
//
// Usage:
// - Drop a TWinshoeLPDListener object on a form
// - In the object inspector, doubleclick on LPDQueues,
//   then add one LPD Queue for each print queue
//
//   LPDQueue properties description:
//   - QueueDirectory:
//     print data files and print control files will be stored here
//   - QueueName:
//     Queue Name
//   - OnPrint event handler
//     this event is called from the server if a print job has been received.
//     To override creation of data and control file,
//     use this event handler.
//     The LPDControlData parameter contains the print data for the print job
//     in the "PrintData" record field
//
// - to add logging for the client communication,
//   you can write an event handler for the OnLog event
//
//------------------------------------------------------------------------------
//
// Changes:
// Moved OnPrint event handler to queue class TLPDQueue.
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
//

interface

uses
  ServerWinshoe, GlobalWinshoe, Classes;

type

  TLPRPrintType = (lp_plain, lp_ascii, lp_dvi, lp_plot, lp_ditroff, lp_ps,
    lp_pr, lp_fortran, lp_troff, lp_raster, lp_cif);

  TLPDControlData = class
  public
    QueueName,
      OriginHostName,
      ResponsibleUser,
      Username,
      UserMail,
      JobName,
      Banner,
      Title,
      SenderHostName,
      ControlFile,
      PrintData: string;
    Unlink: boolean;
    PrintType: TLPRPrintType;
  end;


  TLPDQueue = class;
  TOnLPDQueuePrint = procedure (LPDQueue: TLPDQueue; LPDControlData: TLPDControlData) of object;

  TWinshoeLPDListener = class;
  TLPDQueue = class(TCollectionItem)
  private
    FQueuename: string;
    FQueueDirectory: string;
    FShortQueueStatus: string;
    FLongQueueStatus: string;
    FOnPrint: TOnLPDQueuePrint;

    procedure Print(const Data: TLPDControlData);
    procedure PrintWaitingJobs;
    procedure AbortJob;
    procedure RemoveJobs;

  public
    function GetDisplayName: string; override;
    function GetShortQueueStatus: string;
    function GetLongQueueStatus: string;
    property ShortQueueStatus: string read GetShortQueueStatus write FShortQueueStatus;
    property LongQueueStatus: string read GetLongQueueStatus write FLongQueueStatus;

  published
    property OnPrint: TOnLPDQueuePrint read FOnPrint write FOnPrint;
    property QueueName: string read FQueuename write FQueuename;
    property QueueDirectory: string read FQueueDirectory write FQueueDirectory;

  end;

  TLPDQueuelist = class(TCollection)
  private
    FWinshoeLPDListener: TWinshoeLPDListener;

    function GetItem(Index: Integer): TLPDQueue;
    procedure SetItem(Index: Integer; Value: TLPDQueue);

    procedure QueuePrint(const Data: TLPDControlData);
    procedure QueuePrintWaitingJobs(const AQueueName: string);
    procedure QueueAbortJob(const AQueueName: string);
    procedure QueueRemoveJobs(const AQueueName: string);
    function GetQueueIndex(const AQueueName: string): integer;
    function GetQueueStatus(const AQueueName: string; const LongStatus: boolean): string;

  protected
    function GetOwner: TPersistent; override;

  public
    constructor Create(WinshoeLPDListener: TWinshoeLPDListener);
    function Add: TLPDQueue;
    property Items[Index: Integer]: TLPDQueue
      read GetItem write SetItem; default;
  end;

  TWinshoeLPDListener = class(TWinshoeListener)
  private
    FOnLog: TStringEvent;
    FLPDQueuelist: TLPDQueuelist;

    procedure SetItems(Value: TLPDQueuelist);
    procedure ParseControlFile(const ControlFile: string; var Data: TLPDControlData);
    function DoGetQueueStatus(const QueueName: string; const LongStatus: boolean): string;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
    procedure DoLog(const Message: string);

  published
    property OnLog: TStringEvent read FOnLog write FOnLog;
    property LPDQueues: TLPDQueuelist read FLPDQueuelist write SetItems;
  end;

// Procs
procedure Register;

implementation

uses
  FileCtrl, SysUtils, windows;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeLPDListener]);
end;

//---------------------------------------------------------
// TLPDQueue
//---------------------------------------------------------

function TLPDQueue.GetDisplayName;
begin
  Result := Queuename;
  if Result = '' then Result := inherited GetDisplayName;
end;

function TLPDQueue.GetShortQueueStatus: string;
begin
  Result := 'ready';
end;

function TLPDQueue.GetLongQueueStatus: string;
var SearchRec: TSearchRec;
begin
  Result := 'ready';
  if not DirectoryExists(FQueueDirectory) then
    Result := 'Queue output directory '+FQueueDirectory+' doesn''t exist';
  if FindFirst(FQueueDirectory+'\lpd*.tmp', faAnyFile, SearchRec)=0 then
    repeat
      Result := Result+#13+#10
      +SearchRec.Name
      +' ('+IntToStr(SearchRec.Size)+' bytes) '
      +' waiting to be printed';
    until FindNext(SearchRec)<>0;
    sysutils.FindClose(SearchRec);
end;

procedure TLPDQueue.Print;
var
  DataFileName: string;
  ControlFileName: string;

  function GetTempFile(const PathName: string): string;
  var FileName: PChar;
  begin
    Result := '';
    FileName := StrAlloc(MAX_PATH + 1);
    if windows.GetTempFileName(PChar(PathName), 'lpd', 0, FileName) <> 0 then
      Result := string(FileName)
    else
      raise Exception.Create('Error: could not create temporary file');
    StrDispose(FileName);
  end;

begin
  if Assigned(FOnPrint) then
    FOnPrint(self, Data)
  else begin
    // if no event handler has been assigned, save to file
    if DirectoryExists(FQueueDirectory) then
      with TStringlist.Create do try
        Text := Data.PrintData;
        try
          DataFileName := GetTempFile(FQueueDirectory);
          SaveToFile(DataFileName);
          TLPDQueuelist(Collection).FWinshoeLPDListener.DoLog('Data file saved to ' + DataFileName);
          Text := Data.ControlFile;
          ControlFileName := ChangeFileExt(DataFileName, '.dat');
          SaveToFile(ControlFileName);
          TLPDQueuelist(Collection).FWinshoeLPDListener.DoLog('Control file saved to ' + ControlFileName);
        except
          on E: Exception do
            TLPDQueuelist(Collection).FWinshoeLPDListener.DoLog(E.Message);
        end;
      finally
        Free;
      end
    else
      TLPDQueuelist(Collection).FWinshoeLPDListener.DoLog('Directory '+FQueueDirectory+' doesn''t exist');
  end;
end;

procedure TLPDQueue.PrintWaitingJobs;
begin
//#todo
end;

procedure TLPDQueue.AbortJob;
begin
//#todo
end;

procedure TLPDQueue.RemoveJobs;
begin
//#todo
end;

//---------------------------------------------------------
// TLPDQueuelist
//---------------------------------------------------------

constructor TLPDQueuelist.Create;
begin
  inherited Create(TLPDQueue);
  FWinshoeLPDListener := WinshoeLPDListener;
end;

function TLPDQueuelist.GetItem(Index: Integer): TLPDQueue;
begin
  Result := TLPDQueue(inherited GetItem(Index));
end;

procedure TLPDQueuelist.SetItem(Index: Integer; Value: TLPDQueue);
begin
  inherited SetItem(Index, Value);
end;

function TLPDQueueList.Add;
begin
  Result := TLPDQueue(inherited Add);
end;

function TLPDQueueList.GetOwner;
begin
  Result := FWinshoeLPDListener;
end;

procedure TLPDQueuelist.QueuePrint;
var i: integer;
begin
  i := GetQueueIndex(Data.Queuename);
  if i > -1 then
    with TLPDQueue(Items[i]) do begin
      Print(Data);
    end
end;

procedure TLPDQueuelist.QueuePrintWaitingJobs;
var i: integer;
begin
  i := GetQueueIndex(AQueuename);
  if i > -1 then
    with TLPDQueue(Items[i]) do begin
      PrintWaitingJobs;
    end
end;

procedure TLPDQueuelist.QueueAbortJob;
var i: integer;
begin
  i := GetQueueIndex(AQueuename);
  if i > -1 then
    with TLPDQueue(Items[i]) do begin
      AbortJob;
    end
end;

procedure TLPDQueuelist.QueueRemoveJobs(const AQueueName: string);
var i: integer;
begin
  i := GetQueueIndex(AQueuename);
  if i > -1 then
    with TLPDQueue(Items[i]) do begin
      RemoveJobs;
    end
end;

function TLPDQueuelist.GetQueueIndex(const AQueueName: string): integer;
var i: integer;
begin
  Result := -1;
  for i := 0 to count - 1 do
    with TLPDQueue(Items[i]) do
      if Queuename = AQueuename then begin
        Result := i;
        Exit;
      end;
end;

function TLPDQueuelist.GetQueueStatus;
var i: integer;
begin
  i := GetQueueIndex(AQueuename);
  if i > -1 then
    with TLPDQueue(Items[i]) do begin
      if Longstatus then
        Result := LongQueuestatus
      else
        Result := ShortQueuestatus;
    end
  else
    Result := 'Queue ' + AQueuename + ' not found';
end;

//---------------------------------------------------------
// TWinshoeLPDListener
//---------------------------------------------------------

constructor TWinshoeLPDListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLPDQueuelist := TLPDQueuelist.Create(Self);
  Port := 515;
end;

destructor TWinshoeLPDListener.Destroy;
begin
  FLPDQueuelist.Free;
  inherited Destroy;
end;

procedure TWinshoeLPDListener.Loaded;
var
i: integer;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) then begin
    if (FLPDQueuelist.Count = 0) then
      raise Exception.Create('Error: no queues defined');
    DoLog('Winshoes LPD Server '+Version+' ');
    if Active then
      DoLog('Server status: active');
    for i:=0 to FLPDQueuelist.Count-1 do
      DoLog('Queue '+TLPDQueue(FLPDQueuelist.Items[i]).Queuename+' status: '+FLPDQueuelist.GetQueueStatus(TLPDQueue(FLPDQueuelist.Items[i]).Queuename, true));
  end;
end;

procedure TWinshoeLPDListener.SetItems;
begin
  FLPDQueuelist.Assign(Value);
end;

function TWinshoeLPDListener.DoGetQueueStatus;
begin
  Result := FLPDQueuelist.GetQueueStatus(QueueName, Longstatus);
end;

procedure TWinshoeLPDListener.DoLog(const Message: string);
begin
  if Assigned(FOnLog) then begin
    FOnLog(self, Message);
  end;
end;

procedure TWinshoeLPDListener.ParseControlFile(const ControlFile: string; var Data: TLPDControlData);
var
  i: integer;
  s: string;
begin
  with TStringlist.Create do try
    Text := ControlFile;
    for i := 0 to count - 1 do begin
      s := strings[i];
      case s[1] of
        'H': Data.OriginHostName := Copy(s, 2, Length(s) - 1);
        'P': Data.ResponsibleUser := Copy(s, 2, Length(s) - 1);
        'M': Data.UserMail := Copy(s, 2, Length(s) - 1);
        'J': Data.JobName := Copy(s, 2, Length(s) - 1);
        'C': Data.SenderHostName := Copy(s, 2, Length(s) - 1);
        'L': Data.Banner := Copy(s, 2, Length(s) - 1);
        'T': Data.Title := Copy(s, 2, Length(s) - 1);
        'U': Data.Unlink := true;
        'l': Data.PrintType := lp_plain;
        'f': Data.PrintType := lp_ascii;
        'd': Data.PrintType := lp_dvi;
        'g': Data.PrintType := lp_plot;
        'n': Data.PrintType := lp_ditroff;
        'o': Data.PrintType := lp_ps;
        'p': Data.PrintType := lp_pr;
        'r': Data.PrintType := lp_fortran;
        't': Data.PrintType := lp_troff;
        'v': Data.PrintType := lp_raster;
        'c': Data.PrintType := lp_cif;
      end;
    end;
  finally
    Free;
  end;
end;

function TWinshoeLPDListener.DoExecute;
var
  Data: TLPDControlData;
  s: string;
  BlankPos: integer;
  StartTime: DWord;

  procedure WriteAck;
  begin
    Thread.Connection.Write(CHAR0);
  end;

  procedure LPDCloseConnection;
  begin
    DoLog('closing connection');
    Thread.Connection.Disconnect;
  end;

  function GetQueueName: boolean;
  begin
    if BlankPos > 0 then
      Data.QueueName := Copy(s, 2, BlankPos - 2)
    else
      Data.QueueName := Copy(s, 2, Length(s) - 1);

    Result := FLPDQueuelist.GetQueueIndex(Data.Queuename)<>-1;

    if not result then
      DoLog('Unknown queue '+Data.Queuename);

  end;

begin
  Result := false;
  try
    if Thread.SessionData = nil then begin
      Data := TLPDControlData.Create;
      Thread.SessionData := Data;
    end
    else begin
      Data := Thread.SessionData as TLPDControlData;
    end;

    with Thread.Connection do begin
      EOLTerminator := LF;
      DoLog('connected with ' + Thread.Connection.PeerAddress);
      s := ReadLn;
      while true do begin
        BlankPos := Pos(' ', s);
        // Interpretate daemon command acording to LPD RFC1179
        case s[1] of
          #1: begin // print any waiting jobs
              if GetQueueName then
              //#todo untested!
                FLPDQueuelist.QueuePrintWaitingJobs(Data.Queuename);
            end;
          #2: begin // Receive subcommand
              WriteAck;
              if not GetQueueName then Break;
              while (Data.ControlFile = '') or (Data.PrintData = '') do begin
                s := ReadLn;
                case s[1] of
                  #1: begin // abort job
                      DoLog('abort job');
                      WriteAck;
                      //#todo untested:
                      FLPDQueuelist.QueueAbortJob(Data.Queuename);
                    end;
                  #2: begin
                      DoLog('Receive control file');
                      // Send subcommand ack
                      WriteAck;
                      // Find eventual file lenght and name arguments
                      //#todo parse parameters
                      // Receive control file
                      EOLTerminator := CHAR0;
                      Data.ControlFile := ReadLn;
                      EOLTerminator := LF;
                      ParseControlFile(Data.ControlFile, Data);
                      WriteAck;
                    end;
                  #3: begin
                      DoLog('Receive data file');
                      // Send subcommand ack
                      WriteAck;
                      // Receive data file
                      EOLTerminator := CHAR0;
                      StartTime := windows.GetTickCount;
                      Data.PrintData := ReadLn;
                      EOLTerminator := LF;
                      DoLog(IntToStr(Length(Data.PrintData)) + ' bytes received in ' + FloatToStr((windows.GetTickCount - StartTime) / 1000) + ' seconds');
                      // Send ack for received complete file
                      WriteAck;
                    end;
                else begin // unknown job subcommand code
                    DoLog('unknown job subcommand code: ' + s);
                    WriteAck;
                  end;
                end; // case
              end; // while true
              // print and Close connection
              FLPDQueuelist.QueuePrint(Data);
              break; // Close connection
            end; // subcommand
          #3: begin // Send queue state (short)
              if not GetQueueName then Break;
              DoLog('Send short queue state for ' + Data.Queuename);
              Write(DoGetQueueStatus(Data.Queuename, false));
              Break; // Close connection
            end;
          #4: begin // Send queue state (long)
              if not GetQueueName then Break;
              DoLog('Send long queue state for ' + Data.Queuename);
              Write(DoGetQueueStatus(Data.Queuename, true));
              Break; // Close connection
            end;
          #5: begin // Remove jobs
              if not GetQueueName then Break;
              DoLog('Remove jobs');
              FLPDQueuelist.QueueRemoveJobs(Data.Queuename);
              Break; // Close connection
            end;
        else begin
            DoLog('unknown job command code: ' + s);
          end;
        end;
        s := ReadLn;
      end;
    end;
    LPDCloseConnection;
    Result := true;
  except
    on E: Exception do begin
      DoLog(E.Message);
      Thread.Connection.Disconnect;
    end;
  end;
end;

end.

