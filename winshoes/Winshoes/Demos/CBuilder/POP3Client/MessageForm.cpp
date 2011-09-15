//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "MessageForm.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmMessage *frmMessage;
//---------------------------------------------------------------------------
__fastcall TfrmMessage::TfrmMessage(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmMessage::lbAttachmentsClick(TObject *Sender)
{
  if(lbAttachments->ItemIndex != -1)
    btnSave->Enabled = true;
  else
    btnSave->Enabled = false;
}
//---------------------------------------------------------------------------
void __fastcall TfrmMessage::btnSaveClick(TObject *Sender)
{
  SaveDialog->FileName = lbAttachments->Items->Strings[lbAttachments->ItemIndex];
  if(SaveDialog->Execute())
    frmMain->Msg->Attachments->Items[lbAttachments->ItemIndex]->SaveToFile(SaveDialog->FileName);
}
//---------------------------------------------------------------------------
