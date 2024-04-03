<?php $sendBuffer = TRUE; ob_start(); ?>
<html>
<head>
<title>IPWorks Auth 2022 Demos - Kerberos</title>
<link rel="stylesheet" type="text/css" href="stylesheet.css">
<meta name="description" content="IPWorks Auth 2022 Demos - Kerberos">
</head>

<body>

<div id="content">
<h1>IPWorks Auth - Demo Pages</h1>
<h2>Kerberos</h2>
<p>Demonstrates how to authenticate a user with Kerberos.</p>
<a href="default.php">[Other Demos]</a>
<hr/>

<?php
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
<br/>
<br/>
<br/>
<hr/>
NOTE: These pages are simple demos, and by no means complete applications.  They
are intended to illustrate the usage of the IPWorks Auth objects in a simple,
straightforward way.  What we are hoping to demonstrate is how simple it is to
program with our components.  If you want to know more about them, or if you have
questions, please visit <a href="http://www.nsoftware.com/?demopg-IAPHA" target="_blank">www.nsoftware.com</a> or
contact our technical <a href="http://www.nsoftware.com/support/">support</a>.
<br/>
<br/>
Copyright (c) 2024 /n software inc.
<br/>
<br/>
</div>

<div id="footer">
<center>
IPWorks Auth 2022 - Copyright (c) 2024 /n software inc. - For more information, please visit our website at <a href="http://www.nsoftware.com/?demopg-IAPHA" target="_blank">www.nsoftware.com</a>.
</center>
</div>

</body>
</html>

<?php if ($sendBuffer) ob_end_flush(); else ob_end_clean(); ?>
