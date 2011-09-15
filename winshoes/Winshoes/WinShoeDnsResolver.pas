Unit WinshoeDnsREsolver;

{$C PRELOAD}
//------------------------------------------------------------------------------
// WinshoeDNSResolver
//
//
// Started Date : 07/15/1999 Version 0.10 Complete :(Scheduled) 07/24/1999
//
// Author : Ray Malone
// MBS Software
// 251 E. 4th St.
// Chillicothe, OH 45601
//
// MailTo: ray@mbssoftware.com
//
//------------------------------------------------------------------------------
// The TDNResolver is us just a UPD Client containing a TDnsMessage.
// Its sole funciton is to connect disconect send and receive DNS messages.
// The DnsMessage ecodes and decodes DNS messages
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
// A DNS REsolver sends a Dns Header and a DnsQuestion to a DNS server.
// Type DNS Header (tDNSHeader) is a component to store the header of
// a DNSResolver Query and Header DNS Server Response
// The ReEsolver sends the Server a header and the Sever returns it with various
// bits or values set.
// The Most significant are the Rcodes (Return Codes) If the Rcode is 0 the
// the server was able to complete the requested task. Otherwise it contains
// an error code for what when wrong. The RCodes are listed below.
//
// fQdCount is the number of entries in the request from a resolver to a server.
// fQdCount would normally be set to 1.
//
// fAnCount is set by the server to the number of answers to the query.
//
// fNsCount is the number of entries in the Name Server list
//
// fArCount is the number of additional records.
//
// TDNSHeader exposes all the fields of a header... even those only set by
// the server so it can be used to build a DNS server
//------------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// A DnsResolver and Dns Server both deal with data in a manner designed to
// conserve bandwith and are not conducive to data structures. In other words
// the data must be parsed. The questions and replies in WinshoeDNSResolver are
// parsed so users can just assign and read data from pascal sturctures.
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Header, question, and response objects make up the DNS Message object.
// the TDNSQuestionList is used to hold both the send and received queries
// in easy to handle pascal data structures
// A Question Consists of a Name, Atype and aClass.
//   Name can be a domain name or an IP address depending on the type of
//   question. Question and answer types and Classes are given constant names
//   below;
//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
// DNS Servers return data in various forms. the TDnsMessage parses this data
// and puts it in structures depending on its aType as shown in the Const
// QType definitions above.
// Data Structures for the Responses to the various Qtypes are defined below.
//------------------------------------------------------------------------------
//
// The PROCEDURE CreateQueryPacket takes the Mesage header and questions and
// formats them in to a query packet for sending. When the Server responds
// with a reply packet the  PROCEDURE DecodeReplyPacket formats the reply into
// the proper response data structures depending on the type of reponse.
//------------------------------------------------------------------------------
//  TWinshoeMXResolver  Written July 21, 1999
//  Given a valid DomainName it will return a list of Domain Names of mail
//  Servers in Priority order. That is priority 1 first 2 second
//  Some Mail Locations have several servers all with the same priority.
//  This is done to try to given even distribution of work to the mail
//  Servers. Thus several calls to a particular domain may produce the
//  servers in different order.
//
//------------------------------------------------------------------------------

// ToDoList
//  Try Secondary, and Tertiary Servers if Primary is down.
//------------------------------------------------------------------------------
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)

Interface

Uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  extCtrls,
  Winshoes,
  UDPWinshoe;

Const
  { fBitCode Bits and Masks }
  cQRBit      = $8000;   { QR when 0 = Question when 1 Response                    }
  cQRMask     = $EFFF;
  cOpCodeBits = $7800;   { Operation Code See Constansts Defined Below             }
  cOpCodeMask = $87FF;
  cAABit      = $0400;   { Valid in Responses Authoritative Answer if set (1)      }
  cAAMask     = $FBFF;
  cTCBit      = $0200;   { Truncation Bit if Set Messages was truncated for length }
  cTCMask     = $FDFF;
  cRDBit      = $0100;   { If set(1) Recursive Search is Resquested by Query       }
  cRDMask     = $FEFF;
  cRABit      = $0080;   { If set(1) Server supports Recursive Search (Available)  }
  cRAMask     = $FF7F;
  cRCodeBits  = $000F;   { Response Code. See Constansts Defined Below             }
  cRCodeMask  = $FFF0;

Const
  { Question Operation Code Values }
   cResQuery  = 0;
   cResIQuery = 1;
   cResStatus = 2;
   cOPCodeStrs : Array[cResQuery..cResStatus] Of String[7] =
     ('Query',
      'IQuery',
      'Status');

Const
  { Sever Response codes (RCode) }
   cRCodeNoError   = 0;
   cRCodeFormatErr = 1;
   cRCodeServerErr = 2;
   cRCodeNameErr   = 3;
   cRCodeNotImplemented = 4;
   cRCodeRefused  = 5;

   cRCodeStrs : Array[cRCodeNoError..cRCodeRefused] Of String =
   ('RCode NO Error',
    'DNS Server Reports Query Format Error',
    'DNS Server Reports Query Server Error',
    'DNS Server Reports Query Name Error',
    'DNS Server Reports Query Not Implemented Error',
    'DNS Server Reports Query Refused Error');


//------------------------------------------------------------------------------
// Type DNS Header (tDNSHeader) is a component to store the header of
// a DNSResolver Query  And DNS Server Response
// The REsolver sends the Server a header and the Sever returns it with various
// bits or values set.
// The Most significant are the Rcodes (Return Codes) If the Rcode is 0 the
// the server was able to complete the requested task. Otherwise it contains
// an error code for what when wrong. The RCodes are listed immediately above.
//
// fQdCount is the number of entries in the request from a resolver to a server.
// fQdCount would normally be set to 1.
//
// fAnCount is set by the server to the number of answers to the query.
//
// fNsCount is the number of entries in the Name Server list
//
// fArCount is the number of additional records.
//
// TDNSHeader exposes all the fields of a header... even those only set by
// the server so it can be used to build a DNS server
//------------------------------------------------------------------------------
Type
  TDNSHeader = Class(tComponent)
  Private
    { Private declarations }
    fId : Word;      { Query Id To type Responses to Queries                         }
    fBitCode : Word; { Holds Qr,OPCode AA TC RD RA RCode and Reserved Bits           }
    fQdCount : Word; { Number of Question Entries in Question Section                }
    fAnCount : Word; { Number of Resource Records in Answer Section                  }
    fNsCount : Word; { Number of Name Server Resource Recs in  Authority Rec Section }
    fArCount : Word; { Number of Resource Records in Additional records Section      }
    Procedure InitializefId;
    Function GetQr : Boolean;
    Procedure SetQr( IsResponse : Boolean);
    Function GetOpCode : Word;
    Procedure SetOpCode(OpCode: Word);
    Function GetAA : Boolean;
    Procedure SetAA(AuthAnswer: Boolean);
    Function GetTC : Boolean;
    Procedure SetTC(IsTruncated: Boolean);
    Function GetRD : Boolean;
    Procedure SetRD(RecursionDesired: Boolean);
    Function GetRA : Boolean;
    Procedure SetRA(RecursionAvailable: Boolean);
    Function GetRCode : Word;
    Procedure SetRCode(RCode: Word);
  Protected
    { Protected declarations }
   Public
   { Public declarations }
    Property ID : Word Read fId Write fId;
    Property Qr : Boolean Read GetQr Write SetQr;
    Property Opcode : Word Read GetOpCode Write SetOpCode;
    Property AA : Boolean Read GetAA Write SetAA;
    Property TC : Boolean Read GetTC Write SetTC;
    Property RD : Boolean Read GetRD Write SetRD;
    Property RA : Boolean Read GetRA Write SetRA;
    Property RCode : Word Read GetRCode Write SetRCode;
    Property QDCount : Word Read fQdCount Write fQdCount;
    Property ANCount : Word Read fAnCount Write fAnCount;
    Property NSCount : Word Read fNsCount Write fNsCount;
    Property ARCount : Word Read fArCount Write fArCount;
    Procedure InitVars; Virtual;
   Constructor Create(aOwner: tComponent); Override;
   Published
    { Published declarations }
  End;

