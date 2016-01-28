<?php

require '.../session.php';
require '.../config.php';

$mysql = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);

$uid = $_SESSION['ID'];
$username = $_SESSION['login_user'];

$item_no = $_GET['item_number'];
$item_transaction = $_GET['tx']; 
$item_status = $_GET['st'];

if ($item_status == "Completed") {
    $result = mysqli_query($mysql, "INSERT INTO sales (`pid`, `uid`, `saledate`, `transactionid`) VALUES ('" . $item_no . "', '" . $uid . "', NOW(), '" . $item_transaction . "')");
    if ($result) {
        mysqli_query($mysql, "UPDATE users SET isVIP = '1' WHERE username = '$username'");
        mysqli_query($mysql, "UPDATE users SET rank = '2' WHERE username = '$username'");
        echo "<center><h2>Welcome, $username</h1></center>";
        echo "<center><h2>Payment Successful</h1></center>";
        echo "<center><p>Your rank has been successfully upgraded to VIP</p></center>";
    }
} else {
    echo "<center><h2>Payment Failed</h2></center>";
}

?>