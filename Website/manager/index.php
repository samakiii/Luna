<?php

include 'login.php';

if (isset($_SESSION['login_user'])) {
    header('location: profile.php');
}

?>

<!DOCTYPE html>
<html >
<head>
<meta charset="UTF-8">
<title>Luna - Manager</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>

<div class="overlay">
<ul>
<li><a href="../index.php">Home</a></li>
<li><a  href="../register.php">Register</a></li>
<li><a href="../play.php">Play</a></li>
<li><a class="active" href="index.php">Manager</a></li>
<li><a href="../commands.php">Commands</a></li>
<li><a href="../staff.php">Staff</a></li>
<li><a href="../contact.php">Contact Us</a></li>
<li><a href="../about.php">About Us</a></li>
</ul>     

<div class="container">
<center>
<form class="form" name="form" method="post" action="">
       <input type="text" name="username" maxlength="10" placeholder="Enter Your Username">
       <input type="password" name="password" maxlength="15" placeholder="Enter Your Password">
       <input type="password" name="spin" maxlength="6" placeholder="Enter Your Secret Pin">
       <input type="submit" id="login-button" name="submit" value="Sign In">
       <span><?php echo $strError; ?></span>
</form>
</center>

</div>
<div class="footer">&copy; 2016-2017 Luna &#8482; All Rights Reserved</div>
</div>
</body>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="../js/index.js"></script>
</html>