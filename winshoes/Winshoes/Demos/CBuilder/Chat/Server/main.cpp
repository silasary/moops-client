//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "serverwinshoe"
#pragma link "Winshoes"
#pragma resource "*.dfm"
TFormServer *FormServer;
//---------------------------------------------------------------------------
__fastcall TFormServer::TFormServer(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
/*	Broadcast will send any message that is received to all
		threads that are connected.  Pointers to these threads
		are contained in a TList
*/
void __fastcall TFormServer::Broadcast(AnsiString MsgToSend)
{
	int x;
	TList* ClientList;

	ClientList = Server->Threads->LockList();
	try
	{
		for(x = 0; x < ClientList->Count; x++)
			((TWinshoeServerThread*)ClientList->Items[x])->Connection->WriteLn(MsgToSend);
	}
	__finally
	{
		Server->Threads->UnlockList();
	}
}
//---------------------------------------------------------------------------
void __fastcall TFormServer::DecrementClientCount(void)
{
	LabelClients->Caption = IntToStr(StrToIntDef(LabelClients->Caption, 0) - 1);
}
//---------------------------------------------------------------------------
/*  FormCreate will activate the server and create/initialize any required
		variables
*/
void __fastcall TFormServer::FormCreate(TObject *Sender)
{
	StatusBar1->SimpleText = Server->LocalAddress + ":8088";
	if (OnlyOneThread == 0)
		OnlyOneThread = new TCriticalSection;
	Server->OnExecute = ServerExecute;
	Server->Active = True;
}
//---------------------------------------------------------------------------
void __fastcall TFormServer::IncrementClientCount(void)
{
	LabelClients->Caption = IntToStr( StrToInt(LabelClients->Caption)+1 );
}
//---------------------------------------------------------------------------
/*	ServerExecute is called when the server acquires a new
		connection.  Since the connection is a thread, unless we
		place it in a loop it would terminate after the first
		message is processed.  Once a message is received, the
		program enters a CRITICAL SECTION so that multiple thread
		will not cause a conflict.
*/
void __fastcall TFormServer::ServerExecute(TWinshoeServerThread *Thread)
{
	AnsiString Msg;

	Thread->Synchronize(IncrementClientCount);
	try
	{
		while (Thread->Connection->Connected())
		{
			Msg = Thread->Connection->ReadLn();
			OnlyOneThread->Enter();
			Broadcast(Msg);
			OnlyOneThread->Leave();
		}
	}
	__finally
	{
		Thread->Synchronize(DecrementClientCount);
	}
}
//---------------------------------------------------------------------------

