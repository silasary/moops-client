unit Unit1;

interface

////////////////////////////////////////////////////////////////////////////////
// NNTP Server Protocol DEMONSTRATION
// ..
// Author: Ozz Nixon
// ..
// This is a simple demo (as far as the message bases are concerned!), that will
// track all the newsgroups via NNTPSVC.INI (in your Windows Directory). It can
// be expanded to contain more newsgroups than what is automatically generated!
//
// Instead of designing this demo to be limited to one "root" directory and all
// the newsgroups being stored below them, I allow you to point each newsgroup
// to different drives and subdirectories!
//
// NNTPSVC.INI {layout definition}
// [SETUP]
// Number of Newsgroups
// Port number to listen to {defaults to IPPORT_NNTP=119}
// [GROUP1] {note the 1 is dynamic, it is based upon the # of news groups!}
// Newsgroup Name
// News Group Directory {no trailing backslash!}
// Date of Last Post
// Time of Last Post
//
// I do not keep track of # of posts in the INI, just incase you want to run
// multiple NNTP Servers, they can share the same INI file and/or directories.
//
// Next, If you want the Listener Component to parse the commands and fire
// events to you, do not implement the OnExecute event! If you want to do all
// of the parsing for some reason, then Implement the OnExecute event, and do
// not implement any of the OnCommand* events.
//
// If you plan to develop a server using this type of file layout, the following
// features could improve your performance:
//
// 1. Tracking the Highest/Lowest Message Numbers in the [GROUP#] section would
//    allow you to bypass the physical scan this demo does.
// 2. Using a bit-array, you could set a bit to 1 if the message exists, and 0
//    if it does not. This could be saved into the INI file, but I would suggest
//    that if you do not implement the previous tweak that you implement this
//    one. Each bit is basically tracking does the file exist, then with simple
//    math you would know what the next/previous message numbers are. Basically
//    a real simple index to avoid a lot of wasted "fileexists" calls.
//
////////////////////////////////////////////////////////////////////////////////


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Winshoes, serverwinshoe, ServerWinshoeNNTP, GlobalWinshoe, Buttons, ExtCtrls,
  ComCtrls, StdCtrls;

Const
   IniFilename='NNTPSVC.INI';
   ServerID='news.yourdomain.com';

type
// This Object is stored per thread, for tracking purposes!
  UniqPerThread = class(TObject)
  public
     CurrentMessageNumber:Integer;
     CurrentGroupLoMsg:Integer;
     CurrentGroupHiMsg:Integer;
     CurrentGroupAvail:Integer;
     CurrentNewsGroup:String;
     CurrentGroupPath:String;
  End;

  TForm1 = class(TForm)
    WinshoeNNTPListener1: TWinshoeNNTPListener;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListBox1: TListBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    ListBox2: TListBox;
    SpeedButton3: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure WinshoeNNTPListener1Connect(Thread: TWinshoeServerThread);
    procedure WinshoeNNTPListener1Disconnect(Thread: TWinshoeServerThread);
    procedure FormShow(Sender: TObject);
    procedure WinshoeNNTPListener1CommandList(Thread: TWinshoeServerThread;
      Parm: String);
    procedure WinshoeNNTPListener1CommandGroup(
      Thread: TWinshoeServerThread; Group: String);
    procedure WinshoeNNTPListener1CommandListgroup(
      Thread: TWinshoeServerThread; Parm: String);
    procedure WinshoeNNTPListener1CommandHeadNo(
      Thread: TWinshoeServerThread; ActualNumber: Integer);
    procedure WinshoeNNTPListener1CommandBodyNo(
      Thread: TWinshoeServerThread; ActualNumber: Integer);
    procedure WinshoeNNTPListener1CommandArticleNo(
      Thread: TWinshoeServerThread; ActualNumber: Integer);
    procedure WinshoeNNTPListener1CommandQuit(
      Thread: TWinshoeServerThread);
    procedure WinshoeNNTPListener1CommandStatNo(
      Thread: TWinshoeServerThread; ActualNumber: Integer);
    procedure WinshoeNNTPListener1CommandHelp(
      Thread: TWinshoeServerThread);
    procedure WinshoeNNTPListener1CommandPost(Thread: TWinshoeServerThread);
    procedure WinshoeNNTPListener1CommandDate(
      Thread: TWinshoeServerThread);
    procedure WinshoeNNTPListener1CommandXOver(
      Thread: TWinshoeServerThread; Parm: String);
    procedure WinshoeNNTPListener1CommandNext(
      Thread: TWinshoeServerThread);
    procedure WinshoeNNTPListener1CommandLast(
      Thread: TWinshoeServerThread);
    procedure WinshoeNNTPListener1CommandIHave(
      Thread: TWinshoeServerThread; ActualID: String);
    procedure WinshoeNNTPListener1CommandXHDR(Thread: TWinshoeServerThread;
      Parm: String);
    procedure SpeedButton3Click(Sender: TObject);
    procedure WinshoeNNTPListener1CommandOther(
      Thread: TWinshoeServerThread; Command, Parm: String;
      var Handled: Boolean);
    procedure WinshoeNNTPListener1CommandArticleID(
      Thread: TWinshoeServerThread; ActualID: String);
    procedure WinshoeNNTPListener1CommandHeadID(
      Thread: TWinshoeServerThread; ActualID: String);
    procedure WinshoeNNTPListener1CreateThread(pConnection: TWinshoeServer;
      var pThread: TWinshoeServerThread);
  private
    { Private declarations }
    NumberOfConnections:Integer;
    NumberOfNewsgroups:Integer;

    procedure DebugReadWriter(Sender : TWinshoeSocket);
    procedure DebugWriteWriter(Sender : TWinshoeSocket);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

