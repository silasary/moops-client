Unit WinshoeSMTPServerRelay;
//------------------------------------------------------------------------------
//
//
// Started Date :  08/04/1999        Version Beta .10 Complete : 08/10/1999
//
// Author : Ray Malone
// MBS Software
// 251 E. 4th St.
// Chillicothe, OH 45601
//
// MailTo: ray@mbssoftware.com
//
//
//-----Changes /Addtions/ Bug fixes
// 10/13/99 HRM  {!!0.01}
// Added check of csdesigning in component state to keep
// the Watchdir Thread from running in the IDE.
//
// 10/14/99  HRM  {!!0.02}
//   Added Active property to control WatchThread
//   Modified loaded procedure to handle active property.
//   Changed order of creation so WatchDir is created last.
//
// 10/15/99 HRM  {!!0.03}
//   Exception if Mx Resolver was timed out was not captured
//   causing Server To Crash Changed Exception Handling in GetSMPTHost
//
// 11/04/99  HRM  {!!0.04}
//   Added better checks for Mx-Resolver use added support for more than
//   one Mx-resolver so mail is not dependant on one mx-Resolver;
//
// 11/04/99      {!!0.05}
//    Added support for mulitiple mail servers for a domain. If a domain
//    has several servers, we will try all before rejecting send.
//
// 11/08/99  {!!0.06}      Revison by  M.P. Andriesse,
//    Fixed now adds period to any line containing a starting period except the
//    Last line. Per RFC 821 section 4.5.2
//
// 13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
//------------------------------------------------------------------------------

Interface

Uses
  Windows,
  Classes,
  Controls,
  Messages,
  Forms,
  Dialogs,
  Winshoes,
  WinshoeDNSResolver,
  WinShoeWatchFwdDir;

Type
  ESMTPForwardMailError = Class(EWinshoeException);

Type
  TWinshoeSMTPRelay = Class(TWinshoeClient )
  Private
    fbActive : Boolean;
    fMxHosts : TStrings;
    fMailRootDir : String;
    fPickupDir : String;
    SendingMail,
    fSMTPDebug  : Boolean;
    FNotifyWinHandle : THandle;
    FwdThreadData :TForwardThreadData;
    WatchThread : TWinshoeWatchFwdDir;
    MXResolver : TWinshoeMXResolver;
    PROCEDURE SetMxHosts(Value : Tstrings);
  Protected
    ErrCode : Integer;
    Procedure WriteDebugMsg(Const aStr :String);
    Procedure InitWatchThreadData;
    Procedure SetActive(pbValue: Boolean);
    Procedure Loaded; Override;
    Procedure ParseAddress(Const FullAddrStr: String; Var EmailAddr, ClientName: String);
    Function GetSMTPHost(Const ToStr : String; HostStrs : TStringList) :Boolean;
    Function GetToFromAndSubject(Const FileName : String; VAR ToStr,FromStr,aSubject : String): Boolean;
    Function SendFile(Const AFiName: String) : Integer;
    Procedure DoBadMail(Const SendFileName : String; aResult: Integer);
    Procedure WindowProc(Var Msg : TMessage);
  Public
    Procedure Connect; Override;
    Procedure Disconnect; Override;
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
  Published
    property Active : Boolean read fbActive write SetActive;
    Property MxHosts : tStrings Read fMxHosts Write SetMxHosts;
    Property Debug  : Boolean Read fSMTPDebug Write fSMTPDebug;
    Property MailRootDir : String  Read fmailRootDir Write fMailRootDir;
  End;

// Procs

Procedure Register;

Implementation

