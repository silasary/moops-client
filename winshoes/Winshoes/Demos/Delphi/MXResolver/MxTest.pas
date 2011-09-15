UNIT MxTest;

//------------------------------------------------------------------------------
// WinshoeMXResolver Test Demo
//
//------------------------------------------------------------------------------
//  MXResolverTest  Written July 21, 1999
//  Given a valid DomainName it will return a TStringList of Domain Names for
//  that domain's mail servers in priority order. That is priority 1 first
//  2 second..etc
// Many domains such as aol.com or microsoft.com often use several different
// Severs to accept mail. Thus sending mail to tbrowkaw@nbc.com does not go
// to nbc.com. It goes to ns.ge.com. The MX resolver resolves a domain name
// in an email addres to the fully qualified domain name of the mail server(s)
// for a domain.
//  USAGE:
//      VAR
//        aDomain : string;
//        aStrList : TStringList;
//
//     Begin
//       astrList := tStringList.Create;
//       aDomain := 'microsoft.com';
//       WinshoeMxResolver1.GetMailServers(adomain,aStrList);
//       With aStrlist do
//         DoStuff;
//      aStrList.Free
//
//  Mail servers have a priority. That is if a domain has several mail servers
//  each server has a priority. When an MX request retuns several mail servers
//  they are returned in priority order. The first server in the string list
//  should be tried first. Many large mail services, such as aol.com have
//  several mail servers.  Their priorities are all set to the same value. This
//  is done to divide the work load evenly between the several servers. Thus
//  subsequent MX calls to aol.com will produce a returned string list with the
//  servers in diffenent orders.
//
//  Since ABC radio and TV networks are now owned by Disney, it is interesting
//  to note that one  of the abc.com mail servers is huey.disney.com.  Does
//  anyone know to what tasks, Dewey and Louie are put? The other queston is
//  does Disney have a computer named goofy?
//
//
// Started Date : 07/20/1999 Version 0.10 Complete : Beta 1.0 07/24/1999
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

INTERFACE

USES
  Windows,
  Messages,
  StdCtrls,
  Classes,
  Controls,
  SysUtils,
  Graphics,
  Forms,
  Dialogs,
  WinShoeDNSResolver,
  ExtCtrls, ComCtrls, Winshoes, UDPWinshoe;

TYPE
  TMxTestForm = CLASS(TForm)
    Edit1: TEdit;
    Memo1: TMemo;
    ResolveBtn: TButton;
    Label1: TLabel;
    Panel1: TPanel;
    StatusBar: TStatusBar;
    MXResolver: TWinshoeMXResolver;
    PROCEDURE FormCreate(Sender: TObject);
    PROCEDURE ResolveBtnClick(Sender: TObject);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  MxTestForm: TMxTestForm;

IMPLEMENTATION

{$R *.DFM}

  PROCEDURE TMxTestForm.FormCreate(Sender: TObject);

  BEGIN
    StatusBar.SimpleText := 'Name Server: '+MxResolver.Host;
    Edit1.Text := 'mbssoftware.com';
  END;


  PROCEDURE TMxTestForm.ResolveBtnClick(Sender: TObject);

  VAR
    aStrList : TStringList;

  BEGIN
    Memo1.Clear;
    IF Edit1.Text = '' THEN Edit1.Text := 'mbssoftware.com'
    ELSE BEGIN
      AstrList := TstringList.Create;
      TRY
        MxResolver.GetMailServers(Edit1.Text,aStrList);
        Memo1.Lines.Add(AstrList.Text);
      FINALLY
        AStrList.Free;
      END;
      IF Memo1.Lines.Count = 0 THEN Memo1.Lines.Add('No MX Servers Found');
    END;
  END;


END.
