unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Winshoes, serverwinshoe, MappedPortWinshoe, StdCtrls;

type
  TForm1 = class(TForm)
    Mapper: TWinshoeMappedPort;
    Memo1: TMemo;
  private
  public
  end;

var
  Form1: TForm1;

implementation
{$R *.DFM}

end.