Uses
  GlobalWinshoe,
  FileCtrl,
  SysUtils;

  Procedure Register;
  Begin
    RegisterComponents('Winshoes Servers', [TWinshoeSMTPRelay]);
  End;

  Function FixDirBackSlash(Const aDir : String): String;
  Begin
    If AnsiLastChar(aDir)^ <> '\' Then
      Result := aDir + '\'
    Else
      Result := aDir;
  End;

  Procedure TWinshoeSMTPRelay.WriteDebugMsg(Const aStr :String);
  Var
    aFile :Text;
  Begin                           { WriteDebugMsg }
    {$I-}
    If Boolean(IoResult) Then;
    AssignFile(aFile, FixDirBackSlash(fMailRootDir)+'SMTPFwd.Txt');
    System.Append(aFile);
    If IoResult <> 0 Then
      ReWrite(Afile);
    System.WriteLn(Afile,DateTimeToStr(Now)+' '+aStr);
    System.CloseFile(Afile);
    {$I+}
  End;                           { WriteDebugMsg }

  Procedure TWinshoeSMTPRelay.InitWatchThreadData;
  Begin
    With FwdThreadData Do Begin
      HWndToNotity := FNotifyWinHandle;
      aMailrootDir := FMailRootDir;
      uCallbackMessage := Wm_Has_Mail;
      Debug := FSMTPDebug;;
    End;
  End;

 Constructor TWinshoeSMTPRelay.Create(aOwner : tComponent);
  Begin
    Inherited Create(aOwner);
    fMxHosts := TStringList.Create;
    If PORT = 0 then
      Port := 25;
    FNotifyWinHandle := AllocateHWnd(WindowProc);
  End;

  Procedure TWinshoeSMTPRelay.SetActive(pbValue: Boolean);
  begin                {!!0.02 start}
    if fbActive = pbValue then exit;
    if not ((csLoading in ComponentState) or (csDesigning in ComponentState)) then begin
      if pbValue then begin
        InitWatchThreadData;
        WatchThread := TWinshoeWatchFwdDir.Create(FwdThreadData);
        WatchThread.FreeOnTerminate := True;
      end
      else begin
        WatchThread.Terminate
      end;
    end;
    fbActive := pbValue;
  end;    {!!0.02 end}

  Procedure TWinshoeSMTPRelay.Loaded;
  Begin
    inherited Loaded;  {!!0.02 start}
    MXResolver := TWinshoeMXResolver.Create(Self);
    IF fMXHosts.Count > 0 then
      MxResolver.Host := fMxHosts[0];
    If fSMTPDeBug Then Begin
      WriteDebugMsg('');
      WriteDebugMsg('');
      WriteDebugMsg('SMTPFwd says MxResolver host is ' +MxResolver.host);
    End;
    fPickupDir  := FixDirBackSlash(fMailRootDir)+'Pickup\';
    If fSMTPDeBug Then WriteDebugMsg('SMTPfwd says Pickupdir is ' +fPickupDir);
    If Active then Begin
      fbActive := false;
      SetActive(True);
    end;
    WriteDebugMsg('SMTPFwd says Port is ' +IntToStr(Port));
  End;              {!!0.02 end}

  Destructor TWinshoeSMTPRelay.Destroy;
  Begin
    DeAllocateHWnd(FNotifyWinHandle);
    MxResolver.Free;
    fMxHosts.Free;
    Inherited Destroy;
  End;

  Procedure TWinshoeSMTPRelay.Connect;
  Begin
    Inherited Connect;
    Try
      If GetResponse <> 220 Then Begin
        ErrCode := 2;
        SRaise(EWinshoeConnectRefused);
      End;
      Command('Helo ' + LocalName, 250, 0, 'Connected');
    Except
      Disconnect;
      ErrCode := 2;
      Raise
    End;
  End;

  Procedure TWinshoeSMTPRelay.Disconnect;
  Begin
    Try
      If Connected Then
        WriteLn('Quit');
    Finally
      Inherited Disconnect;
    End;
  End;

  PROCEDURE twinshoeSMTPRelay.SetMxHosts(Value : Tstrings);
  begin
    fMXHosts.Assign(Value);
  end;

  Procedure TWinshoeSMTPRelay.ParseAddress(Const FullAddrStr: String; Var EmailAddr, ClientName: String);
  Var
    iPos: Integer;
  Begin
    EmailAddr  := ''; ClientName  := '';
    If Copy(FullAddrStr, Length(FullAddrStr) , 1) = '>' Then Begin
      iPos := Pos('<', FullAddrStr);
      If iPos > 0 Then Begin
        EmailAddr := Trim(Copy(FullAddrStr, iPos + 1, Length(FullAddrStr) - iPos - 1));
        ClientName := Trim(Copy(FullAddrStr, 1, iPos - 1));
      End;
    End
    Else
      If Copy(FullAddrStr, Length(FullAddrStr), 1) = ')' Then Begin
        iPos := Pos('(', FullAddrStr);
        If iPos > 0 Then Begin
          ClientName := Trim(Copy(FullAddrStr, iPos + 1, Length(FullAddrStr) - iPos - 1));
          EmailAddr := Trim(Copy(FullAddrStr, 1, iPos - 1));
        End;
      End
    Else
      EmailAddr := FullAddrStr;
    While Length(ClientName) > 1 Do Begin
      If (ClientName[1] = '"') And (ClientName[Length(ClientName)] = '"') Then
        ClientName := Copy(ClientName, 2, Length(ClientName) - 2)
      Else
        If (ClientName[1] = '''') And (ClientName[Length(ClientName)] = '''') Then
          ClientName := Copy(ClientName, 2, Length(ClientName) - 2)
      Else
        break;
    End;
    If Length(ClientName) = 0 Then
      ClientName := EmailAddr;
  End;


  Function TWinshoeSMTPRelay.GetToFromAndSubject(Const FileName : String; Var ToStr,FromStr,aSubject : String): Boolean;
  Var
    HeaderStrs : TStringList;

    Function GetHeaderStringsFromFile(Const aFiName : String; HdrStrs: TStringList) : Boolean;
    Var
      f : Text;
      aStr : String;
    Begin                           { GetHeaderStrings }
      System.AssignFile(f,aFiName);
      Try
        Try
          System.ReSet(f);
          While Not Eof(f) Do Begin
            System.ReadLn(f,aStr);
            If aStr <> '' Then
              HdrStrs.Add(aStr)
            Else
              Break;
          End;
          ConvertHeadersToValues(HdrStrs);
          Result := True;
        Except
          On Exception Do Begin
            Result := False;
            ErrCode := 4;
          End;
        End;
      Finally
        System. CloseFile(f);
      End;
    End;                            { GetHeaderStrings }

  Begin                             {GetToFromAndSubject};
    If fSMTPDebug Then
      WriteDebugMsg('SMTPFwd says GetToFromAndSubject is called');
    Result := False; 
    HeaderStrs := TStringList.Create;
    Try
      Result := GetHeaderStringsFromFile(FileName,HeaderStrs);
      ToStr := HeaderStrs.Values['x-receiver'];
      If ToStr = '' Then
        ToStr := HeaderStrs.Values['To'];
      FromStr := HeaderStrs.Values['x-sender'];
      If FromStr = '' Then
        FromStr := HeaderStrs.Values['From'];
      aSubject := HeaderStrs.Values['Subject'];
      If aSubject = '' Then
        ASubject := 'None';
    Finally
      HeaderStrs.Free;
      If Not Result then
        If fSMTPDebug Then
          WriteDebugMsg('SMTPFwd,SendFile GetToFromAndSubject returned False. '+FileName+' is Corrupt');
    End;
  End;                               { GetToFromAndSubject}

  Function TWinshoeSMTPRelay.GetSMTPHost(Const ToStr : String;  HostStrs: TStringList):Boolean;
  Var
    EmailAddr,
    Clientname,
    DomainStr,
    Astr : String;
  Begin                           { GetSMTPHost }
    HostStrs.Clear;
    If fSMTPDebug Then
      WriteDebugMsg('SMTPFwd.SendFile.GetSMTPHost is called');
    ParseAddress(Tostr,EmailAddr,Clientname);
    DomainStr := Copy(EmailAddr,Succ(Pos('@',EmailAddr)),255);
    Try
      MXResolver.GetMailServers(DomainStr, HostStrs);
      If HostStrs.count > 0 then
        Astr := hostStrs[0];
      If fSMTPDebug Then
        WriteDebugMsg('SMTPFwd.GetSMTPHost says host is' +astr);
      Result := True;
    Except
      On Exception do Begin //{!!0.03} trap for all exceptions including time out!!!
        Result := False;
        If fSMTPDebug Then
          WriteDebugMsg('GetSMTPHost says MX Resolver Failed to get Mx Host');
        ErrCode := 3;
      End;
    End;
  End;                            { GetSMTPHost }

  Function TWinshoeSMTPRelay.SendFile(Const AFiName: String)  : Integer;
  Var
    Astr :String;
    bConnected: Boolean;
    FromStr,
    ToStr,
    aSubject : String;
    MailSvrStrs : tStringList;
    ThisSvrNum,
    NumMxServers : Integer;

    Function ExtractAddr(Astr: String):String;
    Var
      NameStr :String;
    Begin                         { ExtractAddr }
      ParseAddress(Astr, Result, NameStr);
    End;                          { ExtractAddr }

    Function GetTheMailServers : Boolean;
    Begin                         { GetTheMailServers }
      Result := False;
      If fMxHosts.count = 0 then Begin
        If fSMTPDebug Then
          WriteDebugMsg('SMTPFwd,SendFile says Failure No Mx Server assigned');
        ErrCode := 1;
        Exit;
      End;
      MailSvrStrs := TStringlist.Create;
      NumMxServers := fMxHosts.Count;
      ThisSvrNum := 0;        {!!0.04 Try Multiple MX Resolvers }
      While (ThisSvrNum  < NumMxServers) and  NOT Result do Begin
        MXResolver.Host := fMxHosts[ThisSvrNum];
        Result := GetSMTPHost(ToStr, MailSvrStrs);
        Inc(ThisSvrNum);
      End;
      If Result then Begin
        ErrCode := 0;
        If fSMTPDebug Then
          WriteDebugMsg('SMTPFwd,SendFile says host is ' + Host);
      End
      Else begin
        If fSMTPDebug Then
          WriteDebugMsg('SMTPFwd,SendFile says GetSMTPHost Failed');
        MailSvrStrs.Free;
      End;
    End;                          { GetTheMailServers }

    Function SendTheFile(Const FileName : String): Boolean;
    Var
      f : Text;
    Begin                         { SendTheFile }
      System.AssignFile(F,FileName);
      Try
        Try
          System.ReSet(F);
          While Not Eof(F) Do Begin
            System.ReadLn(F,AStr);
            IF Not Eof(F) then Begin    {!!0.06}
              If (Length(Astr) > 0) and (AStr[1] = '.') then
                Astr := '.'+Astr;
            End;
            WriteLn(AStr);
            If fSMTPDebug Then
              WriteDebugMsg(Astr);
          End;
          Result := True;
        Except
          On Exception Do  Begin
            Result := False;
            ErrCode := 5;
          End;
        End;
      Finally
        System.CloseFile(f);
      End;
    End;                          { SendTheFile }

    PROCEDURE DoSendFileConnect;
    Var
     Res : Boolean;
    Begin                         { DoSendFileConnect }
      If fSMTPDebug Then
        WriteDebugMsg('SMTPFwd,SendFile Connect is next');
      bConnected := Connected;
      Res := False;
      ThisSvrNum := 0;
      While (ThisSvrNum <  MailSvrStrs.Count)and NOT Res do Begin {!!0.05}
        Host := MailSvrStrs[ThisSvrNum];
        Try
          If Not bConnected Then
            Connect;
          Res := True;
        Except
          Inc(ThisSvrNum);
        end;
      end;
      If Not Res then begin
        If fSMTPDebug Then
          WriteDebugMsg('SMTPFwd,SendFile Failed to connect to Mail Server');
        Raise  ESMTPForwardMailError.Create('Failed to Connect to Mail Server');
      End;
    end;                          { DoSendFileConnect }

  Begin                           { SendFile }
    Result := 0;
    If fSMTPDebug Then
      WriteDebugMsg('SMTPFwd,SendFile is called with '+afiName);
    If Not GetToFromAndSubject(AFiName,Tostr,FromStr, aSubject) Then Begin
      Result := ErrCode;
      Exit;
    End;
    If Not GetTheMailServers then Begin
       Result := ErrCode;
       Exit;
    End;
    bConnected := False;
    DoStatus('  Sending Message: ' + aSubject);
    Try
     Try
        DoSendFileConnect;
        Command('Rset', 250, 2, 'Successful Reset');
        If fSMTPDebug Then
          WriteDebugMsg('SMTPFwd,SendFile says OK ReSet');
        Command('Mail from:<' + ExtractAddr(FromStr) + '>', 250, 0, 'From: '+FromStr);
        If fSMTPDebug Then
          WriteDebugMsg('SMTPFwd,SendFile says OK Mail From');
        Command('RCPT to:<'   + ExtractAddr(Tostr)   + '>', 250, 2, 'To: ' + ToStr);
        If fSMTPDebug Then
          WriteDebugMsg('SMTPFwd,SendFile says OK RCPT');
        Command('Data', 354, 2, 'SMTP is ready for message');
        If fSMTPDebug Then
          WriteDebugMsg('SMTPFwd,SendFile says Data 354');
        If Not SendTheFile(aFiName) Then Begin
          If fSMTPDebug  Then
            WriteDebugMsg('SMTPFwd,SendFile says SendTheFile Returned False');
          Raise ESMTPForwardMailError.Create('SmtpFwd, SendTheFile Failed');
        End
        Else Begin
          Command('.', 250, 2, 'Message '+Tostr +' accepted');
          If fSMTPDebug Then
            WriteDebugMsg('SMTPFwd,SendFile says Message Accepted');
        End;
      Except
        On Exception Do Begin
          If Errcode = 0 Then Errcode := 6;
          Result := ErrCode;
          If fSMTPDebug Then
            WriteDebugMsg('SMTPFwd,SendFile says Exception Raised');
        End;
      End;
    Finally
      If Not bConnected Then Disconnect ;
      If fSMTPDebug Then
        WriteDebugMsg('SMTPFwd,SendFile says Disconnect');
      MailSvrStrs.Free;
     End;
  End;                            { SendFile }

  Procedure TWinshoeSMTPRelay.DoBadMail(Const SendFileName : String; aResult: Integer);
  Var
    BadMailRes : Integer;
    BadFileName : String;

    Function GetBadMailReason(Code :Integer): String;
    Begin                         { GetBadMailReason }
      Case Code Of
        0  : Result := 'File was sent and accepted by the destination domain';
        1  : Result := 'Mx Server was not assigned to Mx Resolver';
        2  : Result := 'Unable to connect to the  destination domain';
        3  : Result := 'Mx Resolver was unable to find a mail server for the address';
        4  : Result := 'Disk Drive error on reading the mail headers from the file';
        5  : Result := 'Failure to read message from the file. Local Disk Error';
        6  : Result := 'Failure to complete transmission of file. Failed Connection';
        Else Result := 'SendFile was unable to forward the mail';
      End;
    End;                          { GetBadMailReason }

    Function PrepareBadMailMessage: Boolean;
    Var
      f : Text;
      ToStr,FromStr,
      aSubject,ResStr : String;
    Begin                         { PrepareBadMailMessage }
      If fSMTPDebug Then
        WriteDebugMsg('SMTPFwd.DoBadMail Says  Get to From And Subject is Next');
      Result := GetToFromAndSubject(BadFileName, TosTr ,FromStr,aSubject);
      System.AssignFile(f,BadFileName);
      Try
        System.ReWrite(F);
        System.WriteLn(f,'X-sender: '+LocalName);
        System.WriteLn(f,'x-receiver: '+FromStr);
        If fSMTPDebug Then
          WriteDebugMsg('SMTPFwd Says.DoBadMail Says BadMailMsg is to '+FromStr);
        System.WriteLn(f,'To: '+FromStr);
        System.WriteLn(f,'From: '+LocalName);
        System.WriteLn(f,'Subject: Failure to Send '+aSubject);
        System.WriteLn(f,'Date: '+FormatDateTime('ddd, dd mmm yyyy hh:nn:ss '
                                  + DateTimeToGmtOffSetStr(OffsetFromUTC, False), Now));
        System.WriteLn(f,'');
        System.WriteLn(f,'Winshoe SMTP Server was unable to forward mail to '+ToStr);
        System.WriteLn(f,'Mail From '+FromStr);
        System.WriteLn(f,'With  the Subject of '+aSubject);
        System.WriteLn(f,'Was not sent!');
        ResStr := GetBadMailReason(aResult);
        If fSMTPDebug Then
          WriteDebugMsg('SMTPFwd Says.DoBadMail Says Reaseon Was '+ResStr);
        System.WriteLn(f,'The Reason for failure was, '+ResStr);
        System.WriteLn(f,'.');
      Finally
        System.CloseFile(f);
      End;
    End;                          { PrepareBadMailMessage }

  Begin                           { DoBadMail }
    If fSMTPDebug Then
      WriteDebugMsg('SMTPFwd.DoBadMail Says Called');
    BadFileName := FixDirBackSlash(FMailRootDir)+'BadMail';
    ForceDirectories(BadFileName);
    BadFileName := FixDirBackSlash(BadFileName) + ExtractFileName(SendFileName);
    If Not MoveFile(PChar(SendFileName),Pchar(BadFileName)) Then Begin
      If fSMTPDebug Then
        WriteDebugMsg('SMTPFwd.DoBadMail Says  BadMail Msg to BadMailDir Failed.');
      If FileExists(SendFilename) Then
        DeleteFile(SendfileName);
    End
    Else Begin
      If fSMTPDebug Then
        WriteDebugMsg('SMTPFwd.DoBadMail Says  MoveFile Returned True');
      PrepareBadMailMessage;
      BadMailRes := SendFile(BadFileName);
      If BadMailRes = 0 Then Begin
        If fSMTPDebug Then
          WriteDebugMsg('SMTPFwd.DoBadMail says BadMailMsg Sent Successfully');
        If FileExists(BadFileName) Then
          DeleteFile(BadfileName);
      End
    End;
  End;                            { DoBadMail }

  Procedure TWinshoeSMTPRelay.WindowProc(Var Msg : TMessage);
  Var
    Sr :TSearchRec;
    RetCode : Integer;
    SendFileName : String;
    aResult : Integer;
  Begin                           { WindowProc }
    If Msg.Msg  = Wm_Has_Mail Then Begin
      If SendingMail Then Exit;
      SendingMail := True;
      If fSMTPDebug Then
        WriteDebugMsg('SMTPFwd says WinProc Called');
      Try
        RetCode := FindFirst(fPickupDir +'*.eml',faArchive,Sr);
        While (RetCode = 0) Do Begin
          If fSMTPDebug Then
            WriteDebugMsg('SMTPFwd says Found ' +Sr.Name);
          SendfileName := fPickupDir +Sr.Name;
          aResult := SendFile(SendFileName);
          If aResult = 0 Then  Begin
            DeleteFile(SendFileName);
            If fSMTPDebug  Then
              WriteDebugMsg('SMTPFwd.SendFile Says Send Was Success.');
          End
          Else DoBadMail(SendfileName,aResult);
          Retcode := FindNext(Sr);
        End;
      Finally
        SendingMail := False;
        Findclose(Sr);
      End;
    End;
  End;                            { WindowProc }

End.
