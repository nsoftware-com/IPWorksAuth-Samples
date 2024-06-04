<?php $sendBuffer = TRUE; ob_start(); ?>
<html>
<head>
<title>IPWorks Auth 2022 Demos - LDAP Search</title>
<link rel="stylesheet" type="text/css" href="stylesheet.css">
<meta name="description" content="IPWorks Auth 2022 Demos - LDAP Search">
</head>

<body>

<div id="content">
<h1>IPWorks Auth - Demo Pages</h1>
<h2>LDAP Search</h2>
<p>Shows how to contact an SSL-enabled LDAP server and lookup a name.</p>
<a href="default.php">[Other Demos]</a>
<hr/>

<?php
require_once('../include/ipworksauth_ldap.php');
require_once('../include/ipworksauth_const.php');

?>

<?php
  class MyLDAP extends IPWorksAuth_LDAP{
    function FireSSLServerAuthentication($param) {
      $param['accept'] = true;
      return $param;
		}
  }

  $ldap = new MyLDAP();
?>

<form method=POST>
<center>
<table width="90%">

 <tr><td>Server:      <td><input type=text name=server value="ldap-master.itd.umich.edu" size=30>
 <tr><td>Search DN:   <td><input type=text name=basedn value="ou=security,dc=umich,dc=edu" size=50>
 <tr><td>Query:       <td><input type=text name=query value="cn=*" size=50>
 <tr><td nowrap>Enable SSL   <td><input type="checkbox" name="security" value="YES" checked>
 <SMALL>if (you enable SSL please make sure you are connecting to a secure server.</SMALL>

 <tr><td><td><input type=submit value="Search!">
</table>
</center>
</form>

<?php
if ($_SERVER['REQUEST_METHOD'] == "POST") {

	$ldap->setServerName($_POST["server"]);

  if ($_POST["security"] == ""){
  	//by default the SSL component will use implicit SSL on port 636
  	//to change this to not use SSL on port 389:
  	echo "<font color=\"RED\">SSL turned off.</font><br/>";
  	$ldap->setSSLStartMode(3); //no SSL
  	$ldap->setServerPort(389);
  }

	//Some servers require you to bind first:
	//$ldap->setDN("yourdn");
	//$ldap->setPassword("password");
	//$ldap->doBind();

  //Here you would check the value of ResultCode to determine if Bind was successful. A non-zero value indicates failure and ResultDescription will hold the error text.

  //set the required attributes, no attributes will result in the server returning all attributes
  //$ldap.setAttrCount(1);
  //$ldap.setAttrType(0,"mail"); //email for addresses etc...

  //Do the Search:
	$ldap->setDN($_POST["basedn"]);
	$ldap->doConfig ("SingleResultMode=true");
  try{
	  $ldap->doSearch ($_POST["query"]);
  } catch (Exception $e) {
    echo 'Error: ',  $e->getMessage(), "\n";
  }

	echo "<hr><pre>";

  $result = $ldap->getResultDN();
  while($result != "") {
    	echo $result . "<br>";
    	//The attributes of each entry are in the AttrType and AttrValue property arrays
      for($i =0;$i<$ldap->getAttrCount();$i++){
				echo "&nbsp;&nbsp;&nbsp;" . $ldap->getAttrType($i) . ": " . $ldap->getAttrValue($i) . "<br>";
			}
    $result = $ldap->getResultDN();
	}
  echo "</pre>";

  //After you find the DN you want, use it to bind with:
  //$ldap->setDN($ldap->getResultDN());
  //$ldap->setPassword("yourpassword");
  //$ldap->doBind();
  //echo "Bind Result: " . $ldap->getResultCode() . "<br>";
}
?>

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
