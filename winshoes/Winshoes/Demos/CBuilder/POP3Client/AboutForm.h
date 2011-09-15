//----------------------------------------------------------------------------
#ifndef AboutFormH
#define AboutFormH
//----------------------------------------------------------------------------
#include <vcl\System.hpp>
#include <vcl\Windows.hpp>
#include <vcl\SysUtils.hpp>
#include <vcl\Classes.hpp>
#include <vcl\Graphics.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Buttons.hpp>
#include <vcl\ExtCtrls.hpp>
#include <shellapi.h>
//----------------------------------------------------------------------------
class TAboutBox : public TForm
{
__published:
	TPanel *Panel1;
	TImage *ProgramIcon;
	TLabel *ProductName;
	TLabel *Version;
  TLabel *Author;
	TLabel *Comments;
	TButton *OKButton;
  TLabel *AuthorName;
  void __fastcall AuthorNameClick(TObject *Sender);
private:
public:
	virtual __fastcall TAboutBox(TComponent* AOwner);
};
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
#endif
