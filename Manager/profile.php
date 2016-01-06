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
<li><a class="active" href="profile.php">Home</a></li>
<li><a href="settings.php">Settings</a></li>
<li><a href="glows.php">Glow Panel</a></li>
<li><a href="search.php">Search</a></li>
<?php if ($_SESSION['isStaff'] == true) { ?>
<li><a href="moderator.php">Mod Panel</a></li>
<?php if ($_SESSION['isAdmin'] == true) { ?>
<li><a href="admin.php">Admin Panel</a></li>
<?php } } ?>
<li><a href="logout.php">Logout</a></li>
</ul>     
</div>

<div class="container">

<?php

include 'config.php';

$strUsername = $_SESSION['login_user'];

$mysql = new mysqli($strDBHost, $strDBUser, $strDBPass, $strDBName);

$resQuery = $mysql->query("SELECT * FROM users WHERE username = '$strUsername'");

$arrResults = $resQuery->fetch_assoc();

$arrRanks = array(
                1 => 'Member',
                2 => 'VIP',
                3 => 'Mediator',
                4 => 'Moderator',
                5 => 'Administrator',
                6 => 'Owner'
);

if ($arrResults['isBanned'] == 'PERM') {
    $strStatus = 'Permanently Banned';
} elseif (is_numeric($arrResults['isBanned']) && $arrResults['isBanned'] > time()) {
    $intRemainingTime = round(($arrResults['isBanned'] - time()) / 3600);
    $strStatus = 'Temporarily Banned For $intRaminingTime hours';
} else {
    $strStatus = 'Active';
}

echo '<center>';
echo '<img  src="avatar.php?avatarInfo=' . implode('|', array($arrResults['colour'], $arrResults['head'], $arrResults['face'], $arrResults['body'], $arrResults['neck'], $arrResults['hands'], $arrResults['feet'])) . '&avatarSize=300">';
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
