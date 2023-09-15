/*
 * IPWorks Auth 2022 Java Edition - Sample Project
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


import java.util.Arrays;
import java.util.Base64;
import java.util.TooManyListenersException;
import ipworksauth.Certificate;
import ipworksauth.IPWorksAuthException;
import ipworksauth.JwtHeaderParamEvent;
import ipworksauth.JwtRecipientInfoEvent;
import ipworksauth.JwtSignerInfoEvent;
import ipworksauth.JwtClaimInfoEvent;
import ipworksauth.JwtErrorEvent;
import ipworksauth.Jwt;

public class jwt extends ConsoleDemo{
	
	public static void main(String[] args) {
		
		if (args.length == 4 || args.length == 5) {
			switch (args[0]) {
			case "sign":
				if (args.length == 5) {
					sign(args[1], args[2], args[3], args[4]);
				} else { // length == 4
					sign(args[1], args[2], args[3], "");
				}
				break;
			case "verify":
				verify(args[1], args[2], args[3]);
				break;
			default:
				displayHelp("First argument must be either 'sign' or 'verify'.");
			}
		} else {
			displayHelp(args.length + " arguments entered, 4 or 5 expected.");
		}

	}
	
	private static void parseMessageIntoJwt(String message, ipworksauth.Jwt token){
		String[] args_msg = message.split(",");
		
		for (int i = 0; i < args_msg.length; i++){
			String name = args_msg[i].split("=")[0];
			String value = args_msg[i].split("=")[1];
			try {
				switch (name){
					case "kid":
						token.setKeyId(value);
						break;
					case "aud":
						token.setClaimAudience(value);
						break;
					case "sub":
						token.setClaimSubject(value);
						break;
					case "iss":
						token.setClaimIssuer(value);
						break;
					case "jti":
						token.setClaimJWTId(value);
						break;
					case "iat":
						token.setClaimIssuedAt(value);
						break;
					default:
						System.out.println("Invalid header or claim.");
						break;
				}
			} catch (IPWorksAuthException e) {
				e.printStackTrace();
			}
		}
	}
	
	private static void sign(String alg, String key, String message, String password) {

		try {
			ipworksauth.Jwt jwt = new ipworksauth.Jwt();
			
			parseMessageIntoJwt(message, jwt);
			switch (alg) {
			case "HS256":
				jwt.setSigningAlgorithm(jwt.saHS256);
				jwt.config("KeyEncoding=1"); //Base64
				if (key.equals("0")) {jwt.setKey("txAVam2uGT20a+ZJC1VWVGCM8tFYSKyJlw+2fgS/BdA=");}
				else { jwt.setKey(key); }
				break;
			case "HS384":
				jwt.setSigningAlgorithm(jwt.saHS384);
				jwt.config("KeyEncoding=1");//Base64
				if (key.equals("0")) {jwt.setKey( "5C/iq/SVHc1i++8elF0u3Cg8w1D1Nj8Idrsw2zzIQeLrolmPk5d26f6MxTE3Npy2");}
				else { jwt.setKey(key); }
				break;
			case "HS512":
				jwt.setSigningAlgorithm(jwt.saHS512);
				jwt.config("KeyEncoding=1");//Base64
				if (key.equals("0")) {jwt.setKey( "AGVJSwvgVMU0cspZ7ChlxURcgCcdj7QV6nm0fr0C/rNtuh8F5uA7nCs4efKuWUDBw7/s9ikfTm0Kx4uZ3SYXcA==");}
				else { jwt.setKey(key); }
				break;
			case "RS256":
				jwt.setSigningAlgorithm(jwt.saRS256);
				jwt.setCertificate(new Certificate(Certificate.cstPFXFile, key, password, "*"));
				break;
			case "RS384":
				jwt.setSigningAlgorithm(jwt.saRS384);
				jwt.setCertificate(new Certificate(Certificate.cstPFXFile, key, password, "*"));
				break;
			case "RS512":
				jwt.setSigningAlgorithm(jwt.saRS512);
				jwt.setCertificate(new Certificate(Certificate.cstPFXFile, key, password, "*"));
				break;
			case "PS256":
				jwt.setSigningAlgorithm(jwt.saPS256);
				jwt.setCertificate(new Certificate(Certificate.cstPFXFile, key, password, "*"));
				break;
			case "PS384":
				jwt.setSigningAlgorithm(jwt.saPS384);
				jwt.setCertificate(new Certificate(Certificate.cstPFXFile, key, password, "*"));
				break;
			case "PS512":
				jwt.setSigningAlgorithm(jwt.saPS512);
				jwt.setCertificate(new Certificate(Certificate.cstPFXFile, key, password, "*"));
				break;
			default:
				displayHelp("Unsupported algorithm selected.");
				System.exit(0);
				break;
			}

			jwt.sign();
			System.out.println("Encoded JWT: "+jwt.getEncodedJWT());

		} catch (IPWorksAuthException e) {
			System.err.println("Error [" + e.getCode() + "]: " + e.getMessage());
			displayHelp("");
		} catch (Exception e) {
			e.printStackTrace();
			displayHelp("");
		}
	}
	


	private static void verify(String alg, String key, String signed) {
		ipworksauth.Jwt jwt = new ipworksauth.Jwt();
		try {
			jwt.addJwtEventListener(new ipworksauth.JwtEventListener(){
				@Override
				public void headerParam(ipworksauth.JwtHeaderParamEvent e){
					System.out.println("\"" + e.name + "\"=\"" + e.value + "\"");
				}
				@Override
				public void claimInfo(ipworksauth.JwtClaimInfoEvent e){
					System.out.println("\"" + e.name + "\"=\"" + e.value + "\"");
				}
				@Override
				public void error(JwtErrorEvent arg0) {					
				}
				@Override
				public void recipientInfo(JwtRecipientInfoEvent arg0) {					
				}
				@Override
				public void signerInfo(JwtSignerInfoEvent arg0) {					
				}
			});
		} catch (TooManyListenersException e) {
			e.printStackTrace();
		}

		try {
			switch (alg) {
			case "HS256":
				jwt.config("KeyEncoding=1");//Base64
				if (key.equals("0")) {jwt.setKey("txAVam2uGT20a+ZJC1VWVGCM8tFYSKyJlw+2fgS/BdA=");}
				else { jwt.setKey(key); }
				break;
			case "HS384":
				jwt.config("KeyEncoding=1");//Base64
				if (key.equals("0")) {jwt.setKey("5C/iq/SVHc1i++8elF0u3Cg8w1D1Nj8Idrsw2zzIQeLrolmPk5d26f6MxTE3Npy2");}
				else { jwt.setKey(key); }
				break;
			case "HS512":
				jwt.config("KeyEncoding=1");//Base64
				if (key.equals("0")) {jwt.setKey("AGVJSwvgVMU0cspZ7ChlxURcgCcdj7QV6nm0fr0C/rNtuh8F5uA7nCs4efKuWUDBw7/s9ikfTm0Kx4uZ3SYXcA==");}
				else { jwt.setKey(key); }
				break;
			case "RS256":
			case "RS384":
			case "RS512":
			case "PS256":
			case "PS384":
			case "PS512":
				jwt.setSignerCert(new Certificate(key));
				break;
			default:
				displayHelp("Unsupported algorithm selected.");
				System.exit(0);
				break;

			}
			jwt.setEncodedJWT(signed);
			jwt.verify();
		} catch (IPWorksAuthException e) {
			System.err.println("Error [" + e.getCode() + "]: " + e.getMessage());
			displayHelp("");
		} catch (Exception e) {
			e.printStackTrace();
			displayHelp("");
		}
	}

	
	
	private static void displayHelp(String message) {
		System.out.println("Invalid arguments entered. " + message);
		System.out.println("Usage: java -jar jwt.jar <action> <algorithm> <key> <input> [keyPassword]");
		System.out.println("\taction          the action to perform - 'sign' or 'verify'");
		System.out.println(
				"\talgorithm       the HMAC or RSA algorithm - 'HS256', 'HS384', 'HS512', 'RS256', 'RS384', 'RS512', 'PS256', 'PS384', or 'PS512'");
		System.out.println(
				"\tkey             HMAC - Base64 key or '0' to use hard-coded key; RSA - filename of key certificate (private cert for sign, public cert for verify)");
		System.out.println("\tinput           a configuration string of headers/claim to sign or payload to verify - 'name=value,...' with possible names - 'kid', 'aud', 'sub', 'iss', 'jti', or 'iat' ");
		System.out.println(
				"\tkeyPassword     key certificate password if necessary (required only for private certificates with passwords)");
		System.out.println("Examples: java -jar jwt.jar sign HS256 txAVam2uGT20a+ZJC1VWVGCM8tFYSKyJlw+2fgS/BdA= \"kid=4321\"");
		System.out.println("          java -jar jwt.jar sign HS512 0 \"kid=8554,aud=test,sub=test,iss=me\"");
		System.out.println("          java -jar jwt.jar sign RS384 .\\testrsapriv.pfx \"kid=1234,aud=test\" test");
		System.out.println(
				"          java -jar jwt.jar verify HS256 ygIg4/Ut0KwUK2nS6fnflj1C5pAhgiXmVzqRqR2WTyU= eyJhbGciOiJIUzI1NiIsImtpZCI6Ijg1NTQifQ.eyJhdWQiOlsidGVzdCJdLCJpc3MiOiJtZSIsInN1YiI6InRlc3QifQ.A7qCsUpJLueb4gkwxDiHxeIVB0OyDzOfxBv_ehQvGzQ");
		System.out.println(
				"          java -jar jwt.jar verify PS256 .\\testrsapub.cer eyJhbGciOiJQUzI1NiIsImtpZCI6Ijg1NTQifQ.eyJhdWQiOlsidGVzdCJdLCJpc3MiOiJtZSIsInN1YiI6InRlc3QifQ.BoQqXWB5YGUh3bid2OpGfW1yZw3j--KCZiNc9nyaMVQefLZUDyeoOHzfN9tNR1jEH9bQHPiRbkr2HyzIZzMdDiKHasg1vGnfUnuaN4y_b5gb6n4qw4AUxTjpPzu3sQfbBuKZUca99sx3YTR76KqAw57rS-gMQG0-YMTNJdEapE7igLlsCqCiPojqB-9KcJoj6PtsVqfds0RVCV_v_LUJvgWJaPznn80wpyAr-_VG07XO7qRSZTShoH7akkGgh0SrFn6TWHsCbF1UBzmkwzk7gYSInq1nUPJ31-up7F_kcbpXRmk8Kg0nZKn_Ol0uFyF3y5e8Tfw6FSjt0gHgUB9XlQ");

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

  static String prompt(String label, String punctuation, String defaultVal)
  {
	System.out.print(label + " [" + defaultVal + "] " + punctuation + " ");
	String response = input();
	if(response.equals(""))
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