//-----------------------------------------------------------------------------
// A DnsResolver and Dns Server both deal with data in a manner designed to
// conserve bandwith and are not conducive to data structures. In other words
// the data must be parsed. The questions and replies in WinshoeDNSResolver are
// parsed so users can just assign and read data from pascal sturctures.
//------------------------------------------------------------------------------

Type
  ptDNSQuestion = ^TDNSQuestion;
  TDNSQuestion = Record
    QName  : ShortString;
    QType  : Word;
    QClass : Word;
  End;

Const           // QType Identifes the type of Question
  cA     =  1;  // a Host Address
  cNS    =  2;  // An Authoritative name server
  cMD    =  3;  // A mail destination obsolete use MX (OBSOLETE)
  cMF    =  4;  // A mail forwarder obsolete use MX   (OBSOLETE)
  cName  =  5;  // The canonical name for an alias
  cSOA   =  6;  // Marks the start of a zone of authority
  cMB    =  7;  // A mail box domain name (Experimental)
  cMG    =  8;  // A mail group member (Experimental)
  cMR    =  9;  // A mail Rename Domain Name (Experimental)
  cNULL  = 10;  // RR (Experimental)
  cWKS   = 11;  // A well known service description
  cPTR   = 12;  // A Domain Name Pointer;
  cHINFO = 13;  // Host Information;
  cMINFO = 14;  // Mailbox or Mail List Information;
  cMX    = 15;  // Mail Exchange
  cTXT   = 16;  // Text String;
  cAXFR  = 252; // A Request for the Transfer of an entire zone;
  cMAILB = 253; // A request for mailbox related records (MB MG OR MR}
  cMAILA = 254; // A request for mail agent RRs (Obsolete see MX)
  cStar =  255; // A Request for all Records

Const          //QClass
  cIN  =  1;   //The Internet
  cCS  =  2;   // the CSNet Obsolete
  cCH  =  3;   // The Chaos Claee
  cHS  =  4;   // Hesiod [Dyer 87]
//CStar any Class is same as QType for all records;

 cQClassStr :Array[cIN..CHs] Of String[3] =
  ('IN','CS','CH','HS');

//------------------------------------------------------------------------------
// Header, question, and response objects make up the DNS Message object.
// the TDNSQuestionList is used to hold both the send and received queries
// in easy to handle pascal data structures
//------------------------------------------------------------------------------
Type
  tDNSQuestionList = Class(tComponent)
  Private
    { Private declarations }
  Protected
    { Protected declarations }
    fList : TList;
    fCount : Integer;
  Public
    { Public declarations }
    Constructor Create(AOwner: tComponent); Override;
    Destructor Destroy;  Override;
  Published
    { Published declarations }

    Property Count : Integer Read fCount Write fCount;
    Procedure Add(DNSQuestion: TDnsQuestion);
    Procedure Delete(Idx : Integer);
    Procedure Clear;
    Function GetDNSQuestion(Idx: Integer):tDnsQuestion;
    Procedure UpdateDNSQuestion(Idx: Integer; aDNSQuestion : TDNSquestion);
  End;


//------------------------------------------------------------------------------
// DNS Servers return data in various forms. the TDnsMessage parses this data
// and puts it in structures depending on its aType as shown in the Const
// QType definitions above.
// Data Structures for the Responses to the various Qtypes are defined next.
//------------------------------------------------------------------------------

Type
  tHInfo = Record
    CPUStr : ShortString;
    OsStr : ShortString;
  End;


  tMInfo = Record
    RMailBox : ShortString;
    EMailBox : ShortString;
  End;


  tMX = Record
    Preference : Word;
    Exchange : ShortString;
  End;


  TSOA = Record
    MName : ShortString;
    RName : ShortString;
    Serial : DWord;
    Refresh : DWord;
    ReTry : Dword;
    Expire : Dword;
    Minimum : DWord;
  End;


  TWKS = Record
    Address : Dword;
    Protocol : Byte;
    Bits : Array[0..7] Of Byte;
  End;

//------------------------------------------------------------------------------
// The Returnd Data (RData) from a server in response to a query can be in
// several formats the following variant record is used to hold the returned
// data.
//-----------------------------------------------------------------------------
  TRdata = Record
    Case Byte Of
      1 : (DomainName : ShortString);
      2 : (HInfo : tHInfo);
      3 : (MInfo : tMInfo);
      4 : (MX : TMx);
      5 : (SOA : TSOA);
      6 : (A : DWord);
      7 : (WKS : TWks);
      8 : (Data : Array[0..4096] Of Char);
      9 : (HostAddrStr : ShortString);
    End;

{TODO Change records to be collections and collection items to be more OO and avoid this hack also}

{$IFNDEF VER100}
{$NODEFINE TRdata}
{$NODEFINE tHInfo}
{$NODEFINE tMInfo}
{$NODEFINE tMX}
{$NODEFINE TSOA}
{$NODEFINE TWKS}

(*$HPPEMIT '#pragma pack(push, 1)'*)
(*$HPPEMIT 'struct tHInfo'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT '	System::ShortString CPUStr;'*)
(*$HPPEMIT '	System::ShortString OsStr;'*)
(*$HPPEMIT '} ;'*)
(*$HPPEMIT '#pragma pack(pop)'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '#pragma pack(push, 1)'*)
(*$HPPEMIT 'struct tMInfo'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT '	System::ShortString RMailBox;'*)
(*$HPPEMIT '	System::ShortString EMailBox;'*)
(*$HPPEMIT '} ;'*)
(*$HPPEMIT '#pragma pack(pop)'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '#pragma pack(push, 4)'*)
(*$HPPEMIT 'struct tMX'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT '	Word Preference;'*)
(*$HPPEMIT '	System::ShortString Exchange;'*)
(*$HPPEMIT '} ;'*)
(*$HPPEMIT '#pragma pack(pop)'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '#pragma pack(push, 4)'*)
(*$HPPEMIT 'struct TSOA'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT '	System::ShortString MName;'*)
(*$HPPEMIT '	System::ShortString RName;'*)
(*$HPPEMIT '	unsigned Serial;'*)
(*$HPPEMIT '	unsigned Refresh;'*)
(*$HPPEMIT '	unsigned ReTry;'*)
(*$HPPEMIT '	unsigned Expire;'*)
(*$HPPEMIT '	unsigned Minimum;'*)
(*$HPPEMIT '} ;'*)
(*$HPPEMIT '#pragma pack(pop)'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '#pragma pack(push, 4)'*)
(*$HPPEMIT 'struct TWKS'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT '	unsigned Address;'*)
(*$HPPEMIT '	Byte Protocol;'*)
(*$HPPEMIT '	Byte Bits[8];'*)
(*$HPPEMIT '} ;'*)
(*$HPPEMIT '#pragma pack(pop)'*)
(*$HPPEMIT '#pragma pack(push, 4)'*)
(*$HPPEMIT 'struct TRdata'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT '	union'*)
(*$HPPEMIT '	{'*)
(*$HPPEMIT '		struct TRdata1'*)
(*$HPPEMIT '		{ System::ShortString HostAddrStr; };'*)
(*$HPPEMIT '		struct TRdata2'*)
(*$HPPEMIT '		{ char Data[4097]; };'*)
(*$HPPEMIT '		struct TRdata3'*)
(*$HPPEMIT '		{ TWKS WKS; };'*)
(*$HPPEMIT '		struct TRdata4'*)
(*$HPPEMIT '		{ unsigned A; };'*)
(*$HPPEMIT '		struct TRData5'*)
(*$HPPEMIT '		{ TSOA SOA; };'*)
(*$HPPEMIT '		struct TRData6'*)
(*$HPPEMIT '		{ tMX MX;	};'*)
(*$HPPEMIT '		struct TRData7'*)
(*$HPPEMIT '		{ tMInfo MInfo; };'*)
(*$HPPEMIT '		struct TRData8'*)
(*$HPPEMIT '		{	tHInfo HInfo; };'*)
(*$HPPEMIT '		struct TRData9'*)
(*$HPPEMIT '		{ System::ShortString DomainName; };'*)
(*$HPPEMIT '	};'*)
(*$HPPEMIT '} ;'*)
(*$HPPEMIT '#pragma pack(pop)'*)
{$ENDIF}

