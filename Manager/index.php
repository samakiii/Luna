
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
<link rel="stylesheet" href="css/style.css">
</head>
<center>
<body>

<div class="wrapper">
<div class="container">
<form class="form" name="form" method="post" action="">
       <input type="text" name="username" maxlength="10" placeholder="Enter Your Username">
       <input type="password" name="password" maxlength="15" placeholder="Enter Your Password">
       <input type="submit" id="login-button" name="submit" value="Sign In">
       <span><?php echo $strError; ?></span>
</form>
</div>
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
</center>
</html>
