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

class MyLDAP : public LDAP
{
public:
	bool showattrs;

	virtual int FireError(LDAPErrorEventParams *e)
	{
		printf( "%d  %s\n", e->ErrorCode, e->Description );
		return 0;
	}

	virtual int FireResult(LDAPResultEventParams *e)
	{
		printf( "%d  %s\n", e->ResultCode, e->ResultDescription );
		return 0;
	}

	virtual int FireSearchComplete(LDAPSearchCompleteEventParams *e)
	{
		printf( "%d  %s\n", e->ResultCode, e->ResultDescription);
		return 0;
	}

	virtual int FireSearchResult(LDAPSearchResultEventParams *e)
	{
		if (showattrs)
		{
			printf( "\r\nAttributes of %s:\r\n\r\n", e->DN );
			for (int i=0; i<GetAttrCount(); i++)
			{
				char* attrval;
				int attrvallen;
				GetAttrValue(i, attrval, attrvallen);
				printf("\t%-20.20s\t%40.40s\r\n", GetAttrType(i), attrval );
			}
		}
		else printf( "%s\r\n", e->DN );
		return 0;
	}

	virtual int FireSSLServerAuthentication(LDAPSSLServerAuthenticationEventParams *e)
	{
		if (e->Accept) return 0;
		printf("Server provided the following certificate:\nIssuer: %s\nSubject: %s\n",
		       e->CertIssuer, e->CertSubject);
		printf("The following problems have been determined for this certificate: %s\n", e->Status);
		printf("Would you like to continue anyways? [y/n] ");
		if (getchar() == 'y') e->Accept = true;
		else exit(0);
		return 0;
	}

};

int main()
{

	MyLDAP LDAP;
	int ret_code = 0;
	char buffer[LINE_LEN];
	char filter[LINE_LEN];
	char binddn[LINE_LEN];
	char bindpassword[LINE_LEN];
	char searchdn[LINE_LEN];

	//find out the server to connect to
	printf( "Directory Server: " );  // try www.openldap.org or ldap-master.itd.umich.edu
	fgets(buffer,LINE_LEN,stdin);
	buffer[strlen(buffer)-1] = '\0';
	if ( ret_code = LDAP.SetServerName( buffer ) ) goto done;

	//get the DN and password to bind with:
	printf( "Bind DN (e.g., Domain\\User or full DN, blank = anonymous bind): " );
	fgets(binddn,LINE_LEN,stdin);
	binddn[strlen(binddn)-1] = '\0';
	if (strlen(binddn) != 0)
	{
		printf( "Bind Password: " );
		fgets(bindpassword,LINE_LEN,stdin);
		bindpassword[strlen(bindpassword)-1] = '\0';
	}

	//get the DN to search:
	printf( "Search DN (e.g., CN=Users,DC=Domain): " );
	fgets(searchdn,LINE_LEN,stdin);
	searchdn[strlen(searchdn)-1] = '\0';

	//get the search filter
	printf( "search filter [cn=*]: " );
	fgets(filter,LINE_LEN,stdin);
	filter[strlen(filter)-1] = '\0';
	if (strlen(filter) == 0) strcat(filter,"cn=*");

	//Show attributes in search results?
	LDAP.showattrs = false;
	printf( "Show search results attributes? [n]: " );
	fgets(buffer,LINE_LEN,stdin);
	buffer[strlen(buffer)-1] = '\0';
	if (strlen(buffer) != 0 && buffer[LINE_LEN+1] != 'n' ) LDAP.showattrs = true;

	//for non-SSL on port 389:
	//if ( ret_code = LDAP.SetServerPort( 389 ) ) goto done;
	//LDAP.SetSSLStartMode(3);

	strcpy( buffer, "" );

	do
	{
		//To limit the search to a specific set of attributes, set them prior to the search.
		//otherwise, the server will return all attributes in any search results.
		//if ( ret_code = LDAP.SetAttrCount(1) ) goto done;
		//if ( ret_code = LDAP.SetAttrType(0, "email") ) goto done;

		LDAP.SetTimeout(10);  //puts component in synchronous mode

		//some servers required an explicit bind
		printf( "\r\n\r\nSending bind request..." );
		LDAP.SetDN(binddn);
		LDAP.SetPassword(bindpassword);
		if (ret_code = LDAP.Bind()) goto done;
		if (LDAP.GetResultCode() == 0) printf( "Successfully bound as %s\r\n", LDAP.GetDN());
		else printf("Bind result: %s\r\n", LDAP.GetResultDescription());

		//send the search request
		printf( "\r\nsending search request...\r\n" );
		LDAP.SetSearchScope(2); //2 (default) = whole subtree, 1 = single level, 0 = base object
		LDAP.SetSearchSizeLimit(100);
		LDAP.SetDN(searchdn);
		if (ret_code = LDAP.Search(filter)) goto done;

		printf( "another search? (y/n) " );
		fgets(buffer,LINE_LEN,stdin);
		buffer[strlen(buffer)-1] = '\0';

	}
	while( buffer[LINE_LEN+1] != 'n' );

done:
	if (ret_code)     // Got an error.  The user is done.
	{
		printf( "\nError: %d", ret_code );
		if (LDAP.GetLastError())
		{
			printf( " \"%s\"\n", LDAP.GetLastError() );
		}
		else if ( ret_code == 10060) printf( " \"[10060] Request timed out\"\n" );
	}
	printf("\nPress enter to continue...");
	getchar();
	exit(ret_code);
	return 0;
}

