//---------------------------------------------------------------------------
#ifndef unitmainH
#define unitmainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "SMTPWinshoe.hpp"
#include "WinshoeMessage.hpp"
#include "Winshoes.hpp"
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
class TMainForm : public TForm
{
__published:	// IDE-managed Components
    TSplitter *Splitter2;
    TStatusBar *StatusBar;
    TPanel *Panel1;
    TMemo *MemoBody;
    TPanel *Panel2;
    TSplitter *Splitter1;
    TPanel *Panel3;
    TLabel *Label2;
    TLabel *Label4;
    TLabel *Label6;
    TLabel *Label5;
    TLabel *Label7;
    TEdit *EditTo;
    TEdit *EditSubject;
    TMemo *MemoCC;
    TMemo *MemoBCC;
    TEdit *EditAttachment;
    TButton *ButtonSelectFile;
    TButton *ButtonSend;
    TPanel *Panel4;
    TLabel *Label1;
    TMemo *MemoServerStatus;
    TOpenDialog *OpenDialogAttachment;
    TMainMenu *MainMenu;
    TMenuItem *MenuItemSetup;
    TWinshoeMessage *Msg;
    TWinshoeSMTP *SMTP;
    void __fastcall ButtonSendClick(TObject *Sender);
    void __fastcall ButtonSelectFileClick(TObject *Sender);
    void __fastcall SMTPWork(TComponent *Sender, const int lPos,
          const int lSize);
    void __fastcall MenuItemSetupClick(TObject *Sender);
    void __fastcall MenuItemNewMessageClick(TObject *Sender);
    void __fastcall SMTPStatus(TComponent *Sender, const AnsiString sOut);
    void __fastcall MenuItemExitClick(TObject *Sender);
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall MenuItemAboutClick(TObject *Sender);
private:	// User declarations
    String HostAddress;
    String EmailAddress;
    void __fastcall ReadRegistry();
    bool __fastcall SMTPValuesPopulated();
public:		// User declarations
    __fastcall TMainForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TMainForm *MainForm;
//---------------------------------------------------------------------------
#endif
 