//------------------------------------------------------------------------------
// The total Data returned by server in response to a query is stored the
// following Record  structure.
// The Name, Type, and Class  were defines as Qname, Qtype, and QClass above
// TTL is a dateTime Dword to tell when the information expires. This is uses
// By resolvers to cache data to hold network traffic to a mimimum.
// The Winshoe DNS Resolvers does not implement a cache.
// RData if defined above
// StarData is of indefinate length. the '*' Query type is send me everything
// It is Defined as an RData Type but a pascal variant record can not store
// a type String so we made a Star data string;
//-----------------------------------------------------------------------------

Type
  ptDNSResource = ^TDNSresource;
  tDNSResource = Record
    Name : ShortString;
    aType : Word;
    aClass : Word;
    TTL   : DWord;
    RdLength : Word;
    RData : TRData;
    StarData: String;
  End;

//------------------------------------------------------------------------------
// TDNSResourceList objects are used to hold the three kinds of information
// a server uses to reply to a Query;
// 3 TDNSResourceList objects are used in a TDNSMessage
//------------------------------------------------------------------------------

Type
  TDNSResourceList = Class(tComponent)
  Private
    { Private declarations }

  Protected
    { Protected declarations }
    fList : TList;
    fCount : Integer;
  Public
    { Public declarations }
    Constructor Create(AOwner: tComponent); Override;
    Destructor Destroy;  Override;
  Published
    { Published declarations }
    Property Count : Integer Read fCount Write fCount;
    Procedure Add(DNSResource: tDNSResource);
    Procedure Delete(Idx : Integer);
    Procedure Clear;
    Function GetDNSResource(Idx: Integer):tDNSResource;
    Function GetDNSRDataDomainName(Idx: Integer): String;
    Function GetDnsMxExchangeNameEx(Idx : Integer): String;
    Procedure UpdateDNSResource(Idx: Integer; aDNSResource : tDNSResource);
  End;


//------------------------------------------------------------------------------
// THE EDnsResolverError is used so the resolver can repond to only resolver
// execeptions.
//------------------------------------------------------------------------------
Type
  EDnsResolverError = Class(EWinshoeException);

//------------------------------------------------------------------------------
// The TDNSMessage is the heart of the TWinshoeDNSResolver
// It creates the query and parses the replies.
//------------------------------------------------------------------------------
Type
  TDNSMessage = Class(tComponent)
    Private
    { Private declarations }
    Protected
      { Protected declarations }
      fDNSHeader : TDNSHeader;
      fDnsQdList : tDNSQuestionList;
      fDnsAnList,
      fDnsNsList,
      fDnsArList : TDNSResourceList;
      FQPackSize : Integer;
      fQPacket : String;
      fRPackSize : Integer;
    Public
      { Public declarations }
      RPacket : String;
      Function  CreateLabelStr(QName : String):String;
      Procedure CreateQueryPacket;
      Procedure DecodeReplyPacket;
      Procedure ClearVars; Virtual;
      Constructor Create(aOwner : tComponent);Override;
      Destructor Destroy; Override;
      Property QPacket : String Read FQPacket Write FQpacket;
      Property DNSHeader : TDnsHeader Read fDNSHeader Write fDNSHeader;
      Property DNSQDList : tDNSQuestionList Read fDnsQdList Write fDnsQdList;
      Property DnsAnList : TDNSResourceList Read fDnsAnList Write fDnsAnList;
      Property DNSNSList : TDNSResourceList Read fDnsNsList Write fDnsNsList;
      Property DNSARList : TDNSResourceList Read fDnsArList Write fDnsArList;
    Published
      { Published declarations }
    End;


Type
  TWinshoeDNSResolver = Class(TWinShoeUDPClient)
  Private
    { Private declarations }
     FDNSMessage : TDNSMessage;
  Protected
    { Protected declarations }

  Public
    { Public declarations }
    Procedure ClearVars; Virtual;
    Constructor Create(aOwner : tComponent); Override;
    Destructor Destroy; Override;
    Property DnsMessage :TDnsMessage Read FDnsMessage Write FDnsMessage;
  Published
    { Published declarations }
  End;

Type
  TWinshoeMXResolver = Class(TWinShoeDNSResolver)
  Private
    { Private declarations }
  Protected
    { Protected declarations }
  Public
    { Public declarations }
    Procedure GetMailServers(Const DomainName : String; ServerList : TStringList);
    Property DnsMessage;
  Published
    { Published declarations }
  End;

 Function  GetQTypeStr(aQType: Integer): String;

 Function GetQClassStr(QClass: Integer):String;

Procedure Register;

Implementation

Type
  HiLoBytes = Record
    HiByte : Byte;
    LoByte : Byte;
  End;
  WordRec = Record
    Case Byte Of
      1 :(TheBytes : HiLoBytes);
      2 : (AWord : Word);
    End;

