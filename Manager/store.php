<?php
include "session.php";
include "config.php";
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
<?php if ($_SESSION["isVIP"] == true) { ?>
<li><a href="glows.php">Glow Panel</a></li>
<?php
}
if ($_SESSION["isStaff"] == true) { 
?>
<li><a href="moderator.php">Mod Panel</a></li>
<?php if ($_SESSION["isAdmin"] == true) { ?>
<li><a href="admin.php">Admin Panel</a></li>
<?php } } ?>
<li><a class="active" href="store.php">Store</a></li>
<li><a href="server.php">Server</a></li>
<li><a href="logout.php">Logout</a></li>
</ul>     

</div>

<div class="container">
<center>
<?php 
$uid = $_SESSION["ID"];
$username = $_SESSION["login_user"];
// $paypal_url = "https://www.sandbox.paypal.com/cgi-bin/webscr"; // if you're going live then comment this line
$paypal_url = "https://www.paypal.com/cgi-bin/webscr"; // if you're using for testing purposes then uncomment above line
$paypal_id = "leneilmario@gmail.com";  //edit this to your paypal seller id

$mysql = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);

$result = mysqli_query($mysql, "SELECT * FROM products");

while ($row = mysqli_fetch_assoc($result)) {
	
?>
<p>Name: </p><?php echo $row["product"];?>
<p>Price: </p><?php echo $row["price"] . "$"; ?>
 
<form class="form" name="form" method="post" action="<?php echo $paypal_url; ?>">
<input type="hidden" name="business" value="<?php echo $paypal_id; ?>">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="item_name" value="<?php echo $row["product"];?>">
<input type="hidden" name="item_number" value="<?php echo $row["pid"];?>">
<input type="hidden" name="amount" value="<?php echo $row["price"];?>">
<input type="hidden" name="no_shipping" value="1">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="cancel_return" value="http://frosty.us/manager/paypal/cancel.php">
<input type="hidden" name="return" value="http://frosty.us/manager/paypal/success.php">
<input type="image" src="https://paypal.com/en_US/i/btn/btn_buynowCC_LG.gif" name="submit">
</form> 
<?php
}
?>
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
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="js/index.js"></script>
</body>
</html>