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

$arrDevelopers = array();
$arrModerators = array();
$arrAdministrators = array();
$arrOwners = array();

while ($arrData = mysqli_fetch_assoc($resQuery)) {
          $strName = $arrData['username'];
          $intRank = $arrData['rank'];
          switch ($intRank) {
                      case 6:
                              array_push($arrModerators, $strName);
                      break;    
                      case 7:
                              array_push($arrAdministrators, $strName);
                      break;
                      case 8:
                              array_push($arrDevelopers, $strName);
                      break;    
                      case 9:
                              array_push($arrOwners, $strName);
                      break;
          }
}

echo  '<br><h1><u>Owners:</u></h1>';
foreach ($arrOwners as $strOwner) {
             echo $strOwner . '<br>';
}

echo  '<br><h1><u>Developers:</u></h1>';
foreach ($arrDevelopers as $strDeveloper) {
             echo $strDeveloper . '<br>';
}

echo  '<br><h1><u>Administrators:</u></h1>';
foreach ($arrAdministrators as $strAdmin) {
             echo $strAdmin . '<br>';
}

echo  '<br><h1><u>Moderators:</u></h1>';
foreach ($arrModerators as $strModerator) {
             echo $strModerator . '<br>';
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