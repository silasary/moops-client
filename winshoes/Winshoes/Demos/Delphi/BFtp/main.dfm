�
 TFORMMAIN 0�
  TPF0	TformMainformMainLeft� Top� Width�Height]CaptionAFTPFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style Menu	MainMenu1OnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight TLabelLabel2LeftTopWidth"HeightCaptionServer:  TLabelLabel3LeftTop!Width3HeightCaption	Username:  TLabelLabel5LeftTop1Width8HeightCaptionDestination:  TLabellablProxyLabelLeftTopBWidthHeightCaptionProxy:Visible  TLabel
lablServerLeftHTopWidth"HeightCaptionServer:Font.CharsetDEFAULT_CHARSET
Font.ColorclHighlightTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabellablUsernameLeftHTop"Width3HeightCaption	Username:Font.CharsetDEFAULT_CHARSET
Font.ColorclHighlightTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabellablDestinationLeftHTop2Width8HeightCaptionDestination:Font.CharsetDEFAULT_CHARSET
Font.ColorclHighlightTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabel	lablProxyLeftHTopCWidthHeightCaptionProxy:Font.CharsetDEFAULT_CHARSET
Font.ColorclHighlightTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontVisible  TLabelLabel6LeftTopWidth4HeightCaptionConfig File:  TLabellablFileLeftHTopWidth"HeightCaptionServer:Font.CharsetDEFAULT_CHARSET
Font.ColorclHighlightTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabellablCurrentLeftHTopmWidthfHeightAutoSizeCaption0  TLabelLabel1LeftTopmWidth,HeightCaption	Progress:  TListBox
lboxStatusLeft TopWidth�Height� AlignalBottom
ItemHeightTabOrder   TButton
butnUploadLeftJTopWidthKHeightCaption&UploadDefault	TabOrderOnClickbutnUploadClick  	TCheckBoxchckUploadAllLeftHTopHWidthaHeightCaptionUpload &AllTabOrder  	TCheckBox	chckProxyLeftHTop7WidthaHeightCaption
Use &ProxyTabOrderOnClickchckProxyClick  TProgressBarProgressBar1Left� TophWidth� HeightMin MaxdTabOrder  
TSimpleFTPftpcConnectRetriesEnableCachePortQuickProgress	QuickProgressMinorProgressBar1ConnectTimeout�� SilentExceptions	FailIfExistsOnGetFileSystemTypeftUnixPassiveLeftTop8  	TMainMenu	MainMenu1Left� Top6 	TMenuItemFile1Caption&File 	TMenuItemitemFile_CreateDefaultConfigCaptionEdit Default &ConfigOnClick!itemFile_CreateDefaultConfigClick  	TMenuItemitemFile_UploadCaption&UploadShortCutU@OnClickbutnUploadClick  	TMenuItemN1Caption-  	TMenuItemitemFile_ExitCaptionE&xitOnClickitemFile_ExitClick     