object ViewOptForm: TViewOptForm
  Left = 782
  Top = 84
  BorderStyle = bsDialog
  BorderWidth = 10
  Caption = 'Theme Options'
  ClientHeight = 374
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 475
    Height = 17
    Align = alTop
    AutoSize = False
    Caption = 'Category:'
  end
  object Panel_2: TPanel
    Left = 105
    Top = 17
    Width = 10
    Height = 317
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
  end
  object Panel_3: TPanel
    Left = 0
    Top = 334
    Width = 475
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Image1: TImage
      Left = 0
      Top = 13
      Width = 32
      Height = 32
      AutoSize = True
      Picture.Data = {
        055449636F6E0000010002001010100000000000280100002600000020201000
        00000000E80200004E0100002800000010000000200000000100040000000000
        C000000000000000000000001000000010000000000000000000800000800000
        00808000800000008000800080800000C0C0C000808080000000FF0000FF0000
        00FFFF00FF000000FF00FF00FFFF0000FFFFFF000100F0000000000099100F00
        000000009F710F00000000000990F700000000000000108F0000000000091110
        FF0000000009911108F0000000009919108F0000000099919100F00000009999
        19100F0000000999919100F0000009999919100F000000999991100F00000097
        9919100F00000009F79110F00000000099108F0087FF000003FF000003FF0000
        83FF0000F0FF0000E03F0000E01F0000F00F0000F0070000F0030000F8010000
        F8000000FC000000FC000000FE010000FF030000280000002000000040000000
        0100040000000000800200000000000000000000100000001000000000000000
        000080000080000000808000800000008000800080800000C0C0C00080808000
        0000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000990008
        F00000000000000000000000099191100F000000000000000000000099991911
        08F0000000000000000000009799919110F0000000000000000000009F999911
        10F00000000000000000000097F9999108F000000000000000000000097F7910
        0F000000000000000000000000999908F0FFF000000000000000000000000000
        01108FF00000000000000000000000001111108F000000000000000000000009
        91911100FF00000000000000000000099919111007F000000000000000000009
        99999111008F00000000000000000009999999191100FF000000000000000000
        99999991911007F00000000000000000999999991911008F0000000000000000
        0999999991911100F00000000000000009999999991911100F00000000000000
        009999999991911100F00000000000000099999999991911100F000000000000
        00999999999991911100F00000000000000999999999991911100F0000000000
        000999999999999191110700000000000000999999999919111100F000000000
        0000997999999991911100F0000000000000099999999999191100F000000000
        0000099779999991911100F00000000000000099F79999991910070000000000
        000000999F7F999191100F000000000000000009997F7F191908F00000000000
        0000000099999990008F00000000000000000000009991188F000000C07FFFFF
        803FFFFF001FFFFF001FFFFF001FFFFF001FFFFF803FFFFFC047FFFFFF81FFFF
        FF00FFFFFE003FFFFE001FFFFE000FFFFE0003FFFF0001FFFF0000FFFF80007F
        FF80003FFFC0001FFFC0000FFFC00007FFE00003FFE00003FFF00001FFF00001
        FFF80001FFF80001FFFC0003FFFC0003FFFE0007FFFF000FFFFFC03F}
    end
    object OKButton: TBitBtn
      Left = 311
      Top = 14
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      TabOrder = 0
      OnClick = OKButtonClick
      Kind = bkOK
    end
    object CancelButton: TBitBtn
      Left = 399
      Top = 14
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Panel_4: TPanel
    Left = 115
    Top = 17
    Width = 360
    Height = 317
    Align = alClient
    BorderWidth = 2
    FullRepaint = False
    TabOrder = 2
    object PageControl: TPageControl
      Left = 3
      Top = 23
      Width = 354
      Height = 291
      ActivePage = TabWindow
      Align = alClient
      Style = tsButtons
      TabOrder = 0
      object TabTheme: TTabSheet
        Caption = 'General Options for this theme'
        TabVisible = False
        object GroupBox3: TGroupBox
          Left = 7
          Top = 7
          Width = 332
          Height = 111
          Caption = ' Theme '
          TabOrder = 0
          object Label23: TLabel
            Left = 13
            Top = 23
            Width = 56
            Height = 13
            Caption = 'Description:'
          end
          object Label35: TLabel
            Left = 13
            Top = 52
            Width = 45
            Height = 13
            Caption = 'Filename:'
          end
          object FileNameLabel: TLabel
            Left = 81
            Top = 52
            Width = 238
            Height = 14
            AutoSize = False
            Caption = 'Unnamed (yet)'
          end
          object ThemeDescrEdit: TEdit
            Left = 81
            Top = 19
            Width = 238
            Height = 21
            TabOrder = 0
          end
          object SaveAsButton: TButton
            Left = 81
            Top = 78
            Width = 68
            Height = 20
            Caption = 'Save as...'
            TabOrder = 2
            OnClick = SaveAsButtonClick
          end
          object ImportButton: TButton
            Left = 156
            Top = 78
            Width = 61
            Height = 20
            Caption = 'Import...'
            TabOrder = 3
            OnClick = ImportButtonClick
          end
          object ResetButton: TButton
            Left = 224
            Top = 78
            Width = 95
            Height = 20
            Caption = 'Reset to defaults'
            TabOrder = 4
            OnClick = ResetButtonClick
          end
          object SaveButton: TButton
            Left = 13
            Top = 78
            Width = 61
            Height = 20
            Caption = 'Save'
            TabOrder = 1
            OnClick = SaveButtonClick
          end
        end
      end
      object TabWindow: TTabSheet
        Caption = 'Window Options'
        ImageIndex = 4
        TabVisible = False
        OnShow = TabWindowShow
        object IndentBox: TCheckBox
          Left = 13
          Top = 20
          Width = 144
          Height = 17
          Hint = 'Add the following character(s) to the wrapped part of the lines'
          Caption = 'Indent wrapped lines with:'
          TabOrder = 0
          OnClick = IndentBoxClick
        end
        object IndentEdit: TEdit
          Left = 157
          Top = 20
          Width = 49
          Height = 21
          Color = clBtnFace
          Enabled = False
          TabOrder = 1
          Text = '>'
        end
        object HorScrollBox: TCheckBox
          Left = 13
          Top = 52
          Width = 209
          Height = 14
          Hint = 'Useful in MOO'#39's that support the [nowrap] ansi-tag'
          Caption = 'Enable horizontal scrollbar'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object ScrollThroughBox: TCheckBox
          Left = 13
          Top = 117
          Width = 209
          Height = 13
          Hint = 
            'When enabled, you can vertically scroll down past the end of the' +
            ' lines'
          Caption = 'Scroll-through'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object AutoCopyBox: TCheckBox
          Left = 13
          Top = 85
          Width = 209
          Height = 13
          Hint = 
            'Enable this option if you don'#39't like having to rightclick and hi' +
            't Copy after selecting text'
          Caption = 'Autocopy text on selecting'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object AlignBtmBox: TCheckBox
          Left = 13
          Top = 149
          Width = 209
          Height = 13
          Hint = 
            'Add a few pixels at the top to get the text aligned to the botto' +
            'm'
          Caption = 'Align text to bottom'
          Enabled = False
          TabOrder = 5
          Visible = False
        end
      end
      object TabFont: TTabSheet
        Caption = 'Font Options'
        ImageIndex = 6
        TabVisible = False
        OnShow = TabFontShow
        object GroupBox1: TGroupBox
          Left = 8
          Top = 8
          Width = 329
          Height = 123
          Caption = ' Normal text '
          TabOrder = 0
          object Label19: TLabel
            Left = 16
            Top = 32
            Width = 24
            Height = 13
            Caption = 'Font:'
          end
          object Label20: TLabel
            Left = 16
            Top = 56
            Width = 23
            Height = 13
            Caption = 'Size:'
          end
          object ChatExample: TLabel
            Left = 176
            Top = 80
            Width = 137
            Height = 33
            Alignment = taCenter
            AutoSize = False
            Caption = 'Example'
            Layout = tlCenter
          end
          object ChatFontCombo: TFontComboBox
            Left = 56
            Top = 28
            Width = 145
            Height = 20
            Options = [foFixedPitchOnly]
            TabOrder = 0
            OnChange = ChatFontComboChange
          end
          object ChatSizeEdit: TRxSpinEdit
            Left = 56
            Top = 52
            Width = 57
            Height = 21
            MaxValue = 72
            MinValue = 3
            Value = 10
            TabOrder = 1
            OnChange = ChatFontComboChange
          end
          object ChatBoldBox: TCheckBox
            Left = 56
            Top = 88
            Width = 57
            Height = 17
            Caption = 'Bold'
            TabOrder = 2
            OnClick = ChatBoldBoxClick
            OnKeyPress = ChatBoldBoxKeyPress
          end
        end
        object FontInputBox: TGroupBox
          Left = 8
          Top = 152
          Width = 329
          Height = 121
          Caption = ' Input bar '
          TabOrder = 1
          object Label21: TLabel
            Left = 16
            Top = 32
            Width = 24
            Height = 13
            Caption = 'Font:'
          end
          object Label22: TLabel
            Left = 16
            Top = 56
            Width = 23
            Height = 13
            Caption = 'Size:'
          end
          object InputExample: TLabel
            Left = 176
            Top = 80
            Width = 137
            Height = 33
            Alignment = taCenter
            AutoSize = False
            Caption = 'Example'
            Layout = tlCenter
          end
          object InputFontCombo: TFontComboBox
            Left = 56
            Top = 28
            Width = 145
            Height = 20
            Options = [foNoSymbolFonts]
            TabOrder = 0
            OnChange = ChatFontComboChange
          end
          object InputSizeEdit: TRxSpinEdit
            Left = 56
            Top = 52
            Width = 57
            Height = 21
            MaxValue = 72
            MinValue = 3
            Value = 10
            TabOrder = 1
            OnChange = ChatFontComboChange
          end
          object InputBoldBox: TCheckBox
            Left = 56
            Top = 88
            Width = 57
            Height = 17
            Caption = 'Bold'
            TabOrder = 2
            OnClick = ChatBoldBoxClick
            OnKeyPress = ChatBoldBoxKeyPress
          end
        end
      end
      object TabColors: TTabSheet
        Caption = 'Color Options'
        ImageIndex = 1
        TabVisible = False
        object ColorsInputBox: TGroupBox
          Left = 7
          Top = 92
          Width = 332
          Height = 52
          Caption = ' Input bar '
          TabOrder = 1
          object Label14: TLabel
            Left = 15
            Top = 23
            Width = 57
            Height = 13
            Caption = 'Foreground:'
          end
          object Label18: TLabel
            Left = 168
            Top = 23
            Width = 61
            Height = 13
            Caption = 'Background:'
          end
          object InputFgCombo: TComboBox
            Left = 80
            Top = 19
            Width = 77
            Height = 21
            Style = csDropDownList
            DropDownCount = 16
            ItemHeight = 13
            TabOrder = 0
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
            Left = 240
            Top = 19
            Width = 77
            Height = 21
            Style = csDropDownList
            DropDownCount = 16
            ItemHeight = 13
            TabOrder = 1
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
        end
        object AnsiEnableGroup: TRadioGroup
          Left = 7
          Top = 7
          Width = 332
          Height = 78
          Caption = ' Ansi colors '
          ItemIndex = 0
          Items.Strings = (
            'Enabled'
            'Disabled, but filtered out (a bit boring)'
            'Disabled, and don'#39't filter (ugly mode)')
          TabOrder = 0
        end
        object ColorsSelectionBox: TGroupBox
          Left = 7
          Top = 150
          Width = 332
          Height = 52
          Caption = ' Selection '
          TabOrder = 2
          object Label13: TLabel
            Left = 15
            Top = 23
            Width = 57
            Height = 13
            Caption = 'Foreground:'
          end
          object Label16: TLabel
            Left = 168
            Top = 23
            Width = 61
            Height = 13
            Caption = 'Background:'
          end
          object SelFgCombo: TComboBox
            Left = 80
            Top = 19
            Width = 77
            Height = 21
            Style = csDropDownList
            DropDownCount = 16
            ItemHeight = 13
            TabOrder = 0
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
          object SelBgCombo: TComboBox
            Left = 240
            Top = 19
            Width = 77
            Height = 21
            Style = csDropDownList
            DropDownCount = 16
            ItemHeight = 13
            TabOrder = 1
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
        end
        object GroupBox5: TGroupBox
          Left = 7
          Top = 208
          Width = 332
          Height = 72
          Caption = 'Miscellaneous'
          TabOrder = 3
          object BlinkBox: TCheckBox
            Left = 13
            Top = 26
            Width = 105
            Height = 14
            Caption = 'Enable blinking'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object BeepBox: TCheckBox
            Left = 13
            Top = 46
            Width = 105
            Height = 13
            Caption = 'Enable beep'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
        end
      end
      object TabColorFg: TTabSheet
        Caption = 'Colors used for the foreground'
        ImageIndex = 2
        TabVisible = False
        object Label2: TLabel
          Left = 3
          Top = 2
          Width = 36
          Height = 13
          Caption = 'Normal:'
        end
        object Label10: TLabel
          Left = 41
          Top = 250
          Width = 57
          Height = 25
          Alignment = taCenter
          AutoSize = False
          Caption = 'Gray'
          Layout = tlCenter
        end
        object Label8: TLabel
          Left = 41
          Top = 185
          Width = 57
          Height = 26
          Alignment = taCenter
          AutoSize = False
          Caption = 'Purple'
          Layout = tlCenter
        end
        object Label9: TLabel
          Left = 41
          Top = 218
          Width = 57
          Height = 24
          Alignment = taCenter
          AutoSize = False
          Caption = 'Cyan'
          Layout = tlCenter
        end
        object Label7: TLabel
          Left = 41
          Top = 154
          Width = 57
          Height = 25
          Alignment = taCenter
          AutoSize = False
          Caption = 'Blue'
          Layout = tlCenter
        end
        object Label6: TLabel
          Left = 41
          Top = 121
          Width = 57
          Height = 25
          Alignment = taCenter
          AutoSize = False
          Caption = 'Yellow'
          Layout = tlCenter
        end
        object Label5: TLabel
          Left = 41
          Top = 90
          Width = 57
          Height = 25
          Alignment = taCenter
          AutoSize = False
          Caption = 'Green'
          Layout = tlCenter
        end
        object Label4: TLabel
          Left = 41
          Top = 58
          Width = 57
          Height = 24
          Alignment = taCenter
          AutoSize = False
          Caption = 'Red'
          Layout = tlCenter
        end
        object Label11: TLabel
          Left = 41
          Top = 25
          Width = 57
          Height = 26
          Alignment = taCenter
          AutoSize = False
          Caption = 'Black'
          Layout = tlCenter
        end
        object Label3: TLabel
          Left = 105
          Top = 2
          Width = 25
          Height = 13
          Caption = 'High:'
        end
        object Label12: TLabel
          Left = 156
          Top = 24
          Width = 181
          Height = 81
          AutoSize = False
          Caption = 
            'You can configure how blue blue should be, for example.'#13#10'To do t' +
            'hat, just hit any of the colors on the left and select your choi' +
            'ce.'
          WordWrap = True
        end
        object Label36: TLabel
          Left = 156
          Top = 114
          Width = 90
          Height = 13
          Caption = 'Normal foreground:'
        end
        object Label37: TLabel
          Left = 156
          Top = 159
          Width = 79
          Height = 13
          Caption = 'High foreground:'
        end
        object PanelF0: TPanel
          Left = 9
          Top = 25
          Width = 25
          Height = 26
          Color = clBlack
          TabOrder = 0
          OnClick = ColorValueChange
        end
        object PanelF1: TPanel
          Left = 9
          Top = 58
          Width = 25
          Height = 24
          Color = clMaroon
          TabOrder = 1
          OnClick = ColorValueChange
        end
        object PanelF2: TPanel
          Left = 9
          Top = 90
          Width = 25
          Height = 25
          Color = clGreen
          TabOrder = 2
          OnClick = ColorValueChange
        end
        object PanelF3: TPanel
          Left = 9
          Top = 121
          Width = 25
          Height = 25
          Color = clOlive
          TabOrder = 3
          OnClick = ColorValueChange
        end
        object PanelF4: TPanel
          Left = 9
          Top = 154
          Width = 25
          Height = 25
          Color = clNavy
          TabOrder = 4
          OnClick = ColorValueChange
        end
        object PanelF5: TPanel
          Left = 9
          Top = 185
          Width = 25
          Height = 26
          Color = clPurple
          TabOrder = 5
          OnClick = ColorValueChange
        end
        object PanelF6: TPanel
          Left = 9
          Top = 218
          Width = 25
          Height = 24
          Color = clTeal
          TabOrder = 6
          OnClick = ColorValueChange
        end
        object PanelF7: TPanel
          Left = 9
          Top = 250
          Width = 25
          Height = 25
          Color = clGray
          TabOrder = 7
          OnClick = ColorValueChange
        end
        object PanelF8: TPanel
          Left = 105
          Top = 25
          Width = 25
          Height = 26
          Color = clSilver
          TabOrder = 8
          OnClick = ColorValueChange
        end
        object PanelF9: TPanel
          Left = 105
          Top = 58
          Width = 25
          Height = 24
          Color = clRed
          TabOrder = 9
          OnClick = ColorValueChange
        end
        object PanelF10: TPanel
          Left = 105
          Top = 90
          Width = 25
          Height = 25
          Color = clLime
          TabOrder = 10
          OnClick = ColorValueChange
        end
        object PanelF11: TPanel
          Left = 105
          Top = 121
          Width = 25
          Height = 25
          Color = clYellow
          TabOrder = 11
          OnClick = ColorValueChange
        end
        object PanelF12: TPanel
          Left = 105
          Top = 154
          Width = 25
          Height = 25
          Color = clBlue
          TabOrder = 12
          OnClick = ColorValueChange
        end
        object PanelF13: TPanel
          Left = 105
          Top = 185
          Width = 25
          Height = 26
          Color = clFuchsia
          TabOrder = 13
          OnClick = ColorValueChange
        end
        object PanelF14: TPanel
          Left = 105
          Top = 218
          Width = 25
          Height = 24
          Color = clAqua
          TabOrder = 14
          OnClick = ColorValueChange
        end
        object PanelF15: TPanel
          Left = 105
          Top = 250
          Width = 25
          Height = 25
          Color = clWhite
          TabOrder = 15
          OnClick = ColorValueChange
        end
        object NormalFgCombo: TComboBox
          Left = 156
          Top = 129
          Width = 105
          Height = 21
          Style = csDropDownList
          DropDownCount = 16
          ItemHeight = 13
          TabOrder = 16
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
        object BoldFgCombo: TComboBox
          Left = 156
          Top = 175
          Width = 105
          Height = 21
          Style = csDropDownList
          DropDownCount = 16
          ItemHeight = 13
          TabOrder = 17
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
        object AllHighBox: TCheckBox
          Left = 156
          Top = 260
          Width = 181
          Height = 14
          Caption = 'Convert all colors to high'
          TabOrder = 19
        end
        object BoldHighBox: TCheckBox
          Left = 156
          Top = 234
          Width = 181
          Height = 14
          Caption = 'Use bold font for high colors'
          TabOrder = 18
        end
      end
      object TabColorBg: TTabSheet
        Caption = 'Colors used for the background'
        ImageIndex = 7
        TabVisible = False
        object Label24: TLabel
          Left = 3
          Top = 2
          Width = 36
          Height = 13
          Caption = 'Normal:'
        end
        object Label25: TLabel
          Left = 105
          Top = 2
          Width = 25
          Height = 13
          Caption = 'High:'
        end
        object Label26: TLabel
          Left = 41
          Top = 250
          Width = 57
          Height = 25
          Alignment = taCenter
          AutoSize = False
          Caption = 'Gray'
          Layout = tlCenter
        end
        object Label27: TLabel
          Left = 41
          Top = 218
          Width = 57
          Height = 24
          Alignment = taCenter
          AutoSize = False
          Caption = 'Cyan'
          Layout = tlCenter
        end
        object Label28: TLabel
          Left = 41
          Top = 185
          Width = 57
          Height = 26
          Alignment = taCenter
          AutoSize = False
          Caption = 'Purple'
          Layout = tlCenter
        end
        object Label29: TLabel
          Left = 41
          Top = 154
          Width = 57
          Height = 25
          Alignment = taCenter
          AutoSize = False
          Caption = 'Blue'
          Layout = tlCenter
        end
        object Label30: TLabel
          Left = 41
          Top = 121
          Width = 57
          Height = 25
          Alignment = taCenter
          AutoSize = False
          Caption = 'Yellow'
          Layout = tlCenter
        end
        object Label31: TLabel
          Left = 41
          Top = 90
          Width = 57
          Height = 25
          Alignment = taCenter
          AutoSize = False
          Caption = 'Green'
          Layout = tlCenter
        end
        object Label32: TLabel
          Left = 41
          Top = 58
          Width = 57
          Height = 24
          Alignment = taCenter
          AutoSize = False
          Caption = 'Red'
          Layout = tlCenter
        end
        object Label33: TLabel
          Left = 41
          Top = 25
          Width = 57
          Height = 26
          Alignment = taCenter
          AutoSize = False
          Caption = 'Black'
          Layout = tlCenter
        end
        object Label15: TLabel
          Left = 156
          Top = 114
          Width = 96
          Height = 13
          Caption = 'Normal background:'
        end
        object Label17: TLabel
          Left = 156
          Top = 159
          Width = 85
          Height = 13
          Caption = 'High background:'
        end
        object Label34: TLabel
          Left = 156
          Top = 24
          Width = 181
          Height = 81
          AutoSize = False
          Caption = 
            'You can configure how blue blue should be, for example.'#13#10'To do t' +
            'hat, just hit any of the colors on the left and select your choi' +
            'ce.'
          WordWrap = True
        end
        object PanelB0: TPanel
          Left = 9
          Top = 25
          Width = 25
          Height = 26
          Color = clBlack
          TabOrder = 0
          OnClick = ColorValueChange
        end
        object PanelB8: TPanel
          Left = 105
          Top = 25
          Width = 25
          Height = 26
          Color = clSilver
          TabOrder = 8
          OnClick = ColorValueChange
        end
        object PanelB1: TPanel
          Left = 9
          Top = 58
          Width = 25
          Height = 24
          Color = clMaroon
          TabOrder = 1
          OnClick = ColorValueChange
        end
        object PanelB2: TPanel
          Left = 9
          Top = 90
          Width = 25
          Height = 25
          Color = clGreen
          TabOrder = 2
          OnClick = ColorValueChange
        end
        object PanelB3: TPanel
          Left = 9
          Top = 121
          Width = 25
          Height = 25
          Color = clOlive
          TabOrder = 3
          OnClick = ColorValueChange
        end
        object PanelB4: TPanel
          Left = 9
          Top = 154
          Width = 25
          Height = 25
          Color = clNavy
          TabOrder = 4
          OnClick = ColorValueChange
        end
        object PanelB5: TPanel
          Left = 9
          Top = 185
          Width = 25
          Height = 26
          Color = clPurple
          TabOrder = 5
          OnClick = ColorValueChange
        end
        object PanelB6: TPanel
          Left = 9
          Top = 218
          Width = 25
          Height = 24
          Color = clTeal
          TabOrder = 6
          OnClick = ColorValueChange
        end
        object PanelB7: TPanel
          Left = 9
          Top = 250
          Width = 25
          Height = 25
          Color = clGray
          TabOrder = 7
          OnClick = ColorValueChange
        end
        object PanelB9: TPanel
          Left = 105
          Top = 58
          Width = 25
          Height = 24
          Color = clRed
          TabOrder = 9
          OnClick = ColorValueChange
        end
        object PanelB10: TPanel
          Left = 105
          Top = 90
          Width = 25
          Height = 25
          Color = clLime
          TabOrder = 10
          OnClick = ColorValueChange
        end
        object PanelB11: TPanel
          Left = 105
          Top = 121
          Width = 25
          Height = 25
          Color = clYellow
          TabOrder = 11
          OnClick = ColorValueChange
        end
        object PanelB12: TPanel
          Left = 105
          Top = 154
          Width = 25
          Height = 25
          Color = clBlue
          TabOrder = 12
          OnClick = ColorValueChange
        end
        object PanelB13: TPanel
          Left = 105
          Top = 185
          Width = 25
          Height = 26
          Color = clFuchsia
          TabOrder = 13
          OnClick = ColorValueChange
        end
        object PanelB14: TPanel
          Left = 105
          Top = 218
          Width = 25
          Height = 24
          Color = clAqua
          TabOrder = 14
          OnClick = ColorValueChange
        end
        object PanelB15: TPanel
          Left = 105
          Top = 250
          Width = 25
          Height = 25
          Color = clWhite
          TabOrder = 15
          OnClick = ColorValueChange
        end
        object NormalBgCombo: TComboBox
          Left = 156
          Top = 129
          Width = 105
          Height = 21
          Style = csDropDownList
          DropDownCount = 16
          ItemHeight = 13
          TabOrder = 16
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
        object BoldBgCombo: TComboBox
          Left = 156
          Top = 175
          Width = 105
          Height = 21
          Style = csDropDownList
          DropDownCount = 16
          ItemHeight = 13
          TabOrder = 17
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
      end
      object TabBackground: TTabSheet
        Caption = 'Configure background-image'
        ImageIndex = 3
        TabVisible = False
        object ImgFileNameCaption: TLabel
          Left = 32
          Top = 88
          Width = 45
          Height = 13
          Caption = 'Filename:'
          Enabled = False
        end
        object StyleCaption: TLabel
          Left = 32
          Top = 112
          Width = 26
          Height = 13
          Caption = 'Style:'
          Enabled = False
        end
        object ImgOpacityLabel: TLabel
          Left = 32
          Top = 136
          Width = 39
          Height = 13
          Caption = 'Opacity:'
          Enabled = False
          Visible = False
        end
        object ImgPercentLabel: TLabel
          Left = 160
          Top = 136
          Width = 8
          Height = 13
          Caption = '%'
          Enabled = False
          Visible = False
        end
        object TranspOpacityLabel: TLabel
          Left = 32
          Top = 201
          Width = 39
          Height = 13
          Caption = 'Opacity:'
          Enabled = False
          Visible = False
        end
        object TranspPercentLabel: TLabel
          Left = 160
          Top = 201
          Width = 8
          Height = 13
          Caption = '%'
          Enabled = False
          Visible = False
        end
        object NoBackRadio: TRadioButton
          Left = 8
          Top = 16
          Width = 153
          Height = 17
          Caption = 'Use background color'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = NoBackRadioClick
        end
        object ImgRadio: TRadioButton
          Left = 8
          Top = 56
          Width = 153
          Height = 17
          Caption = 'Custom Image'
          TabOrder = 1
          OnClick = ImgRadioClick
        end
        object ImgFileNameEdit: TFilenameEdit
          Left = 96
          Top = 84
          Width = 145
          Height = 21
          OnAfterDialog = ImgFileNameEditAfterDialog
          DialogKind = dkOpenPicture
          Filter = 
            'Images (*.bmp, *.jpg, *.ico)|*.bmp;*.jpg;*.ico|All files (*.*)|*' +
            '.*'
          Color = clBtnFace
          Enabled = False
          NumGlyphs = 1
          TabOrder = 2
        end
        object ImgStyleCombo: TComboBox
          Left = 96
          Top = 108
          Width = 145
          Height = 21
          Style = csDropDownList
          Color = clBtnFace
          Enabled = False
          ItemHeight = 13
          TabOrder = 3
          Items.Strings = (
            'Normal - Centered'
            'Normal - Upperleft'
            'Stretched'
            'Stretched, keep aspect ratio'
            'Tiled')
        end
        object ImgOpacityEdit: TRxSpinEdit
          Left = 96
          Top = 132
          Width = 57
          Height = 21
          Decimal = 0
          MaxValue = 100
          Value = 100
          Color = clBtnFace
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Visible = False
        end
        object TranspRadio: TRadioButton
          Left = 8
          Top = 176
          Width = 153
          Height = 17
          Caption = 'Transparent'
          Enabled = False
          TabOrder = 5
          Visible = False
          OnClick = TranspRadioClick
        end
        object TranspOpacityEdit: TRxSpinEdit
          Left = 96
          Top = 197
          Width = 57
          Height = 21
          Decimal = 0
          MaxValue = 100
          Value = 100
          Color = clBtnFace
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          Visible = False
        end
      end
      object TabExample: TTabSheet
        Caption = 'Example'
        ImageIndex = 5
        TabVisible = False
        OnShow = TabExampleShow
        object InputEdit: TEdit
          Left = 16
          Top = 88
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'This is the inputbar'
        end
      end
    end
    object TabCaption: TStaticText
      Left = 3
      Top = 3
      Width = 354
      Height = 20
      Align = alTop
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = 'General Options'
      Color = clBtnShadow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnFace
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 1
    end
  end
  object CategoryView: TTreeView
    Left = 0
    Top = 17
    Width = 105
    Height = 317
    Align = alLeft
    HideSelection = False
    HotTrack = True
    Indent = 19
    ReadOnly = True
    RowSelect = True
    TabOrder = 3
    OnChange = CategoryViewChange
    Items.Data = {
      060000001E0000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
      055468656D651F0000000000000000000000FFFFFFFFFFFFFFFF000000000000
      00000657696E646F771D0000000000000000000000FFFFFFFFFFFFFFFF000000
      000000000004466F6E741F0000000000000000000000FFFFFFFFFFFFFFFF0000
      00000200000006436F6C6F7273230000000000000000000000FFFFFFFFFFFFFF
      FF00000000000000000A466F726567726F756E64230000000000000000000000
      FFFFFFFFFFFFFFFF00000000000000000A4261636B67726F756E642200000000
      00000000000000FFFFFFFFFFFFFFFF00000000000000000957616C6C70617065
      72200000000000000000000000FFFFFFFFFFFFFFFF0000000000000000074578
      616D706C65}
  end
  object ColorDialog: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen, cdSolidColor]
    Left = 16
    Top = 184
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'mth'
    Filter = 'Moops themes (*.mth)|*.mth|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save theme'
    Left = 48
    Top = 184
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'mth'
    Filter = 'Moops themes (*.mth)|*.mth|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Import theme'
    Left = 80
    Top = 184
  end
end