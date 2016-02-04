<head>
<meta charset="UTF-8">
<title>Luna - Staff</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	
<div class="overlay">
<ul>
<li><a href="index.php">Home</a></li>
<li><a href="register.php">Register</a></li>
<li><a href="play.php">Play</a></li>
<li><a href="manager/index.php">Manager</a></li>
<li><a href="commands.php">Commands</a></li>
<li><a class="active" href="staff.php">Staff</a></li>
<li><a href="contact.php">Contact Us</a></li>
<li><a href="about.php">About Us</a></li>
</ul>     

<div class="container">
<center>
	
<?php

require 'config.php';

$resDC = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName) or die('<h2>Failed to connect to MySQL: ' . mysqli_connect_error() . '</h2>');

$resQuery = mysqli_query($resDC, "SELECT username, rank FROM users");

$arrMediators = array();
$arrModerators = array();
$arrAdministrators = array();
$arrOwners = array();

while ($arrData = mysqli_fetch_assoc($resQuery)) {
          $strName = $arrData['username'];
          $intRank = $arrData['rank'];
          switch ($intRank) {
                      case 3:
                              array_push($arrMediators, $strName);
                      break;    
                      case 4:
                              array_push($arrModerators, $strName);
                      break;
                      case 5:
                              array_push($arrAdministrators, $strName);
                      break;    
                      case 6:
                              array_push($arrOwners, $strName);
                      break;
          }
}

echo  '<br><h1><u>Mediators:</u></h1>';
foreach ($arrMediators as $strMediator) {
             echo $strMediator . '<br>';
}

echo  '<br><h1><u>Moderators:</u></h1>';
foreach ($arrModerators as $strModerator) {
             echo $strModerator . '<br>';
}

echo  '<br><h1><u>Administrators:</u></h1>';
foreach ($arrAdministrators as $strAdmin) {
             echo $strAdmin . '<br>';
}

echo  '<br><h1><u>Owners:</u></h1>';
foreach ($arrOwners as $strOwner) {
             echo $strOwner . '<br>';
}             
              
?>

</center>

</div>
<div class="footer">&copy; 2016-2017 Luna &#8482; All Rights Reserved</div>
</div>
</body>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="js/index.js"></script>
</html>