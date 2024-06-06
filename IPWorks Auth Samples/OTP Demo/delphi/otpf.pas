(*
 * IPWorks Auth 2024 Delphi Edition - Sample Project
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

unit otpf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ipacore, ipatypes, ipaotp, ExtCtrls,
  Vcl.Samples.Spin;

type
    TFormOTP = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    txtSecret: TEdit;
    Label3: TLabel;
    txtPassword: TEdit;
    Label7: TLabel;
    btnCreate: TButton;
    btnValidate: TButton;
    Timer1: TTimer;
    ipaTotp1: TipaOTP;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    lblValidityH: TLabel;
    txtSecretH: TEdit;
    txtPasswordH: TEdit;
    numCounter: TSpinEdit;
    btnCreateH: TButton;
    btnValidateH: TButton;
    timest: TSpinEdit;
    lblValidity: TLabel;
    ipaHotp1: TipaOTP;
    Label6: TLabel;
    procedure btnCreateClick(Sender: TObject);
    procedure btnValidateClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnCreateClickH(Sender: TObject);
    procedure btnValidateClickH(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formotp: TFormOTP;

implementation

{$R *.dfm}

procedure TFormOTP.btnValidateClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    Timer1.Enabled := false;
    lblValidity.Caption := '';
    ipaTotp1.Secret := txtSecret.Text;
    ipaTotp1.TimeStep:=timest.Value;
    ipaTotp1.Password := txtPassword.Text;
    if ipaTotp1.ValidatePassword then
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



procedure TFormOTP.Timer1Timer(Sender: TObject);
begin
  lblValidity.Caption := IntToStr(ipaTotp1.ValidityTime);
  if (ipaTotp1.ValidityTime = 0) then
    Timer1.Enabled := false;
end;

procedure TFormOTP.btnCreateClick(Sender: TObject);
  begin
    try
      Screen.Cursor := crHourGlass;
      lblValidity.Caption := '';
      ipaTotp1.Secret := txtSecret.Text;
      ipaTotp1.TimeStep:=timest.Value;
      ipaTotp1.CreatePassword;
      txtPassword.Text := ipaTotp1.Password;
      lblValidity.Font.Color := clBlack;
      lblValidity.Caption := IntToStr(ipaTotp1.ValidityTime);
      Timer1.Enabled := true;
      Screen.Cursor := crDefault;
    Except on E: Exception do
    begin
      Screen.Cursor := crDefault;
      ShowMessage('Error: ' + E.Message);
    end;
  end;
end;

procedure TFormOTP.btnValidateClickH(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    lblValidityh.Caption := '';
    ipaHotp1.Secret := txtSecretH.Text;
    ipaHotp1.Counter := numCounter.Value;
    ipaHotp1.Password := txtPasswordH.Text;
    if ipaHotp1.ValidatePassword then
    begin
      lblValidityH.Font.Color := clGreen;
      lblValidityH.Caption := 'VALID!';
    end
    else
    begin
      lblValidityH.Font.Color := clRed;
      lblValidityH.Caption := 'INVALID!';
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

procedure TFormOTP.btnCreateClickH(Sender: TObject);
  begin
    try
      Screen.Cursor := crHourGlass;
      lblValidityH.Caption := '';
      ipaHotp1.Secret := txtSecretH.Text;
      ipaHotp1.Counter := numCounter.Value;
      ipaHotp1.CreatePassword;
      txtPasswordH.Text := ipaHotp1.Password;
      Screen.Cursor := crDefault;
    Except on E: Exception do
    begin
      Screen.Cursor := crDefault;
      ShowMessage('Error: ' + E.Message);
    end;
  end;
end;

end.


