object AskPWForm: TAskPWForm
  Left = 244
  Top = 210
  BorderStyle = bsDialog
  Caption = 'Moops!'
  ClientHeight = 233
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 273
    Height = 28
    Shape = bsFrame
  end
  object DescrLabel: TLabel
    Left = 13
    Top = 13
    Width = 264
    Height = 20
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 20
    Top = 54
    Width = 31
    Height = 19
    Caption = 'Host:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 20
    Top = 108
    Width = 31
    Height = 21
    Caption = 'User:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 20
    Top = 140
    Width = 61
    Height = 21
    Caption = 'Password:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object ServerLabel: TLabel
    Left = 90
    Top = 54
    Width = 183
    Height = 19
    AutoSize = False
    Caption = 'utopiamoo.net:888'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Image1: TImage
    Left = 8
    Top = 193
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
  object BitBtn1: TBitBtn
    Left = 128
    Top = 200
    Width = 74
    Height = 26
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 211
    Top = 200
    Width = 70
    Height = 26
    TabOrder = 2
    Kind = bkCancel
  end
  object Panel1: TPanel
    Left = 88
    Top = 136
    Width = 129
    Height = 23
    BevelInner = bvLowered
    Color = clWindow
    TabOrder = 0
    object PassEdit: TEdit
      Left = 4
      Top = 4
      Width = 120
      Height = 14
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Symbol'
      Font.Style = []
      ParentFont = False
      PasswordChar = '·'
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 88
    Top = 104
    Width = 129
    Height = 23
    BevelInner = bvLowered
    Color = clWindow
    TabOrder = 3
    object UserEdit: TEdit
      Left = 4
      Top = 4
      Width = 120
      Height = 14
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
end
