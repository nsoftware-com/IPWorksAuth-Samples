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
			console.log("Usage:\n\tnode .\\hotp.js create <secret> <counter>");
			console.log("\tnode .\\hotp.js validate <secret> <counter> <password>");
			
			console.log("\n\tEx: node .\\hotp.js create KSJDH73YSHD8JCS9ISJN23FGH7 1");
			console.log("\tEx: node .\\hotp.js validate KSJDH73YSHD8JCS9ISJN23FGH7 1 654321");
			process.exit();
	}


	const hotp_demo = async function(option, secret, counter, password){
		const hotp = new ipworksauth.hotp()
		switch (option){
			case "create":
				if (process.argv.length !== 5) {
					console.log("Invalid number of parameters");
					process.exit();
				}
				hotp.setSecret(secret);
				hotp.setCounter(parseInt(counter));
				try {
					await hotp.createPassword();
				}catch (e) {
					console.log(e);
				}				
				console.log(`Your password is: ${hotp.getPassword()}`);								
				break;
			case "validate":
				if (process.argv.length !== 6){
					console.log("Invalid number of parameters");
					process.exit();
				}
				hotp.setSecret(secret);
				hotp.setCounter(parseInt(counter));
				hotp.setPassword(password);

				if ( await hotp.validatePassword()) { 
					console.log("Password valid.");
				} else { 
					console.log("Password invalid.");
				}
				break;
			default:
				console.log("Invalid option.");
				process.exit();
		}
	};
	
	await hotp_demo(process.argv[2], process.argv[3], process.argv[4], process.argv[5]);
	process.exit();
}


function prompt(promptName, label, punctuation, defaultVal)
{
  lastPrompt = promptName;
  lastDefault = defaultVal;
  process.stdout.write(`${label} [${defaultVal}] ${punctuation} `);
}
