<?php

include 'config.php';

$resMysql = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);

session_start();

$strUsername = $_SESSION['login_user'];

$resQuery = mysqli_query($resMysql, "SELECT username FROM users WHERE username = '$strUsername'");
$arrResults = mysqli_fetch_assoc($resQuery);

$resSession = $arrResults['username'];

if (!isset($resSession)) {
    mysqli_close($resMysql);
    header('Location: index.php');
}

?>