Type
  HiLoWords = Record
    HiWord,
    LowWord : Word;
  End;

  DWordRec = Record
    Case Byte Of
      1 :(aDWord : DWord);
      2 :(Words : HILoWords);
    End;

  Procedure Register;
  Begin
    RegisterComponents('Winshoes Clients',[TWinshoeDNSResolver,TWinshoeMXResolver]);
  End;
  //---------------------------Low Level Routines --------------------------------
  Function TwoCharToWord(Char1,Char2: Char):Word;
  //Since Replys are returned as Strings, we need a rountime to convert two
  // characters which are a 2 byte U Int into a two byte unsigned integer
  Begin
    Result :=Word((Ord(Char1)Shl 8) And $FF00) Or Word(Ord(Char2)And $00FF);
  End;

  Function FourCharToDWord(Char1,Char2,Char3,Char4 : Char): DWord;
  Var
    ARes : DWordRec;
  Begin
    ares.Words.HiWord := TwoCharToWord(Char1,Char2);
    aRes.Words.LowWord := TwoCharToWord(Char3,Char4);
    Result := ARes.aDword;
  End;

  Function WordToTwoCharStr(aWord : Word): String;
  //Since Queries are sent as Strings, we need a rountime to convert a UINT
  // into a two byte String
  Begin
    Result := Chr(Hi(aWord))+ Chr(Lo(aWord));
  End;

  Function GetRCodeStr(RCode : Integer): String;
  Begin
    If Rcode In [cRCodeNoError..cRCodeRefused] Then
      Result :=  cRCodeStrs[Rcode]
    Else Result := 'Server Returned Unknown Error';
  End;

  Function  GetQTypeStr(aQType: Integer): String;
  Begin
    Case AQType Of
      cA     : Result := 'A';     // a Host Address
      cNS    : Result := 'NS';    // An Authoritative name server
      cMD    : Result := 'MD';    // A mail destination obsolete use MX (OBSOLETE)
      cMF    : Result := 'MF';    // A mail forwarder obsolete use MX   (OBSOLETE)
      cName  : Result := 'NAME';  // The canonical name for an alias
      cSOA   : Result := 'SOA';   // Marks the start of a zone of authority
      cMB    : Result := 'MB';    // A mail box domain name (Experimental)
      cMG    : Result := 'MG';    // A mail group member (Experimental)
      cMR    : Result := 'MR';    // A mail Rename Domain Name (Experimental)
      cNULL  : Result := 'NULL';  // RR (Experimental)
      cWKS   : Result := 'WKS';   // A well known service description
      cPTR   : Result := 'PTR';   // A Domain Name Pointer;
     cHINFO  : Result := 'HINFO'; // Host Information;
     cMINFO  : Result := 'MINFO'; // Mailbox or Mail List Information;
     cMX     : Result := 'MX';    // Mail Exchange
     cTXT    : Result := 'TXT';   // Text String;
     cAXFR   : Result := 'AXFR';  // A Request for the Transfer of an entire zone;
     cMAILB  : Result := 'MAILB'; // A request for mailbox related records (MB MG OR MR}
     cMAILA  : Result := 'MAILA'; // A request for mail agent RRs (Obsolete see MX)
     cStar   : Result := '*';     // A Request for all Records
     Else Result := IntToSTr(aQType);
    End;
  End;

  Function GetQClassStr(QClass: Integer):String;
  Begin
    If QClass In [cIN..CHs] Then Result := cQClassStr[QClass]
    Else If QClass = 15 Then Result := 'MX'
    Else Result := IntToStr(QClass);
  End;

  Function GetErrorStr(Code, Id :Integer): String;
  Begin
    Case code Of
      1 : Result :=  'Invaild Query Count ' +IntTosTr(Id);
      2 : Result := 'Invalid Packet Size '+InttoSTr(Id);
      3 : Result := 'Received Packet is too small. Less than 4 bytes '+IntToStr(Id);
      4 : Result := 'Invalid Header Id '+IntToStr(Id);
      5 : Result := 'Received Packet is too small. Less than 12 bytes '+IntToStr(Id);
      6 : Result := 'Received Packet is too small. '+IntToStr(Id);
    End;
  End;
//------------------------ End Low Level Routines ------------------------------


//----------------------- Start tDNSQuestionList -------------------------------
// Coded July 15, 1999 By RM
// A DNS Resolver uses a header structure to send information about
// requests to the server.
// This DNS Resolver puts the header into a Pascal object
// The Resolver then converts the object data into
// the RFC 1035 format before trasmission.
//------------------------------------------------------------------------------
  Constructor TDNSHeader.Create(aOwner: tComponent);
  Begin
     Inherited Create(AOwner);
     InitialIzeFid;
  End;

  Procedure TDNSHeader.InitializefId;
  Begin
    Randomize;
    fId := Random(10000)
  End;

  Procedure TDNSHeader.InitVars;
  Begin
    fBitCode := 0; { Holds Qr,OPCode AA TC RD RA RCode and Reserved Bits           }
    fQdCount := 0; { Number of Question Entries in Question Section                }
    fAnCount := 0; { Number of Resource Records in Answer Section                  }
    fNsCount := 0; { Number of Name Server Resource Recs in  Authority Rec Section }
    fArCount := 0; { Number of Resource Records in Additional records Section      }
  End;

  Function TDNSHeader.GetQR : Boolean;
  Begin
    Result := (fBitCode And cQRBit) = cQRBit;
  End;

  Procedure TDNSHeader.SetQr( IsResponse : Boolean);
  Begin
    If IsResponse Then   fBitCode := fBitCode Or cQRBit
    Else fBitCode := fBitCode And cQRMask
  End;

  Function TDNSHeader.GetOpCode : Word;
  Begin
    Result := ((fBitCode And cOpCodeBits) Shr 11) And $000F;
  End;

  Procedure TDNSHeader.SetOpCode(OpCode: Word);
  Begin
    fBitCode := ((OpCode  Shl 11) And cOpCodeBits) Or (fBitCode And cOpCodeMask);
  End;

  Function TDNSHeader.GetAA : Boolean;
  Begin
    Result :=  (fBitCode And cAABit) = cAABit;
  End;

  Procedure TDNSHeader.SetAA(AuthAnswer: Boolean);
  Begin
    If AuthAnswer Then  fBitCode := fBitCode Or cAABit
    Else fBitCode := fBitCode And cAAMask;
  End;

  Function TDNSHeader.GetTC : Boolean;
  Begin
    Result :=  (fBitCode And cTCBit) = cTCBit;
  End;

  Procedure TDNSHeader.SetTC(IsTruncated: Boolean);
  Begin
    If IsTruncated Then fBitCode := fBitCode Or cTCBit
    Else fBitCode := fBitCode And cTCMask;
  End;

  Function TDNSHeader.GetRD : Boolean;
  Begin
    Result :=  (fBitCode And cRDBit) = cRDBit;
  End;

  Procedure TDNSHeader.SetRD(RecursionDesired: Boolean);
  Begin
    If RecursionDesired Then fBitCode := fBitCode Or cRDBit
    Else fBitCode := fBitCode And cRDMask;
  End;

  Function TDNSHeader.GetRA : Boolean;
  Begin
    Result :=  (fBitCode And cRABit) = cRABit;
  End;

  Procedure TDNSHeader.SetRA(RecursionAvailable: Boolean);
  Begin
    If RecursionAvailable Then fBitCode := fBitCode Or cRABit
    Else fBitCode := fBitCode And cRAMask;
  End;

  Function TDNSHeader.GetRCode : Word;
  Begin
    Result := (fBitCode And cRCodeBits);
  End;

  Procedure TDNSHeader.SetRCode(RCode: Word);
  Begin
    fBitCode := (RCode  And cRCodeBits) Or (fBitCode And cRCodeMask);
  End;

