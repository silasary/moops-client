{*
  Tunnel components module
  Copyright (C) 1999 Gregor Ibic (gregor.ibic@intelicom-sp.si)
  All rights reserved.

  This package is an Tunnel implementation written
  by Gregor Ibic (gregor.ibic@intelicom-sp.si).

  This software is provided 'as-is', without any express or
  implied warranty. In no event will the author be held liable
  for any damages arising from the use of this software.

  Permission is granted to anyone to use this software for any
  purpose, including commercial applications, and to alter it
  and redistribute it freely, subject to the following
  restrictions:

  1. The origin of this software must not be misrepresented,
     you must not claim that you wrote the original software.
     If you use this software in a product, an acknowledgment
     in the product documentation would be appreciated but is
     not required.

  2. Altered source versions must be plainly marked as such, and
     must not be misrepresented as being the original software.

  3. This notice may not be removed or altered from any source
     distribution.

 // CHANGES

 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)

*}

unit ServerWinshoeTunnel;

interface

uses
  SysUtils, Classes, Winshoes, serverwinshoe, syncobjs,
  GlobalWinshoe, WinSockIntf, Windows, ThreadWinshoe;

const
  BUFFERLEN = $4000;

  // Statistics constants
  NumberOfConnectionsType = 1;
  NumberOfPacketsType     = 2;
  CompressionRatioType    = 3;
  CompressedBytesType     = 4;
  BytesReadType           = 5;
  BytesWriteType          = 6;



type

  TMasterTunnel = class;
  TSlaveTunnel = class;
  TSlaveThread = class;
  TLogger = class;

  ///////////////////////////////////////////////////////////////////////////////
  // Communication classes
  //
  THeader = record
    CRC16: Word;
    MsgType: Word;
    MsgLen: Word;
    UserId: Word;
    Port: Word;
    IpAddr: TInAddr;
  end;

  TCRC16 = class
  private
    function UpdateCRC16(InitCRC: Word; var Buffer; Length:LongInt): Word;
  public
    constructor Create;
    function CalcCRC16(var Buffer; Length: LongInt): Word;
  end;


  TReceiver = class(TObject)
  private
    fiPrenosLen: LongInt;
    fiMsgLen: LongInt;
    fsData: String;
    fbNewMessage: Boolean;
    fCRCFailed: Boolean;
    Locker: TCriticalSection;
    CRCCalculator: TCRC16;
    function FNewMessage: Boolean;
    procedure SetData(const Value: string);
  public
    pBuffer: PChar;
    HeaderLen: Integer;
    Header: THeader;
    MsgLen: Word;
    TypeDetected: Boolean;
    Msg: PChar;
    property Data: String read fsData write SetData;
    property NewMessage: Boolean read FNewMessage;
    property CRCFailed: Boolean read fCRCFailed;
    procedure ShiftData;
    constructor Create;
    destructor Destroy; override;
  end;


  TSender = class(TObject)
  //private
  public
    Header: THeader;
    DataLen: Word;
    HeaderLen: Integer;
    pMsg: PChar;
    Locker: TCriticalSection;
    CRCCalculator: TCRC16;
  public
    Msg: String;
    procedure PrepareMsg(var Header: THeader;
                         buffer: PChar; buflen: Integer);
    constructor Create;
    destructor Destroy; override;
  end;
  //
  // END Communication classes
  ///////////////////////////////////////////////////////////////////////////////


  ///////////////////////////////////////////////////////////////////////////////
  // Master Tunnel classes
  //
  // Thread to communicate with the service
  MClientThread = class(TThread)
  public
    MasterParent: TMasterTunnel;
    UserId: Integer;
    MasterThread: TWinshoeServerThread;
    OutboundClient: TWinshoeClient;
    DisconnectedOnRequest: Boolean;
    Locker: TCriticalSection;
    SelfDisconnected: Boolean;
    procedure Execute; override;
    constructor Create(master: TMasterTunnel);
    destructor Destroy; override;
  end;

  // Slave thread - communicates with the Master, tunnel
  TSlaveData = class(TObject)
  public
    Receiver: TReceiver;
    Sender: TSender;
    Locker: TCriticalSection;
    SelfDisconnected: Boolean;
    UserData: TObject;
  end;


  TSendMsgEvent  = procedure(Thread: TWinshoeServerThread; var CustomMsg: String) of object;
  TSendTrnEvent  = procedure(Thread: TWinshoeServerThread; var Header: THeader; var CustomMsg: String) of object;
  TSendTrnEventC = procedure(var Header: THeader; var CustomMsg: String) of object;
  TTunnelEventC  = procedure(Receiver: TReceiver) of object;
  TSendMsgEventC = procedure(var CustomMsg: String) of object;
  TTunnelEvent   = procedure(Thread: TSlaveThread) of object;

  TMasterTunnel = class(TWinshoeListener)
  private
    fiMappedPort: Integer;
    fsMappedHost: String;
    Clients: TThreadList;
//    fOnExecute,
    fOnConnect,
    fOnDisconnect,
    fOnTransformRead: TServerEvent;
    fOnTransformSend: TSendTrnEvent;
    fOnInterpretMsg: TSendMsgEvent;
    OnlyOneThread: TCriticalSection;
    flConnectedSlaves: Integer; // Number of connected slave tunnels
    flConnectedServices: Integer; // Number of connected service threads
    LockSlavesNumber: TCriticalSection;
    LockServicesNumber: TCriticalSection;
    StatisticsLocker: TCriticalSection;
    fbActive: Boolean;
    fbLockDestinationHost: Boolean;
    fbLockDestinationPort: Boolean;
    fLogger: TLogger;

    // Statistics counters
    fNumberOfConnectionsValue,
    fNumberOfPacketsValue,
    fCompressionRatioValue,
    fCompressedBytes,
    fBytesRead,
    fBytesWrite: Integer;

    procedure ClientOperation(Operation: Integer; UserId: Integer; s: String);
    procedure SendMsg(MasterThread: TWinshoeServerThread; var Header: THeader; s: String);
    procedure DisconectAllUsers;
    procedure DisconnectAllSubThreads(TunnelThread: TWinshoeServerThread);
    procedure SetActive(pbValue: Boolean);
    function  GetNumSlaves: Integer;
    procedure IncNumSlaves;
    procedure DecNumSlaves;
    function  GetNumServices: Integer;
    procedure IncNumServices;
    procedure DecNumServices;
    function GetClientThread(UserID: Integer): MClientThread;
  protected
    procedure DoConnect(Thread: TWinshoeServerThread); override;
    procedure DoDisconnect(Thread: TWinshoeServerThread); override;
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
    procedure DoTransformRead(Thread: TWinshoeServerThread); virtual;
    procedure DoTransformSend(Thread: TWinshoeServerThread; var Header: THeader; var CustomMsg: String); virtual;
    procedure DoInterpretMsg(Thread: TWinshoeServerThread; var CustomMsg: String); virtual;
    procedure LogEvent(Msg: String);
  published
    property MappedHost: string read fsMappedHost write fsMappedHost;
    property MappedPort: Integer read fiMappedPort write fiMappedPort;
    property LockDestinationHost: Boolean read fbLockDestinationHost write fbLockDestinationHost;
    property LockDestinationPort: Boolean read fbLockDestinationPort write fbLockDestinationPort;
    property OnConnect: TServerEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TServerEvent read FOnDisconnect write FOnDisconnect;
