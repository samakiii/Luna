<?php

include 'config.php';

session_start();

$strUsername = $_SESSION['login_user'];

$mysql = new mysqli($strDBHost, $strDBUser, $strDBPass, $strDBName);

$resQuery = $mysql->query("SELECT username FROM users WHERE username = '$strUsername'");

$arrResults = $resQuery->fetch_assoc();

$resSession = $arrResults['username'];

if (!isset($resSession)) {
    $mysql->close();
    header('Location: index.php');
}

?>
