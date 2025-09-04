<?php
/*
 * IPWorks Auth 2024 PHP Edition - Sample Project
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
require_once('../include/ipworksauth_kerberos.php');
require_once('../include/ipworksauth_const.php');
?>
<form method="post">
	<p>
		This demo shows how to use the Kerberos component to authenticate a user. To begin specify the User, Password, SPN (Service Principal Name), and KDCHost (the Kerberos server).
	</p>
	<p>
		<table>
			<tr>
				<td style="width:100px;">		
					<label for="txtUser">User:</label>		
				</td>
				<td style="width:250px;">			
					<input type = "text" name = "txtUser" size = "20" value = "<?php if(array_key_exists('code', $_GET)){ echo $_COOKIE['txtUser']; } else { echo ''; } ?>" />				
				</td>
				<td>			
					<input type = "submit" name = "btnAuthenticate" value = "Authenticate" />			
				</td>
			</tr>
			<tr>
				<td style="width:100px;">
					<label for="txtPassword">Password:</label>
				</td>
				<td style="width:250px;">
					<input type = "password" name = "txtPassword" size = "20" value = "<?php if(array_key_exists('code', $_GET)){ echo $_COOKIE['txtPassword']; } else { echo ''; } ?>" />
				</td>
				<td></td>
			</tr>
			<tr>
				<td style="width:100px;">
					<label for="txtSPN">SPN:</label>
				</td>
				<td style="width:250px;">
					<input type = "text" name = "txtSPN" size = "20" value = "<?php if(array_key_exists('code', $_GET)){ echo $_COOKIE['txtSPN']; } else { echo ''; } ?>" />
				</td>
				<td></td>
			</tr>
			<tr>
				<td style="width:100px;">
					<label for="txtHost">KDCHost:</label>	
				</td>
				<td style="width:250px;">		
					<input type = "text" name = "txtHost" size = "20" value = "<?php if(array_key_exists('code', $_GET)){ echo $_COOKIE['txtHost']; } else { echo ''; } ?>" />			
				</td>
				<td></td>
			</tr>
		</table>
	</p>
	<p />
	<?php
		$kerberos1 = new IPWorksAuth_Kerberos();
		try { 
			if ($_SERVER['REQUEST_METHOD'] == 'POST'){
				setcookie('txtUser', $_POST['txtUser'], time() + 900);  
				setcookie('txtPassword', $_POST['txtPassword'], time() + 900);
				setcookie('txtSPN', $_POST['txtSPN'], time() + 900);
				setcookie('txtHost', $_POST['txtHost'], time() + 900);
				$kerberos1->setUser($_POST['txtUser']);
				$kerberos1->setPassword($_POST['txtPassword']);
				$kerberos1->setSPN($_POST['txtSPN']);
				$kerberos1->setKDCHost($_POST['txtHost']);
				$kerberos1->doAuthenticate();
				echo '<b><font color="green">&nbsp;&nbsp;&nbsp;Authenticated</font></b><br />';
			}
		}
		catch (Exception $ex){
			echo '<font color="red">&nbsp;&nbsp;&nbsp;' . $ex->getMessage() . '</font></b><br />';
		}
	?>
</form>