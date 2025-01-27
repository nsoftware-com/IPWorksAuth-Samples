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


import sys
import string
from ipworksauth import *

input = sys.hexversion<0x03000000 and raw_input or input

def ensureArg(args, prompt, index):
  if len(args) <= index:
    while len(args) <= index:
      args.append(None)
    args[index] = input(prompt)
  elif args[index] == None:
    args[index] = input(prompt)

def fireError(e):
  print(e.message)

hotp = OTP()
totp = OTP()
hotp.on_error = fireError
totp.on_error = fireError

try:
	option = ""
	choice = ""
	while choice != "q" and choice!= "quit":
		print("Please select the algorithm:")
		print("1) HOTP")
		print("2) TOTP")
		print("q) Quit")
		choice = input("Option > ").lower()

		if choice == "1" or choice=="hotp":				
			while True:
				print("Please select the option:")
				print("1) Create Password")
				print("2) Validate Password")
				print("q) Quit")
				option = input("hotp > ").lower()
				hotp.reset()
				hotp.set_password_algorithm(1)
				if option=="1":
					print("Create password!")
					secret = input("Secret: ")
					if secret == "":
						secret = "ABCDEFGHIJKLMNOP"
					hotp.set_secret(secret)
					try:
						counter = input("Counter: ")
						if counter == "":
							counter = 1
						hotp.set_counter(int(counter))
					except ValueError:
						print("Error: Input not recognized")
						continue
					hotp.create_password()
					print("Password: " + hotp.get_password() + "\r\n")	
					continue
				if option=="2":			
					print("Validate password!")
					secret = input("Secret: ")
					if secret == "":
						secret = "ABCDEFGHIJKLMNOP"
					hotp.set_secret(secret)					
					try:
						counter = input("Counter: ")
						if counter == "":
							counter = 1
						hotp.set_counter(int(counter))
					except ValueError:
						print("Error: Input not recognized")
						continue
					password = input("Password: ")			
					hotp.set_password(str(password))					
					if hotp.validate_password():
						print("VALID")
						continue
					else:
						print("INVALID")
						continue
				elif option=="q"or option=="quit":
					break
				else:
					print("Error: Input not recognized")
					continue
		elif choice == "2" or choice=="totp":			
			while True:		
				print("Please select the option:")
				print("1) Create Password")
				print("2) Validate Password")
				print("q) Quit")
				option = input("totp > ").lower()		
				totp.set_password_algorithm(0) 		#default algorthim 
				if option=="1":
					print("Create password!")
					secret = input("Secret: ")
					if secret == "":
						secret = "ABCDEFGHIJKLMNOP"
					totp.set_secret(secret)									
					try:
						timestep = input("TimeStep: ")				
						if timestep=="":
							timestep=totp.get_time_step() # default 30 seconds
						totp.set_time_step(int(timestep))	
					except ValueError:
						print("Error: Input not recognized")
						continue
					totp.create_password()
					print("\nPassword: " + totp.get_password() + "\r")	
					print("Validity time: " + str(totp.get_validity_time())+"\n")	
					continue
				elif option=="2":
					print("Validate password!")
					print("Validity time: " + str(totp.get_validity_time()))
					secret = input("Secret: ")
					if secret == "":
						secret = "ABCDEFGHIJKLMNOP"
					totp.set_secret(secret)	
					try:
						timestep = input("TimeStep: ")				
						if timestep=="":
							timestep=totp.get_time_step()
						totp.set_time_step(int(timestep))	
					except ValueError:
						print("Error: Input not recognized")
						continue
					password = input("Password: ")			
					totp.set_password(str(password))
					if totp.validate_password():
						print("VALID")						
						continue
					else:
						print("INVALID")
						continue
				elif option=="q"or option=="quit":
					break
				else:
					print("Error: Input not recognized")
					continue			
		elif choice != "q" and choice != "quit":
			print("Error: Input not recognized\n")
			continue
		else:
			break
except IPWorksAuthError as e:
  print("ERROR %s" %e.message)

