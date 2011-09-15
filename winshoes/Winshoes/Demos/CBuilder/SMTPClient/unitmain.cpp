//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "unitmain.h"
#include "unitsetup.h"
#include "unitabout.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "SMTPWinshoe"
#pragma link "WinshoeMessage"
#pragma link "Winshoes"
#pragma resource "*.dfm"
TMainForm *MainForm;
//---------------------------------------------------------------------------
__fastcall TMainForm::TMainForm(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::FormCreate(TObject *Sender)
{
  MenuItemNewMessageClick(this);

}
//---------------------------------------------------------------------------
void __fastcall TMainForm::ReadRegistry()
{
  TRegistry& regKey = *new TRegistry();
  bool keyGood = regKey.OpenKey("Software\\smtpdemos\\SETUP", false);
  if (keyGood)
  {
    HostAddress = regKey.ReadString("Server");
    EmailAddress = regKey.ReadString("Email");
  }
  else
  {
    HostAddress = "";
    EmailAddress = "";
  }
  delete &regKey;

}
//---------------------------------------------------------------------------
bool __fastcall TMainForm::SMTPValuesPopulated()
{
   SMTP->Host = HostAddress;

   Msg->Attachments->Clear();
   Msg->CCList->Assign(MemoCC->Lines);
   Msg->BCCList->Assign(MemoBCC->Lines);
   Msg->Too->Add(EditTo->Text.Trim());
   Msg->From = EmailAddress;
   Msg->Subject = EditSubject->Text;
   Msg->Text = MemoBody->Lines;
   if (FileExists(EditAttachment->Text))
     Msg->Attachments->AddAttachment(EditAttachment->Text);

   if (EditTo->Text != "" && MemoBody->Lines->Count != 0)
     return(true);
   else
     return(false);
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::ButtonSendClick(TObject *Sender)
{
  ReadRegistry();
  if ( HostAddress.Length() > 0 && EmailAddress.Length() > 0 )
  {
    if (SMTPValuesPopulated())
    {
      SMTP->Send(Msg);
      MemoServerStatus->Lines->Add("Message to " + EditTo->Text +
                                 " has been sent");
    }
    else
      ShowMessage("Must have a To address and a message.");
  }
  else
    ShowMessage("Use File/Setup to set your server parameters first.");
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::ButtonSelectFileClick(TObject *Sender)
{
  if (OpenDialogAttachment->Execute())
    EditAttachment->Text = OpenDialogAttachment->FileName;
}
//---------------------------------------------------------------------------

void __fastcall TMainForm::SMTPWork(TComponent *Sender, const int lPos,
      const int lSize)
{
  Caption = "Sending: " + IntToStr(lPos) + " of " + IntToStr(lSize);    
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::MenuItemSetupClick(TObject *Sender)
{
  TFormSetup *FormSetup = new TFormSetup(this);
  FormSetup->ShowModal();
  delete FormSetup;
}
//---------------------------------------------------------------------------

void __fastcall TMainForm::MenuItemNewMessageClick(TObject *Sender)
{
  EditTo->Text = "";
  EditSubject->Text = "";
  MemoCC->Lines->Clear();
  MemoBCC->Lines->Clear();
  EditAttachment->Text = "";
  MemoBody->Lines->Clear();
  MemoServerStatus->Lines->Clear();
  StatusBar->SimpleText = "";
}
//---------------------------------------------------------------------------

void __fastcall TMainForm::SMTPStatus(TComponent *Sender,
      const AnsiString sOut)
{
  MemoServerStatus->Lines->Add(sOut);  
}
//---------------------------------------------------------------------------

void __fastcall TMainForm::MenuItemExitClick(TObject *Sender)
{
  Close();    
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::MenuItemAboutClick(TObject *Sender)
{
  TFormAbout *AboutForm = new TFormAbout(this);
  AboutForm->ShowModal();
  delete AboutForm;
}
//---------------------------------------------------------------------------

 