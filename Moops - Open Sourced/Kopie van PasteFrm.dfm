object PasteForm: TPasteForm
  Left = 302
  Top = 167
  AutoScroll = False
  Caption = 'Paste text'
  ClientHeight = 332
  ClientWidth = 436
  Color = clBtnFace
  Constraints.MinHeight = 359
  Constraints.MinWidth = 444
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 65
    Height = 16
    Caption = 'Command:'
  end
  object Label2: TLabel
    Left = 8
    Top = 52
    Width = 36
    Height = 16
    Caption = 'Prefix:'
  end
  object Label3: TLabel
    Left = 8
    Top = 87
    Width = 29
    Height = 16
    Caption = 'Text:'
  end
  object Label4: TLabel
    Left = 303
    Top = 13
    Width = 52
    Height = 16
    Caption = 'End with:'
  end
  object CmdCombo: TComboBox
    Left = 77
    Top = 8
    Width = 178
    Height = 24
    ItemHeight = 16
    TabOrder = 0
    Text = '@paste'
    Items.Strings = (
      '@paste'
      '@chanpaste'
      '@pastecode')
  end
  object PrefixEdit: TEdit
    Left = 77
    Top = 47
    Width = 99
    Height = 24
    TabOrder = 1
  end
  object TextMemo: TMemo
    Left = 8
    Top = 106
    Width = 417
    Height = 175
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 2
    WordWrap = False
  end
  object EndEdit: TEdit
    Left = 372
    Top = 8
    Width = 51
    Height = 24
    TabOrder = 3
    Text = '.'
  end
  object OKButton: TBitBtn
    Left = 6
    Top = 295
    Width = 92
    Height = 31
    Anchors = [akLeft, akBottom]
    TabOrder = 4
    Kind = bkOK
  end
  object CancelButton: TBitBtn
    Left = 103
    Top = 295
    Width = 92
    Height = 31
    Anchors = [akLeft, akBottom]
    TabOrder = 5
    Kind = bkCancel
  end
end
