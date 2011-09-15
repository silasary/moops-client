(
  This file mix MASD syntax, SASM syntax and RPL syntax in
  order to ensure that the HP48 highlighter is working properly
  This file does not intent to be compiled and run.
  BTW, This is a RPL comment
)

* send a file to an XSERVER (This is also a RPL comment)
xNAME XPUT	( xNAME, :: and ; should be highlighted )
::
  CK1&Dispatch
  id
  ::
    "P" DOXMIT DROP
    DUP ID>$ xsendcommand
    ROMPTR xXSEND
  ;
;

* entering in SASM mode (the ASSEMBLE and RPL are RPL keywords)
ASSEMBLE
* This is a SASM comment
	A=A+A	A		this is a SASM comment. 
        A=A+A   A               the 2 parts of the instruction should be in SASM text
Label	RTN			The label should be in SASM keyword. This is a comment
RPL

* entering in SASM mode (through the CODE and ENDCODE RPL keywords)
CODE
* This is a SASM comment
	A=A+A	A		this is a SASM comment. 
        A=A+A   A               the 2 parts of the instruction should be in SASM text
Label	RTN			The label should be highlighted. This is a comment
ENDCODE

* Entering in MASD mode
CODEM
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % A % starts a comment that end at the end of the line
  % all jump words (GOTO, GOSUB, EXIT, UP, UPC, UPNC and labels should be highlighted
  % the assemby area stops on the ENDCODE directive
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  *ThisIsALabelTahtShouldBeHighlighted
  SAVE GOSBVL DisableIntr ST=0._RS232ONAbort  % standard init
  C=0.S C+10.S                                % ready to retry 10 times
  {
    C-1.S EXITC                               % first try
    ?ST=1._RS232ONAbort EXIT                  % abort?
    GOSBVL D1=DSKTOP A=DAT1.A D1=A D1+5       % D1 point on the string to send
    A=DAT1.A A-5.A ASRB.A D1+5                % Aa: nb chr in command
    B=A.A ASR.A ASR.A GOSUB .RS232SendOneChr  % send low byte
    A=B.B GOSUB .RS232SendOneChr              % and high byte
    D=0.A B-1.A SKC                           % Da: CRC, Ba: nb chr to send
    {
      C=DAT1.B D+C.B GOSUB .RS232SendOneChrC  % send one chr, update CRC
      D1+2 B-1.A UPNC                         % next char
    }
    C=D.B GOSUB .RS232SendOneChrC             % send CRC
    LC(5)#8192 GOSUB .RS232GetOneChr UPC      % wait for ACK or NAK
    LC(5)_XACK ?A#C.B UP                      % if ACK, finish, else retry
  }
  GOSBVL AllowIntr LOAD D1+5 D+1.A RPL        % go back to RPL, droping the string
ENDCODE

ASSEMBLEM
% This is an other MASD area that should act like the previous one
*Label GOTO Label A=A+A.A A+A.A
!RPL