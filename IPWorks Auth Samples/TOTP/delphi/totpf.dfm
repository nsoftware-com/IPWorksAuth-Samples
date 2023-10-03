object FormTotp: TFormTotp
  Left = 0
  Top = 0
  Caption = 'TOTP Demo'
  ClientHeight = 162
  ClientWidth = 374
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
    Width = 355
    Height = 65
    Caption = 
      'This application demonstrates how to create and validate Time-Ba' +
      'sed One-Time Passwords. To create a password simply specify the ' +
      'Base32 encoded secret value and click Create. To validate a pass' +
      'word make sure the Base32 encoded secret matches the value used ' +
      'when creating the password and click Validate.'
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
    Width = 358
    Height = 74
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
      Top = 19
      Width = 81
      Height = 13
      Caption = 'Secret (Base32):'
    end
    object Label7: TLabel
      Left = 10
      Top = 46
      Width = 50
      Height = 13
      Caption = 'Password:'
    end
    object lblValidity: TLabel
      Left = 223
      Top = 46
      Width = 6
      Height = 13
      Alignment = taCenter
      Caption = '0'
      Layout = tlCenter
    end
    object txtSecret: TEdit
      Left = 97
      Top = 16
      Width = 120
      Height = 21
      TabOrder = 0
      Text = 'ABCDEFGHIJKLMNOP'
    end
    object txtPassword: TEdit
      Left = 97
      Top = 43
      Width = 120
      Height = 21
      TabOrder = 1
    end
    object btnCreate: TButton
      Left = 272
      Top = 17
      Width = 73
      Height = 20
      Caption = '&Create'
      TabOrder = 2
      OnClick = btnCreateClick
    end
    object btnValidate: TButton
      Left = 272
      Top = 43
      Width = 73
      Height = 20
      Caption = '&Validate'
      TabOrder = 3
      OnClick = btnValidateClick
    end
  end
  object ipaTotp1: TipaTOTP
    Left = 328
    Top = 56
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 272
    Top = 56
  end
end


