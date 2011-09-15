object CreateSessionForm: TCreateSessionForm
  Left = 245
  Top = 179
  BorderStyle = bsDialog
  Caption = 'Create a session'
  ClientHeight = 335
  ClientWidth = 389
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
    Top = 20
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object Label2: TLabel
    Left = 16
    Top = 132
    Width = 34
    Height = 13
    Caption = 'Server:'
  end
  object Label3: TLabel
    Left = 16
    Top = 156
    Width = 22
    Height = 13
    Caption = 'Port:'
  end
  object Label4: TLabel
    Left = 16
    Top = 44
    Width = 56
    Height = 13
    Caption = 'Description:'
  end
  object Label5: TLabel
    Left = 32
    Top = 212
    Width = 61
    Height = 13
    Caption = 'Proxy server:'
    Enabled = False
  end
  object Label6: TLabel
    Left = 32
    Top = 236
    Width = 22
    Height = 13
    Caption = 'Port:'
    Enabled = False
  end
  object Label7: TLabel
    Left = 16
    Top = 76
    Width = 51
    Height = 13
    Caption = 'Username:'
  end
  object Label8: TLabel
    Left = 16
    Top = 100
    Width = 49
    Height = 13
    Caption = 'Password:'
  end
  object Label9: TLabel
    Left = 280
    Top = 16
    Width = 78
    Height = 13
    Caption = '(e.g. MySession)'
  end
  object Label10: TLabel
    Left = 32
    Top = 260
    Width = 50
    Height = 13
    Caption = 'Command:'
    Enabled = False
  end
  object ProxyBox: TCheckBox
    Left = 16
    Top = 184
    Width = 169
    Height = 17
    Caption = 'Connect through proxy'
    TabOrder = 6
    OnClick = ProxyBoxClick
  end
  object LogBox: TCheckBox
    Left = 16
    Top = 296
    Width = 169
    Height = 17
    Caption = 'Enable logging'
    Checked = True
    State = cbChecked
    TabOrder = 10
  end
  object FileNameEdit: TEdit
    Left = 80
    Top = 16
    Width = 185
    Height = 21
    TabOrder = 0
    OnChange = EditChange
  end
  object DescrEdit: TEdit
    Left = 80
    Top = 40
    Width = 185
    Height = 21
    TabOrder = 1
    OnChange = EditChange
  end
  object ServerEdit: TEdit
    Left = 80
    Top = 128
    Width = 185
    Height = 21
    TabOrder = 4
    OnChange = EditChange
  end
  object PortEdit: TEdit
    Left = 80
    Top = 152
    Width = 65
    Height = 21
    TabOrder = 5
    Text = '1111'
    OnChange = EditChange
  end
  object ProxyServer: TEdit
    Left = 104
    Top = 208
    Width = 161
    Height = 21
    Color = clBtnFace
    Enabled = False
    TabOrder = 7
    OnChange = EditChange
  end
  object ProxyPort: TEdit
    Left = 104
    Top = 232
    Width = 65
    Height = 21
    Color = clBtnFace
    Enabled = False
    TabOrder = 8
    Text = '23'
    OnChange = EditChange
  end
  object UserEdit: TEdit
    Left = 80
    Top = 72
    Width = 185
    Height = 21
    TabOrder = 2
    OnChange = EditChange
  end
  object PassEdit: TEdit
    Left = 80
    Top = 96
    Width = 185
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
    OnChange = EditChange
  end
  object OKButton: TBitBtn
    Left = 304
    Top = 224
    Width = 75
    Height = 25
    TabOrder = 11
    OnClick = OKButtonClick
    Kind = bkOK
  end
  object CancelButton: TBitBtn
    Left = 304
    Top = 256
    Width = 75
    Height = 25
    TabOrder = 12
    Kind = bkCancel
  end
  object ProxyCmd: TEdit
    Left = 104
    Top = 256
    Width = 161
    Height = 21
    Color = clBtnFace
    Enabled = False
    TabOrder = 9
    Text = 'c'
    OnChange = EditChange
  end
end
