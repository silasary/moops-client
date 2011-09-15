object SelSessionForm: TSelSessionForm
  Left = 338
  Top = 288
  ActiveControl = ScriptList
  BorderStyle = bsDialog
  Caption = 'Select script'
  ClientHeight = 205
  ClientWidth = 324
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
    Left = 8
    Top = 8
    Width = 165
    Height = 13
    Caption = 'Please select the script to execute:'
  end
  object ScriptList: TListBox
    Left = 8
    Top = 32
    Width = 217
    Height = 145
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = ScriptListDblClick
    OnKeyPress = ScriptListKeyPress
    OnMouseDown = ScriptListMouseDown
  end
  object OkButton: TBitBtn
    Left = 240
    Top = 32
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object CancelButton: TBitBtn
    Left = 240
    Top = 64
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
  object AddButton: TBitBtn
    Left = 240
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Add...'
    TabOrder = 3
    OnClick = AddButtonClick
  end
  object DelButton: TBitBtn
    Left = 240
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 4
    OnClick = DelButtonClick
  end
  object ShowOnStartupBox: TCheckBox
    Left = 8
    Top = 184
    Width = 217
    Height = 17
    Caption = 'Show this dialog on startup'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
end