//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("Client.res");
USEFORM("main.cpp", FormClient);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
	try
	{
		Application->Initialize();
		Application->CreateForm(__classid(TFormClient), &FormClient);
		Application->Run();
	}
	catch (Exception &exception)
	{
		Application->ShowException(&exception);
	}
	return 0;
}
//---------------------------------------------------------------------------
