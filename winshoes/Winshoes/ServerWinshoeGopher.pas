unit ServerWinshoeGopher;

interface

{
13-JAN-2000 MTL
  - Moved to new Palette Scheme (Winshoes Servers)
  - Fixed a few compiler warnings
10 Oct 1999 Pete Mee
 - Added SendDirectoryEntryPlus
7 Oct 1999 Pete Mee
 - Completed constants
 - Added Gopher+ Events
6 Oct 1999 Pete Mee
 - Added some GPlusxxx constants
 - Altered constants for Item_Image, Item_Sound & Item_Movie to match Gopher+
3 Oct 1999 Pete Mee
 - Gopher server is very basic... started & completed...
}

uses
  Classes,
  ServerWinshoe,
  GlobalWinshoe;

{Typical connection:
 - Client attaches with no data
 - Server accepts with no data
 - Client sends request with CR LF termate (CRLF only for root)
 - Server sends items available each with CRLF termating
 - Server sends .CRLF
 - Server close connection
}

Const
  {Item constants - comments taken from RFC}
  Item_Document : Char = '0'; // Item is a file
  Item_Directory : Char = '1'; // Item is a directory
  Item_CSO : Char = '2'; // Item is a CSO phone-book server
  Item_Error : Char = '3';  // Error
  Item_BinHex : Char = '4'; // Item is a BinHexed Macintosh file.
  Item_BinDOS : Char = '5'; // Item is DOS binary archive of some sort.
    // Client must read until the TCP connection closes.  Beware.
  Item_UUE : Char = '6'; // Item is a UNIX uuencoded file.
  Item_Search : Char = '7'; // Item is an Index-Search server.
  Item_Telnet : Char = '8'; // Item points to a text-based telnet session.
  Item_Binary : Char = '9'; // Item is a binary file.
    // Client must read until the TCP connection closes.  Beware.
  Item_Redundant : Char = '+'; // Item is a redundant server
  Item_TN3270 : Char = 'T'; // Item points to a text-based tn3270 session.
  Item_GIF : Char = 'g'; // Item is a GIF format graphics file.
  Item_Image : Char = ':'; // Item is some kind of image file.
    // Client decides how to display.  Was 'I', but depracted
  {Items discovered outside of Gopher RFC - "Gopher+"}
  Item_Sound : Char = '<';  //Was 'S', but deprecated
  Item_Movie : Char = ';';  //Was 'M', but deprecated
  Item_HTML : Char = 'h';
  Item_MIME : Char = 'M';
  Item_Information : Char = 'i'; // Not a file - just information

  //Gopher+ additional information
  GPlusInfo = '+INFO: ';
  { Info format is the standard Gopher directory entry + TAB + '+'.
    The info is contained on the same line as the '+INFO: '}
  GPlusAdmin = '+ADMIN:' + CR + LF;
  { Admin block required for every item.  The '+ADMIN:' occurs on a
    line of it's own (starting with a space) and is followed by
    the fields - one per line.

    Required fields:
    ' Admin: ' [+ comments] + '<' + admin e-mail address + '>'
    ' ModDate: ' [+ comments] + '<' + dateformat:YYYYMMDDhhmmss + '>'

    Optional fields regardless of location:
    ' Score: ' + relevance-ranking
    ' Score-range: ' + lower-bound  + ' ' + upper-bound

    Optional fields recommended at the root only:
    ' Site: ' + site-name
    ' Org: ' + organization-description
    ' Loc: ' + city + ', ' + state + ', ' + country
    ' Geog: ' + latitude + ' ' + longitude
    ' TZ: ' + GMT-offset

    Additional recorded possibilities:
    ' Provider: ' + item-provider-name
    ' Author: ' + author
    ' Creation-Date: ' + '<' + YYYYMMDDhhmmss + '>'
    ' Expiration-Date: ' + '<' + YYYYMMDDhhmmss + '>'
    }
  GPlusViews = '+VIEWS:' + CR + LF;
  { View formats are one per line:
    ' ' + mime/type [+ langcode] + ': <' + size estimate + '>'
    ' ' + logcode = ' ' + ISO-639-Code + '_' + ISO-3166-Code
  }
  GPlusAbstract = '+ABSTRACT:' + CR + LF;
  { Is followed by a (multi-)line description.  Line(s) begin with
    a space.}
  GPlusAsk = '+ASK:';

  //Questions for +ASK section:
  AskPassword = 'AskP: ';
  AskLong = 'AskL: ';
  AskFileName = 'AskF: ';

  // Prompted responses for +ASK section:
  Select = 'Select: '; // Multi-choice, multi-selection
  Choose = 'Choose: '; // Multi-choice, single-selection
  ChooseFile = 'ChooseF: '; //Multi-choice, single-selection


  //Known response types:
  Data_BeginSign = '+-1' + CR + LF;
  Data_EndSign = CR + LF + '.' + CR + LF;
  Data_UnknownSize = '+-2' + CR + LF;

