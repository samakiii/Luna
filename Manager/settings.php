<?php

include 'session.php';
include 'config.php';

$strForm1Error = '';
$strForm2Error = '';
$strForm1Message = '';
$strForm2Message = '';

$strUsername = $_SESSION['login_user'];

$mysql = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);

if (isset($_POST['submit'])) {
    $strOldEmail = $_POST['oldemail'];
    $strNewEmail = $_POST['newemail'];
    if (!empty($strOldEmail) && !empty($strNewEmail)) {
        $strOldEmail = mysqli_real_escape_string($mysql, stripslashes($strOldEmail));
        $strNewEmail = mysqli_real_escape_string($mysql, stripslashes($strNewEmail));
        if (filter_var($strNewEmail, FILTER_VALIDATE_EMAIL) && filter_var($strOldEmail, FILTER_VALIDATE_EMAIL)) {
            $resQuery = mysqli_query($mysql, "SELECT email FROM users WHERE username = '$strUsername'");
            $arrResults = mysqli_fetch_assoc($resQuery);
            $strCurEmail = $arrResults['email'];  
            if ($strCurEmail != $strOldEmail) {
                $strForm1Error = 'Old email does not match with supplied email!';
            } else {
                mysqli_query($mysql, "UPDATE users SET email = '$strNewEmail' WHERE username = '$strUsername'");
                $strForm1Message = 'Successfully updated to your new email';
            }
       } else {
            $strForm1Error = 'The email you have provided is invalid!';
       }
   } else {
            $strForm1Error = 'Please fill in the desired fields for changing the email!';
   }
}

if (isset($_POST['submit2'])) {
    $strNewPass = $_POST['newpass'];
    $strNewPassTwo = $_POST['newpasstwo'];
    if (!empty($strNewPass) && !empty($strNewPassTwo)) {
        $strNewPass = mysqli_real_escape_string($mysql, stripslashes($strNewPass));
        $strNewPassTwo = mysqli_real_escape_string($mysql, stripslashes($strNewPassTwo));
        if ($strNewPass == $strNewPassTwo) {
            if (strlen($strNewPass) < 15 && strlen($strNewPass) > 5 && strlen($strNewPassTwo) < 15 && strlen($strNewPassTwo) > 5) {
                $strMD5 = md5($strNewPass);
                mysqli_query($mysql, "UPDATE users SET password = '$strMD5' WHERE username = '$strUsername'");
                $strForm2Message = 'Successfully updated to your new password';
            } else {
                $strForm2Error = 'Password is either too short or too long!';
            }
        } else {
            $strForm2Error = 'Passwords do not match!';
        }
    } else {
        $strForm2Error = 'Please fill in the desired fields for changing the password';
    }
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
<li><a class="active" href="settings.php">Settings</a></li>
<li><a href="search.php">Search</a></li>
<li><a href="glows.php">Glow Panel</a></li>
<?php if ($_SESSION['isStaff'] == true) { ?>
 <li><a href="moderator.php">Mod Panel</a></li>
<?php if ($_SESSION['isAdmin'] == true) { ?>
<li><a href="admin.php">Admin Panel</a></li>
<?php } } ?>
<li><a href="store.php">Store</a></li>
<li><a href="server.php">Server</a></li>
<li><a href="logout.php">Logout</a></li>
</ul>     

</div>

<div class="container">
<center>
<form class="form" name="form" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
       <input type="text" name="oldemail" maxlength="25" placeholder="Enter Your Old Email">
       <input type="text" name="newemail" maxlength="25" placeholder="Enter Your New Email">
       <input type="submit" id="login-button" name="submit" value="Change Email">
       <span><?php echo $strForm1Error; ?></span>
       <span><?php echo $strForm1Message; ?></span>
</form>
<br>
<br>
<form class="form" name="form2" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
       <input type="password" name="newpass" maxlength="15" placeholder="Enter Your New Password">
       <input type="password" name="newpasstwo" maxlength="15" placeholder="Enter Your New Password Again">
       <input type="submit" id="login-button" name="submit2" value="Change Password">
       <span><?php echo $strForm2Error; ?></span>
       <span><?php echo $strForm2Message; ?></span>
</form>
</center>
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
