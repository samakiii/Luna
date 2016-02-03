<?php

require '.../session.php';
require '.../config.php';

$mysql = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);

$uid = $_SESSION['ID'];
$username = $_SESSION['login_user'];

$item_no = $_GET['item_number'];
$item_transaction = $_GET['tx']; 
$item_status = $_GET['st'];

$item_no = mysqli_real_escape_string($mysql, $item_no);
$item_transaction = mysqli_real_escape_string($mysql, $item_transaction);
$item_status = mysqli_real_escape_string($mysql, $item_status);

$item_no = addslashes($item_no);
$item_transaction = addslashes($item_transaction);
$item_status = addslashes($item_status);

if (!empty($item_transaction) && $item_status == "Completed") {
    $result = mysqli_query($mysql, "INSERT INTO sales (`pid`, `uid`, `saledate`, `transactionid`) VALUES ('" . $item_no . "', '" . $uid . "', NOW(), '" . $item_transaction . "')");
    if ($result) {
        $intPaymentID = mysqli_insert_id($mysql);
        mysqli_query($mysql, "UPDATE users SET isVIP = '1' WHERE username = '$username'");
        mysqli_query($mysql, "UPDATE users SET rank = '2' WHERE username = '$username'");
        echo "<center><h2>Welcome, $username</h1></center>";
        echo "<center><h2>Payment Successful</h1></center>";
        echo "<center><p>Your Payment ID - " . $intPaymentID . "</p></center>";
        echo "<center><p>Your rank has been successfully upgraded to VIP</p></center>";
    }
} else {
    echo "<center><h2>Payment Failed</h2></center>";
}

?>