//----------------------- Start tDNSQuestionList -------------------------------
// Coded July 15, 1999 By RM
// Since A DNS Resolver can present requests to resolve several Domain names in
// a single request, we have users put them in a list. The Resolver then converts
// them to RFC 1035 format before trasmission
//------------------------------------------------------------------------------

  Constructor tDNSQuestionList.Create(AOwner : tComponent);
  Begin
    Inherited Create(AOwner);
    fList := TList.Create;
    fList.Clear;
    fCount := 0;
  End;

  Destructor tDNSQuestionList.Destroy;
  Var
    Idx : Integer;
    aPtr : ptDNSQuestion;
  Begin
    If fList.Count > 0 Then Begin
      For Idx := 0 To (fList.count -1) Do Begin
         aPtr := fList.Items[Idx];
         Dispose(aPtr);
       End;
     End;
    fList.Free;
    Inherited Destroy;
  End;

  Procedure tDNSQuestionList.Add(DNSQuestion: TDnsQuestion);
  Var
    pDNSQuestionItem : ptDNSQuestion;
  Begin
    New(pDNSQuestionItem);
    pDNSQuestionItem^.QName := DnsQuestion.QName;
    pDNSQuestionItem^.QType := DnsQuestion.QType;
    pDNSQuestionItem^.QClass := DnsQuestion.QClass;
    fList.Add(pDNSQuestionItem);
    fCount := fList.Count;
  End;

  Procedure tDNSQuestionList.Delete(Idx : Integer);
  Var
    pDNSQuestionItem : ptDNSQuestion;
  Begin
    If Idx < fList.Count Then Begin
      pDNSQuestionItem := fList.Items[Idx];
      Dispose(pDNSQuestionItem);
      fList.Delete(Idx);
      fCount := fList.Count;
    End;
  End;

  Procedure tDNSQuestionList.Clear;
  Var
    aPtr : ptDNSQuestion;
    Idx : Integer;
  Begin
    If fList.count > 0 Then Begin
      For Idx := 0 To (fList.count -1) Do Begin
         aPtr := fList.Items[Idx];
         Dispose(aPtr);
      End;
      fList.Clear;
    End;
    fCount := 0;
  End;

  Function tDNSQuestionList.GetDNSQuestion(Idx: Integer):tDNSQuestion;
  Var
    DNSQuestion : TDNSQuestion;
  Begin
    FillChar(DNSQuestion,SizeOf(DNSQuestion),0);
    Result := DNSQuestion;
    If (Idx < fList.Count) And (Idx >= 0) Then Begin
      Result := tDNSQuestion(fList.Items[Idx]^);
    End;
  End;

  Procedure tDNSQuestionList.UpdateDNSQuestion(Idx: Integer; aDNSQuestion : TDNSquestion);
  Begin
    If (Idx < fList.Count) And (Idx >= 0) Then Begin
      tDNSQuestion(fList.Items[Idx]^) := aDNSQuestion;
    End;
  End;
//------------------------ End tDNSQuestionList --------------------------------


//------------------------Start tDNSResourceList -------------------------------
// Coded July 15, 1999 By RM
// Since A DNS Server can reply to  requests to resolve several Domain names in
// a single reply, we present users WITH a  list of replies. The Resolver has
// converted them from RFC 1035 format to the more useable list format after
// reception.
//------------------------------------------------------------------------------

  Constructor TDNSResourceList.Create(AOwner : tComponent);
  Begin
    Inherited Create(AOwner);
    fList := TList.Create;
    fList.Clear;
    fCount := 0;
  End;

  Destructor TDNSResourceList.Destroy;
  Var
    Idx : Integer;
    aPtr : ptDNSREsource;
  Begin
    If fList.Count > 0 Then Begin
      For Idx := 0 To (fList.count -1) Do Begin
         aPtr := fList.Items[Idx];
         Dispose(aPtr);
       End;
     End;
    fList.Free;
    Inherited Destroy;
  End;


  Procedure tDNSResourceList.Add(DNSResource: tDNSResource);
  Var
    pDNSResourceItem : ptDNSResource;
  Begin
    New(pDNSResourceItem);
    pDNSResourceItem^.Name := DNSResource.Name;
    pDNSResourceItem^.aType := DNSResource.aType;
    pDNSResourceItem^.aClass := DNSResource.aClass;
    pDNSResourceItem^.TTL := DNSResource.TTL;
    pDNSResourceItem^.RdLength := DNSResource.RdLength;
    pDNSResourceItem^.RData := DNSResource.RData;
    fList.Add(pDNSResourceItem);
    fCount := fList.Count;
  End;

  Procedure tDNSResourceList.Delete(Idx : Integer);
  Var
    pDNSResourceItem : ptDNSResource;
  Begin
    If Idx < fList.Count Then Begin
      pDNSResourceItem := fList.Items[Idx];
      Dispose(pDNSResourceItem);
      fList.Delete(Idx);
      fCount := fList.Count;
    End;
  End;

  Procedure tDNSResourceList.Clear;
  Var
    aPtr : ptDNSResource;
    Idx : Integer;

  Begin
    If fList.count > 0 Then Begin
      For Idx := 0 To (fList.count -1) Do Begin
         aPtr := fList.Items[Idx];
         Dispose(aPtr);
      End;
      fList.Clear;
    End;
    fCount := 0;
  End;

  Function tDNSResourceList.GetDNSResource(Idx: Integer):tDNSResource;
  Var
    DNSResource : tDNSResource;

  Begin
    FillChar(DNSResource,SizeOf(DNSResource),0);
    Result := DNSResource;
    If (Idx < fList.Count) And (Idx >= 0) Then Begin
      Result := tDNSResource(fList.Items[Idx]^);
    End;
  End;

  Procedure tDNSResourceList.UpdateDNSResource(Idx: Integer; aDNSResource : tDNSResource);
  Begin
    If (Idx < fList.Count) And (Idx >= 0) Then Begin
      tDNSResource(fList.Items[Idx]^) := aDNSResource;
    End;
  End;

  Function tDNSResourceList.GetDNSRDataDomainName(Idx: Integer): String;
  Begin
    If (Idx < fList.Count) And (Idx >= 0) Then
      Result := tDNSResource(fList.Items[Idx]^).RData.DomainName
    Else Result := '';
  End;

  Function tDNSResourceList.GetDnsMxExchangeNameEx(Idx : Integer): String;
  Begin
    If (Idx < fList.Count) And (Idx >= 0) Then Begin
      Result := IntToStr(tDNSResource(fList.Items[Idx]^).RData.MX.Preference);
      While Length(Result) < 5 Do Result := ' '+ Result;
      Result := Result+' '+tDNSResource(fList.Items[Idx]^).RData.MX.Exchange;
    End
    Else Result := '';
  End;

//------------------------- End tDNSResourceList--------------------------------

