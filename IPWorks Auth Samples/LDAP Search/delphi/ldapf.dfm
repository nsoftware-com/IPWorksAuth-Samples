object FormLdap: TFormLdap
  Left = 280
  Top = 147
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'LDAP Demo'
  ClientHeight = 468
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  DesignSize = (
    417
    468)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 85
    Width = 77
    Height = 13
    Caption = 'Directory server:'
  end
  object Label1: TLabel
    Left = 8
    Top = 56
    Width = 128
    Height = 13
    Caption = 'Please enter a search filter:'
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 396
    Height = 39
    Caption = 
      'You may use this demo to search an LDAP server for a specified n' +
      'ame.  The results of the search are returned through the "Search' +
      'Result Event" and are displayed in the text box below.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label4: TLabel
    Left = 8
    Top = 110
    Width = 46
    Height = 13
    Caption = 'Base DN:'
  end
  object Memo1: TMemo
    Left = 0
    Top = 168
    Width = 425
    Height = 309
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '')
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object tServer: TEdit
    Left = 144
    Top = 83
    Width = 265
    Height = 21
    TabOrder = 1
    Text = 'ldap-master.itd.umich.edu'
  end
  object tFilter: TEdit
    Left = 144
    Top = 56
    Width = 265
    Height = 21
    TabOrder = 0
    Text = 'cn=*'
  end
  object Button1: TButton
    Left = 241
    Top = 139
    Width = 81
    Height = 23
    Caption = '&Search'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 328
    Top = 139
    Width = 81
    Height = 23
    Caption = '&Disconnect'
    TabOrder = 3
    OnClick = Button2Click
  end
  object tBaseDN: TEdit
    Left = 144
    Top = 110
    Width = 265
    Height = 21
    TabOrder = 5
    Text = 'ou=Security,dc=umich,dc=edu'
  end
  object ipaLDAP1: TipaLDAP
    SSLCertStore = 'MY'
    OnSearchComplete = ipaLDAP1SearchComplete
    OnSearchResult = ipaLDAP1SearchResult
    OnSSLServerAuthentication = ipaLDAP1SSLServerAuthentication
    OnSSLStatus = ipaLDAP1SSLStatus
    Left = 8
    Top = 128
  end
end