//    property OnExecute: TServerEvent read FOnExecute write FOnExecute;
    property OnTransformRead: TServerEvent read fOnTransformRead write fOnTransformRead;
    property OnTransformSend: TSendTrnEvent read fOnTransformSend write fOnTransformSend;
    property OnInterpretMsg: TSendMsgEvent read fOnInterpretMsg write fOnInterpretMsg;
  public
    property Active: Boolean read FbActive write SetActive;
    property Logger: TLogger read fLogger write fLogger;
    property NumSlaves: Integer read GetNumSlaves;
    property NumServices: Integer read GetNumServices;
    procedure SetStatistics(Module: Integer; Value: Integer);
    procedure GetStatistics(Module: Integer; var Value: Integer);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;
  //
  // END Master Tunnel classes
  ///////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////////////////////////
  // Slave Tunnel classes
  //
  // Client data structure
  TClientData = class
  public
    Id: Integer;
    TimeOfConnection: TDateTime;
    DisconnectedOnRequest: Boolean;
    SelfDisconnected: Boolean;
    ClientAuthorised: Boolean;
    Locker: TCriticalSection;
    Port: Word;
    IpAddr: TInAddr;
    constructor Create;
    destructor Destroy; override;
  end;

  // Slave thread - tunnel thread to communicate with Master
  TSlaveThread = class(TkdzuThread)
  private
    FLock: TRTLCriticalSection;
    FExecuted: Boolean;
    FConnection: TWinshoeClient;
  protected
    procedure SetExecuted(Value: Boolean);
    function  GetExecuted: Boolean;
    procedure AfterRun; override;
    procedure BeforeRun; override;
  public
    SlaveParent: TSlaveTunnel;
    Receiver: TReceiver;
    property Executed: Boolean read GetExecuted write SetExecuted;
    property Connection: TWinshoeClient read fConnection;
    constructor Create(Slave: TSlaveTunnel);
    destructor Destroy; override;
    procedure Execute; override;
    procedure Run; override;
    procedure Lock;
    procedure Unlock;
  end;


  TSlaveTunnel = class(TWinshoeListener)
  private
    fiMasterPort: Integer; // Port on which Master Tunnel accepts connections
    fsMasterHost: String; // Address of the Master Tunnel
    SClient: TWinshoeClient; // Client which talks to the Master Tunnel
//    fOnExecute, fOnConnect,
    fOnDisconnect: TServerEvent;
    fOnStatus: TStringEvent;
    fOnBeforeTunnelConnect: TSendTrnEventC;
    fOnTransformRead: TTunnelEventC;
    fOnInterpretMsg: TSendMsgEventC;
    fOnTransformSend: TSendTrnEventC;
    fOnTunnelDisconnect: TTunnelEvent;

    Sender: TSender; // Communication class
    OnlyOneThread: TCriticalSection; // Some locking code
    SendThroughTunnelLock: TCriticalSection; // Some locking code
    GetClientThreadLock: TCriticalSection; // Some locking code
    LockClientNumber: TCriticalSection;
    StatisticsLocker: TCriticalSection;
    ManualDisconnected: Boolean;  // We trigered the disconnection
    StopTransmiting: Boolean;
    fbActive: Boolean;
    fbSocketize: Boolean;
    flConnectedClients: Integer; // Number of connected clients
    SlaveThread: TSlaveThread; // Thread which receives data from the Master
    fLogger: TLogger;

    // Statistics counters
    fNumberOfConnectionsValue,
    fNumberOfPacketsValue,
    fCompressionRatioValue,
    fCompressedBytes,
    fBytesRead,
    fBytesWrite: Integer;

    SlaveThreadTerminated: Boolean;

    procedure SendMsg(var Header: THeader; s: String);
    procedure ClientOperation(Operation: Integer; UserId: Integer; s: String);
    procedure SetActive(pbValue: Boolean);
    procedure DisconectAllUsers;
    //procedure DoStatus(Sender: TComponent; const sMsg: String);
    function GetNumClients: Integer;
    procedure IncNumClients;
    procedure DecNumClients;
    procedure TerminateTunnelThread;
    function GetClientThread(UserID: Integer): TWinshoeServerThread;
    procedure OnTunnelThreadTerminate(Sender: TObject);
  protected
    fbAcceptConnections: Boolean; // status if we accept new connections
                                  // it is used with tunnels with some athentication
                                  // procedure between slave and master tunnel

    procedure DoConnect(Thread: TWinshoeServerThread); override;
    procedure DoDisconnect(Thread: TWinshoeServerThread); override;
    function DoExecute(Thread: TWinshoeServerThread): boolean; override;
    procedure DoBeforeTunnelConnect(var Header: THeader; var CustomMsg: String); virtual;
    procedure DoTransformRead(Receiver: TReceiver); virtual;
    procedure DoInterpretMsg(var CustomMsg: String); virtual;
    procedure DoTransformSend(var Header: THeader; var CustomMsg: String); virtual;
    procedure DoStatus(Sender: TComponent; const sMsg: String); virtual;
    procedure DoTunnelDisconnect(Thread: TSlaveThread); virtual;
    procedure LogEvent(Msg: String);
  published
    property MasterHost: string read fsMasterHost write fsMasterHost;
    property MasterPort: Integer read fiMasterPort write fiMasterPort;
    property Socks4: Boolean read fbSocketize write fbSocketize;
//    property OnConnect: TServerEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TServerEvent read FOnDisconnect write FOnDisconnect;
//    property OnExecute: TServerEvent read FOnExecute write FOnExecute;
    property OnBeforeTunnelConnect: TSendTrnEventC read fOnBeforeTunnelConnect
                                                  write fOnBeforeTunnelConnect;
    property OnTransformRead: TTunnelEventC read fOnTransformRead
                                            write fOnTransformRead;
    property OnInterpretMsg: TSendMsgEventC read fOnInterpretMsg write fOnInterpretMsg;
    property OnTransformSend: TSendTrnEventC read fOnTransformSend write fOnTransformSend;
    property OnStatus: TStringEvent read FOnStatus write FOnStatus;
    property OnTunnelDisconnect: TTunnelEvent read FOnTunnelDisconnect write FOnTunnelDisconnect;
  public
    property Active: Boolean read FbActive write SetActive;
    property Logger: TLogger read fLogger write fLogger;
    property NumClients: Integer read GetNumClients;
    procedure SetStatistics(Module: Integer; Value: Integer);
    procedure GetStatistics(Module: Integer; var Value: Integer);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;
  //
  // END Slave Tunnel classes
  ///////////////////////////////////////////////////////////////////////////////


  ///////////////////////////////////////////////////////////////////////////////
  // Logging class
  //
  TLogger = class(TObject)
  private
    OnlyOneThread: TCriticalSection; // Some locking code
    fLogFile: TextFile; // Debug Log File
    fbActive: Boolean;
  public
    property Active: Boolean read fbActive;
    procedure LogEvent(Msg: String);
    constructor Create(LogFileName: String);
    destructor Destroy; override;
  end;
  //
  // Logging class
  ///////////////////////////////////////////////////////////////////////////////

procedure Register;

implementation



procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TMasterTunnel, TSlaveTunnel]);
end;

///////////////////////////////////////////////////////////////////////////////
//
// CRC 16 Class
//
///////////////////////////////////////////////////////////////////////////////
const

Crc16Tab: Array[0..$FF] of Word =
    ($00000, $01021, $02042, $03063, $04084, $050a5, $060c6, $070e7,
     $08108, $09129, $0a14a, $0b16b, $0c18c, $0d1ad, $0e1ce, $0f1ef,
     $01231, $00210, $03273, $02252, $052b5, $04294, $072f7, $062d6,
     $09339, $08318, $0b37b, $0a35a, $0d3bd, $0c39c, $0f3ff, $0e3de,
     $02462, $03443, $00420, $01401, $064e6, $074c7, $044a4, $05485,
     $0a56a, $0b54b, $08528, $09509, $0e5ee, $0f5cf, $0c5ac, $0d58d,
     $03653, $02672, $01611, $00630, $076d7, $066f6, $05695, $046b4,
     $0b75b, $0a77a, $09719, $08738, $0f7df, $0e7fe, $0d79d, $0c7bc,
     $048c4, $058e5, $06886, $078a7, $00840, $01861, $02802, $03823,
     $0c9cc, $0d9ed, $0e98e, $0f9af, $08948, $09969, $0a90a, $0b92b,
     $05af5, $04ad4, $07ab7, $06a96, $01a71, $00a50, $03a33, $02a12,
     $0dbfd, $0cbdc, $0fbbf, $0eb9e, $09b79, $08b58, $0bb3b, $0ab1a,
     $06ca6, $07c87, $04ce4, $05cc5, $02c22, $03c03, $00c60, $01c41,
     $0edae, $0fd8f, $0cdec, $0ddcd, $0ad2a, $0bd0b, $08d68, $09d49,
     $07e97, $06eb6, $05ed5, $04ef4, $03e13, $02e32, $01e51, $00e70,
     $0ff9f, $0efbe, $0dfdd, $0cffc, $0bf1b, $0af3a, $09f59, $08f78,
     $09188, $081a9, $0b1ca, $0a1eb, $0d10c, $0c12d, $0f14e, $0e16f,
     $01080, $000a1, $030c2, $020e3, $05004, $04025, $07046, $06067,
     $083b9, $09398, $0a3fb, $0b3da, $0c33d, $0d31c, $0e37f, $0f35e,
     $002b1, $01290, $022f3, $032d2, $04235, $05214, $06277, $07256,
     $0b5ea, $0a5cb, $095a8, $08589, $0f56e, $0e54f, $0d52c, $0c50d,
     $034e2, $024c3, $014a0, $00481, $07466, $06447, $05424, $04405,
     $0a7db, $0b7fa, $08799, $097b8, $0e75f, $0f77e, $0c71d, $0d73c,
     $026d3, $036f2, $00691, $016b0, $06657, $07676, $04615, $05634,
     $0d94c, $0c96d, $0f90e, $0e92f, $099c8, $089e9, $0b98a, $0a9ab,
     $05844, $04865, $07806, $06827, $018c0, $008e1, $03882, $028a3,
     $0cb7d, $0db5c, $0eb3f, $0fb1e, $08bf9, $09bd8, $0abbb, $0bb9a,
     $04a75, $05a54, $06a37, $07a16, $00af1, $01ad0, $02ab3, $03a92,
     $0fd2e, $0ed0f, $0dd6c, $0cd4d, $0bdaa, $0ad8b, $09de8, $08dc9,
     $07c26, $06c07, $05c64, $04c45, $03ca2, $02c83, $01ce0, $00cc1,
     $0ef1f, $0ff3e, $0cf5d, $0df7c, $0af9b, $0bfba, $08fd9, $09ff8,
     $06e17, $07e36, $04e55, $05e74, $02e93, $03eb2, $00ed1, $01ef0);