//------------------------ Start TDNSMessage Code ------------------------------
// Coded July 15.. 17 1999 By HRM
//------------------------------------------------------------------------------

  Constructor TDNSMessage.Create(aOwner : tComponent);
  Begin
    Inherited Create(aOwner);
    fDNSHeader := TDnsHeader.Create(Self);
    fDnsQdList := tDNSQuestionList.Create(Self);
    fDnsAnList := TDNSResourceList.Create(Self);
    fDnsNsList := TDNSResourceList.Create(Self);
    fDnsArList := TDNSResourceList.Create(Self);
  End;

  Destructor TDNSMessage.Destroy;
  Begin
    fDNSHeader.Free;
    fDnsQdList.Free;
    fDnsAnList.Free;
    fDnsNsList.Free;
    fDnsArList.Free;
    Inherited Destroy;
  End;

  Procedure tDNSMessage.ClearVars;
  Begin
    fDNSHeader.InitVars;
    fDnsQdList.Clear;
    fDnsAnList.Clear;
    fDnsNsList.Clear;
    fDnsArList.Clear;
  End;

  Function TDNSMessage.CreateLabelStr(QName : String):String;
  Const
    aPeriod = '.';
  Var
    aLabel : String;
    ResultArray : Array[0..512] Of Char;
    NumBytes,
    aPos,
    RaIdx : Integer;

  Begin
    Result := '';
    FillChar(ResultArray,SizeOf(ResultArray),0);
    aPos := Pos(aPeriod,QName);
    RaIdx := 0;
    While (aPos <> 0) And ((RaIdx + aPos) < SizeOf(ResultArray)) Do Begin
      aLabel := Copy(QName,1,Pred(aPos));
      NumBytes := Succ(Length(Alabel));
      Move(aLabel,ResultArray[RaIdx],NumBytes);
      Inc(RaIdx,NumBytes);
      Delete(QName,1,aPos);
      aPos := Pos(aPeriod,QName);
    End;
    Result := String(ResultArray);
  End;

  Procedure TDnsMessage.CreateQueryPacket;
  Var
    QueryIdx : Integer;
    DnsQuestion : tDNSQuestion;

    Procedure DoDomainName(ADNS : String);
    Var
     BufStr : String;
     aPos : Integer;
    Begin                         { DoDomainName }
      While Length(aDns)>0 Do Begin
        aPos:=Pos('.',aDns);
        If aPos=0 Then aPos:=Length(aDns)+1;
        BufStr:=Copy(aDns,1,aPos-1);
        Delete(aDns,1,aPos);
        fQPacket:=fQPacket+Chr(Length(BufStr))+BufStr;
      End;
    End;                          { DoDomainName }

    Procedure DoHostAddress(aDNS :String);
    Var
      BufStr,
      BufStr2 : String;
      aPos : Integer;
    Begin                         { DoHostAddress }
      While Length(aDns)>0 Do Begin
        aPos:=Pos('.',aDns);
        If aPos =0 Then aPos:=Length(aDns)+1;
        BufStr:=Copy(aDns,1,aPos-1);
        Delete(aDns,1,aPos);
        BufStr2:=Chr(Length(BufStr))+BufStr + BufStr2;
      End;
      fQPacket:=fQPacket+BufStr2+Chr(07)+'in-addr'+Chr(04)+'arpa';
    End;                          { DoHostAddress }

  Begin                           { CreateQueryPacket }
    With fDNSHeader Do Begin
      fId:=Random(62000);
      fQdCount := fDnsQdList.Count;
      If fQdCount < 1 Then
        Raise  EDnsResolverError.Create(GetErrorStr(1,1));
      fQPacket := WordToTwoCharStr(fId);    //Query-ID
      fQPacket := fQPacket+ WordToTwoCharStr(fBitCode);// BitCodes
      fQPacket := fQPacket+WordToTwoCharStr(fQdCount); // #Queries
      fQPacket := fQPacket+Chr(0)+Chr(0)    // fAnCount
                      +Chr(0)+Chr(0)    // fNsCount
                      +Chr(0)+Chr(0);   // fArCount
    End;
    For QueryIdx := 0 To fDnsQdList.Count - 1 Do Begin
     DNsQuestion := fDnsQdList.GetDNSQuestion(QueryIdx);
      With DNSQuestion Do Begin
        Case Qtype Of
          cA     : DoDomainName(QName);
          cNS    : DoDomainName(QName);
          cMD    : Raise  EDnsResolverError.Create('MD is an Obsolete Command. Use MX.');
          cMF    : Raise  EDnsResolverError.Create('MF is an Obsolete Command. USE MX.');
          cName  : DoDomainName(QName);
          cSOA   : DoDomainName(Qname);
          cMB    : DoDomainName(QName);
          cMG    : DoDomainName(QName);
          cMR    : DoDomainName(QName);
          cNULL  : DoDomainName(QName);
          cWKS   : DoDomainName(QName);
          cPTR   : DoHostAddress(QName);
          cHINFO : DoDomainName(QName);
          cMINFO : DoDomainName(QName);
          cMX    : DoDomainName(QName);
          cTXT   : DoDomainName(QName);
          cAXFR  : DoDomainName(QName);
          cMAILB : DoDomainName(QName);
          cMailA : Raise  EDnsResolverError.Create('MailA is an Obsolete Command. USE MX.');
          cSTar  : DoDomainName(QName);
        End;
        fQPacket:=fQPacket+Chr(0);                    // Root is NULL length
        fQPacket:=fQPacket+WordToTwoCharStr(QType);   // QType
        fQPacket:=fQPacket+WordToTwoCharStr(QClass);  // QClass
      End;
    End;
    FQPackSize := Length(fQPacket);
  End;                            { CreateQueryPacket }

  Procedure TDNSMessage.DecodeReplyPacket;
  Var
    CharCount : Integer;
    Idx : Integer;
    ReplyId : Word;

    Function LabelsToDomainName(Const SrcStr : String; Var Idx : Integer): String;
    Var
      LabelStr : String;
      Len : Integer;
      SavedIdx : Integer;
      AChar :Char;
     Begin
      Result := '';
      SavedIdx := 0;
      Repeat
        Len := Byte(SrcStr[Idx]);
        If Len > 63 Then Begin
          If SavedIdx = 0 Then SavedIdx := Succ(Idx);
          aChar := Char(Len And $3F);
          Idx := TwoCharToWord(aChar,SrcStr[Idx+1])+1;
        End;
        If Idx > fRPackSize Then Begin
          Raise  EDnsResolverError.Create(GetErrorStr(2,2));
        End;
        SetLength(LabelStr,Byte(SrcStr[Idx]));
        Move(SrcStr[Idx+1],LabelStr[1], Length(LabelStr));
        Inc(Idx, Length(LabelStr)+1);
        If Pred(Idx) > fRPackSize Then
          Raise  EDnsResolverError.Create(GetErrorStr(2,3));
        Result  := Result + LabelStr +'.';
      Until (SrcStr[Idx] = Char(0)) Or (Idx >= Length(SrcStr));
      If Result[Length(Result)] = '.' Then Begin
        Delete(Result,Length(Result),1);
      End;
      If SavedIdx > 0 Then Idx := SavedIdx;
      Inc(Idx);
    End;

    Function ParseQuestions(StrIdx : Integer): Integer;
    Var
      DNSQuestion : TDNSQuestion;
      Idx : Integer;
     Begin                         { ParseQuestions }
      For Idx := 1 To fDNSHeader.fQdCount Do Begin
        FillChar(DnsQuestion,SizeOF(DNSQuestion),0);
        DnsQuestion.QName := LabelsToDomainName(RPacket,StrIdx);
        If StrIdx > fRPackSize Then
          Raise  EDnsResolverError.Create(GetErrorStr(2,4));
        DnsQuestion.Qtype := TwoCharToWord(RPacket[StrIdx],RPacket[StrIdx+1]);
        Inc(StrIdx,2);
        If StrIdx > fRPackSize Then
          Raise  EDnsResolverError.Create(GetErrorStr(2,5));
        DnsQuestion.QClass := TwoCharToWord(RPacket[StrIdx],RPacket[StrIdx+1]);
        If StrIdx +1  > fRPackSize Then
          Raise  EDnsResolverError.Create(GetErrorStr(2,6));
        Inc(StrIdx,2);
        fDnsQdList.Add(DnsQuestion);
      End;                        { ParseQuestions }
      Result := StrIdx;
    End;

    Function ParseResource(NumItems, StrIdx: Integer; DnsList: TDNSResourceList): Integer;
    Var
      RDataStartIdx : Integer;
      DnsResponse : tDNSResource;
      Idx : Integer;

      Procedure ProcessRData(sIdx : Integer);

        Procedure DoHostAddress;
        Var
         Idx : Integer;

        Begin                     { DoHostAddressRData }
          With DnsResponse Do Begin
          If sIdx +3 > fRPackSize Then
             Raise  EDnsResolverError.Create(GetErrorStr(2,7));
            For Idx := sIdx To sIdx +3 Do Begin
             RData.HostAddrStr := RData.HostAddrStr+IntToStr(Ord(RPacket[Idx]))+'.';
            End;
            Delete(RData.HostAddrStr,Length(RData.HostAddrStr),1);
          End;
        End;                      { DoHostAddressRData }

        Procedure DoDomainNameRData;
        Begin                     { DoDomainNameRData }
          DnsResponse.RData.DomainName := LabelsToDomainName(RPacket,sIdx);
          If Pred(sIdx) > fRPackSize Then
            Raise  EDnsResolverError.Create(GetErrorStr(2,8));
        End;                      { DoDomainNameRData }

        Procedure DoSOARdata;
        Begin                     { DoSOARData }
          With DnsResponse.RData.SOA Do Begin
            MName := LabelsToDomainName(RPacket,sIdx);
            If sIdx > fRPackSize Then
              Raise  EDnsResolverError.Create(GetErrorStr(2,9));
            RName := LabelsToDomainName(RPacket,sIdx);
            If sIdx +4 > fRPackSize Then
               Raise  EDnsResolverError.Create(GetErrorStr(2,10));
            Serial := FourCharToDWord(RPacket[sIdx],RPacket[sIdx+1],RPacket[sIdx+2],RPacket[sIdx+3]);
            Inc(sIdx,4);
            If sIdx +4 > fRPackSize Then
              Raise  EDnsResolverError.Create(GetErrorStr(2,11));
            Refresh := FourCharToDWord(RPacket[sIdx],RPacket[sIdx+1],RPacket[sIdx+2],RPacket[sIdx+3]);
            Inc(sIdx,4);
            If sIdx +4 > fRPackSize Then
              Raise  EDnsResolverError.Create(GetErrorStr(2,12));
            ReTry := FourCharToDWord(RPacket[sIdx],RPacket[sIdx+1],RPacket[sIdx+2],RPacket[sIdx+3]);
            Inc(sIdx,4);
            If sIdx +4 > fRPackSize Then
               Raise  EDnsResolverError.Create(GetErrorStr(2,13));
            Expire := FourCharToDWord(RPacket[sIdx],RPacket[sIdx+1],RPacket[sIdx+2],RPacket[sIdx+3]);
            Inc(sIdx,4);
            If sIdx + 3 > fRPackSize Then
              Raise  EDnsResolverError.Create(GetErrorStr(2,14));
            Minimum := FourCharToDWord(RPacket[sIdx],RPacket[sIdx+1],RPacket[sIdx+2],RPacket[sIdx+3]);
            Inc(sIdx,4);
          End;
        End;                      { DoSOARData }

        Procedure DoWKSRdata;
        Begin                     { DoWKSRData }
          With DnsResponse.RData.WKS Do Begin
            If sIdx + 4 > fRPackSize Then
               Raise  EDnsResolverError.Create(GetErrorStr(2,15));
            Address :=  FourCharToDWord(RPacket[sIdx],RPacket[sIdx+1],RPacket[sIdx+2],RPacket[sIdx+3]);
            Inc(sIdx,4);
            Protocol := Byte(RPacket[sIdx]);
            Inc(sIdx);
            If sIdx + 7 > fRPackSize Then
               Raise  EDnsResolverError.Create(GetErrorStr(2,16));
            Move(RPacket[sIdx],Bits, 8);
          End;
        End;                      { DoWKSRData }

        Procedure DoHInfoRdata;
        Begin                     { DoHInfoRData }
          With DnsResponse Do Begin
            If sIdx +Ord(RPacket[sIdx])+1 > fRPackSize Then
               Raise  EDnsResolverError.Create(GetErrorStr(2,17));
            Move(RPacket[sIdx],RData.Hinfo.CpuStr,Ord(RPacket[sIdx])+1);
            sIdx := sIdx + Length(RData.Hinfo.CpuStr) +2;
            If sIdx + Ord(RPacket[sIdx])+1 > fRPackSize Then
              Raise  EDnsResolverError.Create(GetErrorStr(2,18));
            Move(RPacket[sIdx], RData.Hinfo.OSStr,Ord(RPacket[sIdx])+1);
          End;
        End;                      { DoHInfoRData }

        Procedure DoMInfoRdata;
        Begin                     { DoMInfoRData }
          With DnsResponse Do Begin
            RData.Minfo.RMailBox := LabelsToDomainName(RPacket,sIdx);
            If sIdx > fRPackSize Then
              Raise  EDnsResolverError.Create(GetErrorStr(2,19));
            RData.MinFo.EMailBox := LabelsToDomainName(RPacket,sIdx);
            If sIdx > fRPackSize Then
              Raise  EDnsResolverError.Create(GetErrorStr(2,20));
          End;
        End;                      { DoMInfoRData }

        Procedure DoMXRData;
        Begin                     { DoMXRData }
          With DnsResponse Do Begin
            If sIdx +2 > fRPackSize Then
              Raise  EDnsResolverError.Create(GetErrorStr(2,21));
            RData.MX.Preference :=  TwoCharToWord(RPacket[sIdx],RPacket[sIdx+1]);
            Inc(sIdx,2);
            If sIdx +2 > fRPackSize Then
              Raise  EDnsResolverError.Create(GetErrorStr(2,22));
            RData.Mx.Exchange := LabelsToDomainName(RPacket,sIdx);
          End;
        End;                      { DoMXRData }

        Procedure DoMailBRdata;
        Begin                     { DoMailRData }
          Raise EDnsResolverError.Create('-Err 501 MailB is not implemented');
        End;                      { DoMailRData }

      Begin                       { ProcessRdata }
        Case DnsResponse.AType Of
          cA     : DoHostAddress;
          cNS    : DoDomainNameRData;
          cMD    : Raise EDnsResolverError.Create('MD is an Obsolete Command. Use MX.');
          cMF    : Raise EDnsResolverError.Create('MF is an Obsolete Command. USE MX.');
          cName  : DoDomainNameRData;
          cSOA   : DoSOARdata;
          cMB    : DoDomainNameRData;
          cMG    : DoDomainNameRData;
          cMR    : DoDomainNameRData;
          cNULL  : DnsResponse.StarData := Copy(RPacket,RDataStartIdx,DnsResponse.RdLength);
          cWKS   : DoWKSRdata;
          cPTR   : DoDomainNameRData;
          cHINFO : DoHInfoRdata;
          cMINFO : DoMInfoRdata;
          cMX    : DoMXRData;
          cTXT   : DnsResponse.StarData := Copy(RPacket,RDataStartIdx,DnsResponse.RdLength);
          cAXFR  : DnsResponse.StarData := Copy(RPacket,RDataStartIdx,DnsResponse.RdLength);
          cMAILB : DoMailBRData;
          cMailA : Raise EDnsResolverError.Create('MF is an Obsolete Command. USE MX.');
          cStar  : DnsResponse.StarData := Copy(RPacket,RDataStartIdx,DnsResponse.RdLength);
          Else{ Showmessage('Atype is '+INtTostr(DnsResponse.AType)+' String Idx is '+IntTosTr(sIdx))};
        End;
      End;                        { ProcessRdata }

    Begin                         { ParseResource }
      Result := 0;
      For Idx := 1 To NumItems Do Begin
        FillChar(DnsResponse,SizeOf(DnsResponse),0);
        DnsResponse.Name := LabelsToDomainName(RPacket,StrIdx);
        If StrIdx +10 > fRPackSize Then
            Raise  EDnsResolverError.Create(GetErrorStr(2,23));
        DnsResponse.aType := TwoCharToWord(RPacket[StrIdx],RPacket[StrIdx+1]);
        Inc(StrIdx,2);
        DnsResponse.aClass := TwoCharToWord(RPacket[StrIdx],RPacket[StrIdx+1]);
        Inc(StrIdx,2);
        DnsResponse.TTL := FourCharToDWord(RPacket[StrIdx],RPacket[StrIdx+1],
                                           RPacket[StrIdx+2],RPacket[StrIdx+3]);
        Inc(StrIdx,4);
        DnsResponse.RdLength := TwoCharToWord(RPacket[StrIdx],RPacket[StrIdx+1]);
        Inc(StrIdx,2);
        If Pred(StrIdx+DnsResponse.RdLength) > fRPackSize Then
          Raise  EDnsResolverError.Create(GetErrorStr(2,23));
        RDataStartIdx := StrIdx;
        ProcessRdata(StrIdx);
        Inc(StrIdx,DnsResponse.RdLength);
        DnsList.Add(DnsResponse);
        Result := StrIdx;
        If StrIdx >= Length(RPacket) Then Exit;
      End;
      If Result = 0 Then Result := StrIdx;
    End;                          { ParseResource }

  Begin                           { DecodeReplyPacket }
    ClearVars;
    fRPackSize := Length(RPacket);
    If fRPackSize < 4 Then
      Raise  EDnsResolverError.Create(GetErrorStr(3,28));
    CharCount := 1;
    With fDNSHeader Do Begin
      ReplyId := TwoCharToWord(RPacket[1],RPacket[2]);
      If ReplyId <> fid Then Begin
         Raise  EDnsResolverError.Create(GetErrorStr(4, Fid));
      End;
      Inc(CharCount,4);
      fBitCode := TwoCharToWord(RPacket[3],RPacket[4]);
      If RCode <> 0 Then
        Raise  EDnsResolverError.Create(GetRCodeStr(RCode));
      If fRPackSize < 12 Then
        Raise  EDnsResolverError.Create(GetErrorStr(5,29));
      fQdCount := TwoCharToWord(RPacket[5],RPacket[6]);
      fAnCount:= TwoCharToWord(RPacket[7],RPacket[8]);
      fNsCount := TwoCharToWord(RPacket[9],RPacket[10]);
      fArCount := TwoCharToWord(RPacket[11],RPacket[12]);
      If (fRPackSize < FQPackSize) Then
        Raise  EDnsResolverError.Create(GetErrorStr(5,30));
      For Idx := 1 To fQdCount Do Begin
       CharCount := ParseQuestions(13);
      End;
      If (Charcount >= fRPackSize)
      And ((fAnCount >0) Or (fNsCount > 0) Or (fArCount > 0)) Then
        Raise  EDnsResolverError.Create(GetErrorStr(6,31));
      If fAnCount > 0 Then Begin
        CharCount := ParseResource(fAnCount, CharCount, fDnsAnList);
      End;
      If (Charcount >= fRPackSize)
      And ((fNsCount > 0) Or (fArCount > 0)) Then
        Raise  EDnsResolverError.Create(GetErrorStr(6,32));
      If fNsCount > 0 Then Begin
        CharCount := ParseResource(fNsCount,CharCount, fDnsNsList);
      End;
      If (Charcount >= fRPackSize) And (fArCount > 0) Then
        Raise  EDnsResolverError.Create(GetErrorStr(6,33));
      If fArCount > 0 Then Begin
        CharCount := ParseResource(fArCount,CharCount, fDnsArList);
      End;
    End;
    fRPackSize := CharCount;
  End;                            { DecodeReplyPacket }

