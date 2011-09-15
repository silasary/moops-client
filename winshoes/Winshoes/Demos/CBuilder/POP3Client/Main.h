//---------------------------------------------------------------------------
#ifndef MainH
#define MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Pop3Winshoe.hpp"
#include "WinshoeMessage.hpp"
#include "Winshoes.hpp"
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Menus.hpp>
#include "MessageForm.h"
#include "AboutForm.h"
//---------------------------------------------------------------------------
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
  TWinshoePOP3 *POP3;
  TWinshoeMessage *Msg;
  TPanel *Panel1;
  TListView *lvwHeaders;
  TMainMenu *MainMenu;
  TMenuItem *File1;
  TMenuItem *Exit1;
  TMenuItem *Help1;
  TMenuItem *About1;
  TEdit *Server;
  TEdit *Port;
  TEdit *Username;
  TEdit *Password;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label3;
  TLabel *Label4;
  TBevel *Bevel;
  TSpeedButton *btnConnect;
  TSpeedButton *btnDisconnect;
  TSpeedButton *btnRetrieve;
  TSpeedButton *btnRemove;
  TStatusBar *StatusBar;
  void __fastcall Exit1Click(TObject *Sender);
  void __fastcall About1Click(TObject *Sender);
  void __fastcall POP3Status(TComponent *Sender,
          const AnsiString sOut);
  void __fastcall btnConnectClick(TObject *Sender);
  void __fastcall btnDisconnectClick(TObject *Sender);
  void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
  void __fastcall lvwHeadersSelectItem(TObject *Sender, TListItem *Item,
          bool Selected);
  void __fastcall btnRemoveClick(TObject *Sender);
  void __fastcall btnRetrieveClick(TObject *Sender);
private:
    void __fastcall RetrieveMessageHeaders(int Count);	// User declarations
public:		// User declarations
  __fastcall TfrmMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMain *frmMain;
//---------------------------------------------------------------------------
#endif
