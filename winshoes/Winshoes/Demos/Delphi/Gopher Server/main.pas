unit main;

interface

{
6 Oct 1999 Pete Mee
 - Added some Gopher+ functionality
3 Oct 1999 Pete Mee
 - Got basic implementation & some Gopher+ guess work
}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Winshoes, serverwinshoe, ServerWinshoeGopher, StdCtrls;

const
     ServerInfo = 'Winshoes Gopher Server, http://www.pbe.com/';
     TelnetInfo = 'Telnet : Example';
     TelnetUser = 'Anonymous';
     TelnetServer = '127.0.0.1';
     TelnetPort = 25;

     ImageExtensions : Array [0..6] of String =
       ('jpg',
        'jpe',
        'jpeg',
        'tif',
        'tiff',
        'bmp',
        'pcx');

     SoundExtensions : Array [0..2] of String =
       ('au',
        'wav',
        'mp3');

     MovieExtensions : Array [0..3] of string =
       ('avi',
        'mpg',
        'mpe',
        'mpeg');

     HTMLExtensions : Array [0..2] of string =
       ('htm',
        'html',
        'shtml');

type
  TGopher = class(TForm)
    WinshoeGopherListener1: TWinshoeGopherListener;
    lstMon: TListBox;
    procedure WinshoeGopherListener1Request(Thread: TWinshoeServerThread;
      Request: String);
    procedure FormCreate(Sender: TObject);
    procedure WinshoeGopherListener1RequestAllItems(
      Thread: TWinshoeServerThread; Request, LimitItems: String);
    procedure WinshoeGopherListener1RequestInformation(
      Thread: TWinshoeServerThread; Request, LimitItems: String);
    procedure WinshoeGopherListener1RequestPlus(
      Thread: TWinshoeServerThread; Request, Representative,
      DataFlag: String);
    procedure WinshoeGopherListener1RequestQuery(
      Thread: TWinshoeServerThread; Request, LimitItems: String);
  private
    { Private declarations }
    NumConnections : Integer;
    MaxConnections : Integer;
    DefaultAdmin : String;

    procedure SendDirectoryContents(Thread : TWinshoeServerThread;
      Dir : String; ExtraData : String);
    procedure SendTextFile(Thread : TWinshoeServerThread;
      FName : String; ExtraData : String);
    procedure SendFile(Thread : TWinshoeServerThread;
      FName : String; ExtraData : String);
  public
    { Public declarations }
  end;

var
  Gopher: TGopher;

implementation

{$R *.DFM}

uses StringsWinshoe, GlobalWinshoe, FileIO;

function DirectoryExists(Dir: String): Boolean;
var
  curDir: String;
begin
  //Quick & dirty programming.  Could be programmed neater using Delphi stuff
  //and faster using direct API calls - but I'm being lazy. ;-)

  //Grab current dir.
  GetDir(0, curDir);

  //Switch off file I/O checking
  {$I-}

  //Attempt to change
  ChDir(Dir);

  //Switch on file I/O checking
  {$I+}

  //Check the result
  if IOresult = 0
  then DirectoryExists := True
  else DirectoryExists := False;

  //Switch off file I/O checking in case the 'current' dir has been removed
  //during the above
  {$I-}

  //Change back
  ChDir(curDir);

  //Switch back to default
  {$I+}

  //Grab the result to free up the IOResult var.
  If IOResult = 0 then begin
  end;
end; { DirectoryExists }

procedure TGopher.SendDirectoryContents;
var
   sr : TWin32FindData;
   hnd : Integer;
   oldFile, str : String;
