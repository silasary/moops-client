object SessionOptForm: TSessionOptForm
  Left = 741
  Top = 132
  BorderStyle = bsDialog
  BorderWidth = 10
  Caption = 'Session Options'
  ClientHeight = 374
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
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
    TabOrder = 3
  end
  object Panel_3: TPanel
    Left = 0
    Top = 334
    Width = 475
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
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
    TabOrder = 1
    object PageControl: TPageControl
      Left = 3
      Top = 23
      Width = 354
      Height = 291
      ActivePage = TabProxy
      Align = alClient
      Style = tsButtons
      TabOrder = 0
      object TabGeneral: TTabSheet
        Caption = 'General Options'
        TabVisible = False
        object GroupBox3: TGroupBox
          Left = 7
          Top = 7
          Width = 332
          Height = 156
          Caption = ' Session '
          TabOrder = 0
          object Label27: TLabel
            Left = 13
            Top = 23
            Width = 56
            Height = 13
            Caption = 'Description:'
          end
          object Label35: TLabel
            Left = 13
            Top = 78
            Width = 45
            Height = 13
            Caption = 'Filename:'
          end
          object FileNameLabel: TLabel
            Left = 91
            Top = 78
            Width = 228
            Height = 14
            AutoSize = False
            Caption = 'Unnamed (yet)'
          end
          object Label29: TLabel
            Left = 13
            Top = 49
            Width = 66
            Height = 13
            Caption = 'Page caption:'
          end
          object SessionDescrEdit: TEdit
            Left = 91
            Top = 19
            Width = 228
            Height = 21
            TabOrder = 0
          end
          object SaveAsButton: TButton
            Left = 81
            Top = 124
            Width = 68
            Height = 20
            Caption = 'Save as...'
            TabOrder = 3
            OnClick = SaveAsButtonClick
          end
          object ImportButton: TButton
            Left = 156
            Top = 124
            Width = 61
            Height = 20
            Caption = 'Import...'
            TabOrder = 4
            OnClick = ImportButtonClick
          end
          object ResetButton: TButton
            Left = 224
            Top = 124
            Width = 95
            Height = 20
            Caption = 'Reset to defaults'
            TabOrder = 5
            OnClick = ResetButtonClick
          end
          object SaveButton: TButton
            Left = 13
            Top = 124
            Width = 61
            Height = 20
            Caption = 'Save'
            TabOrder = 2
            OnClick = SaveButtonClick
          end
          object PageCaptionEdit: TEdit
            Left = 91
            Top = 45
            Width = 228
            Height = 21
            TabOrder = 1
          end
        end
        object AutoStartBox: TCheckBox
          Left = 13
          Top = 189
          Width = 79
          Height = 13
          Hint = 'Automatically start this session when starting Moops'
          Caption = 'AutoStart'
          TabOrder = 1
        end
      end
      object TabAccount: TTabSheet
        Caption = 'Login Settings'
        ImageIndex = 1
        TabVisible = False
        object Label3: TLabel
          Left = 8
          Top = 14
          Width = 34
          Height = 13
          Caption = 'Server:'
        end
        object Label4: TLabel
          Left = 8
          Top = 38
          Width = 22
          Height = 13
          Caption = 'Port:'
        end
        object Label7: TLabel
          Left = 8
          Top = 84
          Width = 51
          Height = 13
          Caption = 'Username:'
        end
        object Label8: TLabel
          Left = 8
          Top = 107
          Width = 49
          Height = 13
          Caption = 'Password:'
        end
        object Label32: TLabel
          Left = 8
          Top = 180
          Width = 27
          Height = 13
          Caption = 'Ident:'
        end
        object ServerEdit: TEdit
          Left = 72
          Top = 10
          Width = 185
          Height = 21
          TabOrder = 4
        end
        object UserEdit: TEdit
          Left = 72
          Top = 80
          Width = 185
          Height = 21
          TabOrder = 0
          Text = 'guest'
        end
        object PassEdit: TEdit
          Left = 72
          Top = 103
          Width = 185
          Height = 21
          PasswordChar = '*'
          TabOrder = 1
        end
        object PortEdit: TRxSpinEdit
          Left = 72
          Top = 34
          Width = 66
          Height = 21
          MaxValue = 65535
          MinValue = 1
          Value = 1111
          TabOrder = 5
        end
        object IdentIDEdit: TEdit
          Left = 72
          Top = 176
          Width = 185
          Height = 21
          TabOrder = 3
          Text = 'Anonymous'
        end
        object AskPWBox: TCheckBox
          Left = 72
          Top = 130
          Width = 185
          Height = 14
          Caption = 'Ask for password'
          TabOrder = 2
          OnClick = AskPWBoxClick
          OnKeyPress = AskPWBoxKeyPress
        end
      end
      object TabProxy: TTabSheet
        Caption = 'Proxy server settings'
        ImageIndex = 5
        TabVisible = False
        object Label33: TLabel
          Left = 16
          Top = 16
          Width = 80
          Height = 13
          Caption = 'Connection type:'
        end
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
        object ConnectCombo: TComboBox
          Left = 104
          Top = 12
          Width = 161
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = ConnectComboChange
          Items.Strings = (
            'Direct'
            'Socks4'
            'Socks4A'
            'Socks5'
            'Simple Proxy'
            'Use Global Settings')
        end
        object ProxyServer: TEdit
          Left = 104
          Top = 41
          Width = 161
          Height = 21
          Color = clBtnFace
          Enabled = False
          TabOrder = 1
        end
        object ProxyAuthBox: TCheckBox
          Left = 16
          Top = 128
          Width = 161
          Height = 17
          Caption = 'Authentication required'
          Enabled = False
          TabOrder = 2
          OnClick = ProxyAuthBoxClick
          OnKeyPress = ProxyAuthBoxKeyPress
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
          TabOrder = 3
        end
        object ProxyCmd: TEdit
          Left = 104
          Top = 91
          Width = 161
          Height = 21
          Color = clBtnFace
          Enabled = False
          TabOrder = 4
          Text = 'c %server% %port%'
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
      object TabBuffer: TTabSheet
        Caption = 'Buffer and History Options'
        ImageIndex = 8
        TabVisible = False
        object GroupBox4: TGroupBox
          Left = 7
          Top = 7
          Width = 332
          Height = 150
          Caption = ' Screen buffer '
          TabOrder = 0
          object Label6: TLabel
            Left = 16
            Top = 23
            Width = 23
            Height = 13
            Caption = 'Size:'
          end
          object Label16: TLabel
            Left = 127
            Top = 23
            Width = 21
            Height = 13
            Caption = 'lines'
          end
          object ScreenBufEdit: TRxSpinEdit
            Left = 52
            Top = 21
            Width = 66
            Height = 21
            MaxValue = 30000
            MinValue = 10
            Value = 1000
            TabOrder = 0
          end
          object FollowRadio: TRadioGroup
            Left = 13
            Top = 52
            Width = 306
            Height = 85
            Caption = ' Follow mode '
            ItemIndex = 2
            Items.Strings = (
              'Follow Off'
              'Follow On'
              'Auto-follow')
            TabOrder = 1
          end
        end
        object GroupBox5: TGroupBox
          Left = 7
          Top = 169
          Width = 332
          Height = 105
          Caption = ' Input buffer '
          TabOrder = 1
          object Label10: TLabel
            Left = 16
            Top = 23
            Width = 23
            Height = 13
            Caption = 'Size:'
          end
          object Label28: TLabel
            Left = 127
            Top = 23
            Width = 21
            Height = 13
            Caption = 'lines'
          end
          object InputBufEdit: TRxSpinEdit
            Left = 52
            Top = 21
            Width = 66
            Height = 21
            MaxValue = 30000
            MinValue = 10
            Value = 500
            TabOrder = 0
          end
          object SelHistBox: TCheckBox
            Left = 20
            Top = 59
            Width = 169
            Height = 13
            Caption = 'Enable selective history'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object SaveHistBox: TCheckBox
            Left = 20
            Top = 78
            Width = 169
            Height = 14
            Hint = 'Automatically save/load on close/load'
            Caption = 'Save to file'
            TabOrder = 2
          end
        end
      end
      object TabCommands: TTabSheet
        Caption = 'Customize commands'
        ImageIndex = 6
        TabVisible = False
        object Label9: TLabel
          Left = 16
          Top = 16
          Width = 29
          Height = 13
          Caption = 'Login:'
        end
        object Label11: TLabel
          Left = 16
          Top = 40
          Width = 30
          Height = 13
          Caption = 'Paste:'
        end
        object Label13: TLabel
          Left = 16
          Top = 88
          Width = 47
          Height = 13
          Caption = 'Note Edit:'
        end
        object Label12: TLabel
          Left = 16
          Top = 64
          Width = 21
          Height = 13
          Caption = 'Edit:'
        end
        object Label30: TLabel
          Left = 16
          Top = 111
          Width = 52
          Height = 13
          Caption = 'Line length'
        end
        object Label31: TLabel
          Left = 20
          Top = 150
          Width = 38
          Height = 13
          Caption = 'Label31'
          Enabled = False
          Visible = False
        end
        object PasteCmdEdit: TEdit
          Left = 80
          Top = 36
          Width = 193
          Height = 21
          TabOrder = 0
          Text = '@paste'
        end
        object EditCmdEdit: TEdit
          Left = 80
          Top = 60
          Width = 193
          Height = 21
          TabOrder = 1
          Text = '@edit'
        end
        object NotEditCmdEdit: TEdit
          Left = 80
          Top = 84
          Width = 193
          Height = 21
          TabOrder = 2
          Text = '@notedit'
        end
        object LineLengthCmdEdit: TEdit
          Left = 80
          Top = 107
          Width = 193
          Height = 21
          TabOrder = 3
          Text = '@linelength'
        end
        object LoginCmdCombo: TComboBox
          Left = 80
          Top = 12
          Width = 193
          Height = 21
          ItemHeight = 13
          TabOrder = 4
          Text = 'CO %user% %pass%'
          Items.Strings = (
            'CO %user% %pass%'
            'CONNECT %user% %pass%'
            'LOGIN %user% %pass%'
            '%user% %newline% %pass%')
        end
      end
      object TabTheme: TTabSheet
        Caption = 'Theme Selection'
        ImageIndex = 2
        TabVisible = False
        object Label2: TLabel
          Left = 8
          Top = 8
          Width = 36
          Height = 13
          Caption = 'Theme:'
        end
        object Label5: TLabel
          Left = 13
          Top = 195
          Width = 326
          Height = 79
          AutoSize = False
          Caption = 
            'Note:'#13#10'In order to find the themes, Moops expects them to reside' +
            ' in the directory Themes in your Moops directory.'#13#10'If it'#39's not t' +
            'here, Moops will automatically create it for you if you create a' +
            ' new theme.'
          WordWrap = True
        end
        object ThemeList: TListBox
          Left = 8
          Top = 24
          Width = 329
          Height = 105
          ItemHeight = 13
          Items.Strings = (
            '(No theme)')
          TabOrder = 0
          OnClick = ThemeListClick
          OnKeyPress = ThemeListKeyPress
        end
        object NewThemeButton: TButton
          Left = 112
          Top = 144
          Width = 73
          Height = 25
          Caption = '&New'
          TabOrder = 2
          OnClick = NewThemeButtonClick
        end
        object DeleteThemeButton: TButton
          Left = 272
          Top = 144
          Width = 65
          Height = 25
          Caption = '&Delete'
          Enabled = False
          TabOrder = 4
          OnClick = DeleteThemeButtonClick
        end
        object RefreshThemesButton: TButton
          Left = 8
          Top = 144
          Width = 73
          Height = 25
          Caption = '&Refresh list'
          TabOrder = 1
          OnClick = RefreshThemesButtonClick
        end
        object EditThemeButton: TButton
          Left = 192
          Top = 144
          Width = 73
          Height = 25
          Caption = '&Edit'
          Enabled = False
          TabOrder = 3
          OnClick = EditThemeButtonClick
        end
      end
      object TabLog: TTabSheet
        Caption = 'Logging Facilities'
        ImageIndex = 3
        TabVisible = False
        object LogInpLabel: TLabel
          Left = 33
          Top = 55
          Width = 46
          Height = 13
          Caption = 'Outgoing:'
          Enabled = False
        end
        object LogOutLabel: TLabel
          Left = 33
          Top = 81
          Width = 54
          Height = 13
          Caption = 'Incomming:'
          Enabled = False
        end
        object LogErrLabel: TLabel
          Left = 33
          Top = 107
          Width = 30
          Height = 13
          Caption = 'Errors:'
          Enabled = False
        end
        object LogInfLabel: TLabel
          Left = 33
          Top = 133
          Width = 55
          Height = 13
          Caption = 'Information:'
          Enabled = False
        end
        object LogNoteLabel: TLabel
          Left = 31
          Top = 202
          Width = 308
          Height = 78
          AutoSize = False
          Caption = 
            'Note:'#13#10'You can use the following '#39'variables'#39':'#13#10'%text% = the text' +
            ' to be placed in the log, i.e. the actual data'#13#10'%time% = the cur' +
            'rent time in hh:mm:ss format'#13#10'%date% = the current date in dd-mm' +
            '-yyyy format'
          Enabled = False
          WordWrap = True
        end
        object EnableLogBox: TCheckBox
          Left = 16
          Top = 16
          Width = 97
          Height = 17
          Caption = 'Enable logging'
          TabOrder = 0
          OnClick = EnableLogBoxClick
        end
        object LogOutEdit: TEdit
          Left = 111
          Top = 52
          Width = 121
          Height = 21
          Color = clBtnFace
          Enabled = False
          TabOrder = 1
          Text = '< %text%'
        end
        object LogInpEdit: TEdit
          Left = 111
          Top = 78
          Width = 121
          Height = 21
          Color = clBtnFace
          Enabled = False
          TabOrder = 2
          Text = '> %text%'
        end
        object LogErrEdit: TEdit
          Left = 111
          Top = 104
          Width = 121
          Height = 21
          Color = clBtnFace
          Enabled = False
          TabOrder = 3
          Text = '! %text%'
        end
        object LogInfEdit: TEdit
          Left = 111
          Top = 130
          Width = 121
          Height = 21
          Color = clBtnFace
          Enabled = False
          TabOrder = 4
          Text = '# %text%'
        end
        object VerboseLogBox: TCheckBox
          Left = 33
          Top = 169
          Width = 202
          Height = 14
          Caption = 'Don'#39't strip ansi and beep'
          TabOrder = 5
        end
      end
      object TabScripts: TTabSheet
        Caption = 'Scripting'
        ImageIndex = 7
        TabVisible = False
        object Label14: TLabel
          Left = 8
          Top = 8
          Width = 63
          Height = 13
          Caption = 'Select event:'
        end
        object Label15: TLabel
          Left = 8
          Top = 40
          Width = 30
          Height = 13
          Caption = 'Script:'
        end
        object ScriptCombo: TComboBox
          Left = 80
          Top = 4
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = ScriptComboChange
          Items.Strings = (
            'OnLoad'
            'OnServerConnected'
            'OnLoginSent'
            'OnDisconnect'
            'OnServerDisconnected'
            'OnClose')
        end
        object ScriptMemo: TMemo
          Left = 8
          Top = 56
          Width = 329
          Height = 217
          TabOrder = 1
        end
      end
      object TabInfo: TTabSheet
        Caption = 'Information'
        ImageIndex = 4
        TabVisible = False
        object GroupBox1: TGroupBox
          Left = 8
          Top = 8
          Width = 329
          Height = 81
          Caption = 'General'
          TabOrder = 0
          object Label17: TLabel
            Left = 16
            Top = 24
            Width = 91
            Height = 13
            Caption = 'Session created at:'
          end
          object Label18: TLabel
            Left = 128
            Top = 24
            Width = 38
            Height = 13
            Caption = 'Label18'
          end
          object Label19: TLabel
            Left = 16
            Top = 48
            Width = 38
            Height = 13
            Caption = 'Label19'
          end
          object Label26: TLabel
            Left = 128
            Top = 48
            Width = 38
            Height = 13
            Caption = 'Label18'
          end
        end
        object GroupBox2: TGroupBox
          Left = 8
          Top = 104
          Width = 329
          Height = 105
          Caption = 'Current'
          TabOrder = 1
          object Label20: TLabel
            Left = 16
            Top = 24
            Width = 77
            Height = 13
            Caption = 'Connected time:'
          end
          object Label21: TLabel
            Left = 128
            Top = 24
            Width = 38
            Height = 13
            Caption = 'Label18'
          end
          object Label22: TLabel
            Left = 16
            Top = 48
            Width = 85
            Height = 13
            Caption = 'Screen buffersize:'
          end
          object Label23: TLabel
            Left = 16
            Top = 72
            Width = 75
            Height = 13
            Caption = 'Input buffersize:'
          end
          object Label24: TLabel
            Left = 128
            Top = 48
            Width = 38
            Height = 13
            Caption = 'Label18'
          end
          object Label25: TLabel
            Left = 128
            Top = 72
            Width = 38
            Height = 13
            Caption = 'Label18'
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
    TabOrder = 0
    OnChange = CategoryViewChange
    Items.Data = {
      07000000200000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
      0747656E6572616C200000000000000000000000FFFFFFFFFFFFFFFF00000000
      01000000074163636F756E741E0000000000000000000000FFFFFFFFFFFFFFFF
      00000000000000000550726F7879270000000000000000000000FFFFFFFFFFFF
      FFFF00000000000000000E4275666665722F486973746F727921000000000000
      0000000000FFFFFFFFFFFFFFFF000000000000000008436F6D6D616E64731E00
      00000000000000000000FFFFFFFFFFFFFFFF0000000000000000055468656D65
      1C0000000000000000000000FFFFFFFFFFFFFFFF0000000000000000034C6F67
      220000000000000000000000FFFFFFFFFFFFFFFF000000000000000009536372
      697074696E67}
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'mse'
    Filter = 'Moops sessions (*.mse)|*.mse|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save session'
    Left = 48
    Top = 184
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'mse'
    Filter = 'Moops sessions (*.mse)|*.mse|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Import session'
    Left = 80
    Top = 184
  end
end
