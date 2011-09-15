object SelectSessionForm: TSelectSessionForm
  Left = 271
  Top = 199
  AutoScroll = False
  Caption = 'Select session'
  ClientHeight = 353
  ClientWidth = 398
  Color = clBtnFace
  Constraints.MinHeight = 380
  Constraints.MinWidth = 406
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 10
    Top = 10
    Width = 200
    Height = 16
    Caption = 'Please select the session to load:'
  end
  object OkButton: TBitBtn
    Left = 295
    Top = 39
    Width = 93
    Height = 31
    Anchors = [akTop, akRight]
    Caption = '&Start'
    Default = True
    ModalResult = 1
    TabOrder = 1
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object CancelButton: TBitBtn
    Left = 295
    Top = 119
    Width = 93
    Height = 31
    Anchors = [akTop, akRight]
    Caption = 'Close'
    TabOrder = 3
    Kind = bkCancel
  end
  object NewButton: TBitBtn
    Left = 295
    Top = 196
    Width = 93
    Height = 30
    Anchors = [akRight, akBottom]
    Caption = 'New...'
    TabOrder = 4
    OnClick = NewButtonClick
  end
  object DelButton: TBitBtn
    Left = 295
    Top = 274
    Width = 93
    Height = 32
    Anchors = [akRight, akBottom]
    Caption = 'Delete'
    Enabled = False
    TabOrder = 6
    OnClick = DelButtonClick
  end
  object ShowOnStartupBox: TCheckBox
    Left = 10
    Top = 322
    Width = 267
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Show this dialog on startup'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object EditButton: TBitBtn
    Left = 295
    Top = 236
    Width = 93
    Height = 30
    Anchors = [akRight, akBottom]
    Caption = 'Edit...'
    Enabled = False
    TabOrder = 5
    OnClick = EditButtonClick
  end
  object SessionList: TCheckListBox
    Left = 8
    Top = 40
    Width = 265
    Height = 265
    OnClickCheck = SessionListClickCheck
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 16
    TabOrder = 0
    OnClick = SessionListClick
    OnDblClick = SessionListDblClick
    OnKeyPress = SessionListKeyPress
  end
  object AutoButton: TBitBtn
    Left = 295
    Top = 79
    Width = 93
    Height = 31
    Anchors = [akTop, akRight]
    Caption = '&Auto start'
    ModalResult = 8
    TabOrder = 2
    OnClick = AutoButtonClick
    Glyph.Data = {
      F2010000424DF201000000000000760000002800000024000000130000000100
      0400000000007C01000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333334433333
      3333333333388F3333333333000033334224333333333333338338F333333333
      0000333422224333333333333833338F33333333000033422222243333333333
      83333338F3333333000034222A22224333333338F33F33338F33333300003222
      A2A2224333333338F383F3338F33333300003A2A222A222433333338F8333F33
      38F33333000034A22222A22243333338833333F3338F333300004222A2222A22
      2433338F338F333F3338F3330000222A3A2224A22243338F3838F338F3338F33
      0000A2A333A2224A2224338F83338F338F3338F300003A33333A2224A2224338
      333338F338F3338F000033333333A2224A2243333333338F338F338F00003333
      33333A2224A2233333333338F338F83300003333333333A2224A333333333333
      8F338F33000033333333333A222433333333333338F338F30000333333333333
      A224333333333333338F38F300003333333333333A223333333333333338F8F3
      000033333333333333A3333333333333333383330000}
    NumGlyphs = 2
  end
  object FormPlacement: TFormPlacement
    IniSection = 'SelectSessionForm'
    Left = 296
    Top = 160
  end
end
