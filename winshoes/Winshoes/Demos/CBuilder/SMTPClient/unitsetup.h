//---------------------------------------------------------------------------
#ifndef unitsetupH
#define unitsetupH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Registry.hpp>
//---------------------------------------------------------------------------
class TFormSetup : public TForm
{
__published:	// IDE-managed Components
    TPanel *Panel1;
    TLabel *Label1;
    TLabel *Label2;
    TEdit *EditServer;
    TEdit *EditAddress;
    TButton *ButtonDone;
    TStatusBar *StatusBar;
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall ButtonDoneClick(TObject *Sender);
private:	// User declarations
    String initialEditServer;
    String initialEditAddress;
    void __fastcall ReadRegistry();
    void __fastcall WriteRegistry();
public:		// User declarations
    __fastcall TFormSetup(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFormSetup *FormSetup;
//---------------------------------------------------------------------------
#endif
 