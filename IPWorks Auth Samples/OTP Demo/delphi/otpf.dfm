object FormOTP: TFormOTP
  Left = 0
  Top = 0
  Caption = 'OTP Demo'
  ClientHeight = 297
  ClientWidth = 374
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 330
    Height = 39
    Caption = 
      #13#10'Use this demo to create and validate single use passwords usin' +
      'g the HOTP and TOTP algorithms.'
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
    Top = 63
    Width = 358
    Height = 106
    Caption = 'TOTP Parameters'
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
      Left = 12
      Top = 78
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
    object Label6: TLabel
      Left = 12
      Top = 43
      Width = 48
      Height = 13
      Caption = 'TimeStep:'
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
      Top = 71
      Width = 120
      Height = 21
      TabOrder = 2
    end
    object btnCreate: TButton
      Left = 272
      Top = 17
      Width = 73
      Height = 20
      Caption = '&Create'
      TabOrder = 3
      OnClick = btnCreateClick
    end
    object btnValidate: TButton
      Left = 272
      Top = 43
      Width = 73
      Height = 20
      Caption = '&Validate'
      TabOrder = 4
      OnClick = btnValidateClick
    end
    object timest: TSpinEdit
      Left = 97
      Top = 43
      Width = 40
      Height = 22
      MaxValue = 99999
      MinValue = 0
      TabOrder = 1
      Value = 30
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 184
    Width = 358
    Height = 105
    Caption = 'HOTP Parameters'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label2: TLabel
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
    object Label4: TLabel
      Left = 10
      Top = 73
      Width = 50
      Height = 13
      Caption = 'Password:'
    end
    object lblValidityH: TLabel
      Left = 223
      Top = 43
      Width = 6
      Height = 22
      Alignment = taCenter
      Layout = tlCenter
    end
    object txtSecretH: TEdit
      Left = 97
      Top = 16
      Width = 165
      Height = 21
      TabOrder = 0
      Text = 'ABCDEFGHIJKLMNOP'
    end
    object txtPasswordH: TEdit
      Left = 97
      Top = 71
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
    object btnCreateH: TButton
      Left = 280
      Top = 17
      Width = 73
      Height = 20
      Caption = '&Create'
      TabOrder = 3
      OnClick = btnCreateClickH
    end
    object btnValidateH: TButton
      Left = 280
      Top = 43
      Width = 73
      Height = 20
      Caption = '&Validate'
      TabOrder = 4
      OnClick = btnValidateClickH
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 272
    Top = 56
  end
  object ipaTotp1: TipaOTP
    Left = 152
    Top = 40
  end
  object ipaHotp1: TipaOTP
    Counter = 1
    PasswordAlgorithm = paHOTP
    Left = 160
    Top = 224
  end
end


