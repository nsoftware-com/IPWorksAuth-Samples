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
unit hotpf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ipacore, ipatypes, ipahotp, Spin;

type
  TFormHotp = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    txtSecret: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    txtPassword: TEdit;
    Label7: TLabel;
    ipaHotp1: TipaHotp;
    numCounter: TSpinEdit;
    btnCreate: TButton;
    btnValidate: TButton;
    lblValidity: TLabel;
    procedure btnCreateClick(Sender: TObject);
    procedure btnValidateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHotp: TFormHotp;

implementation

{$R *.dfm}

procedure TFormHotp.btnValidateClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    lblValidity.Caption := '';
    ipaHotp1.Secret := txtSecret.Text;
    ipaHotp1.Counter := numCounter.Value;
    ipaHotp1.Password := txtPassword.Text;
    if ipaHotp1.ValidatePassword then
    begin
      lblValidity.Font.Color := clGreen;
      lblValidity.Caption := 'VALID!';
    end
    else
    begin
      lblValidity.Font.Color := clRed;
      lblValidity.Caption := 'INVALID!';
    end;
    Screen.Cursor := crDefault;
  Except
    on E: Exception do
    begin
      Screen.Cursor := crDefault;
      ShowMessage('Error: ' + E.Message);
    end;

  end;
end;

procedure TFormHotp.btnCreateClick(Sender: TObject);
  begin
    try
      Screen.Cursor := crHourGlass;
      lblValidity.Caption := '';
      ipaHotp1.Secret := txtSecret.Text;
      ipaHotp1.Counter := numCounter.Value;
      ipaHotp1.CreatePassword;
      txtPassword.Text := ipaHotp1.Password;
      Screen.Cursor := crDefault;
    Except on E: Exception do
    begin
      Screen.Cursor := crDefault;
      ShowMessage('Error: ' + E.Message);
    end;
  end;
end;

end.

