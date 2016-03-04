<?php

include 'session.php';
include '../config.php';

if ($_SESSION['isVIP'] == false) { 
    header('location: index.php');
}

$strError = '';
$strFormTwoError = '';
$strMessage = '';
$strFormTwoMessage = '';

$mysql = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);

$strUsername = $_SESSION['login_user']; 

if (isset($_POST['update'])) {
    $strType = $_POST['gtype'];
    $strColor = $_POST['color'];
    if (isset($strType) && isset($strColor)) {
        $strType = mysqli_real_escape_string($mysql, $strType);
        $strColor = mysqli_real_escape_string($mysql, $strColor);
        $strType = addslashes($strType);
        $strColor = addslashes($strColor);     
        if (strlen($strColor) <= 6) {
			$strColor = '0x' . $strColor;
            mysqli_query($mysql, "UPDATE users SET $strType = '$strColor' WHERE username = '$strUsername'");
            $strMessage = "Successfully updated " . ucfirst($strType);
        } else {
			$strError = "Invalid Glow Pattern";
		}
    }
}

if (isset($_POST['update_speed'])) {
    $intSpeed = $_POST['speed'];
    if (isset($intSpeed)) {
        $intSpeed = mysqli_real_escape_string($mysql, $intSpeed);
        $intSpeed = addslashes($intSpeed);     
        if (is_numeric($intSpeed) && $intSpeed <= 100) {
            mysqli_query($mysql, "UPDATE users SET speed = '$intSpeed' WHERE username = '$strUsername'");
            $strFormTwoMessage = "Successfully updated Speed to $intSpeed";
        } else {
			$strFormTwoError = "Invalid Speed";
		}
    }
}

?>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Luna - Manager</title>
<link rel="stylesheet" href="../css/style.css">
<link rel='stylesheet prefetch' href='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css'>
</head>
<body>

<div class="overlay">
<ul>
<li><a href="profile.php">Home</a></li>
<li><a href="settings.php">Settings</a></li>
<li><a href="search.php">Search</a></li>
<?php if ($_SESSION['isVIP'] == true) { ?>
<li><a class="active" href="glows.php">Glow Panel</a></li>
<?php 
}
if ($_SESSION['isStaff'] == true) {
 ?>
 <li><a href="moderator.php">Mod Panel</a></li>
<?php if ($_SESSION['isAdmin'] == true) { ?>
<li><a href="admin.php">Admin Panel</a></li>
<?php } } ?>
<li><a href="store.php">Store</a></li>
<li><a href="server.php">Server</a></li>
<li><a href="logout.php">Logout</a></li>
</ul>     

<div class="container">
<center>
<form class="form" name="form" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
       <select name="gtype" id="gtype">
		  <option value="null">Select Type</option>
		  <option value='nameglow'>Name Glow</option>
		  <option value='namecolour'>Name Color</option>
		  <option value='bubbletext'>Bubble Text Color</option>
		  <option value='bubblecolour'>Bubble Color</option>
		  <option value='bubbleglow'>Bubble Glow</option>
		  <option value='ringcolour'>Ring Color</option>
		  <option value='chatglow'>Chat Glow</option>
		  <option value='penguinglow'>Penguin Glow</option>
		  <option value='moodglow'>Mood Glow</option>
		  <option value='moodcolor'>Mood Color</option>
		  <option value='snowballglow'>Snowball Glow</option>
		  <option value='titleglow'>Title Glow</option>
		  <option value='titlecolor'>Title Color</option>
       </select>
       <br><br>
       <input class="jscolor" type="text" name="color" maxlength="6">
       <input type="submit" id="login-button" name="update" value="Update">
       <span><?php echo $strError; ?></span>
       <span><?php echo $strMessage; ?></span>
</form>
<form class="form" name="form2" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
       <label for="speed">Speed:</label>
       <div class="slider">
       <output id="rangevalue">10</output>
       <input type = "range" min="0" max="100" name="speed" onchange="rangevalue.value=value"/>
       </div>
       <input type="submit" id="login-button" name="update_speed" value="Update">
       <span><?php echo $strFormTwoError; ?></span>
       <span><?php echo $strFormTwoMessage; ?></span>
</form>
</center>

</div>
<div class="footer">&copy; 2016-2017 Luna &#8482; All Rights Reserved</div>
</div>
</body>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js'></script>
<script src="../js/jscolor.js"></script>
<script src="../js/index.js"></script>
</html>
