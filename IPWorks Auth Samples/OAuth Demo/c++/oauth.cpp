/*
 * IPWorks Auth 2024 C++ Edition - Sample Project
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

class MyOAuth : public OAuth
{
public:
  virtual int FireLaunchBrowser(OAuthLaunchBrowserEventParams *e)
  {
  	// Normally, the component will execute the command property to launch the browser for authorization.
	// Setting the command to an empty string will prevent a browser from opening the URL. The following 
	// line can be un-commented to exhibit this behavior.
    //e->Command = "";
    printf("Authorization URL: %s\n\n", e->URL);
    return 0;
  }
};

int main(int args, char **argv)
{

  MyOAuth oauth; //OAuth object
  char buffer[LINE_LEN]; // user input

  printf("This application demonstrates how to use the OAuth component to authenticate\n");
  printf("with Google using OAuth 2.0 (Device Profile). It will guide you through the \n");
  printf("steps to perform authorization using OAuth. Please see the Introduction page\n");
  printf("within the help for more detailed instructions.\n\n");

  // Client ID and Client Secret
  printf("1. Obtain and set your Client ID and Client Secret. For Google, these values\n");
  printf("can be found in the API Console: https://code.google.com/apis/console#access\n");
  printf("The default values are from a Google test account that we have setup for you to\n");
  printf("easily run this demo.\n\n");

  printf("Client ID [723966830965.apps.googleusercontent.com]: ");
  fgets(buffer, LINE_LEN, stdin);
  buffer[strlen(buffer)-1] = '\0';
  if (strlen(buffer) == 0) { 
    oauth.SetClientId("723966830965.apps.googleusercontent.com"); 
  } else { 
    oauth.SetClientId(buffer); 
  }
  
  printf("Client Secret [_bYMDLuvYkJeT_99Q-vkP1rh]: ");
  fgets(buffer, LINE_LEN, stdin);
  buffer[strlen(buffer)-1] = '\0';
  if (strlen(buffer) == 0) {
    oauth.SetClientSecret("_bYMDLuvYkJeT_99Q-vkP1rh");
  } else {
    oauth.SetClientSecret(buffer);
  }


  // Server Auth URL, Server Token URL, and Authorization Scope
  printf("\n2. You can also set Server Auth URL, Server Token URL, and Authorization\n");
  printf("Scope to the values desired. These are preset to values for Google's User Info\n");
  printf("service.\n\n");

  printf("Server Auth URL [https://accounts.google.com/o/oauth2/auth]: ");
  fgets(buffer, LINE_LEN, stdin);
  buffer[strlen(buffer)-1] = '\0';
  if (strlen(buffer) == 0) {
    oauth.SetServerAuthURL("https://accounts.google.com/o/oauth2/auth");
  } else {
    oauth.SetServerAuthURL(buffer);
  }

  printf("Server Token URL [https://accounts.google.com/o/oauth2/token]: ");
  fgets(buffer, LINE_LEN, stdin);
  buffer[strlen(buffer)-1] = '\0';
  if (strlen(buffer) == 0) {
    oauth.SetServerTokenURL("https://accounts.google.com/o/oauth2/token");
  } else {
    oauth.SetServerTokenURL(buffer);
  }
  
  printf("Authorization Scope [https://www.googleapis.com/auth/userinfo.email]: ");
  fgets(buffer, LINE_LEN, stdin);
  buffer[strlen(buffer)-1] = '\0';
  if (strlen(buffer) == 0) {
    oauth.SetAuthorizationScope("https://www.googleapis.com/auth/userinfo.email");
  } else {
    oauth.SetAuthorizationScope(buffer);
  }


  // Get Authorize URL for user to authenticate
  printf("\n3. The following URL will open in a web browser to authenticate to the\n");
  printf("service. Upon successfully authenticating and allowing access, the user will\n");
  printf("be redirected back to an embedded web server within the component.\n"); 
  
  printf("\n4. Authorization String received: %s\n", oauth.GetAuthorization());
  
  printf("\nPress enter to exit...");
  fgets(buffer, LINE_LEN, stdin);

  return 0;
};

