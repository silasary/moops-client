�
 TFRMSIMPHTTPGETDEMO 0�	  TPF0TfrmSimpHTTPGetDemofrmSimpHTTPGetDemoLeft� TopnWidthoHeightjCaptionSimple HTTP GET demoColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	OnCreate
FormCreatePixelsPerInch`
TextHeight 	TSplitter	Splitter1Left Top� WidthgHeightCursorcrVSplitAlignalBottom  TMemomemHeadLeft Top WidthgHeight`AlignalClientFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style Lines.StringsQRaw HTTP header information will appear here.  This is just plain text - use the JTSimpleHTTP.HTTPHeaderInfo object's properties to obtain pre-parsed (e.g. Opre-converted to TDateTime or Integer values) information such as status code, )status text and content dates and length. 
ParentFont
ScrollBars
ssVerticalTabOrder   TMemomemBodyLeft Top� WidthgHeight� AlignalBottomFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style Lines.StringsJThe main body of the content will appear here.  This demo only copes with RHTML or text, so if you try to GET a GIF or other binary file (in this demo only) 'you will be rewarded with garbled text! FAs an exercise, try altering TfrmSimpHTTPGetDemo.btnGetClick such thatSa binary file containing the content is saved.  This is very easy - just change theLTStringStream (ssResult) to a TFileStream and supply an appropriate filename when the file stream is created. 4See the help file WinShoes.hlp for more information. 
ParentFont
ScrollBars
ssVerticalTabOrder  TPanel
pnlAddressLeft Top WidthgHeight AlignalTopCaption
pnlAddressTabOrder TButtonbtnGetLeftTopWidthDHeightCaption&GetDefault	TabOrder OnClickbtnGetClick  TEditedtURLLeftTopWidthHeightTabOrderTexthttp://www.borland.com/OnKeyUpedtURLKeyUp   
TStatusBarstbMainLeft Top:WidthgHeightPanelsWidth, BevelpbNoneStylepsOwnerDrawWidth�  Widthm  SimplePanelOnDrawPanelstbMainDrawPanel  TProgressBarpbMainLeft�TopdWidth� HeightMin MaxdTabOrder  TSimpleHTTPSimpleHTTP1ConnectRetriesEnableCacheHostNamewww.borland.comPortPQuickProgress	QuickProgressMinorpbMainQuickStatusstbMainConnectTimeout�� ResolveNamesrnPreConfigSilentExceptions	BlockSize  	EnableSSLPostData.Strings	Some Data ReferrermeLeftTop(   