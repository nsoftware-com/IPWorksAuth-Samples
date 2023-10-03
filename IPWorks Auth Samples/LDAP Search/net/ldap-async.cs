/*
 * IPWorks Auth 2022 .NET Edition - Sample Project
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
 * 
 */

using System.Collections.Generic;
﻿using System;
using System.Threading.Tasks;
using nsoftware.async.IPWorksAuth;

class ldapDemo
{
  private static Ldap ldap = new nsoftware.async.IPWorksAuth.Ldap();

  static async Task Main(string[] args)
  {
    if (args.Length < 6)
    {
      Console.WriteLine("usage: ldap /s server /dn dn /p params\n");
      Console.WriteLine("  server    the name or address of the LDAP server");
      Console.WriteLine("  dn        the DN to bind with");
      Console.WriteLine("  params    the parameters to search for");
      Console.WriteLine("\nExample: ldap /s ldap.umich.edu /dn \"dc=umich, dc=edu\" /p cn=*");
    }
    else
    {
      ldap.OnSSLServerAuthentication += ldap_OnSSLServerAuthentication;
      ldap.OnSearchResult += ldap_OnSearchResult;

      try
      {
        Dictionary<string, string> myArgs = ConsoleDemo.ParseArgs(args);

        ldap.ServerName = myArgs["s"];
        ldap.DN = myArgs["dn"];

        Console.WriteLine("Sending bind request...");
        await ldap.Bind();
        Console.WriteLine("Bind result: " + ldap.ResultDescription);

        Console.WriteLine("\nSending search request...");
        await ldap.Search(myArgs["p"]);
      }
      catch (Exception ex)
      {
        Console.WriteLine(ex.Message);
      }
    }
  }

  private static void ldap_OnSSLServerAuthentication(object sender, LdapSSLServerAuthenticationEventArgs e)
  {
    if (e.Accept) return;
    Console.Write("Server provided the following certificate:\nIssuer: " + e.CertIssuer + "\nSubject: " + e.CertSubject + "\n");
    Console.Write("The following problems have been determined for this certificate: " + e.Status + "\n");
    Console.Write("Would you like to continue anyways? [y/n] ");
    if (Console.Read() == 'y') e.Accept = true;
  }

  private static void ldap_OnSearchResult(object sender, LdapSearchResultEventArgs e)
  {
    Console.WriteLine(e.DN);
  }
}


class ConsoleDemo
{
  public static Dictionary<string, string> ParseArgs(string[] args)
  {
    Dictionary<string, string> dict = new Dictionary<string, string>();

    for (int i = 0; i < args.Length; i++)
    {
      // If it starts with a "/" check the next argument.
      // If the next argument does NOT start with a "/" then this is paired, and the next argument is the value.
      // Otherwise, the next argument starts with a "/" and the current argument is a switch.

      // If it doesn't start with a "/" then it's not paired and we assume it's a standalone argument.

      if (args[i].StartsWith("/"))
      {
        // Either a paired argument or a switch.
        if (i + 1 < args.Length && !args[i + 1].StartsWith("/"))
        {
          // Paired argument.
          dict.Add(args[i].TrimStart('/'), args[i + 1]);
          // Skip the value in the next iteration.
          i++;
        }
        else
        {
          // Switch, no value.
          dict.Add(args[i].TrimStart('/'), "");
        }
      }
      else
      {
        // Standalone argument. The argument is the value, use the index as a key.
        dict.Add(i.ToString(), args[i]);
      }
    }
    return dict;
  }

  public static string Prompt(string prompt, string defaultVal)
  {
    Console.Write(prompt + (defaultVal.Length > 0 ? " [" + defaultVal + "]": "") + ": ");
    string val = Console.ReadLine();
    if (val.Length == 0) val = defaultVal;
    return val;
  }
}