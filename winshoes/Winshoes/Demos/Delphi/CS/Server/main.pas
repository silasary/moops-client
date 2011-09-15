unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Winshoes, serverwinshoe, StdCtrls;

type
  TForm1 = class(TForm)
    WinshoeListener1: TWinshoeListener;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure WinshoeListener1Execute(Thread: TWinshoeServerThread);
  private
  public
  end;

var
  Form1: TForm1;

implementation
{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  WinshoeListener1.Active := True;
end;

procedure TForm1.WinshoeListener1Execute(Thread: TWinshoeServerThread);
var
  s: string;
begin
  // This is not thread safe
  with listbox1.items do begin
    Add('Connect');
    repeat
      s := Thread.Connection.ReadLn;
      Add(s);
    until s = 'EXIT';
    Thread.Connection.Disconnect;
    Add('Disconnect');
  end;
end;

end.
