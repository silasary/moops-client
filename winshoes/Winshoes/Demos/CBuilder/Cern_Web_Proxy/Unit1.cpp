//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "Unit2.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "serverwinshoe"
#pragma link "ServerWinshoeHTTP"
#pragma link "Winshoes"
#pragma resource "*.dfm"
TForm1 *Form1;
/*---------------------------------------------------------------------------

This program is a CERN http proxy server. It accepts requests from web
browsers, extracts the command/host/document, connects to the host and
requests the document. It then sends any remaining headers. Since the
program doesn't bother with understanding any headers except for the
first one (containing host/document) it should work with all versions
of HTML and all browsers. It has been tested and works with Java,
Flash, images, forms, web based e-mail, etc. If you find any
problems, please e-mail me informing me (this code is part of some
software I wrote for an organization. :) )
Many thanks to Kudzu and his crew not only for the software, but for
all the tech support.

//--------------------------------------------------------------------------*/
__fastcall TForm1::TForm1(TComponent* Owner)
      : TForm(Owner)
{
  Server->Port=1500; Server->Active=true;
  Edit1->Text=Server->LocalAddress+": "+StrToInt(Server->Port);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ServerExecute(TWinshoeServerThread *Thread)
{
  TStringList *Dat; Dat = new TStringList;
  TWinshoeClient *Client; Client=new TWinshoeClient(NULL);
  AnsiString Data, Host, Command, Document, Outbound;

  Client->Port=80; Client->BufferChunk=8192;

// *********** Read incoming headers from browser
    do
      {
       Edit2->Text="Reading Headers";
       Outbound=Thread->Connection->ReadLn();
       Dat->Add(Outbound);
      } while (Thread->Connection->Readable(1)==true);

// *********** Extract host, document, command, etc.  from headers
    Edit2->Text="Extract Data";
    Data=Dat->Strings[0]; Dat->Delete(0);
    Extract(Data,Command,Host,Document);
    Dat->Insert(0,Command+" "+Document);  // host address needs to be removed from header
    Client->Host=Host;
    Edit2->Text="Connect to Host";
    Client->Connect();
    Edit2->Text="Write Headers";
    Client->WriteTStrings(Dat);

// *********** Transfer data, until there's no more to be transferred.
do

{
  if (Client->Readable(1)==true)
   {
     Edit2->Text="Receive";
     while (Client->Readable(1)==true)
      Thread->Connection->Write(Client->ReadBuffer());
   }

  if (Thread->Connection->Readable(1)==true)
   {
     Edit2->Text="Transmit";
     while (Thread->Connection->Readable(1)==true)
      Client->Write(Thread->Connection->ReadBuffer());
   }
} while ((Thread->Connection->Connected()==true)||(Client->Connected()==true));

  Client->Disconnect();

  delete Client;
  delete Dat;

}
//---------------------------------------------------------------------------

void __fastcall TForm1::Extract(AnsiString Data, AnsiString &Command, AnsiString &Host, AnsiString &Document)
{
 int index=1;
       // Extract Command
       do
         {
           if (Data[index]==' ') {Command=Data.SubString(0,index-1);}
           index++;
         } while (Data[index-1]!=' ');     // end do

     // Extract Host
     Host=Data.SubString(index+7,Data.Length());
     index=1;

     do {index++;} while (Host[index]!='/');   // end do

     // Extract Document
     Document=Host.SubString(index,Host.Length()-index+1);
     Host.SetLength(index-1);
}

//---------------------------------------------------------------------------


void __fastcall TForm1::Exit1Click(TObject *Sender)
{
  Close();        
}
//---------------------------------------------------------------------------

void __fastcall TForm1::About1Click(TObject *Sender)
{
  TForm2 *AboutForm = new TForm2(this);
  AboutForm->ShowModal();
  delete AboutForm;
}
//---------------------------------------------------------------------------

