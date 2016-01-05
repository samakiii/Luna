<?php
include 'session.php';

if ($_SESSION['isStaff'] == false) { 
    header('location: index.php');
}

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
<li><a href="glows.php">Glow Panel</a></li>
<li><a href="search.php">Search</a></li>
<?php if ($_SESSION['isStaff'] == true) { ?>
 <li><a href="moderator.php">Mod Panel</a></li>
<?php if ($_SESSION['isAdmin'] == true) { ?>
<li><a class="active" href="admin.php">Admin Panel</a></li>
<?php } } ?>
<li><a href="logout.php">Logout</a></li>
</ul>     

</div>

<div class="container">

<?php

include 'mysql.php';

$strMessage = '';
$strMessageTwo = '';

if (isset($_POST['update_rank'])) {
    $strUsername = $_POST['username'];
    $intRank = $_POST['rank'];
    if (isset($strUsername) && isset($intRank)) {
        $strUsername = $mysql->perfEscape(stripslashes($strUsername));
        $intRank = $mysql->perfEscape(stripslashes($intRank));
        $arrRanks = array(
                1 => 'Member',
                2 => 'VIP',
                3 => 'Mediator',
                4 => 'Moderator',
                5 => 'Administrator',
                6 => 'Owner'
        );
        $arrStaffRanks = array(
                3 => 'Mediator',
                4 => 'Moderator',
                5 => 'Administrator',
                6 => 'Owner'
        );
        $strRank = $arrRanks[$intRank];
        if (array_key_exists($intRank, $arrStaffRanks)) {
            $mysql->perfQuery("UPDATE users SET rank = '$intRank' WHERE username = '$strUsername'");
            $mysql->perfQuery("UPDATE users SET isStaff = '1' WHERE username = '$strUsername'");
        } else {
            $mysql->perfQuery("UPDATE users SET rank = '$intRank' WHERE username = '$strUsername'");
        }
        $strMessage = 'You have successfuly updated $strUsername rank to $strRank';
    }
}

if (isset($_POST['update_active'])) {
    $strUsername = $_POST['username'];
    $intAction = $_POST['action'];
    if (isset($strUsername) && isset($intRank)) {
        $strUsername = $mysql->perfEscape(stripslashes($strUsername));
        $intAction = $mysql->perfEscape(stripslashes($intAction));
        switch ($intAction) {
                    case 0:
                            $mysql->perfQuery("UPDATE users SET active = '0' WHERE username = '$strUsername'");
                            $strMessage = 'You have deactivated $strUsername account';
                    break;
                    case 1:
                            $mysql->perfQuery("UPDATE users SET active = '1' WHERE username = '$strUsername'");
                            $strMessage = 'You have activated $strUsername account';
                    break;
        }
    }
}

?>

<form class="form" name="form" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
       <input type="text" name="username" maxlength="10" placeholder="Type a username">
       <div class="select">
       <span class="arr"></span>
       <select name="rank" id="rank">
                <option value="1">Member</option>
                <option value="2">VIP</option>
                <option value="3">Mediator</option>
                <option value="4">Moderator</option>
                <option value="5">Administrator</option>
       </select>
       </div>
       <br>
       <br>
       <input type="submit" id="login-button" name="update_rank" value="Update Rank">
       <span><?php echo $strMessage; ?></span>
</form>         

<form class="form" name="form2" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
       <input type="text" name="username" maxlength="10" placeholder="Type a username">
       <div class="select">
       <span class="arr"></span>
       <select name="action" id="action">
                <option value="0">Deactivate</option>
                <option value="1">Activate</option>
       </select>
       </div>
       <br>
       <br>
       <input type="submit" id="login-button" name="update_active" value="Update Active">
       <span><?php echo $strMessageTwo; ?></span>
</form>         

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
