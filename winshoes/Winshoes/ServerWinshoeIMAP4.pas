Unit ServerWinshoeIMAP4;

Interface
{------------------------------------------------------------------------------}
{ Program Unit : ServerWinshoeIMAP4                                            }
{ Component  :  twinshoeIMAP4Sever                                             }
{                                                                              }
{ Author       : Ray Malone                                                    }
{ MBS Software                                                                 }
{ 251 E. 4th St.                                                               }
{ Chillicothe, OH 45601                                                        }
{  Started             Completed                                               }
{                                                                              }
{  Based on  RFC 2060 - IMAP4 Protocol (Structure).                            }
{------------------------------------------------------------------------------}
{ THIS UNIT IS UNDER CONSTRUCION.                                              }
{                                                                              }
{ Commands IMPLEMENTED                                                         }
{                                                                              }
{                                                                              }
{ Commands to Do                                                               }
{  CAPABILITY                                                                  }
{   NOOP                                                                       }
{   LOGOUT                                                                     }
{   AUTHENTICATE                                                               }
{   LOGIN                                                                      }
{   SELECT                                                                     }
{   EXAMINE                                                                    }
{   CREATE                                                                     }
{   DELETE                                                                     }
{   RENAME                                                                     }
{   SUBSCRIBE                                                                  }
{   UNSUBSCRIBE                                                                }
{   LIST                                                                       }
{   LSUB                                                                       }
{   STATUS                                                                     }
{   APPEND                                                                     }
{   CHECK                                                                      }
{   CLOSE                                                                      }
{   EXPUNGE                                                                    }
{   SEARCH                                                                     }
{   FETCH                                                                      }
{   STORE                                                                      }
{   COPY                                                                       }
{   UID                                                                        }
{   XCmds                                                                      }
{                                                                              }
{------------------------------------------------------------------------------}

// CHANGES
//
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
//

Uses
  Classes,
  ServerWinshoe;
Const
   WSPORT_IMAP = 143;

Const
  IMAPCommands : Array [1..25] Of String =
  ({ Client Commands - Any State}
   'CAPABILITY',
   'NOOP',
   'LOGOUT',
   { Client Commands - Non Authenticated State}
   'AUTHENTICATE',
   'LOGIN',
   { Client Commands - Authenticated State}
   'SELECT',
   'EXAMINE',
   'CREATE',
   'DELETE',
   'RENAME',
   'SUBSCRIBE',
   'UNSUBSCRIBE',
   'LIST',
   'LSUB',
   'STATUS',
   'APPEND',
   { Client Commands - Selected State}
   'CHECK',
   'CLOSE',
   'EXPUNGE',
   'SEARCH',
   'FETCH',
   'STORE',
   'COPY',
   'UID',
   { Client Commands - Experimental/ Expansion}
   'X');


