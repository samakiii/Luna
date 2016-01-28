<?php

include 'session.php';

?>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Luna - Manager</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>

<div class="overlay">
<ul>
<li><a href="profile.php">Home</a></li>
<li><a href="settings.php">Settings</a></li>
<li><a href="search.php">Search</a></li>
<?php if ($_SESSION['isVIP'] == true) { ?>
<li><a href="glows.php">Glow Panel</a></li>
<?php 
}
if ($_SESSION['isStaff'] == true) { 
?>
<li><a href="moderator.php">Mod Panel</a></li>
<?php if ($_SESSION['isAdmin'] == true) { ?>
<li><a href="admin.php">Admin Panel</a></li>
<?php } } ?>
<li><a href="store.php">Store</a></li>
<li><a class="active" href="server.php">Server</a></li>
<li><a href="logout.php">Logout</a></li>
</ul>     

<div class="container">

<?php


include '../config.php';

$mysql = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);

$resQuery = mysqli_query($mysql, "SELECT * FROM users");

$intRegistered = mysqli_num_rows($resQuery);

$resQueryTwo = mysqli_query($mysql, "SELECT curPop FROM servers WHERE servPort = '$intGamePort'");

$arrData = mysqli_fetch_assoc($resQueryTwo);

echo '<center>';
echo ($resCon = @fsockopen($strServerHost, $intLoginPort)) ? "Login Server: <font color=\"green\">Online</font>" : "Login Server: <font color=\"red\">Offline</font>";
echo '<br>';
echo ($resCon = @fsockopen($strServerHost, $intGamePort)) ? "Game Server: <font color=\"green\">Online</font>" : "Game Server: <font color=\"red\">Offline</font>";
@fclose($resCon);
echo '<p>Users Registered: ' . $intRegistered . '</p>';
echo '<p>Users Online: ' . $arrData['curPop'] . '</p>';
echo "</center>";

?>

</div>
<div class="footer">&copy; 2016-2017 Luna &#8482; All Rights Reserved</div>
</div>
</body>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="../js/index.js"></script>
</html>