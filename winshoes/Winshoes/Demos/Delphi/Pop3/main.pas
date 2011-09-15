// TITLE:       Pop3 Demo for Winshoes Pop3 Component
// DATE:        8-JULY-1999
// AUTHOR:      Hadi Hariri
// UNIT NAME:   main.pas
// FORM NAME:   fmMAIN
// UTILITY:     Demonstrate the user of POP3 component from Winshoes package
unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, WinshoeMessage, Winshoes, Pop3Winshoe, Buttons, ExtCtrls, Grids,
  ComCtrls, fileio;

type
  TfmMAIN = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    POP: TWinshoePOP3;
    Label3: TLabel;
    Label4: TLabel;
    edSERVER: TEdit;
    edACCOUNT: TEdit;
    edPORT: TEdit;
    edPASSWORD: TEdit;
    Panel1: TPanel;
    btCONNECT: TSpeedButton;
    btDISCONNECT: TSpeedButton;
    btDELETE: TSpeedButton;
    btRETRIEVE: TSpeedButton;
    sgHEADERS: TStringGrid;
    StatusBar1: TStatusBar;
    Msg: TWinshoeMessage;
    procedure FormCreate(Sender: TObject);
    procedure btCONNECTClick(Sender: TObject);
    procedure POPStatus(Sender: TComponent; const sOut: String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btDISCONNECTClick(Sender: TObject);
    procedure btDELETEClick(Sender: TObject);
    procedure btRETRIEVEClick(Sender: TObject);
  private
    { Private declarations }
    procedure RetrievePOPHeaders;
    procedure ToggleButtons(boolConnected: boolean);
  public
    { Public declarations }
  end;

var
  fmMAIN: TfmMAIN;

implementation

uses msg;

{$R *.DFM}

//////////////////////////////////////////////////////////////////
// PROCEDURE: Toggle the buttons depending on the status
//////////////////////////////////////////////////////////////////
procedure TfmMAIN.ToggleButtons(boolConnected: boolean);
begin
	btCONNECT.Enabled := not boolConnected ;
    btDISCONNECT.Enabled := boolConnected ;
    btDELETE.Enabled := boolConnected ;
    btRETRIEVE.Enabled := boolConnected ;
end;

//////////////////////////////////////////////////////////////////
// EVENT: On Form Create
//////////////////////////////////////////////////////////////////
procedure TfmMAIN.FormCreate(Sender: TObject);
begin
    // Set the titles for the string grid
    sgHEADERS.Cells [ 0,0 ] := 'Subject';
    sgHEADERS.Cells [ 1,0 ] := 'From';
    sgHEADERS.Cells [ 2,0 ] := 'Date';
    sgHEADERS.Cells [ 3,0 ] := 'Size (bytes)';
    sgHEADERS.Cells [ 4,0 ] := '';

    Statusbar1.SimpleText := 'Not connected';

    ToggleButtons ( False );
end;

//////////////////////////////////////////////////////////////////
// EVENT: On CONNECT click
//////////////////////////////////////////////////////////////////
procedure TfmMAIN.btCONNECTClick(Sender: TObject);
begin
    // Check to see params are filled in.
    if  (edSERVER.Text = '') or
        (edACCOUNT.Text = '') or
        (edPASSWORD.Text = '') then
        MessageDlg('Configuration missing',mtError,[mbOk],0)
    else
        begin
            // Set the settings in POP3
            POP.Host := edSERVER.Text ;
            if (edPORT.Text = '') then
                POP.Port := 110
            else
                POP.Port := StrToInt(edPORT.Text);
            POP.UserID := edACCOUNT.Text ;
            POP.Password := edPASSWORD.Text ;
            POP.Connect ;
            if POP.Connected then
				begin
					ToggleButtons ( True );
	                // Retrieve headers
	                // Check to see if there are messages
	                if POP.CheckMessages > 0 then
	                    RetrievePOPHeaders
	                else
	                    MessageDlg('No messages on server',mtInformation,[mbOk],0);
                end ;
        end ;
end;

//////////////////////////////////////////////////////////////////
// EVENT: on POP status change
//////////////////////////////////////////////////////////////////
procedure TfmMAIN.POPStatus(Sender: TComponent; const sOut: String);
begin
    Statusbar1.SimpleText := sOut ;
end;
//////////////////////////////////////////////////////////////////
// PROCEDURE: Retrieves the message headers
//////////////////////////////////////////////////////////////////
procedure TfmMAIN.RetrievePOPHeaders;
var
    intIndex: integer ;
begin


    sgHEADERS.RowCount := POP.CheckMessages + 1;
    for intIndex := 1 to POP.CheckMessages do
        begin
            // Clear the message properties
            Msg.Clear ;

            // Retrieve message
            Msg.ExtractAttachments := True ;
            POP.RetrieveHeader( intIndex, Msg ) ;
            // Add info to string grid
            sgHEADERS.Cells [ 0, intIndex ] := Msg.Subject ;
            sgHEADERS.Cells [ 1, intIndex ] := Msg.From ;
            sgHEADERS.Cells [ 2, intIndex ] := DateToStr (Msg.Date) ;
            sgHEADERS.Cells [ 3, intIndex ] := IntToStr(POP.RetrieveSize(intIndex) div 8);
            sgHEADERS.Cells [ 4, intIndex ] := '';
        end ;

end;

//////////////////////////////////////////////////////////////////
// EVENT: On Close
//////////////////////////////////////////////////////////////////
procedure TfmMAIN.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{    if POP.Connected then
        POP.Disconnect ;
}end;

//////////////////////////////////////////////////////////////////
// EVENT: On DISCONNECT click
//////////////////////////////////////////////////////////////////
procedure TfmMAIN.btDISCONNECTClick(Sender: TObject);
begin
    if POP.Connected then
        POP.Disconnect ;
    ToggleButtons ( False );
end;

//////////////////////////////////////////////////////////////////
// EVENT: On DELETE button click
//////////////////////////////////////////////////////////////////
procedure TfmMAIN.btDELETEClick(Sender: TObject);
begin
    POP.Delete ( sgHEADERS.Row ) ;
    sgHEADERS.Cells [ 4 , sgHEADERS.Row ] := ' * ' ;
end;

procedure TfmMAIN.btRETRIEVEClick(Sender: TObject);
var
    intIndex: integer ;
begin
    Msg.Clear ;
    fmMESSAGE.meBODY.Clear ;
    fmMESSAGE.lbATTACH.Clear ;

    POP.Retrieve ( sgHEADERS.Row , Msg ) ;


		fmMESSAGE.Edit1.Text := Msg.From ;
    fmMESSAGE.Edit2.Text := Msg.Too.Text ;
    fmMESSAGE.Edit3.Text := Msg.CCList.Text ;
    fmMESSAGE.Edit4.Text := Msg.Subject ;
    fmMESSAGE.meBODY.Lines.Assign(Msg.Text);



    for intIndex := 0 to Msg.Attachments.Count - 1 do
    	fmMESSAGE.lbATTACH.Items.Add ( Msg.Attachments.Items[intIndex].Filename ) ;

    fmMESSAGE.ShowModal;
end;


end.
