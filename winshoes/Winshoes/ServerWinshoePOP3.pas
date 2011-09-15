Unit ServerWinshoePOP3;

//-----------------------------------------------------------------------------
// WinshoePOP3Server is the Winshoe implementation of a POP3 Server
// It is designed to run as an NT service in conjuction with The Winshoe SMTP
// Server. It will also run on windows 9x / 2000 / NT 4.x machines as will
// The WinshoeSMTP Server
//
//
// See the Demo Progarm POP3NtSrvc.dpr for an NT service wrapper
// POP3Server demo for a Win 32 application demo.
// See the Demo Program EMailServer for a win 9x NT email server for both
// SMTP and POP3 service
// See the demo program NTEMail for an NT service Email server for both
// SMTP and POP3 Service
//
// ServerWinshoePOP3 server is implemeted  as described in
// STD 53 - POP3 Client/Server Standard
//
// The TWinshoePOP3Listenter is an abstract class that implements the command
// parsing. The actual code for the POP3 server is in TWinshoePOP3Server.
//
// The Following POP3 Client Commands are supported
//    USER
//    PASS
//    LIST
//    RETR
//    DELE
//    QUIT
//    NoOP
//    STAT
//    RSET
//    TOP
//    UIDL
//
// NOT Implemented
//  APOP
//  The APOP command is not supported. It returns a not supported error
//  APOP however the OnAPOPCommand event passes the received command string
//  and the user can implement his ownd APOP command;
//
//  BETA Version 1.0
//
//
//  User directories are placed under the Default C:\INetPub\MailRoot\
//
//  There are two options for user mailboxes.
//
//  If the Registry setting Pop3UseDomainDirs is false then
//  a user name of raym would find his mail in C:\INetPub\MailRoot\MailBoxes\raym
//  The user/name and password verification defaults values as set with the
//  POP3SvrSetup demo.
//  The Setup demo will create a sub dir for each user and a
//  password for default verification .
//
//  If the Registry setting of POP3UseDomainDirs is true then a user name of
//  ray.mbssoftware would find his mail in
//  C:\InetPub\MailRoot\Mailboxes\mbssoftware\ray
//  This allows each domain on a server to have  duplicate email names.
//  Thus a ray@domain1.com and ray@domain2.com can be different people with
//  separate mail boxes.
//  The UserId for UseDomianDirs would be UserId.Domain  Dommain is only the
//  identifier. That is ray.mbssoftware is the userid for ray@mbssofware.com
//
//  The OnCommandUSER and OnCommandPASS events can be assigned to override this
//  behavior so users can impliment their own user verification; If the user name
//  or password check succeeds set PopState to etPopStateTransaction...
//  on failure leave it set to etPOP3StateName
//
//  There is an onCommandxxxx event for each of the Std 53 POP3 Commands. They
//  will overide the currently implemented code to handle the command.
//  If the Arg Handled is false the default behavior will run also.
//
//
//  ServerWinshoePOP3 was Started on June 23, 1999
//  The first Beta version was completed August 8, 1999
//
//------------------------------------------------------------------------------
//
// To do list
// APOP command is not implemented;
//------------------------------------------------------------------------------
// Revision History
// 11/09/99
// Revision Num {0.01}D
// DoCommandTop  returned error for command of TOP 1 0 (zero) lines
//   It should return just the header. Per David Hildingsson suggestion changed
//   If Numlines <= 0 to  If Numlines < 0
//
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Clients)
//
//------------------------------------------------------------------------------

Interface

Uses
  Classes,
  Windows,
  Dialogs,
  SysUtils,
  Winshoes,
  ServerWinshoe;

Type
  EWinshoeEmailListError = Class(EWinshoeException);

Type
  pEmailRec = ^tEmailRec;
  tEmailRec = Record
    FileName : String;
    FileNum : Integer;
    FileSize : Integer;
    DeleteFile : Boolean;
  End;

Type
  TEMailList = Class(TComponent)
  Private
    { Private declarations }
    fList : TList;
    fCount : Integer;
  Protected
    { Protected declarations }
   Function  IsValidIndex(Idx :Integer):Boolean;
  Public
    { Public declarations }
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy;  Override;
  Published
    { Published declarations }
    Property Count : Integer Read fCount Write fCount;
    Procedure Add(EmailItem : tEmailRec);
    Procedure Delete(Idx : Integer);
    Procedure Clear;
    Function GetEmailRec(Idx: Integer):tEmailRec;
    Function GetFileName(Idx : Integer) : String;
    Procedure SetFileName(Idx : Integer;  FiName : String);
    Function GetFileNum(Idx : Integer) : Integer;
    Procedure SetFileNUM(Idx : Integer; Num : Integer);
    Function GetFileSize(Idx : Integer) : Integer;
    Procedure SetFileSize(Idx : Integer; Size : Integer);
    Function GetFileDeleted(Idx : Integer) : Boolean;
    Procedure SetFileDeleted(Idx : Integer; Del : Boolean);
  End;

Const
  csClientRequests : Array [1..12] Of String =
   ('USER',  {From Std 53}
   'PASS',
   'LIST',
   'RETR',
   'DELE',
   'QUIT',
   'APOP',
   'STAT',
   'NOOP',
   'RSET',
   'TOP',
   'UIDL');
  ciError = -1;
  ciUSER = 1;
  ciPASS = 2;
  ciLIST = 3;
  ciRETR = 4;
  ciDELE = 5;
  ciQUIT = 6;
  ciAPOP = 7;
  ciSTAT = 8;
  ciNOOP = 9;
  ciRSET = 10;
  ciTOP  = 11;
  ciUIDL = 12;

Type
  etClientRequests = (eCrNONE,eCrUSER,eCrPASS,eCRLIST,eCrRETR,eCrDELE,eCrQUIT,eCrAPOP,
                      eCrSTAT,eCrNOOP,eCrRSET,eCrTOP,eCrUIDL);

Type
  etPop3SvrState = (ePopStateName, ePopStateTransaction, ePopStateUpDate);
