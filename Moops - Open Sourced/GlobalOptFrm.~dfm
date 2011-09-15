object GlobalOptForm: TGlobalOptForm
  Left = 190
  Top = 118
  BorderStyle = bsDialog
  BorderWidth = 10
  Caption = 'Global Options'
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
      ActivePage = TabEditor
      Align = alClient
      Style = tsButtons
      TabOrder = 0
      object TabGeneral: TTabSheet
        Caption = 'General Options'
        TabVisible = False
        object Label5: TLabel
          Left = 39
          Top = 137
          Width = 63
          Height = 13
          Caption = 'Default ident:'
        end
        object StatusHintBox: TCheckBox
          Left = 13
          Top = 13
          Width = 124
          Height = 17
          Hint = 'Show popups for the icons in the statusbar'
          Caption = 'Show statushints'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object VerCheckBox: TCheckBox
          Left = 13
          Top = 46
          Width = 124
          Height = 17
          Caption = 'Enable versioncheck'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object IdentCheckBox: TCheckBox
          Left = 13
          Top = 111
          Width = 79
          Height = 13
          Caption = 'Enable ident server'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object DefIdentEdit: TEdit
          Left = 111
          Top = 133
          Width = 130
          Height = 21
          TabOrder = 3
        end
        object MvCaptionBox: TCheckBox
          Left = 13
          Top = 78
          Width = 124
          Height = 14
          Caption = 'Mooving caption'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
      end
      object TabStartup: TTabSheet
        Caption = 'Startup Options'
        ImageIndex = 1
        TabVisible = False
        object ShowSessionBox: TCheckBox
          Left = 13
          Top = 13
          Width = 121
          Height = 17
          Caption = 'Show session-list'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object ShowSplashBox: TCheckBox
          Left = 13
          Top = 46
          Width = 124
          Height = 13
          Caption = 'Show splashscreen'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
      end
      object TabConnection: TTabSheet
        Caption = 'Proxy settings'
        ImageIndex = 2
        TabVisible = False
        object ProxyLabel1: TLabel
          Left = 16
          Top = 45
          Width = 61
          Height = 13
          Caption = 'Proxy server:'
          Enabled = False
        end
        object ProxyLabel2: TLabel
          Left = 16
          Top = 70
          Width = 22
          Height = 13
          Caption = 'Port:'
          Enabled = False
        end
        object ProxyLabel3: TLabel
          Left = 16
          Top = 95
          Width = 50
          Height = 13
          Caption = 'Command:'
          Enabled = False
        end
        object ProxyNoteLabel: TLabel
          Left = 8
          Top = 215
          Width = 329
          Height = 66
          AutoSize = False
          Caption = 
            'Note:'#13#10'You can use the following '#39'variables'#39' in your proxy comma' +
            'nd:'#13#10'%server% = server to connect to, %port% = port to connect t' +
            'o'#13#10'(%user% = proxy-user, %pass% = proxy-pass)'#13#10'%newline% = send ' +
            'a CR+LF'
          Visible = False
          WordWrap = True
        end
        object Label2: TLabel
          Left = 16
          Top = 16
          Width = 80
          Height = 13
          Caption = 'Connection type:'
        end
        object ProxyLabel4: TLabel
          Left = 32
          Top = 157
          Width = 51
          Height = 13
          Caption = 'Username:'
          Enabled = False
        end
        object ProxyLabel5: TLabel
          Left = 32
          Top = 182
          Width = 49
          Height = 13
          Caption = 'Password:'
          Enabled = False
        end
        object ProxyServer: TEdit
          Left = 104
          Top = 41
          Width = 161
          Height = 21
          Color = clBtnFace
          Enabled = False
          TabOrder = 0
        end
        object ProxyPort: TRxSpinEdit
          Left = 104
          Top = 66
          Width = 66
          Height = 21
          MaxValue = 65535
          MinValue = 1
          Value = 23
          Color = clBtnFace
          Enabled = False
          TabOrder = 1
        end
        object ProxyCmd: TEdit
          Left = 104
          Top = 91
          Width = 161
          Height = 21
          Color = clBtnFace
          Enabled = False
          TabOrder = 2
          Text = 'c %server% %port%'
        end
        object ConnectCombo: TComboBox
          Left = 104
          Top = 12
          Width = 161
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 3
          OnChange = ConnectComboChange
          Items.Strings = (
            'Direct'
            'Socks4'
            'Socks4A'
            'Socks5'
            'Simple Proxy')
        end
        object ProxyAuthBox: TCheckBox
          Left = 16
          Top = 128
          Width = 161
          Height = 17
          Caption = 'Authentication required'
          Enabled = False
          TabOrder = 4
          OnClick = ProxyAuthBoxClick
          OnKeyPress = ProxyAuthBoxKeyPress
        end
        object ProxyUser: TEdit
          Left = 104
          Top = 153
          Width = 137
          Height = 21
          Color = clBtnFace
          Enabled = False
          TabOrder = 5
        end
        object ProxyPass: TEdit
          Left = 104
          Top = 178
          Width = 137
          Height = 21
          Color = clBtnFace
          Enabled = False
          PasswordChar = '*'
          TabOrder = 6
        end
        object ProxyAskPwBox: TCheckBox
          Left = 104
          Top = 202
          Width = 137
          Height = 13
          Caption = 'Ask for password'
          Enabled = False
          TabOrder = 7
          OnClick = ProxyAskPwBoxClick
          OnKeyPress = ProxyAskPwBoxKeyPress
        end
      end
      object TabEditor: TTabSheet
        Caption = 'Editor'
        ImageIndex = 3
        TabVisible = False
        OnShow = TabEditorShow
        object GroupBox1: TGroupBox
          Left = 8
          Top = 8
          Width = 329
          Height = 123
          Caption = 'Editor text'
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
          object EditorExample: TLabel
            Left = 176
            Top = 80
            Width = 137
            Height = 33
            Alignment = taCenter
            AutoSize = False
            Caption = 'Example'
            Layout = tlCenter
          end
          object EditorFontCombo: TFontComboBox
            Left = 56
            Top = 28
            Width = 145
            Height = 20
            Options = [foFixedPitchOnly]
            TabOrder = 0
            OnChange = EditorFontChange
          end
          object EditorSizeEdit: TRxSpinEdit
            Left = 56
            Top = 52
            Width = 57
            Height = 21
            MaxValue = 72
            MinValue = 3
            Value = 10
            TabOrder = 1
            OnChange = EditorFontChange
          end
          object EditorBoldBox: TCheckBox
            Left = 56
            Top = 88
            Width = 57
            Height = 17
            Caption = 'Bold'
            TabOrder = 2
            OnClick = EditorFontChange
            OnKeyPress = EditorBoldBoxKeyPress
          end
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
      04000000200000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
      0747656E6572616C200000000000000000000000FFFFFFFFFFFFFFFF00000000
      0000000007537461727475701E0000000000000000000000FFFFFFFFFFFFFFFF
      00000000000000000550726F78791F0000000000000000000000FFFFFFFFFFFF
      FFFF000000000000000006456469746F72}
  end
  object WinshoeClient1: TWinshoeClient
    Port = 0
    SSLEnabled = False
    BufferChunk = 8192
    SocksPort = 0
    SocksVersion = svNoSocks
    SocksAuthentication = saNoAuthentication
    Left = 34
    Top = 134
  end
end
