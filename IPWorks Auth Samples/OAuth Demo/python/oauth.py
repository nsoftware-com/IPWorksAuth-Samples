# 
# IPWorks Auth 2024 Python Edition - Sample Project
# 
# This sample project demonstrates the usage of IPWorks Auth in a 
# simple, straightforward way. It is not intended to be a complete 
# application. Error handling and other checks are simplified for clarity.
# 
# www.nsoftware.com/ipworksauth
# 
# This code is subject to the terms and conditions specified in the 
# corresponding product license agreement which outlines the authorized 
# usage and restrictions.
# 

import sys
import string
from ipworksauth import *

input = sys.hexversion < 0x03000000 and raw_input or input


def ensureArg(args, prompt, index):
    if len(args) <= index:
        while len(args) <= index:
            args.append(None)
        args[index] = input(prompt)
    elif args[index] is None:
        args[index] = input(prompt)



def fireError(e):
  print(e.message)

def fireLog(e):
  print(e.message)

def fireConnected(e):
  print(e.description)

oauth = OAuth()
oauth.on_error = fireError
oauth.on_log = fireLog
oauth.on_connected = fireConnected

try:
  print("\nThis application demonstrates how to use the OAuth component to authenticate with Google using OAuth 2.0 (Device Profile).")
  print("It will guide you through the steps to perform authorization using OAuth.")
  print("Please see the Introduction page within the help for more detailed instructions. \n")

  print("1. Obtain and set your Client ID and Client Secret. For Google, these values can be found in the API Console: \n")
  print("https://code.google.com/apis/console#access \n")
  print("The values that are given as an example are from a Google test account that we have setup for you to easily run this demo. \n")

  clientID = input("Client ID: ")
  if clientID == "":
    clientID = "723966830965.apps.googleusercontent.com"
  clientSecret = input("Client Secret: ")
  if clientSecret == "":
    clientSecret = "_bYMDLuvYkJeT_99Q-vkP1rh"

  print("\n2. You can also set Server Auth URL, Server Token URL, and Authorization Scope to the values desired.")
  print("These are preset to values for Google's User Info service. \n")

  serverAuthURL = input("Server Auth URL: ")
  if serverAuthURL == "":
    serverAuthURL = "https://accounts.google.com/o/oauth2/auth"
  serverTokenURL = input("Server Token URL: ")
  if serverTokenURL == "":
    serverTokenURL = "https://accounts.google.com/o/oauth2/token"
  authScope = input("Authorization Scope: ")
  if authScope == "":
    authScope = "https://www.googleapis.com/auth/userinfo.email"

  oauth.set_client_id(clientID)
  oauth.set_client_secret(clientSecret)
  oauth.set_server_auth_url(serverAuthURL)
  oauth.set_server_token_url(serverTokenURL)
  oauth.set_authorization_scope(authScope)

  print("\n3. The following URL will open in a web browser to authenticate to the")
  print("service. Upon successfully authenticating and allowing access, the user will")
  print("be redirected back to an embedded web server within the component.\n")

  oauth.config("BrowserResponseTimeout=30")
  authString = oauth.get_authorization()

  print("\n4. Authorization String: " + authString)

  input("Press enter to exit")

  sys.exit(0)
except IPWorksAuthError as e:
  print("ERROR %s" %e.message)
    




