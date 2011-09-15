unit WinsockIntf;

(*
This unit is meant to be an encapselation of Winsock, and not an abstraction. Calls to Winsock
should be minimally wrapped. Abstraction should be left to Winshoes.pas and others.

Eventually no other unit should be allowed to call directly to Winsock. All calls should be
performed through this unit.

It has many uses, but one upcoming future ability that will be put in this unit is the dynamic
loading of Winsock, and thus also allowing the "swapping" of Winsock.dll's.
*)

interface

uses
  SysUtils
  , Windows, Winsock;

const
  // "Proxy" these so other units do not need to use Winsock.pas
  AF_INET = Winsock.AF_INET;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.AF_INET}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE AF_INET}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE AF_INET}{$ENDIF}
  INADDR_ANY = Winsock.INADDR_ANY;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.INADDR_ANY}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE INADDR_ANY}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE INADDR_ANY}{$ENDIF}
  INADDR_NONE = Winsock.INADDR_NONE;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.INADDR_NONE}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE INADDR_NONE}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE INADDR_NONE}{$ENDIF}
  INVALID_SOCKET = Winsock.INVALID_SOCKET;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.INVALID_SOCKET}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE INVALID_SOCKET}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE INVALID_SOCKET}{$ENDIF}
  IPPROTO_TCP = Winsock.IPPROTO_TCP;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.IPPROTO_TCP}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE IPPROTO_TCP}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE IPPROTO_TCP}{$ENDIF}
  IPPROTO_IP = Winsock.IPPROTO_IP;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.IPPROTO_IP}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE IPPROTO_IP}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE IPPROTO_IP}{$ENDIF}
  IPProto_ICMP = Winsock.IPProto_ICMP;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.IPProto_ICMP}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE IPProto_ICMP}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE IPProto_ICMP}{$ENDIF}
  PF_INET = Winsock.PF_INET;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.PF_INET}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE PF_INET}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE PF_INET}{$ENDIF}
  SOCKET_ERROR = Winsock.SOCKET_ERROR;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.SOCKET_ERROR}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE SOCKET_ERROR}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE SOCKET_ERROR}{$ENDIF}
  SOCK_STREAM = Winsock.SOCK_STREAM;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.SOCK_STREAM}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE SOCK_STREAM}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE SOCK_STREAM}{$ENDIF}
  SOCK_DGRAM = Winsock.SOCK_DGRAM;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.SOCK_DGRAM}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE SOCK_DGRAM}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE SOCK_DGRAM}{$ENDIF}
  SOCK_RAW = Winsock.SOCK_RAW;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.SOCK_RAW}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE SOCK_RAW}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE SOCK_RAW}{$ENDIF}
  SOL_SOCKET = Winsock.SOL_Socket;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.SOL_SOCKET}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE SOL_SOCKET}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE SOL_SOCKET}{$ENDIF}
  SO_RCVTIMEO = Winsock.SO_RCVTIMEO;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.SO_RCVTIMEO}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE SO_RCVTIMEO}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE SO_RCVTIMEO}{$ENDIF}
  SO_SNDTIMEO = Winsock.SO_SNDTIMEO;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.SO_SNDTIMEO}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE SO_SNDTIMEO}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE SO_SNDTIMEO}{$ENDIF}
  TCP_NODELAY = Winsock.TCP_NODELAY;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.TCP_NODELAY}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE TCP_NODELAY}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE TCP_NODELAY}{$ENDIF}
  //
  WSAEINTR = Winsock.WSAEINTR;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEINTR}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEINTR}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEINTR}{$ENDIF}
  WSAEBADF = Winsock.WSAEBADF;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEBADF}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEBADF}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEBADF}{$ENDIF}
  WSAEACCES = Winsock.WSAEACCES;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEACCES}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEACCES}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEACCES}{$ENDIF}
  WSAEFAULT = Winsock.WSAEFAULT;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEFAULT}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEFAULT}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEFAULT}{$ENDIF}
  WSAEINVAL = Winsock.WSAEINVAL;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEINVAL}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEINVAL}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEINVAL}{$ENDIF}
  WSAEMFILE = Winsock.WSAEMFILE;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEMFILE}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEMFILE}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEMFILE}{$ENDIF}
  WSAEWOULDBLOCK = Winsock.WSAEWOULDBLOCK;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEWOULDBLOCK}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEWOULDBLOCK}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEWOULDBLOCK}{$ENDIF}
  WSAEINPROGRESS = Winsock.WSAEINPROGRESS;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEINPROGRESS}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEINPROGRESS}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEINPROGRESS}{$ENDIF}
  WSAEALREADY = Winsock.WSAEALREADY;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEALREADY}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEALREADY}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEALREADY}{$ENDIF}
  WSAENOTSOCK = Winsock.WSAENOTSOCK;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAENOTSOCK}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAENOTSOCK}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAENOTSOCK}{$ENDIF}
  WSAEDESTADDRREQ = Winsock.WSAEDESTADDRREQ;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEDESTADDRREQ}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEDESTADDRREQ}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEDESTADDRREQ}{$ENDIF}
  WSAEMSGSIZE = Winsock.WSAEMSGSIZE;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEMSGSIZE}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEMSGSIZE}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEMSGSIZE}{$ENDIF}
  WSAEPROTOTYPE = Winsock.WSAEPROTOTYPE;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEPROTOTYPE}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEPROTOTYPE}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEPROTOTYPE}{$ENDIF}
  WSAENOPROTOOPT = Winsock.WSAENOPROTOOPT;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAENOPROTOOPT}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAENOPROTOOPT}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAENOPROTOOPT}{$ENDIF}
  WSAEPROTONOSUPPORT = Winsock.WSAEPROTONOSUPPORT;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEPROTONOSUPPORT}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEPROTONOSUPPORT}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEPROTONOSUPPORT}{$ENDIF}
  WSAESOCKTNOSUPPORT = Winsock.WSAESOCKTNOSUPPORT;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAESOCKTNOSUPPORT}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAESOCKTNOSUPPORT}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAESOCKTNOSUPPORT}{$ENDIF}
  WSAEOPNOTSUPP = Winsock.WSAEOPNOTSUPP;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEOPNOTSUPP}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEOPNOTSUPP}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEOPNOTSUPP}{$ENDIF}
  WSAEPFNOSUPPORT = Winsock.WSAEPFNOSUPPORT;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEPFNOSUPPORT}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEPFNOSUPPORT}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEPFNOSUPPORT}{$ENDIF}
  WSAEAFNOSUPPORT = Winsock.WSAEAFNOSUPPORT;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEAFNOSUPPORT}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEAFNOSUPPORT}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEAFNOSUPPORT}{$ENDIF}
  WSAEADDRINUSE = Winsock.WSAEADDRINUSE;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEADDRINUSE}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEADDRINUSE}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEADDRINUSE}{$ENDIF}
  WSAEADDRNOTAVAIL = Winsock.WSAEADDRNOTAVAIL;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEADDRNOTAVAIL}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEADDRNOTAVAIL}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEADDRNOTAVAIL}{$ENDIF}
  WSAENETDOWN = Winsock.WSAENETDOWN;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAENETDOWN}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAENETDOWN}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAENETDOWN}{$ENDIF}
  WSAENETUNREACH = Winsock.WSAENETUNREACH;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAENETUNREACH}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAENETUNREACH}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAENETUNREACH}{$ENDIF}
  WSAENETRESET = Winsock.WSAENETRESET;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAENETRESET}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAENETRESET}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAENETRESET}{$ENDIF}
  WSAECONNABORTED = Winsock.WSAECONNABORTED;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAECONNABORTED}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAECONNABORTED}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAECONNABORTED}{$ENDIF}
  WSAECONNRESET = Winsock.WSAECONNRESET;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAECONNRESET}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAECONNRESET}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAECONNRESET}{$ENDIF}
  WSAENOBUFS = Winsock.WSAENOBUFS;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAENOBUFS}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAENOBUFS}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAENOBUFS}{$ENDIF}
  WSAEISCONN = Winsock.WSAEISCONN;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEISCONN}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEISCONN}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEISCONN}{$ENDIF}
  WSAENOTCONN = Winsock.WSAENOTCONN;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAENOTCONN}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAENOTCONN}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAENOTCONN}{$ENDIF}
  WSAESHUTDOWN = Winsock.WSAESHUTDOWN;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAESHUTDOWN}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAESHUTDOWN}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAESHUTDOWN}{$ENDIF}
  WSAETOOMANYREFS = Winsock.WSAETOOMANYREFS;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAETOOMANYREFS}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAETOOMANYREFS}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAETOOMANYREFS}{$ENDIF}
  WSAETIMEDOUT = Winsock.WSAETIMEDOUT;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAETIMEDOUT}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAETIMEDOUT}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAETIMEDOUT}{$ENDIF}
  WSAECONNREFUSED = Winsock.WSAECONNREFUSED;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAECONNREFUSED}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAECONNREFUSED}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAECONNREFUSED}{$ENDIF}
  WSAELOOP = Winsock.WSAELOOP;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAELOOP}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAELOOP}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAELOOP}{$ENDIF}
  WSAENAMETOOLONG = Winsock.WSAENAMETOOLONG;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAENAMETOOLONG}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAENAMETOOLONG}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAENAMETOOLONG}{$ENDIF}
  WSAEHOSTDOWN = Winsock.WSAEHOSTDOWN;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEHOSTDOWN}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEHOSTDOWN}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEHOSTDOWN}{$ENDIF}
  WSAEHOSTUNREACH = Winsock.WSAEHOSTUNREACH;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEHOSTUNREACH}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEHOSTUNREACH}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEHOSTUNREACH}{$ENDIF}
  WSAENOTEMPTY = Winsock.WSAENOTEMPTY;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAENOTEMPTY}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAENOTEMPTY}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAENOTEMPTY}{$ENDIF}
  WSAEPROCLIM = Winsock.WSAEPROCLIM;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEPROCLIM}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEPROCLIM}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEPROCLIM}{$ENDIF}
  WSAEUSERS = Winsock.WSAEUSERS;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEUSERS}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEUSERS}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEUSERS}{$ENDIF}
  WSAEDQUOT = Winsock.WSAEDQUOT;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEDQUOT}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEDQUOT}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEDQUOT}{$ENDIF}
  WSAESTALE = Winsock.WSAESTALE;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAESTALE}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAESTALE}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAESTALE}{$ENDIF}
  WSAEREMOTE = Winsock.WSAEREMOTE;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEREMOTE}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEREMOTE}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEREMOTE}{$ENDIF}
  WSAEDISCON = Winsock.WSAEDISCON;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAEDISCON}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAEDISCON}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAEDISCON}{$ENDIF}
  WSASYSNOTREADY = Winsock.WSASYSNOTREADY;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSASYSNOTREADY}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSASYSNOTREADY}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSASYSNOTREADY}{$ENDIF}
  WSAVERNOTSUPPORTED = Winsock.WSAVERNOTSUPPORTED;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAVERNOTSUPPORTED}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAVERNOTSUPPORTED}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAVERNOTSUPPORTED}{$ENDIF}
  WSANOTINITIALISED = Winsock.WSANOTINITIALISED;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSANOTINITIALISED}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSANOTINITIALISED}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSANOTINITIALISED}{$ENDIF}
  WSAHOST_NOT_FOUND = Winsock.WSAHOST_NOT_FOUND;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSAHOST_NOT_FOUND}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSAHOST_NOT_FOUND}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSAHOST_NOT_FOUND}{$ENDIF}
  WSATRY_AGAIN = Winsock.WSATRY_AGAIN;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSATRY_AGAIN}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSATRY_AGAIN}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSATRY_AGAIN}{$ENDIF}
  WSANO_RECOVERY = Winsock.WSANO_RECOVERY;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSANO_RECOVERY}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSANO_RECOVERY}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSANO_RECOVERY}{$ENDIF}
  WSANO_DATA = Winsock.WSANO_DATA;
    {$IFDEF VER110}{$NODEFINE WinsockIntf.WSANO_DATA}{$ENDIF}
    {$IFDEF VER125}{$NODEFINE WSANO_DATA}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE WSANO_DATA}{$ENDIF}

