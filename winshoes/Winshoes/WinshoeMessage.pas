unit WinshoeMessage;

interface

uses
  Classes
  , EncodeWinshoe
  , Winshoes;

Const
  WinshoeMessageHeaderNames: array [0..6] of String =
   ('From'
   , 'Organization'
   , 'References'
   , 'Reply-To'
   , 'Subject'
   , 'To'         // 5
   , 'Message-ID' // 6
   );

Type
  TOnGetAttachmentStream = procedure(pstrm: TStream) of object;
  TOnGetInLineImageStream = procedure(pstrm: TStream) of object; // Satvinder Basra 2/12/1999 Added to deal with inline images

  // The structure for TWinshoeMessage changes a bit.
  // However, some properties will be kept for backward compatibility.

  // ADDED:
  //
  // property TMessageParts: contains all the different part of a MIME message (excluding attachments)
  //
  //
  // carry on commenting once you finish.

  // CHANGES:
  //
  // When using TWinshoeMessage for POP3, the TEXT property will be empty. This is substituted with
  // the MessageParts property

  ///////////////////////////////////////////

  TMessagePart = class(TCollectionItem)
  private
    fslstText:TStrings; // the actual text of the corresponding message part
    fsContentTransfer,
    fsContentType: string; // identifies the content-type encoding of the message

  public
    property ContentType: string read fsContentType write fsContentType;
    property ContentTransfer: string read fsContentTransfer write fsContentTransfer;
    property Text: TStrings read fslstText write fslstText;
    constructor Create(Collection: TCollection); override ;
    destructor Destroy; override;
  end ;


  TMessageParts = class(TCollection)
  private
    function GetItem(Index: Integer): TMessagePart;
    procedure SetItem(Index: Integer; const Value:TMessagePart);
  public
    function Add: TMessagePart;
    procedure AddMessagePart(const psContentType,psContentTransfer:string; slstText:TStrings);
    property Items[Index: Integer]: TMessagePart read GetItem write SetItem;
  end ;

  ////////////////////////////////////////////


  TAttachment = class(TCollectionItem)
  private
    fslstHeaders: TStrings;
    fsFilename, fsStoredPathname: String;
    fOnGetAttachmentStream: TOnGetAttachmentStream;
    //
    procedure SetStoredPathname(const Value: String);
  public
    property Filename: string read fsFilename write fsFilename;
    property Headers: TStrings read fslstHeaders;
    property OnGetAttachmentStream: TOnGetAttachmentStream read fOnGetAttachmentStream
     write fOnGetAttachmentStream;
    property StoredPathname: String read fsStoredPathname write SetStoredPathname;
    //
    // SaveToFile
    // This method will save the attachment to the specified filename.
    function SaveToFile( strFileName: string):boolean;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  end;

  TAttachments = class(TCollection)
  private
    function GetItem(Index: Integer): TAttachment;
    procedure SetItem(Index: Integer; const Value: TAttachment);
  public
    function Add: TAttachment;
    procedure AddAttachment(const psPathname: string);
    property Items[Index: Integer]: TAttachment read GetItem write SetItem; default;
  end;

// Satvinder Basra 2/12/1999 Added to deal with inline images
  TInLineImage = class(TCollectionItem)
  private
    fslstHeaders: TStrings;
    fsFilename, fsStoredPathname: String;
    fOnGetInLineImageStream: TOnGetInLineImageStream;
    //
    procedure SetStoredPathname(const Value: String);
  public
    property Filename: string read fsFilename write fsFilename;
    property Headers: TStrings read fslstHeaders;
    property OnGetInLineImageStream: TOnGetInLineImageStream read fOnGetInLineImageStream
     write fOnGetInLineImageStream;
    property StoredPathname: String read fsStoredPathname write SetStoredPathname;
    //
    // SaveToFile
    // This method will save the attachment to the specified filename.
    function SaveToFile( strFileName: string):boolean;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  end;

  TInLineImages = class(TCollection)
  private
    function GetItem(Index: Integer): TInLineImage;
    procedure SetItem(Index: Integer; const Value: TInLineImage);
  public
    function Add: TInLineImage;
    procedure AddInLineImage(const psPathname: string);
    property Items[Index: Integer]: TInLineImage read GetItem write SetItem; default;
  end;

  TWinshoeMessage = class(TComponent)
  private
    fbExtractAttachments, fbUseNowForDate: Boolean;
    fiMsgNo: Integer;
    fsContentType: string;
    FsDefaultDomain: string;
    fAttachments: TAttachments;
    fInLineImages : TInLineImages; // Satvinder Basra 2/12/1999 Added to deal with inline images

    // added for MessageParts
    fMessageParts: TMessageParts;

    fbNoDecode:boolean;
    FslstToo,
    FslstCCList, FslstBCCList, fslstHeaders, fslstText, fslstNewsgroups: TStrings;
    //
    procedure SetBCCList(Value: TStrings);
    procedure SetCCList(Value: TStrings);
    procedure SetText(slst: TStrings);
    procedure SetHeaders(Value: TStrings);
    procedure SetNewsgroups(Value: TStrings);
    //function GetNewsgroups: TStrings;

    //function GetCCList: TStrings;
    procedure SetToo(Value: TStrings);
    //function GetToo:TStrings;
  protected
    procedure SetHeaderDate(const Value: TDateTime);
    procedure SetHeaderString(const piIndex: Integer; const Value: String);
    function GetHeaderDate: TDateTime;
    function GetHeaderString(const piIndex: Integer): string;
  public
    procedure Clear; virtual;
    procedure ClearBody;
    procedure ClearHeader;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class procedure FromArpa(const sFull: string; var sAddr, sReal: string);
    {Given a Full address, this will seperate the Address from the Descriptive and return in the
    2nd and 3rd parameters. If no Real exists, Real will be the same as Addr}
    class function ExtractAddr(const sFull: string): string;
    {Returns just the address from a full address}
    class function ExtractReal(const sFull: string): string;
    {Returns just the descriptive portion of a full address}
    {TODO Fix to use Streaming - also will allow to make changes and remain compatible}
    procedure LoadFromFile(const sFileName: String);
    procedure SaveToFile(const sFileName: String);
    procedure SetDynamicHeaders;
    class function StrInternetToDateTime(s1: string): TDateTime;
    {Attempts to convert a text internet representation of a date to a TDatetime. Is about 85% successful}
    class function ToArpa(const sAddress, sReal: string): string;
    {Given an address and a descriptive portion, a full address is returned}
    class procedure ValidateAddr(const psAddr, psField: String);
    //
    property Attachments: TAttachments read fAttachments;
    property InLineImages: TInLineImages read fInLineImages;
    // Satvinder Basra 2/12/1999 Added to deal with inline images
    property MessageParts: TMessageParts read fMessageParts ;
  published
    // NOTE: There is no GetBCCList since when a message is sent
    // The Bcc list does not show.
    property BCCList: TStrings read FslstBCCList write SetBCCList;
    property CCList: TStrings read fslstCCList write SetCCList;
    {}property DefaultDomain: String read FsDefaultDomain write FsDefaultDomain;
		// Contains the default domain to be used for adressees who do not have one
    property ExtractAttachments: Boolean read fbExtractAttachments write fbExtractAttachments
     default True;
    property Headers: TStrings read FslstHeaders write SetHeaders;
    property MsgNo: Integer read fiMsgNo write fiMsgNo;
    property Text: TStrings read fslstText write SetText;
    property UseNowForDate: Boolean read fbUseNowForDate write fbUseNowForDate default True;

    // Linked to Headers
    property ContentType: string read fsContentType write fsContentType;
    property Date: TDateTime read GetHeaderDate write SetHeaderDate;
    property Newsgroups: TStrings read fslstNewsgroups write SetNewsgroups;
    //
    property From: string index 0 read GetHeaderString write SetHeaderString;
    property Organization: string index 1 read GetHeaderString write SetHeaderString;
    property MsgID: string index 6 read GetHeaderString write SetHeaderString;
    property References: string index 2 read GetHeaderString write SetHeaderString;
    property ReplyTo: string index 3 read GetHeaderString write SetHeaderString;
    property Subject: string index 4 read GetHeaderString write SetHeaderString;

    property Too: TStrings read fslstToo write SetToo;
    property NoDecode: boolean read fbNoDecode write fbNoDEcode default False;
  end;

  TWinshoeMessageClient = class(TWinshoeClient)
  private
    fsXProgram: String;
  protected
  public
    procedure ReceiveHeader(pMsg: TWinshoeMessage; const psDelim: string); virtual;
    procedure ReceiveBody(pMsg: TWinshoeMessage); virtual;
    procedure Send(pMsg: TWinshoeMessage); virtual;
    procedure WriteHeader(const psHeader, psValue: String);
    procedure WriteMessage(pslst: TStrings);
  published
    property XProgram: string read fsXProgram write fsXProgram;
  end;

