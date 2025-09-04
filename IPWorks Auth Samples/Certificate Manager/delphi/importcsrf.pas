unit importcsrf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ipacore, ipatypes, ipacertmgr;

type
  TFormImportcsr = class(TForm)
    tCSR: TMemo;
    bOK: TButton;
    bCancel: TButton;
    Label4: TLabel;
    Label2: TLabel;
    cbKey: TComboBox;
    ipaCertMgr1: TipaCertMgr;
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ipaCertMgr1KeyList(Sender: TObject; const KeyContainer: string;
      const KeyType: Integer; const AlgId: string; const KeyLen: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormImportcsr: TFormImportcsr;

implementation

{$R *.dfm}

procedure TFormImportcsr.bOKClick(Sender: TObject);
begin
  //this imports into the 'MY' store, but any other store would work as well
  ipaCertMgr1.CertStoreType := cstUser;
  ipaCertMgr1.CertStore := 'MY';
  ipaCertMgr1.ImportSignedCSR(TEncoding.Default.GetBytes(tCSR.Text), cbKey.Text);
  Close();
end;

procedure TFormImportcsr.bCancelClick(Sender: TObject);
begin
        Close();
end;

procedure TFormImportcsr.FormActivate(Sender: TObject);
begin
  cbKey.Items.Clear;
  ipaCertMgr1.ListKeys;
  cbKey.ItemIndex := 0;
end;

procedure TFormImportcsr.ipaCertMgr1KeyList(Sender: TObject;
  const KeyContainer: string; const KeyType: Integer; const AlgId: string;
  const KeyLen: Integer);
begin
  cbKey.Items.Add(KeyContainer);
end;

end.