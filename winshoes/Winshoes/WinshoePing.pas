Unit WinshoePing;
{------------------------------------------------------------------------------}
{ Program Unit : WinshoePing.Pas                                                      }
{ For Program  :  PING                                                         }
{                                                                              }
{ Author       :  Ray Malone                                                   }
{ MBS Software                                                                 }
{ 251 E. 4th St.                                                               }
{ Chillicothe, OH 45601                                                        }
{ Started 08/28/99   Completed  08/29/99                                       }
{                                                                              }
{  MailTo: ray@mbssofware.com                                                  }
{                                                                              }
{ Thie is a Ping Component that does not require the ICMP.DLL or Winsock2.Dll  }
{ It will work with any version of windows 9x or NT 4 or 2000                  }
{ It requres 1.1 Winsock DLL. This is supported by version 1 and all higher    }
{ Versions of the DLL                                                          }
{                                                                              }
{ WinshoePing has just three properties and and 2 events to deal with          }
{                                                                              }
{ The DestHost property is the computer name or IP of the computer to be Pinged}
{  For exmaple either                                                          }
{         DestHost := 'sparticus.eurekanet.com';                               }
{         DestHost := '209.239.128.3';                                         }
{  The time out is set for time to send and time to receive                    }
{   It is in milliseconds The Default is 4000 Ms ... That is 4 Seconds         }
{  ReplyStatus is set if the ping is successful  See TReplyStatus below        }
{                                                                              }
{ There are two events OnStatusChange has a string argument that shows the     }
{  Status of the PING. Address Resolution sending and results                  }
{ OnReply has a ReplyStatus structure as an argument. It contains the          }
{ The Sequence number and the time elapsed on a successful PING.               }
{                                                                              }
{ Revision History                                                             }
{                                                                              }
{ 10/23/99 Added ICMP.DLL Support                                              }
{ 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)              }
{------------------------------------------------------------------------------}

//------------------------------------------------------------------------------
// THIS COMPONENT CAN USE THE Microsoft  ICMP.DLL SEE MODE PROPERTY
//The following is the microsoft warning and documentation for the ICMP.DLL:
//  [DISCLAIMER]
//
//  We have had requests in the past to expose the functions exported from
//  icmp.dll.  The files in this directory are provided for your convenience
//  in building applications which make use of ICMPSendEcho().
//
// Notice that the functions in icmp.dll are not considered part of the
// Win32 API and will not be supported in future releases.  Once we have
// a more complete solution in the operating system, this DLL, and the
// functions it exports, will be dropped.
//
//
//[DOCUMENTATION]
//
// The ICMPSendEcho() function sends an ICMP echo request to the specified
// destination IP address and returns any replies received within the timeout
// specified. The API is synchronous, requiring the process to spawn a thread
// before calling the API to avoid blocking. An open IcmpHandle is required
// for the request to complete. IcmpCreateFile() and IcmpCloseHandle() functions
// are used to create and destroy the context handle.
//-----------------------------------------------------------------------------
//------------------------------------------------------------------------------
// This unit Exposes the three routines from the ICMP.DLL
//
// Routine Name:  IcmpCreateFile
//     Opens a handle on which ICMP Echo Requests can be issued.
// Arguments: None.
// Return Value:
//     An open file handle or INVALID_HANDLE_VALUE. Extended error information
//     is available by calling GetLastError().
//
// Routine Name: IcmpSendEcho
//
//     Sends an ICMP Echo request and returns any replies. The
//     call returns when the timeout has expired or the reply buffer
//     is filled.
//
// Args: IcmpHandle - An open handle returned by ICMPCreateFile.
//       DestinationAddress   - The destination of the echo request.
//       RequestData          - A buffer containing the data to send in the request.
//       RequestSize          - The number of bytes in the request data buffer.
//       RequestOptions       - Ptr to the IP header options for the request. Can be NULL.
//       ReplyBuffer          - A buffer to hold any replies to the request.
//       ReplySize            - The size in bytes of the reply buffer.
//       Timeout              - The time in milliseconds to wait for replies.
//
//  On return : the reply buffer will contain an array of ICMP_ECHO_REPLY
//              structures followed by the  options and data for the replies.
//              The buffer should be large enough to hold at least one
//              ICMP_ECHO_REPLY structure plus MAX(RequestSize, 8) bytes of data
//              since an ICMP error message contains 8 bytes of data.
// Return Value: Returns the number of ICMP_ECHO_REPLY structures stored in
//               ReplyBuffer.The status of each reply is contained in the structure.
//               If the return value is zero, extended error information is available via
//               GetLastError().
//
// Routine Name:  IcmpCloseHandle
//     Closes a handle opened by ICMPOpenFile.
// Arguments:  IcmpHandle  - The handle to close.
// Return Value:
//     TRUE if the handle was closed successfully, otherwise FALSE. Extended
//     error information is available by calling GetLastError().
//-----------------------------------------------------------------------------
// This unit also exposes the TWinshoeICMP component which Contains which
//  publishes the method Ping. This Unit only works on computers that have the
//  ICMP.Dll Installed.
//  To use :
//      Drop the tWinshoeICMP Component on a form.
//      Assign the OnPingReply event
//      SetMode to pmICMP
//      Write code to display the EchoReply Var of the PingReply Ent
//      At runtime set the Set the DestHostName Property to the full domain name
//      of the computer to ping.
//      Call the ping method.
//------------------------------------------------------------------------------

