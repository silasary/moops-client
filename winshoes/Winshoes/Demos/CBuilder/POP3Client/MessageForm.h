//---------------------------------------------------------------------------
#ifndef MessageFormH
#define MessageFormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <Dialogs.hpp>
#include "main.h"
//---------------------------------------------------------------------------
class TfrmMessage : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TLabel *Label1;
  TEdit *Subject;
  TLabel *Label4;
  TLabel *Label3;
  TLabel *Label2;
  TEdit *From;
  TEdit *To;
  TEdit *CC;
  TMemo *Body;
  TLabel *Label5;
  TEdit *Date;
  TLabel *Label6;
  TListBox *lbAttachments;
  TSaveDialog *SaveDialog;
  TButton *btnSave;
  void __fastcall lbAttachmentsClick(TObject *Sender);
  void __fastcall btnSaveClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
  __fastcall TfrmMessage(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMessage *frmMessage;
//---------------------------------------------------------------------------
#endif
