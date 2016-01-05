<?php

include 'mysql.php';

session_start();

$strUsername = $_SESSION['login_user'];

$arrResults = $mysql->perfFetchAssoc("SELECT username FROM users WHERE username = '$strUsername'");

$resSession = $arrResults['username'];

if (!isset($resSession)) {
    $mysql->closeMySQL();
    header('Location: index.php');
}

?>