Interface

Uses
  Classes,
  SysUtils,
  Windows,
  Winshoes,
  WinsockIntf;

Type
  EICMPException = Class(Exception);

Const
  DEF_PACKET_SIZE = 32;
  MAX_PACKET_SIZE = 1024;
  ICMP_MIN = 8;
  ICMP_ECHO = 8;
  ICMP_ECHOREPLY = 0;

Type
  tpmMode = (pmRAW,pmICMP);

type
  pOptionInfo = ^TOptionInfo;
  TOptionInfo = Packed Record
     TimeToLive  : Byte;
     TypeService : Byte;
     HdrFlags    : Byte;
     OptionDataSize : Byte;
     OptionsData : PChar;
  End;

  PEchoReply = ^TEchoReply;
  TEchoReply = Packed Record
     ReplyAddr    : DWord;
     IPStatus     : DWord;
     RndTripTime  : DWord;
     ReplyDataSize: Word;
     Reserved     : Word;
     ReplyDataPtr : Pointer;
     ReplyOptions : TOptionInfo;    // Reply options
  End;

Const
  cDefaultPacketSize = 128;
  cDefaultReplyBufSize = 1024;

Type
  TIcmpCreateFile  = function: THandle; stdcall;
  TIcmpSendEcho = Function (IcmpHandle:THandle; DestinationAddress : DWord; RequestData : Pointer;
                      RequestSize: Word; RequestOptions: POptionInfo; ReplyBuffer: Pointer;
                      ReplySize: DWord; Timeout: DWord ): DWord; stdcall;
  TIcmpCloseHandle = Function (IcmpHandle : THandle): Boolean; StdCall;

Type
 tDataBuf = Array[1..Max_Packet_Size] Of Char;
 TICMPDataBuffer = Array [1..cDefaultPacketSize] Of Byte;

Type
 { Internet Protocol Header }
 tIPHeader = Record
   VerLen : Byte;         { 1st nibble is version 2nd Nibble Num Bytes in header div 4 }
   Tos : Byte;            { Type Of Service                                            }
   Total_Len : Word;      { Total length of header and data in Bytes (Octets)          }
   Ident : Word;          { Message Identifier                                         }
   Frag_And_Flags : Word; { 1st nibble is Flags next 3 nibbles is fragment offset      }
   TTL : Byte;            { Time to live. Packet is destroyed if has not arrived in TTL}
   Proto : Byte;          {  Proto type                                                }
   CheckSum : Word;       { Check sum for confirming arival with out corruption        }
   SourceIp : Dword;      { The IP Address of the sender                               }
   DestIp : Dword;        { IPAddress of Receiving computer                            }
   Options : Dword;       {  Options and padding not used in PING                      }
 End;

