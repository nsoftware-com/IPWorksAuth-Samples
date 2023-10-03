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

program kerberos;

uses
  Forms,
  kerberosf in 'kerberosf.pas' {FormKerberos};

begin
  Application.Initialize;

  Application.CreateForm(TFormKerberos, FormKerberos);
  Application.Run;
end.


         