type
  // "Proxy" these so other units do not need to use Winsock.pas
  PHostEnt = Winsock.PHostEnt;
  PInAddr = Winsock.PInAddr;
  TInAddr = Winsock.TInAddr;
  TSockAddr = Winsock.TSockAddr;
  TSockAddrIn = Winsock.TSockAddrIn;
  TSocket = Winsock.TSocket;
  TTimeVal = Winsock.TTimeVal;
  TFDSet = Winsock.TFDSet;
  TWSAData = Winsock.TWSAData;
  u_char = Winsock.u_char;
  u_long = Winsock.u_long;

  TSunB = packed record
    s_b1, s_b2, s_b3, s_b4: u_char;
  end;

  TSocksRequest = record
    Version: Byte;
    OpCode: Byte;
    Port: Word;
    IpAddr: TInAddr;
    UserId: String[255];
  end;

  TSocksResponse = record
    Version: Byte;
    OpCode: Byte;
    Port: Word;
    IpAddr: TInAddr;
  end;

  // At a later date - it might be useful to create a abstracted network interface - but this
  // would probably make more sense to do on an abstracted level above TWinshoe and not at this
  // low level
  //
  // I considered doing this with procedural pointers, but the ability to handle diff call types for
  // diff versions of Winsock would make it's usefullness short lived
  //
  {TODO Dyanmically load Winsock - this will require elimination of Winsock call above
  and copying of types - or some other delayed loading mechanism. Look into other mechanisms}
  TWinsockIntfBase = class
  private
    fsStackDescription: string;
    fiMaxSockets, fiMaxUDPSize: Integer;
  public
    constructor Create; virtual;
    // ---------- Calls to Winsock Functions ----------
    function connect(s: TSocket; var name: TSockAddr; namelen: Integer): Integer; virtual; abstract;
    function gethostbyaddr(addr: Pointer; len, Struct: Integer): PHostEnt; virtual; abstract;
    function htons(hostshort: u_short): u_short; virtual; abstract;
    function ntohs(netshort: u_short): u_short; virtual; abstract;
    function inet_addr(cp: PChar): u_long; virtual; abstract;
    function gethostname(name: PChar; len: Integer): Integer; virtual; abstract;
    function GetHostByName(name: PChar): PHostEnt; virtual; abstract;
    function TranslateSocketErrorMsg(const iErr: integer): string; virtual; abstract;
    function WSAGetLastError: Integer; virtual; abstract;
    function recv(s: TSocket; var Buf; len, flags: Integer): Integer; virtual; abstract;
    function recvfrom(s: TSocket; var Buf; len, flags: Integer; var from: TSockAddr;
     var fromlen: Integer): Integer; virtual; abstract;
    function select(nfds: Integer; readfds, writefds, exceptfds: PFDSet; timeout: PTimeVal)
     : Longint; virtual; abstract;
    function send(s: TSocket; var Buf; len, flags: Integer): Integer; virtual; abstract;
    function sendto(s: TSocket; var Buf; len, flags: Integer; var addrto: TSockAddr;
      tolen: Integer): Integer; virtual; abstract;
    function setsockopt(s: TSocket; level, optname: Integer; optval: PChar; optlen: Integer)
     : Integer; virtual; abstract;
    function inet_ntoa(inaddr: TInAddr): PChar; virtual; abstract;
    function listen(s: TSocket; backlog: Integer): Integer; virtual; abstract;
    function accept(s: TSocket; addr: PSockAddr; addrlen: PInteger): TSocket; virtual; abstract;
    function bind(s: TSocket; var addr: TSockAddr; namelen: Integer): Integer; virtual; abstract;
    function closesocket(s: TSocket): Integer; virtual; abstract;
    function socket(af, Struct, protocol: Integer): TSocket; virtual; abstract;
    function WSACancelBlockingCall: Integer; virtual; abstract;
    // Properties
    property StackDescription: string read fsStackDescription;
    property MaxSockets: Integer read fiMaxSockets;
    property MaxUDPSize: Integer read fiMaxUDPSize;
  end;

  TWinsockIntf11 = class(TWinsockIntfBase)
  public
    constructor Create; override;
    //
    function connect(s: TSocket; var name: TSockAddr; namelen: Integer): Integer; override;
    function gethostbyaddr(addr: Pointer; len, Struct: Integer): PHostEnt; override;
    function htons(hostshort: u_short): u_short; override;
    function ntohs(netshort: u_short): u_short; override;
    function inet_addr(cp: PChar): u_long; override;
    function gethostname(name: PChar; len: Integer): Integer; override;
    function GetHostByName(name: PChar): PHostEnt; override;
    function TranslateSocketErrorMsg(const iErr: integer): string; override;
    function WSAGetLastError: Integer; override;
    function recv(s: TSocket; var Buf; len, flags: Integer): Integer; override;
    function recvfrom(s: TSocket; var Buf; len, flags: Integer; var from: TSockAddr;
     var fromlen: Integer): Integer;  override;
    function select(nfds: Integer; readfds, writefds, exceptfds: PFDSet; timeout: PTimeVal)
     : Longint; override;
    function send(s: TSocket; var Buf; len, flags: Integer): Integer; override;
    function sendto(s: TSocket; var Buf; len, flags: Integer; var addrto: TSockAddr;
      tolen: Integer): Integer;  override;
    function setsockopt(s: TSocket; level, optname: Integer; optval: PChar; optlen: Integer)
     : Integer; override;
    function inet_ntoa(inaddr: TInAddr): PChar; override;
    function listen(s: TSocket; backlog: Integer): Integer; override;
    function accept(s: TSocket; addr: PSockAddr; addrlen: PInteger): TSocket; override;
    function bind(s: TSocket; var addr: TSockAddr; namelen: Integer): Integer; override;
    function closesocket(s: TSocket): Integer; override;
    function socket(af, Struct, protocol: Integer): TSocket; override;
    function WSACancelBlockingCall: Integer; override;
  end;

