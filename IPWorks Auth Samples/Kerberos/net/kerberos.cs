/*
 * IPWorks Auth 2024 .NET Edition - Sample Project
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

﻿using System;
using nsoftware.IPWorksAuth;

class kerberosDemo
{
  private static Kerberos kerberos = new nsoftware.IPWorksAuth.Kerberos();

  static void Main(string[] args)
  {
    try
    {
      Console.WriteLine("This demo shows how to use the Kerberos component to authenticate a user.\n" +
        "To begin, specify the User, Password, SPN (Service Principal Name), and KDCHost (the Kerberos server).\n");

      kerberos.User = ConsoleDemo.Prompt("Please enter your User", "");
      kerberos.Password = ConsoleDemo.Prompt("Please enter your Password", "");
      kerberos.SPN = ConsoleDemo.Prompt("Please enter your SPN", "");
      kerberos.KDCHost = ConsoleDemo.Prompt("Please enter your KDCHost", "");

      kerberos.Authenticate();
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
  /// <summary>
  /// Takes a list of switch arguments or name-value arguments and turns it into a dictionary.
  /// </summary>
  public static System.Collections.Generic.Dictionary<string, string> ParseArgs(string[] args)
  {
    System.Collections.Generic.Dictionary<string, string> dict = new System.Collections.Generic.Dictionary<string, string>();

    for (int i = 0; i < args.Length; i++)
    {
      // Add a key to the dictionary for each argument.
      if (args[i].StartsWith("/"))
      {
        // If the next argument does NOT start with a "/", then it is a value.
        if (i + 1 < args.Length && !args[i + 1].StartsWith("/"))
        {
          // Save the value and skip the next entry in the list of arguments.
          dict.Add(args[i].ToLower().TrimStart('/'), args[i + 1]);
          i++;
        }
        else
        {
          // If the next argument starts with a "/", then we assume the current one is a switch.
          dict.Add(args[i].ToLower().TrimStart('/'), "");
        }
      }
      else
      {
        // If the argument does not start with a "/", store the argument based on the index.
        dict.Add(i.ToString(), args[i].ToLower());
      }
    }
    return dict;
  }
  /// <summary>
  /// Asks for user input interactively and returns the string response.
  /// </summary>
  public static string Prompt(string prompt, string defaultVal)
  {
    Console.Write(prompt + (defaultVal.Length > 0 ? " [" + defaultVal + "]": "") + ": ");
    string val = Console.ReadLine();
    if (val.Length == 0) val = defaultVal;
    return val;
  }
}