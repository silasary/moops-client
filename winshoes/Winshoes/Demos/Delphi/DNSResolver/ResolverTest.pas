UNIT ResolverTest;
//------------------------------------------------------------------------------
// WinshoeDNSResolver Test Demo
//
//
// Started Date : 07/20/1999 Version 0.10 Complete Beta 1.0 : 07/24/1999
//
// Author : Ray Malone
// MBS Software
// 251 E. 4th St.
// Chillicothe, OH 45601
//
// MailTo: ray@mbssoftware.com
//
//
//------------------------------------------------------------------------------
// The setup data for the Resolver is stored in the regsistry
// It stores the port and  primary, secondary and tertiany dns servers.
//------------------------------------------------------------------------------
// The TDNResolver is us just a UPD Client containing a TDnsMessage.
// Its sole funciton is to connect disconect send and receive DNS messages.
// The DnsMessage ecodes and decodes DNS messages
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
// A DNS Resolver sends a Dns Header and a DnsQuestion to a DNS server.
// Type DNS Header (tDNSHeader) is a component to store the header of
// a DNSResolver Query and Header DNS Server Response
// The ReEsolver sends the Server a header and the Sever returns it with various
// bits or values set.
//                   The DNS Header Contains the following
// The Most significant are the Rcodes (Return Codes) If the Rcode is 0 the
// the server was able to complete the requested task. Otherwise it contains
// an error code for what when wrong. The RCodes are listed in the
// WinshoeDnsResolver.pas file.
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
//------------------------------------------------------------------------------
//  TDNS Question
//  A DNS Question contains three pieces of data
//  They are:
//    QName  : ShortString;
//    QType  : Word;
//    QClass : Word;
//
//   QName is either a domain name or an IP address.
//   The QType is the type of question
//    They are requests for
//      A        a Host Address
//      NS       Authoritative name server
//      MD       A mail destination obsolete use MX (OBSOLETE)
//      MF       A mail forwarder obsolete use MX   (OBSOLETE)
//      Name     The canonical name for an alias
//      SOA      Marks the start of a zone of authority
//      MB       A mail box domain name (Experimental)
//      MG       A mail group member (Experimental)
//      MR       A mail Rename Domain Name (Experimental)
//      NULL     RR (Experimental)
//      WKS      A well known service description
//      PTR      A Domain Name Pointer (IP Addr) is question Answer is Domain name
//      HINFO    Host Information;
//      MINFO    Mailbox or Mail List Information;
//      MX       Mail Exchange
//      TXT      Text String;
//      AXFR     A Request for the Transfer of an entire zone;
//      MAILB    A request for mailbox related records (MB MG OR MR}
//      MAILA    A request for mail agent RRs (Obsolete see MX)
//      Star     A Request for all Records '*'
//
//  Winshoes implements these requests by defining constant values.
//  The identifier is preceeded by the letter c to show its a constant value
//   ca = 1;
//   cns =2   etc.
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//                        TDNS Response
//-----------------------------------------------------------------------------
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
//------------------------------------------------------------------------------
// DNS Servers return data in various forms. the TDnsMessage parses this data
// and puts it in structures depending on its aType as shown in the Const
// QType definitions above.
// Data Structures for the Responses to the various Qtypes are defined next.
// The data structures are named for the types of questions and responses (QType)
//
//------------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//
//Type
//  ptDNSResource = ^TDNSresource;
//  tDNSResource = Record
//    Name : ShortString;
//    aType : Word;
//    aClass : Word;
//    TTL   : DWord;
//    RdLength : Word;
//    RData : TRData;
//    StarData: String;
//  End;
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//
// The Returnd Data (RData) from a server in response to a query can be in
// several formats the following variant record is used to hold the returned
// data.
//-----------------------------------------------------------------------------
//  TRdata = Record
//    Case Byte Of
//      1 : (DomainName : ShortString);
//      2 : (HInfo : tHInfo);
//      3 : (MInfo : tMInfo);
//      4 : (MX : TMx);
//      5 : (SOA : TSOA);
//      6 : (A : DWord);
//      7 : (WKS : TWks);
//      8 : (Data : Array[0..4096] Of Char);
//      9 : (HostAddrStr : ShortString);
//    End;
//
//
//    Type
//      tHInfo = Record
//        CPUStr : ShortString;
//        OsStr : ShortString;
//     End;
//
//
//    tMInfo = Record
//      RMailBox : ShortString;
//      EMailBox : ShortString;
//    End;
//
//
//    tMX = Record
//      Preference : Word;       { This is the priority of this server }
//      Exchange : ShortString; {this is the Domain name of the Mail Server }
//    End;
//
//
//    TSOA = Record
//      MName : ShortString;
//      RName : ShortString;
//      Serial : DWord;
//      Refresh : DWord;
//      ReTry : Dword;
//      Expire : Dword;
//      Minimum : DWord;
//    End;
//
//
//   TWKS = Record
//     Address : Dword;
//     Protocol : Byte;
//     Bits : Array[0..7] Of Byte;
//    End;


