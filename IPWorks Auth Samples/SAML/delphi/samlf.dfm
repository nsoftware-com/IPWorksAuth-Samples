object FormSAML: TFormSAML
  Left = 0
  Top = 0
  Caption = 'SAML Demo'
  ClientHeight = 504
  ClientWidth = 739
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
    Width = 723
    Height = 26
    Caption = 
      'To begin, select the AuthMode. For SharePoint Online and Dynamic' +
      's CRM simply specify your email address, password, and Applicati' +
      'on URN. For ADFS you must also specify a LocalSTS. Note that thi' +
      's demo is configured for simple common scenarios. Please see the' +
      ' help file for more details.'
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
    Top = 40
    Width = 723
    Height = 105
    Caption = 'Auth Info'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 35
      Top = 19
      Width = 56
      Height = 13
      Caption = 'Auth Mode:'
    end
    object Label3: TLabel
      Left = 280
      Top = 19
      Width = 26
      Height = 13
      Caption = 'User:'
    end
    object Label4: TLabel
      Left = 491
      Top = 19
      Width = 50
      Height = 13
      Caption = 'Password:'
    end
    object Label5: TLabel
      Left = 11
      Top = 46
      Width = 80
      Height = 13
      Caption = 'Application URN:'
    end
    object Label6: TLabel
      Left = 371
      Top = 46
      Width = 80
      Height = 13
      Caption = 'Federation URN:'
    end
    object Label7: TLabel
      Left = 26
      Top = 73
      Width = 65
      Height = 13
      Caption = 'Location STS:'
    end
    object Label8: TLabel
      Left = 374
      Top = 73
      Width = 77
      Height = 13
      Caption = 'Federation STS:'
    end
    object txtUser: TEdit
      Left = 312
      Top = 16
      Width = 165
      Height = 21
      TabOrder = 0
    end
    object txtPassword: TEdit
      Left = 547
      Top = 16
      Width = 165
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object txtApplicationURN: TEdit
      Left = 97
      Top = 43
      Width = 255
      Height = 21
      TabOrder = 2
    end
    object txtFederationURN: TEdit
      Left = 457
      Top = 43
      Width = 255
      Height = 21
      TabOrder = 3
    end
    object txtLocalSTS: TEdit
      Left = 97
      Top = 70
      Width = 255
      Height = 21
      TabOrder = 4
    end
    object txtFederationSTS: TEdit
      Left = 457
      Top = 70
      Width = 255
      Height = 21
      TabOrder = 5
    end
    object cboAuthMode: TComboBox
      Left = 97
      Top = 16
      Width = 177
      Height = 21
      TabOrder = 6
      OnChange = cboAuthModeChange
      Items.Strings = (
        'SharePoint Online'
        'Dynamics CRM'
        'ADFS')
    end
  end
  object btnGetSecurityToken: TButton
    Left = 8
    Top = 151
    Width = 153
    Height = 25
    Caption = 'Get Security Token'
    TabOrder = 1
    OnClick = btnGetSecurityTokenClick
  end
  object btnGetAssertion: TButton
    Left = 167
    Top = 151
    Width = 114
    Height = 25
    Caption = 'Get Assertion'
    TabOrder = 2
    OnClick = btnGetAssertionClick
  end
  object txtResult: TMemo
    Left = 8
    Top = 182
    Width = 723
    Height = 314
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object ipaSAML1: TipaSAML
    SSLCertStore = 'MY'
    OnSSLServerAuthentication = ipaSAML1SSLServerAuthentication
    Left = 672
    Top = 152
  end
end