Uses
   FileCtrl,
   StringsWinshoe,
   IniFiles, Unit2;

{$R *.DFM}

Function GetHighestMsgNumber(S1:String):Integer;
Var
   Err:Integer;
   SRec:TSearchRec;

Begin
   Result:=0;
   Err:=FindFirst(S1+'\*.HDR',faAnyFile,SRec);
   While Err=0 do Begin
try
      If StrToInt(Copy(SRec.Name,1,Pos('.',SRec.Name)-1))>Result
         then Result:=StrToInt(Copy(SRec.Name,1,Pos('.',SRec.Name)-1));
except
end;
      Err:=FindNext(SRec);
   End;
   FindClose(SRec);
End;

Function SendListResponse(Path:String):String;
Var
   Err:Integer;
   SRec:TSearchRec;
   TmpInt:Integer;
   CurrentGroupHiMsg:Integer;
   CurrentGroupLoMsg:Integer;

Begin
   Err:=FindFirst(Path+'\*.hdr',faAnyFile,SRec);
   CurrentGroupHiMsg:=0;
   CurrentGroupLoMsg:=1;
   While Err=0 do Begin
      If SRec.Attr and faDirectory=0 then Begin
         TmpInt:=StrToInt(Copy(SRec.Name,1,Pos('.',SRec.Name)-1));
         If TmpInt>CurrentGroupHiMsg then CurrentGroupHiMsg:=TmpInt;
         If CurrentGroupLoMsg>TmpInt then CurrentGroupLoMsg:=TmpInt;
      End;
      Err:=FindNext(SRec);
   End;
   {the 'y' on the end means writable!}
   Result:=Pad10(CurrentGroupHiMsg)+CHAR32+Pad10(CurrentGroupLoMsg)+CHAR32+'y';
   FindClose(SRec);
End;

Function  SendGroupResponse(Thread: TWinshoeServerThread;Path,Group:String):String;
Var
   Err:Integer;
   SRec:TSearchRec;
   TmpInt:Integer;

Begin
   With Thread.SessionData as UniqPerThread do Begin
      CurrentNewsGroup:=Group;
      CurrentGroupPath:=Path;
      CurrentGroupLoMsg:=0;
      CurrentGroupHiMsg:=0;
      CurrentGroupAvail:=0;
      CurrentMessageNumber:=0;
      Err:=FindFirst(Path+'\*.hdr',faAnyFile,SRec);
      While Err=0 do Begin
         If SRec.Attr and faDirectory=0 then Begin
            TmpInt:=StrToInt(Copy(SRec.Name,1,Pos('.',SRec.Name)-1));
{if you wanted to do a bit array of available msgs it would go here!}
            If TmpInt>CurrentGroupHiMsg then CurrentGroupHiMsg:=TmpInt;
            If CurrentGroupLoMsg=0 then CurrentGroupLoMsg:=TmpInt
            Else
               If CurrentGroupLoMsg>TmpInt then CurrentGroupLoMsg:=TmpInt;
            CurrentGroupAvail:=CurrentGroupAvail+1;
         End;
         Err:=FindNext(SRec);
      End;
      Result:='211 '+
         IntToStr(CurrentGroupAvail)+CHAR32+
         IntToStr(CurrentGroupLoMsg)+CHAR32+
         IntToStr(CurrentGroupHiMsg)+CHAR32+Group;
      CurrentMessageNumber:=CurrentGroupLoMsg;
      FindClose(SRec);
   End;
End;

////////////////////////////////////////////////////////////////////////////////
// START THE SERVER
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
   Form2.ListBox1.Items.Clear;
try
   WinshoeNNTPListener1.Active:=True;
   StatusBar1.SimpleText:='Server Ready for Clients!';
   SpeedButton1.Enabled:=False;
   SpeedButton2.Enabled:=True;
   NumberOfConnections:=0;
except
   StatusBar1.SimpleText:='Server failed to Initialize!';
end;
end;

////////////////////////////////////////////////////////////////////////////////
// STOP THE SERVER
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.SpeedButton2Click(Sender: TObject);
Var
   TmpTList:TList;
   Count:Integer; {do it this way!}

begin
   TmpTList:=WinshoeNNTPListener1.Threads.LockList;
   Count:=TmpTList.Count;
   WinshoeNNTPListener1.Threads.UnlockList;
   If Count>0 then Begin
      If Windows.MessageBox(0,
         PChar('There are '+IntToStr(Count)+
         ' connections active!'+#13+
         'Do you wish to continue?'),
         'Warning!',
         MB_ICONEXCLAMATION or MB_YESNO)=IDNO then Exit;
   End;
try
   WinShoeNNTPListener1.Active:=False;