var
  WinsockInterface: TWinsockIntfBase;

implementation

function TWinsockIntf11.accept(s: TSocket; addr: PSockAddr; addrlen: PInteger): TSocket;
begin
  result := Winsock.accept(s, addr, addrlen);
end;

function TWinsockIntf11.bind(s: TSocket; var addr: TSockAddr; namelen: Integer): Integer;
begin
  result := Winsock.bind(s, addr, namelen);
end;

function TWinsockIntf11.closesocket(s: TSocket): Integer;
begin
  result := Winsock.closesocket(s);
end;

function TWinsockIntf11.connect(s: TSocket; var name: TSockAddr; namelen: Integer): Integer;
begin
  result := Winsock.connect(s, name, namelen);
end;

constructor TWinsockIntf11.Create;
var
  sData: TWSAData;
begin
  inherited;
  if WSAStartup($101, sData) = SOCKET_ERROR then
    raise Exception.Create('Winsock Initialization Error.');
  fsStackDescription := StrPas(sData.szDescription);
  fiMaxUDPSize := sData.iMaxUdpDg;
  fiMaxSockets := sData.iMaxSockets;
end;

function TWinsockIntf11.gethostbyaddr(addr: Pointer; len, Struct: Integer): PHostEnt;
begin
  result := Winsock.gethostbyaddr(addr, len, Struct);