constructor TCRC16.Create;
begin
  inherited;
end;

function TCRC16.CalcCRC16(var Buffer; Length: LongInt): Word;
var
  CRC16: Word;
  p: Pointer;
begin
  CRC16 := 0;
  CRC16 := UpdateCrc16(CRC16, Buffer, Length);
  GetMem(p, 2);      { Finish XModem crc with two nulls }
  FillChar(p^, 2, 0);
  CRC16 := UpdateCrc16(CRC16, p^, 2);
  FreeMem(p, 2);
  Result := CRC16;
end;

function TCRC16.UpdateCRC16(InitCRC: Word; var Buffer; Length:LongInt): Word;
begin
  asm
         push   esi
         push   edi
         push   eax
         push   ebx
         push   ecx
         push   edx
         lea    edi, Crc16Tab
         mov    esi, Buffer
         mov    ax, InitCrc
         mov    ecx, Length
         or     ecx, ecx
         jz     @@done
@@loop:
         xor    ebx, ebx
         mov    bl, ah
         mov    ah, al
         lodsb
         shl    bx, 1
         add    ebx, edi
         xor    ax, [ebx]
         loop   @@loop
@@done:
         mov    Result, ax
         pop    edx
         pop    ecx
         pop    ebx
         pop    eax
         pop    edi
         pop    esi
   end;
end;





///////////////////////////////////////////////////////////////////////////////
// Communication classes
//
constructor TSender.Create;
begin
  inherited;
  Locker := TCriticalSection.Create;
  CRCCalculator := TCRC16.Create;
  HeaderLen := SizeOf(THeader);
  GetMem(pMsg, BUFFERLEN);
end;

destructor TSender.Destroy;
begin
  FreeMem(pMsg, BUFFERLEN);
  Locker.Free;
  CRCCalculator.Free;
  inherited;
end;

procedure TSender.PrepareMsg(var Header: THeader;
                             buffer: PChar; buflen: Integer);
begin
  Locker.Enter;
  try
    //Header.MsgType := mType;
    Header.CRC16 := CRCCalculator.CalcCRC16(buffer^, buflen);
    Header.MsgLen := Headerlen + bufLen;
    //Header.UserId := mUser;
    //Header.Port := Port;
    //Header.IpAddr := IPAddr;
    Move(Header, pMsg^, Headerlen);
    Move(buffer^, (pMsg + Headerlen)^, bufLen);
    SetLength(Msg, Header.MsgLen);
    SetString(Msg, pMsg, Header.MsgLen);
  finally
    Locker.Leave;
  end;
end;



constructor TReceiver.Create;
begin
  inherited;
  Locker := TCriticalSection.Create;
  CRCCalculator := TCRC16.Create;
  fiPrenosLen := 0;
  fsData := '';
  fiMsgLen := 0;
  HeaderLen := SizeOf(THeader);
  GetMem(pBuffer, BUFFERLEN);
  GetMem(Msg, BUFFERLEN);
end;


destructor TReceiver.Destroy;
begin
  FreeMem(pBuffer, BUFFERLEN);
  FreeMem(Msg, BUFFERLEN);
  Locker.Free;
  CRCCalculator.Free;
  inherited;
end;

function TReceiver.FNewMessage: Boolean;
begin
  Result := fbNewMessage;
end;

procedure TReceiver.SetData(const Value: string);
var
  CRC16: Word;
begin
  Locker.Enter;
  try
    try
      fsData := Value;
      fiMsgLen := Length(fsData);
      if fiMsgLen > 0 then begin
        Move(fsData[1], (pBuffer + fiPrenosLen)^, fiMsgLen);
        fiPrenosLen := fiPrenosLen + fiMsgLen;
        if (fiPrenosLen >= HeaderLen) then begin
          // copy the header
          Move(pBuffer^, Header, HeaderLen);
          TypeDetected := True;
          // do we have enough data for the entire message
          if Header.MsgLen <= fiPrenosLen then begin
            MsgLen := Header.MsgLen - HeaderLen;
            Move((pBuffer+HeaderLen)^, Msg^, MsgLen);
            // Calculate the crc code
            CRC16 := CRCCalculator.CalcCRC16(Msg^, MsgLen);
            if CRC16 <> Header.CRC16 then begin
              fCRCFailed := True;
            end
            else begin
              fCRCFailed := False;
            end;
            fbNewMessage := True;
          end
          else begin
            fbNewMessage := False;
          end;
        end
        else begin
          TypeDetected := False;
        end;
      end
      else begin
        fbNewMessage := False;
        TypeDetected := False;
      end;
    except
      raise;
    end;

  finally
    Locker.Leave;
  end;
end;

procedure TReceiver.ShiftData;
var
  CRC16: Word;
begin
  Locker.Enter;
  try
    fiPrenosLen := fiPrenosLen - Header.MsgLen;
    // check if we have another entire message
    if fiPrenosLen > 0 then begin
      Move((pBuffer + Header.MsgLen)^, pBuffer^, fiPrenosLen);
    end;

    // check if we have another entire message
    if (fiPrenosLen >= HeaderLen) then begin
      // copy the header
      Move(pBuffer^, Header, HeaderLen);
      TypeDetected := True;
      // do we have enough data for the entire message
      if Header.MsgLen <= fiPrenosLen then begin
        MsgLen := Header.MsgLen - HeaderLen;
        Move((pBuffer+HeaderLen)^, Msg^, MsgLen);
        // Calculate the crc code
        CRC16 := CRCCalculator.CalcCRC16(Msg^, MsgLen);
        if CRC16 <> Header.CRC16 then begin
          fCRCFailed := True;
        end
        else begin
          fCRCFailed := False;
        end;
        fbNewMessage := True;
      end
      else begin
        fbNewMessage := False;
      end;
    end
    else begin
      TypeDetected := False;
    end;
  finally
    Locker.Leave;
  end;
end;
//
// END Communication classes
///////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////
// Master Tunnel classes
//
constructor TMasterTunnel.Create(AOwner: TComponent);
begin
  Clients := TThreadList.Create;
  inherited Create(AOwner);
  fbActive := False;
  flConnectedSlaves := 0;
  flConnectedServices := 0;

  fNumberOfConnectionsValue := 0;
  fNumberOfPacketsValue := 0;
  fCompressionRatioValue := 0;
  fCompressedBytes := 0;
  fBytesRead := 0;
  fBytesWrite := 0;

  fbLockDestinationHost := False;
  fbLockDestinationPort := False;

  OnlyOneThread := TCriticalSection.Create;
  LockSlavesNumber := TCriticalSection.Create;
  LockServicesNumber := TCriticalSection.Create;
  StatisticsLocker := TCriticalSection.Create;
end;

destructor TMasterTunnel.Destroy;
begin
  Logger := nil;
  Active := False;
  DisconectAllUsers; // disconnects service threads
  inherited Destroy;

  Clients.Destroy;
  OnlyOneThread.Free;
  LockSlavesNumber.Free;
  LockServicesNumber.Free;
  StatisticsLocker.Free;
end;


procedure TMasterTunnel.SetActive(pbValue: Boolean);
begin
  LogEvent('ENTER: TMasterTunnel.SetActive');

  if fbActive = pbValue then
    exit;
  LogEvent('Setting status Master');

