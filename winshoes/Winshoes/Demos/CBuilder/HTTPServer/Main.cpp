//---------------------------------------------------------------------------
// This is a copy of the Delphi HTTP_Server in de demos directory.
// It has exactly the same functionality, but is written in BCB 4.
// It is based on the Delphi HTTP_Server of June 1999.
//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "serverwinshoe"
#pragma link "ServerWinshoeHTTP"
#pragma link "Winshoes"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::HTTPServerCommandGet(TWinshoeServerThread *Thread,
      THTTPRequestInfo *RequestInfo, THTTPResponseInfo *ResponseInfo)
{
  try
  {
    sDoc = RequestInfo->Document;
    if(sDoc.Length() == 0) sDoc = "index.html";
    if(sDoc[sDoc.Length()] == '/') sDoc = sDoc + "index.html";
    if(CompareText(sDoc.SubString(1, 8), "/secure/") == 0)
    {
      if(!RequestInfo->AuthExists)
      {
        ResponseInfo->AuthRealm = "Webshoes_Secure";
      }
      else
      {
        if(!LogonUser(RequestInfo->AuthUsername.c_str(),
                      NULL, RequestInfo->AuthPassword.c_str(),
                      LOGON32_LOGON_NETWORK,
                      LOGON32_PROVIDER_DEFAULT, &HUserToken))
        {
          ResponseInfo->ResponseNo = 403;
        }
        else
        {
          try
          {
            Win32Check(ImpersonateLoggedOnUser(HUserToken));
            try
            {
              ServeFile("secure\\" + sDoc.SubString(9, MaxInt), ResponseInfo, Thread);
            }
            __finally
            {
              Win32Check(RevertToSelf());
            }
          }
          __finally
          {
            Win32Check(CloseHandle(HUserToken));
          }
        }
      }
    }
    else
    {
      ServeFile("html\\" + sDoc, ResponseInfo, Thread);
    }
  }
  catch(Exception &E)
  {
    ResponseInfo->ResponseNo = 500;
    ResponseInfo->ResponseText = E.Message;
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ServeFile(const AnsiString psFile,
                                  THTTPResponseInfo *ResponseInfo,
                                  TWinshoeServerThread *Thread)
{
  AnsiString sData;
  if(!FileExists(ExtractFilePath(Application->ExeName) + psFile))
  {
    ResponseInfo->ResponseNo = 404;
    exit;
  }

  TFileStream *FS;
  FS = new TFileStream(ExtractFilePath(Application->ExeName) + psFile, fmOpenRead);
  sData.SetLength(FS->Size);
  FS->ReadBuffer(sData.c_str(), FS->Size);
  delete FS;

  Sysutils::TReplaceFlags Flags;
  sData = StringReplace(sData, "{%DATE%}",
                        DateToStr(Date()),
                        Flags << Sysutils::rfReplaceAll);
                        
  ResponseInfo->ContentLength = sData.Length();
  ResponseInfo->WriteHeader();
  Thread->Connection->Write(sData);
}
//---------------------------------------------------------------------------
  