end;

function TWinsockIntf11.gethostbyname(name: PChar): PHostEnt;
begin
  result := Winsock.gethostbyname(name);
end;

function TWinsockIntf11.gethostname(name: PChar; len: Integer): Integer;
begin
  result := Winsock.gethostname(name, len);
end;

function TWinsockIntf11.htons(hostshort: u_short): u_short;
begin
  result := Winsock.htons(hostshort)
end;

function TWinsockIntf11.inet_addr(cp: PChar): u_long;
begin
  result := Winsock.inet_addr(cp);
end;

function TWinsockIntf11.inet_ntoa(inaddr: TInAddr): PChar;
begin
  result := Winsock.inet_ntoa(inaddr);
end;

function TWinsockIntf11.listen(s: TSocket; backlog: Integer): Integer;
begin
  result := Winsock.listen(s, backlog);
end;

function TWinsockIntf11.ntohs(netshort: u_short): u_short;
begin
  result := Winsock.ntohs(netshort);
end;

function TWinsockIntf11.recv(s: TSocket; var Buf; len, flags: Integer): Integer;
begin
  result := Winsock.recv(s, Buf, len, flags);
end;

function TWinsockIntf11.recvfrom(s: TSocket; var Buf; len, flags: Integer; var from: TSockAddr; var fromlen: Integer): Integer;
begin
  result := Winsock.recvfrom(s, Buf, len, flags, from, fromlen);
