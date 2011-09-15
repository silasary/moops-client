Unit WinshoeWatchFwdDir;
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
//------------------------------------------------------------------------------

Interface

Uses
  Windows,
  Messages,
  Classes;

Const
  WM_Has_Mail = Wm_User + $99; { Hopefully this is unused Message Id }
  ParamFwd_Message = 90664;    { Required but not needed             }

Type
   TForwardThreadData = Record
     HWndToNotity : THandle;    { Handle to window to notify if mail is in dir       }
     aMailrootDir : String[127];{ Root Directory where mail is put RootDir +'Pickup')}
     uCallbackMessage : UINT;   {  Wm_Has_Mail is message used                       }
     uCallBackId : Integer;     { Lparam of Message                                  }
     Debug : Boolean;           { Toggles Debug File messages                        }
   End;

Type
  TWinshoeWatchFwdDir = Class(TThread)
  Private
    { Private declarations }
    fPickupMailDir: String;
    fWinHandleToNotify: THandle;
    NotifyMessage : Uint;
    FDebug : Boolean;
    fMailRootDir : String;
    Procedure WriteDebugMsg(Const aStr :String);
    Procedure SetPickupMailDir;
  Protected
    Procedure Execute; Override;
   Published
    Constructor Create(Var FwdThrdDta: TForwardThreadData);
  End;

Implementation

{ TWinshoeWatchFwdDir }
Uses
  SysUtils,
  FileCtrl;

Const
  StartThrdSuspended = True;
  StartThrdRunning = False;

  Function FileInUse(Const FileName : String) : Boolean;
  Var
    FileHandle : Integer;
  Begin                         { FileInUse }
    Result := False;
    If FileExists(FileName) Then Begin
      FileHandle := FileOpen(FileName, fmOpenRead Or fmShareExclusive	);
      Result :=  FileHandle = -1;
      If FileHandle > 0 Then Fileclose(FileHandle);
    End;
  End;                          { FileInUse }

  Function FixDirBackSlash(Const aDir : String): String;
  Begin
    If AnsiLastChar(aDir)^ <> '\' Then Result := aDir + '\'
    Else Result := aDir;
  End;

  Constructor TWinshoeWatchFwdDir.Create(Var FwdThrdDta: TForwardThreadData);
  Begin
   Inherited Create(StartThrdSuspended);
   With FwdThrdDta Do Begin
     fWinHandleToNotify := HWndToNotity;
     FMailRootDir := aMailrootDir;
     NotifyMessage :=  uCallbackMessage;
     fDebug := Debug;
   End;
   Resume;
  End;

  Procedure TWinshoeWatchFwdDir.WriteDebugMsg(Const aStr :String);
  Var
    aFile :Text;
  Begin                           { WriteDebugMsg }
      {$I-}
    If Boolean(IoResult) Then;
    AssignFile(aFile,FixDirBackSlash(fMailRootDir)+'SMTPFwdWatch.txt');
    Append(aFile);
    If IoResult <> 0 Then ReWrite(Afile);
    WriteLn(Afile,DateTimeToStr(Now)+' '+Astr);
    Close(Afile);
    {$I+}
  End;


  Procedure TWinshoeWatchFwdDir.SetPickupMailDir;
  Begin                           { SetSendMailDir }
    fPickupMailDir := FixDirBackSlash(FMailRootDir)+'Pickup\';
    ForceDirectories(fPickupMailDir);
    If fDebug Then WriteDebugMsg('WatchDir says PickupMailDir is '+fPickUpMailDir);
  End;                            { SetSendMailDir }

  Procedure TWinshoeWatchFwdDir.Execute;
  Var
    SearchPath : String;

   Function PickUpDirHasFiles : Boolean;
    Var
      Sr : TSearchRec;
      ErrCode : Integer;
    Begin                         { PickUpDirHasFiles }
      Result := False;
      Try
        Try
          ErrCode := FindFirst(SearchPath, faArchive, Sr);
          Result := ErrCode = 0;
          If Result Then Begin
            If FileInUse(fPickupMailDir+Sr.name) Then  Result := False;
            If Result Then Begin
               If fDebug Then WriteDebugMsg('WatchDir says PickupDirHasFiles is True');
            End
            Else Begin
              If fDebug Then WriteDebugMsg('WatchDir says PickupDirHasFiles but file is still open');
            End;
          End;
        Except
          On Exception Do Begin
            If fDebug Then
              WriteDebugMsg('WatchDir''s PickupDirHasFiles says FindFirst Has an Exception');
          End;
       End ;
      Finally
        FindClose(Sr);
      End
    End;                          { PickupDirHasFiles }

  Begin                           { Thread Execute }
    SetPickupMailDir;
    SearchPath := FixDirBackSlash(fPickUpMailDir)+'*.eml';
     If fDebug  Then Begin
        WriteDebugMsg('');
        WriteDebugmsg('');
        WriteDebugMsg('Winshoe WatchDir is Running '+SearchPath);
     End;
     While Not Terminated  Do Begin
       Sleep(2000);
       If Not Terminated Then Begin
         If PickUpDirHasFiles Then SendMessage(fWinHandleToNotify,WM_Has_Mail,ParamFwd_Message,0);
       End;
     End;
  End;

End.
