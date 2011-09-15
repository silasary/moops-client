//---------------------------------------------------------------------------
#ifndef unitaboutH
#define unitaboutH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TFormAbout : public TForm
{
__published:	// IDE-managed Components
    TPanel *Panel1;
    TLabel *Label1;
    TLabel *Label2;
    TLabel *Label3;
    TLabel *Label4;
    TImage *ImageDPower;
    TLabel *Label5;
    TLabel *Label6;
    TLabel *Label7;
    TButton *ButtonClose;
    void __fastcall ButtonCloseClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall TFormAbout(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFormAbout *FormAbout;
//---------------------------------------------------------------------------
#endif