//------------------------ End TDNSMessage Code --------------------------------


//--------------------- Start of TWinshoeDNSResolver ---------------------------
// Coded July 15..17 1999 By RM
//------------------------------------------------------------------------------

  Constructor  TWinshoeDNSResolver.Create(aOwner : tComponent);
  Begin
    Inherited Create(aOwner);
    FDNSMessage := TDNSMessage.Create(Self);
    Port := WSPORT_DOMAIN;
  End;

  Destructor TWinshoeDNSResolver.Destroy;
  Begin
    FDNSMessage.Free;
    Inherited Destroy;
  End;

  Procedure TWinshoeDNSResolver.ClearVars;
  Begin
    fDnsMessage.ClearVars;
  End;

  Procedure TWinshoeMXResolver.GetMailServers(Const DomainName : String; ServerList : TStringList);
  Var
    DnsQuestion : TDNSQuestion;
    aStr : String;
    Idx,
    CharIdx : Integer;
  Begin                           { GetMailServers }
    ServerList.Clear;
    ClearVars;
    Try
      With DnsMessage.DNSHeader Do Begin
        ID := Id +1;  { Resolver/Server coordination Set to Random num on Create THEN Inc'd }
        Qr := False;  { False is a query; True is a response}
        Opcode := 0;  { 0 is Query 1 is Iquery Iquery is send IP return <domainname>}
        RD := True;   { Request Recursive search}
        QDCount := 1; { Just one Question }
      End;
      With DNSQuestion Do Begin {And the Question is ?}
        QName := DomainName;
        QType  := cMX;
        QClass := cIN;
      End;
      DnsMessage.DNSQDList.Add(DnsQuestion);   {Add question of List }
      DnsMessage.CreateQueryPacket;        { Turn Header and Question in to Query Packet }
      Connect;
      Try
        Send(DnsMessage.QPacket);
        //DnsMessage.RPacket := Receive; ORIGINAL
        //DnsMessage.RPacket := Receive(0);
      Finally
        DisConnect;
      End;
      ServerList.Sorted := True;
      DnsMessage.DecodeReplyPacket;
      If DnsMessage.DnsAnList.Count > 0 Then Begin
        For Idx := 0 To DnsMessage.DnsAnList.Count - 1 Do Begin
          ServerList.Add(DnsMessage.DnsAnList.GetDnsMxExchangeNameEx(Idx));
        End;
      End;
      ServerList.Sorted := False;
      If ServerList.Count > 0 Then Begin
        For Idx := 0 To ServerList.Count - 1 Do Begin
          aStr := ServerList.Strings[Idx];
          aStr := Trim(aStr);
          CharIdx := 1;
           While (CharIdx <= Length(aStr))
          And (aStr[CharIdx] In ['0'..'9']) Do Delete(aStr,1,1);
          aStr := Trim(aStr);
          ServerList.Strings[Idx] := aStr;
        End;
      End;
    Finally
      ClearVars;
    End;
  End;                            { GetMailServers }

End.
