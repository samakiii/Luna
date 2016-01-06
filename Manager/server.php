<?php

include 'session.php';

?>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Luna - Manager</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="wrapper">
<ul>
<li><a href="profile.php">Home</a></li>
<li><a href="settings.php">Settings</a></li>
<li><a href="search.php">Search</a></li>
<li><a href="glows.php">Glow Panel</a></li>
<?php if ($_SESSION['isStaff'] == true) { ?>
<li><a href="moderator.php">Mod Panel</a></li>
<?php if ($_SESSION['isAdmin'] == true) { ?>
<li><a href="admin.php">Admin Panel</a></li>
<?php } } ?>
<li><a class="active" href="server.php">Server</a></li>
<li><a href="logout.php">Logout</a></li>
</ul>     
</div>

<div class="container">

<?php

/*

include 'config.php';

$mysql = new mysqli($strDBHost, $strDBUser, $strDBPass, $strDBName);

$resQuery = $mysql->query("SELECT * FROM users");

$intRegistered = $resQuery->num_rows();

$resQueryTwo = $mysql->query("SELECT curPop FROM servers WHERE servPort = '$intGamePort' AND servIP = '$strServerHost'");

$arrData = $resQueryTwo->fetch_assoc();

echo '<center>';
echo ($resCon = @fsockopen($strServerHost, $intLoginPort, null, null, 2)) ? "Login Server: <font color=\"green\">Online</font>" : "Login Server: <font color=\"red\">Offline</font>";
echo ($resCon = @fsockopen($strServerHost, $intGamePort, null, null, 2)) ? "Game Server: <font color=\"green\">Online</font>" : "Game Server: <font color=\"red\">Offline</font>";
@fclose($resCon);
echo '<p>Users Registered: ' . $intRegistered . '</p>';
echo '<p>Users Online: ' . $arrData['curPop'] . '</p>';
echo "</center>";

$mysql->close(); */

?>

</div>
<footer class="bg-bubbles">
    <li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
</footer>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="js/index.js"></script>
</body>
</html>