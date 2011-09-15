object ColorForm: TColorForm
  Left = 255
  Top = 149
  AutoScroll = False
  Caption = 'Configure Colors & Font'
  ClientHeight = 399
  ClientWidth = 567
  Color = clBtnFace
  Constraints.MinHeight = 351
  Constraints.MinWidth = 469
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object ChatPanel: TPanel
    Left = 329
    Top = 0
    Width = 238
    Height = 399
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 10
    TabOrder = 0
    object Label15: TLabel
      Left = 10
      Top = 10
      Width = 218
      Height = 31
      Align = alTop
      AutoSize = False
      Caption = 'Example:'
      Layout = tlCenter
    end
    object InputEdit: TEdit
      Left = 26
      Top = 262
      Width = 149
      Height = 24
      AutoSelect = False
      ReadOnly = True
      TabOrder = 0
      Text = 'This is the input bar'
    end
    object Panel16: TPanel
      Left = 10
      Top = 348
      Width = 218
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object OKButton: TBitBtn
        Left = 11
        Top = 12
        Width = 94
        Height = 30
        Anchors = [akRight, akBottom]
        TabOrder = 0
        Kind = bkOK
      end
      object CancelButton: TBitBtn
        Left = 116
        Top = 12
        Width = 92
        Height = 30
        Anchors = [akRight, akBottom]
        TabOrder = 1
        OnClick = CancelButtonClick
        Kind = bkCancel
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 329
    Height = 399
    ActivePage = TabSheet3
    Align = alLeft
    HotTrack = True
    TabOrder = 1
    object TabSheet2: TTabSheet
      Caption = 'General'
      ImageIndex = 1
    end
    object TabSheet3: TTabSheet
      Caption = 'Ansi'
      ImageIndex = 2
      object Label11: TLabel
        Left = 10
        Top = 12
        Width = 115
        Height = 16
        Caption = 'Normal foreground:'
      end
      object Label12: TLabel
        Left = 167
        Top = 12
        Width = 122
        Height = 16
        Caption = 'Normal background:'
      end
      object Label16: TLabel
        Left = 10
        Top = 68
        Width = 99
        Height = 16
        Caption = 'Bold foreground:'
      end
      object Label17: TLabel
        Left = 167
        Top = 68
        Width = 106
        Height = 16
        Caption = 'Bold background:'
      end
      object Label13: TLabel
        Left = 10
        Top = 127
        Width = 99
        Height = 16
        Caption = 'Input foreground:'
      end
      object Label14: TLabel
        Left = 167
        Top = 127
        Width = 106
        Height = 16
        Caption = 'Input background:'
      end
      object DefFgCombo: TComboBox
        Left = 10
        Top = 31
        Width = 129
        Height = 24
        Style = csDropDownList
        DropDownCount = 16
        ItemHeight = 16
        TabOrder = 0
        OnChange = ChatDefChange
        Items.Strings = (
          'Black'
          'Maroon'
          'Green'
          'Olive'
          'Navy'
          'Purple'
          'Teal'
          'Gray'
          'Silver'
          'Red'
          'Lime'
          'Yellow'
          'Blue'
          'Fuchsia'
          'Aqua'
          'White')
      end
      object DefBgCombo: TComboBox
        Left = 167
        Top = 31
        Width = 130
        Height = 24
        Style = csDropDownList
        DropDownCount = 16
        ItemHeight = 16
        TabOrder = 1
        OnChange = ChatDefChange
        Items.Strings = (
          'Black'
          'Maroon'
          'Green'
          'Olive'
          'Navy'
          'Purple'
          'Teal'
          'Gray')
      end
      object ComboBox1: TComboBox
        Left = 10
        Top = 87
        Width = 129
        Height = 24
        Style = csDropDownList
        DropDownCount = 16
        ItemHeight = 16
        TabOrder = 2
        OnChange = ChatDefChange
        Items.Strings = (
          'Black'
          'Maroon'
          'Green'
          'Olive'
          'Navy'
          'Purple'
          'Teal'
          'Gray'
          'Silver'
          'Red'
          'Lime'
          'Yellow'
          'Blue'
          'Fuchsia'
          'Aqua'
          'White')
      end
      object ComboBox2: TComboBox
        Left = 167
        Top = 87
        Width = 130
        Height = 24
        Style = csDropDownList
        DropDownCount = 16
        ItemHeight = 16
        TabOrder = 3
        OnChange = ChatDefChange
        Items.Strings = (
          'Black'
          'Maroon'
          'Green'
          'Olive'
          'Navy'
          'Purple'
          'Teal'
          'Gray')
      end
      object InputFgCombo: TComboBox
        Left = 10
        Top = 146
        Width = 129
        Height = 24
        Style = csDropDownList
        DropDownCount = 16
        ItemHeight = 16
        TabOrder = 4
        OnChange = InputDefChange
        Items.Strings = (
          'Black'
          'Maroon'
          'Green'
          'Olive'
          'Navy'
          'Purple'
          'Teal'
          'Gray'
          'Silver'
          'Red'
          'Lime'
          'Yellow'
          'Blue'
          'Fuchsia'
          'Aqua'
          'White')
      end
      object InputBgCombo: TComboBox
        Left = 167
        Top = 146
        Width = 130
        Height = 24
        Style = csDropDownList
        DropDownCount = 16
        ItemHeight = 16
        TabOrder = 5
        OnChange = InputDefChange
        Items.Strings = (
          'Black'
          'Maroon'
          'Green'
          'Olive'
          'Navy'
          'Purple'
          'Teal'
          'Gray'
          'Silver'
          'Red'
          'Lime'
          'Yellow'
          'Blue'
          'Fuchsia'
          'Aqua'
          'White')
      end
      object ChatFontButton: TButton
        Left = 14
        Top = 207
        Width = 80
        Height = 26
        Caption = 'Font...'
        TabOrder = 6
        OnClick = ChatFontButtonClick
      end
      object InputFontButton: TButton
        Left = 14
        Top = 242
        Width = 80
        Height = 26
        Caption = 'Font...'
        TabOrder = 7
        OnClick = InputFontButtonClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Colors'
      object Label1: TLabel
        Left = 14
        Top = 12
        Width = 47
        Height = 16
        Caption = 'Normal:'
      end
      object Label2: TLabel
        Left = 139
        Top = 12
        Width = 31
        Height = 16
        Caption = 'Bold:'
      end
      object Label3: TLabel
        Left = 60
        Top = 41
        Width = 70
        Height = 32
        Alignment = taCenter
        AutoSize = False
        Caption = 'Black'
        Layout = tlCenter
      end
      object Label4: TLabel
        Left = 60
        Top = 81
        Width = 70
        Height = 30
        Alignment = taCenter
        AutoSize = False
        Caption = 'Red'
        Layout = tlCenter
      end
      object Label5: TLabel
        Left = 60
        Top = 121
        Width = 70
        Height = 30
        Alignment = taCenter
        AutoSize = False
        Caption = 'Green'
        Layout = tlCenter
      end
      object Label6: TLabel
        Left = 60
        Top = 159
        Width = 70
        Height = 31
        Alignment = taCenter
        AutoSize = False
        Caption = 'Yellow'
        Layout = tlCenter
      end
      object Label7: TLabel
        Left = 60
        Top = 199
        Width = 70
        Height = 31
        Alignment = taCenter
        AutoSize = False
        Caption = 'Blue'
        Layout = tlCenter
      end
      object Label8: TLabel
        Left = 60
        Top = 238
        Width = 70
        Height = 32
        Alignment = taCenter
        AutoSize = False
        Caption = 'Purple'
        Layout = tlCenter
      end
      object Label9: TLabel
        Left = 60
        Top = 278
        Width = 70
        Height = 30
        Alignment = taCenter
        AutoSize = False
        Caption = 'Cyan'
        Layout = tlCenter
      end
      object Label10: TLabel
        Left = 60
        Top = 318
        Width = 70
        Height = 30
        Alignment = taCenter
        AutoSize = False
        Caption = 'Gray'
        Layout = tlCenter
      end
      object Panel0: TPanel
        Left = 21
        Top = 41
        Width = 31
        Height = 32
        Color = clBlack
        TabOrder = 0
        OnClick = ChangeColor
      end
      object Panel1: TPanel
        Left = 21
        Top = 81
        Width = 31
        Height = 30
        Color = clMaroon
        TabOrder = 1
        OnClick = ChangeColor
      end
      object Panel2: TPanel
        Left = 21
        Top = 121
        Width = 31
        Height = 30
        Color = clGreen
        TabOrder = 2
        OnClick = ChangeColor
      end
      object Panel3: TPanel
        Left = 21
        Top = 159
        Width = 31
        Height = 31
        Color = clOlive
        TabOrder = 3
        OnClick = ChangeColor
      end
      object Panel4: TPanel
        Left = 21
        Top = 199
        Width = 31
        Height = 31
        Color = clNavy
        TabOrder = 4
        OnClick = ChangeColor
      end
      object Panel5: TPanel
        Left = 21
        Top = 238
        Width = 31
        Height = 32
        Color = clPurple
        TabOrder = 5
        OnClick = ChangeColor
      end
      object Panel6: TPanel
        Left = 21
        Top = 278
        Width = 31
        Height = 30
        Color = clTeal
        TabOrder = 6
        OnClick = ChangeColor
      end
      object Panel7: TPanel
        Left = 21
        Top = 318
        Width = 31
        Height = 30
        Color = clGray
        TabOrder = 7
        OnClick = ChangeColor
      end
      object Panel8: TPanel
        Left = 139
        Top = 41
        Width = 31
        Height = 32
        Color = clSilver
        TabOrder = 8
        OnClick = ChangeColor
      end
      object Panel9: TPanel
        Left = 139
        Top = 81
        Width = 31
        Height = 30
        Color = clRed
        TabOrder = 9
        OnClick = ChangeColor
      end
      object Panel10: TPanel
        Left = 139
        Top = 121
        Width = 31
        Height = 30
        Color = clLime
        TabOrder = 10
        OnClick = ChangeColor
      end
      object Panel11: TPanel
        Left = 139
        Top = 159
        Width = 31
        Height = 31
        Color = clYellow
        TabOrder = 11
        OnClick = ChangeColor
      end
      object Panel12: TPanel
        Left = 139
        Top = 199
        Width = 31
        Height = 31
        Color = clBlue
        TabOrder = 12
        OnClick = ChangeColor
      end
      object Panel13: TPanel
        Left = 139
        Top = 238
        Width = 31
        Height = 32
        Color = clFuchsia
        TabOrder = 13
        OnClick = ChangeColor
      end
      object Panel14: TPanel
        Left = 139
        Top = 278
        Width = 31
        Height = 30
        Color = clAqua
        TabOrder = 14
        OnClick = ChangeColor
      end
      object Panel15: TPanel
        Left = 139
        Top = 318
        Width = 31
        Height = 30
        Color = clWhite
        TabOrder = 15
        OnClick = ChangeColor
      end
    end
  end
  object ColorDialog: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen, cdSolidColor]
    Left = 236
    Top = 8
  end
  object InputFont: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Options = [fdAnsiOnly, fdFixedPitchOnly, fdForceFontExist]
    Left = 204
    Top = 8
  end
  object ChatFont: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Options = [fdAnsiOnly, fdFixedPitchOnly, fdForceFontExist]
    Left = 172
    Top = 8
  end
end