Type
  {Internet Control Message Protocol Header }
  TIcmpHeader = Record
    i_type : Byte;          { Type Of Message ICMP_Echo in Sent PING     }
    i_code : Byte;          { Zero for request or reply ??? who knows    }
    i_checkSum : Word;      { A ones complement check sum (NOT CRC)      }
    i_Id : Word;            { to match requests and replies. Zero is OK  }
    i_seq : Word;           { A Sequence num to match requets an replies }
    OTimeStamp : ULong;     { Time Msg sent. Used to cald elapsed time   }
    RTimeStamp : ULong;
    TTimeStamp : ULong;
  End;

Type
  tReplyStatus = Record
    BytesReceived : Integer; {Number of bytes in the reply from Pinged computer }
    FromIpAddress :String;   { IP address of computer repling to PING           }
    MsgType : Byte;
    SequenceId : Word;       { Id to tell one PING Reply from another           }
    MsRoundTripTime : DWord; { Time for PIng round trip in Milliseconds         }
  End;

Type
  tOnReplyEvent = Procedure( Const ReplyStatus : TReplyStatus) Of Object;
  tOnStatusChangeEvent = Procedure(Const Status :String) Of Object;

Type
 TWinshoePing = Class(TWinshoeBase)
 Private
    fOnReply : TOnReplyEvent;
    fOnStatusChange : TOnStatusChangeEvent;
    fMode : TpmMode;
    fIcmpHandle : Thandle;
    fDestIPAddrDWord : DWord;
    fDestHostIpStr,
    fDestHostNameStr : String;
    FRawSocket : TSocket;
    ftimeOut : Integer;
    FromAddr,
    DestAddr : TSockAddr;
    AddrLen,
    DataSize : Integer;
    Seq_No : Word;
    fReplyStatus : TReplyStatus;
    RequestData : TICMPDataBuffer;
    RecivBuf : TDataBuf;
    IcmpData : TDataBuf;
  Protected

    ICMPdllHandle : THandle;
    ICMPDllLoaded : boolean;
    IcmpCreateFile :  TIcmpCreateFile;
    IcmpCloseHandle : TIcmpCloseHandle;
    IcmpSendEcho :    TIcmpSendEcho;
    PROCEDURE SetDestinationAddress;
    Procedure CreateRawSocket;
    Procedure SetRawSocketTimeOuts;
    Function CalcCheckSum: Word;
    Procedure SetICMPData;
    Procedure SendREquest;
    Procedure DecodeResponse(bytesRead : Integer);
    Procedure GetReply;
    PROCEDURE DoRawPing;
    PROCEDURE GetICMPHandle;
    PROCEDURE LoadICMPdll;
    PROCEDURE DoICMPPing;
  Public
    Constructor  Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure Ping;
  Published
     PROPERTY MODE : tPmMode Read fMode write fMode;
     Property DestHost : String Read  fDestHostNameStr Write  fDestHostNameStr;
     Property TimeOut : Integer Read fTimeOut Write fTimeOut;
     Property OnReply : TOnReplyEvent Read fOnReply Write fOnReply;
     Property OnStatusChange : TOnStatusChangeEvent Read fOnStatusChange  Write fOnStatusChange;
     Property ReplyStatus : TReplyStatus Read FReplyStatus;
  End;

// Procs
  Procedure Register;

