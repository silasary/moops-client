unit SNTPWinshoe;

{*
  Winshoe SNTP (Simple Network Time Protocol)
  behaves more or less according to RFC-3030

 Originally by R. Brian Lindahl
 @author R. Brian Lindahl
 01/13/2000 - MTL - Moved to new Palette Tab scheme (Winshoes Clients)


*}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Winshoes, UDPWinshoe;

type
  TWinshoeSNTP = class(TWinshoeUDPClient)
  protected
    function GetDateTime : TDateTime;
  public
    constructor Create(aowner : tComponent); override;
{:
@example You can use code like the following to sync your local computer time with the NTP Server.<br>
<code>
var
  SysTimeVar: TSystemTime;
begin
  with WinshoeSNTP do begin
    DateTimeToSystemTime( DateTime, SysTimeVar) ;
    SetLocalTime( SysTimeVar );
  end;
end;
</code>:}
    property DateTime : TDateTime read GetDateTime;
  published
  end;

// Procs
	procedure Register;

implementation

type
  // format of NTP datagram
  tNTPGram = packed record
    head1, head2,
      head3, head4 : byte;
    RootDelay : longint;
    RootDisperson : longint;
    RefID : longint;
    Ref1, Ref2,
      Org1, Org2,
      Rcv1, Rcv2,
      Xmit1, Xmit2 : longint;
  end;

  // record to facilitate bigend <-> littleend conversions
  lr = packed record
    l1, l2, l3, l4 : byte;
  end;

// convert bigendian to littleendian or vice versa
function flip(var n : longint) : longint;
var
  n1, n2            : lr;
begin
  n1 := lr(n);
  n2.l1 := n1.l4;
  n2.l2 := n1.l3;
  n2.l3 := n1.l2;
  n2.l4 := n1.l1;
  flip := longint(n2);
end;

// get offset of time zone from Windows - returned as fractional days
// (same units as TDateTime)
// should be ADDED to convert local -> UTC
// should be SUBTRACTED to convert UTC -> local
function tzbias : double;
var
  tz                : TTimeZoneInformation;
begin
  GetTimeZoneInformation(tz);
  result := tz.Bias / 1440;
end;

const
  maxint2           = 4294967296.0;

// convert TDateTime to 2 longints - NTP timestamp format
procedure dt2ntp(dt : tdatetime; var nsec, nfrac : longint);
var
  d, d1             : double;
begin
  d := dt + tzbias - 2;                 // convert to UTC
  d := d * 86400;                       // convert days -> seconds

  d1 := d;
  if d1 > maxint then begin
  	d1 := d1 - maxint2;
  end;
  nsec := trunc(d1);

  d1 := ((frac(d) * 1000) / 1000) * maxint2;

  if d1 > maxint then begin
  	d1 := d1 - maxint2;
  end;
  nfrac := trunc(d1);
end;

// convert 2 longints - NTP timestamp format - to TDateTime
function ntp2dt(nsec, nfrac : longint) : tdatetime;
var
  d, d1             : double;
begin
  d := nsec;
  if d < 0 then d := maxint2 + d - 1;

  d1 := nfrac;
  if d1 < 0 then d1 := maxint2 + d1 - 1;
  d1 := d1 / maxint2;
  d1 := trunc(d1 * 1000) / 1000;        // round to milliseconds

  result := (d + d1) / 86400;

  // account for time zone and 2 day offset of TDateTime
  result := result - tzbias + 2;
end;

constructor TWinshoeSNTP.Create(aowner : tComponent);
begin
  inherited;
  // sntp is on port 123
  Port := 123;
end;
{:
@example You can use code like the following to sync your local computer time with the NTP Server.<br>
<code>
var
  SysTimeVar: TSystemTime;
begin
  with WinshoeSNTP do begin
    DateTimeToSystemTime( DateTime, SysTimeVar) ;
    SetLocalTime( SysTimeVar );
  end;
end;
</code>:}

function TWinshoeSNTP.GetDateTime : TDateTime;
var
  ng                : TNTPGram;
  s                 : string;
begin
  fillchar(ng, sizeof(ng), 0);

  // version 3, mode 3
  ng.head1 := $1B;

  dt2ntp(now, ng.Xmit1, ng.xmit2);
  ng.Xmit1 := flip(ng.xmit1);
  ng.Xmit2 := flip(ng.xmit2);

  setlength(s, sizeof(ng));
  move(ng, s[1], sizeof(ng));
  Connect;
  try
    UDPSize := sizeof(ng);
    Send(s);
    s := receive;
    move(s[1], ng, sizeof(ng));

    result := ntp2dt(flip(ng.xmit1), flip(ng.xmit2));
  finally
    Disconnect;
  end;
end;

procedure Register;
begin
  RegisterComponents('Winshoes Clients', [TWinshoeSNTP]);
end;

end.
