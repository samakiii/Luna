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
<li><a class="active" href="search.php">Search</a></li>
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
<li><a href="server.php">Server</a></li>
<li><a href="logout.php">Logout</a></li>
</ul>     

<div class="container">

<?php

include '../config.php';

$strError = '';

$mysql = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);

if (isset($_POST['submit'])) {
    $strSearch = $_POST['search'];
    if (isset($strSearch)) {
       $strSearch = mysqli_real_escape_string($mysql, $strSearch);
       $strSearch = addslashes($strSearch);
       $resQuery = mysqli_query($mysql, "SELECT * FROM users WHERE username = '$strSearch'");
       $arrResults = mysqli_fetch_assoc($resQuery);
       if (!empty($arrResults)) {
           $arrRanks = array(
                1 => 'Member',
                2 => 'VIP',
                3 => 'Mediator',
                4 => 'Moderator',
                5 => 'Administrator',
                6 => 'Owner'
           );
          echo '<center>';
          echo '<img  src="avatar.php?avatarInfo=' . implode('|', array($arrResults['colour'], $arrResults['head'], $arrResults['face'], $arrResults['body'], $arrResults['neck'], $arrResults['feet'])) . '&avatarSize=300">';
          echo '<br><br>';
          echo '<p>Username: ' . $arrResults['username'] . '</p>';
          echo '<p>Email: ' . $arrResults['email'] . '</p>';
          echo '<p>Penguin Age: ' . round((time() - strtotime($arrResults['age'])) / 86400) . '</p>';
          echo '<p>Coins: ' . $arrResults['coins'] . '</p>';
          echo '<p>Rank: ' . $arrRanks[$arrResults['rank']] . '</p>';
          echo '<p>Last Seen: ' . $arrResults['LastLogin'] . '</p>';
          echo "</center>";
      } else {
          $strError = 'No user found with provided details';
      }
    } else {
       $strError = 'Please fill in your search information';
    }
}
?>

<form class="form" name="form" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
       <input type="text" name="search" maxlength="25" placeholder="Type a username">
       <input type="submit" id="login-button" name="submit" value="Search">
       <span><?php echo $strError; ?></span>
</form>

</div>
<div class="footer">&copy; 2016-2017 Luna &#8482; All Rights Reserved</div>
</div>
</body>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="../js/index.js"></script>
</html>