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
require_once('../include/ipworksauth_oauth.php');
require_once('../include/ipworksauth_const.php');
?>
<br />
<form method="post">
  <p>
	This demo shows how to use the OAuth component to authenticate with Google using OAuth 2.0 (Web Server Profile). 
	Please see the Introduction page within the help for more detailed instructions.
  </p>
  <p>
	<table><tr><td style="vertical-align:top;">
	  <table>
	    <tr><td>Client Profile: </td><td><input type = "text" name = "txtClientId" size = "50" value = "<?php if(array_key_exists('code', $_GET)){ echo $_COOKIE['txtClientId']; } else { echo '723966830965.apps.googleusercontent.com'; } ?>" /></td>
	    <tr><td>Client Profile: </td><td><input type = "text" name = "txtClientSecret" size = "50" value = "<?php if(array_key_exists('code', $_GET)){ echo $_COOKIE['txtClientSecret']; } else { echo '_bYMDLuvYkJeT_99Q-vkP1rh'; } ?>" /></td>
	    <tr><td>Server Auth URL: </td><td><input type = "text" name = "txtServerAuthURL" size = "50" value = "<?php if(array_key_exists('code', $_GET)){ echo $_COOKIE['txtServerAuthURL']; } else { echo 'https://accounts.google.com/o/oauth2/auth'; } ?>" /></td>
	    <tr><td>Server Token URL: </td><td><input type = "text" name = "txtServerTokenURL" size = "50" value = "<?php if(array_key_exists('code', $_GET)){ echo $_COOKIE['txtServerTokenURL']; } else { echo 'https://accounts.google.com/o/oauth2/token'; } ?>" /></td>
	    <tr><td>Authorization Scope: </td><td><input type = "text" name = "txtAuthScope" size = "50" value = "<?php if(array_key_exists('code', $_GET)){ echo $_COOKIE['txtAuthScope']; } else { echo 'https://www.googleapis.com/auth/userinfo.email'; } ?>" /></td>
	    <tr colspan="2"><td><input type = "submit" name = "btnAuthorize" value = "Authorize"></td></tr>
	  </table>
	</td><td>
	  <p>
		1. Obtain and set your Client ID and Client Secret. For Google, these values can be found in the <a href="https://code.google.com/apis/console#access">API Console</a>. The default values are from a Google test account that we have setup for you to easily run this demo.
	  </p>
	  <p>
	    2. You can also set Server Auth URL, Server Token URL, and Authorization Scope to the values desired. These are preset to values for Google's User Info service.
	  </p>
	  <p>
	    3. Click the 'Authorize' button.  This will redirect to a page that will allow the user to authenticate to the service. Upon the user successfully authenticating and allowing access, the user will be redirected back to the URL specified by the 'ReturnURL' property with the Authorization Code as a query parameter.
	  </p>
	  <p>
		4. When the page returns, the 'code' parameter will be used to get the Authorization String.
	  </p>
	</td></tr></table>
  </p>
  <p />
  <br />

<?php
class MyOAuth extends IPWorksAuth_OAuth{
  function fireStatus($param) {
    echo '<b>Status: </b>' . $param['statuscode'] . ' - ' . $param['description'] . '<br />';
  }
  function fireTransfer($param) {
    echo '<b>Transfer: </b>' . $param['direction'] . ' - ' . $param['text'] . '<br />';
  }
  function fireConnectionStatus($param) {
	echo '<b>Connection: </b>' . $param['connectionevent'] . ' - ' . $param['description'] . '<br />';
  }
  function fireError($param) {
	echo '<b>Error: </b>' . $param['errorcode'] . ' - ' . $param['description'] . '<br />';
  }
}
$oauth1 = new IPWorksAuth_OAuth();

// Setup the ReturnURL
if ($_SERVER['HTTPS'] == 'ON') {
  $pageUrl = 'https://';
} else {
  $pageUrl = 'http://';
}
$pageUrl .= $_SERVER['HTTP_HOST'];
$pageUrl .= $_SERVER['PHP_SELF'];

try
{ 
  if ($_SERVER['REQUEST_METHOD'] == 'POST')
  {
	// Authorize button was clicked. Obtain and redirect to authorization URL.
	if (array_key_exists("txtClientId", $_POST))
    {
	  // Add these values to cookies
	  setcookie('txtClientId', $_POST['txtClientId'], time() + 900);  
	  setcookie('txtClientSecret', $_POST['txtClientSecret'], time() + 900);
	  setcookie('txtServerAuthURL', $_POST['txtServerAuthURL'], time() + 900);
	  setcookie('txtServerTokenURL', $_POST['txtServerTokenURL'], time() + 900);
	  setcookie('txtAuthScope', $_POST['txtAuthScope'], time() + 900);
	  
	  $oauth1->setClientProfile(1);
	  $oauth1->setClientId($_POST['txtClientId']);
	  $oauth1->setClientSecret($_POST['txtClientSecret']);
	  $oauth1->setServerAuthURL($_POST['txtServerAuthURL']);
	  $oauth1->setServerTokenURL($_POST['txtServerTokenURL']);
	  $oauth1->setAuthorizationScope($_POST['txtAuthScope']);
	  $oauth1->setReturnURL($pageUrl);
	  $url = $oauth1->doGetAuthorizationURL();
	  header('Location: '.$url);
	  exit();
	} 

  }
  else
  {
	// Redirected from authorization page. Get authorization string and retrieve user information. 
	if (array_key_exists('code', $_GET))
	{
	
	  $oauth1->setClientProfile(1);
	  $oauth1->setClientId($_COOKIE['txtClientId']);
	  $oauth1->setClientSecret($_COOKIE['txtClientSecret']);
	  $oauth1->setServerAuthURL($_COOKIE['txtServerAuthURL']);
	  $oauth1->setServerTokenURL($_COOKIE['txtServerTokenURL']);
	  $oauth1->setAuthorizationScope($_COOKIE['txtAuthScope']);
      $oauth1->setAuthorizationCode($_GET['code']); 
	  $oauth1->setReturnURL($pageUrl);

	  $authString = $oauth1->doGetAuthorization();
      
      echo '<font color="red"><b>Authorization string: </b></font>' . $authString;
    }
	else if (array_key_exists('error', $_GET))
	{
	  
	  echo '<b>ERROR: ' . $_GET['error'] . '</b>';
	  
	}

  }
}
catch (Exception $ex)
{
  echo '<font color="red">' . $ex->getMessage() . '</font></b><br /><br />';
}

?>

</form>