//------------------------------------------------------------------------------
// Header, question, and response objects make up the DNS Message object.
// the TDNSQuestionList is used to hold both the send and received queries
// in easy to handle pascal data structures
// A Question Consists of a Name, Atype and aClass.
//   Name can be a domain name or an IP address depending on the type of
//   question. Question and answer types and Classes are given constant names
//   as defined in WinshoeDnsResolver.pas
//------------------------------------------------------------------------------
//
// The PROCEDURE CreateQueryPacket takes the Mesage header and questions and
// formats them in to a query packet for sending. When the Server responds
// with a reply packet the  PROCEDURE DecodeReplyPacket formats the reply into
// the proper response data structures depending on the type of reponse.
//------------------------------------------------------------------------------


INTERFACE

USES
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Winshoes,
  StdCtrls,
  Buttons,
  ExtCtrls,
  ComCtrls,
  UDPWinshoe,
  WinshoeDnsResolver;


TYPE
  TResolverForm = CLASS(TForm)
    ConnectBtn: TBitBtn;
    Memo: TMemo;
    Edit1: TEdit;
    QueryTypeListBox: TListBox;
    Panel1: TPanel;
    SelectedQueryLabel: TPanel;
    WarningMemo: TMemo;
    DNSLabel: TPanel;
    StatusBar: TStatusBar;
    DNSResolver: TWinshoeDNSResolver;
    PROCEDURE ConnectBtnClick(Sender: TObject);
    PROCEDURE FormCreate(Sender: TObject);
    PROCEDURE QueryTypeListBoxClick(Sender: TObject);
  PRIVATE
    { Private declarations }
    {DNSResolver : WinshoeDnsResolver;}
    InProgress  : Boolean;
    aQueryType : Integer;
    PROCEDURE ShowQueryType;
    PROCEDURE DisplayResults;
  PUBLIC
    { Public declarations }
  END;

VAR
  ResolverForm: TResolverForm;

IMPLEMENTATION

