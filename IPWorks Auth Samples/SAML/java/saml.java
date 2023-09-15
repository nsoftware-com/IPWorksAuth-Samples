/*
 * IPWorks Auth 2022 Java Edition - Sample Project
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

import java.io.*;
import ipworksauth.*;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStreamReader;

public class saml extends ConsoleDemo {
	public static void main(String[] args) {
		Saml saml = new Saml();

		try {

			saml
					.addSamlEventListener(new ipworksauth.DefaultSamlEventListener() {
						public void SSLServerAuthentication(
								ipworksauth.SamlSSLServerAuthenticationEvent e) {
							// For the purposes of this demo we will accept any
							// server certificate
							e.accept = true;
						}
					});
			String authMode = "";
			while (!authMode.equalsIgnoreCase("q")) {
				System.out
						.println("******************************************************************************************");
				System.out
						.println("To begin, select the AuthMode. For SharePoint Online and Dynamics CRM simply specify your \r\n"
								+ "email address, password, and ApplicationURN. For ADFS you must also specify a LocalSTS. Note that \r\n"
								+ "this demo is configured for simple common scenarios. Please see the help file for more details.");
				System.out
						.println("******************************************************************************************");

				System.out.println("Please select an AuthMode:");
				System.out.println("1)  SharePoint Online");
				System.out.println("2)  Dynamics CRM");
				System.out.println("3)  ADFS");
				System.out.println("Q)  Quit");

				authMode = prompt("\r\noption", ">");

				// Initial setup
				if (authMode.equals("1")) // SharePoint Online
				{
					saml.setAuthMode(Saml.camSharePointOnline);
					saml.setUser(prompt("Username", ":",
							"user@mycrm.onmicrosoft.com"));
					saml.setPassword(prompt("Password"));
					saml.setApplicationURN(prompt("Application URN", ":",
							"https://mycrm.sharepoint.com"));
				} else if (authMode.equals("2")) {
					saml.setAuthMode(Saml.camDynamicsCRM);
					saml.setUser(prompt("Username", ":",
							"user@mycrm.onmicrosoft.com"));
					saml.setPassword(prompt("Password"));
					saml.setApplicationURN(prompt("Application URN", ":",
							"urn:crmapac:dynamics.com"));
				} else if (authMode.equals("3")) {
					saml.setAuthMode(Saml.camADFS);
					saml.setUser(prompt("User"));
					saml.setPassword(prompt("Password"));
					saml
							.setApplicationURN(prompt("Application URN", ":",
									"https://fsweb.contoso.com/ClaimsAwareWebAppWithManagedSTS/"));
					saml
							.setLocalSTS(prompt("Local STS", ":",
									"https://adfs.contoso.com/adfs/services/trust/2005/usernamemixed"));
				} else if (!authMode.equalsIgnoreCase("q")){
					System.out.println("Error: Input not recognized.");
					continue;
				} else {
					continue;
				}

				// If using SharePoint Online or Dynamics CRM call
				// GetSecurityToken()
				if (saml.getAuthMode() == Saml.camSharePointOnline
						|| saml.getAuthMode() == Saml.camDynamicsCRM) {
					System.out.println("\r\nObtaining Security Token ...");
					saml.getSecurityToken();
					System.out.println("\r\nSecurity Token:\r\n"
							+ saml.getSecurityTokenXML());
				} else // If using ADFS call GetAssertion to get the assertion
						// from the LocalSTS
				{
					System.out.println("\r\nObtaining Assertion ...");
					saml.getAssertion();
					System.out.println("\r\nAssertion:\r\n"
							+ saml.getAssertionXML());
				}
			}

		} catch (IPWorksAuthException ex) {
			System.out.println("IPWorksAuth exception thrown: " + ex.getCode()
					+ " [" + ex.getMessage() + "].");
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
}
class ConsoleDemo {
  private static BufferedReader bf = new BufferedReader(new InputStreamReader(System.in));

  static String input() {
    try {
      return bf.readLine();
    } catch (IOException ioe) {
      return "";
    }
  }
  static char read() {
    return input().charAt(0);
  }

  static String prompt(String label) {
    return prompt(label, ":");
  }
  static String prompt(String label, String punctuation) {
    System.out.print(label + punctuation + " ");
    return input();
  }

  static String prompt(String label, String punctuation, String defaultVal)
  {
	System.out.print(label + " [" + defaultVal + "] " + punctuation + " ");
	String response = input();
	if(response.equals(""))
		return defaultVal;
	else
		return response;
  }

  static char ask(String label) {
    return ask(label, "?");
  }
  static char ask(String label, String punctuation) {
    return ask(label, punctuation, "(y/n)");
  }
  static char ask(String label, String punctuation, String answers) {
    System.out.print(label + punctuation + " " + answers + " ");
    return Character.toLowerCase(read());
  }

  static void displayError(Exception e) {
    System.out.print("Error");
    if (e instanceof IPWorksAuthException) {
      System.out.print(" (" + ((IPWorksAuthException) e).getCode() + ")");
    }
    System.out.println(": " + e.getMessage());
    e.printStackTrace();
  }
}



