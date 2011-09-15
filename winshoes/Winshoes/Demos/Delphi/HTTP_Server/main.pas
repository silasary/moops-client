unit main;

{
Very basic implementation of a web server.

This demo is still being worked on - as of yet it will ALWAYS return
index.html - no matter what the request is.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Winshoes, serverwinshoe, StdCtrls, ServerWinshoeHTTP;

type
  TformMain = class(TForm)
    HTTPServer: TWinshoeHTTPListener;
    Memo1: TMemo;
    procedure HTTPServerCommandGet(Thread: TWinshoeServerThread;
      RequestInfo: THTTPRequestInfo; ResponseInfo: THTTPResponseInfo);
  private
  public
  end;

var
  formMain: TformMain;

implementation
{$R *.DFM}

uses
  EncodeWinshoe
  , GlobalWinshoe;

procedure TformMain.HTTPServerCommandGet(Thread: TWinshoeServerThread;
  RequestInfo: THTTPRequestInfo; ResponseInfo: THTTPResponseInfo);
var
  sDoc: string;
  HUserToken: THandle;

  procedure ServeFile(const psFile: string);
  var
    sData: string;
  begin
    if not FileExists(ExtractFilePath(Application.EXEName) + psFile) then begin
      ResponseInfo.ResponseNo := 404;
      exit;
    end;

    with TFileStream.Create(ExtractFilePath(Application.EXEName) + psFile, fmOpenRead) do try
      SetLength(sData, Size);
      ReadBuffer(sData[1], Size);
    finally free; end;

    // Replace variables
    sData := StringReplace(sData, '{%DATE%}', DateToStr(Date), [rfReplaceAll]);

    with ResponseInfo do begin
      ContentLength := Length(sData);
      WriteHeader;
    end;
    Thread.Connection.Write(sData);
  end;

begin
  //Event is in running in contect of thread

  try
    sDoc := RequestInfo.Document;
    if length(sDoc) = 0 then
      sDoc := 'index.html';
    if sDoc[Length(sDoc)] = '/' then
      sDoc := sDoc + 'index.html';

    if CompareText(Copy(sDoc, 1, 8), '/secure/') = 0 then begin
      if not RequestInfo.AuthExists then begin
        // Request
        ResponseInfo.AuthRealm := 'Webshoes_Secure';
      end else begin
        if not LogonUser(PChar(RequestInfo.AuthUsername), nil, PChar(RequestInfo.AuthPassword)
         , LOGON32_LOGON_NETWORK, LOGON32_PROVIDER_DEFAULT, HUserToken) then begin
          ResponseInfo.ResponseNo := 403
        end else begin
          try
            Win32Check(ImpersonateLoggedOnUser(HUserToken)); try
              ServeFile('secure\' + Copy(sDoc, 9, MaxInt));
            finally Win32Check(RevertToSelf); end;
          finally Win32Check(CloseHandle(HUserToken)); end;
        end;
      end;
    end else begin
      ServeFile('html\' + sDoc);
    end;
  except
    on E: Exception do begin
      ResponseInfo.ResponseNo := 500;
      ResponseInfo.ResponseText := E.Message;
    end;
  end;
end;

end.