Type
  TRequestEvent = procedure(Thread : TWinshoeServerThread; Request : String)
    of object;
  TRequestPlusEvent = procedure(Thread : TWinshoeServerThread; Request : String;
    Representative : String; DataFlag : String) of object;
  TRequestItems = procedure(Thread : TWinshoeServerThread; Request : String;
    LimitItems : String) of object;

  TWinshoeGopherListener = class(TWinshoeListener)
  private
    // RFC Gopher request
    fOnRequest : TRequestEvent;
    // Gopher+ requests
    fOnRequestPlus : TRequestPlusEvent;
    fOnRequestInformation : TRequestItems;
    fOnRequestAllItems : TRequestItems;
    fOnRequestQuery : TRequestItems;

    // 'Polite' gopher settings - shouldn't send a User Friendly name of
    // more than 70 characters.
    fTruncateUserFriendly : Boolean;
    fTruncateLength : Integer;
  protected
    function DoExecute(Thread : TWinshoeServerThread): boolean; override;
  public
    constructor Create(AOwner : TComponent); override;
    // Formats the parameters for a Gopher entry and sends the information
    procedure SendDirectoryEntry(Thread : TWinshoeServerThread;
      ItemType : Char; UserFriendlyName, RealResourceName : String;
      HostServer : String; HostPort : Integer);

    // Formats the parameters for a Gopher+ entry and sends the information
    procedure SendDirectoryEntryPlus(Thread : TWinshoeServerThread;
      ItemType : Char; UserFriendlyName, RealResourceName : String;
      HostServer : String; HostPort : Integer; Additions : String);

    procedure SetTruncateUserFriendlyName(truncate : Boolean);
    procedure SetTruncateLength(length : Integer);
  published
    // Only one Gopher Event needed
    property OnRequest : TRequestEvent read fOnRequest write fOnRequest;
    // Some alternate events for Gopher+
    property OnRequestPlus : TRequestPlusEvent read fOnRequestPlus
      write fOnRequestPlus;
    property OnRequestInformation : TRequestItems read fOnRequestInformation
      write fOnRequestInformation;
    property OnRequestAllItems : TRequestItems read fOnRequestAllItems
      write fOnRequestAllItems;
    property OnRequestQuery : TRequestItems read fOnRequestQuery
      write fOnRequestQuery;

    property TruncateUserFriendlyName : Boolean read fTruncateUserFriendly
      write SetTruncateUserFriendlyName default True;
    property TruncateLength : Integer read fTruncateLength
      write SetTruncateLength default 70;
  end;

  procedure Register;

implementation

uses
  StringsWinshoe, SysUtils,
  Winshoes;

procedure Register;
begin
  RegisterComponents('Winshoes Servers', [TWinshoeGopherListener]);
end;

constructor TWinshoeGopherListener.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := WSPORT_GOPHER;
end;

function TWinshoeGopherListener.DoExecute(Thread: TWinshoeServerThread): boolean;
var
   s, first, second : String;
   i : Integer;
