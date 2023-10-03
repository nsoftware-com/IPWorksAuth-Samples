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

class kerberosDemo
{
  private static Kerberos kerberos = new nsoftware.async.IPWorksAuth.Kerberos();

  static async Task Main(string[] args)
  {
    try
    {
      Console.WriteLine("This demo shows hpw to use the Kerberos component to authenticate a user.\n" +
        "To begin, specify the User, Password, SPN (Service Principal Name), and KDCHost (the Kerberos server).\n");

      kerberos.User = ConsoleDemo.Prompt("Please enter your User", "");
      kerberos.Password = ConsoleDemo.Prompt("Please enter your Password", "");
      kerberos.SPN = ConsoleDemo.Prompt("Please enter your SPN", "");
      kerberos.KDCHost = ConsoleDemo.Prompt("Please enter your KDCHost", "");

      await kerberos.Authenticate();
      Console.WriteLine("\nAuthenticated!");
    }
    catch (Exception ex)
    {
      Console.WriteLine(ex.Message);
    }
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