Type
  tCommandEvent = Procedure(Thread: TWinshoeServerThread;Const Tag, CmdStr : String;  Var Handled : Boolean) Of Object;

  TWinshoeIMAP4Listener = Class(TWinshoeListener)
  Private
    fOnCommandCAPABILITY : TCommandEvent;
    fONCommandNOOP: TCommandEvent;
    fONCommandLOGOUT: TCommandEvent;
    fONCommandAUTHENTICATE: TCommandEvent;
    fONCommandLOGIN: TCommandEvent;
    fONCommandSELECT : TCommandEvent;
    fONCommandEXAMINE : TCommandEvent;
    fONCommandCREATE : TCommandEvent;
    fONCommandDELETE : TCommandEvent;
    fONCommandRENAME : TCommandEvent;
    fONCommandSUBSCRIBE : TCommandEvent;
    fONCommandUNSUBSCRIBE : TCommandEvent;
    fONCommandLIST : TCommandEvent;
    fONCommandLSUB : TCommandEvent;
    fONCommandSTATUS : TCommandEvent;
    fONCommandAPPEND : TCommandEvent;
    fONCommandCHECK : TCommandEvent;
    fONCommandCLOSE : TCommandEvent;
    fONCommandEXPUNGE : TCommandEvent;
    fONCommandSEARCH : TCommandEvent;
    fONCommandFETCH : TCommandEvent;
    fONCommandSTORE : TCommandEvent;
    fONCommandCOPY : TCommandEvent;
    fONCommandUID : TCommandEvent;
    fONCommandX : TCommandEvent;
    fOnCommandError : TCommandEvent;
  Protected
    Procedure DoCommandCapability(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandNOOP(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandLOGOUT(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandAUTHENTICATE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandLOGIN(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandSELECT(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandEXAMINE(Thread: TWinshoeServerThread; Const Tag, mdStr :String;
                                Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandCREATE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandDELETE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandRENAME(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandSUBSCRIBE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandUNSUBSCRIBE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandLIST(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandLSUB(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandSTATUS(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandAPPEND(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandCHECK(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandCLOSE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandEXPUNGE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandSEARCH(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandFETCH(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandSTORE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandCOPY(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandUID(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandX(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Procedure DoCommandError(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Virtual; Abstract;
    Function DoExecute(Thread: TWinshoeServerThread): Boolean; Override;
  Public
    Constructor Create(AOwner: TComponent); Override;
  Published
    Property ONCommandCAPABILITY : TCommandEvent Read fOnCommandCAPABILITY Write fOnCommandCAPABILITY;
    Property ONCommandNOOP : TCommandEvent Read fONCommandNOOP Write fONCommandNOOP;
    Property ONCommandLOGOUT : TCommandEvent Read fONCommandLOGOUT Write fONCommandLOGOUT;
    Property ONCommandAUTHENTICATE : TCommandEvent Read fONCommandAUTHENTICATE Write fONCommandAUTHENTICATE;
    Property ONCommandLOGIN : TCommandEvent Read fONCommandLOGIN Write fONCommandLOGIN;
    Property ONCommandSELECT : TCommandEvent Read fONCommandSELECT Write fONCommandSELECT;
    Property OnCommandEXAMINE :TCommandEvent Read fOnCommandEXAMINE Write fOnCommandEXAMINE;
    Property ONCommandCREATE  :  TCommandEvent Read fONCommandCREATE Write fONCommandCREATE;
    Property ONCommandDELETE  :  TCommandEvent Read fONCommandDELETE Write fONCommandDELETE;
    Property OnCommandRENAME : TCommandEvent Read fOnCommandRENAME Write fOnCommandRENAME;
    Property ONCommandSUBSCRIBE  :  TCommandEvent Read fONCommandSUBSCRIBE Write fONCommandSUBSCRIBE;
    Property ONCommandUNSUBSCRIBE  :  TCommandEvent Read fONCommandUNSUBSCRIBE Write fONCommandUNSUBSCRIBE;
    Property ONCommandLIST  :  TCommandEvent Read fONCommandLIST Write fONCommandLIST;
    Property OnCommandLSUB : TCommandEvent Read fOnCommandLSUB Write fOnCommandLSUB;
    Property ONCommandSTATUS  :  TCommandEvent Read fONCommandSTATUS Write fONCommandSTATUS;
    Property OnCommandAPPEND : TCommandEvent Read fOnCommandAPPEND Write fOnCommandAPPEND;
    Property ONCommandCHECK  :  TCommandEvent Read fONCommandCHECK Write fONCommandCHECK;
    Property OnCommandCLOSE : TCommandEvent Read fOnCommandCLOSE Write fOnCommandCLOSE;
    Property ONCommandEXPUNGE  :  TCommandEvent Read fONCommandEXPUNGE Write fONCommandEXPUNGE;
    Property OnCommandSEARCH : TCommandEvent Read fOnCommandSEARCH Write fOnCommandSEARCH;
    Property ONCommandFETCH  :  TCommandEvent Read fONCommandFETCH Write fONCommandFETCH;
    Property OnCommandSTORE : TCommandEvent Read fOnCommandSTORE Write fOnCommandSTORE;
    Property OnCommandCOPY : TCommandEvent Read fOnCommandCOPY Write fOnCommandCOPY;
    Property ONCommandUID  :  TCommandEvent Read fONCommandUID Write fONCommandUID;
    Property OnCommandX : TCommandEvent Read fOnCommandX Write fOnCommandX;
    Property OnCommandError : TCommandEvent Read fOnCommandError Write fOnCommandError;
  End;


  TWinshoeIMAP4Server = Class(TWinshoeIMAP4Listener)
  Private
  Protected
    Procedure DoCommandCAPABILITY(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                Var Handled :Boolean); Override;
    Procedure DoCommandNOOP(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                Var Handled :Boolean); Override;
    Procedure DoCommandLOGOUT(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                Var Handled :Boolean); Override;
    Procedure DoCommandAUTHENTICATE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                Var Handled :Boolean); Override;
    Procedure DoCommandLOGIN(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                Var Handled :Boolean); Override;
    Procedure DoCommandSELECT(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                Var Handled :Boolean); Override;
    Procedure DoCommandEXAMINE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                Var Handled :Boolean); Override;
    Procedure DoCommandCREATE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandDELETE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandRENAME(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandSUBSCRIBE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandUNSUBSCRIBE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandLIST(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandLSUB(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandSTATUS(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandAPPEND(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandCHECK(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandCLOSE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandEXPUNGE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandSEARCH(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandFETCH(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandSTORE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandCOPY(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandUID(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandX(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
    Procedure DoCommandError(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                    Var Handled :Boolean); Override;
  Public

  Published

  End;


// Procs
  Procedure Register;

Implementation

Uses
  GlobalWinshoe,
  SysUtils,
  Winshoes;

Procedure Register;
Begin
  RegisterComponents('Winshoes Servers', [TWinshoeIMAP4Server]);
End;

//--------------------Start of  TWinshoeIMAP4Listener Code ---------------------
//                     Started August 26, 1999
//------------------------------------------------------------------------------
Const
   cCAPABILITY   =  1;
   cNOOP         =  2;
   cLOGOUT       =  3;
   cAUTHENTICATE =  4;
   cLOGIN        =  5;
   cSELECT       =  6;
   cEXAMINE      =  7;
   cCREATE       =  8;
   cDELETE       =  9;
   cRENAME       = 10;
   cSUBSCRIBE    = 11;
   cUNSUBSCRIBE  = 12;
   cLIST         = 13;
   cLSUB         = 14;
   cSTATUS       = 15;
   cAPPEND       = 16;
   cCHECK        = 17;
   cCLOSE        = 18;
   cEXPUNGE      = 19;
   cSEARCH       = 20;
   cFETCH        = 21;
   cSTORE        = 22;
   cCOPY         = 23;
   cUID          = 24;
   cXCmd         = 25;

  Constructor TWinshoeIMAP4Listener.Create(AOwner: TComponent);
  Begin
    Inherited Create(AOwner);
    Port := WSPORT_IMAP;
  End;

  Function TWinshoeIMAP4Listener.DoExecute(Thread: TWinshoeServerThread): Boolean;
  Var
    RcvdStr,
    ArgStr,
    sTag,
    sCmd: String;
    cmdNum : Integer;
    Handled : Boolean;

    Function GetFirstTokenDeleteFromArg(Var s1: String; Const sDelim: String): String;
    Var
      nPos: Integer;
    Begin                         { GetFirstTokenDeleteFromArg }
      nPos := Pos(sDelim, s1);
      If nPos = 0 Then nPos := Length(s1) + 1;
      Result := Copy(s1, 1, nPos - 1);
      Delete(s1, 1, nPos);
      S1 := Trim(S1);
    End;                          { GetFirstTokenDeleteFromArg }

  Begin
    Result := Inherited DoExecute(Thread);
    If Result Then exit;
    With Thread.Connection Do Begin
      While Connected Do Begin
        Handled := False;
        RcvdStr := ReadLn;
        ArgStr := RcvdStr;
        sTag := UpperCase(GetFirstTokenDeleteFromArg(ArgStr,CHAR32));
        sCmd := UpperCase(GetFirstTokenDeleteFromArg(ArgStr,CHAR32));
        CmdNum := Succ(PosInStrArray(Uppercase(sCmd),IMAPCommands));
        Case CmdNum Of
          cCAPABILITY   : DoCommandCAPABILITY(Thread,sTag,ArgStr,Handled);
          cNOOP         : DoCommandNOOP(Thread,sTag,ArgStr,Handled);
          cLOGOUT       : DoCommandLOGOUT(Thread,sTag,ArgStr,Handled);
          cAUTHENTICATE : DoCommandAUTHENTICATE(Thread,sTag,ArgStr,Handled);
          cLOGIN        : DoCommandLOGIN(Thread,sTag,ArgStr,Handled);
          cSELECT       : DoCommandSELECT(Thread,sTag,ArgStr,Handled);
          cEXAMINE      : DoCommandEXAMINE(Thread,sTag,ArgStr,Handled);
          cCREATE       : DoCommandCREATE(Thread,sTag,ArgStr,Handled);
          cDELETE       : DoCommandDELETE(Thread,sTag,ArgStr,Handled);
          cRENAME       : DoCommandRENAME(Thread,sTag,ArgStr,Handled);
          cSUBSCRIBE    : DoCommandSUBSCRIBE(Thread,sTag,ArgStr,Handled);
          cUNSUBSCRIBE  : DoCommandUNSUBSCRIBE(Thread,sTag,ArgStr,Handled);
          cLIST         : DoCommandLIST(Thread,sTag,ArgStr,Handled);
          cLSUB         : DoCommandLSUB(Thread,sTag,ArgStr,Handled);
          cSTATUS       : DoCommandSTATUS(Thread,sTag,ArgStr,Handled);
          cAPPEND       : DoCommandAPPEND(Thread,sTag,ArgStr,Handled);
          cCHECK        : DoCommandCHECK(Thread,sTag,ArgStr,Handled);
          cCLOSE        : DoCommandCLOSE(Thread,sTag,ArgStr,Handled);
          cEXPUNGE      : DoCommandEXPUNGE(Thread,sTag,ArgStr,Handled);
          cSEARCH       : DoCommandSEARCH(Thread,sTag,ArgStr,Handled);
          cFETCH        : DoCommandFETCH(Thread,sTag,ArgStr,Handled);
          cSTORE        : DoCommandSTORE(Thread,sTag,ArgStr,Handled);
          cCOPY         : DoCommandCOPY(Thread,sTag,ArgStr,Handled);
          cUID          : DoCommandUID(Thread,sTag,ArgStr,Handled);
          Else Begin
            If (Length(SCmd) > 0) And (UpCase(SCmd[1]) = 'X') Then
               DoCommandX(Thread,sTag,ArgStr,Handled)
            Else DoCommandError(Thread,sTag,ArgStr,Handled);
          End;
        End; {Case}
      End; {while}
    End; {with}
  End;                            { doExecute }
//------------------------------------------------------------------------------
//                  End of  TWinshoeIMAP4Listener Code
//                     Started August 26, 1999
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//                  Start of  TWinshoeIMAP4SERVER Code
//                     Started August 26, 1999
//------------------------------------------------------------------------------

  Procedure TWinshoeIMAP4Server.DoCommandCapability(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                               Var Handled :Boolean);
  Begin
   If Assigned(fOnCommandCAPABILITY) Then OnCommandCAPABILITY(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandNOOP(Thread: TWinshoeServerThread; Const Tag,CmdStr :String;
                              Var Handled :Boolean);
  Begin
    If Assigned(fONCommandNOOP) Then OnCommandNOOP(Thread,Tag, CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandLOGOUT(Thread: TWinshoeServerThread; Const Tag,CmdStr :String;
                              Var Handled :Boolean);
  Begin
    If Assigned(fONCommandLOGOUT) Then OnCommandLOGOUT(Thread,Tag, CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandAUTHENTICATE(Thread: TWinshoeServerThread; Const Tag,CmdStr :String;
                              Var Handled :Boolean);
  Begin
    If Assigned(fONCommandAUTHENTICATE) Then OnCommandAUTHENTICATE(Thread,Tag, CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandLOGIN(Thread: TWinshoeServerThread; Const Tag,CmdStr :String;
                              Var Handled :Boolean);
  Begin
    If Assigned(fONCommandLOGIN) Then OnCommandLOGIN(Thread,Tag, CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandSELECT(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                              Var Handled :Boolean);
  Begin
    If Assigned(fONCommandSELECT) Then OnCommandSELECT(Thread,Tag, CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandEXAMINE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                              Var Handled :Boolean);
  Begin
    If Assigned(fONCommandEXAMINE) Then OnCommandEXAMINE(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandCREATE(Thread: TWinshoeServerThread; Const Tag,CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandCREATE) Then OnCommandCREATE(Thread,Tag, CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandDELETE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandDELETE) Then OnCommandDELETE(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandRENAME(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandRENAME) Then OnCommandRENAME(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandSUBSCRIBE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandSUBSCRIBE) Then OnCommandSUBSCRIBE(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandUNSUBSCRIBE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandUNSUBSCRIBE) Then OnCommandUNSUBSCRIBE(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandLIST(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandLIST) Then OnCommandLIST(Thread,Tag, CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandLSUB(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandLSUB) Then OnCommandLSUB(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandSTATUS(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandSTATUS) Then OnCommandSTATUS(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandAPPEND(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandAPPEND) Then OnCommandAPPEND(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandCHECK(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandCHECK) Then OnCommandCHECK(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandCLOSE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandCLOSE) Then OnCommandCLOSE(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandEXPUNGE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandEXPUNGE) Then OnCommandEXPUNGE(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandSEARCH(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandSEARCH) Then OnCommandSEARCH(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandFETCH(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandFETCH) Then OnCommandFETCH(Thread,Tag,CmdStr,Handled);
  End;


  Procedure TWinshoeIMAP4Server.DoCommandSTORE(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandSTORE) Then OnCommandSTORE(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandCOPY(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandCOPY) Then OnCommandCOPY(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandUID(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandUID) Then OnCommandUID(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandX(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandX) Then OnCommandX(Thread,Tag,CmdStr,Handled);
  End;

  Procedure TWinshoeIMAP4Server.DoCommandError(Thread: TWinshoeServerThread; Const Tag, CmdStr :String;
                                  Var Handled :Boolean);
  Begin
    If Assigned(fONCommandError) Then OnCommandError(Thread,Tag,CmdStr,Handled);
  End;
//------------------------------------------------------------------------------
//                  End of  TWinshoeIMAP4SERVER Code
//                     Started August 26, 1999
//------------------------------------------------------------------------------

End.
