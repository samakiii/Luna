<?php

require '.../session.php';
require '.../config.php';

$mysql = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);

$uid = $_SESSION['ID'];
$username = $_SESSION['login_user'];

$item_no = $_GET['item_number'];
$item_transaction = $_GET['tx']; 
$item_price = $_GET['amt'];
$item_currency = $_GET['cc'];

$sql = mysqli_query($mysql, "SELECT product, price, currency FROM products WHERE pid = '$item_no'");
$row = mysqli_fetch_assoc($sql);
$price = $row['price'];
$currency = $row['currency'];

if ($item_price == $price && item_currency == $currency) {
    $result = mysqli_query($mysql, "INSERT INTO sales (pid, uid, saledate, transactionid) VALUES ('$item_no', '$uid', NOW(), '$item_transaction')");
    if ($result) {
        mysqli_query($mysql, "UPDATE users SET isVIP = '1' WHERE username = '$username'");
        mysqli_query($mysql, "UPDATE users SET rank = '2' WHERE username = '$username'");
        echo "<center><h1>Welcome, $username</h1></center>";
        echo "<center><h1>Payment Successful</h1></center>";
        echo "<center><p>Your rank has been successfully upgraded to VIP</p></center>";
    }
} else {
echo "<center><h1>Payment Failed</h1></center>";
}

?>