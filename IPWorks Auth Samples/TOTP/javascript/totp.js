/*
 * IPWorks Auth 2022 JavaScript Edition - Sample Project
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
 
const readline = require("readline");
const ipworksauth = require("@nsoftware/ipworksauth");

if(!ipworksauth) {
  console.error("Cannot find ipworksauth.");
  process.exit(1);
}
let rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

main();

async function main() {
	if (process.argv.length === 2) {
			console.log("Usage:\n\tnode .\\totp.js create <secret> [timestep]")
			console.log("\tnode .\\totp.js validate <secret> <password>")
			
			console.log("\n\tEx: node .\\totp.js create KSJDH73YSHD8JCS9ISJN23FGH7 30")
			console.log("\tEx: node .\\totp.js validate KSJDH73YSHD8JCS9ISJN23FGH7 654321")
			
			process.exit();
	}


	const totp = new ipworksauth.totp()

	const totp_demo =  async function( option, secret, time_pass){
		switch (option){
			case "create":
				totp.setSecret(secret);
				if (time_pass) {
					totp.setTimeStep(parseInt(time_pass))
				} else { 
					totp.setTimeStep(30) 
				}
				await totp.createPassword( (e) => ((e !== null) ? console.log(e.message) : null));
				console.log(`Your temporary password is: ${totp.getPassword()}, and it is good for ${totp.getValidityTime()}s.`);
				break;
			case "validate":
				totp.setSecret(secret);
				totp.setPassword(time_pass);
				if (await totp.validatePassword()) { 
					console.log("Password is valid.")
				} else { 
					console.log("Password invalid.") 
				}
				break;
			default:
				console.log("Invalid option.")
				process.exit();
		}
	};

	await totp_demo(process.argv[2], process.argv[3], process.argv[4]);
	process.exit();
}


function prompt(promptName, label, punctuation, defaultVal)
{
  lastPrompt = promptName;
  lastDefault = defaultVal;
  process.stdout.write(`${label} [${defaultVal}] ${punctuation} `);
}