//Procs
  procedure Register;


const
  MultiPartBoundary = '=_NextPart_2rfksadvnqw3nerasdf';
  MultiPartAlternativeBoundary = '=_NextPart_2altrfksadvnqw3nerasdf';
  MultiPartRelatedBoundary = '=_NextPart_2relrfksadvnqw3nerasdf';

implementation


Uses GlobalWinshoe, StringsWinshoe, SystemWinshoe, SysUtils, Windows;

procedure Register;
begin
  RegisterComponents('Winshoes Misc', [TWinshoeMessage]);
end;

procedure TWinshoeMessageClient.WriteHeader(const psHeader, psValue: String);
begin
  if length(psValue) > 0 then
    WriteLn(psHeader + ': ' + psValue);
end;

procedure TWinshoeMessage.SetNewsgroups;
begin
  fslstNewsgroups.Assign(Value);
end;

procedure TWinshoeMessage.SetCCList;
begin
  fslstCCList.Assign(Value);
end;

procedure TWinshoeMessage.SetBCCList;
begin
  FslstBCCList.Assign(Value);
end;

class procedure TWinshoeMessage.ValidateAddr;
begin
  if Length(ExtractAddr(psAddr)) = 0 then
    raise Exception.Create(psField + ' not specified.');
end;

class function TWinshoeMessage.ToArpa;
begin
  if (length(sReal) > 0) and (Uppercase(sAddress) <> sReal) then
    Result := sReal + ' <' + sAddress + '>'
  else
    Result := sAddress;
end;

class function TWinshoeMessage.ExtractReal;
begin
  FromArpa(sFull, sVoid, Result);
end;

class function TWinshoeMessage.ExtractAddr;
begin
  FromArpa(sFull, Result, sVoid);
end;

procedure TWinshoeMessage.SetText;
begin
  FslstText.Assign(slst);
end;

procedure TWinshoeMessage.SetHeaders;
begin
  FslstHeaders.Assign(Value);
end;

