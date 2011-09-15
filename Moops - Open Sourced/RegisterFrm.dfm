object RegisterForm: TRegisterForm
  Left = 281
  Top = 186
  BorderStyle = bsDialog
  BorderWidth = 10
  Caption = 'Registration'
  ClientHeight = 460
  ClientWidth = 585
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 585
    Height = 21
    Align = alTop
    AutoSize = False
    Caption = 'Category:'
  end
  object Panel_2: TPanel
    Left = 129
    Top = 21
    Width = 13
    Height = 390
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 3
  end
  object Panel_3: TPanel
    Left = 0
    Top = 411
    Width = 585
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Image1: TImage
      Left = 0
      Top = 10
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
      Left = 383
      Top = 17
      Width = 92
      Height = 31
      Anchors = [akRight, akBottom]
      Caption = 'Next'
      TabOrder = 0
      OnClick = OKButtonClick
      Kind = bkOK
    end
    object CancelButton: TBitBtn
      Left = 491
      Top = 17
      Width = 92
      Height = 31
      Anchors = [akRight, akBottom]
      TabOrder = 1
      OnClick = CancelButtonClick
      Kind = bkCancel
    end
  end
  object Panel_4: TPanel
    Left = 142
    Top = 21
    Width = 443
    Height = 390
    Align = alClient
    BorderWidth = 2
    FullRepaint = False
    TabOrder = 1
    object PageControl: TPageControl
      Left = 3
      Top = 27
      Width = 437
      Height = 360
      ActivePage = TabSheet1
      Align = alClient
      Style = tsButtons
      TabOrder = 0
      object TabSheet1: TTabSheet
        Tag = 1
        Caption = 'Information'
        TabVisible = False
        object Label2: TLabel
          Left = 10
          Top = 10
          Width = 405
          Height = 326
          AutoSize = False
          Caption = 
            'Welcome to Moops!'#13#10#13#10#13#10'This appears to be the first time you'#39're ' +
            'running Moops.'#13#10'On the next page, you are asked to give some inf' +
            'ormation about yourself, you are NOT required to fill any of the' +
            ' fields, but your cooperation will very much be apprieciated. Th' +
            'is information will be used for statistical purposes (how many u' +
            'sers use Moops, etc) and will not be given out to anyone else, n' +
            'or will you be bothered with unsollicitated e-mail.'
          WordWrap = True
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Registration'
        ImageIndex = 1
        TabVisible = False
        object Label3: TLabel
          Left = 20
          Top = 20
          Width = 68
          Height = 16
          Caption = 'Your name:'
        end
        object Label4: TLabel
          Left = 20
          Top = 49
          Width = 71
          Height = 16
          Caption = 'Your e-mail:'
        end
        object Label5: TLabel
          Left = 20
          Top = 79
          Width = 77
          Height = 16
          Caption = 'Your country:'
        end
        object Label6: TLabel
          Left = 20
          Top = 128
          Width = 208
          Height = 16
          Caption = 'How did you find out about Moops?'
        end
        object NameEdit: TEdit
          Left = 118
          Top = 15
          Width = 287
          Height = 24
          TabOrder = 0
        end
        object EmailEdit: TEdit
          Left = 118
          Top = 44
          Width = 287
          Height = 24
          TabOrder = 1
        end
        object CountryEdit: TEdit
          Left = 118
          Top = 74
          Width = 51
          Height = 24
          MaxLength = 2
          TabOrder = 2
        end
        object HowCombo: TComboBox
          Left = 20
          Top = 148
          Width = 385
          Height = 24
          ItemHeight = 16
          TabOrder = 3
          Items.Strings = (
            'From a friend'
            'Recommendation from the Virtual World (e.g. a MUD)'
            'From a link on a webpage'
            'Via a Search Engine')
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Getting started'
        ImageIndex = 2
        TabVisible = False
        object Label7: TLabel
          Left = 10
          Top = 10
          Width = 405
          Height = 326
          AutoSize = False
          Caption = 
            'If this is the first time you'#39're using Moops, you will be presen' +
            'ted with a dialogbox.'#13#10'Here, you should fill in some details of ' +
            'the server you want to connect to.'#13#10#13#10'Many servers allow you to ' +
            'login as a guest, so the default username will suffice if you'#39're' +
            ' new.'#13#10#13#10'For a good list of muds and moo'#39's, you should check out' +
            #13#10'http://www.mudconnector.org'
          WordWrap = True
        end
      end
    end
    object TabCaption: TStaticText
      Left = 3
      Top = 3
      Width = 437
      Height = 24
      Align = alTop
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = 'Introduction'
      Color = clBtnShadow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnFace
      Font.Height = -18
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 1
    end
  end
  object CategoryView: TTreeView
    Left = 0
    Top = 21
    Width = 129
    Height = 390
    Align = alLeft
    HideSelection = False
    HotTrack = True
    Indent = 19
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    OnChange = CategoryViewChange
    Items.Data = {
      03000000250000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
      0C496E74726F64756374696F6E250000000000000000000000FFFFFFFFFFFFFF
      FF00000000000000000C526567697374726174696F6E28000000000000000000
      0000FFFFFFFFFFFFFFFF00000000000000000F47657474696E67207374617274
      6564}
  end
end
