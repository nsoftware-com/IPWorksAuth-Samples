object FormKerberos: TFormKerberos
  Left = 0
  Top = 0
  Caption = 'Kerberos Demo'
  ClientHeight = 200
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblInfo: TLabel
    Left = 8
    Top = 8
    Width = 409
    Height = 41
    AutoSize = False
    Caption = 
      'This demo shows how to use the Kerberos component to authenticat' +
      'e a user. To begin specify the User, Password, SPN (Service Prin' +
      'cipal Name), and KDCHost (the Kerberos server).'
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
    Top = 55
    Width = 401
    Height = 138
    Caption = 'User Authenticator'
    TabOrder = 0
    object lblUser: TLabel
      Left = 16
      Top = 24
      Width = 22
      Height = 13
      Caption = 'User'
    end
    object lblPassword: TLabel
      Left = 16
      Top = 51
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object lblSPN: TLabel
      Left = 16
      Top = 75
      Width = 19
      Height = 13
      Caption = 'SPN'
    end
    object lblHost: TLabel
      Left = 16
      Top = 104
      Width = 42
      Height = 13
      Caption = 'KDCHost'
    end
    object lblResponse: TLabel
      Left = 288
      Top = 63
      Width = 3
      Height = 13
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object txtUser: TEdit
      Left = 104
      Top = 21
      Width = 137
      Height = 21
      TabOrder = 0
    end
    object txtPassword: TEdit
      Left = 104
      Top = 48
      Width = 137
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object txtSPN: TEdit
      Left = 104
      Top = 75
      Width = 137
      Height = 21
      TabOrder = 2
    end
    object txtHost: TEdit
      Left = 104
      Top = 102
      Width = 137
      Height = 21
      TabOrder = 3
    end
    object btnAuthenticate: TButton
      Left = 272
      Top = 24
      Width = 105
      Height = 25
      Caption = 'Authenticate'
      TabOrder = 4
      OnClick = btnAuthenticateClick
    end
  end
  object ipaKerberos1: TipaKerberos
    Left = 280
    Top = 144
  end
end


