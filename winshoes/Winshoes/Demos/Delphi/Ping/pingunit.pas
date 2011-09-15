unit pingunit;
{------------------------------------------------------------------------------}
{ Program Unit : PingUnit.pas                                                  }
{ For Program  : PING.EXE                                                      }
{                                                                              }
{ Author       :   Ray Malone                                                  }
{ MBS Software                                                                 }
{ 251 E. 4th St.                                                               }
{ Chillicothe, OH 45601                                                        }
{  Started 08/28/99   Completed   08/29/99                                     }
{                                                                              }
{ The PING Program will work with all versions on Winsock?.dll                 }
{  It can use the ICMP.Dll or Raw Sockets                                      }
{  To user raw sockets set the Mode property to pmRAW and to use the           }
{  functions in the ICMP.Dll set Mode to pmICMP.                               }
{ IT needs version 1.1 of the Winsock DLL                                      }
{   Since all later versions support version 1.1 this code will work with all  }
{   Versions                                                                   }
{                                                                              }
{  Raw Sockets will not create in NT or Win 2000 unless the user has           }
{  Administrator rights.                                                       }
{  Microsoft had announced with the release of Win 98 that the ICMP.DlL would  }
{  not be in later versions of the operating system. They dropped the ICMP     }
{  files from the Platform SDK. Then the Oct 1999 SDK came out with the        }
{  ICMP.Dll documentationrestored. And Win 2000 RC-2 has the ICMP.DLL included }
{  So we decided to include suppopt for the ICMP.DLL in winshoes as well as    }
{  native Raw socket support.                                                  }
{------------------------------------------------------------------------------}
//------------------------------------------------------------------------------
// THIS COMPONENT USES THE Microsoft  ICMP.DLL
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

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  Buttons,
  ExtCtrls,
  WinshoePing, Winshoes;

type
  TWinshoesPingForm = class(TForm)
    Edit1: TEdit;
    PingBtn: TBitBtn;
    StatusBar1 : TStatusBar;
    OnImage: TImage;
    OffImage: TImage;
    Label1: TLabel;
    WinshoePing1: TWinshoePing;
    procedure PingBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure WinshoePingOnStatusChange(const Status : string);
    procedure WinshoePingOnReply(Const ReplyStatus : TReplyStatus);
  public
    { Public declarations }
  end;

var
  WinshoesPingForm: TWinshoesPingForm;

implementation

{$R *.DFM}

  procedure TWinshoesPingForm.FormCreate(Sender: TObject);
  begin
    PingBtn.Glyph := OffImage.Picture.BitMap;
  end;

  procedure TWinshoesPingForm.WinshoePingOnStatusChange(const Status : string);
  Begin
    StatusBar1.SimpleText := Status;
  end;

  procedure TWinshoesPingForm.WinshoePingOnReply(Const ReplyStatus : TReplyStatus);
  Begin
     PingBtn.Glyph := OffImage.Picture.BitMap;
     Application.ProcessMessages;
    With ReplyStatus do begin
      ShowMessage('Received '+ InttoStr(bytesReceived)+ ' bytes from '+FromIpAddress +#13+
                  'Message Type was: '+IntToStr(msgType)+#13+
                  'Sequence Id was : '+IntToStr(SequenceId)+#13+
                  'Round trip time was : '+IntTosTr(MsRoundTripTime) +' Ms');
    End;
  end;

  procedure TWinshoesPingForm.PingBtnClick(Sender: TObject);
  begin
     PingBtn.Glyph := ONImage.Picture.BitMap;
     Application.ProcessMessages;
    Try
      With WinShoePing1 Do Begin
        TimeOut := 8000;
        OnStatusChange :=  WinshoePingOnStatusChange;
        OnReply :=  WinshoePingOnReply;
        DestHost  := Edit1.Text;
        Ping;
      End;
    Finally
      PingBtn.Glyph := OffImage.Picture.BitMap;
      Application.ProcessMessages;
    end;
  end;

end.