{$R *.DFM}


  PROCEDURE TResolverForm.FormCreate(Sender: TObject);

  BEGIN                           { FormCreate }
    aQueryType := 1;
    QueryTypeListBox.ItemIndex := 0;
    ShowQueryType;
    StatusBar.SimpleText := 'Current Domain Name Server is :  '+DnsResolver.Host;
  END;                            { FormCreate }


  PROCEDURE TResolverForm.ShowQueryType;

  BEGIN                           { ShowQueryType }
    WITH SelectedQueryLabel DO BEGIN
      Alignment := taCenter;
      Caption := 'Selected Query Type is '+GetQTypeStr(aQueryType);
      Alignment := taCenter;
    END;
    IF aQueryType = cPTR THEN DnsLabel.Caption := 'Enter IP Address'
    ELSE DnsLabel.Caption := 'Enter Domain Name';
  END;                            { ShowQueryType }


  PROCEDURE TResolverForm.QueryTypeListBoxClick(Sender: TObject);

  BEGIN                           { QueryTypeListBoxClick }
    WITH QueryTypelistBox DO BEGIN
      IF  ItemIndex > -1 THEN BEGIN
        aQueryType := Succ(ItemIndex);
      END;
      IF aQueryType > 16 THEN BEGIN
        aQueryType := aQueryType  + 235;
      END;
      ShowQueryType;
    END;
  END;                            { QueryTypeListBoxClick }


  PROCEDURE  TResolverForm.DisplayResults;

  VAR
    DnsResource : TDnsResource;
    Idx : Integer;

    PROCEDURE ShowaList;

      PROCEDURE ShowSoa;

      BEGIN                       { ShowSoa }
        WITH DnsResource.Rdata.SOA DO BEGIN
          Memo.Lines.Add('Primary Data Src :  '+MName);
          Memo.Lines.Add('Responsible Mailbox :  '+Rname);
          Memo.Lines.Add('Serial : ' +IntToStr(Serial)+'   Refresh : '+IntTostr(REfresh)
                         + '    Retry : '+IntTosTr(Retry));
          Memo.Lines.Add('Expire :  '+IntTosTr(Expire)+'   Minimum : '+IntToStr(Minimum));
        END;
      END;                        { ShowSoa }


    BEGIN                         { ShowAList }
      Memo.Lines.Add('Resource name is :  '+DnsResource.Name);
      Memo.Lines.Add('Type is :  '+GetQTypeStr(DnsResource.aType)+ '    Class is :  '+GetQClassStr(DnsResource.AClass));
      CASE DnsResource.aType OF
        cA : Memo.Lines.Add('IP Address is :  '+DnsResource.Rdata.DomainName);
        cSoa : ShowSoa;
        cPtr : Memo.Lines.Add('Domain name is :  '+DnsResource.Rdata.DomainName);
        cMx :Memo.Lines.Add('MX Priority :  '+IntToStr(DnsResource.Rdata.MX.Preference)
                         +'         MX Server :  ' + DNsResource.Rdata.MX.Exchange);

        ELSE Memo.Lines.Add('Domain name is :  '+DnsResource.Rdata.DomainName);
      END;
      Memo.Lines.Add('');
    END;                          { ShowAList }


  BEGIN                           { DisplayResults }
    Memo.Lines.Clear;
    WITH DNSResolver DO BEGIN
      IF DnsMessage.DnsAnList.Count > 0 THEN BEGIN
        Memo.Lines.Add('Answer List'+#13+#10);
        FOR Idx := 0 TO DnsMessage.DnsAnList.Count - 1 DO BEGIN
          DnsResource := DNSMessage.DnsAnList.GetDnsResource(Idx);
          ShowAList;
        END;
      END;
      Memo.Lines.Add('');
      IF DnsMessage.DnsNsList.Count > 0 THEN BEGIN
        Memo.Lines.Add('Authority List'+#13+#10);
        FOR Idx := 0 TO DnsMessage.DnsNsList.Count - 1 DO BEGIN
          DnsResource := DNSMessage.DnsNsList.GetDnsResource(Idx);
          ShowAList;
        END;
      END;
      Memo.Lines.Add('');
      IF DnsMessage.DnsArList.Count > 0 THEN BEGIN
        Memo.Lines.Add('Additional Response List'+#13+#10);
        FOR Idx := 0 TO DnsMessage.DnsArList.Count - 1 DO BEGIN
          DnsResource := DNSMessage.DnsArList.GetDnsResource(Idx);
          ShowAList;
        END;
      END;
    END;
  END;                            { DisplayResults }


  PROCEDURE TResolverForm.ConnectBtnClick(Sender: TObject);

  VAR
    DnsQuestion : TDNSQuestion;

  BEGIN                           { ConnectBtnClick }
   IF InProgress THEN Exit;
   InProgress := True;
   TRY
     Memo.Clear;
     DnsResolver.ClearVars;
     WITH DnsREsolver.DNSMessage.DNSHeader DO BEGIN
         ID := Id +1;  { Resolver/Server coordination Set to Random num on Create THEN inc'd }
         Qr := False;  { False is a query; True is a response}
         Opcode := 0;  { 0 is Query 1 is Iquery Iquery is send IP return <domainname>}
         RD := True;   { Request Recursive search}
         QDCount := 1; { Just one Question }
      END;
      WITH DNSQuestion DO BEGIN {And the Question is ?}
        IF Length(Edit1.Text) = 0 THEN BEGIN
          IF aQueryType = cPTR THEN Qname := '209.239.140.2'
          ELSE  QName := 'mbssoftware.com'
        END
        ELSE QName  := Edit1.Text;
        QType  := aQueryType;
        QClass := cIN;
      END;
      WITH DNSResolver DO BEGIN
        DnsMessage.DNSQDList.Add(DnsQuestion);   {Add question of List }
        DnsMessage.CreateQueryPacket;        { Turn Header and Question in to Query Packet }
        Connect;
        TRY
          Send(DnSMessage.QPacket);
          DnsMessage.RPacket := Receive;
        FINALLY
          DisConnect;
        END;
        DNSMessage.DecodeReplyPacket;
      END;
      DisplayResults;
    FINALLY
      InProgress := False;
    END;
  END;                            { ConnectBtnClick }


END.
