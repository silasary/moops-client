object AddSessionForm: TAddSessionForm
  Left = 237
  Top = 194
  BorderStyle = bsDialog
  Caption = 'Add a script'
  ClientHeight = 146
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 129
    Height = 13
    Caption = 'What would you like to do?'
  end
  object FileNameLabel: TLabel
    Left = 48
    Top = 92
    Width = 31
    Height = 13
    Caption = 'Name:'
    Enabled = False
  end
  object BrowseButton: TSpeedButton
    Left = 240
    Top = 88
    Width = 23
    Height = 22
    Enabled = False
    Glyph.Data = {
      36020000424D3602000000000000360000002800000010000000100000000100
      10000000000000020000000000000000000000000000000000001F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000
      000000000000000000000000000000001F7C1F7C1F7C1F7C1F7C000000000042
      0042004200420042004200420042004200001F7C1F7C1F7C1F7C0000E07F0000
      00420042004200420042004200420042004200001F7C1F7C1F7C0000FF7FE07F
      000000420042004200420042004200420042004200001F7C1F7C0000E07FFF7F
      E07F000000420042004200420042004200420042004200001F7C0000FF7FE07F
      FF7FE07F000000000000000000000000000000000000000000000000E07FFF7F
      E07FFF7FE07FFF7FE07FFF7FE07F00001F7C1F7C1F7C1F7C1F7C0000FF7FE07F
      FF7FE07FFF7FE07FFF7FE07FFF7F00001F7C1F7C1F7C1F7C1F7C0000E07FFF7F
      E07F00000000000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C00000000
      00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C00001F7C00001F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C}
    OnClick = BrowseButtonClick
  end
  object DescrLabel: TLabel
    Left = 48
    Top = 116
    Width = 56
    Height = 13
    Caption = 'Description:'
    Enabled = False
  end
  object NewRadio: TRadioButton
    Left = 32
    Top = 40
    Width = 169
    Height = 17
    Caption = 'Create a new login-session'
    Checked = True
    TabOrder = 0
    TabStop = True
    OnClick = NewRadioClick
  end
  object OpenRadio: TRadioButton
    Left = 32
    Top = 64
    Width = 169
    Height = 17
    Caption = 'Add an existing script'
    TabOrder = 1
    OnClick = OpenRadioClick
  end
  object OKButton: TBitBtn
    Left = 304
    Top = 80
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkOK
  end
  object CancelButton: TBitBtn
    Left = 304
    Top = 112
    Width = 75
    Height = 25
    TabOrder = 5
    Kind = bkCancel
  end
  object FileNameEdit: TEdit
    Left = 112
    Top = 88
    Width = 121
    Height = 21
    Color = clBtnFace
    Enabled = False
    TabOrder = 2
    OnChange = EditChange
  end
  object DescrEdit: TEdit
    Left = 112
    Top = 112
    Width = 121
    Height = 21
    Color = clBtnFace
    Enabled = False
    TabOrder = 3
    OnChange = EditChange
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '.msc'
    Filter = 'Moops scripts (*.msc)|*.msc|All files (*.*)|*.*'#13#10'*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Select script to add'
    Left = 264
    Top = 88
  end
end