begin
     WinshoeGopherListener1.SendDirectoryEntryPlus(Thread,
       Item_Information, ServerInfo,
       ServerInfo,
       WinshoeGopherListener1.LocalAddress,
       WinshoeGopherListener1.Port, '+');
     WinshoeGopherListener1.SendDirectoryEntryPlus(Thread,
       Item_Telnet, TelnetInfo,
       TelnetUser,
       TelnetServer,
       TelnetPort, '+');
     hnd := FindFirstFile(PChar(AddBackslash(Dir) + '*.*'), sr);
     if hnd <> INVALID_HANDLE_VALUE then begin
        oldFile := '';
        repeat
              if sr.dwFileAttributes and faDirectory = faDirectory then begin
                 if sr.cFileName = String('.') then begin
                    //Ignore
                 end else if sr.cFileName = '..' then begin
                     If Thread.Connection.Connected then begin
                        str := ExtractFilePath(Dir);
                        str := Copy(str, 1, length(str) - 1);
                        WinshoeGopherListener1.SendDirectoryEntryPlus(Thread,
                          Item_Directory, '..', Str,
                          WinshoeGopherListener1.LocalAddress,
                          WinshoeGopherListener1.Port, '+');
                     end;
                 
                 end else begin
                     If Thread.Connection.Connected then begin
                        WinshoeGopherListener1.SendDirectoryEntryPlus(Thread,
                          Item_Directory, sr.cFileName,
                          AddBackslash(Dir) + sr.cFileName,
                          WinshoeGopherListener1.LocalAddress,
                          WinshoeGopherListener1.Port, '+');
                     end;
                 end;
              end else begin
                  If Thread.Connection.Connected then begin
                     str := LowerCase(ExtractFileExt(sr.cFileName));
                     if length(str) > 1 then begin
                        str := Copy(str, 2, length(str));
                     end;
                     if str = 'txt' then begin
                        WinshoeGopherListener1.SendDirectoryEntryPlus(Thread,
                          Item_Document, sr.cFileName,
                          AddBackslash(Dir) + sr.cFileName,
                          WinshoeGopherListener1.LocalAddress,
                          WinshoeGopherListener1.Port, '+');
                     end else if str = 'uue' then begin
                        WinshoeGopherListener1.SendDirectoryEntryPlus(Thread,
                          Item_UUE, sr.cFileName,
                          AddBackslash(Dir) + sr.cFileName,
                          WinshoeGopherListener1.LocalAddress,
                          WinshoeGopherListener1.Port, '+');
                     end else if str = 'gif' then begin
                        WinshoeGopherListener1.SendDirectoryEntryPlus(Thread,
                          Item_Gif, sr.cFileName,
                          AddBackslash(Dir) + sr.cFileName,
                          WinshoeGopherListener1.LocalAddress,
                          WinshoeGopherListener1.Port, '+');
                     end else if PosInStrArray(str, ImageExtensions) <> -1 then begin
                        WinshoeGopherListener1.SendDirectoryEntryPlus(Thread,
                          Item_Image, sr.cFileName,
                          AddBackslash(Dir) + sr.cFileName,
                          WinshoeGopherListener1.LocalAddress,
                          WinshoeGopherListener1.Port, '+');
                     end else if PosInStrArray(str, SoundExtensions) <> -1 then begin
                        WinshoeGopherListener1.SendDirectoryEntryPlus(Thread,
                          Item_Sound, sr.cFileName,
                          AddBackslash(Dir) + sr.cFileName,
                          WinshoeGopherListener1.LocalAddress,
                          WinshoeGopherListener1.Port, '+');
                     end else if PosInStrArray(str, MovieExtensions) <> -1 then begin
                        WinshoeGopherListener1.SendDirectoryEntryPlus(Thread,
                          Item_Movie, sr.cFileName,
                          AddBackslash(Dir) + sr.cFileName,
                          WinshoeGopherListener1.LocalAddress,
                          WinshoeGopherListener1.Port, '+');
                     end else if PosInStrArray(str, HTMLExtensions) <> -1 then begin
                        WinshoeGopherListener1.SendDirectoryEntryPlus(Thread,
                          Item_HTML, sr.cFileName,
                          AddBackslash(Dir) + sr.cFileName,
                          WinshoeGopherListener1.LocalAddress,
                          WinshoeGopherListener1.Port, '+');
                     end else begin
                         WinshoeGopherListener1.SendDirectoryEntryPlus(Thread,
                           Item_Binary, sr.cFileName,
                           AddBackslash(Dir) + sr.cFileName,
                           WinshoeGopherListener1.LocalAddress,
                           WinshoeGopherListener1.Port, '+');
                     end;
                  end;
              end;

              oldFile := sr.cFileName;
              FindNextFile(hnd, sr);

        until oldFile = sr.cFileName;
        Windows.CloseHandle(hnd);
     end;
     Thread.Connection.Writeln('.');
end;

procedure TGopher.WinshoeGopherListener1Request(
  Thread: TWinshoeServerThread; Request: String);
var
   str : String;
