/*
 * IPWorks Auth 2022 C++ Edition - Sample Project
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
 */


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "../../include/ipworksauth.h"
#define LINE_LEN 80

class MySAML : public SAML
{
public:
  virtual int FireSSLServerAuthentication (SAMLSSLServerAuthenticationEventParams *e)
  {
    e->Accept = true;
    return 0;
  }
};

int main(int argc, char **argv)
{
	MySAML saml;
	char buffer[LINE_LEN];
	buffer[strlen(buffer)-1] = '\0';
	int ret_code=0;

while((strcmp(buffer, "q") != 0) && (strcmp(buffer, "Q") != 0))
{
  printf("Please select an AuthMode:\n");
  printf("1) SharePoint Online\n");
  printf("2) Dynamics CRM\n");
  printf("3) ADFS\n");
  printf("Q) Quit\n");
  printf("Option> ");

	fgets(buffer, LINE_LEN, stdin);
  buffer[strlen(buffer)-1] = '\0';
  
  if (! strcmp(buffer, "1")) // SharePoint Online
  {
    saml.SetAuthMode(CAM_SHARE_POINT_ONLINE);
    saml.SetUser("user@mycrm.onmicrosoft.com");
    saml.SetApplicationURN("https://mycrm.sharepoint.com");

    printf("\nUsername (user@mycrm.onmicrosoft.com): ");
	  fgets(buffer, LINE_LEN, stdin);
	  buffer[strlen(buffer)-1] = '\0';
    if (strlen(buffer) > 0)
      saml.SetUser(buffer);

    printf("Password: ");
    fgets(buffer, LINE_LEN, stdin);
    buffer[strlen(buffer)-1] = '\0';
    saml.SetPassword(buffer);

    printf("Application URN (https://mycrm.sharepoint.com): ");
    fgets(buffer, LINE_LEN, stdin);
    buffer[strlen(buffer)-1] = '\0';
    if (strlen(buffer) > 0)
      saml.SetApplicationURN(buffer);

    printf("Obtaining Security Token...\n\n");
    ret_code = saml.GetSecurityToken();
    if (ret_code) goto done;

    printf("Security Token:\n%s\n\n", saml.GetSecurityTokenXML());
  } 
  else if (! strcmp(buffer, "2")) // Dynamics CRM
  {
    saml.SetAuthMode(CAM_DYNAMICS_CRM);
    saml.SetUser("user@mycrm.onmicrosoft.com");
    saml.SetApplicationURN("urn:crmapac:dynamics.com");

    printf("\nUsername (user@mycrm.onmicrosoft.com): ");
	  fgets(buffer, LINE_LEN, stdin);
	  buffer[strlen(buffer)-1] = '\0';
	  if (strlen(buffer) > 0)
      saml.SetUser(buffer);

    printf("Password: ");
    fgets(buffer, LINE_LEN, stdin);
    buffer[strlen(buffer)-1] = '\0';
    saml.SetPassword(buffer);

    printf("Application URN (urn:crmapac:dynamics.com): ");
    fgets(buffer, LINE_LEN, stdin);
    buffer[strlen(buffer)-1] = '\0';
    if (strlen(buffer) > 0)
      saml.SetApplicationURN(buffer);

    printf("Obtaining Security Token...\n\n");
    ret_code = saml.GetSecurityToken();
    if (ret_code) goto done;

    printf("Security Token:\n%s\n\n", saml.GetSecurityTokenXML());
  } 
  else if (! strcmp(buffer, "3")) // ADFS
  {
    saml.SetAuthMode(CAM_ADFS);
    saml.SetApplicationURN("https://fsweb.contoso.com/ClaimsAwareWebAppWithManagedSTS/");
    saml.SetLocalSTS("https://adfs.contoso.com/adfs/services/trust/2005/usernamemixed");

    printf("\nUser: ");
	  fgets(buffer, LINE_LEN, stdin);
	  buffer[strlen(buffer)-1] = '\0';
	  saml.SetUser(buffer);

    printf("Password: ");
    fgets(buffer, LINE_LEN, stdin);
    buffer[strlen(buffer)-1] = '\0';
    saml.SetPassword(buffer);

    printf("Application URN (https://fsweb.contoso.com/ClaimsAwareWebAppWithManagedSTS/): ");
    fgets(buffer, LINE_LEN, stdin);
    buffer[strlen(buffer)-1] = '\0';
    if (strlen(buffer) > 0)
      saml.SetApplicationURN(buffer);

    printf("Local STS (https://adfs.contoso.com/adfs/services/trust/2005/usernamemixed): ");
    fgets(buffer, LINE_LEN, stdin);
    buffer[strlen(buffer)-1] = '\0';
    if (strlen(buffer) > 0)
      saml.SetLocalSTS(buffer);
    
    printf("Obtaining Assertion...\n\n");
    ret_code = saml.GetAssertion();
    if (ret_code) goto done;

    printf("Assertion:\n%s\n\n", saml.GetAssertionXML());
  }
  else if(strcmp(buffer, "q") && strcmp(buffer, "Q"))
  {
    printf("\nInvalid Option\n\n");
  }
  else
  {
    continue;
  }
  
done:
	if (ret_code)     // Got an error.  The user is done.
	{
		printf( "Error: %d", ret_code );
    if (saml.GetLastError())
		{
			printf( " \"%s\"\n\n", saml.GetLastError() );
		}
	}

  fprintf(stderr, "press <return> to continue...\n");
	getchar();
}
	exit(ret_code);
	return 0;

}











