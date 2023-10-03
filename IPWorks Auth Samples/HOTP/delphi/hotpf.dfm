object FormHotp: TFormHotp
  Left = 0
  Top = 0
  Caption = 'HOTP Demo'
  ClientHeight = 185
  ClientWidth = 385
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 369
    Height = 65
    Caption = 
      'This application demonstrates how to create and validate HMAC-Ba' +
      'sed One-Time Passwords. To create a password simply specify the ' +
      'Base32 encoded secret value and click Create. To validate a pass' +
      'word make sure counter and Base32 encoded secret match the value' +
      's used when creating the password and click Validate.'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    WordWrap = True
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 79
    Width = 369
    Height = 105
    Caption = 'Password Parameters'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label3: TLabel
      Left = 10
      Top = 24
      Width = 81
      Height = 13
      Caption = 'Secret (Base32):'
    end
    object Label5: TLabel
      Left = 10
      Top = 46
      Width = 43
      Height = 13
      Caption = 'Counter:'
    end
    object Label7: TLabel
      Left = 10
      Top = 73
      Width = 50
      Height = 13
      Caption = 'Password:'
    end
    object lblValidity: TLabel
      Left = 280
      Top = 73
      Width = 3
      Height = 13
      Alignment = taCenter
      Layout = tlCenter
    end
    object txtSecret: TEdit
      Left = 97
      Top = 16
      Width = 165
      Height = 21
      TabOrder = 0
      Text = 'ABCDEFGHIJKLMNOP'
    end
    object txtPassword: TEdit
      Left = 97
      Top = 70
      Width = 165
      Height = 21
      TabOrder = 2
    end
    object numCounter: TSpinEdit
      Left = 97
      Top = 43
      Width = 40
      Height = 22
      MaxValue = 100
      MinValue = 0
      TabOrder = 1
      Value = 1
    end
    object btnCreate: TButton
      Left = 280
      Top = 17
      Width = 73
      Height = 20
      Caption = '&Create'
      TabOrder = 3
      OnClick = btnCreateClick
    end
    object btnValidate: TButton
      Left = 280
      Top = 43
      Width = 73
      Height = 20
      Caption = '&Validate'
      TabOrder = 4
      OnClick = btnValidateClick
    end
  end
  object ipaHotp1: TipaHOTP
    Left = 352
    Top = 56
  end
end


