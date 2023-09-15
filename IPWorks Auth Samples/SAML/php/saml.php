<?php $sendBuffer = TRUE; ob_start(); ?>
<html>
<head>
<title>IPWorks Auth 2022 Demos - SAML</title>
<link rel="stylesheet" type="text/css" href="stylesheet.css">
<meta name="description" content="IPWorks Auth 2022 Demos - SAML">
</head>

<body>

<div id="content">
<h1>IPWorks Auth - Demo Pages</h1>
<h2>SAML</h2>
<p>Shows how to obtain an assertion or security token using SAML.</p>
<a href="default.php">[Other Demos]</a>
<hr/>

<?php
require_once('../include/ipworksauth_saml.php');
require_once('../include/ipworksauth_const.php');

?>

<?php
  class MySAML extends IPWorksAuth_SAML
  {
    function FireSSLServerAuthentication($param) {
      $param['accept'] = true;
      return $param;
    }
  }
  $saml = new MySAML();
  $authmode = 'sharepointOnline';
  $results = '';
  $user = 'user@mycrm.onmicrosoft.com';
  $password = '';
  $applicationURN = 'https://mycrm.sharepoint.com';
  $localSTS = '';
  
  try
  { 
    if ($_SERVER['REQUEST_METHOD'] == 'POST')
    {
	    $authmode = $_POST['authmode'];
  	  $user = $_POST['user'];
	    $password = $_POST['password'];
	    $applicationURN = $_POST['applicationURN'];
	    $localSTS = $_POST['localSTS'];
	  
      if (isset($_POST['getSecurityToken']) && $_POST['getSecurityToken'])
	    {
  	    if ($authmode == 'sharepoint') 
		    {
		      $saml->setAuthMode(0);
		      $saml->setLocalSTS($localSTS);
		      $saml->setApplicationURN($applicationURN);
		      $saml->setUser($user);
		      $saml->setPassword($password);
		      $saml->doGetSecurityToken();
		      $results = $saml->getSecurityTokenXML();
		    } 
		    elseif ($authmode == 'crm')
		    {
		      $saml->setAuthMode(1);
		      $saml->setLocalSTS($localSTS);
		      $saml->setApplicationURN($applicationURN);
		      $saml->setUser($user);
		      $saml->setPassword($password);
		      $saml->doGetSecurityToken();
		      $results = $saml->getSecurityTokenXML();
		    }
		    elseif ($authmode == 'adfs')
		    {
		      echo '<font color="red">For ADFS, use the "Get Assertion" function.</font></b><br /><br />';
		    }
      }
	    elseif ($_POST['getAssertion'])
	    {
	      if ($authmode == 'sharepoint') 
		    {
		      echo '<font color="red">For SharePoint Online, use the "Get Security Token" function.</font></b><br /><br />';
		    } 
		    elseif ($authmode == 'crm')
		    {
    		  echo '<font color="red">For Dynamics CRM, use the "Get Security Token" function.</font></b><br /><br />';
	  	  }
		    elseif ($authmode == 'adfs')
		    {
    		  $saml->setAuthMode(2);
	  	    $saml->setFederationURN('');
		      $saml->setFederationSTS('');
		      $saml->setLocalSTS($localSTS);
		      $saml->setApplicationURN($applicationURN);
		      $saml->setUser($user);
  		    $saml->setPassword($password);
	  	    $saml->doGetAssertion();
		      $results = $saml->getAssertionXML();
		    }
	    }
    }
  }
catch (Exception $ex)
{
  echo '<font color="red">' . $ex->getMessage() . '</font></b><br /><br />';
}
  
?>

<form method="post">
  <p>
	This demo shows how to use the SAML component to obtain an assertion or security token.
  </p>
  <p>
    <center>
	<table style="width:90%;">
	  <tr>
	    <td>Auth Mode:</td>
		<td>
		  <select name="authmode">
		    <option <?php echo ($authmode=="sharepoint")?"selected":""?> value="sharepoint">SharePoint Online</option>
			<option <?php echo ($authmode=="crm")?"selected":""?> value="crm">Dynamics CRM</option>
			<option <?php echo ($authmode=="adfs")?"selected":""?> value="adfs">ADFS</option>
		  </select>
		</td>
		<td></td>
		<td></td>
	  </tr>
	  <tr>
	    <td>User:</td>
		<td>
		  <input name="user" type="text" value="<?php echo $user ?>" style="width:100%" />
		</td>
		<td>Password:</td>
		<td>
		  <input name="password" type="password" value="<?php echo $password ?>" style="width:100%" />
		</td>
	  </tr>
	  <tr>
	    <td>Application URN:</td>
		<td>
		  <input name="applicationURN" type="text" value="<?php echo $applicationURN ?>" style="width:100%" />
		</td>
		<td>Local STS:</td>
		<td>
		  <input name="localSTS" type="text" value="<?php echo $localSTS ?>" style="width:100%" />
		</td>
	  </tr>
	  <tr>
	    <td colspan="2" style="align:right;">
		  <input type="submit" name="getSecurityToken" value="Get Security Token" id="getSecurityToken" />
		</td>
		<td colspan="2">
		  <input type="submit" name="getAssertion" value="Get Assertion" id="getAssertion" />
		</td>
	  </tr>
	  <tr>
	    <td colspan="4">
		  <textarea name="results" rows="2" cols="20" id="results" style="height:300px;width:100%;"><?php echo $results?></textarea>
		</td>
	  </tr>
	</table>
	</center>
  </p>
  <p />
  <br />
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
Copyright (c) 2023 /n software inc.
<br/>
<br/>
</div>

<div id="footer">
<center>
IPWorks Auth 2022 - Copyright (c) 2023 /n software inc. - For more information, please visit our website at <a href="http://www.nsoftware.com/?demopg-IAPHA" target="_blank">www.nsoftware.com</a>.
</center>
</div>

</body>
</html>

<?php if ($sendBuffer) ob_end_flush(); else ob_end_clean(); ?>
