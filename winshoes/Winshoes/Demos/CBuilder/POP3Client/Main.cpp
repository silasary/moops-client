/* This program demonstrates how to use TWinshoePOP3 component */
//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Pop3Winshoe"
#pragma link "WinshoeMessage"
#pragma link "Winshoes"
#pragma resource "*.dfm"
TfrmMain *frmMain;
//---------------------------------------------------------------------------
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::Exit1Click(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::About1Click(TObject *Sender)
{
  TAboutBox *About = new TAboutBox(this);
  About->ShowModal();
  delete About;
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::POP3Status(TComponent *Sender,
      const AnsiString sOut)
{
  // Whenever the status is changed, this event is fired
  StatusBar->SimpleText = sOut;
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::btnConnectClick(TObject *Sender)
{
  // Check if all the fields were filled (except Port if its blank, default - 110 will be used
  if(Server->Text == "" ||
     Username->Text == "" ||
     Password->Text == "")
       MessageDlg("Please fill all the fields.",mtError,TMsgDlgButtons()<<mbOK,0);
  else
  {
    POP3->Host = Server->Text;
    POP3->Port = Port->Text == "" ? 110:StrToInt(Port->Text);
    POP3->UserID = Username->Text;
    POP3->Password = Password->Text;
    try
    {
      POP3->Connect(); // lets connect to our mail server
      btnConnect->Enabled = false; //update GUI
      btnDisconnect->Enabled = true; //update GUI
      int Count = POP3->CheckMessages(); //this fucntion returns how many messages we have in our mailbox
      if(Count) //if we have anym essages, we should retrieve their headers(Subject,From,Date)
      {
        StatusBar->SimpleText = IntToStr(Count) + " Messages were found."; //it just updates status bar and displays how many headers were retrieved
        RetrieveMessageHeaders(Count); //this function retrieves headers and updates GUI, it takes 1 parameter - number of messages that are waiting
      }
      else
        MessageDlg("Your account is empty",mtInformation,TMsgDlgButtons()<<mbOK,0); //no messages were found on server
    }
    catch(EWinshoeException &Error)
    {
      ShowMessage("Error:" + Error.Message);
    }
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::RetrieveMessageHeaders(int Count)
{
  lvwHeaders->Items->Clear(); // Clear ListView
  for(int i = 1; i <= Count; i++) //Note: its from 1 to count
  {
    Msg->Clear(); //clear TWinshoeMessage this way we get rid of old content
    Msg->ExtractAttachments = true;
    POP3->RetrieveHeader(i,Msg); // this method retrieves header it takes 2 parameters: which message to retrieve  and where to store it(TWinshoeMessage)

    TListItem *Item = lvwHeaders->Items->Add(); //add item to listview
    Item->Caption = Msg->Subject;
    Item->SubItems->Add(Msg->From);
    Item->SubItems->Add(DateToStr(Msg->Date));
  }
  StatusBar->SimpleText = IntToStr(Count) + " headers retrieved.";
}
void __fastcall TfrmMain::btnDisconnectClick(TObject *Sender)
{
  try
  {
    btnConnect->Enabled = true;
    btnDisconnect->Enabled = false;
    btnRetrieve->Enabled = false;
    btnRemove->Enabled = false;
    POP3->Disconnect(); //just disconnects
  }
  catch(EWinshoeException &Error)
  {
    ShowMessage("Error Disconnecting:" + Error.Message);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::FormClose(TObject *Sender, TCloseAction &Action)
{
  // check if we are still connected, if so disconnect
  if(POP3->Connected())
  {
    try
    {
      POP3->Disconnect();
    }
    catch(EWinshoeException &Error)
    {
      ShowMessage("Error Disconnecting:" + Error.Message);
    }
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::lvwHeadersSelectItem(TObject *Sender,
      TListItem *Item, bool Selected)
{
  // we catch this event just for updating GUI
  bool State = POP3->Connected() ? Selected : false;

  btnRetrieve->Enabled = State;
  btnRemove->Enabled = State;
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::btnRemoveClick(TObject *Sender)
{
  try
  {
    int Index = lvwHeaders->Items->IndexOf(lvwHeaders->Selected);
    POP3->Delete(Index + 1); //this method deletes a message from the server. It takes 1 parameter: which message we want to delete
    lvwHeaders->Items->Delete(Index); //delete from listview
  }
  catch(EWinshoeException &Error)
  {
    ShowMessage("Failed to remove from server:" + Error.Message);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::btnRetrieveClick(TObject *Sender)
{
  Msg->Clear();
  frmMessage->lbAttachments->Items->Clear(); //we have to clear listbox cause we got only 1 instance of frmMessage so it may contain previous items
  frmMessage->btnSave->Enabled = false;
  try
  {
    int Index = lvwHeaders->Items->IndexOf(lvwHeaders->Selected);
    POP3->Retrieve(Index + 1,Msg); //this method retrieves message it takes 2 parameters: which message to retrieve and where to store it(TWinshoeMessage)
    frmMessage->From->Text = Msg->From;
    frmMessage->To->Text = Msg->Too->Text;
    frmMessage->CC->Text = Msg->CCList->Text;
    frmMessage->Subject->Text = Msg->Subject;
    frmMessage->Date->Text = DateToStr(Msg->Date);
    frmMessage->Body->Lines = Msg->Text;
    for(int i = 0; i < Msg->Attachments->Count; i++) //Msg->Attachments->Count represents how many attached files we got there
      frmMessage->lbAttachments->Items->Add(Msg->Attachments->Items[i]->Filename);
    frmMessage->ShowModal();
  }
  catch(EWinshoeException &Error)
  {
    ShowMessage("Error Retrieving Message:" + Error.Message);
  }
}
//---------------------------------------------------------------------------

