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
<li><a class="active" href="profile.php">Home</a></li>
<li><a href="settings.php">Settings</a></li>
<li><a href="search.php">Search</a></li>
<li><a href="glows.php">Glow Panel</a></li>
<?php
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

<?php

include '../config.php';

$strUsername = $_SESSION['login_user'];

$mysql = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);

$resQuery = mysqli_query($mysql, "SELECT * FROM users WHERE username = '$strUsername'");

$arrResults = mysqli_fetch_assoc($resQuery);

$arrRanks = array(
                1 => 'Member',
                2 => 'Member',
                3 => 'Mediator',
                4 => 'Moderator',
                5 => 'Administrator',
                6 => 'Owner'
);

if ($arrResults['isBanned'] == 'PERM') {
    $strStatus = 'Permanently Banned';
} elseif (is_numeric($arrResults['isBanned']) && $arrResults['isBanned'] > time()) {
    $intRemainingTime = round(($arrResults['isBanned'] - time()) / 3600);
    $strStatus = "Temporarily Banned For $intRaminingTime hours";
} else {
    $strStatus = 'Active';
}

echo '<center>';
echo '<img  src="avatar.php?avatarInfo=' . implode('|', array($arrResults['colour'], $arrResults['head'], $arrResults['face'], $arrResults['body'], $arrResults['neck'], $arrResults['hand'], $arrResults['feet'])) . '&avatarSize=300">';
echo '<br><br>';
echo '<p>Username: ' . $arrResults['username'] . '</p>';
echo '<p>Email: ' . $arrResults['email'] . '</p>';
echo '<p>Penguin Age: ' . round((time() - strtotime($arrResults['age'])) / 86400) . '</p>';
echo '<p>Coins: ' . $arrResults['coins'] . '</p>';
echo '<p>Rank: ' . $arrRanks[$arrResults['rank']] . '</p>';
echo '<p>Last Seen: ' . $arrResults['LastLogin'] . '</p>';
echo '<p>Account Status: ' . $strStatus . '</p>';
echo "</center>";

?>

</div>
<div class="footer">&copy; 2016-2017 Luna &#8482; All Rights Reserved</div>
</div>
</body>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="../js/index.js"></script>
</html>
