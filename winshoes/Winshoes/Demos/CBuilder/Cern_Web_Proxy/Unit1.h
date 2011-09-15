//---------------------------------------------------------------------------
#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "serverwinshoe.hpp"
#include "ServerWinshoeHTTP.hpp"
#include "Winshoes.hpp"
#include "simphttp.hpp"
#include "WinInetControl.hpp"
#include <Menus.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TWinshoeHTTPListener *Server;
        TEdit *Edit1;
        TLabel *Label1;
        TMainMenu *MainMenu1;
        TMenuItem *File1;
        TMenuItem *Help1;
        TMenuItem *Exit1;
        TMenuItem *About1;
        TEdit *Edit2;
        TLabel *Label2;
        void __fastcall ServerExecute(TWinshoeServerThread *Thread);
        void __fastcall Exit1Click(TObject *Sender);
        void __fastcall About1Click(TObject *Sender);
private:	// User declarations
        void __fastcall Extract(AnsiString Data, AnsiString &Command, AnsiString &Host, AnsiString &Document);
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