//  if not ((csLoading in ComponentState) or (csDesigning in ComponentState)) then begin
  if pbValue then begin
    inherited Active := True;
  end
  else begin
    inherited Active := False;
    DisconectAllUsers; // also disconnectes service threads
  end;

//  end;

  fbActive := pbValue;

  LogEvent('EXIT: TMasterTunnel.SetActive');
end;

procedure TMasterTunnel.LogEvent(Msg: String);
begin
  if Assigned(fLogger) then
    fLogger.LogEvent(Msg);
end;


function TMasterTunnel.GetNumSlaves: Integer;
begin
  LogEvent('ENTER: TMasterTunnel.GetNumSlaves');

  LockSlavesNumber.Enter;
  try
    Result := flConnectedSlaves;
  finally
    LockSlavesNumber.Leave;
  end;

  LogEvent('EXIT: TMasterTunnel.GetNumSlaves');
end;

procedure TMasterTunnel.IncNumSlaves;
begin
  LogEvent('ENTER: TMasterTunnel.IncNumSlaves');

  LockSlavesNumber.Enter;
  try
    Inc(flConnectedSlaves);
  finally
    LockSlavesNumber.Leave;
  end;

  LogEvent('EXIT: TMasterTunnel.IncNumSlaves');
end;

procedure TMasterTunnel.DecNumSlaves;
begin
  LogEvent('ENTER: TMasterTunnel.DecNumSlaves');

  LockSlavesNumber.Enter;
  try
    Dec(flConnectedSlaves);
  finally
    LockSlavesNumber.Leave;
  end;

  LogEvent('EXIT: TMasterTunnel.DecNumSlaves');
end;

function TMasterTunnel.GetNumServices: Integer;
begin
  LogEvent('ENTER: TMasterTunnel.GetNumServices');

  LockServicesNumber.Enter;
  try
    Result := flConnectedServices;
  finally
    LockServicesNumber.Leave;
  end;

  LogEvent('EXIT: TMasterTunnel.GetNumServices');
end;

procedure TMasterTunnel.IncNumServices;
begin
  LogEvent('ENTER: TMasterTunnel.IncNumServices');

  LockServicesNumber.Enter;
  try
    Inc(flConnectedServices);
    SetStatistics(NumberOfConnectionsType, 0);
  finally
    LockServicesNumber.Leave;
  end;

  LogEvent('EXIT: TMasterTunnel.IncNumServices');
end;

procedure TMasterTunnel.DecNumServices;
begin
  LogEvent('ENTER: TMasterTunnel.DecNumServices');

  LockServicesNumber.Enter;
  try
    Dec(flConnectedServices);
  finally
    LockServicesNumber.Leave;
  end;

  LogEvent('EXIT: TMasterTunnel.DecNumServices');
end;

procedure TMasterTunnel.GetStatistics(Module: Integer; var Value: Integer);
begin
  StatisticsLocker.Enter;
  try
    case Module of
      NumberOfConnectionsType:
        begin
          Value := fNumberOfConnectionsValue;
        end;
      NumberOfPacketsType:
        begin
          Value := fNumberOfPacketsValue;
        end;
      CompressionRatioType:
        begin
          if fCompressedBytes > 0 then
            Value := Trunc((fBytesRead * 1.0) / (fCompressedBytes * 1.0) * 100.0)
          else
            Value := 0;
        end;
      CompressedBytesType:
        begin
          Value := fCompressedBytes;
        end;
      BytesReadType:
        begin
          Value := fBytesRead;
        end;
      BytesWriteType:
        begin
          Value := fBytesWrite;
        end;
    end;
  finally
    StatisticsLocker.Leave;
  end;
end;

procedure TMasterTunnel.SetStatistics(Module: Integer; Value: Integer);
var
  packets: Real;
  ratio: Real;
begin
  StatisticsLocker.Enter;
  try
    case Module of
      NumberOfConnectionsType:
        begin
          Inc(fNumberOfConnectionsValue);
        end;
      NumberOfPacketsType:
        begin
          Inc(fNumberOfPacketsValue);
        end;
      CompressionRatioType:
        begin
          ratio := fCompressionRatioValue;
          packets := fNumberOfPacketsValue;
          ratio := (ratio/100.0 * (packets - 1.0) + Value/100.0) / packets;
          fCompressionRatioValue := Trunc(ratio * 100);
        end;
      CompressedBytesType:
        begin
          fCompressedBytes := fCompressedBytes + Value;
        end;
      BytesReadType:
        begin
          fBytesRead := fBytesRead + Value;
        end;
      BytesWriteType:
        begin
          fBytesWrite := fBytesWrite + Value;
        end;
    end;
  finally
    StatisticsLocker.Leave;
  end;
end;

procedure TMasterTunnel.DoConnect(Thread: TWinshoeServerThread);
begin
  LogEvent('ENTER: TMasterTunnel.DoConnect');

  LogEvent('Slave connected');
  Thread.SessionData := TSlaveData.Create;
  with TSlaveData(Thread.SessionData) do begin
    Receiver := TReceiver.Create;
    Sender := TSender.Create;
    SelfDisconnected := False;
    Locker := TCriticalSection.Create;
  end;
  if Assigned(OnConnect) then begin
    OnConnect(Thread);
  end;
  IncNumSlaves;

  LogEvent('EXIT: TMasterTunnel.DoConnect');
end;


procedure TMasterTunnel.DoDisconnect(Thread: TWinshoeServerThread);
begin
  LogEvent('ENTER: TMasterTunnel.DoDisconnect');

  DecNumSlaves;
  // disconnect all service threads, owned by this tunnel
  DisconnectAllSubThreads(Thread);
  if Thread.Connection.Connected then
    Thread.Connection.Disconnect;

  If Assigned(OnDisconnect) then begin
    OnDisconnect(Thread);
  end;

  with TSlaveData(Thread.SessionData) do begin
    Receiver.Destroy;
    Sender.Destroy;
    Locker.Free;
  end;
  LogEvent('Slave disconnected');

  LogEvent('EXIT: TMasterTunnel.DoDisconnect');
end;


function TMasterTunnel.DoExecute(Thread: TWinshoeServerThread): boolean;
var
  user: TSlaveData;
  clientThread: MClientThread;
  s: String;
  ErrorConnecting: Boolean;
  sLen: Integer;
  sIP: String;
  CustomMsg: String;
  Header: THeader;
begin
  LogEvent('ENTER: TMasterTunnel.DoExecute');

  user := TSlaveData(Thread.SessionData);

  if Thread.Connection.Readable(1) then  begin
    user.receiver.Data := Thread.Connection.ReadBuffer;

    // increase the packets counter
    SetStatistics(NumberOfPacketsType, 0);

    while user.receiver.TypeDetected do begin
      // security filter
      if not (user.receiver.Header.MsgType in [1, 2, 3, 99]) then begin
        LogEvent('Invalid message type');
        Thread.Connection.Disconnect;
        break;
      end;

      if user.receiver.NewMessage then begin
        if user.Receiver.CRCFailed then begin
          LogEvent('CRC failed');
          Thread.Connection.Disconnect;
          break;
        end;

        // Custom data transformation
        try
          DoTransformRead(Thread);
        except
          LogEvent('Transformation failed');
          Thread.Connection.Disconnect;
          Break;
        end;



        // Action
        case user.Receiver.Header.MsgType of
          0:  // transformation of data failed, disconnect the tunnel
            begin
              try
                LogEvent('Transformation failed');
                Thread.Connection.Disconnect;
                break;
              except
                ;
              end;
            end; // Failure END



          1:  // Data
            begin
              try
                SetString(s, user.Receiver.Msg, user.Receiver.MsgLen);
                ClientOperation(1, user.Receiver.Header.UserId, s);
              except
                LogEvent('Send to client failed');
              end;

            end;  // Data END

          2:  // Disconnect
            begin
              try
                ClientOperation(2, user.Receiver.Header.UserId, '');
              except
                LogEvent('Disconnect client failed');
              end;
            end;  // Disconnect END

          3:  // Connect
            // Connection should be done synchroneusly
            // because more data could arrive before client
            // connects asyncroneusly
            begin
              try
                clientThread := MClientThread.Create(self);
                try
                  ErrorConnecting := False;
                  with clientThread do begin
                    UserId := user.Receiver.Header.UserId;
                    MasterThread := Thread;
                    OutboundClient := TWinshoeClient.Create(nil);
                    sLen := strlen(WinsockInterface.inet_ntoa(user.Receiver.Header.IpAddr));
                    SetString(sIP, WinsockInterface.inet_ntoa(user.Receiver.Header.IpAddr), sLen);
                    if fbLockDestinationHost then begin
                      OutboundClient.Host := fsMappedHost;
                      if fbLockDestinationPort then
                        OutboundClient.Port := fiMappedPort
                      else
                        OutboundClient.Port := user.Receiver.Header.Port;
                    end
                    else begin
                      // do we tunnel all connections from the slave to the specified host
                      if sIP = '0.0.0.0' then begin
                        OutboundClient.Host := fsMappedHost;
                        OutboundClient.Port := user.Receiver.Header.Port; //fiMappedPort;
                      end
                      else begin
                        OutboundClient.Host := sIP;
                        OutboundClient.Port := user.Receiver.Header.Port;
                      end;
                    end;
                    OutboundClient.Connect;
                  end;
                except
                  ErrorConnecting := True;
                end;
                if ErrorConnecting then begin
                  clientThread.Destroy;
                end
                else begin
                  clientThread.Resume;
                end;
              except
                ;
              end;

            end;  // Connect END

          99:  // Session
            begin
              // Custom data interpretation
              CustomMsg := '';
              DoInterpretMsg(Thread, CustomMsg);
              if Length(CustomMsg) > 0 then begin
                Header.MsgType := 99;
                Header.UserId := 0;
                SendMsg(Thread, Header, CustomMsg);
              end;
            end;

        end; // case

        // Shift of data
        user.Receiver.ShiftData;

      end
      else
        break;  // break the loop

    end; // end while
  end;  // readable

  Result := True;

  LogEvent('EXIT: TMasterTunnel.DoExecute');