except
end;
   StatusBar1.SimpleText:='Server is now offline!';
   SpeedButton1.Enabled:=True;
   SpeedButton2.Enabled:=False;
   NumberOfConnections:=0;
end;

////////////////////////////////////////////////////////////////////////////////
// UNKNOWN COMMAND TO THE SERVER COMPONENT
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandOther(
  Thread: TWinshoeServerThread; Command, Parm: String;
  var Handled: Boolean);
begin
   Form2.ListBox1.Items.Append('UNKNOWN: ['+Command+'] '+Parm);
   ListBox2.Items.Add(Command+CHAR32+Parm);
   If command='MODE' then Begin
      Handled:=True;
      Thread.Connection.Writeln('200 OK');
   end
   Else Handled:=False;
end;

////////////////////////////////////////////////////////////////////////////////
// POST Received - SAVE A MESSAGE (HEADER AND BODY) TO DISK
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandPost(
  Thread: TWinshoeServerThread);
Var
   Msg:TStringList;
   Body:TStringList;
   Newsgroups:String;
   S:String;
   Loop:Integer;
   IniFile:TIniFile;
   Path:String;
   CurrentGroupHiMsg:Integer;
   W1,W2,W3,W4:Word;
   Ws:String;
begin
   Form2.ListBox1.Items.Append('POST');
   Thread.Connection.Writeln('340 send article to be posted. End with <CR-LF>.<CR-LF>');
   Msg:=TStringList.Create;
   Thread.Connection.CaptureHeader(Msg,'');
   {should always be blank}
   {fields we add on the fly we have to add "=" to mimic capture!}
   If Msg.Values['Message-ID']='' then Begin
      DecodeDate(Now,W1,W2,W3);
      Ws:=IntToHex(W1,4)+IntToHex(W2,2)+IntToHex(W3,2);
      DecodeTime(Now,W1,W2,W3,W4);
      Ws:=Ws+IntToHex(W1,2)+IntToHex(W2,2)+IntToHex(W3,2)+IntToHex(W4,2);
      Msg.Insert(0,'Message-ID=<'+WS+'@'+ServerID+'>');
   End;
   If Msg.Values['Path']='' then
      Msg.Insert(0,'Path='+ServerID);
   Newsgroups:=Msg.Values['Newsgroups'];
   If Newsgroups='' then Newsgroups:=
      UniqPerThread(Thread.SessionData).CurrentNewsGroup;
   If NewsGroups='' then Begin
      Thread.Connection.Writeln('412 no newsgroup has been selected');
      Msg.Free;
      Exit;
   End;
   Body:=TStringList.Create;
   Thread.Connection.Capture(Body, ['.']);
   IniFile:=TIniFile.Create(IniFilename);
   Newsgroups:=Lowercase(Newsgroups)+',';
   S:=Fetch(Newsgroups,',');
   While S<>'' do Begin
      Path:='';
      For Loop:=1 to NumberOfNewsgroups do Begin
         With IniFile do Begin
            Path:=ReadString('GROUP'+IntToStr(Loop),'Name','');
            If lowercase(Path)=S then Begin
               Path:=ReadString('GROUP'+IntToStr(Loop),'Path','');
               Break
            End;
         End;
      End;
      If Path<>'' then Begin
         CurrentGroupHiMsg:=GetHighestMsgNumber(Path);
         If Msg.Values['Lines']='' then
            Msg.Append('Lines='+IntToStr(Body.Count));
         Msg.SaveToFile(Path+'\'+Pad10(CurrentGroupHiMsg+1)+'.HDR');
         Body.SaveToFile(Path+'\'+Pad10(CurrentGroupHiMsg+1)+'.BDY');
      End;
      S:=Fetch(Newsgroups,',');
   End;
   Msg.Free;
   Body.Free;
   IniFile.Free;
   Thread.Connection.Writeln('240 article posted ok');
end;

////////////////////////////////////////////////////////////////////////////////
// NEW CLIENT HAS CONNECTED TO THE SERVER!
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1Connect(Thread: TWinshoeServerThread);
begin
   ListBox1.Items.Add('Connect: '+
      DateToStr(Date)+CHAR32+TimeToStr(Time));
{if login is required then send a different 200 number!}
   Thread.Connection.WriteLn('200 '+ServerID+' NNTP_Sample/1.0 ready. (posting ok)');
   Inc(NumberOfConnections);
   StatusBar1.SimpleText:='There are '+IntToStr(NumberOfConnections)+' connections...';
   Thread.SessionData:=UniqPerThread.Create;
   With Thread.SessionData as UniqPerThread do begin
      CurrentMessageNumber:=-1;
      CurrentNewsGroup:='';
      CurrentGroupPath:='';
      CurrentGroupLoMsg:=0;
      CurrentGroupHiMsg:=0;
      CurrentGroupAvail:=0;
   End;
end;

////////////////////////////////////////////////////////////////////////////////
// AN EXISTING CLIENT SESSION HAS DROPPED
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1Disconnect(
  Thread: TWinshoeServerThread);
begin
   ListBox1.Items.Add('Disconnect: '+
      DateToStr(Date)+CHAR32+TimeToStr(Time));
   Dec(NumberOfConnections);
   StatusBar1.SimpleText:='There are '+IntToStr(NumberOfConnections)+' connections...';
end;

////////////////////////////////////////////////////////////////////////////////
// APPLICATION STARTED, LOAD DEFAULT SETTINGS
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.FormShow(Sender: TObject);
Var
   IniFile:TIniFile;

begin
   IniFile:=TIniFile.Create(IniFilename);
   If IniFile.ReadInteger('SETUP','Groups',0)=0 then Begin
      With IniFile do Begin
         WriteInteger('SETUP','Groups',3);
         WriteInteger('SETUP','Port', WSPORT_NNTP);

         WriteString('GROUP1','Name','public.news.test');
         WriteString('GROUP1','Path',ExtractFilePath(Paramstr(0))+'public.news.test');
         ForceDirectories(ExtractFilePath(Paramstr(0))+'public.news.test');
         WriteString('GROUP1','Date','800101'); {1980/01/01}
         WriteString('GROUP1','Time','000000'); {midnight}

         WriteString('GROUP2','Name','public.news.announcements');
         WriteString('GROUP2','Path',ExtractFilePath(Paramstr(0))+'public.news.announcements');
         ForceDirectories(ExtractFilePath(Paramstr(0))+'public.news.announcements');
         WriteString('GROUP2','Date','800101'); {1980/01/01}
         WriteString('GROUP2','Time','000000'); {midnight}

         WriteString('GROUP3','Name','public.other.news');
         WriteString('GROUP3','Path',ExtractFilePath(Paramstr(0))+'public.other.news');
         ForceDirectories(ExtractFilePath(Paramstr(0))+'public.other.news');
         WriteString('GROUP3','Date','800101'); {1980/01/01}
         WriteString('GROUP3','Time','000000'); {midnight}
      End;
   End;
   With IniFile do Begin
      WinShoeNNTPListener1.Port:=ReadInteger('SETUP','Port', WSPORT_NNTP);
      NumberOfNewsGroups:=ReadInteger('SETUP','Groups',0);
      StatusBar1.SimpleText:='Server is supporting '+
         IntToStr(NumberOfNewsgroups)+' message area(s).';
   End;
   IniFile.Free;
end;

////////////////////////////////////////////////////////////////////////////////
// LIST Received - send a list of newsgroup names
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandList(
  Thread: TWinshoeServerThread; Parm: String);
Var
   Loop:Integer;
   IniFile:TInifile;

begin
   Form2.ListBox1.Items.Append('LIST ('+Parm+')');
   If Parm<>'' then Begin
      If lowercase(parm)='extensions' then Begin
         Thread.Connection.Writeln('202 Extensions supported:');
         Thread.Connection.Writeln('  OVER');
         Thread.Connection.Writeln('  HDR');
         Thread.Connection.Writeln('  PAT');
         Thread.Connection.Writeln('  LISTGROUP');
         Thread.Connection.Writeln('  DATE');
         Thread.Connection.Writeln('  AUTHINFO');
         Thread.Connection.Writeln('.');
         Exit;
      end;
   End;
   IniFile:=TIniFile.Create(IniFilename);
   Thread.Connection.Writeln('215 list of newsgroups follows');
   With IniFile do Begin
      For Loop:=1 to NumberOfNewsGroups do Begin
         Thread.Connection.WriteLn(
            lowercase(IniFile.ReadString('GROUP'+IntToStr(Loop),'Name',''))+CHAR32+
            SendListResponse(
               IniFile.ReadString('GROUP'+IntToStr(Loop),'Path','')));
      End;
   End;
   Thread.Connection.Writeln('.');
   IniFile.Free;
   StatusBar1.SimpleText:='List of Newsgroups requested...';
end;

////////////////////////////////////////////////////////////////////////////////
// GROUP Received - Select the Newsgroup
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandGroup(
  Thread: TWinshoeServerThread; Group: String);
Var
   IniFile:TIniFile;
   Loop:Integer;

begin
   Form2.ListBox1.Items.Append('GROUP ('+Group+')');
   If Group<>'' then Begin
      IniFile:=TIniFile.Create(IniFilename);
      With IniFile do Begin
         For Loop:=1 to NumberOfNewsGroups do Begin
            If lowercase(ReadString('GROUP'+IntToStr(Loop),'Name',''))=
               lowercase(group) then Begin
               Thread.Connection.Writeln(
                  SendGroupResponse(Thread,
                     ReadString('GROUP'+IntToStr(Loop),'Path',''),Group));
               StatusBar1.SimpleText:=Group+' selected.';
               IniFile.Free;
               Exit;
            End;
         End;
      End;
      IniFile.Free;
   End;
   Thread.Connection.Writeln('431 no such news group')
end;

////////////////////////////////////////////////////////////////////////////////
// LISTGROUP Received - Send a list of active message numbers
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandListgroup(
  Thread: TWinshoeServerThread; Parm: String);
Var
   Loop:Integer;
   IniFile:TInifile;

Procedure SendSortedArticleList(Path:String);
Var
   Err:Integer;
   SRec:TSearchRec;
   SortList:TStringList;

Begin
   SortList:=TStringList.Create;
   Err:=FindFirst(Path+'\*.HDR',faAnyFile,SRec);
   While Err=0 do Begin
try
      SortList.Add(IntToStr(StrToInt(Copy(SRec.Name,1,Pos('.',SRec.Name)-1))));
except
end;
      Err:=FindNext(SRec);
   End;
   FindClose(SRec);
   SortList.Sort;
   While SortList.Count>0 do Begin
      Thread.Connection.WriteLn(SortList[0]);
      SortList.Delete(0);
   End;
   SortList.Free;
End;

begin
   Form2.ListBox1.Items.Append('LISTGROUP ('+Parm+')');
   If Parm='' then Begin
      Parm:=UniqPerThread(Thread.SessionData).CurrentNewsGroup;
      If Parm='' then Begin
         Thread.Connection.Writeln('412 no newsgroup has been selected');
         Exit;
      End;
   End;
   Parm:=lowercase(parm);
   IniFile:=TIniFile.Create(IniFilename);
   Thread.Connection.Writeln('211 list of article numbers follows');
   With IniFile do Begin
      For Loop:=1 to NumberOfNewsGroups do Begin
         If lowercase(IniFile.ReadString('GROUP'+IntToStr(Loop),'Name',''))=
            Parm then Begin
            SendSortedArticleList(IniFile.ReadString('GROUP'+IntToStr(Loop),'Path',''));
            Break;
         End;
      End;
   End;
   Thread.Connection.Writeln('.');
   IniFile.Free;
   StatusBar1.SimpleText:='List of article in '+Parm;
end;

////////////////////////////////////////////////////////////////////////////////
// HEAD # Received - Send the appropriate Header
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandHeadNo(
  Thread: TWinshoeServerThread; ActualNumber: Integer);
Var
   Msg:TStringList;
   MsgID:String;

begin
   Form2.ListBox1.Items.Append('HEAD ('+IntToStr(ActualNumber)+')');
   If UniqPerThread(Thread.SessionData).CurrentGroupPath='' then Begin
      Thread.Connection.Writeln('412 no newsgroup has been selected');
      Exit;
   End;
   MsgID:=Pad10(ActualNumber);
   Msg:=TStringList.Create;
   Msg.LoadFromFile(UniqPerThread(Thread.SessionData).CurrentGroupPath+'\'+
      Pad10(ActualNumber)+'.HDR');
   MsgID:=lowercase(Msg.Values['Message-ID']);
   Thread.Connection.Writeln('221 '+IntToStr(ActualNumber)+CHAR32+
      MsgID+CHAR32+'head');
   While Msg.Count>0 do Begin
      Thread.Connection.Writeln(Msg.Names[0]+': '+Msg.Values[Msg.Names[0]]);
      Msg.Delete(0);
   End;
   Msg.Free;
   Thread.Connection.Writeln('.');
   StatusBar1.SimpleText:='Head Command issued for message #'+IntToStr(ActualNumber);
end;

////////////////////////////////////////////////////////////////////////////////
// BODY # Received - Send the appropriate body
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandBodyNo(
  Thread: TWinshoeServerThread; ActualNumber: Integer);
Var
   Msg:TStringList;
   MsgID:String;

begin
   Form2.ListBox1.Items.Append('BODY ('+IntToStr(ActualNumber)+')');
   If UniqPerThread(Thread.SessionData).CurrentGroupPath='' then Begin
      Thread.Connection.Writeln('412 no newsgroup has been selected');
      Exit;
   End;
   MsgID:=Pad10(ActualNumber);
   Msg:=TStringList.Create;
   Msg.LoadFromFile(UniqPerThread(Thread.SessionData).CurrentGroupPath+'\'+
      Pad10(ActualNumber)+'.HDR');
   MsgID:=lowercase(Msg.Values['Message-ID']);
   Msg.LoadFromFile(UniqPerThread(Thread.SessionData).CurrentGroupPath+'\'+
      Pad10(ActualNumber)+'.BDY');
   Thread.Connection.Writeln('222 '+IntToStr(ActualNumber)+CHAR32+
      MsgID+CHAR32+'head');
   While Msg.Count>0 do Begin
      Thread.Connection.Writeln(Msg[0]);
      Msg.Delete(0);
   End;
   Msg.Free;
   Thread.Connection.Writeln('.');
   StatusBar1.SimpleText:='Body Command issued for message #'+IntToStr(ActualNumber);
end;

////////////////////////////////////////////////////////////////////////////////
// ARTICLE # Received - Send the appropriate header and body
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandArticleNo(
  Thread: TWinshoeServerThread; ActualNumber: Integer);
Var
   Msg:TStringList;
   MsgID:String;

begin
   Form2.ListBox1.Items.Append('ARTICLE ('+IntToStr(ActualNumber)+')');
   If UniqPerThread(Thread.SessionData).CurrentGroupPath='' then Begin
      Thread.Connection.Writeln('412 no newsgroup has been selected');
      Exit;
   End;
   MsgID:=Pad10(ActualNumber);
   Msg:=TStringList.Create;
   Msg.LoadFromFile(UniqPerThread(Thread.SessionData).CurrentGroupPath+'\'+
      Pad10(ActualNumber)+'.HDR');
   MsgID:=lowercase(Msg.Values['Message-ID']);
   Thread.Connection.Writeln('220 '+IntToStr(ActualNumber)+CHAR32+
      MsgID+CHAR32+'head');
   While Msg.Count>0 do Begin
      Thread.Connection.Writeln(Msg.Names[0]+': '+Msg.Values[Msg.Names[0]]);
      Msg.Delete(0);
   End;
   Msg.LoadFromFile(UniqPerThread(Thread.SessionData).CurrentGroupPath+'\'+
      Pad10(ActualNumber)+'.BDY');
   Thread.Connection.Writeln(''); {end of header marker!}
   While Msg.Count>0 do Begin
      Thread.Connection.Writeln(Msg[0]);
      Msg.Delete(0);
   End;
   Msg.Free;
   Thread.Connection.Writeln('.');
   StatusBar1.SimpleText:='Article Command issued for message #'+IntToStr(ActualNumber);
end;

////////////////////////////////////////////////////////////////////////////////
// QUIT Received - Say Goodbye
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandQuit(
  Thread: TWinshoeServerThread);
begin
   Form2.ListBox1.Items.Append('QUIT');
   StatusBar1.SimpleText:='Connection terminated by user!';
   Thread.Connection.WriteLn('205 Goodbye');
end;

////////////////////////////////////////////////////////////////////////////////
// STAT # Received - Show the Status of the message
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandStatNo(
  Thread: TWinshoeServerThread; ActualNumber: Integer);
Var
   Msg:TStringList;
   Loop:Integer;
   Ws:String;
   MsgID:String;

begin
   Form2.ListBox1.Items.Append('STAT ('+IntToStr(ActualNumber)+')');
   If UniqPerThread(Thread.SessionData).CurrentGroupPath='' then Begin
      Thread.Connection.Writeln('412 no newsgroup has been selected');
      Exit;
   End;
   MsgID:=Pad10(ActualNumber);
   Msg:=TStringList.Create;
   Msg.LoadFromFile(UniqPerThread(Thread.SessionData).CurrentGroupPath+'\'+
      Pad10(ActualNumber)+'.HDR');
   For Loop:=1 to Msg.Count do Begin
      Ws:=Msg[Loop-1];
      Ws:=lowercase(Fetch(Ws,CHAR32));
      If Copy(Ws,1,10)='message-id' then Begin
         MsgID:=Ws;
         Break;
      End;
   End;
   Thread.Connection.Writeln('223 '+IntToStr(ActualNumber)+CHAR32+
      MsgID+CHAR32+'status');
   Msg.Free;
   //Thread.Connection.Writeln('.');
   StatusBar1.SimpleText:='Status Command issued for message #'+IntToStr(ActualNumber);
end;

////////////////////////////////////////////////////////////////////////////////
// HELP Received - Send a list of commands we support
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandHelp(
  Thread: TWinshoeServerThread);
begin
   Form2.ListBox1.Items.Append('HELP');
   With Thread.Connection do Begin
      Writeln('100 Legal commands');
      Writeln('  authinfo user Name|pass Password');
      Writeln('  article [MessageID|Number]');
      Writeln('  body [MessageID|Number]');
      Writeln('  date');
      Writeln('  group newsgroup');
      Writeln('  head [MessageID|Number]');
      Writeln('  help');
      Writeln('  ihave');
      Writeln('  last');
      Writeln('  list [active|xactive|newsgroups|distributions|overview.fmt|searches|searchable');
      Writeln('|srchfields|extensions|motd|prettynames|subscriptions]');
      Writeln('  listgroup newsgroup');
//      Writeln('  newgroups yymmdd hhmmss ["GMT"] [<distributions>]');
//      Writeln('  newnews newsgroups yymmdd hhmmss ["GMT"] [<distributions>]');
      Writeln('  next');
      Writeln('  post');
//      Writeln('  slave');
      Writeln('  stat [MessageID|Number]');
      Writeln('  xover [range]');
      Writeln('Report problems to <name@yourdomain.com>');
      Writeln('.');
   End;
end;

////////////////////////////////////////////////////////////////////////////////
// DATE Received - Send YYYYMMDDHHNNSS
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandDate(
  Thread: TWinshoeServerThread);
begin
   Form2.ListBox1.Items.Append('DATE');
   Thread.Connection.Writeln('111 '+
      FormatDateTime('yyyymmddhhnnss',Now));
end;

////////////////////////////////////////////////////////////////////////////////
// XOVER [RANGE] Received - Send the Tab Padded Overview
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandXOver(
  Thread: TWinshoeServerThread; Parm: String);
Var
   StartNo,StopNo:Integer;
   Loop:Integer;
   Msg:TStringList;
   SRec:TSearchRec;
   TmpInt:Integer;

begin
   Form2.ListBox1.Items.Append('XOVER ('+Parm+')');
   If UniqPerThread(Thread.SessionData).CurrentGroupPath='' then Begin
      Thread.Connection.Writeln('412 no newsgroup has been selected');
      Exit;
   End;
   If Pos('-',Parm)>0 then Begin
try
      StartNo:=StrToInt(Fetch(Parm,'-'));
except
      StartNo:=1;
end;
try
      StopNo:=StrToInt(Parm);
except
      StopNo:=StartNo;
end;
   End
   Else Begin
try
      StartNo:=StrToInt(Parm);
except
      StartNo:=1;
end;
      StopNo:=StartNo;
   End;
   Thread.Connection.Writeln('224 overview information follows');
   Msg:=TStringList.Create;
   For Loop:=StartNo to StopNo do Begin
      If FileExists(UniqPerThread(Thread.SessionData).CurrentGroupPath+
            '\'+Pad10(Loop)+'.HDR') then Begin
         Msg.LoadFromFile(UniqPerThread(Thread.SessionData).CurrentGroupPath+
            '\'+Pad10(Loop)+'.HDR');
         FindFirst(UniqPerThread(Thread.SessionData).CurrentGroupPath+
            '\'+Pad10(Loop)+'.HDR',faAnyFile,SRec);
         TmpInt:=SRec.Size;
         FindClose(SRec);
         FindFirst(UniqPerThread(Thread.SessionData).CurrentGroupPath+
            '\'+Pad10(Loop)+'.BDY',faAnyFile,SRec);
         TmpInt:=TmpInt+SRec.Size;
         FindClose(SRec);
         Thread.Connection.Writeln(
             IntToStr(Loop)+#9+
             Msg.Values['Subject']+#9+
             Msg.Values['From']+#9+
             Msg.Values['Date']+#9+
             Msg.Values['Message-ID']+#9+
             Msg.Values['References']+#9+
             IntToStr(TmpInt)+#9+
             Msg.Values['Lines']);
      End;
   End;
   Msg.Free;
   Thread.Connection.Writeln('.');
end;

////////////////////////////////////////////////////////////////////////////////
// NEXT Received - Move the counter to the next message #
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandNext(
  Thread: TWinshoeServerThread);
begin
   Form2.ListBox1.Items.Append('NEXT');
   If UniqPerThread(Thread.SessionData).CurrentGroupPath<>'' then Begin
      If UniqPerThread(Thread.SessionData).CurrentMessageNumber=
         UniqPerThread(Thread.SessionData).CurrentGroupHiMsg then
         Thread.Connection.Writeln('420 no current article has been selected')
      Else Begin
         UniqPerThread(Thread.SessionData).CurrentMessageNumber:=
            UniqPerThread(Thread.SessionData).CurrentMessageNumber+1;
         Thread.Connection.Writeln('223 '+
            IntToStr(UniqPerThread(Thread.SessionData).CurrentMessageNumber)+
            CHAR32+'<> article retreived');
      End;
   End
   Else Thread.Connection.Writeln('412 no news group selected');
end;

////////////////////////////////////////////////////////////////////////////////
// LAST Received - Move the counter to the last message #
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandLast(
  Thread: TWinshoeServerThread);
begin
   Form2.ListBox1.Items.Append('LAST');
   If UniqPerThread(Thread.SessionData).CurrentGroupPath<>'' then Begin
      UniqPerThread(Thread.SessionData).CurrentMessageNumber:=
         UniqPerThread(Thread.SessionData).CurrentMessageNumber+1;
      Thread.Connection.Writeln('223 '+
         IntToStr(UniqPerThread(Thread.SessionData).CurrentMessageNumber)+
         CHAR32+'<> article retreived');
   End
   Else Thread.Connection.Writeln('412 no news group selected');
end;

////////////////////////////////////////////////////////////////////////////////
// IHAVE Received - Accept the message if CurrentGroup is defined!
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandIHave(
  Thread: TWinshoeServerThread; ActualID: String);
Var
   Msg:TStringList;
   Body:TStringList;
   Newsgroups:String;
   S:String;
   Loop:Integer;
   IniFile:TIniFile;
   Path:String;
   CurrentGroupHiMsg:Integer;
   W1,W2,W3,W4:Word;
   Ws:String;

begin
   Form2.ListBox1.Items.Append('IHAVE ('+ActualID+')');
   Thread.Connection.Writeln('335 send article to be posted. End with <CR-LF>.<CR-LF>');
   Msg:=TStringList.Create;
   Thread.Connection.CaptureHeader(Msg,'');
   {should *NOT* be blank}
   {fields we add on the fly we have to add "=" to mimic capture!}
   If Msg.Values['Message-ID']='' then Begin
      DecodeDate(Now,W1,W2,W3);
      Ws:=IntToHex(W1,4)+IntToHex(W2,2)+IntToHex(W3,2);
      DecodeTime(Now,W1,W2,W3,W4);
      Ws:=Ws+IntToHex(W1,2)+IntToHex(W2,2)+IntToHex(W3,2)+IntToHex(W4,2);
      Msg.Insert(0,'Message-ID=<'+WS+'@'+ServerID+'>');
   End;
   If Msg.Values['Path']='' then
      Msg.Insert(0,'Path='+ServerID)
   Else {update it!}
   Newsgroups:=Msg.Values['Newsgroups'];
   If Newsgroups='' then Newsgroups:=
      UniqPerThread(Thread.SessionData).CurrentNewsGroup;
   If NewsGroups='' then Begin
      Thread.Connection.Writeln('437 article rejected - do not try again');
      Msg.Free;
      Exit;
   End;
   Body:=TStringList.Create;
   Thread.Connection.Capture(Body, ['.']);
   IniFile:=TIniFile.Create(IniFilename);
   Newsgroups:=Lowercase(Newsgroups)+',';
   S:=Fetch(Newsgroups,',');
   While S<>'' do Begin
      Path:='';
      For Loop:=1 to NumberOfNewsgroups do Begin
         With IniFile do Begin
            Path:=ReadString('GROUP'+IntToStr(Loop),'Name','');
            If lowercase(Path)=S then Begin
               Path:=ReadString('GROUP'+IntToStr(Loop),'Path','');
               Break
            End;
         End;
      End;
      If Path<>'' then Begin
         CurrentGroupHiMsg:=GetHighestMsgNumber(Path);
         Msg.SaveToFile(Path+'\'+Pad10(CurrentGroupHiMsg+1)+'.HDR');
         Body.SaveToFile(Path+'\'+Pad10(CurrentGroupHiMsg+1)+'.BDY');
      End;
      S:=Fetch(Newsgroups,',');
   End;
   Msg.Free;
   Body.Free;
   IniFile.Free;
   Thread.Connection.Writeln('235 article transferred ok');
end;

////////////////////////////////////////////////////////////////////////////////
// XHDR Received - Send the requested header field
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.WinshoeNNTPListener1CommandXHDR(
  Thread: TWinshoeServerThread; Parm: String);
Var
   Header:String;
   StartNo,StopNo:Integer;
   Msg:TStringList;
   Loop:Integer;

begin
   Form2.ListBox1.Items.Append('XHDR ('+Parm+')');
   If UniqPerThread(Thread.SessionData).CurrentGroupPath='' then Begin
      Thread.Connection.Writeln('412 no news group selected');
      Exit;
   End;
   Header:=lowercase(Fetch(Parm,CHAR32));
   If (Header<>'subject') and
      (Header<>'from') and
      (Header<>'date') and
      (Header<>'lines') and
      (Header<>'references') and
      (Header<>'message-id') then Begin
      Thread.Connection.Writeln('501 usage: xhdr header [range|message-id]');
      Exit;
   End;
   If Pos('-',Parm)>0 then Begin
try
      StartNo:=StrToInt(Fetch(Parm,'-'));
except
      StartNo:=1;
end;
try
      StopNo:=StrToInt(Parm);
except
      StopNo:=StartNo;
end;
   End
   Else Begin
try
      StartNo:=StrToInt(Parm);
except
      StartNo:=1;
end;
      StopNo:=StartNo;
   End;
   Thread.Connection.Writeln('221 '+Header+' follows');
   Msg:=TStringList.Create;
   For Loop:=StartNo to StopNo do Begin
      If FileExists(UniqPerThread(Thread.SessionData).CurrentGroupPath+
            '\'+Pad10(Loop)+'.HDR') then Begin
         Msg.LoadFromFile(UniqPerThread(Thread.SessionData).CurrentGroupPath+
            '\'+Pad10(Loop)+'.HDR');
         Thread.Connection.Writeln(IntToStr(Loop)+CHAR32+
            Msg.Values[Header]);
      End;
   End;
   Thread.Connection.Writeln('.');
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
   Form2.Show;
end;

procedure TForm1.WinshoeNNTPListener1CommandArticleID(
  Thread: TWinshoeServerThread; ActualID: String);
begin
   WinshoeNNTPListener1CommandArticleNo(Thread,UniqPerThread(Thread.SessionData).CurrentMessageNumber+1)
end;


procedure TForm1.WinshoeNNTPListener1CommandHeadID(
  Thread: TWinshoeServerThread; ActualID: String);
begin
   WinshoeNNTPListener1CommandHeadNo(Thread,UniqPerThread(Thread.SessionData).CurrentMessageNumber+1)
end;

procedure TForm1.WinshoeNNTPListener1CreateThread(
  pConnection: TWinshoeServer; var pThread: TWinshoeServerThread);
var
   s : String;
begin
   With pConnection do begin
        OnDebugWrite := DebugWriteWriter;
        OnDebugRead := DebugReadWriter
   end;
   s := 'c:\' + pConnection.PeerAddress + '.';
   s := s + IntToStr(pConnection.PeerPort);
   pConnection.SetDebugWriteFile(s);
   pConnection.SetDebugReadFile(s);
   pConnection.SetDebugMode(DEBUG_READ_DEBUG or DEBUG_WRITE_DEBUG);
end;

procedure TForm1.DebugWriteWriter(Sender: TWinshoeSocket);
var
   s : String;
   bWrite : Integer;
begin
     s := DateTimeToStr(Now) + ' ' + Sender.PeerAddress + ' ' +
       IntToStr(Sender.PeerPort) + ' Write' + #13 + #10;
     Sender.DoDebugOutput(Sender.DebugWriteHandle, s);
end;

procedure TForm1.DebugReadWriter(Sender: TWinshoeSocket);
var
   s : String;
   bWrite : Integer;
begin
     s := DateTimeToStr(Now) + ' ' + Sender.PeerAddress + ' ' +
       IntToStr(Sender.PeerPort) + ' Read' + #13 + #10;
     Sender.DoDebugOutput(Sender.DebugReadHandle, s);
end;

end.
