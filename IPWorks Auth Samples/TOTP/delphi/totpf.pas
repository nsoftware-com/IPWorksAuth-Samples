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
unit totpf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ipacore, ipatypes, ipatotp, ExtCtrls;

type
  TFormTotp = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    txtSecret: TEdit;
    Label3: TLabel;
    txtPassword: TEdit;
    Label7: TLabel;
    ipaTotp1: TipaTotp;
    btnCreate: TButton;
    btnValidate: TButton;
    lblValidity: TLabel;
    Timer1: TTimer;
    procedure btnCreateClick(Sender: TObject);
    procedure btnValidateClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTotp: TFormTotp;

implementation

{$R *.dfm}

procedure TFormTotp.btnValidateClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    Timer1.Enabled := false;
    lblValidity.Caption := '';
    ipaTotp1.Secret := txtSecret.Text;
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

procedure TFormTotp.Timer1Timer(Sender: TObject);
begin
  lblValidity.Caption := IntToStr(ipaTotp1.ValidityTime);
  if (ipaTotp1.ValidityTime = 0) then
    Timer1.Enabled := false;
end;

procedure TFormTotp.btnCreateClick(Sender: TObject);
  begin
    try
      Screen.Cursor := crHourGlass;
      lblValidity.Caption := '';
      ipaTotp1.Secret := txtSecret.Text;
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

end.

