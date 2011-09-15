// Title            : smtpdemo
// Author           : Richard Hunkler
// Release Date     : 5/19/1999
// CBuilder         : 3
// Description      : A minimal mail client for sending mail
// WinShoes Version :
//    v7.035B -  Initial release
//
//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEFORM("unitabout.cpp", FormAbout);
USEFORM("unitmain.cpp", MainForm);
USEFORM("unitsetup.cpp", FormSetup);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TMainForm), &MainForm);
        Application->CreateForm(__classid(TFormAbout), &FormAbout);
        Application->CreateForm(__classid(TFormSetup), &FormSetup);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
