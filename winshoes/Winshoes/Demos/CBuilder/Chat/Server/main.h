//---------------------------------------------------------------------------
#ifndef mainH
#define mainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "serverwinshoe.hpp"
#include "Winshoes.hpp"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <syncobjs.hpp>
#include <Graphics.hpp>
//---------------------------------------------------------------------------
class TFormServer : public TForm
{
__published:	// IDE-managed Components
	TStatusBar *StatusBar1;
	TImage *Image1;
	TPanel *Panel2;
	TLabel *Label1;
	TLabel *LabelClients;
	TWinshoeListener *Server;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall ServerExecute(TWinshoeServerThread *Thread);
private:	// User declarations
	TCriticalSection *OnlyOneThread;
	void __fastcall Broadcast(AnsiString MsgToSend) ;
	void __fastcall DecrementClientCount(void);
	void __fastcall IncrementClientCount(void);
public:		// User declarations
	__fastcall TFormServer(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFormServer *FormServer;
//---------------------------------------------------------------------------
#endif
