//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "unitsetup.h"
#include "unitmain.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFormSetup *FormSetup;
//---------------------------------------------------------------------------
__fastcall TFormSetup::TFormSetup(TComponent* Owner)
    : TForm(Owner)
{
 ReadRegistry();
}
//---------------------------------------------------------------------------
void __fastcall TFormSetup::ReadRegistry()
{
  TRegistry& regKey = *new TRegistry();
  bool keyGood = regKey.OpenKey("Software\\smtpdemos\\SETUP", false);
  if (keyGood)
  {
    EditServer->Text = regKey.ReadString("Server");
    EditAddress->Text = regKey.ReadString("Email");
  }
  else
  {
    EditServer->Text = "";
    EditAddress->Text = "";
  }
  delete &regKey;
}
//---------------------------------------------------------------------------
void __fastcall TFormSetup::WriteRegistry()
{
  TRegistry& regKey = *new TRegistry();
  regKey.OpenKey("Software\\smtpdemos\\SETUP", true);
  regKey.WriteString("Server", EditServer->Text);
  regKey.WriteString("Email", EditAddress->Text);
  delete &regKey;
}
//---------------------------------------------------------------------------
void __fastcall TFormSetup::FormCreate(TObject *Sender)
{
  ReadRegistry();
  initialEditServer = EditServer->Text;
  initialEditAddress = EditAddress->Text;
}
//---------------------------------------------------------------------------

void __fastcall TFormSetup::ButtonDoneClick(TObject *Sender)
{
// Do not write to Registry unless there is a change of information.
 if (EditServer->Text != initialEditServer ||
      EditAddress->Text != initialEditAddress)
    WriteRegistry();
  Close();
}
//---------------------------------------------------------------------------

 