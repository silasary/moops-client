�
 TMAINFORM 0�  TPF0	TMainFormMainFormLeft� TopnWidthMHeight�Caption	SMTP DemoFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style MenuMainMenuVisible	OnCreate
FormCreatePixelsPerInch`
TextHeight 	TSplitter	Splitter2Left Top� WidthEHeight	CursorcrVSplitAlignalTop  
TStatusBar	StatusBarLeft Top�WidthEHeightPanels SimplePanel	  TPanelPanel1Left Top� WidthEHeight� AlignalClient
BevelInnerbvRaised
BevelOuter	bvLoweredBorderWidthCaptionPanel1TabOrder TMemoMemoBodyLeftTopWidth7Height� AlignalClientLines.StringsQEnter the text here that you would like to send in the body of the EMail message. YHi! I'm using Winshoes. It's really cool product. Not only is it the best, but it's also free! 
ScrollBars
ssVerticalTabOrder    TPanelPanel2Left Top WidthEHeight� AlignalTop
BevelInnerbvRaised
BevelOuter	bvLoweredBorderWidthCaptionPanel2TabOrder 	TSplitter	Splitter1Left%TopWidthHeight� CursorcrHSplit  TPanelPanel3LeftTopWidthHeight� AlignalLeft
BevelInnerbvRaised
BevelOuter	bvLoweredBorderWidthCaption TabOrder  TLabelLabel2Left$TopWidthHeightCaptionTo:  TLabelLabel4LeftTop6Width'HeightCaptionSubject:  TLabelLabel6Left&TopVWidthHeightCaptionCC:  TLabelLabel5Left"Top� WidthHeightCaptionFile:  TLabelLabel7LeftTop� WidthHeightCaptionBCC:  TEditEditToLeft<TopWidth� HeightTabOrder   TEditEditSubjectLeft<Top0Width� HeightTabOrderText   TMemoMemoCCLeft<TopHWidth� Height)Lines.Strings  TabOrder  TMemoMemoBCCLeft<ToptWidth� Height)Lines.Strings  TabOrder  TEditEditAttachmentLeft<Top� Width� HeightTabOrder  TButtonButtonSelectFileLeft� Top� WidthHeightCaption...TabOrderOnClickButtonSelectFileClick  TButton
ButtonSendLeft<Top� Width� HeightCaptionSendTabOrderOnClickButtonSendClick   TPanelPanel4Left(TopWidthHeight� AlignalClient
BevelInnerbvRaised
BevelOuter	bvLoweredBorderWidthCaptionPanel4TabOrder TLabelLabel1LeftTopWidthHeightAlignalTop	AlignmenttaCenterCaptionServer StatusFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TMemoMemoServerStatusLeftTopWidthHeight� AlignalClientLines.Strings  
ScrollBars
ssVerticalTabOrder     TOpenDialogOpenDialogAttachmentOptionsofHideReadOnlyofPathMustExistofFileMustExist Left4Top$  	TMainMenuMainMenuLeftPTop' 	TMenuItemFile1Caption&File 	TMenuItemMenuItemSetupCaption&SetupOnClickMenuItemSetupClick  	TMenuItemN2Caption-  	TMenuItemExit1Caption&ExitOnClickMenuItemExitClick   	TMenuItemNewMessage1Caption&New MessageOnClickMenuItemNewMessageClick  	TMenuItemAbout1Caption&AboutOnClickMenuItemAboutClick   TWinshoeMessageMsgMsgNo ContentType
text/plainToo.Stringsdharmor@yahoo.com Left�Top'  TWinshoeSMTPSMTPPortBufferChunk  OnStatus
SMTPStatusHost Password UserID Left�Top'   