end;

function TWinsockIntf11.select(nfds: Integer; readfds, writefds, exceptfds: PFDSet; timeout: PTimeVal): Longint;
begin
  result := Winsock.select(nfds, readfds, writefds, exceptfds, timeout);
end;

function TWinsockIntf11.send(s: TSocket; var Buf; len, flags: Integer): Integer;
begin
  result := Winsock.send(s, Buf, len, flags);
end;

function TWinsockIntf11.sendto(s: TSocket; var Buf; len, flags: Integer; var addrto: TSockAddr; tolen: Integer): Integer;
begin
  result := Winsock.sendto(s, Buf, len, flags, addrto, tolen);
end;

function TWinsockIntf11.setsockopt(s: TSocket; level, optname: Integer; optval: PChar; optlen: Integer): Integer;
begin
  result := Winsock.setsockopt(s, level, optname, optval, optlen);
end;

function TWinsockIntf11.socket(af, Struct, protocol: Integer): TSocket;
begin
  result := Winsock.socket(af, Struct, protocol);
end;

function TWinsockIntf11.TranslateSocketErrorMsg(const iErr: integer): string;
begin
  Result := '';
  case iErr of
    WSAEINTR: Result           := 'Interrupted system call.';
    WSAEBADF: Result           := 'Bad file number.';
    WSAEACCES: Result          := 'Access denied.';
    WSAEFAULT: Result          := 'Bad address.';
    WSAEINVAL: Result          := 'Invalid argument.';
    WSAEMFILE: Result          := 'Too many open files.';

    WSAEWOULDBLOCK: Result     := 'Operation would block. ';
    WSAEINPROGRESS: Result     := 'Operation now in progress.';
    WSAEALREADY: Result        := 'Operation already in progress.';
    WSAENOTSOCK: Result        := 'Socket operation on non-socket.';
    WSAEDESTADDRREQ: Result    := 'Destination address required.';
    WSAEMSGSIZE: Result        := 'Message too long.';
    WSAEPROTOTYPE: Result      := 'Protocol wrong type for socket.';
    WSAENOPROTOOPT: Result     := 'Bad protocol option.';
    WSAEPROTONOSUPPORT: Result := 'Protocol not supported.';
    WSAESOCKTNOSUPPORT: Result := 'Socket type not supported.';
    WSAEOPNOTSUPP: Result      := 'Operation not supported on socket.';
    WSAEPFNOSUPPORT: Result    := 'Protocol family not supported.';
    WSAEAFNOSUPPORT: Result    := 'Address family not supported by protocol family.';
    WSAEADDRINUSE: Result      := 'Address already in use.';
    WSAEADDRNOTAVAIL: Result   := 'Can''t assign requested address.';
    WSAENETDOWN: Result        := 'Network is down.';
    WSAENETUNREACH: Result     := 'Network is unreachable.';
    WSAENETRESET: Result       := 'Net dropped connection or reset.';
    WSAECONNABORTED: Result    := 'Software caused connection abort.';
    WSAECONNRESET: Result      := 'Connection reset by peer.';
    WSAENOBUFS: Result         := 'No buffer space available.';
    WSAEISCONN: Result         := 'Socket is already connected.';
    WSAENOTCONN: Result        := 'Socket is not connected.';
    WSAESHUTDOWN: Result       := 'Cannot send or receive after socket is closed.';
    WSAETOOMANYREFS: Result    := 'Too many references, can''t splice.';
    WSAETIMEDOUT: Result       := 'Connection timed out.';
    WSAECONNREFUSED: Result    := 'Connection refused.';
    WSAELOOP: Result           := 'Too many levels of symbolic links.';
    WSAENAMETOOLONG: Result    := 'File name too long.';
    WSAEHOSTDOWN: Result       := 'Host is down.';
    WSAEHOSTUNREACH: Result    := 'No route to host.';
    WSAENOTEMPTY: Result       := 'Directory not empty';
    WSAEPROCLIM: Result        := 'Too many processes.';
    WSAEUSERS: Result          := 'Too many users.';
    WSAEDQUOT: Result          := 'Disk Quota Exceeded.';
    WSAESTALE: Result          := 'Stale NFS file handle.';
    WSAEREMOTE: Result         := 'Too many levels of remote in path.';

    WSASYSNOTREADY: Result     := 'Network subsystem is unavailable.';
    WSAVERNOTSUPPORTED: Result := 'WINSOCK DLL Version out of range.';
    WSANOTINITIALISED: Result  := 'Winsock not loaded yet.';

    WSAHOST_NOT_FOUND: Result  := 'Host not found.';
    WSATRY_AGAIN: Result       := 'Non-authoritative response (try again or check DNS setup).';
    WSANO_RECOVERY: Result     := 'Non-recoverable errors: FORMERR, REFUSED, NOTIMP.';
    WSANO_DATA: Result         := 'Valid name, no data record (check DNS setup).';
  end;
  Result := 'Socket Error #' + IntToStr(iErr) + #13#10 + Result;
end;

function TWinsockIntf11.WSACancelBlockingCall: Integer;
begin
	result := Winsock.WSACancelBlockingCall;
end;

function TWinsockIntf11.WSAGetLastError: Integer;
begin
  result := Winsock.WSAGetLastError;
end;

constructor TWinsockIntfBase.Create;
begin
  inherited;
end;

initialization
  WinsockInterface := TWinsockIntf11.Create;
finalization
  WinsockInterface.Free;
end.
