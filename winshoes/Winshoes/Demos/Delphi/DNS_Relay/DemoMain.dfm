object Form1: TForm1
  Left = 376
  Top = 195
  Width = 303
  Height = 134
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object memLog: TMemo
    Left = 0
    Top = 0
    Width = 295
    Height = 107
    Align = alClient
    Lines.Strings = (
      '')
    TabOrder = 0
  end
  object DNSMappedPort1: TDNSMappedPort
    Port = 53
    UDPSize = 65467
    Active = True
    OnUDPRead = DNSMappedPort1UDPRead
    MappedHost = '10.1.10.20'
    Left = 256
    Top = 8
  end
  object WinshoeGUIIntegrator1: TWinshoeGUIIntegrator
    IdleTimeOut = 250
    OnlyWhenIdle = False
    ApplicationHasPriority = True
    Left = 256
    Top = 48
  end
end
