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
unit ldapf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ipacore, ipatypes, ipaldap;

type
  TFormLdap = class(TForm)
    Memo1: TMemo;
    tServer: TEdit;
    Label2: TLabel;
    tFilter: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    ipaLDAP1: TipaLDAP;
    Label4: TLabel;
    tBaseDN: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ipaLDAP1SearchComplete(Sender: TObject; MessageId: Integer;
      const DN: String; ResultCode: Integer; const Description: String);
    procedure ipaLDAP1SearchResult(Sender: TObject; MessageId: Integer;
      const DN: String);
    procedure ipaLDAP1SSLServerAuthentication(Sender: TObject;
      CertEncoded: string; CertEncodedB: TArray<System.Byte>; const CertSubject, CertIssuer, Status: String;
      var Accept: Boolean);
    procedure ipaLDAP1SSLStatus(Sender: TObject; const Message: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLdap: TFormLdap;

implementation

{$R *.DFM}

procedure TFormLdap.Button1Click(Sender: TObject);
begin
    Memo1.Clear;
    ipaLDAP1.ServerName := tServer.Text;
    ipaLDAP1.SearchSizeLimit := 100; // at most 100 results
    ipaLDAP1.Timeout := 0; //set timeout > 0 to use in synch mode
    //set the required attributes
    ipaLDAP1.AttrCount := 1;
    ipaLDAP1.AttrType[0] := 'mail';  // put 'email' for addresses etc...

    Memo1.Lines.Add('sending search request...');

    ipaLDAP1.DN := tBaseDN.Text;
    ipaLDAP1.Search(tFilter.Text);

    Memo1.Lines.Add('waiting for server response...');
    Screen.Cursor := crHourGlass;
end;

procedure TFormLdap.Button2Click(Sender: TObject);
begin
    ipaLDAP1.Interrupt();
end;

procedure TFormLdap.ipaLDAP1SearchComplete(Sender: TObject;
  MessageId: Integer; const DN: String; ResultCode: Integer;
  const Description: String);
begin
    Memo1.Lines.Add('search complete: ' + IntToStr(ResultCode) + ' ' + Description);
    ipaLDAP1.Unbind();
    Screen.Cursor := crDefault;
end;

procedure TFormLdap.ipaLDAP1SearchResult(Sender: TObject; MessageId: Integer;
  const DN: String);
begin
    Memo1.Lines.Add(DN);
end;


procedure TFormLdap.ipaLDAP1SSLServerAuthentication(Sender: TObject;
  CertEncoded: string; CertEncodedB: TArray<System.Byte>; const CertSubject, CertIssuer, Status: String;
  var Accept: Boolean);
var
  S: String;
begin
  if not Accept then
    begin
      S := 'Server provided the following certificate' + #13#10#13#10 +
      '    Issuer: ' + CertIssuer + #13#10 +
      '    Subject: ' + CertSubject + #13#10#13#10 +
      'The following problems have been determined for this certificate: ' + Status + #13#10#13#10 +
      'Would you like to continue or cancel the connection?';
      if (MessageDlg(S, mtInformation, [mbYes, mbNo, mbCancel], 0) = mrYes) then Accept := true;

    end;
end;
procedure TFormLdap.ipaLDAP1SSLStatus(Sender: TObject;
  const Message: String);
begin
     Memo1.Lines.Add(Message);
end;

end.

