unit signcsrf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ipacore, ipatypes, ipacertmgr;

type
  TFormSigncsr = class(TForm)
    tCSR: TMemo;
    tSignedCSR: TMemo;
    bSign: TButton;
    bOK: TButton;
    bCancel: TButton;
    Label1: TLabel;
    cbIssuer: TComboBox;
    Label3: TLabel;
    Label2: TLabel;
    tSerialNumber: TEdit;
    Label4: TLabel;
    ipaCertMgr1: TipaCertMgr;
    procedure bSignClick(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure tSerialNumberChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ipaCertMgr1CertList(Sender: TObject; const CertEncoded: string;
      const CertEncodedB: TArray<System.Byte>; const CertSubject, CertIssuer,
      CertSerialNumber: string; const HasPrivateKey: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSigncsr: TFormSigncsr;

implementation

{$R *.dfm}

procedure TFormSigncsr.ipaCertMgr1CertList(Sender: TObject;
  const CertEncoded: string; const CertEncodedB: TArray<System.Byte>;
  const CertSubject, CertIssuer, CertSerialNumber: string;
  const HasPrivateKey: Boolean);
begin
  if HasPrivateKey then cbIssuer.Items.Add(CertSubject);
end;

procedure TFormSigncsr.bSignClick(Sender: TObject);
begin
  ipaCertMgr1.CertSubject := cbIssuer.Text;
  tSignedCSR.Text := ipaCertMgr1.signcsr(TEncoding.Default.GetBytes(tCSR.Text), StrToInt(tSerialNumber.Text))
end;

procedure TFormSigncsr.bOKClick(Sender: TObject);
begin
        Close();
end;

procedure TFormSigncsr.bCancelClick(Sender: TObject);
begin
        Close();
end;

procedure TFormSigncsr.tSerialNumberChange(Sender: TObject);
var MyNumber: integer;
begin
    try
        MyNumber := StrToInt(tSerialNumber.Text);
    except on E:Exception do begin
        ShowMessage('Please enter only numeric data for the serial number.');
        tSerialNumber.Text := '';
        end;
    end;
end;

procedure TFormSigncsr.FormActivate(Sender: TObject);
begin
  tSerialNumber.Text := IntToStr(StrToInt(tSerialNumber.Text) + 1);
  cbIssuer.items.Clear;
  ipaCertMgr1.ListStoreCertificates;
  cbIssuer.ItemIndex := 0;
end;

end.