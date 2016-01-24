<?php

require '.../session.php';

$username = $_SESSION['login_user'];

echo "<center><h1>Welcome, $username</h1></center>";
echo "<center><h1>Payment Canceled</h1></center>";

?>