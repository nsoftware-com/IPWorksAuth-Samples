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
#define LINE_LEN 100
#define MESSAGE_LEN 1024

int main(int argc, char **argv)
{
  OTP hotp;
  OTP totp;
  totp.Reset();
  char buffer[LINE_LEN];
  int ret_code = 0;

  while (true) {
    printf("Please choose the algorithm:\n");
    printf("1) HOTP\n");
    printf("2) TOTP\n");
    printf("Q) Quit\n");
    printf("otp> ");
    fgets(buffer, LINE_LEN, stdin);
    buffer[strlen(buffer) - 1] = '\0';    
    hotp.Reset();    
    hotp.SetPasswordAlgorithm(1); 
    totp.SetPasswordAlgorithm(0);
    //for HOTP algorithm
    if (!strcmp(buffer, "1") || !strcmp(buffer, "hotp")) {
      while (1) {
        printf("Please specify an operation:\n");
        printf("1) Create Password \n");
        printf("2) Validate Password \n");
        printf("Q) Quit\n");
        printf("hotp> ");
        fgets(buffer, LINE_LEN, stdin);
        buffer[strlen(buffer) - 1] = '\0';        
        if (!strcmp(buffer, "1")) {          
          printf("Secret: ");
          fgets(buffer, LINE_LEN, stdin);
          buffer[strlen(buffer) - 1] = '\0';
          if (buffer[0] != '\0') {
            hotp.SetSecret(buffer);
          }
          else { 
            hotp.SetSecret("ABCDEFGHIJKLMNOP"); //if empty
          }
          printf("Counter: ");
          fgets(buffer, LINE_LEN, stdin);
          buffer[strlen(buffer) - 1] = '\0';
          if (buffer[0] != '\0') {
            hotp.SetCounter(atoi(buffer));// default 0
          }
          else {
            hotp.SetCounter(1); //if empty
          }
          hotp.CreatePassword();
          printf("Password: %s\n\n", hotp.GetPassword());          
        }
        else if (!strcmp(buffer, "2")) {          
          printf("Secret: ");
          fgets(buffer, LINE_LEN, stdin);
          buffer[strlen(buffer) - 1] = '\0';          
          if (buffer[0] != '\0') {
            hotp.SetSecret(buffer);
          }
          else {
            hotp.SetSecret("ABCDEFGHIJKLMNOP"); //if empty
          }
                   
          printf("Counter: ");          
          fgets(buffer, LINE_LEN, stdin);
          buffer[strlen(buffer) - 1] = '\0';          
          if (buffer[0] != '\0') {
            hotp.SetCounter(atoi(buffer));
          }
          else {
            hotp.SetCounter(1); //if empty
          }
          printf("Password: ");
          fgets(buffer, LINE_LEN, stdin);
          buffer[strlen(buffer) - 1] = '\0';
          hotp.SetPassword(buffer);          
          if (hotp.ValidatePassword()) {
            printf("VALID!\n\n");
          }
          else {
            printf("INVALID!\n\n");
          }
        }
        else if ((!strcmp(buffer, "q")) || (!strcmp(buffer, "Q"))) {
          break;
        }
        else {
          printf("Error: Input not recognized.\n\n");
        }
      }    
     }
    //for TOTP algorithm    
    else if (!strcmp(buffer, "2") || !strcmp(buffer, "totp")) {
      while (1) {
        printf("Please specify an operation:\n");
        printf("1) Create Password \n");
        printf("2) Validate Password \n");
        printf("Q) Quit\n");
        printf("totp> ");
        fgets(buffer, LINE_LEN, stdin);
        buffer[strlen(buffer) - 1] = '\0';

        if (!strcmp(buffer, "1")) {
          printf("Secret: ");
          fgets(buffer, LINE_LEN, stdin);
          buffer[strlen(buffer) - 1] = '\0';
          if (buffer[0] != '\0') {
            totp.SetSecret(buffer);
          }
          else {
            totp.SetSecret("ABCDEFGHIJKLMNOP"); //if empty
          }
          printf("TimeStep: ");
          fgets(buffer, LINE_LEN, stdin);
          buffer[strlen(buffer) - 1] = '\0';
          if (buffer[0] != '\0') {
            totp.SetTimeStep(atoi(buffer));
          }
          else {
            totp.SetTimeStep(30); //default
          }
          totp.CreatePassword();
          printf("Password: %s\n", totp.GetPassword());
          printf("Validity Time: %i\n\n", totp.GetValidityTime());
        }
        else if (!strcmp(buffer, "2")) {
          printf("Validity Time Remaining: %i\n\n", totp.GetValidityTime());
          printf("Secret: ");
          fgets(buffer, LINE_LEN, stdin);
          buffer[strlen(buffer) - 1] = '\0';          
          if (buffer[0] != '\0') {
            totp.SetSecret(buffer);
          }
          else {
            totp.SetSecret("ABCDEFGHIJKLMNOP"); // if empty
          }
          printf("TimeStep: ");
          fgets(buffer, LINE_LEN, stdin);
          buffer[strlen(buffer) - 1] = '\0';
          if (buffer[0] != '\0') {
            totp.SetTimeStep(atoi(buffer));
          }
          else {
            totp.SetTimeStep(30); // if empty
          }
          printf("Password: ");
          fgets(buffer, LINE_LEN, stdin);
          buffer[strlen(buffer) - 1] = '\0';
          totp.SetPassword(buffer);

          if (totp.ValidatePassword()) {
            printf("VALID!\n\n");
            continue;
          }
          else {
            printf("INVALID!\n\n");
            continue;
          }
        }
        else if ((!strcmp(buffer, "q")) || (!strcmp(buffer, "Q"))) {
          break;
        }
        else {
          printf("Error: Input not recognized.\n\n");
          continue;
        }
      }
    }
    else if ((!strcmp(buffer, "q")) || (!strcmp(buffer, "Q"))){
      break;
    }
    else{
      printf("Error: Input not recognized.\n\n");
    }
   }
	  exit(ret_code);
	  return 0;
  }


