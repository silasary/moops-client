//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("POP3Demo.res");
USEFORM("Main.cpp", frmMain);
USEFORM("AboutForm.cpp", AboutBox);
USEFORM("MessageForm.cpp", frmMessage);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
  try
  {
     Application->Initialize();
     Application->CreateForm(__classid(TfrmMain), &frmMain);
     Application->CreateForm(__classid(TfrmMessage), &frmMessage);
     Application->Run();
  }
  catch (Exception &exception)
  {
     Application->ShowException(&exception);
  }
  return 0;
}
//---------------------------------------------------------------------------
