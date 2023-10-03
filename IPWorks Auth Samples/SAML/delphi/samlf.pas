(*
 * IPWorks Auth 2022 Delphi Edition - Sample Project
 *
 * This sample project demonstrates the usage of IPWorks Auth in a 
 * simple, straightforward way. It is not intended to be a complete 
 * application. Error handling and other checks are simplified for clarity.
 *
 * www.nsoftware.com/ipworksauth
 *
 * This code is subject to the terms and conditions specified in the 
 * corresponding product license agreement which outlines the authorized 
 * usage and restrictions.
 *)
unit samlf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ipacore, ipatypes, ipasaml;

type
  TFormSAML = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    txtUser: TEdit;
    txtPassword: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    txtApplicationURN: TEdit;
    Label5: TLabel;
    txtFederationURN: TEdit;
    Label6: TLabel;
    txtLocalSTS: TEdit;
    Label7: TLabel;
    txtFederationSTS: TEdit;
    Label8: TLabel;
    btnGetSecurityToken: TButton;
    btnGetAssertion: TButton;
    txtResult: TMemo;
    cboAuthMode: TComboBox;
    ipaSAML1: TipaSAML;
    procedure btnGetSecurityTokenClick(Sender: TObject);
    procedure cboAuthModeChange(Sender: TObject);
    procedure btnGetAssertionClick(Sender: TObject);
    procedure ipaSAML1SSLServerAuthentication(Sender: TObject;
      CertEncoded: string; CertEncodedB: TArray<System.Byte>; const CertSubject, CertIssuer, Status: string;
      var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSAML: TFormSAML;

implementation

{$R *.dfm}

procedure TFormSAML.btnGetAssertionClick(Sender: TObject);
begin
  try
    ipaSAML1.FederationURN := '';
    ipaSAML1.FederationSTS := ''; //Obtaining an assertion does not communicate with the FederationSTS.
    ipaSAML1.LocalSTS := txtLocalSTS.Text;
    ipaSAML1.ApplicationURN := txtApplicationURN.Text;
    ipaSAML1.User := txtUser.Text;
    ipaSAML1.Password := txtPassword.Text;

    Screen.Cursor := crHourGlass;
    ipaSAML1.GetAssertion();
    txtResult.Lines.Add(ipaSAML1.AssertionXML);
    Screen.Cursor := crDefault;
  Except on E: Exception do
  begin
    Screen.Cursor := crDefault;
    ShowMessage('Error: ' + E.Message);
  end;

  end;
end;

procedure TFormSAML.btnGetSecurityTokenClick(Sender: TObject);
  begin
    try
      ipaSAML1.FederationURN := txtFederationURN.Text;
      ipaSAML1.FederationSTS := txtFederationSTS.Text;
      ipaSAML1.LocalSTS := txtLocalSTS.Text;
      ipaSAML1.ApplicationURN := txtApplicationURN.Text;
      ipaSAML1.User := txtUser.Text;
      ipaSAML1.Password := txtPassword.Text;

      Screen.Cursor := crHourGlass;
      ipaSAML1.GetSecurityToken();
      Screen.Cursor := crDefault;
      txtResult.Lines.Add(ipaSAML1.SecurityTokenXML);
    Except on E: Exception do
    begin
      Screen.Cursor := crDefault;
      ShowMessage('Error: ' + E.Message);
    end;
  end;
end;

procedure TFormSAML.cboAuthModeChange(Sender: TObject);
begin
  case cboAuthMode.ItemIndex of
    0 : begin
          ipaSAML1.AuthMode := TipasamlAuthModes.camSharePointOnline;
          txtApplicationURN.Text := 'https://mycrm.sharepoint.com';
          txtUser.Text := 'user@mycrm.onmicrosoft.com';
          txtLocalSTS.Text := '';

          txtFederationURN.Enabled := true;
          txtFederationSTS.Enabled := true;
          txtLocalSTS.Enabled := false;
          btnGetSecurityToken.Enabled := true;
          btnGetAssertion.Enabled := false;
        end;
    1 : begin
          ipaSAML1.AuthMode := TipasamlAuthModes.camDynamicsCRM;
          txtApplicationURN.Text := 'urn:crmapac:dynamics.com';
          txtUser.Text := 'user@mycrm.onmicrosoft.com';
          txtLocalSTS.Text := '';

          txtFederationURN.Enabled := true;
          txtFederationSTS.Enabled :=  true;
          txtLocalSTS.Enabled := false;
          btnGetSecurityToken.Enabled := true;
          btnGetAssertion.Enabled := false;
        end;
    else
        begin
          ipaSAML1.AuthMode := TipasamlAuthModes.camADFS;
          txtApplicationURN.Text := 'https://fsweb.contoso.com/ClaimsAwareWebAppWithManagedSTS/';
          txtLocalSTS.Text := 'https://adfs.contoso.com/adfs/services/trust/2005/usernamemixed';
          txtUser.Text := '';

          txtFederationURN.Enabled := false;
          txtFederationSTS.Enabled := false;
          txtLocalSTS.Enabled := true;
          btnGetSecurityToken.Enabled := false;
          btnGetAssertion.Enabled := true;
        end;
  end;
  txtFederationSTS.Text := ipaSAML1.FederationSTS;
  txtFederationURN.Text := ipaSAML1.FederationURN;
end;

procedure TFormSAML.ipaSAML1SSLServerAuthentication(Sender: TObject;
  CertEncoded: string; CertEncodedB: TArray<System.Byte>; const CertSubject, CertIssuer, Status: string;
  var Accept: Boolean);
begin
  Accept := true;
end;

end.

