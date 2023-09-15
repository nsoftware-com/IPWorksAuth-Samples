# 
# IPWorks Auth 2022 Python Edition - Sample Project
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

input = sys.hexversion<0x03000000 and raw_input or input


def fireError(e):
  print(e.message)

hotp = HOTP()
hotp.on_error = fireError

try:
	option = ""
	while option != "q":
		print("Please select an operation:")
		print("1)  Create Password")
		print("2) Validate Password")
		print("q) Quit")
		option = input("Option > ")

		if option == "1":
			hotp.reset()
			secret = input("Secret: ")
			if secret == "":
				secret = "ABCDEFGHIJKLMNOP"
			hotp.set_secret(secret)
			counter = input("Counter: ")
			if counter == "":
				counter = 1
			hotp.set_counter(int(counter))
			hotp.create_password()
			print("Password: " + hotp.get_password() + "\r\n")
			print("Password len: " + str(len(hotp.get_password())))
		elif option == "2":
			hotp.reset()
			secret = input("Secret: ")
			if secret == "":
				secret = "ABCDEFGHIJKLMNOP"
			hotp.set_secret(secret)
			counter = input("Counter: ")
			if counter == "":
				counter = 1
			hotp.set_counter(int(counter))
			password = input("Password: ")
			print("Password len: " + str(len(password)))
			hotp.set_password(str(password))
			print("Secret: " + secret)
			print("counter: " + str(counter))
			if hotp.validate_password():
				print("VALID")
			else:
				print("INVALID")
		elif option != "q":
			print("Error: Input not recognized")
			continue
		else:
			continue
except IPWorksAuthError as e:
  print("ERROR %s" %e.message)