begin
  result:=inherited DoExecute(Thread);
  if result then begin
     exit;
  end;

  with Thread.Connection do begin
    while Connected do begin
      try
        s:=ReadLn;
        i := Pos(TAB, s);
        if i > 0 then begin
           case s[i + 1] of
             '+' : begin
               first := Copy(s, i + 2, length(s));
               s := Copy(s, 1, i - 1);
               i := Pos(TAB, first);
               if i > 0 then begin
                  second := Copy(first, i + 1,
                    length(first));
                  first := Copy(first, 1, i - 1);
               end else begin
                   second := '';
               end;
               if Assigned(OnRequestPlus) then begin
                  OnRequestPlus(Thread, s, first, second);
               end else begin
                   Thread.Connection.WriteLn('.');
                   Thread.Connection.Disconnect;
               end;
             end;
             '!' : begin
               first := Copy(s, i + 2, length(s));
               s := Copy(s, 1, i - 1);
               if Assigned(OnRequestInformation) then begin
                  OnRequestInformation(Thread, s, first);
               end else begin
                   Thread.Connection.WriteLn('.');
                   Thread.Connection.Disconnect;
               end;
             end;
             '$' : begin
               first := Copy(s, i + 2, length(s));
               s := Copy(s, 1, i - 1);
               if Assigned(OnRequestAllItems) then begin
                  OnRequestAllItems(Thread, s, first);
               end else begin
                   Thread.Connection.WriteLn('.');
                   Thread.Connection.Disconnect;
               end;
             end;
             '?' : begin
               first := Copy(s, i + 2, length(s));
               s := Copy(s, 1, i - 1);
               if Assigned(OnRequestQuery) then begin
                  OnRequestQuery(Thread, s, first);
               end else begin
                   Thread.Connection.WriteLn('.');
                   Thread.Connection.Disconnect;
               end;
             end;
           end;
        end else begin
            //Standard Gopher request
            if Assigned(OnRequest) then begin
               OnRequest(Thread, s)
            end else begin
                Thread.Connection.WriteLn('.');
                Thread.Connection.Disconnect;
            end;
        end;
      except
        Thread.Connection.Disconnect;
      end;
    end;
  end;
end; {doExecute}

procedure TWinshoeGopherListener.SendDirectoryEntry;
{
Format of server reply to directory (assume no spacing between - i.e.,
one line, with CR LF at the end)
 - Item Type
 - User Description (without tab characters)
 - Tab
 - Server-assigned string to this individual Item Type resource
 - Tab
 - Domain Name of host
 - Tab
 - Port # of host
}
begin
     if fTruncateUserFriendly then begin
        if (Length(UserFriendlyName) > fTruncateLength)
        and (fTruncateLength <> 0) then begin
            UserFriendlyName := Copy(UserFriendlyName, 1, fTruncateLength);
        end;
     end;

     Thread.Connection.WriteLn(ItemType + UserFriendlyName +
       TAB + RealResourceName + TAB + HostServer + TAB + IntToStr(HostPort));
end;

procedure TWinshoeGopherListener.SendDirectoryEntryPlus;
{ As SendDirectoryEntry but an additional TAB + additions }
begin
     if fTruncateUserFriendly then begin
        if (Length(UserFriendlyName) > fTruncateLength)
        and (fTruncateLength <> 0) then begin
            UserFriendlyName := Copy(UserFriendlyName, 1, fTruncateLength);
        end;
     end;

     Thread.Connection.WriteLn(ItemType + UserFriendlyName +
       TAB + RealResourceName + TAB + HostServer + TAB + IntToStr(HostPort) +
       TAB + Additions);
end;

procedure TWinshoeGopherListener.SetTruncateUserFriendlyName;
begin
     fTruncateUserFriendly := Truncate;
end;

procedure TWinshoeGopherListener.SetTruncateLength;
begin
     fTruncateLength := Length;
end;
end.
