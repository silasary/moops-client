unit RootMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus;

type
  TformRootMain = class(TForm)
    MainMenu: TMainMenu;
    mitmHelp: TMenuItem;
    mitmReadMe: TMenuItem;
    N7: TMenuItem;
    mitmWeb: TMenuItem;
    mitmProductNews: TMenuItem;
    mitmFaqs: TMenuItem;
    mitmSupport: TMenuItem;
    N8: TMenuItem;
    mitmFeedback: TMenuItem;
    N6: TMenuItem;
    mitmAbout: TMenuItem;
    mitmFile: TMenuItem;
    mitmExit: TMenuItem;
    N9: TMenuItem;
    procedure mitmAboutClick(Sender: TObject);
    procedure mitmHelpClick(Sender: TObject);
    procedure WebClick(Sender: TObject);
    procedure mitmExitClick(Sender: TObject);
  private
    FAboutTitle: string;
    FAboutAuthor: string;
    FAboutAddress: string;
    FReadmeFile: string;
  public
    constructor Create(AOwner: TComponent); override;
    property AboutTitle: string read FAboutTitle write FAboutTitle;
    property AboutAuthor: string read FAboutAuthor write FAboutAuthor;
    property AboutAddress: string read FAboutAddress write FAboutAddress;
  end;

implementation

uses
  DemoUtils, AboutForm;

{$R *.DFM}

constructor TformRootMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FReadmeFile := ExtractFilePath(Application.ExeName) + '\readme.txt';
end;

procedure TformRootMain.mitmAboutClick(Sender: TObject);
begin
  with TformAbout.Create(Application) do begin
    try
      lablTitle.Caption := AboutTitle;
      lablAuthorName.Caption := AboutAuthor;
      lablAuthorAddress.Caption := AboutAddress;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TformRootMain.WebClick(Sender: TObject);
begin
  if Sender = mitmReadMe then
    OpenPrim(FReadmeFile)
  else if Sender = mitmProductNews then
    OpenPrim('http://www.pbe.com/winshoes/')
  else if Sender = mitmFaqs then
    OpenPrim('http://www.pbe.com/winshoes/')
  else if Sender = mitmSupport then
    OpenPrim('http://www.pbe.com/Winshoes/Documentation/TechSupport.html')
  else if Sender = mitmFeedback then
    MailTo(AboutAddress, AboutTitle);
end;

procedure TformRootMain.mitmHelpClick(Sender: TObject);
begin
  mitmAbout.Caption := '&About ' + AboutTitle + '...';
  mitmReadme.Enabled := FileExists(FReadmeFile);
end;

procedure TformRootMain.mitmExitClick(Sender: TObject);
begin
  Close;
end;

end.