//------------------------------------------------------------------------------
// TWinshoePOP3Listener is a Class that parses Users commmands and calls events
// to handle them. This is an abstract class the actual server replies and
// down loads are handled by the TWinshoePOP3Server defined below
//------------------------------------------------------------------------------
Type
  TUserIdEvent = Procedure(Thread: TWinshoeServerThread; RcvdStr : String;
                            Var UserId : String;  Var POPState: etPop3SvrState;
                            Var Handled : Boolean) Of Object;
  TPasswordEvent = Procedure (Thread: TWinshoeServerThread; RcvdStr : String;
                               Var UserId, PassWord : String; EmailList: TEMailList;
                               Var POPState: etPop3SvrState;
                               Var Handled : Boolean) Of Object;
  TGetEmailEvent = Procedure(Const UserId : String; Var PathStr : String;
                             EmailList :TEmailList;Var Handled : Boolean) Of Object;
  TCommandEvent = Procedure(Thread: TWinshoeServerThread; Const Arg : String;
                            EmailList :TEmailList; Var State: etPop3SvrState;
                            Var Handled : Boolean) Of Object;
  TCommandErrorEvent = Procedure(Thread: TWinshoeServerThread; Const Arg : String;
                                  Var State: etPop3SvrState) Of Object;

  TWinshoePOP3Listener =  Class(TWinshoeListener)
  Private
    fOnCommandUSER : TUserIdEvent;
    fOnCommandPASS : TPasswordEvent;
    fOnCommandLIST,
    fOnCommandRETR,
    fOnCommandDELE,
    fOnCommandQUIT,
    fOnCommandAPOP,
    fOnCommandSTAT,
    fOnCommandNOOP,
    fOnCommandRSET,
    fOnCommandTOP,
    fOnCommandUIDL : TCommandEvent;
    fOnGetEmail : TGetEmailEvent;
    fOnCommandError : TCommandErrorEvent;
  Protected
    Procedure DoCommandUSER(Thread: TWinshoeServerThread; RcvdStr : String;
                             Var UserId : String;  Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandPASS(Thread: TWinshoeServerThread; RcvdStr : String;
                             Var UserId, Password : String;EmailList: TEMailList;
                             Var POPState: etPop3SvrState;Var Handled : Boolean);
                             Virtual;Abstract;
    Procedure DoCommandLIST(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandRETR(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandDELE(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandQUIT(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandAPOP(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandSTAT(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandNOOP(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandRSET(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandTOP(Thread: TWinshoeServerThread; RcvdStr : String;
                            EmailList :TEmailList; Var POPState: etPop3SvrState;
                            Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandUIDL(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList;  Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Virtual; Abstract;
    Procedure DoCommandError(Thread: TWinshoeServerThread; RcvdStr : String;
                              Var POPState: etPop3SvrState); Virtual; Abstract;
    procedure DoGetEmailList(Const UserId : String; EmailList: TEMailList);
                              virtual; Abstract;
    Function DoExecute(Thread: TWinshoeServerThread): Boolean; Override;
  Public
    Constructor Create(AOwner: TComponent); Override;
  Published
    Property OnCommandUSER : TUserIdEvent Read fOnCommandUSER Write fOnCommandUSER;
    Property OnCommandPASS : TPassWordEvent Read fOnCommandPASS Write fOnCommandPASS;
    Property OnGetEmail : TGetEmailEvent Read fOnGetEmail Write fOnGetEmail;
    Property OnCommandLIST : TCommandEvent Read fOnCommandLIST Write fOnCommandLIST;
    Property OnCommandRETR : TCommandEvent Read fOnCommandRETR Write fOnCommandRETR;
    Property OnCommandDELE : TCommandEvent Read fOnCommandDELE Write fOnCommandDELE;
    Property OnCommandQUIT : TCommandEvent Read fOnCommandQUIT Write fOnCommandQUIT;
    Property OnCommandAPOP : TCommandEvent Read fOnCommandAPOP Write fOnCommandAPOP;
    Property OnCommandSTAT : TCommandEvent Read fOnCommandSTAT Write fOnCommandSTAT;
    Property OnCommandNOOP : TCommandEvent Read fOnCommandNOOP Write fOnCommandNOOP;
    Property OnCommandRSET : TCommandEvent Read fOnCommandRSET Write fOnCommandRSET;
    Property OnCommandTOP  : TCommandEvent Read fOnCommandTOP  Write fOnCommandTOP;
    Property OnCommandUIDL : TCommandEvent Read fOnCommandUIDL Write fOnCommandUIDL;
    Property OnCommandError:TCommandErrorEvent Read fonCommandError Write fOnCommandError;
  End;

	TGetPasswordEvent = procedure(Sender: TComponent; const asUserID: string; var vsPassword: string)
   of object;

  TWinshoePOP3Server = Class(TWinshoePOP3Listener)
  Protected
    fbUseDomainDirs, fbLogDebug: Boolean;
    fsMailRootDir: String;
    fxOnGetPassword: TGetPasswordEvent;
    //
    Procedure DoConnect(Thread: TWinshoeServerThread); Override;
    Procedure DoCommandUSER(Thread: TWinshoeServerThread; RcvdStr : String;
                             Var UserId : String;  Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Override;
    Procedure DoCommandPASS(Thread: TWinshoeServerThread; RcvdStr : String;
                             Var UserId, Password : String;EmailList:TEmailList;
                             Var POPState: etPop3SvrState;Var Handled : Boolean);
                             Override;
    Procedure DoCommandLIST(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Override;
    Procedure DoCommandRETR(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Override;
    Procedure DoCommandDELE(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Override;
    Procedure DoCommandQUIT(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Override;
    Procedure DoCommandAPOP(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Override;
    Procedure DoCommandSTAT(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Override;
    Procedure DoCommandNOOP(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Override;
    Procedure DoCommandRSET(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Override;
    Procedure DoCommandTOP(Thread: TWinshoeServerThread;  RcvdStr : String;
                            EmailList :TEmailList; Var POPState: etPop3SvrState;
                            Var Handled : Boolean); Override;
    Procedure DoCommandUIDL(Thread: TWinshoeServerThread; RcvdStr : String;
                             EmailList :TEmailList; Var POPState: etPop3SvrState;
                             Var Handled : Boolean); Override;
    Procedure DoCommandError(Thread: TWinshoeServerThread; RcvdStr : String;
                              Var POPState: etPop3SvrState); Override;
    procedure DoGetEmailList(Const UserId : String; EmailList: TEMailList); Override;
    procedure DoGetPassword(const asUserID: string; var vsPassword: string);
    Procedure WriteDebugMsg(Const aStr :String);
    Function GetFirstTokenDeleteFromArg(Var s1: String; Const sDelim: String): String;
    Function GetTotalFileSize(EmailList: TEmailList): Integer;
    Function GetNumMsgsOnFile(EmailList: TEmaillist): Integer;
  Public
    Constructor Create(AOwner: TComponent); Override;
  Published
    Property LogDebug: Boolean Read fbLogDebug  Write fbLogDebug;
    Property MailRootDir: String Read fsMailRootDir Write fsmailRootDir;
    property OnGetPassword: TGetPasswordEvent read fxOnGetPassword write fxOnGetPassword;
    Property UseDomainDirs: Boolean Read fbUseDomainDirs Write fbUseDomainDirs;
  End;

// Procs
	Procedure Register;

//------------------------------------------------------------------------------
// Start Of IMPLEMENTATION CODE
//------------------------------------------------------------------------------
Implementation

Uses
  FileCtrl,
  Registry,
  GlobalWinshoe;

Const
  Char32 = Char(32);
  cPeriod = '.';

Procedure Register;
Begin
  RegisterComponents('Winshoes Servers', [TWinshoePop3Listener, TWinshoePop3Server]);
End;

//------------------------------------------------------------------------------
// Local Utilily Function code Begins
//------------------------------------------------------------------------------
  Function FileInUse(Const FileName : String) : Boolean;
  Var
    FileHandle : Integer;
  Begin
    Result := False;
    If FileExists(FileName) Then Begin
      FileHandle := FileOpen(FileName, fmOpenRead Or fmShareExclusive	);
      Result :=  FileHandle = -1;
      If FileHandle > 0 Then
        Fileclose(FileHandle);
    End;
  End;

  Function FixDirBackSlash(Const aDir : String): String;
  Begin
    If AnsiLastChar(aDir)^ <> '\' Then
      Result := aDir + '\'
    Else Result := aDir;
  End;

  Function FixUserId(Const UserId : String ): String;
  var
    aPos,
    pPos : Integer;
  Begin
    Result := UserId;
    aPos := Pos('@',UserId);
    pPos := Pos('.',UserId);
    IF (aPos = 0) and (pPos <> 0) then
      Result[pPos] := '@';
  End;

//------------------------------------------------------------------------------
// Local Utilily Function code Ends
//------------------------------------------------------------------------------
  Constructor TEMailList.Create(AOwner : TComponent);
  Begin
    Inherited Create(AOwner);
    fList := TList.Create;
    fList.Clear;
    fCount := 0;
  End;

  Destructor TEMailList.Destroy;
  Var
    Idx : Integer;
    aPtr : pEmailRec;
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

  Function  tEmailList.IsValidIndex(Idx :Integer):Boolean;
  Begin
    Result := (Idx >= 0) And (Idx < FList.Count);
    If Not Result Then
      Raise EWinshoeEmailListError.Create('Email List invalid Index Error');
  End;

  Procedure TEmailList.Clear;
  Var
    aPtr : pEmailRec;
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

  Procedure TEmailList.Add(EmailItem : tEmailRec);
  Var
    pEMailItem : PEmailRec;
  Begin
    New(pEMailItem);
    pEMailItem^.FileName := EmailItem.FileName;
    pEMailItem^.FileNum := EmailItem.FileNum;
    pEMailItem^.FileSize := EmailItem.FileSize;
    pEMailItem^.DeleteFile := EmailItem.DeleteFile;
    fList.Add(pEMailItem);
    fCount := fList.Count;
  End;

  Procedure TEMailList.Delete(Idx : Integer);
  Var
    pEMailItem : PEmailRec;
  Begin
    If IsValidIndex(Idx) Then Begin
      pEMailItem := fList.Items[Idx];
      Dispose(pEMailItem);
      fList.Delete(Idx);
      fCount := fList.Count;
    End;
  End;

  Function TEMailList.GetEmailRec(Idx: Integer):tEmailRec;
  Var
    EMailItem : TEmailRec;
  Begin
    FillChar(EMailItem,SizeOf(EMailItem),0);
    Result := EMailItem;
    If IsValidIndex(Idx)Then
      Result := tEMailRec(fList.Items[Idx]^);
  End;

  Function TEMailList.GetFileName(Idx :Integer):String;
  Begin
    Result := '';
    If IsValidIndex(Idx) Then
      Result := tEMailRec(fList.Items[Idx]^).FileName;
  End;

  Procedure TEMailList.SetFileName(Idx : Integer; FiName : String);
  Begin
    If IsValidIndex(Idx) Then
      tEMailRec(fList.Items[Idx]^).FileName := FiName;
  End;

  Function TEMailList.GetFileNum(Idx : Integer) : Integer;
  Begin
    Result := -1;
    If IsValidIndex(Idx) Then
      Result := tEMailRec(fList.Items[Idx]^).FileSize;
  End;


  Procedure TEMailList.SetFileNum(Idx : Integer; Num : Integer);
  Begin
    If IsValidIndex(Idx) Then
      tEMailRec(fList.Items[Idx]^).FileNum := Num;
  End;

  Function TEMailList.GetFileSize(Idx : Integer) : Integer;
  Begin
    Result := 0;
    If IsValidIndex(Idx) Then
      Result := tEMailRec(fList.Items[Idx]^).FileSize;
  End;

  Procedure TEMailList.SetFileSize(Idx : Integer; Size : Integer);
  Begin
    If IsValidIndex(Idx) Then
      tEMailRec(fList.Items[Idx]^).FileSize := Size;
  End;

  Function TEMailList.GetFileDeleted(Idx : Integer) : Boolean;
  Begin
    Result := False;
    If IsValidIndex(Idx) Then
      Result := tEMailRec(fList.Items[Idx]^).DeleteFile;
  End;

  Procedure TEMailList.SetFileDeleted(Idx : Integer; Del : Boolean);
  Begin
    If IsValidIndex(Idx)  Then
      tEMailRec(fList.Items[Idx]^).DeleteFile := Del;
  End;

//------------------------------------------------------------------------------
//Start of POP3Listener code
//------------------------------------------------------------------------------
  Constructor TWinshoePOP3Listener.Create(AOwner: TComponent);
  Begin
    Inherited Create(AOwner);
    Port := WSPORT_POP3;
  End;

  Function  TWinshoePOP3Listener.DoExecute(Thread: TWinshoeServerThread): Boolean;
  Const
    cSpace = Char(32);
  Var
    RcvdStr,
    TotalStr, sCmd,
    UserId, Password : String;
    CmdNum : Integer;
    Handled : Boolean;
    POPState : etPop3SvrState;
    EmailList : TEMailList;

    Function GetFirstTokenDeleteFromArg(Var s1: String; Const sDelim: String): String;
    Var
      nPos: Integer;
    Begin                         { GetFirstTokenDeleteFromArg }
      nPos := Pos(sDelim, s1);
      If nPos = 0 Then
        nPos := Length(s1) + 1;
      Result := Copy(s1, 1, nPos - 1);
      Delete(s1, 1, nPos);
      S1 := Trim(S1);
    End;                          { GetFirstTokenDeleteFromArg }

  Begin                           { DoExecute }
    Result := Inherited DoExecute(Thread);
    If Result Then exit;
    PopState := ePopStateName;
    EmailList := TEMailList.Create(Self); Try
      With Thread.Connection Do Begin
        While Connected Do Begin
          TotalStr := ReadLn;
          RcvdStr := TotalStr;
          sCmd := UpperCase(GetFirstTokenDeleteFromArg(RcvdStr,cSpace));
          CmdNum := Succ(PosInStrArray(sCmd,csClientRequests));
          Handled := False;
          Case CmdNum Of
            ciUSER : DoCommandUSER(Thread, RcvdStr, UserId, PopState, Handled);
            ciPASS : DoCommandPass(Thread, RcvdStr, UserId, Password, EmailList,PopState, Handled);
            ciLIST : DoCommandLIST(Thread, RcvdStr, EmailList, PopState, Handled);
            ciRETR : DoCommandRETR(Thread, RcvdStr, EmailList, PopState, Handled);
            ciDELE : DoCommandDELE(Thread, RcvdStr, EmailList, PopState, Handled);
            ciQUIT : DoCommandQUIT(Thread, RcvdStr, EmailList, PopState, Handled);
            ciAPOP : DoCommandAPOP(Thread, RcvdStr, EmailList, PopState, Handled);
            ciSTAT : DoCommandSTAT(Thread, RcvdStr, EmailList, PopState, Handled);
            ciNOOP : DoCommandNOOP(Thread, RcvdStr, EmailList, PopState, Handled);
            ciRSET : DoCommandRSET(Thread, RcvdStr, EmailList, PopState, Handled);
            ciTOP  : DoCommandTOP(Thread, RcvdStr,  EmailList, PopState, Handled);
            ciUIDL : DoCommandUIDL(Thread, RcvdStr, EmailList,  PopState, Handled);
            Else DoCommandError(Thread, TotalStr,PopState);
          End; {end case}
        End; {while}
      End; {with}
    Finally EmailList.Free; End;
  End;                            { DoExecute }
//-------------------- End TWinshoePOP3Listener Code ---------------------------

//-----------------------------------------------------------------------------
//                     Startof WinshoePOP3Server code
//-----------------------------------------------------------------------------

  Constructor TWinshoePOP3Server.Create(AOwner: TComponent);
  Begin                           { Create }
    Inherited Create(AOwner);
    SessionTimeOut := 20000;
  End;                            { Create }

  Procedure TWinshoePOP3Server.WriteDebugMsg(Const aStr :String);
  Var
    aFile :Text;
  Begin                           { WriteDebugMsg }
    If LogDebug then begin
      {$I-}
      If Boolean(IoResult) Then;
      AssignFile(aFile,FixDirBackSlash(fsMailRootDir)+'Pop3.log');
      Append(aFile);
      If IoResult <> 0 Then ReWrite(Afile);
      WriteLn(Afile,DateTimeToStr(Now)+' '+Astr);
      Close(Afile);
      {$I+}
    end;
  End;                           { WriteDebugMsg }

  Function TWinShoePOP3Server.GetFirstTokenDeleteFromArg(Var s1: String; Const sDelim: String): String;
  Var
    nPos: Integer;
  Begin                           { GetFirstTokenDeleteFromArg }
    nPos := Pos(sDelim, s1);
    If nPos = 0 Then
      nPos := Length(s1) + 1;
    Result := Copy(s1, 1, nPos - 1);
    Delete(s1, 1, nPos);
    S1 := Trim(S1);
  End;                            { GetFirstTokenDeleteFromArg }

  Procedure TWinShoePop3Server.DoGetEmailList(Const UserId : String; EmailList : TEMailList);
  Var
    PathStr : String;
    Res : Integer;
    EmailItem : tEmailRec;
    Sr : TSearchRec;
    FileNameMask : STring;
    NumFiles : Integer;
    Handled : Boolean;

    function SetUserPath : string;
    var
      userSubDir : string;
      aPos : Integer;
    begin
      Apos := Pos('@',UserId);
      If UseDomainDirs then Begin
        IF APos > 0 then
          UserSubDir := copy(UserId,Succ(Apos),255)+'\'+Copy(UserId,1,Pred(aPos))
        Else
          UserSubDir := Userid;
      End
      Else UserSubDir := UserId;
      Result := FixDirBackSlash(FixDirBackSlash(MailRootDir)+'MailBoxes\'+ UserSubDir);
    End;

  Begin                           { LoadEmailList }
    Handled := False;
    FileNameMask := '';
    PathStr := '';
    If Assigned(fonGetEmail) then FOnGetEmail(UserId, PathStr, EmailList, Handled);
    if Handled then Exit;
    If PathStr = '' Then Pathstr := SetUserPath
    Else PathStr :=  FixDirBackSlash(PathStr);
    FileNameMask := PathStr + '*.eml';
    Try
      Res := FindFirst(FileNameMask,faArchive,Sr);
      If Res <> 0 Then Begin
        WriteDebugMsg('PASS says +OK LoadEmailList FindFirst found No Email Files in Drop Dir');
      End
      Else WriteDebugMsg('PASS says +OK LoadEmailList FindFirst found Email File(s) in Drop Dir');
      NumFiles := 0;
      While Res = 0 Do Begin
        Inc(NumFiles);
        If LogDebug Then WriteDebugMsg('PASS says +OK LoadEmail has file number '+IntToSTr(NumFiles)
                                           +'''s File Name is '+Sr.Name);
        EmailItem.FileSize := Sr.Size;
        EmailItem.FileName := PathStr + Sr.Name;
        EmailItem.FileNum := NumFiles;
        EmailItem.DeleteFile := False;
        EmailList.Add(EmailItem);
        Res := FindNext(Sr);
      End;
    Finally
      FindClose(Sr);
    End;
  End;                            { LoadEmailList }

  Function TWinShoePOP3Server.GetTotalFileSize(EmailList: TEmailList): Integer;
  Var
    Idx : Integer;
  Begin                           { GetTotalFileSize }
    Result := 0;
    If EmailList.Count > 0 Then Begin
      For Idx := 0 To EmailList.Count -1 Do Begin
        If Not EmailList.GetFileDeleted(Idx) Then Begin
          Result := Result +EmailList.GetFileSize(Idx);
        End;
      End;
    End;
  End;                            { GetTotalFileSize }

  Function TWinshoePOP3Server.GetNumMsgsOnFile(EmailList: TEmaillist): Integer;
  Var
    Idx : Integer;
  Begin                           { GetNumMsgsOnFile }
    Result := 0;
    If EmailList.Count > 0 Then Begin
      For Idx := 0 To EmailList.Count -1 Do Begin
        If Not EmailList.GetFileDeleted(Idx) Then
          Inc(Result);
      End;
    End;
  End;                            { GetNumMsgsOnFile }

  Procedure TWinshoePOP3Server.DoConnect(Thread: TWinshoeServerThread);
  Begin                           { DoConnect }
    If Assigned(OnConnect) Then
      OnConnect(Thread)
    Else Begin
      Thread.Connection.WriteLn('+OK WinShoe POP3 Server is Ready');
      If LogDebug Then Begin
        WriteDebugMsg('');
        WriteDebugMsg('');
        WriteDebugMsg('Connect says +OK WinShoe POP3 Server is Ready');
      End;
    End;
  End;                            { DoConnect }

  Procedure TWinshoePOP3Server.DoCommandUSER(Thread: TWinshoeServerThread; RcvdStr : String;
                                              Var UserId : String; Var POPState: etPop3SvrState;
                                              Var Handled : Boolean);
  Begin                           { DoCommandUSER }
    UserId := GetFirstTokenDeleteFromArg(RcvdStr,Char32);
    If Assigned(OnCommandUSER) Then
      OnCommandUSER(Thread, RcvdStr,UserId,PopState,Handled);
    If Handled Then Exit;
    If LogDebug Then
      WriteDebugMsg('USER says +OK Called');
    If PopState <>  ePopstateName Then Begin
      Thread.Connection.WriteLn('-ERR Invalid State for USER Command Error');
      If LogDebug Then
        WriteDebugMsg('USER says -ERR Ivalid State');
    End
    Else If Length(UserId) = 0 Then Begin
      Thread.Connection.WriteLn('-ERR Missing User ID');
      If LogDebug Then
        WriteDebugMsg('USER says -ERR Missing User Id');
    End
    Else Begin
      Thread.Connection.WriteLn('+OK USER Verified');
      If LogDebug Then
        WriteDebugMsg('USER says +OK User Verified');
      POPState := ePopStateName;
    End;
  End;                            { DoCommandUSER }

Procedure TWinshoePOP3Server.DoCommandPASS(Thread: TWinshoeServerThread; RcvdStr : String;
 Var UserID, Password: String; EmailList:TEMailList; Var POPState: etPop3SvrState;
 Var Handled : Boolean);
Var
  PassOnfile :String;
  aPos : Integer;
  UserSubDir : String;

  Procedure DoInValidPassWord;
  Begin                         { DoINvalidPassword }
    Thread.Connection.WriteLn('-ERR Invalid Password  Error');
    If LogDebug Then
      WriteDebugMsg('PASS says -ERR Invalid Password Error');
  End;                          { DoINvalidPassword }

Begin                           { DoCommandPASS }
  Password := GetFirstTokenDeleteFromArg(RcvdStr,Char32);
  If Assigned(OnCommandPASS) Then Begin
    OnCommandPASS(Thread, RcvdStr,UserId,Password,EmailList, PopState, Handled);
    If (PopState = ePopStateTransaction) And Handled Then
      DoGetEmailList(UserId,EmailList);
  End;
  If  Handled Then Exit;
  If PopState <>  ePOPStateName Then Begin
    Thread.Connection.WriteLn('-ERR Invalid State for PASS Command Error');
    If LogDebug Then
      WriteDebugMsg('PASS says -ERR Invalid State');
    Exit;
  End;
  If LogDebug Then
    WriteDebugMsg('PASS says +OK UserId is '+UserId + '  Password is '+Password);
  If Password = '' Then Begin
    DoInValidPassWord;
    Exit;
  End;
  If Length(UserId) = 0 Then Begin
    DoInValidPassWord;
    Exit;
  End;
  UserID := FixUserId(UserId);
  UserSubDir := UserId;
  If UseDomainDirs Then Begin
    If LogDebug Then
      WriteDebugMsg('UseDomainDirs is true');
    APos := Pos('#', UserSubDir);
    If Apos <> 0 Then Begin
      UserSubDir := Copy(UserSubDir,Succ(Apos),255) + '\'+Copy(UserSubDir,1,Pred(Apos));
      UserSubDir := Trim(UserSubDir);
    End;
  End Else If LogDebug Then begin
    WriteDebugMsg('Use DomainDirs is False');
  end;
  If Not DirectoryExists(FixDirBackSlash(MailRootDir)+'MailBoxes\'+UserSubDir) Then Begin
    If LogDebug Then begin
      WriteDebugMsg('PASS says -err UserId after parse is '+UserId + '  Password is '+Password);
    end;
    DoInvalidPassword;
    Exit;
  End;
  DoGetPassword(UserId, PassOnFile);
  If LogDebug Then begin
    WriteDebugMsg('PASS says Sent Password is ***' + Password +'***  PASS On File is  ***'
     + PassOnFile + '***');
  end;
  If CompareText(PassOnFile,Password) <> 0 Then Begin
    DoInvalidPassword;
    Exit;
  End;
  PopState := ePOPStateTransaction;
  Thread.Connection.WriteLn('+OK POP3 Server Password Accepted');
  If LogDebug Then begin
    WriteDebugMsg('PASS says +OK POP3 Server Password Accepted');
  end;
  DoGetEmailList(UserId,EmailList);
End;                            { DoCommandPASS }

  Procedure TWinshoePOP3Server.DoCommandLIST(Thread: TWinshoeServerThread; RcvdStr: String;
                                              EmailList: TEMailList; Var POPState: etPop3SvrState;
                                              Var Handled : Boolean);
  Var
    MsgNum,
    NumMsgs,
    TotalSize : Integer;
    Idx : Integer;
    Err : Integer;
    MsgStr : String;
  Begin                           { DoCommandLIST }
    If Assigned(OnCommandLIST) Then
      OnCommandLIST(Thread, RcvdStr,EmailList,PopState,Handled);
    If Handled Then Exit;
    If PopState <>  ePOPStateTRansaction Then Begin
      Thread.Connection.WriteLn('-ERR Invalid Tranaction State Error');
      If LogDebug Then
        WriteDebugMsg('LIST says -ERR Invalid State');
      Exit;
    End;
    MsgNum := 0;
    Err := 0;
    MsgStr := GetFirstTokenDeleteFromArg(RcvdStr,Char32);
    If Length(MsgStr) > 0 Then Begin
      Val(MsgStr , MsgNum, Err);
    End;
    NumMsgs := EmailList.Count;
    If Err <> 0 Then
      MsgNum := 0;
    If LogDebug Then
      WriteDebugMsg('List says +OK MgsNum is '+IntToStr(MsgNum));
    If MsgNum = 0 Then Begin
      {MsgNum = 0 or No Msg Num means list all messages on file}
      If  EmailList.Count = 0 Then Begin
        {NO Messages on file. Return +OK 0}
        If LogDebug Then
          WriteDebugMsg('LIST says +OK 0 Email on file');
        Thread.Connection.WriteLn('+OK 0 Email on file');
        Thread.Connection.WriteLn(cPeriod);
        Exit;
      End;
      {More than one message has been received }
      TotalSize := GetTotalFileSize(EmailList);
      Thread.Connection.WriteLn('+OK '+IntToStr(NumMsgs)
                                +' Messages ('+IntToStr(TotalSize)+' octets)');
      If LogDebug Then
        WriteDebugMsg('List says +OK '+IntToStr(NumMsgs)
                      +' Messages ('+IntToStr(TotalSize)+' octets)' );
      For Idx := 0 To NumMsgs -1 Do Begin
        Thread.Connection.WriteLn(IntToStr(Succ(Idx))+' '
                                  + IntToStr(EmailList.GetFileSize(Idx)));
        If LogDebug Then
          WriteDebugMsg(IntToStr(Succ(Idx))+' '+IntToStr(EmailList.GetFileSize(Idx)));
      End;
      Thread.Connection.WriteLn(cPeriod);
      If LogDebug Then
        WriteDebugMsg(cPeriod);
      Exit;
    End;
    { Cammand has a Msg Mum argument }
    If Not ((MsgNum > 0 ) And (MsgNum <= NumMsgs)) Then Begin
      { MsgNum Arg is not valid }
      Thread.Connection.WriteLn('-ERR No Such Message');
      If LogDebug Then
        WriteDebugMsg('List says -ERR Invalid Msg Num');
      Exit;
    End;
    { Valid Msg Num arg }
    Thread.Connection.WriteLn('+OK '+IntToStr(MsgNum)+' '
                              +IntToStr(EmailList.GetFileSize(MsgNum-1)));
    If LogDebug Then
      WriteDebugMsg('List says +OK '+IntToStr(MsgNum)+' '
                    +IntToStr(EmailList.GetFileSize(MsgNum-1)));
  End;                            { DoCommandLIST }

  Procedure TWinshoePOP3Server.DoCommandRETR(Thread: TWinshoeServerThread; RcvdStr : String;
                                             EmailList: TEMailList;  Var POPState: etPop3SvrState;
                                             Var Handled : Boolean);
  Var
    F : Text;
    FileStr : String;
    MsgNum,
    NumMsgs,
    FiSize,
    Err : Integer;
    MsgNumStr,
    ReturnFileStr : String;

    Procedure DoInValidMsgNum;
    Begin                         { DoInValidMsgNum }
      Thread.Connection.WriteLn('-ERR Return Command Has Invalid Msg Num');
      If LogDebug Then
        WriteDebugMsg('RETR says -ERR Invalid Msg Num');
    End;                          { DoInValidMsgNum }

  Begin                           { DoCommandRETR }
    If Assigned(OnCommandRETR) Then
      OnCommandRETR(Thread, RcvdStr,EmailList,PopState,Handled);
    If Handled Then
      Exit;
    If LogDebug Then
      WriteDebugMsg('RETR says Called');
    If PopState <>  ePopStateTransaction Then Begin
      Thread.Connection.WriteLn('-ERR Invalid State User not Logged on');
      If LogDebug Then
        WriteDebugMsg('RETR says -ERR Invalid State');
      Exit;
    End;
    MsgNumStr := GetFirstTokenDeleteFromArg(RcvdStr,Char32);
    If Length(MsgNumStr) = 0 Then Begin
      DoInValidMsgNum;
      Exit;
    End;
    Val(MsgNumStr, MsgNum, Err);
    If Err <> 0 Then Begin
       DoInValidMsgNum;
      Exit;
    End;
    NumMsgs := EMailList.Count;
    If Not ((MsgNum > 0) And (MsgNum <= NumMsgs)) Then Begin
      DoInValidMsgNum;
      Exit;
    End;
    If EmailList.GetFileDeleted(MsgNum -1) Then Begin
      Thread.Connection.WriteLn('-ERR File has been deleted. Use RSET to recover.');
      If LogDebug Then
        WriteDebugMsg('RETR says Message '+IntToStr(MsgNum) +' has been deleted');
      Exit;
    End;
    ReturnFileStr := EmailList.GetfileName(MsgNum-1);
    If LogDebug Then
      WriteDebugMsg('RETR says FileName  is ' +ReturnFileStr);
    If FileInUse(ReturnFileStr) Then Begin
      Thread.Connection.WriteLn('-ERR File Open Permission Refused. Re-Try later.');
      If LogDebug Then
        WriteDebugMsg('RETR says -ERR File ' +ReturnFileStr+' is in use.');
      Exit;
    End;
    FiSize := EmailList.GetFileSize(MsgNum -1);
    Thread.Connection.WriteLn('+OK '+InttoSTr(Fisize)+' octets');
    If LogDebug Then
      WriteDebugMsg('RETR says +OK '+InttoSTr(Fisize)+' octets' );
    AssignFile(f,ReturnFileStr);
    Try
      Try
        ReSet(F);
        While Not Eof(F) Do Begin
          ReadLn(F,FileStr);
          Thread.Connection.WriteLn(FileStr);
          If LogDebug Then
            WriteDebugMsg(FileStr);
        End;
      Except
        On Exception Do Begin
          If LogDebug Then
            WriteDebugMsg('RETR says -ERR Exception on Copy to Writeln');
        End;
      End;
      If FileStr <> cPeriod then Begin
        Filestr := cPeriod;
        Thread.Connection.WriteLn(FileStr);
        If LogDebug Then WriteDebugMsg(FileStr);
      End;
     Finally
      If LogDebug Then
        WriteDebugMsg('RETR says +OK Close File ');
      CloseFile(F);
    End;
  End;                            { DoCommandRETR }

  Procedure TWinshoePOP3Server.DoCommandDELE(Thread: TWinshoeServerThread; RcvdStr : String;
                                              EmailList: TEMailList;  Var POPState: etPop3SvrState;
                                              Var Handled : Boolean);
  Var
    MsgNumStr : String;
    MsgNum,
    NumMsgs,
    Err : Integer;

    Procedure DoInvalidMsgNum;
    Begin                         { DoInvalidMsgNum }
      Thread.Connection.WriteLn('-ERR Delete Command Has Invalid Msg Number');
      If LogDebug Then
        WriteDebugMsg('DELE says -ERR Invalid Msg Num');
    End;                          { DoInvalidMsgNum }

  Begin                           { DoCommandDELE }
    If Assigned(OnCommandDELE) Then
      OnCommandDELE(Thread, RcvdStr,EmailList,PopState,Handled);
    If  Handled Then
      Exit;
    If LogDebug Then
      WriteDebugMsg('DELE says Called');
    If PopState <>  ePopStateTransaction Then Begin
      Thread.Connection.WriteLn('-ERR Invalid State User not Logged on');
      If LogDebug Then
        WriteDebugMsg('DELE says -ERR Invalid State');
      Exit;
    End;
    MsgNumStr := GetFirstTokenDeleteFromArg(RcvdStr,char32);
    Val(MsgNumStr, MsgNum, Err);
    If Err <> 0 Then Begin
      DoInValidMsgNum;
      Exit;
    End;
    NumMsgs := EMailList.Count;
    If Not((MsgNum > 0)And (MsgNum <= NumMsgs)) Then Begin
      DoInvalidMsgNum;
      Exit;
    End;
    If EmailList.GetFileDeleted(MsgNum -1) Then Begin
      Thread.Connection.WriteLn('-ERR MSG Already Deleted');
      If LogDebug Then
        WriteDebugMsg('DELE says -ERR Msg Already Deleted');
      Exit;
    End;
    EmailList.SetFileDeleted(MsgNum -1,True);
    Thread.Connection.WriteLn('+OK Msg '+IntTosTr(MsgNum)+' was deleted');
    If LogDebug Then
      WriteDebugMsg('DELE says +OK Msg '+IntTosTr(MsgNum)+' was deleted');
  End;                            { DoCommandDELE }

  Procedure TWinshoePOP3Server.DoCommandQUIT(Thread: TWinshoeServerThread; RcvdStr : String;
                                              EmailList: TEMailList;  Var POPState: etPop3SvrState;
                                              Var Handled : Boolean);
  Var
    Idx : Integer;
  Begin                           { DoCommandQuit }
    Try
      If Assigned(OnCommandQUIT) Then
        OnCommandQUIT(Thread,RcvdStr,EmailList,PopState,Handled);
      If Not Handled Then Begin
        If LogDebug Then WriteDebugMsg('QUIT says Called');
        If  EmailList.Count > 0 Then Begin
          For Idx := 0 To EmailList.Count -1 Do Begin
            If EmailList.GetFileDeleted(Idx) Then Begin
              DeleteFile(EmailList.GetFileName(Idx));
              If LogDebug Then
                WriteDebugMsg('QUIT says Deleting '+ EmailList.GetfileName(Idx));
            End;
          End;
        End;
        EmailList.Clear;
        Thread.Connection.WriteLn('+OK Winshoe Pop3 Server Confirms Quit');
        If LogDebug Then
          WriteDebugMsg('QUIT says +OK Winshoe Pop3 Server Confirms Quit' );
      End;
    Finally
      Thread.Connection.Disconnect;
    End;
  End;                            { DoCommandQuit }

  Procedure TWinshoePOP3Server.DoCommandAPOP(Thread: TWinshoeServerThread; RcvdStr : String;
                                              EmailList: TEMailList;  Var POPState: etPop3SvrState;
                                              Var Handled : Boolean);
  Begin                           { DoCommandAPOP }
    If Assigned(OnCommandAPOP) Then
      OnCommandAPOP(Thread, RcvdStr,EmailList,PopState,Handled);
    If Handled Then
      Exit;
    Thread.Connection.WriteLn('-ERR APOP Command Not Implemented');
    If LogDebug Then
      WriteDebugMsg('APOP says -ERR Command Not Implemented' );
  End;                            { DoCommandAPOP }

  Procedure TWinshoePOP3Server.DoCommandSTAT(Thread: TWinshoeServerThread; RcvdStr : String;
                                              EmailList: TEMailList; Var POPState: etPop3SvrState;
                                              Var Handled : Boolean);
  Var
   NumFiles,
   TotSize : Integer;
  Begin                           { DoCommandSTAT }
    If Assigned(OnCommandSTAT) Then
      OnCommandSTAT(Thread, RcvdStr,EmailList,PopState,Handled);
    If Handled Then
      Exit;
    If POPState <>  ePopStateTransaction Then Begin
      Thread.Connection.WriteLn('-ERR Invalid State User not Logged on');
      If LogDebug Then
        WriteDebugMsg('STAT says -ERR Invalid State' );
      Exit;
    End;
    NumFiles := GetNumMsgsOnFile(EMailList);
    TotSize := GetTotalFileSize(EmailList);
    Thread.Connection.WriteLn('+OK '+IntToStr(NumFiles)+' '+IntTostr(TotSize));
    If LogDebug Then
      WriteDebugMsg('STAT says +OK '+IntToStr(NumFiles)+' '+IntTostr(TotSize));
  End;                            { DoCommandSTAT }

  Procedure TWinshoePOP3Server.DoCommandNOOP(Thread: TWinshoeServerThread; RcvdStr : String;
                                              EmailList: TEMailList;  Var POPState: etPop3SvrState;
                                              Var Handled : Boolean);
  Begin                           { DoCommandNOOP }
    If Assigned(OnCommandNOOP) Then
      OnCommandNOOP(Thread, RcvdStr,EmailList,PopState,Handled);
    If Handled Then
      Exit;
    Thread.Connection.WriteLn('+OK NOOP Executed');
    If LogDebug Then
      WriteDebugMsg('NOOP says +OK NOOP Executed' );
  End;                            { DoCommandNOOP }

  Procedure TWinshoePOP3Server.DoCommandRSET(Thread: TWinshoeServerThread; RcvdStr : String;
                                              EmailList: TEMailList; Var POPState: etPop3SvrState;
                                              Var Handled : Boolean);
  Var
    Idx,
    NumFiles,
    TotSize : Integer;
  Begin                           { DoCommandRSET }
    If Assigned(OnCommandRSET) Then
      OnCommandRSET(Thread, RcvdStr,EmailList,PopState,Handled);
    If Handled Then
      Exit;
    If POPState <>  ePopStateTransaction Then Begin
      Thread.Connection.WriteLn('-ERR Invalid State User not Logged on');
      
        WriteDebugMsg('RSET says -ERR Invalid State');
      Exit;
    End;
    If EmailList.Count > 0 Then Begin
      For Idx := 0 To EmailList.Count -1 Do Begin
        If EmailList.GetFileDeleted(Idx) Then Begin
          EmailList.SetfileDeleted(Idx, False);
        End;
      End;
    End;
    NumFiles := EmailList.Count;
    TotSize := GetTotalFileSize(EmailList);
    Thread.Connection.WriteLn('+OK maildrop has ' + IntToStr(NumFiles)+' messages ('
                              +IntToStr(TotSize)+ ' octets)' );
    
      WriteDebugMsg('RSET says +OK maildrop has ' + IntToStr(NumFiles)+' messages ('
                    +IntToStr(TotSize)+ ' octets)' );
  End;                             { DoCommandRSET }

  Procedure TWinshoePOP3Server.DoCommandTOP(Thread: TWinshoeServerThread; RcvdStr : String;
                                              EmailList: TEMailList; Var POPState: etPop3SvrState;
                                              Var Handled : Boolean);
  Var
    Idx,
    MsgNum,
    NumMsgs,
    NumLines,Err :Integer;
    NumStr : String;
    FiStr : String;
    f: Text;

    Procedure DoInValidMsgNum;
    Begin                         { DoInValidMsgNum }
      Thread.Connection.WriteLn('-ERR Invalid Msg Number ');
      
        WriteDebugMsg('TOP says -ERR Invalid Msg Num');
    End;                          { DoInValidMsgNum }

  Begin                           { DoCommandTOP }
    If Assigned(OnCommandTOP) Then
      OnCommandTOP(Thread, RcvdStr,EmailList,PopState,Handled);
    If Handled Then
      Exit;
    If POPState <>  ePopStateTransaction Then Begin
      Thread.Connection.WriteLn('-ERR Invalid State User not Logged on');
      
        WriteDebugMsg('TOP says -ERR Invalid State ');
      Exit;
    End;
    NumMsgs := GetNumMsgsOnFile(EmailList);
    If NumMsgs = 0 Then Begin
      Thread.Connection.WriteLn('-ERR There are no Messages on file');
      
        WriteDebugMsg('TOP says -ERR No Messages on File');
      Exit;
    End;
    NumStr := GetFirstTokenDeleteFromArg(RcvdStr,Char32);
    Val(NumStr,MsgNum,Err);
    If Err <> 0 Then Begin
      DoInvalidMsgNum;
      Exit;
    End;
    If Not ((MsgNum > 0) And (MsgNum <= NumMsgs)) Then Begin
      DoInvalidMsgNum;
      Exit;
    End;
    NumStr := GetFirstTokenDeleteFromArg(RcvdStr,Char32);
    Val(NumStr, NumLines,Err);
    If Err <> 0 Then Begin
      Thread.Connection.WriteLn('-ERR Number of lines corrupted');
      
        WriteDebugMsg('TOP says -ERR Number of lines corrupted');
      Exit;
    End;
    If NumLines < 0 Then Begin  // {0.01} zero should return just headers
      Thread.Connection.WriteLn('-ERR Invalid Number of Lines');
      
        WriteDebugMsg('TOP says -ERR Invalid Number of Lines');
      Exit;
    End;
    AssignFile(f,EmailList.GetFileName(MsgNum-1));
    Try
      ReSet(f);
      Idx := 0;
      Thread.Connection.WriteLn('+OK');
      
        WriteDebugMsg('TOP says +OK');
      While Not Eof(f) Do Begin
        ReadLn(F,FiStr);
        Thread.Connection.WriteLn(FiStr);
        If FiStr = '' Then Break
      End;
      While Not (Eof(f)) And (Idx < NumLines) Do Begin
        Inc(Idx);
        ReadLn(F,FiStr);
        Thread.Connection.WriteLn(FiStr);
        
          WriteDebugMsg(FiStr);
      End;
      If Not Eof(f) Then Begin
        Thread.Connection.WriteLn(cPeriod);
         WriteDebugMsg(cPeriod);
      End;
    Finally
      CloseFile(f);
    End;
  End;                            { DoCommandTOP }

  Procedure TWinshoePOP3Server.DoCommandUIDL(Thread: TWinshoeServerThread; RcvdStr : String;
                                               EmailList: TEMailList; Var POPState: etPop3SvrState;
                                               Var Handled : Boolean);
  Var
    NumMsgs,
    MsgNum,
    Err,
    Idx : Integer;
    UIDLStr,
    MsgNumStr : String;

    Function GetUIDLFromMessage(Msg: Integer) : String;
    Var
      aPos : Integer;
    Begin                         { GetUIDLFromMessage }
      Result := ExtractFileName(EmailList.GetFileName(Msg -1));
      aPos := Pos(cPeriod,Result);
      If aPos <> 0 Then
        Delete(Result,aPos,254);
    End;                          { GetUIDLFromMessage }

    Procedure DoNoMessageError;
    Begin
      
        WriteDebugMsg('UIDL says -ERR No Messages on File');
      Thread.Connection.WriteLn('-ERR NO Message on file');
    End;

    Procedure DoInvalidMsgNum;
    Begin
      Thread.Connection.WriteLn('-ERR Invalid Msg Number');
      
        WriteDebugMsg('UIDL says -ERR Invalid Msg Number');
    End;

    Procedure DoMsgDeletedErr;
    Begin
      Thread.Connection.WriteLn('-ERR Invalid Msg Num. It Has Been Deleted');
      
        WriteDebugMsg('UIDL says -ERR Msg Deleted');
    End;

  Begin                           { DoCommandUIDL }
    If Assigned(OnCommandUIDL) Then
      OnCommandUIDL(Thread, RcvdStr,EmailList,PopState,Handled);
    If Handled Then Exit;
    If POPState <>  ePopStateTransaction Then Begin
      Thread.Connection.WriteLn('-ERR Invalid State User not Logged on');
       WriteDebugMsg('UIDL says -ERR Invalid State');
      Exit;
    End;
    NumMsgs := GetNumMsgsOnFile(EmailList);
    If NumMsgs = 0 Then Begin
       DoNoMessageError;
       Exit;
    End;
    MsgNumStr := GetFirstTokenDeleteFromArg(RcvdStr,Char32);
    If Length(MsgNumStr) = 0 Then Begin
      If NumMsgs = 0 Then Begin
        DoNoMessageError;
        Exit;
      End;
      Thread.Connection.WriteLn('+OK');
      
        WriteDebugMsg('UIDL says +OK');
      For Idx := 0 To EmailList.Count -1 Do Begin
        UIDLStr := GetUIDLFromMessage(Succ(Idx));
        
          WriteDebugMsg('UIDL says '+IntToStr(Succ(Idx))+' '+UIDLStr);
        Thread.Connection.WriteLn(IntTostr(Succ(Idx)) +' '+ UIDLStr);
      End;
      
        WriteDebugMsg('UIDL says .');
      Thread.Connection.WriteLn(cPeriod);
    End
    Else Begin
      Val(MsgNumStr,MsgNum,Err);
      If Err <> 0 Then Begin
        DoInvalidMsgNum;
        Exit;
      End;
      If Not ((MsgNum > 0) And (MsgNum <= EmailList.Count)) Then Begin
        DoInvalidMsgNum;
        Exit;
      End;
      If EmailList.GetFileDeleted(MsgNum-1) Then Begin
        DoMsgDeletedErr;
        Exit;
      End;
      UIDLStr := GetUIDLFromMessage(MsgNum);
      If Length(UidlStr) = 0 Then Begin
        DoMsgDeletedErr;
        Exit;
      End;
      Thread.Connection.WriteLn('+OK '+InttoStr(MsgNum)+' '+UIdlStr);
      
        WriteDebugMsg('UIDL says +OK '+InttoStr(MsgNum)+' '+UIdlStr);
    End;
  End;                            { DoCommandUIDL }

  Procedure TWinshoePOP3Server.DoCommandError(Thread: TWinshoeServerThread;RcvdStr: String;
                                               Var POPState: etPop3SvrState);
  Begin                           { DoCommandError }
    If Assigned (OnCommandError) Then
      OnCommandError(Thread, RcvdStr,PopState)
    Else Begin
      Thread.Connection.WriteLn('-ERR Invalid Command Str of '+RcvdStr);

        WriteDebugMsg('Command Parser says -ERR Invalid Command Str of '+RcvdStr);
    End;
  End;                            { DoCommandError }
//-------------------- End TWinshoePOP3Server Code ---------------------------


procedure TWinshoePOP3Server.DoGetPassword(const asUserID: string; var vsPassword: string);
begin
	vsPassword := '';
	if assigned(OnGetPassword) then begin
  	OnGetPassword(Self, asUserID, vsPassword);
  end;
end;

End.

