//---------------------------------------------------------------------------
#ifndef MainH
#define MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "serverwinshoe.hpp"
#include "ServerWinshoeHTTP.hpp"
#include "Winshoes.hpp"
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
  TMemo *Memo1;
  TWinshoeHTTPListener *HTTPServer;
  void __fastcall HTTPServerCommandGet(TWinshoeServerThread *Thread,
          THTTPRequestInfo *RequestInfo, THTTPResponseInfo *ResponseInfo);
private:	// User declarations
  AnsiString sDoc;
  HANDLE HUserToken;
  void __fastcall ServeFile(const AnsiString psFile,
                            THTTPResponseInfo *ResponseInfo,
                            TWinshoeServerThread *Thread);
public:		// User declarations
  __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
  