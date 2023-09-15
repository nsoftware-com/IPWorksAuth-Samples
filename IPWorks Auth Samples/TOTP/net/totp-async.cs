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

class totpDemo
{
  private static Totp totp = new nsoftware.async.IPWorksAuth.Totp();

  static async Task Main(string[] args)
  {
    try
    {
      Console.WriteLine("Type \"?\" for a list of commands.");
      Console.Write("totp> ");
      string command;
      string[] arguments;
      while (true)
      {
        command = Console.ReadLine();
        arguments = command.Split();

        if (arguments[0] == "?" || arguments[0] == "help")
        {
          Console.WriteLine("Commands: ");
          Console.WriteLine("  ?                               display the list of valid commands");
          Console.WriteLine("  help                            display the list of valid commands");
          Console.WriteLine("  create <secret>                 create a password using the specified secret");
          Console.WriteLine("  validate <password> <secret>    validate the specified password");
          Console.WriteLine("  quit                            exit the application");
        }
        else if (arguments[0] == "quit" || arguments[0] == "exit")
        {
          break;
        }
        else if (arguments[0] == "create")
        {
          if (arguments.Length > 1)
          {
            await totp.Reset();
            totp.Secret = arguments[1];

            await totp.CreatePassword();
            Console.WriteLine("Password: " + totp.Password + "\r\n");
            Console.WriteLine("Validity Time: " + totp.ValidityTime + "\r\n");
          }
        }
        else if (arguments[0] == "validate")
        {
          if (arguments.Length > 2)
          {
            await totp.Reset();
            totp.Password = arguments[1];
            totp.Secret = arguments[2];

            if (await totp.ValidatePassword())
              Console.WriteLine("Valid!\r\n");
            else
              Console.WriteLine("Invalid!\r\n");
          }
        }
        else if (arguments[0] == "")
        {
          // Do nothing.
        }
        else
        {
          Console.WriteLine("Invalid command.");
        } // End of command checking.

        Console.Write("totp> ");
      }
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