class procedure TWinshoeMessage.FromArpa(const sFull: string; var sAddr, sReal: string);
var iPos: Integer;
begin
  sAddr  := ''; sReal  := '';
  if Copy(sFull, Length(sFull) , 1) = '>' then
  begin
    iPos := Pos('<', sFull);
    if iPos > 0 then
    begin
      sAddr := Trim(Copy(sFull, iPos + 1, Length(sFull) - iPos - 1));
      sReal := Trim(Copy(sFull, 1, iPos - 1));
    end;
  end else if Copy(sFull, Length(sFull), 1) = ')' then
    begin
      iPos := Pos('(', sFull);
      if iPos > 0 then
      begin
        sReal := Trim(Copy(sFull, iPos + 1, Length(sFull) - iPos - 1));
        sAddr := Trim(Copy(sFull, 1, iPos - 1));
      end;
    end else begin
      sAddr := sFull;
    end;

  while length(sReal) > 1 do
  begin
    if (sReal[1] = '"') and (sReal[Length(sReal)] = '"') then
        sReal := Copy(sReal, 2, Length(sReal) - 2)
    else if (sReal[1] = '''') and (sReal[Length(sReal)] = '''') then
        sReal := Copy(sReal, 2, Length(sReal) - 2)
    else
      break;
  end;

  if Length(sReal) = 0 then
    sReal := sAddr;
end;

class function TWinshoeMessage.StrInternetToDateTime(s1: string): TDateTime;
var i1: Integer;
    wDt, wMo, wYr, wHo, wMin, wSec: Word;
begin
  result := 0.0;
  s1 := Trim(s1);
  if length(s1) = 0 then
    exit;

  try
    if StrToDay(Copy(s1, 1, 3)) > 0 then
      Delete(s1, 1, 5);

    if IsNumeric(s1[2]) then
    begin
      wDt := StrToIntDef(Copy(s1, 1, 2), 1);
      i1 := 4;
    end else begin
      wDt := StrToIntDef(Copy(s1, 1, 1), 1);
      i1 := 3;
    end;

    wMo := StrToMonth(Copy(s1, i1, 3));
    if wMo = 0 then
      wMo := 1;

    if (i1 + 6 > Length(s1)) or (s1[i1 + 6] = ' ') then
      wYr := StrToIntDef(Copy(s1, i1 + 4, 2), 1900)
    else
      wYr := StrToIntDef(Copy(s1, i1 + 4, 4), 1900);

    if wYr < 80 then Inc(wYr, 2000)
    else if wYr < 100 then Inc(wYr, 1900);

    Result := EncodeDate(wYr, wMo, wDt);
    i1 := Pos(':',s1);
    // added this
    if i1 > 0 then begin
      wHo := StrToInt(Copy(s1,i1-2,2));
      wMin := StrToInt(Copy(s1,i1+1,2));
      wSec := StrToInt(Copy(s1,i1+4,2));
      result := result + EncodeTime(wHo,wMin,wSec,0);
    end;
  except
    Result := 0.0;
  end;
end;

constructor TWinshoeMessage.Create;
begin
  inherited;
  fbExtractAttachments := True;
  fbUseNowForDate := True;
  fsContentType := 'text/plain';
  fAttachments := TAttachments.Create(TAttachment);
  fInLineImages := TInLineImages.create(TInLineImage); // Satvinder Basra 2/12/1999 Added to deal with inline images
  //
  fMessageParts := TMessageParts.Create(TMessagePart);
  fslstBCCList := TStringList.Create;
  fslstCCList := TStringList.Create;
  fslstHeaders := TStringList.Create;
  fslstText := TStringList.Create;
  fslstNewsgroups := TStringList.Create;
  fslstToo := TStringList.Create ;
  fbNoDecode := false ;
end;

procedure TWinshoeMessageClient.Send;
var i: integer;
    encd: TWinshoeEncoder;
begin
  if pMsg.Attachments.Count > 0 then
  begin
    if (pMsg.InLineImages.Count >0) and (pMsg.Attachments.Count >0) then
    begin
      WriteLn('This is a multi-part message in MIME format.');
      WriteLn('');
      WriteLn('--' + MultiPartRelatedBoundary);
      WriteLn('Content-Type: multipart/related; ');
      WriteLn('        boundary="' + MultiPartAlternativeBoundary +'"');
      WriteLn('        type: multipart/alternative; ');
      WriteLn('');
      WriteLn('--' + MultiPartAlternativeBoundary);
      WriteLn('Content-Type: multipart/alternative; ');
      WriteLn('        boundary="' + MultiPartBoundary +'"');
      WriteLn('');
    end
    else
    begin
      if (pMsg.InLineImages.Count >0) or (pMsg.Attachments.Count >0) then
      begin
        WriteLn('This is a multi-part message in MIME format.');
        WriteLn('');
        WriteLn('--' + MultiPartAlternativeBoundary);
        WriteLn('Content-Type: multipart/alternative; ');
        WriteLn('        boundary="' + MultiPartBoundary +'"');
        WriteLn('');
      end;
    end;

    WriteLn('');
    if pMsg.MessageParts.Count > 0 then // Alternative part
    begin
      with pMsg.MessageParts do
      begin
        for i := 0 to Pred(Count) do
        begin
          WriteLn('--' + MultiPartBoundary);
          WriteLn('Content-Type: ' + Items[i].ContentType ) ;
          WriteLn('Content-Transfer-Encoding: ' + Items[i].ContentTransfer);
          WriteLn('');
          WriteMessage(Items[i].Text );
          WriteLn('');
        end;
      end;
      WriteLn('--' + MultiPartBoundary + '--');
    end
    else // No alternative part
    begin
      WriteLn('--' + MultiPartBoundary);
      WriteLn('Content-Type: ' + pMsg.ContentType+ ';');
      WriteLn('        charset="iso-8859-1"');
      WriteLn('Content-Transfer-Encoding: 7bit');
      WriteLn('');
      WriteMessage(pMsg.Text);
      WriteLn('');
      WriteLn('--' + MultiPartBoundary + '--');
    end;

    // Now the InLineImages
    with pMsg.InLineImages do
    begin
      encd := TWinshoeEncoder.Create;
      try
        for i := 0 to Pred(Count) do
        begin
          WriteLn('');
          if pMsg.Attachments.Count > 0 then
            WriteLn('--' + MultiPartAlternativeBoundary)
          else
            WriteLn('--' + MultiPartRelatedBoundary);

          WriteLn('Content-Type: image/' + Copy(ExtractFileExt(Items[i].Filename),2,length(Items[i].Filename))  + ';');
          WriteLn('        name="' + Items[i].Filename + '"');
          WriteLn('Content-Transfer-Encoding: base64');
          WriteLn('Content-ID: <'+ Items[i].Filename +'>');
          WriteLn('');
          encd.EncodeFile(Self, Items[i].StoredPathname);
        end;
        if (pMsg.InLineImages.Count >0) then
          if pMsg.Attachments.Count > 0 then
            WriteLn('--' + MultiPartAlternativeBoundary + '--')
          else
            WriteLn('--' + MultiPartRelatedBoundary + '--');
      finally
        encd.free;
      end;
    end ;

    // Now the attachments
    with pMsg.Attachments do
    begin
      encd := TWinshoeEncoder.Create;
      try
        for i := 0 to Pred(Count) do
        begin
          WriteLn('');
          if pMsg.InLineImages.Count > 0 then
            WriteLn('--' + MultiPartRelatedBoundary)
          else
            WriteLn('--' + MultiPartAlternativeBoundary);
          WriteLn('Content-Type: application/octet-stream;');
          WriteLn('        name="' + Items[i].Filename + '"');
          WriteLn('Content-Transfer-Encoding: base64');
          WriteLn('Content-Disposition: attachment;');
          WriteLn('        filename="' + Items[i].Filename + '"');
          WriteLn('');
          encd.EncodeFile(Self, Items[i].StoredPathname);
        end;
        if pMsg.InLineImages.Count > 0 then
          WriteLn('--' + MultiPartRelatedBoundary + '--')
        else
          WriteLn('--' + MultiPartAlternativeBoundary + '--');
      finally
        encd.free;
      end;
      WriteLn('');
    end ;
  end
  else // No attachments
  begin   // need to check for inline images
    if (pMsg.InLineImages.Count >0) then
    begin
      WriteLn('This is a multi-part message in MIME format.');
      WriteLn('');
      WriteLn('--' + MultiPartAlternativeBoundary);
      WriteLn('Content-Type: multipart/alternative; ');
      WriteLn('        boundary="' + MultiPartBoundary +'"');
      WriteLn('');
      WriteLn('');
      if pMsg.MessageParts.Count > 0 then // Alternative part
      begin
        with pMsg.MessageParts do
        begin
          for i := 0 to Pred(Count) do
          begin
            WriteLn('--' + MultiPartBoundary);
            WriteLn('Content-Type: ' + Items[i].ContentType ) ;
            WriteLn('Content-Transfer-Encoding: ' + Items[i].ContentTransfer);
            WriteLn('');
            WriteMessage(Items[i].Text );
            WriteLn('');
          end;
        end;
        WriteLn('--' + MultiPartBoundary + '--');
      end
      else // No alternative part
      begin
        WriteLn('--' + MultiPartBoundary);
        WriteLn('Content-Type: ' + pMsg.ContentType+ ';');
        WriteLn('        charset="iso-8859-1"');
        WriteLn('Content-Transfer-Encoding: 7bit');
        WriteLn('');
        WriteMessage(pMsg.Text);
        WriteLn('');
        WriteLn('--' + MultiPartBoundary + '--');
      end;

      // Now the InLineImages
      with pMsg.InLineImages do
      begin
        encd := TWinshoeEncoder.Create;
        try
          for i := 0 to Pred(Count) do
          begin
            WriteLn('');
            WriteLn('--' + MultiPartAlternativeBoundary);

            WriteLn('Content-Type: image/' + Copy(ExtractFileExt(Items[i].Filename),2,length(Items[i].Filename))  + ';');
            WriteLn('        name="' + Items[i].Filename + '"');
            WriteLn('Content-Transfer-Encoding: base64');
            WriteLn('Content-ID: <'+ Items[i].Filename +'>');
            WriteLn('');
            encd.EncodeFile(Self, Items[i].StoredPathname);

          end;
          WriteLn('--' + MultiPartAlternativeBoundary + '--');
        finally
          encd.free;
        end;
      end;
    end
    else
    begin
      if pMsg.MessageParts.Count > 0 then // Has alternative
      begin
        WriteLn('This is a multi-part message in MIME format.');
        WriteLn('');
        with pMsg.MessageParts do
        begin
          for i := 0 to Pred(Count) do
          begin
            WriteLn('--' + MultiPartBoundary);
            WriteLn('Content-Type: ' + Items[i].ContentType ) ;
            WriteLn('Content-Transfer-Encoding: ' + Items[i].ContentTransfer);
            WriteLn('');
            WriteMessage(Items[i].Text );
            WriteLn('');
          end;
        end;
        WriteLn('--' + MultiPartBoundary + '--');
      end else
        WriteMessage(pMsg.Text); // No attachments or alternative parts (message parts)
    end;
  end;
end;

destructor TWinshoeMessage.Destroy;
begin
  fMessageParts.Free ;
  fAttachments.Free;
  fInLineImages.Free; // Satvinder Basra 2/12/1999 Added to deal with inline images
  FslstBCCList.Free;
  FslstCCList.Free;
  FslstHeaders.Free;
  FslstText.Free;
  fslstNewsgroups.Free;
  fslstToo.Free;

  inherited Destroy;
end;

procedure TWinshoeMessage.Clear;
begin
  ClearHeader;
  ClearBody;
end;

procedure TWinshoeMessage.ClearBody;
begin
  MessageParts.Clear;
  Attachments.Clear;
  InLineImages.Clear; // Satvinder Basra 2/12/1999 Added to deal with inline images
  Text.Clear;
end;

procedure TWinshoeMessage.ClearHeader;
begin
  BCCList.Clear;
  CCList.Clear;
  DefaultDomain := '';
  Date := 0 ;
  From := '';
  Headers.Clear;
  MsgNo := 0 ;
  Newsgroups.Clear;
  Organization := '';
  References := '';
  ReplyTo := '';
  Subject := '';
  Too.Clear;
end;

procedure TWinshoeMessageClient.WriteMessage(pslst: TStrings);
{Writes a message to a socket, guaranteeing a terminating EOL
, and changes leading '.'}
var
  i: integer;
  s: string;
begin
  for i := 0 to Pred(pslst.Count) do begin
    s := pslst[i];
    if Copy(s, 1, 1) = '.' then
      s := '.' + s;
    WriteLn(s);
  end;
end;

function TWinshoeMessage.GetHeaderDate: TDateTime;
begin
  result := StrInternetToDateTime(Headers.Values['Date']);
end;

function TWinshoeMessage.GetHeaderString(const piIndex: Integer): string;
begin
  result := Headers.Values[WinshoeMessageHeaderNames[piIndex]];
end;

procedure TWinshoeMessage.SetHeaderDate(const Value: TDateTime);
var
  TheDate:TDateTime ;
  strOldFormat,
  strDate: String;
  wDay,
  wMonth,
  wYear:WORD;
begin
  // This code doesn't work with non-english systems.

  //Headers.Values['Date'] := FormatDateTime('ddd, dd mmm yyyy hh:nn:ss '
  //+ DateTimeToGmtOffSetStr(OffsetFromUTC, False), Value);
  if fbUseNowForDate then
    TheDate := Now
  else
    TheDate := Value ;
  // Replace with this:
  strOldFormat := ShortDateFormat ;

  ShortDateFormat := 'DD.MM.YYYY';

  // Date
  case DayOfWeek(TheDate) of
    1: strDate := 'Sun, ';
    2: strDate := 'Mon, ';
    3: strDate := 'Tue, ';
    4: strDate := 'Wed, ';
    5: strDate := 'Thu, ';
    6: strDate := 'Fri, ';
    7: strDate := 'Sat, ';
  end;
  DecodeDate(TheDate, wYear, wMonth, wDay);
  strDate := strDate + IntToStr(wDay) + #32;
  case wMonth of
     1: strDate := strDate + 'Jan ';
     2: strDate := strDate + 'Feb ';
     3: strDate := strDate + 'Mar ';
     4: strDate := strDate + 'Apr ';
     5: strDate := strDate + 'May ';
     6: strDate := strDate + 'Jun ';
     7: strDate := strDate + 'Jul ';
     8: strDate := strDate + 'Aug ';
     9: strDate := strDate + 'Sep ';
    10: strDate := strDate + 'Oct ';
    11: strDate := strDate + 'Nov ';
    12: strDate := strDate + 'Dec ';
  end;
  strDate := strDate + IntToStr(wYear) + #32 + TimeToStr(TheDate);

  Headers.Values['Date'] := strDate + DateTimeToGmtOffSetStr(OffsetFromUTC,False);

  ShortDateFormat := strOldFormat ;
end;

procedure TWinshoeMessage.SetHeaderString(const piIndex: Integer;
  const Value: String);
begin
  Headers.Values[WinshoeMessageHeaderNames[piIndex]] := Value;
end;

procedure TWinshoeMessage.SaveToFile;
begin
  with TFileStream.Create(sFileName, fmCreate) do try
    WriteComponent (Self);
  finally Free; end;
end;

procedure TWinshoeMessage.LoadFromFile;
begin
  with TFileStream.Create(sFileName, fmOpenRead) do try
    ReadComponent(Self);
  finally Free; end;
end;

procedure TWinshoeMessage.SetDynamicHeaders;
var useBoundary : string;
begin
  Date := Now;
// Satvinder Basra 2/12/1999 Added to deal with inline images
  if (InLineImages.Count >0) and (Attachments.Count >0) then
    useBoundary := MultiPartRelatedBoundary
  else
    if (InLineImages.Count >0) or (Attachments.Count >0) then
      useBoundary := MultiPartAlternativeBoundary
    else
      useBoundary := MultiPartBoundary;

  if Attachments.Count > 0 then
  begin  // Has attachments
    Headers.Values['MIME-Version'] := '1.0';
    Headers.Values['Content-Type'] := 'multipart/mixed; boundary="'
                           + useBoundary {MultiPartBoundary} + '"';
  end
  else
  begin
    if InLineImages.Count > 0 then
    begin  // Has InLineImages
      Headers.Values['MIME-Version'] := '1.0';
      Headers.Values['Content-Type'] := 'multipart/related; '+
                                        'type="multipart/alternative"; ' +
                                        'boundary="' + useBoundary {MultiPartBoundary} + '"';
    end
    else
    begin
      if MessageParts.Count > 0 then
      begin
        Headers.Values['MIME-Version'] := '1.0';
        Headers.Values['Content-Type'] := 'multipart/alternative; boundary="' +
           useBoundary{MultiPartBoundary} + '"';
      end
      else
      begin
        Headers.Values['MIME-Version'] := '';
        Headers.Values['Content-Type'] := fsContentType +
                ' boundary="' + useBoundary{MultiPartBoundary} + '"';
      end;
    end;
  end;

  if Newsgroups.Count > 0 then
    Headers.Values['Newsgroups'] := Newsgroups.CommaText;
end;

function TAttachments.Add: TAttachment;
begin
  result := TAttachment(inherited Add);
end;

procedure TAttachments.AddAttachment(const psPathname: string);
begin
  with Add do begin
    Filename := ExtractFileName(psPathname);
    StoredPathname := psPathname;
  end;
end;

function TAttachments.GetItem(Index: Integer): TAttachment;
begin
  result := TAttachment(inherited GetItem(Index));
end;

procedure TAttachments.SetItem(Index: Integer; const Value: TAttachment);
begin
  inherited SetItem(Index, Value);
end;

procedure TWinshoeMessageClient.ReceiveBody(pMsg: TWinshoeMessage);
var
  intStart,
  intEnd,
  i: integer;
  intPos : integer ;
  sOldBoundary,
  sTemp,
  s, sBoundary: string;
  lstBoundary : TStringList;
  slst : TStringList;
  MsgPart : TMessagePart;
  Att : TAttachment;
  Img : TInLineImage;
  strmOut: TFileStream;
  bBoundary,
  boolBoundaryFound: boolean ;

function ExtractBoundary : string;
var b: string;
begin
  Result := '';
  intPos := Pos('=',s);
  b := Trim(Copy(s,intPos+1,Length(s)-intPos+1));
  if pos(';',b) <> 0 then
    b:= Fetch(b,';');
  if b[length(b)]='"' then
    intEnd := Length(b)-1;
  if b[1]='"' then
    intStart := 1
  else
    intStart := 0;
  b := Trim( Copy(b, intStart+1, IntEnd-1));
  Result := b;
end; {ExtractBoundary}

procedure ExtractInLineImages;
var b : integer;
begin
  with pMsg do
  begin
    if (ExtractAttachments) and
       (Pos('multipart/alternative',slst.Values['Content-Type'])=0) then
    begin
      strmOut := nil ;
      try
        Img := InLineImages.Add ;
        with Img do
        begin
          Headers.Assign(slst);
          FileName := Pluck(slst.Values['Content-Type'], 'name="', '"', True );
          if FileName = '' then
            FileName := Pluck(slst.Values['Content-Disposition'], 'filename="', '"', True );

          if slst.Values[slst.Values['Content-ID']] <> '' then
           slst.Values[slst.Values['Content-ID']] := FileName;

          if MsgPart.fslstText.indexof(
                Pluck(slst.Values['Content-ID'], '<','>',True)) >-1 then
          begin
            MsgPart.fslstText[MsgPart.fslstText.indexof(
                Pluck(slst.Values['Content-ID'], '<','>',True))] :=
                Pluck(slst.Values['Content-ID'], '<','>',True);
          end;

          for b := 0 to MsgPart.fslstText.Count-1 do
          begin
            {Satvinder Basra 13/12/99 - fix problem with images with spaces in name}
            if Pos(' ',FileName)> 0 then
               MsgPart.text[b] := StringReplace( MsgPart.text[b],
                              Pluck(slst.Values['Content-ID'], '<','>',True),
                              '"'+FileName+'"',[rfReplaceAll,rfIgnoreCase])
             else
               MsgPart.text[b] := StringReplace( MsgPart.text[b],
                              Pluck(slst.Values['Content-ID'], '<','>',True),
                              FileName,[rfReplaceAll,rfIgnoreCase]);
             MsgPart.text[b] := StringReplace( MsgPart.text[b],
                            'CID:', '', [rfReplaceAll,rfIgnoreCase]);
             MsgPart.text[b] := StringReplace( MsgPart.text[b],
                            '""'+FileName+'""', '"'+FileName+'"', [rfReplaceAll,rfIgnoreCase]);
          end;
          for b := 0 to pMsg.Text.Count-1 do
          begin
            {Satvinder Basra 13/12/99 - fix problem with images with spaces in name}
            if Pos(' ',FileName)> 0 then
              pMsg.text[b] := StringReplace( pMsg.Text[b],
                             Pluck(slst.Values['Content-ID'], '<','>',True),
                             '"'+FileName+'"',[rfReplaceAll,rfIgnoreCase])
            else
              pMsg.text[b] := StringReplace( pMsg.Text[b],
                             Pluck(slst.Values['Content-ID'], '<','>',True),
                             FileName,[rfReplaceAll,rfIgnoreCase]);
            pMsg.text[b] := StringReplace( pMsg.Text[b],
                           'CID:', '', [rfReplaceAll,rfIgnoreCase]);
            pMsg.text[b] := StringReplace( pMsg.Text[b],
                           '""'+FileName+'""', '"'+FileName+'"', [rfReplaceAll,rfIgnoreCase]);
          end;

          if assigned ( OnGetInLineImageStream ) then
            OnGetInLineImageStream(strmOut);
        end ;
        if strmOut = nil then
        begin
          Img.StoredPathName := MakeTempFilename ;
          strmOut := TFileStream.Create(Img.StoredPathName, fmCreate );
        end ;
        if CompareText(slst.Values['Content-Transfer-Encoding'], 'base64' ) = 0 then
        begin
          boolBoundaryFound := False ;
          while true do
          begin
            s := ReadLn ;
            if Length ( s ) = 0 then // some clients don't leave
              break									 // a space at then end before boundary
            else
            if (s = sBoundary) or (s = sBoundary + '--') then // Some clients don't leave a blank line
            begin
              boolBoundaryFound := True ;
              break ;
            end ;
            s := TWinshoeDecoder.DecodeLine(s);
            strmOut.WriteBuffer(s[1], Length(s));
          end ;
          if not boolBoundaryFound then
            i := Capture (nil, [sBoundary, sBoundary + '--'])
          else
            i := 0 ;
        end
        else
          i := Capture(strmOut, [sBoundary, sBoundary + '--']);
      finally
        strmOut.Free ;
      end ;
    end
    else // don't save attachment
      i := Capture(nil, [sBoundary,sBoundary + '--']) ;
  end
end; {ExtractInLineImages}

procedure ExtractAttachedFiles;
begin
  with pMsg do
  begin
    if (ExtractAttachments) and
      (Pos('multipart/alternative',slst.Values['Content-Type'])=0) then
    begin
      strmOut := nil ;
      try
        Att := Attachments.Add ;
        with Att do
        begin
          Headers.Assign(slst);
          FileName := Pluck(slst.Values['Content-Type'], 'name="', '"', True );
          if FileName = '' then
            FileName := Pluck(slst.Values['Content-Disposition'], 'filename="', '"', True );
          if assigned ( OnGetAttachmentStream ) then
            OnGetAttachmentStream(strmOut);
        end ;
        if strmOut = nil then
        begin
          Att.StoredPathName := MakeTempFilename ;
          strmOut := TFileStream.Create(Att.StoredPathName, fmCreate );
        end;
        if CompareText(slst.Values['Content-Transfer-Encoding'], 'base64' ) = 0 then
        begin
          boolBoundaryFound := False ;
          while true do
          begin
            s := ReadLn ;
            if Length ( s ) = 0 then // some clients don't leave
              break									 // a space at then end before boundary
            else
              if (s = sBoundary) or (s = sBoundary + '--') then // Some clients don't leave a blank line
              begin
                boolBoundaryFound := True ;
                break ;
              end ;

            s := TWinshoeDecoder.DecodeLine(s);
            strmOut.WriteBuffer(s[1], Length(s));
          end ;
          if not boolBoundaryFound then
            i := Capture (nil, [sBoundary, sBoundary + '--'])
          else
            i := 0 ;

        end
        else
          i := Capture(strmOut, [sBoundary, sBoundary + '--']);
      finally
        strmOut.Free ;
      end ;
    end
    else // don't save attachment
      i := Capture(nil, [sBoundary,sBoundary + '--']) ;
  end;
end; {ExtractAttachedFiles}

begin
  bBoundary := FALSE;
  if pMsg.fbNoDecode then // Don't decode the message, just capture it raw
    Capture(pMsg.fslstText,['.'])
  else
  begin
    lstBoundary := TStringList.Create ;
    try
      sOldBoundary := '' ;
      OnCaptureLine := nil;
      with pMsg do
      begin
        s := Headers.Values['Content-Type']; // Get the header content-type
        if CompareText(Fetch(s,'/'),'multipart') = 0  then // If this is a multipart message
        begin // now it could be mixed or alternative
          // We have to distinguish if it is alternative, since we have to change the boundary.
          // If there is an attachment, it will be multipart/mixed
          s := Headers.Values['Content-Type'];
          // See if boundary is found
          intPos := Pos('boundary',LowerCase(s)); // some put boundary in caps
          s := Trim ( Copy ( s, intPos, Length ( s ) - intPos + 1 )) ;

          if (CompareText(Copy(s,1,8), 'boundary') = 0 ) then
          begin
            // According to the RFC, the boundary should be put in the content type as:
            // boundary="simple boundary", that is boundary an = sign and then the boundary.
            // However, I found some boundary with spaces on each between the = sign. This is why
            // the following fixes this problem.

            // Get the actual boundary
            intPos := Pos ('=', s) ;
            sBoundary := Trim(Copy(s,intPos+1,Length(s)-intPos + 1 ));
            // See if there is a ';' the boundary
            if Pos(';',s) <> 0 then
              s := Fetch(s,';');
            if s[Length(s)]='"' then // in case boundary is enclosed in quotes (").
              intEnd := Length(s) -11
            else
              intEnd := Length(s) - 9;

            if s[10] = '"' then
              intStart := 1
            else
              intStart := 0 ;


            // Set the boundary
            sBoundary := '--' + Trim(Copy(s,intStart + 10,intEnd));
            s := ReadLn ;
            repeat
              if bBoundary then
                s := sBoundary;
              if s = sBoundary then // new part of messsage
              begin
                slst := TStringList.Create ;
                try
                  CaptureHeader ( slst, '');
                  if slst.Count > 0 then
                  begin
                    s := slst.Values['Content-Type'];
                    // Set flag if alternative
                    if (Pos('multipart/alternative',s)>0) or (Pos('multipart/related',s)>0) then
                    begin
                      {Satvinder Basra 13/12/99 - fix problem with not decoding emails}
                      {                           with images text and attachments}
                      lstBoundary.Add(sBoundary);
                      sOldBoundary := sBoundary ; // Save boundary
                      bBoundary := FALSE;
                      if Pos('boundary',s) >0 then
                      begin
                        s:= Copy(s,Pos('boundary',s), length(s));
                        sBoundary := '--'+ExtractBoundary;
                        bBoundary := TRUE;
                        Continue;
                      end
                      else
                      begin
                        if (Pos('multipart/alternative',s)>0) then
                        begin
                          CompareText(Trim(Fetch(s,';')),'multipart/alternative');
                        end;
                        if (Pos('multipart/related',s)>0) then
                        begin
                          CompareText(Trim(Fetch(s,';')),'multipart/related')
                        end;

                        // Get alternative boundary
                        sBoundary := '--' + Copy(Trim(s),11,Length(s)-12);
                      end;
                    end;
                    s := slst.Values['Content-Type'];
                    s := Trim(Fetch(s,'/'));

                    if (CompareText(s, 'text') = 0) and
                    // Maybe this won't work with all.

                    // Temp Change. For allowing inline images etc...
    //              if (Pos('multipart',s)=0) and
                    (Pos('attachment',slst.Values['Content-Disposition'])=0) then // if it is a body part
                    begin
                      // Create the message part
                      MsgPart := MessageParts.Add ;
                      MsgPart.fsContentType := slst.Values ['Content-Type'];
                      MsgPart.fsContentTransfer := slst.Values['Content-Transfer-Encoding'];
                      // Get the message
                      if LowerCase(MsgPart.fsContentTransfer) = 'quoted-printable' then
                        i := CaptureQuotedPrintable(MsgPart.fslstText, [sBoundary, sBoundary + '--'])
                      else
                        i := Capture(MsgPart.fslstText, [sBoundary, sBoundary + '--']);
                      bBoundary := FALSE;
                      // for back compatibility assign to text
                      fslstText.AddStrings ( MsgPart.fslstText ) ; // remove this in future versions
                    end
                    else // It is an attachment
                    begin  // Get rid of alternative saving
    //              if (Pluck(slst.Values['Content-Disposition'], 'filename="','"',True) <> '')
    //                 and (ExtractAttachments) then
                      if (Pluck(slst.Values['Content-ID'], '<','>',True) <> '') then
                      begin
                        ExtractInLineImages;
                        bBoundary := FALSE;
                      end
                      else
                      begin
                        ExtractAttachedFiles;
                        bBoundary := FALSE;
                      end; {}
                    end;
                    if i = 1 then s := sBoundary ;
                    // else   //Took this out. BUG
                    // s := ''// 24 OCT. 1999 Wasn't decoding atts. with this properly.
                  end ;
                finally
                  slst.Free ;
                end
              end
              else
                if s = '.' then
                  break
                else
                begin
                  {Satvinder Basra 13/12/99 - reset boundary to previous in list}
                  if (lstBoundary.Count > 0) and (bBoundary = FALSE) then
                  begin
                    sBoundary := lstBoundary.strings[Pred(lstBoundary.Count)];
                    lstBoundary.Delete(Pred(lstBoundary.Count));
                    bBoundary := TRUE;
                  end;
  //                if sOldBoundary <> '' then // restore boundary
  //                  sBoundary := sOldBoundary ;
                  s := ReadLn ;
                end ;
            until false ;
          end
         else
           // Boundary error
           raise EWinshoeException.Create('Boundary error');
         end
         else // this is not a multipart message or content-type not set
         begin
           // Create a message part and finish.
           s := Headers.Values['Content-Type'];
  //         if CompareText(Fetch(s,'/'),'text') <> 0 then
           if (CompareText(Fetch(s,'/'),'text') <> 0) and (s<>'') then
           begin
             sTemp :=Pluck(Headers.Values['Content-Disposition'], 'filename="','"',True);
             if (sTemp<>'') and (ExtractAttachments) then
             begin
               strmOut := nil ;
               try
                 Att := Attachments.Add ;
                 with Att do
                 begin
                   FileName := sTemp;
                   if assigned ( OnGetAttachmentStream ) then
                              OnGetAttachmentStream(strmOut);
                 end ;
                 if strmOut = nil then
                 begin
                   Att.StoredPathName := MakeTempFilename ;
                   strmOut := TFileStream.Create(Att.StoredPathName, fmCreate );
                 end ;
                 if CompareText(Headers.Values['Content-Transfer-Encoding'], 'base64' ) = 0 then
                 begin
                   while true do
                   begin
                     s := ReadLn ;
                     if (Length ( s ) = 0) or (s='.') then // some clients don't leave
                       break;									 // a space at then end before boundary
                     s := TWinshoeDecoder.DecodeLine(s);
                     strmOut.WriteBuffer(s[1], Length(s));
                   end ;
                 end
                 else
                   Capture(strmOut, [sBoundary, sBoundary + '--']);
               finally
                 strmOut.Free;
               end ;
             end
           end
           else
           begin
             MsgPart := MessageParts.Add ;
             MsgPart.fsContentType := Headers.Values['Content-Type'];
             MsgPart.fsContentTransfer := Headers.Values['Content-Transfer-Encoding'];
             // Get the text
             if LowerCase(MsgPart.fsContentTransfer) = 'quoted-printable' then
               CaptureQuotedPrintable(MsgPart.fslstText, ['.'])
             else
               Capture(MsgPart.fslstText, ['.']);

             // For back compatibilty assign the text to the Text property aswell
             fslstText.Assign ( MsgPart.fslstText ) ; // This line will be removed in future versions
           end ; {if}
         end; {if}
      end ; {with}
    finally
      lstBoundary.Free;
    end;
  end ; {if}
end; {ReceiveBody}

procedure TWinshoeMessageClient.ReceiveHeader;
var
  s: string;
begin
  with pMsg do begin
    Clear;
    CaptureHeader(Headers, psDelim);
    ParseCommaString(Too, Headers.Values['To']);
    ParseCommaString(CCList, Headers.Values['Cc']);
    ParseCommaString(Newsgroups, Headers.Values['Newsgroups']);
    s := Headers.Values['Title'];
    if length(s) > 0 then begin
      Headers.Values['Subject'] := Headers.Values['Title'];
      Headers.Values['Title'] := '';
    end;
  end;
end;

procedure TWinshoeMessage.SetToo(Value: TStrings);
begin
  FslstToo.Assign(Value);
end ;

{ TAttachment }

constructor TAttachment.Create;
begin
  inherited;
  fslstHeaders := TStringList.Create;
end;

destructor TAttachment.Destroy;
begin
  fslstHeaders.Free;
  inherited;
end;

function TAttachment.SaveToFile(strFileName: string): boolean;
begin
  // What it really does is copy the file from the
  // temp location where the attachment has been saved
  // to the location specified in the parameter.

  if strFileName [ Length ( strFileName ) ] = '\' then
    strFileName := Copy ( strFileName, 1, Length ( strFileName ) - 1 );

  Result := CopyFile ( PChar ( fsStoredPathname ) , PChar(strFileName), False);
end;

procedure TAttachment.SetStoredPathname(const Value: String);
begin
  fsStoredPathname := Value;
end;

{ TMessagePart }

constructor TMessagePart.Create(Collection: TCollection);
begin
  inherited ;
  fslstText := TStringList.Create;
end;

destructor TMessagePart.Destroy;
begin
  fslstText.Free ;
  inherited;
end;

{ TMessageParts }

function TMessageParts.Add: TMessagePart;
begin
  result := TMessagePart(inherited Add);
end;

function TMessageParts.GetItem(Index: Integer): TMessagePart;
begin
  result := TMessagePart(inherited GetItem(Index));
end;

procedure TMessageParts.AddMessagePart(const psContentType,
  psContentTransfer: string; slstText: TStrings);
begin
  with Add do
    begin
      ContentType := psContentType;
      if psContentTransfer = '' then
        ContentTransfer := 'quoted-printable'
      else
        ContentTransfer := psContentTransfer ;
      Text.Assign(slstText) ;
    end ;
end;

procedure TMessageParts.SetItem(Index: Integer; const Value: TMessagePart);
begin
  inherited SetItem(Index,Value);
end;

{ TInLineImages }

function TInLineImages.Add: TInLineImage;
begin
  result := TInLineImage(inherited Add);
end;

procedure TInLineImages.AddInLineImage(const psPathname: string);
begin
  with Add do begin
    Filename := ExtractFileName(psPathname);
    StoredPathname := psPathname;
  end;
end;

function TInLineImages.GetItem(Index: Integer): TInLineImage;
begin
  result := TInLineImage(inherited GetItem(Index));
end;

procedure TInLineImages.SetItem(Index: Integer; const Value: TInLineImage);
begin
  inherited SetItem(Index, Value);
end;

{ TInLineImage }
constructor TInLineImage.Create;
begin
  inherited;
  fslstHeaders := TStringList.Create;
end;

destructor TInLineImage.Destroy;
begin
  fslstHeaders.Free;
  inherited;
end;

function TInLineImage.SaveToFile(strFileName: string): boolean;
begin
  // What it really does is copy the file from the
  // temp location where the attachment has been saved
  // to the location specified in the parameter.

  if strFileName [ Length ( strFileName ) ] = '\' then
      strFileName := Copy ( strFileName, 1, Length ( strFileName ) - 1 );

  Result := CopyFile ( PChar ( fsStoredPathname ) , PChar(strFileName), False);
end;

procedure TInLineImage.SetStoredPathname(const Value: String);
begin
  fsStoredPathname := Value;
end;

end.
