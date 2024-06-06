/*
 * IPWorks Auth 2024 Java Edition - Sample Project
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
import java.io.*;
import ipworksauth.*;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStreamReader;

public class otp extends ConsoleDemo {
    public static void main(String[] args) {
        OTP hotp = new OTP();
        OTP totp = new OTP();
        try {
            String choice="";
            while (true) {
                System.out.println("Choose the OTP algorithm:");
                System.out.println("1) HOTP");
                System.out.println("2) TOTP");
                System.out.println("Q (Quit)");
                choice = prompt("otp", ">");
                if (choice.equalsIgnoreCase("hotp")||choice.equalsIgnoreCase("1")) {
                    String option = "";
                    while (!option.equalsIgnoreCase("q")&&!option.equalsIgnoreCase("quit")) {
                        System.out.println("Please select an operation:");
                        System.out.println("1)  Create Password");
                        System.out.println("2)  Validate Password");
                        System.out.println("Q)  Quit");
                        option = prompt("hotp", ">");
                        hotp.reset();
                        hotp.setPasswordAlgorithm(1);
                        // Initial setup
                        if (option.equals("1")) {
                            hotp.setSecret(prompt("Secret", ":", "ABCDEFGHIJKLMNOP"));
                            hotp.setCounter(Integer.parseInt(prompt("Counter", ":", "1")));
                            hotp.createPassword();
                            System.out.println("Password: " + hotp.getPassword() + "\r\n");
                        } else if (option.equals("2")) {
                            hotp.setSecret(prompt("Secret", ":", "ABCDEFGHIJKLMNOP"));
                            hotp.setCounter(Integer.parseInt(prompt("Counter", ":", "1")));
                            hotp.setPassword(prompt("Password", ":"));
                            if (hotp.validatePassword()) {
                                System.out.println("VALID!\r\n");
                            } else {
                                System.out.println("INVALID!\r\n");
                            }
                        } else if (!option.equalsIgnoreCase("q")&&!option.equalsIgnoreCase("quit")) {
                            System.out.println("Error: Input not recognized.");
                        } else { continue;
                        }
                    }
                } else if (choice.equalsIgnoreCase("totp")||choice.equalsIgnoreCase("2")) {
                    String option = "";
                    while (!option.equalsIgnoreCase("q")&&!option.equalsIgnoreCase("quit")) {
                        System.out.println("Please select an operation:");
                        System.out.println("1)  Create Password");
                        System.out.println("2)  Validate Password");
                        System.out.println("Q)  Quit");
                        option = prompt("totp", ">");
                        totp.setPasswordAlgorithm(0); //also by default
                        // Initial setup
                        if (option.equals("1")) {
                            totp.setSecret(prompt("Secret", ":", "ABCDEFGHIJKLMNOP"));
                            totp.setTimeStep(Integer.parseInt(prompt("TimeStep", ":", "30")));
                            totp.createPassword();
                            System.out.println("Validity Time: " + totp.getValidityTime() + "\r\n");
                            System.out.println("Password: " + totp.getPassword());
                        } else if (option.equals("2")) {
                            System.out.println("Validity Time: " + totp.getValidityTime() + "\r\n");
                            totp.setSecret(prompt("Secret", ":", "ABCDEFGHIJKLMNOP"));
                            totp.setTimeStep(Integer.parseInt(prompt("TimeStep", ":", "30")));
                            totp.setPassword(prompt("Password", ":"));
                            if (totp.validatePassword()) {
                                System.out.println("VALID!\r\n");
                            } else {
                                System.out.println("INVALID!\r\n");
                            }
                        } else if (!option.equalsIgnoreCase("q")&&!option.equalsIgnoreCase("quit")) {
                            System.out.println("Error: Input not recognized.");
                        } else { continue;
                        }
                    }
                } else if(choice.equalsIgnoreCase("q")||choice.equalsIgnoreCase("quit")){
                    break;
                }else { System.out.println("Error: Input not recognized.");
                }
            }
        } catch(IPWorksAuthException ex){
            System.out.println("IPWorksAuth exception thrown: " + ex.getCode()
                    + " [" + ex.getMessage() + "].");
        } catch(Exception ex){
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
  static String prompt(String label, String punctuation, String defaultVal) {
      System.out.print(label + " [" + defaultVal + "] " + punctuation + " ");
      String response = input();
      if (response.equals(""))
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



