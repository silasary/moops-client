//---------------------------------------------------------------------------
#ifndef mainH
#define mainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Winshoes.hpp"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Graphics.hpp>
//---------------------------------------------------------------------------
class TFormClient : public TForm
{
__published:	// IDE-managed Components
	TSplitter *Splitter1;
	TGroupBox *GroupBox1;
	TImage *Image1;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TEdit *EditNick;
	TEdit *EditHost;
	TEdit *EditPort;
	TButton *ButtonConnect;
	TButton *ButtonDisconnect;
	TPanel *Panel3;
	TStatusBar *StatusBar1;
	TPanel *Panel1;
	TMemo *MemoIncomingMessages;
	TPanel *Panel2;
	TMemo *MemoSend;
	TWinshoeClient *Client;
	void __fastcall ButtonConnectClick(TObject *Sender);
	void __fastcall ButtonDisconnectClick(TObject *Sender);
	void __fastcall MemoSendKeyPress(TObject *Sender, char &Key);
	void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TFormClient(TComponent* Owner);
};

class TRecvThread : public Classes::TThread
{
private:
	AnsiString Msg;
	void __fastcall NewMail(void);

protected:
	virtual void __fastcall Execute(void);

public:
	__fastcall TRecvThread(bool CreateSuspended) : Classes::TThread(CreateSuspended) { }
	__fastcall virtual ~TRecvThread(void) { }

	__property ReturnValue;
	__property Terminated;

};

//---------------------------------------------------------------------------
extern PACKAGE TFormClient *FormClient;
extern PACKAGE TRecvThread* RecvThread;
extern PACKAGE bool ClientStatusFlag;
//---------------------------------------------------------------------------
#endif