begin
     // This is a Gopher (not Gopher+) request

     If NumConnections >= MaxConnections then begin
        //Too many connections - write simple error msg & quit
        Thread.Connection.WriteLn('.');
        Thread.Connection.Disconnect;
        Exit;
     end;

     Inc(NumConnections);

     // Grab resource as specified by Request
     lstMon.Items.Add('Request: ' + Request);
     if Request = '' then begin
        SendDirectoryContents(Thread, 'C:\', '');
     end else if Request = ServerInfo then begin
         Thread.Connection.WriteLn('Winshoes Gopher Server v1.0.  Basic' +
           'Server written in a couple of hours by Peter Mee');
         Thread.Connection.WriteLn('For more information on the Open Source' +
           'Internet Suite, check out the Winshoes web site:');
         Thread.Connection.WriteLn('http://www.pbe.com');
         Thread.Connection.WriteLn('.');
     end else begin
         if DirectoryExists(Request) then begin
            SendDirectoryContents(Thread, Request, '');
         end else If FileExists(Request) then begin
             //Send the requested file
             str := LowerCase(ExtractFileExt(Request));
             If Length(str) > 1 then begin
                str := Copy(str, 2, length(str));
             end;
             if str = 'txt' then begin
                SendTextFile(Thread, Request, '');
                Thread.Connection.Write(Data_EndSign);
             end else begin
                 If not FileExists(Request) then begin
                    // Do not send anything - the .CRLF is later in the proc.
                 end else begin
                     SendFile(Thread, Request, '');
                 end;
             end;
         end else begin
             Thread.Connection.WriteLn('.');
         end;
     end;
     If Thread.Connection.Connected then begin
        try
           Thread.Connection.Disconnect;
        except
        end;
     end;
     Dec(NumConnections);
end;

procedure TGopher.SendTextFile;
var
   fio : TFIO;
   str : String;
   i : Integer;
begin
     fio := TFIO.Create(Self);
     fio.SetAccessMode(fioNO_ACCESS);
     fio.SetFileName(FName);
     fio.SetAccessMode(fioREAD_ACCESS);
     while not fio.EOF do begin
       str := fio.ReadLn;
       i := Pos('.' + CR + LF, str);
       while i > 0 do begin
         str := Copy(str, 1, i - 1) + '. ' + CR + LF +
           Copy(str, i + 4, length(str));
         i := Pos('.' + CR + LF, str);
       end;
       Thread.Connection.WriteLn(str);
     end;
end;

procedure TGopher.SendFile;
var
   fio : TFIO;
   s : String;
   i : Integer;
begin
     fio := TFIO.Create(Self);
     fio.SetAccessMode(fioNO_ACCESS);
     fio.SetFileName(FName);
     fio.SetAccessMode(fioREAD_ACCESS);
     SetLength(s, fio.BufferSize);
     while not fio.EOF do begin
       s := fio.ReadXBytesFromBuffer(fio.BufferSize, i);
       Thread.Connection.Write(s);
     end;
end;

procedure TGopher.FormCreate(Sender: TObject);
begin
     MaxConnections := 10;
     NumConnections := 0;
     DefaultAdmin := 'admin@sitename.com';
end;

procedure TGopher.WinshoeGopherListener1RequestAllItems(
  Thread: TWinshoeServerThread; Request, LimitItems: String);
begin
     lstMon.Items.Add('RequestAllItems: ' + Request);
     Thread.Connection.Disconnect;
end;

procedure TGopher.WinshoeGopherListener1RequestInformation(
  Thread: TWinshoeServerThread; Request, LimitItems: String);
begin
     lstMon.Items.Add('RequestInformation: ' + Request);
     Thread.Connection.Disconnect;
end;

procedure TGopher.WinshoeGopherListener1RequestPlus(
  Thread: TWinshoeServerThread; Request, Representative, DataFlag: String);
begin
     lstMon.Items.Add('RequestPlus: ' + Request);
     SendDirectoryContents(Thread, 'C:\', '');
     Thread.Connection.Disconnect;
end;

procedure TGopher.WinshoeGopherListener1RequestQuery(
  Thread: TWinshoeServerThread; Request, LimitItems: String);
begin
     lstMon.Items.Add('RequestQuery: ' + Request);
     Thread.Connection.Disconnect;
end;

end.
