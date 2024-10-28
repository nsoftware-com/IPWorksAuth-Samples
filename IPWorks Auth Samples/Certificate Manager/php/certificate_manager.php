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
require_once('../include/ipworksauth_certmgr.php');
require_once('../include/ipworksauth_const.php');
?>
<?php
  $certstore = '';
  $certsubject = '';
  $machine = '';

  if (isset($_GET['certstore'])) {
    $certstore = $_GET["certstore"];
  }
  if (isset($_GET['certsubject'])) {
    $certsubject = $_GET["certsubject"];
  }
  if (isset($_GET['machine'])) {
    $machine = $_GET["machine"];
  }
  
  $thispage = $_SERVER["PHP_SELF"];
  $certmgr = new IPWorksAuth_CertMgr();
?>

<ul>
<li><b><a href="<?php echo $thispage; ?>?machine=yes">[List Machine Stores]</a>
<li><b><a href="<?php echo $thispage; ?>">[List User Stores]</a>

<p>
<dl>
<?php
  if ($machine == "yes") {
  	$stores = $certmgr->doListMachineStores();
  	$storeparam = "&machine=yes";
  } else {
  	$stores = $certmgr->doListCertificateStores();
  	$storeparam = "";
  }

  $mystores =  explode("\r\n",$stores);
  for($i = 0; $i < count($mystores) -1; $i++){

    $store = $mystores[$i];

    if (strtoupper($certstore) == strtoupper($store)) {

      //if store is selected then expand it
      echo "<dt><b>[ &nbsp; ] <u>" . $store . "</u></b>";

      echo "<dd><ul>";

      $certmgr->setCertStore($store);
      try {
        $certs = $certmgr->doListStoreCertificates();
      
      
        $mycerts = explode("\r\n",$certs);

        for($j=0;$j<count($mycerts) -1;$j++){
          $subjectList = explode("\t",$mycerts[$j]);
          $subject = $subjectList[0];

          if (strtoupper($certsubject) == strtoupper($subject)) {
          //if certificate is selected then show it
            echo "<li><b><u><a name=selectedCert>" . $subject . "</u></b>";

            $certmgr->setCertSubject($subject);

            echo "<table bgcolor=whitesmoke>";

            echo "<tr><td><i>Issuer:              <td>" . $certmgr->getCertIssuer();
            echo "<tr><td><i>Subject:             <td>" . $certmgr->getCertSubject();
            echo "<tr><td><i>Version:             <td>" . $certmgr->getCertVersion();
            echo "<tr><td><i>SerialNumber:        <td>" . $certmgr->getCertSerialNumber();
            echo "<tr><td><i>SignatureAlgorithm:  <td>" . $certmgr->getCertSignatureAlgorithm();
            echo "<tr><td><i>EffectiveDate:       <td>" . $certmgr->getCertEffectiveDate();
            echo "<tr><td><i>ExpirationDate:      <td>" . $certmgr->getCertExpirationDate();
            echo "<tr><td><i>PublicKeyAlgorithm:  <td>" . $certmgr->getCertPublicKeyAlgorithm();
            echo "<tr><td><i>PublicKeyLength:     <td>" . $certmgr->getCertPublicKeyLength();

            echo "</table>";
          } else {
            echo "<li><a href=" . $thispage . "?";
            echo "certstore=" . urlencode($store);
            echo "&certsubject=" . urlencode($subject) . $storeparam;
            echo "#selectedCert>" . $subject . "</a>";
          }
        } //for loop
      } catch (Exception) {
        echo "<font color=\"RED\">Cannot open certificate store!</font><br/>";
      }


      echo "</ul>";

    } else {

      //if store not selected, just list it
      echo "<dt><b>";
      echo "<a href=" . $thispage . "?certstore=" . urlencode($store) . $storeparam . ">";
      echo "[+]</a> ";
      echo "<a href=" . $thispage . "?certstore=" . urlencode($store) . $storeparam . ">";
      echo $store;
      echo "</a></b>";

    }
  } //for loop
?>

</dl>

</ul>
