unit codermain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CoderWinshoeBinToASCII, Menus;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    ListBox1: TListBox;
    ListBox2: TListBox;
    PopupMenu1: TPopupMenu;
    popSave: TMenuItem;
    SaveDialog1: TSaveDialog;
    PopupMenu2: TPopupMenu;
    mnuSave: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure popSaveClick(Sender: TObject);
    procedure mnuSaveClick(Sender: TObject);
  private
    { Private declarations }
    Encoder1 : TWinshoeUUEncoder;
    Decoder1 : TWinshoeUUDecoder;
    procedure SaveListBox(ListBox: TListBox);
  public
    { Public declarations }
    procedure Output1(Sender: TComponent; const sOut: string);
    procedure Output2(Sender: TComponent; const sOut: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses GlobalWinshoe, //import CR & LF
     FileIO;

procedure TForm1.SaveListBox(ListBox : TListBox);
var
   FIO : TFIO;
   i : Integer;
begin
     //Save to file.
     if ListBox.Items.Count = 0 then Exit;
     if SaveDialog1.Execute then begin
        if FileExists(SaveDialog1.FileName) then begin
           Exit;
        end;
        FIO := TFIO.Create(Self);
        FIO.SetAccessMode(fioAPPEND_ACCESS);
        FIO.SetCreationStyle(fioOPEN_ALWAYS);
        FIO.SetFileName(SaveDialog1.FileName);
        for i := 0 to ListBox1.Items.Count -1 do begin
            FIO.WriteLn(ListBox1.Items[i]);
        end;
        FIO.CloseFile;
     end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   i : Integer;
begin
     ListBox1.Items.Clear;
     ListBox2.Items.Clear;

     // Initialise Coders
     Encoder1 := TWinshoeUUEncoder.Create(-1);
     Decoder1 := TWinshoeUUDecoder.Create(-1);

     // Organise the Output
     Encoder1.OnWrite := Output1;
     Decoder1.OnWrite := Output2;

     // Force the Encoder to output the table
     Encoder1.TableNeeded := True;

     for i := 0 to Memo1.Lines.Count - 1 do begin
         Encoder1.CodeString(memo1.Lines[i] + CR + LF);
     end;
     Encoder1.CompletedInput;

     for i := 0 to listBox1.Items.Count - 1 do begin
         Decoder1.CodeString(ListBox1.Items[i] + CR + LF);
     end;
     Decoder1.CompletedInput;

     Encoder1.Free;
     Decoder1.Free;
end;

procedure TForm1.Output1;
var
   s : String;
   i : Integer;
begin
     i := Pos(CR + LF, sOut);
     // Add the output, removing the trailing CR + LF
     if i > 1 then begin
        listBox1.Items.Add(Copy(sOut, 1, i - 1));
        s := Copy(sOut, i, length(sOut));
        if s = CR + LF then exit;
        Output2(Sender,  s);
     end else begin
         listBox1.Items.Add(sOut);
     end;
end;

procedure TForm1.Output2;
var
   s : String;
   i : Integer;
begin
     i := Pos(CR + LF, sOut);
     // Add the output, removing the trailing CR + LF
     if i > 1 then begin
        listBox2.Items.Add(Copy(sOut, 1, i - 1));
        s := Copy(sOut, Pos(CR + LF, sOut) + 2, length(sOut));
        if length(s) > 0 then begin
           Output2(Sender,  s);
        end;
     end else begin
         listBox2.Items.Add(sOut);
     end;
end;

procedure TForm1.popSaveClick(Sender: TObject);
begin
     SaveListBox(ListBox1);
end;

procedure TForm1.mnuSaveClick(Sender: TObject);
begin
     SaveListBox(ListBox2);
end;

end.
