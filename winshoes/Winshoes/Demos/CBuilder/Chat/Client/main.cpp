//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Winshoes"
#pragma resource "*.dfm"
TFormClient *FormClient;
TRecvThread *RecvThread;
bool ClientStatusFlag;
//---------------------------------------------------------------------------
__fastcall TFormClient::TFormClient(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
/*	Connects to a Server and creates the Thread that will receive incoming
		messages
*/
void __fastcall TFormClient::ButtonConnectClick(TObject *Sender)
{
	try
	{
		Client->Host = EditHost->Text;
		Client->Port = StrToInt(EditPort->Text);
		Client->Connect();
		Client->WriteLn("Welcome To: " + EditNick->Text);
		RecvThread = new TRecvThread(false);
		ClientStatusFlag = true;
		EditNick->ReadOnly = true;
		EditHost->ReadOnly = true;
		EditPort->ReadOnly = true;
	}
	__finally
	{
	}
}
//---------------------------------------------------------------------------
/*	Disconnects from server and Terminates the receive thread
*/
void __fastcall TFormClient::ButtonDisconnectClick(TObject *Sender)
{
	if (ClientStatusFlag)
	{
		Client->WriteLn("So Long From: " + EditNick->Text);
		EditNick->ReadOnly = false;
		EditHost->ReadOnly = false;
		EditPort->ReadOnly = false;
		ClientStatusFlag = false;
		RecvThread->Terminate();
		do
		{
			Application->ProcessMessages();
		} while (!RecvThread->Terminated);
		Client->Disconnect();
		MemoIncomingMessages->Lines->Add("Disconnected");
	}
}
//---------------------------------------------------------------------------
/*	when the users presses enter, it will send each line in the
		outgoing memo box to the server
*/
void __fastcall TFormClient::MemoSendKeyPress(TObject *Sender, char &Key)
{
	if (Key == '\r')
	{
		while ( MemoSend->Lines->Count > 0 )
		{
			try
			{
				Client->WriteLn(EditNick->Text + ": " + MemoSend->Lines->Strings[0]);
				MemoSend->Lines->Delete(0);
				Key = '\0';
				MemoSend->Lines->Clear();
			}
			catch(...)
			{
				MemoSend->Lines->Clear();
			}
		}
	}
}
//---------------------------------------------------------------------------
/*	this thread will loop until the Terminate method is called
		elsewhere in the program.  The synchronize method is used
		because errors will occur if a thread tries to directly update
		a vcl component
*/
void __fastcall TRecvThread::Execute(void)
{
	while (!RecvThread->Terminated)
	{
		try
		{
			Msg = FormClient->Client->ReadLn();
			Synchronize(NewMail);
		}
		catch (...)
		{
			RecvThread->Terminate();
		}
	}
}
//---------------------------------------------------------------------------
void __fastcall TRecvThread::NewMail(void)
{
	FormClient->MemoIncomingMessages->Lines->Add(Msg);
}
//---------------------------------------------------------------------------
void __fastcall TFormClient::FormClose(TObject *Sender,
			TCloseAction &Action)
{
	ButtonDisconnect->Click();
	Action = caFree;
}
//---------------------------------------------------------------------------
void __fastcall TFormClient::FormCreate(TObject *Sender)
{
	EditNick->ReadOnly = false;
	EditHost->ReadOnly = false;
	EditPort->ReadOnly = false;
	ClientStatusFlag = false;
}
//---------------------------------------------------------------------------