end;


procedure TMasterTunnel.DoTransformRead(Thread: TWinshoeServerThread);
begin
  LogEvent('ENTER: TMasterTunnel.DoTransformRead');

  if Assigned(fOnTransformRead) then
    fOnTransformRead(Thread);

  LogEvent('EXIT: TMasterTunnel.DoTransformRead');
end;

procedure TMasterTunnel.DoTransformSend(Thread: TWinshoeServerThread; var Header: THeader; var CustomMsg: String);
begin
  LogEvent('ENTER: TMasterTunnel.DoTransformSend');

  if Assigned(fOnTransformSend) then
    fOnTransformSend(Thread, Header, CustomMsg);

  LogEvent('EXIT: TMasterTunnel.DoTransformSend');
end;

procedure TMasterTunnel.DoInterpretMsg(Thread: TWinshoeServerThread; var CustomMsg: String);
begin
  LogEvent('ENTER: TMasterTunnel.DoInterpretMsg');

  if Assigned(fOnInterpretMsg) then
    fOnInterpretMsg(Thread, CustomMsg);

  LogEvent('EXIT: TMasterTunnel.DoInterpretMsg');
end;


// Disconnect all services owned by tunnel thread
procedure TMasterTunnel.DisconnectAllSubThreads(TunnelThread: TWinshoeServerThread);
var
  Thread: MClientThread;
  i: integer;
  listTemp: TList;
begin
  LogEvent('ENTER: TMasterTunnel.DisconnectAllSubThreads');

  OnlyOneThread.Enter; // for now it is done with locking
  listTemp := Clients.LockList;
  try
    for i := 0 to pred(listTemp.count) do begin
      if Assigned(listTemp[i]) then begin
        Thread := MClientThread(listTemp[i]);
        if Thread.MasterThread = TunnelThread then begin
          Thread.DisconnectedOnRequest := True;
          Thread.OutboundClient.Disconnect;
        end;
      end;
    end;
  finally
    Clients.UnlockList;
    OnlyOneThread.Leave;
  end;

  LogEvent('EXIT: TMasterTunnel.DisconnectAllSubThreads');
end;


procedure TMasterTunnel.SendMsg(MasterThread: TWinshoeServerThread; var Header: THeader; s: String);
var
  user: TSlaveData;
  tmpString: String;
begin
  LogEvent('ENTER: TMasterTunnel.SendMsg');

  TSlaveData(MasterThread.SessionData).Locker.Enter;
  try
    user := TSlaveData(MasterThread.SessionData);
    try
      // Custom data transformation before send
      tmpString := s;
      try
        DoTransformSend(MasterThread, Header, tmpString);
      except
        on E: Exception do begin
          LogEvent('Error in transformation before send: ' + E.Message);
          raise Exception.Create('Error in transformation before send');
        end;
      end;
      if Header.MsgType = 0 then begin // error ocured in transformation
        LogEvent('Error in transformation before send');
        raise Exception.Create('Error in transformation before send');
      end;

      user.Sender.PrepareMsg(Header, PChar(@tmpString[1]), Length(tmpString));
      MasterThread.Connection.Write(user.Sender.Msg);
    except
      LogEvent('Exception durring SendMsg');
      raise;
    end;
  finally
    TSlaveData(MasterThread.SessionData).Locker.Leave;
  end;

  LogEvent('EXIT: TMasterTunnel.SendMsg');
end;

function TMasterTunnel.GetClientThread(UserID: Integer): MClientThread;
var
  Thread: MClientThread;
  i: integer;
begin
  LogEvent('ENTER: TMasterTunnel.GetClientThread');

  Result := nil;
  with Clients.LockList do
  try
    for i := 0 to Count-1 do begin
      try
        if Assigned(Items[i]) then begin
          Thread := MClientThread(Items[i]);
          if Thread.UserId = UserID then begin
            Result := Thread;
            break;
          end;
        end;
      except
        Result := nil;
        LogEvent('List index error');
      end;
    end;
  finally
    Clients.UnlockList;
  end;

  LogEvent('EXIT: TMasterTunnel.GetClientThread');
end;


procedure TMasterTunnel.DisconectAllUsers;
begin
  LogEvent('ENTER: TMasterTunnel.DisconectAllUsers');

  Threads.TerminateAll;

  LogEvent('EXIT: TMasterTunnel.DisconectAllUsers');
end;


procedure TMasterTunnel.ClientOperation(Operation: Integer; UserId: Integer; s: String);
var
  Thread: MClientThread;
begin

  LogEvent('ENTER: TMasterTunnel.ClientOperation');

  Thread := GetClientThread(UserID);
  if Assigned(Thread) then begin
    Thread.Locker.Enter;
    try
      if not Thread.SelfDisconnected then begin
        case Operation of
          1:
          begin
            try
              Thread.OutboundClient.CheckForDisconnect;
              if Thread.OutboundClient.Connected then
                Thread.OutboundClient.Write(s);
            except
              LogEvent('EXCEPTION: Sending data to the client2');
              try
                Thread.OutboundClient.Disconnect;
              except
                ;
              end;
            end;
          end;

          2:
          begin
            Thread.DisconnectedOnRequest := True;
            try
              Thread.OutboundClient.Disconnect;
            except
              ;
            end;
          end;

        end;

      end;
    finally
      Thread.Locker.Leave;
    end;
  end; // Assigned

  LogEvent('EXIT: TMasterTunnel.ClientOperation');
end;





/////////////////////////////////////////////////////////////////
//
//  MClientThread thread, talks to the service
//
/////////////////////////////////////////////////////////////////
constructor MClientThread.Create(master: TMasterTunnel);
begin
  MasterParent := master;
  FreeOnTerminate := True;
  DisconnectedOnRequest := False;
  SelfDisconnected := False;
  Locker := TCriticalSection.Create;
  MasterParent.Clients.Add(self);
  master.IncNumServices;
  inherited Create(True);
end;

destructor MClientThread.Destroy;
var
  Header: THeader;
begin
  MasterParent.DecNumServices;

  MasterParent.Clients.Remove(self);
  try
    if not DisconnectedOnRequest then begin
       // service disconnected the thread
       try
         Header.MsgType := 2;
         Header.UserId := UserId;
         MasterParent.SendMsg(MasterThread, Header, 'Odklop');
       except
         ;
       end;
    end;

    if OutboundClient.Connected then
      OutboundClient.Disconnect;

  except
    ;
  end;

  MasterThread := nil;

  try
    OutboundClient.Free;
  except
   ;
  end;

  Locker.Free;

  Terminate; // dodano

  inherited Destroy;
end;



// thread which talks to the service
procedure MClientThread.Execute;
var
  s: String;
  Header: THeader;
