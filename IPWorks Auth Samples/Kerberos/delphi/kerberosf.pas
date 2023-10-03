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
unit kerberosf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ipacore, ipatypes, ipakerberos;

type
  TFormKerberos = class(TForm)
    lblInfo: TLabel;
    GroupBox1: TGroupBox;
    lblUser: TLabel;
    lblPassword: TLabel;
    lblSPN: TLabel;
    lblHost: TLabel;
    txtUser: TEdit;
    txtPassword: TEdit;
    txtSPN: TEdit;
    txtHost: TEdit;
    btnAuthenticate: TButton;
    lblResponse: TLabel;
    ipaKerberos1: TipaKerberos;
    procedure btnAuthenticateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormKerberos: TFormKerberos;

implementation

{$R *.dfm}

procedure TFormKerberos.btnAuthenticateClick(Sender: TObject);
begin
  try
    begin
	  lblResponse.Caption := '';
      ipaKerberos1.User := txtUser.Text;
      ipaKerberos1.Password := txtPassword.Text;
      ipaKerberos1.SPN := txtSPN.Text;
      ipaKerberos1.KDCHost := txtHost.Text;
      ipaKerberos1.Authenticate();
      lblResponse.Caption := 'Authenticated';
    end;
  Except on E: Exception do
    ShowMessage('Error: ' + E.Message);
  end;
end;

end.

