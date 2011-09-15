//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("Server.res");
USEFORM("main.cpp", FormServer);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
	try
	{
		Application->Initialize();
		Application->CreateForm(__classid(TFormServer), &FormServer);
		Application->Run();
	}
	catch (Exception &exception)
	{
		Application->ShowException(&exception);
	}
	return 0;
}
//---------------------------------------------------------------------------
