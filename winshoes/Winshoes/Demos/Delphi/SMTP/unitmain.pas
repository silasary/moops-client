unit Unitmain;

interface

uses
  UnitAbout,
  UnitSetup,
  Windows, Messages, IniFiles,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SMTPWinshoe, ComCtrls, winshoes, Menus, ExtCtrls, WinshoeMessage;

type
  TFormMain = class(TForm)
    StatusBar: TStatusBar;
    SMTP: TWinshoeSMTP;
    OpenDialogAttachment: TOpenDialog;
    MainMenu: TMainMenu;
    MenuFile: TMenuItem;
    MenuItemSetup: TMenuItem;
    N1: TMenuItem;
    MenuItemExit: TMenuItem;
    MenuItemAbout: TMenuItem;
    MenuItemNewMessage: TMenuItem;
    Panel1: TPanel;
    MemoBody: TMemo;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Splitter1: TSplitter;
    Label2: TLabel;
    EditSubject: TEdit;
    Label4: TLabel;
    Label6: TLabel;
    MemoCC: TMemo;
    MemoBCC: TMemo;
    EditAttachment: TEdit;
    Label5: TLabel;
    ButtonSelectFile: TButton;
    Label7: TLabel;
    Splitter2: TSplitter;
    ButtonSend: TButton;
    MemoServerStatus: TMemo;
    Label1: TLabel;
    Msg: TWinshoeMessage;
    MemoTo: TMemo;
    procedure ButtonSendClick(Sender: TObject);
    procedure ButtonSelectFileClick(Sender: TObject);
    procedure SMTPWork(Sender: TComponent; const lPos, lSize: Integer);
    procedure MenuItemAboutClick(Sender: TObject);
    procedure MenuItemSetupClick(Sender: TObject);
    procedure MenuItemNewMessageClick(Sender: TObject);
    procedure SMTPStatus(Sender: TComponent; const sOut: String);
    procedure MenuItemExitClick(Sender: TObject);
  private
    HostAddress : String;
    EmailAddress : String;
    //
    procedure ReadIniFile;
  public
	end;

var
  FormMain: TFormMain;
  FormAbout : TFormAbout;

implementation
{$R *.DFM}

uses
  SenderThread;

procedure TFormMain.ButtonSendClick(Sender: TObject);

  function EmailAndHostAreValid : Boolean;
  begin
    ReadIniFile;
    if (( Length(HostAddress) > 0 ) and
        ( Length(EmailAddress) > 0 ))
      then
        Result := True
      else
        Result := False;
  end;

  procedure PopulateSMTPValues;
  begin
    SMTP.Host := HostAddress;
    with Msg do begin
      Attachments.Clear;
      CCList :=  MemoCC.Lines;
      BCCList := MemoBCC.Lines;
      Too := MemoTo.Lines;
      From := EmailAddress;
      Subject := EditSubject.Text;
      Text := MemoBody.Lines;
      if FileExists(EditAttachment.Text) then
        Attachments.AddAttachment(EditAttachment.Text);
    end;
  end;

begin
  if EmailAndHostAreValid then begin
    PopulateSMTPValues;
    with TSenderThread.Create(True) do begin
      FreeOnTerminate := True;
      SMTP := Self.SMTP;
      Msg := Self.Msg;
      Resume;
    end;
  end else
    ShowMessage('Use File : Setup to set your server parameters first.');
end;

procedure TFormMain.ButtonSelectFileClick(Sender: TObject);
begin
  if OpenDialogAttachment.Execute
    then
      EditAttachment.Text := OpenDialogAttachment.FileName;
end;

procedure TFormMain.SMTPWork(Sender: TComponent; const lPos,
  lSize: Integer);
begin
  Caption := 'Sending: ' + IntToStr(lPos) + ' of ' + IntToStr(lSize);
end;

procedure TFormMain.MenuItemAboutClick(Sender: TObject);
begin
  FormAbout := TFormAbout.Create(self);
  FormAbout.ShowModal;
end;

procedure TFormMain.MenuItemSetupClick(Sender: TObject);
begin
  FormSetup := TFormSetup.Create(self);
  FormSetup.ShowModal;
end;

procedure TFormMain.MenuItemNewMessageClick(Sender: TObject);
begin
  MemoTo.Clear;
  EditSubject.Text := '';
  MemoCC.Lines.Clear;
  MemoBCC.Lines.Clear;
  EditAttachment.Text := '';
  MemoBody.Lines.Clear;
  MemoServerStatus.Lines.Clear;
  StatusBar.SimpleText := '';
end;

procedure TFormMain.ReadInifile;
begin
  with TIniFile.Create(ChangeFileExt(Application.EXEName, '.ini')) do try
    HostAddress:= ReadString('SETUP','Server','');
    EMailAddress := ReadString('SETUP','Email','your.address@goes.here');
  finally Free; end;
end;

procedure TFormMain.SMTPStatus(Sender: TComponent; const sOut: String);
begin
  MemoServerStatus.Lines.Add(sOut);
end;

procedure TFormMain.MenuItemExitClick(Sender: TObject);
begin
  Close;
end;

end.