begin
  try
    while not Terminated do begin

      if OutboundClient.Connected then begin
        if OutboundClient.Readable(-1) then  begin
          s := OutboundClient.ReadBuffer;
          try
            Header.MsgType := 1;
            Header.UserId := UserId;
            MasterParent.SendMsg(MasterThread, Header, s);
          except
            Terminate;
            break;
          end;
        end;
      end
      else begin
        Terminate;
        break;
      end;

    end;
  except
    MasterParent.LogEvent('SERVICE DISCONNECTED - MASTER');
  end;

  Locker.Enter;
  try
    SelfDisconnected := True;
  finally
    Locker.Leave;
  end;

end;
//
// END Master Tunnel classes
///////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////
// Slave Tunnel classes
//
constructor TSlaveTunnel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fbActive := False;
  flConnectedClients := 0;
  fNumberOfConnectionsValue := 0;
  fNumberOfPacketsValue := 0;
  fCompressionRatioValue := 0;
  fCompressedBytes := 0;
  fBytesRead := 0;
  fBytesWrite := 0;

  fbSocketize := False;
  fbAcceptConnections := True;
  SlaveThreadTerminated := False;
  OnlyOneThread := TCriticalSection.Create;
  SendThroughTunnelLock := TCriticalSection.Create;
  GetClientThreadLock := TCriticalSection.Create;
  LockClientNumber := TCriticalSection.Create;
  StatisticsLocker := TCriticalSection.Create;

  Sender := TSender.Create;
  SClient := TWinshoeClient.Create(nil);
  SClient.OnStatus := self.DoStatus;

  ManualDisconnected := False;
  StopTransmiting := False;

end;


destructor TSlaveTunnel.Destroy;
begin

  LogEvent('Enter Destroy');
  fbAcceptConnections := False;
  StopTransmiting := True;
  ManualDisconnected := True;

  Active := False;

//  DisconectAllUsers;

  try
    if SClient.Connected then begin
//      DisconnectedByServer := False;
      SClient.Disconnect;
    end;
  except
    LogEvent('Exception SCLient');
  end;

//  if Assigned(SlaveThread) then
//    if not SlaveThread.Executed then
//      SlaveThread.TerminateAndWaitFor;
  if not SlaveThreadTerminated then
    TerminateTunnelThread;

  LogEvent('Destroying client');
  SClient.Free;
  LogEvent('After Destroying client');

  LogEvent('Destroying SlaveThread');
//  SlaveThread.Terminate;
  LogEvent('After Destroying SlaveThread');

  LockClientNumber.Free;
  OnlyOneThread.Free;
  SendThroughTunnelLock.Free;
  GetClientThreadLock.Free;
  StatisticsLocker.Free;
  LogEvent('Leave Destroy');
  LogEvent('Setting Logger = nil');
  Logger := nil;

  inherited Destroy;
end;

procedure TSlaveTunnel.LogEvent(Msg: String);
begin
  if Assigned(fLogger) then
    fLogger.LogEvent(Msg);
end;

procedure TSlaveTunnel.DoStatus(Sender: TComponent; const sMsg: String);
begin
  LogEvent('ENTER: TSlaveTunnel.DoStatus');

  if Assigned(OnStatus) then
    OnStatus(self, sMsg);

  LogEvent('EXIT: TSlaveTunnel.DoStatus');
end;


procedure TSlaveTunnel.SetActive(pbValue: Boolean);
var
  ErrorConnecting: Boolean;
begin
  LogEvent('ENTER: TSlaveTunnel.SetActive');

  OnlyOneThread.Enter;
  try

    LogEvent('Enter SetActive');
    if fbActive = pbValue then begin
      LogEvent('EXIT: TSlaveTunnel.SetActive');
      exit;
    end;

  //  if not ((csLoading in ComponentState) or (csDesigning in ComponentState)) then begin
      if pbValue then begin
  //      DisconnectedByServer := False;
        ManualDisconnected := False;
        StopTransmiting := False;
        ErrorConnecting := False;
        SClient.Host := fsMasterHost;
        SClient.Port := fiMasterPort;
        try
          SClient.Connect;
        except
          fbActive := False;
          raise Exception.Create('Can''t connect to the Master server');
          //Exit;
        end;
        if not ErrorConnecting then begin
          SlaveThread := TSlaveThread.Create(self);
          SlaveThreadTerminated := False;
          SlaveThread.Resume;
          // Maybe we wait here till authentication of Slave happens
          // here can happen the error if the port is already occupied
          // we must handle this
          try
            inherited Active := True;
            fbActive := True;
          except
            LogEvent('Error Activating the server');
            StopTransmiting := False;
            DisconectAllUsers;
            SClient.Disconnect;
            TerminateTunnelThread;
            fbActive := False;
          end;
        end;
      end
      else begin
        fbAcceptConnections := False;
        StopTransmiting := True;
        ManualDisconnected := True;
        LogEvent('Before inherited active');
        inherited Active := False;       // Cancel accepting new clients
        LogEvent('After inherited active');

        DisconectAllUsers;               // Disconnect existing ones
        LogEvent('Before client disc.');
        SClient.Disconnect;
        LogEvent('After client disc.');
        LogEvent('Before destroy thread');
        TerminateTunnelThread;
        LogEvent('After destroy thread');

        fbActive := pbValue;
      end;

  //  end;
    //fbActive := pbValue;
    LogEvent('Leave SetActive');

  finally
    OnlyOneThread.Leave;
  end;


  LogEvent('EXIT: TSlaveTunnel.SetActive');
end;

function TSlaveTunnel.GetNumClients: Integer;
begin
//  LogEvent('ENTER: TSlaveTunnel.GetNumClients');

  LockClientNumber.Enter;
  try
    Result := flConnectedClients;
  finally
    LockClientNumber.Leave;
  end;

//  LogEvent('EXIT: TSlaveTunnel.GetNumClients');
end;


procedure TSlaveTunnel.IncNumClients;
begin
//  LogEvent('ENTER: TSlaveTunnel.IncNumClients');

  LockClientNumber.Enter;
  try
    Inc(flConnectedClients);
    SetStatistics(NumberOfConnectionsType, 0);
  finally
    LockClientNumber.Leave;
  end;

//  LogEvent('EXIT: TSlaveTunnel.IncNumClients');
end;

procedure TSlaveTunnel.DecNumClients;
begin
  LogEvent('ENTER: TSlaveTunnel.DecNumClients');

  LockClientNumber.Enter;
  try
    Dec(flConnectedClients);
  finally
    LockClientNumber.Leave;
  end;

  LogEvent('EXIT: TSlaveTunnel.DecNumClients');
end;



procedure TSlaveTunnel.SetStatistics(Module: Integer; Value: Integer);
var
  packets: Real;
  ratio: Real;
begin
  StatisticsLocker.Enter;
  try
    case Module of
      NumberOfConnectionsType:
        begin
          Inc(fNumberOfConnectionsValue);
        end;
      NumberOfPacketsType:
        begin
          Inc(fNumberOfPacketsValue);
        end;
      CompressionRatioType:
        begin
          ratio := fCompressionRatioValue;
          packets := fNumberOfPacketsValue;
          ratio := (ratio/100.0 * (packets - 1.0) + Value/100.0) / packets;

          fCompressionRatioValue := Trunc(ratio * 100);
        end;
      CompressedBytesType:
        begin
          fCompressedBytes := fCompressedBytes + Value;
        end;
      BytesReadType:
        begin
          fBytesRead := fBytesRead + Value;
        end;
      BytesWriteType:
        begin
          fBytesWrite := fBytesWrite + Value;
        end;
    end;
  finally
    StatisticsLocker.Leave;
  end;
end;


procedure TSlaveTunnel.GetStatistics(Module: Integer; var Value: Integer);
begin
  StatisticsLocker.Enter;
  try
    case Module of
      NumberOfConnectionsType:
        begin
          Value := fNumberOfConnectionsValue;
        end;
      NumberOfPacketsType:
        begin
          Value := fNumberOfPacketsValue;
        end;
      CompressionRatioType:
        begin
          if fCompressedBytes > 0 then
            Value := Trunc((fBytesRead * 1.0) / (fCompressedBytes * 1.0) * 100.0)
          else
            Value := 0;
        end;
      CompressedBytesType:
        begin
          Value := fCompressedBytes;
        end;
      BytesReadType:
        begin
          Value := fBytesRead;
        end;
      BytesWriteType:
        begin
          Value := fBytesWrite;
        end;
    end;
  finally
    StatisticsLocker.Leave;
  end;
end;


