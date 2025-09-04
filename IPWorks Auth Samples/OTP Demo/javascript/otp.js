/*
 * IPWorks Auth 2024 JavaScript Edition - Sample Project
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
			console.log("Usage:\n\tnode .\\otp.js hotp create <secret> <counter>");
			console.log("\tnode .\\otp.js hotp validate <secret> <counter> <password>");

			console.log("\tnode .\\otp.js totp create <secret> <timestep> ");
            console.log("\tnode .\\otp.js totp validate <secret> <timestep> <password>");

			console.log("\n\tEx: node .\\otp.js hotp create KSJDH73YSHD8JCS9ISJN23FGH7 1");
			console.log("\tEx: node .\\otp.js hotp validate KSJDH73YSHD8JCS9ISJN23FGH7 1 654321");

            console.log("\n\tEx: node .\\otp.js totp create KSJDH73YSHD8JCS9ISJN23FGH7 30");
			console.log("\tEx: node .\\otp.js totp validate KSJDH73YSHD8JCS9ISJN23FGH7 30 654321");
			process.exit();
	}

	const otp_demo = async function(algorithm,option, secret, cnttms, password){
		const hotp = new ipworksauth.otp()
        const totp = new ipworksauth.otp()
        
        switch (algorithm){
            case "hotp":                
                hotp.reset();
                hotp.setPasswordAlgorithm(1);
                switch (option){
                    case "create":
                        if (process.argv.length !== 6) {
                            console.log("Invalid number of parameters!");
                            process.exit();
                        }
                        hotp.setSecret(secret);
                        hotp.setCounter(parseInt(cnttms));
                        try {
                            await hotp.createPassword();
                        }catch (e) {
                            console.log(e);
                        }				
                        console.log("Your password is: "+hotp.getPassword());						
                        break;
                    case "validate":
                        if (process.argv.length !== 7){
                            console.log("Invalid number of parameters!");
                            process.exit();
                        }
                        hotp.setSecret(secret);
                        hotp.setCounter(parseInt(cnttms));
                        hotp.setPassword(password);
        
                        if (await hotp.validatePassword()) { 
                            console.log("Password VALID!");
                        } else { 
                            console.log("Password INVALID!");
                        }
                        break;
                    default:
                        console.log("Invalid option!");
                        process.exit();
                }
                break;

            case "totp":               
                totp.setPasswordAlgorithm(0); //default
                switch (option){
                    case "create":
                        totp.reset()
                        if (process.argv.length !== 6){
                            console.log("Invalid number of parameters!");
                            process.exit();
                        }
                        totp.setSecret(secret);                        
                        totp.setTimeStep(parseInt(cnttms));                        
                        await totp.createPassword( (e) => ((e !== null) ? console.log(e.message) : null));
                        console.log("Your temporary password is: "+ totp.getPassword());
                        console.log("It is valid for: "+totp.getValidityTime()+"s");                        
                        break;
                    case "validate":
                        if (process.argv.length !== 7){
                            console.log("Invalid number of parameters!");
                            process.exit();
                        }                        
                        totp.setPassword(password);
                        totp.setSecret(secret);  
                        totp.setTimeStep(parseInt(cnttms));                     
                        
                        if (await totp.validatePassword()) {                             
                            console.log("Password is VALID!")                            
                        } else { 
                            console.log("Password INVALID!")                             
                        }
                        break;
                    default:
                        console.log("Invalid option!")
                        process.exit();
                }
                break;
            default:
                    console.log("Invalid option!");
                    process.exit();
        }    
	};
	
	await otp_demo(process.argv[2], process.argv[3], process.argv[4], process.argv[5],process.argv[6]);
	process.exit();
}

function prompt(promptName, label, punctuation, defaultVal)
{
  lastPrompt = promptName;
  lastDefault = defaultVal;
  process.stdout.write(`${label} [${defaultVal}]${punctuation} `);
}