Implementation

 Const
   IcmpDll  = 'Icmp.dll';

  Procedure Register;
  Begin
    RegisterComponents('Winshoes Clients', [TWinshoePing]);
  End;

  Constructor TWinshoePing.Create(AOwner: TComponent);
  Begin
    Inherited Create(AOwner);
    IcmpDllLoaded := False;
    Seq_No := 0;
    AddrLen := SizeOf( TSockAddr);
  End;

  Destructor TWinshoePing.Destroy;
  Begin
     if ICMPDllLoaded  then
        FreeLibrary(ICMPdllHandle);
    Inherited Destroy;
  End;

  PROCEDURE TWinshoePing.SetDestinationAddress;
  Begin
    FillChar(DestAddr,SizeOf(DestAddr),0);
    DestAddr.Sin_Addr.S_Addr := TWinshoe.ResolveHost( fDestHostNameStr ,fDestHostIpStr);
    DestAddr.Sin_Family := AF_INET;
  end;

  Procedure TWinshoePing.CreateRawSocket;
  Begin
    fRawSocket := WinsockInterface.Socket(AF_INET, SOCK_RAW, IPProto_ICMP);
    If fRawSocket = INVALID_SOCKET Then
      Raise EICMPException.Create('Ping Create Socket Error : '
                                 +WinsockInterface.TranslateSocketErrorMsg(GetLastError));
  End;

  Procedure TWinshoePing.SetRawSocketTimeOuts;
  Var
    Res : Integer;
    Size : Integer;
  Begin
    If FtimeOut = 0 Then
      fTimeOut := 4000;
    Size := sizeOf(TimeOut);
    Res := WinsockInterface.setsockopt(fRawSocket, SOL_SOCKET, SO_RCVTIMEO, @TimeOut, Size);
    If Res = SOCKET_ERROR Then
      Raise EICMPException.Create('Failed To set Received Time Out: '
                            +WinsockInterface.TranslateSocketErrorMsg(GetLastError));
    Res := WinsockInterface.setsockopt(fRawSocket, SOL_SOCKET, SO_SNDTIMEO, @TimeOut, Size);
    If Res = SOCKET_ERROR Then
      Raise EICMPException.Create('Failed To set Send Time Out: '
                                  +WinsockInterface.TranslateSocketErrorMsg(GetLastError));
  End;

  Function TwinshoePing.CalcCheckSum: Word;
  Type
    tWordArray = Array[1..512] Of Word;
  VAr
    PtrWordArray : ^tWordarray;
    CkSum : Dword;
    NumWords,
    Remainder : Integer;
    Idx : Integer;
  Begin
    NumWords := DataSize Div 2;
    Remainder := Datasize Mod 2;
    PtrWordArray := @IcmpData;
    CkSum := 0;
    For Idx := 1 To NumWords Do
      CkSum := CkSum + PtrWordArray^[Idx];
    If Remainder <> 0 Then
      CkSum := CkSum + Byte(IcmpData[DataSize]);
    CkSum := (CkSum Shr 16)  + (CkSum And $FFFF);
    CkSum := CkSum + (CkSum Shr 16);
    Result := Word( Not CkSum);
  End;

  Procedure TWinshoePing.SetICMPData;
  Var
    PtrIcmpHeader : ^TICMPHeader;
    Idx : Integer;
  Begin
    FillChar(IcmpData,SizeOf(IcmpData),0);
    PtrIcmpHeader := @IcmpData;
    With PtrIcmpHeader^ Do Begin
      i_type := ICMP_ECHO;
      i_code := 0;
      i_Id := Word(GetCurrentProcessId);
       OTimeStamp := GetTickcount;
      Inc(Seq_No);
      i_Seq := Seq_No;
      Idx := Succ(SizeOf(TicmpHeader));
      While Idx <= DataSize Do Begin
        IcmpData[Idx] := 'E';
        Inc(Idx);
      End;
      i_CheckSum := CalcCheckSum;
    End;
  End;

  Procedure TwinshoePing.SendRequest;
  Var
    BytesWritten : Integer;
  Begin
    BytesWritten := WinsockInterface.sendto(fRawSocket, IcmpData, DataSize, 0, DestAddr, AddrLen);
    If BytesWritten = SOCKET_ERROR Then
      Raise EICMPException.Create('Ping Send Failed. Error '
                                   +WinsockInterface.TranslateSocketErrorMsg(GetLastError));
  End;

  Procedure TWinshoePing.DecodeResponse( bytesRead :Integer);
  Var
    PtrIPHeader : ^TIPHeader;
    PtrICMPHeader : ^TICMPHeader;
    IpHdrLen : Integer;
  begin
    PtrIpHeader := @REcivBuf;
    IpHdrLen := (PtrIpHeader^.VerLen And $0F) *4;
    If (bytesRead  < IpHdrLen + ICMP_MIN)Then
      Raise EICMPException.Create('Ping Error. Too few bytes received from '
                                  + WinsockInterface.inet_ntoa(fromAddr.sin_addr));
    PtrIcmpHeader := @RecivBuf[IpHdrLen+1];
    If (PtrIcmpHeader^.i_type <> ICMP_ECHOREPLY) Then
      Raise EICMPException.Create( 'Ping Error Non-Echo type reponse '
                                  +IntToStr(PtrIcmpHeader^.I_type)+' received.');
    If (PtrIcmpheader^.i_id <> Word(GetCurrentProcessId)) Then
      Raise  EICMPException.Create('Ping Error Recieved someone else''s packet');
    With FReplyStatus Do Begin
      BytesReceived := BytesRead;
      FromIpAddress := WinsockInterface.inet_ntoa(FromAddr.sin_addr);
      MsgType := PtrIcmpHeader^.i_Type;
      SequenceId :=   PtrIcmpheader^.i_seq;
      MsRoundTripTime := GetTickCount - PtrIcmpHeader^.OTimeStamp;
    End;
    If Assigned(FOnStatusChange) Then
      FOnStatusChange('Ping of '+fDestHostIPStr +' took '
                      +IntToStr(FReplyStatus.MsRoundTripTime)+' Ms.');
    If Assigned(fonReply) Then
      FonReply(FReplyStatus);
  End;

  Procedure TWinshoePing.GetReply;
  Var
    BytesRead : Integer;
    Size : Integer;
    Flags : Integer;
  Begin
    FillChar(RecivBuf,SizeOf(RecivBuf),0);
    FillChar(FromAddr,SizeOf(FromAddr),0);
    Size := Sizeof(RecivBuf);
    Flags := 0;
    BytesRead := WinsockInterface.recvfrom(fRawSocket,RecivBuf,Size,Flags,FromAddr,AddrLen);
    If BytesRead = SOCKET_ERROR Then Begin
      Raise EICMPException.Create('Ping Received Failed. Error is '
                                  +WinsockInterface.TranslateSocketErrorMsg(GetLastError));
    End;
    If Assigned(FOnStatusChange) Then
      FOnStatusChange('Decoding Reply From ' + fDestHostIPStr);
    DecodeResponse(BytesRead);
  End;

  Procedure TWinshoePing.DoRawPing;
  Begin
     If Assigned(FOnStatusChange) Then
       FOnStatusChange('Resolving ' + fDestHostNameStr +' Address');
    SetDestinationAddress;
    If Assigned(FOnStatusChange) Then
      FOnStatusChange('IPAddress is ' +fDestHostIPStr +' Sending Request');
    CreateRawSocket;
    SetRawSocketTimeOuts;
    DataSize := def_Packet_Size + sizeof(TIcmpHeader);
    SetICMPData;
    SendRequest;
    GetReply;
    WinsockInterface.CloseSocket(fRawSocket);
  End;


  PROCEDURE TWinshoePing.GetICMPHandle;
  Begin
    fIcmpHandle := IcmpCreateFile;
    If fIcmpHandle = INVALID_HANDLE_VALUE Then
      Raise EIcmpException.Create('IcmpCreatefile Failed.');
  End;


  PROCEDURE tWinshoePing.LoadICMPdll;
  var
    Buff : Array [0..255] of Char;
    PathStr : STring;
    Res : DWord;
  Begin
    Res := GetSystemDirectory(Buff,SizeOf(buff));
    If Res = 0 then
       Raise EICMPException.Create('Ping GetSystem Directory Error :'
                                    +IntToStr(GetLastError) );
    PathStr := String(Buff);
    IF PathStr[Length(PathStr)] <> '\' then
      PathStr := PathStr +'\';
    PathStr := PathStr + 'ICMP.Dll';
    IcmpDllHandle := LoadLibrary(Pchar(PathStr));
    if IcmpDllhandle = 0 then
        raise EICMPException.Create('Unable to register ICMP.DLL '+IntToStr(GetLastError));
    @ICMPCreateFile  := GetProcAddress(IcmpDllhandle, 'IcmpCreateFile');
    if (@ICMPCreateFile = Nil) then
         raise EICMPException.Create('Error loading ICMP.DLL');
    @IcmpCloseHandle := GetProcAddress(IcmpDllhandle, 'IcmpCloseHandle');
    if (@ICMPCreateFile = Nil) then
         raise EICMPException.Create('Error loading ICMP.DLL');
    @IcmpSendEcho := GetProcAddress(IcmpDllhandle, 'IcmpSendEcho');
    if (@ICMPCreateFile = Nil) then
         raise EICMPException.Create('Error loading ICMP.DLL');
    ICMPDllLoaded := True;
  End;

  Procedure TWinshoePing.DoICMPPing;
  Var
    ReplyPtr : PEchoReply;
    ReplySize : Integer;
    NumReplies : Integer;
  Begin
    If Not ICMPDllLoaded then LoadICMPdll;
    If Assigned(fOnStatusChange) then
      fOnStatusChange('Creating  File Handle');
    Try
      GetICMPHandle;
    Except
      On Exception Do begin
        If Assigned(fOnStatusChange) then
          fOnStatusChange('Icmp Createfile Failed');
        Raise;
      End;
    End;
    If Assigned(FOnStatusChange) Then
      FOnStatusChange('Resolving ' + fDestHostNameStr +' Address');
    fDestIPAddrDWord  :=  TWinshoe.ResolveHost( fDestHostNameStr ,fDestHostIpStr);
    If Assigned(FOnStatusChange) Then
      FOnStatusChange('IPAddress is ' +fDestHostIPStr +' Sending Request');
    FillChar(RequestData,SizeOf(RequestData),0);
    FillChar(fReplyStatus,SizeOf(FReplyStatus),0);
    If FTimeOut = 0 Then
      FTimeOut := 4000;
    ReplyPtr := AllocMem(cDefaultReplyBufSize);
    Try
      ReplySize := cDefaultReplyBufSize;
      If Assigned(fOnStatusChange) then
        fOnStatusChange('Attempting to Ping '+ fDestHostIpStr);
      NumReplies := ICMPSendEcho(fIcmpHandle,FDestIpAddrDword,
                                 @RequestData,SizeOf(RequestData),Nil,
                                 ReplyPtr,ReplySize,FTimeOut);
      If NumReplies > 0 Then Begin
        With ReplyPtr^ do Begin
          fReplyStatus.FromIpAddress := WinsockInterface.inet_ntoa(TINAddr(ReplyAddr));
          fREplyStatus.MsRoundTripTime := RndTripTime;
          fReplyStatus.BytesReceived := ReplyDataSize;
        End;
        If Assigned(fOnStatusChange) then
          fOnStatusChange('Ping of '+fDestHostIPStr +' was Successful');
        If Assigned( fOnReply ) Then
          fOnReply(fReplyStatus);
      End
      Else Begin
        Raise EICMPException.Create('Ping IcmpSendEcho Failed.'+#13
                       +WinsockInterface.TranslateSocketErrorMsg(GetLastError));
      End;
    Finally;
      IcmpCloseHandle(fIcmpHandle);
      FreeMem(ReplyPtr,cDefaultReplyBufSize);
    End;
  End;

  Procedure TWinshoePing.Ping;
  Begin
    if fMode = pmRAW then
      DoRawPing
    else
      DoICMPPing;
  End;

End.
