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
<li><a class="active" href="store.php">Store</a></li>
<li><a href="server.php">Server</a></li>
<li><a href="logout.php">Logout</a></li>
</ul>     

</div>

<div class="container">
<center>
<form class="form" name="form" action="paypal/create.php" method="post">
<input type="hidden" value="1" name="productid"/>
<input type="hidden" value="VIP" name="itemname"/>
<input type="hidden" value="5" name="itemprice"/>
<input type="hidden" value="0" name="shipping"/>
<input type="hidden" value="0" name="tax"/>
<input type="hidden" value="USD" name="currencycode"/>
<input type="hidden" value="Buy VIP" name="paypaldesc"/>
<input type="submit" value="Buy" id="login-button" name="subbutton"/>
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