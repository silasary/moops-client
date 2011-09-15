//---------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "AboutForm.h"
//---------------------------------------------------------------------
#pragma resource "*.dfm"

//--------------------------------------------------------------------- 
__fastcall TAboutBox::TAboutBox(TComponent* AOwner)
	: TForm(AOwner)
{
}
//---------------------------------------------------------------------
void __fastcall TAboutBox::AuthorNameClick(TObject *Sender)
{
  ShellExecute(NULL,"open","mailto:tsumbush@hotmail.com",NULL,NULL,SW_NORMAL);
}
//---------------------------------------------------------------------------