////////////////////////////////////////////////////////////////
//
//  CLIENT SERVICES
//
////////////////////////////////////////////////////////////////
procedure TSlaveTunnel.DoConnect(Thread: TWinshoeServerThread);
const
  MAXLINE=255;
var
  SID: Integer;
  s: String;
  req: TSocksRequest;
  res: TSocksResponse;
  numread: Integer;
  Header: THeader;
begin
  LogEvent('ENTER: TSlaveTunnel.DoConnect');

  if not fbAcceptConnections then begin
    Thread.Connection.Disconnect;
    // don't allow to enter in OnExecute
    raise Exception.Create ('Don''t allow connctions now');
  end;

  IncNumClients;

  Thread.SessionData := TClientData.Create;

  // Socket version begin
  if fbSocketize then begin
    try
      s := Thread.Connection.Read(8);
    except
      try
        Thread.Connection.Disconnect;
      except
        ;
      end;
//      LogEvent('Except connecting through socksd');
      Thread.Terminate;
      Exit;
    end;

    if Length(s) = 8 then begin
      Move(s[1], req, 8);
    end
    else begin
    end;

    numread := 0;
    repeat begin
      s := Thread.Connection.Read(1);
      req.UserId[numread+1] := s[1];
      Inc(numread);
    end
    until ((numread >= MAXLINE) or (s[1]=#0));
    SetLength(req.UserId, numread);

    numread := strlen(WinsockInterface.inet_ntoa(req.IpAddr));
    SetString(s, WinsockInterface.inet_ntoa(req.IpAddr), numread);


    res.Version := 0;
    res.OpCode := 90;
    res.Port := req.Port;
    res.IpAddr := req.IpAddr;
    SetString(s, PChar(@res), SizeOf(res));
    Thread.Connection.Write(s);
  end;

  with TClientData(Thread.SessionData) do begin
    //Id := Thread.ThreadID;
    Id := Thread.Handle; //original
    SID := Id;
    TimeOfConnection := Now;
    DisconnectedOnRequest := False;
    if fbSocketize then begin
      Port := WinsockInterface.ntohs(req.Port);
      IpAddr := req.IpAddr;
    end
    else begin
      Port := self.Port;
      IpAddr.S_addr := 0;
    end;
    Header.Port := Port;
    Header.IpAddr := IpAddr;
  end;

  Header.MsgType := 3;
  Header.UserId := SID;
  SendMsg(Header, 'Connecting');

  LogEvent('EXIT: TSlaveTunnel.DoConnect');
end;

procedure TSlaveTunnel.DoDisconnect(Thread: TWinshoeServerThread);
var
  Header: THeader;
begin
  LogEvent('ENTER: TSlaveTunnel.DoDisconnect');

try
  with TClientData(Thread.SessionData) do begin
    if DisconnectedOnRequest = False then begin
      Header.MsgType := 2;
      Header.UserId := Id;
      SendMsg(Header, 'Disconnect');
    end;
  end;

  DecNumClients;
except
  on EInvalidPointer do LogEvent('EX IN DISCONNECT');
  else LogEvent('EX IN DISCONNECT2');
end;

  LogEvent('EXIT: TSlaveTunnel.DoDisconnect');
end;

// Thread to communicate with the user
// reads the requests and transmits them through the tunnel
function TSlaveTunnel.DoExecute(Thread: TWinshoeServerThread): boolean;
var
  user: TClientData;
  s: String;
  Header: THeader;
begin
  LogEvent('ENTER: TSlaveTunnel.DoExecute');
  if Thread.Connection.Readable(-1) then  begin
    s := Thread.Connection.ReadBuffer;
    try
      user := TClientData(Thread.SessionData);
      Header.MsgType := 1;
      Header.UserId := user.Id;
      SendMsg(Header, s);
    except
      LogEvent('Exception sending');
      Thread.Connection.Disconnect;
      raise;
    end;
  end;

  Result := True;

  LogEvent('EXIT: TSlaveTunnel.DoExecute');
end;

procedure TSlaveTunnel.SendMsg(var Header: THeader; s: String);
var
  tmpString: String;
begin

  LogEvent('ENTER: TSlaveTunnel.SendMsg');

  SendThroughTunnelLock.Enter;
  LogEvent('Send enter');
  try
    try

      if not StopTransmiting then begin
        LogEvent('Sending message...');
        if Length(s) > 0 then begin
          try
            // Custom data transformation before send
            tmpString := s;
            try
              DoTransformSend(Header, tmpString);
            except
              on E: Exception do begin
                LogEvent('Error transforming data. ' + E.Message);
                raise;
              end;
            end;
            if Header.MsgType = 0 then begin // error ocured in transformation
              raise Exception.Create('Error in transformation before send');
            end;

            try
            Sender.PrepareMsg(Header, PChar(@tmpString[1]), Length(tmpString));
            except
              LogEvent('Exception preparing before send'); //
              raise;
            end;

            try
              SClient.Write(Sender.Msg);
            except
              LogEvent('Katastrofalna '); // Katastrofalna napaka, odklopit moramo tunnel in se ponovno priklopiti
              StopTransmiting := True;
              raise;
            end;
          except
            ;
            raise;
          end;
        end
      end;

    except
      LogEvent('EX IN SENDMSG2');
      SClient.Disconnect;
    end;

  finally
    LogEvent('Send leave');
    SendThroughTunnelLock.Leave;
  end;

  LogEvent('EXIT: TSlaveTunnel.SendMsg');
end;

procedure TSlaveTunnel.DoBeforeTunnelConnect(var Header: THeader; var CustomMsg: String);
begin
  LogEvent('ENTER: TSlaveTunnel.DoBeforeTunnelConnect');

  if Assigned(fOnBeforeTunnelConnect) then
    fOnBeforeTunnelConnect(Header, CustomMsg);

  LogEvent('EXIT: TSlaveTunnel.DoBeforeTunnelConnect');
end;

procedure TSlaveTunnel.DoTransformRead(Receiver: TReceiver);
begin
  LogEvent('ENTER: TSlaveTunnel.DoTransformRead');

  if Assigned(fOnTransformRead) then
    fOnTransformRead(Receiver);

  LogEvent('EXIT: TSlaveTunnel.DoTransformRead');
end;

procedure TSlaveTunnel.DoInterpretMsg(var CustomMsg: String);
begin
  LogEvent('ENTER: TSlaveTunnel.DoInterpretMsg');

  if Assigned(fOnInterpretMsg) then
    fOnInterpretMsg(CustomMsg);

  LogEvent('EXIT: TSlaveTunnel.DoInterpretMsg');
end;

procedure TSlaveTunnel.DoTransformSend(var Header: THeader; var CustomMsg: String);
begin
  LogEvent('ENTER: TSlaveTunnel.DoTransformSend');

  if Assigned(fOnTransformSend) then
    fOnTransformSend(Header, CustomMsg);

  LogEvent('EXIT: TSlaveTunnel.DoTransformSend');
end;

procedure TSlaveTunnel.DoTunnelDisconnect(Thread: TSlaveThread);
begin
  LogEvent('ENTER: TSlaveTunnel.DoDisconnect');

  try
    StopTransmiting := True;
    if not ManualDisconnected then begin
      if Active then begin
        Active := False;
      end;
    end;
  except
    LogEvent('Exception during TSlaveTunnel.DoDisconnect');
  end;

  If Assigned(OnTunnelDisconnect) then
    OnTunnelDisconnect(Thread);

  LogEvent('EXIT: TSlaveTunnel.DoDisconnect');
end;

procedure TSlaveTunnel.OnTunnelThreadTerminate(Sender:TObject);
begin
// Samo nastavimo status
  SlaveThreadTerminated := True;

//  if SClient.Connected then
//    SClient.Disconnect;
//  DoTunnelDisconnect(SlaveThread);
end;


function TSlaveTunnel.GetClientThread(UserID: Integer): TWinshoeServerThread;
var
  user: TClientData;
  Thread: TWinshoeServerThread;
  i: integer;
begin

  LogEvent('ENTER: TSlaveTunnel.GetClientThread');

//  GetClientThreadLock.Enter;
  LogEvent('Enter GetClientThread =========');
  Result := nil;
  with Threads.LockList do
  try
    try
      for i := 0 to Count-1 do begin
        try
          if Assigned(Items[i]) then begin
            Thread := TWinshoeServerThread(Items[i]);
            if Assigned(Thread.SessionData) then begin
              user := TClientData(Thread.SessionData);
              if user.Id = UserID then begin
                Result := Thread;
                break;
              end;
            end;
          end;
        except
          LogEvent('List index error');
          Result := nil;
        end;
      end;
    except
      Result := nil;
      LogEvent('EX IN GET THR ID2');
    end;
  finally
    Threads.UnlockList;
    LogEvent('Exit GetClientThread =========');
//    GetClientThreadLock.Leave;
  end;


  LogEvent('EXIT: TSlaveTunnel.GetClientThread');
end;


procedure TSlaveTunnel.TerminateTunnelThread;
begin
  OnlyOneThread.Enter;
  try
    if Assigned(SlaveThread) then begin
      if GetCurrentThreadID <> SlaveThread.ThreadID then begin
        SlaveThread.TerminateAndWaitFor;
        SlaveThread.Free;
        SlaveThread := nil;
      end else begin
        SlaveThread.FreeOnTerminate := True;
      end;
    end;
  finally
    OnlyOneThread.Leave;
  end;
end;



procedure TSlaveTunnel.ClientOperation(Operation: Integer; UserId: Integer; s: String);
var
  Thread: TWinshoeServerThread;
  user: TClientData;
begin
  LogEvent('ENTER: TSlaveTunnel.ClientOperation');

  if not StopTransmiting then begin

    LogEvent('Before GetClientThread');
    Thread := GetClientThread(UserID);
    LogEvent('After GetClientThread');
    LogEvent('Operation: ' + IntToStr(Operation));
    if Assigned(Thread) then begin

      try

        case Operation of
          1:
          begin
            LogEvent('Before send');
            try
              if Thread.Connection.Connected then begin
                try
                  if not Assigned(Thread) then LogEvent('HERE IS THE DEVIL');
                  Thread.Connection.Write(s);
                except
                  LogEvent('Exception Writing to client');
                end;
              end;
            except
              try
                Thread.Connection.Disconnect;
              except
              end;
            end;
            LogEvent('After send');
          end;

          2:
          begin
            LogEvent('Before disconnecting');
            user := TClientData(Thread.SessionData);
            user.DisconnectedOnRequest := True;
            Thread.Connection.Disconnect;
            LogEvent('After disconnecting');
          end;
        end;

      except
        LogEvent('Exception in ClientOperation');
      end;
    end
    else begin
      LogEvent('Thread Id is NIL');
    end;

  end; // if StopTransmiting

  LogEvent('EXIT: TSlaveTunnel.ClientOperation');
end;

procedure TSlaveTunnel.DisconectAllUsers;
begin
  LogEvent('ENTER: TSlaveTunnel.DisconectAllUsers');

  Threads.TerminateAll;

  LogEvent('EXIT: TSlaveTunnel.DisconectAllUsers');
end;
//
// END Slave Tunnel classes
///////////////////////////////////////////////////////////////////////////////

constructor TClientData.Create;
begin
  Locker := TCriticalSection.Create;
  SelfDisconnected := False;
end;

destructor TClientData.Destroy;
begin
  Locker.Free;
  inherited;
end;

///////////////////////////////////////////////////////////////////////////////
// Logging class
//
constructor TLogger.Create(LogFileName: String);
begin
  fbActive := False;
  OnlyOneThread := TCriticalSection.Create;
  try
    AssignFile(fLogFile, LogFileName);
    Rewrite(fLogFile);
    fbActive := True;
  except
    fbActive := False; //self.Destroy; // catch file i/o errors, double create file
  end;
end;

destructor TLogger.Destroy;
begin
  if fbActive then
    CloseFile(fLogFile);
  OnlyOneThread.Free;
  inherited;
end;

procedure TLogger.LogEvent(Msg: String);
begin
  OnlyOneThread.Enter;
  try
    WriteLn(fLogFile, Msg);
    Flush(fLogFile);
  finally
    OnlyOneThread.Leave;
  end;
end;
//
// Logging class
///////////////////////////////////////////////////////////////////////////////


constructor TSlaveThread.Create(Slave: TSlaveTunnel);
begin
  SlaveParent := Slave;
//  FreeOnTerminate := True;
  FreeOnTerminate := False;
  FExecuted := False;
  FConnection := Slave.SClient;
  OnTerminate := Slave.OnTunnelThreadTerminate;
  InitializeCriticalSection(FLock);
  Receiver := TReceiver.Create;
  inherited Create(True);
end;

destructor TSlaveThread.Destroy;
begin
//  Executed := True;
  Connection.Disconnect;
  Receiver.Free;
  DeleteCriticalSection(FLock);
  inherited Destroy;
end;


procedure TSlaveThread.SetExecuted(Value: Boolean);
begin
  Lock;
  try
    FExecuted := Value;
  finally
    Unlock;
  end;
end;

function TSlaveThread.GetExecuted: Boolean;
begin
  Lock;
  try
    Result := FExecuted;
  finally
    Unlock;
  end;
end;

procedure TSlaveThread.Execute;
begin
  inherited;
  Executed := True;
end;

procedure TSlaveThread.Run;
var
  Header: THeader;
  s: String;
  CustomMsg: String;
begin
  try
    if Connection.Readable(-1) then begin
      Receiver.Data := Connection.ReadBuffer;

      // increase the packets counter
      SlaveParent.SetStatistics(NumberOfPacketsType, 0);

      while (Receiver.TypeDetected) and (not Terminated) do begin
        if Receiver.NewMessage then begin
          if Receiver.CRCFailed then begin
            SlaveParent.LogEvent('CRC Failed');
            raise Exception.Create('CRC Failed');
          end;

          try
          // Custom data transformation
            SlaveParent.DoTransformRead(Receiver);
          except
            SlaveParent.LogEvent('Do transform failed');
            raise Exception.Create('DoTransform failed');
          end;

          // Action
          case Receiver.Header.MsgType of
            0:  // transformation of data failed, disconnect the tunnel
              begin
                SlaveParent.LogEvent('0 - Message type');
                SlaveParent.ManualDisconnected := False;
                raise Exception.Create('0 - Message type');
              end; // Failure END


            1:  // Data
              begin
                try
                  SetString(s, Receiver.Msg, Receiver.MsgLen);
                  SlaveParent.ClientOperation(1, Receiver.Header.UserId, s);
                except
                  SlaveParent.LogEvent('1 - message handling failed');
                  raise Exception.Create('1 - message handling failed');
                end;
              end; // Data END

            2:  // Disconnect
              begin
                try
                  SlaveParent.ClientOperation(2, Receiver.Header.UserId, '');
                except
                  SlaveParent.LogEvent('2 - message handling failed');;
                  raise Exception.Create('3 - message handling failed');
                end;
              end;

            99:  // Session
              begin
                // Custom data interpretation
                CustomMsg := '';
                SetString(CustomMsg, Receiver.Msg, Receiver.MsgLen);
                try
                  try
                    SlaveParent.DoInterpretMsg(CustomMsg);
                  except
                    raise Exception.Create('DoInterpretMsg failed');
                  end;
                  if Length(CustomMsg) > 0 then begin
                    Header.MsgType := 99;
                    Header.UserId := 0;
                    SlaveParent.SendMsg(Header, CustomMsg);
                  end;
                except
                  SlaveParent.ManualDisconnected := False;
                  raise Exception.Create('Custom interpretation failed');
                end;

              end;

          end; // case

          // Shift of data
          Receiver.ShiftData;

        end
        else
          break;  // break the loop

      end; // end while
    end; // if readable
  except
    on E: EWinshoeSocketError do begin
      case E.LastError of
        10054: Connection.Disconnect;
        else
           begin
             SlaveParent.LogEvent(E.Message);
             //raise;
             Terminate;
           end;
      end;
    end;
    on EWinshoeClosedSocket do ;
  else
    raise;
  end;
  if not Connection.Connected then
    Terminate;
end;

procedure TSlaveThread.AfterRun;
begin
  SlaveParent.DoTunnelDisconnect(self);
//  SlaveParent.TerminateTunnelThread;
end;

procedure TSlaveThread.BeforeRun;
var
  Header: THeader;
  tmpString: String;
begin
  tmpString := '';
  try
    SlaveParent.DoBeforeTunnelConnect(Header, tmpString);
  except
    ;
  end;
  if Length(tmpString) > 0 then begin
    Header.MsgType := 99;
    Header.UserId := 0;
    SlaveParent.SendMsg(Header, tmpString);
  end;

end;

procedure TSlaveThread.Lock;
begin
  EnterCriticalSection(FLock);
end;

procedure TSlaveThread.Unlock;
begin
  LeaveCriticalSection(FLock);
end;


end.
