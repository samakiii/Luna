<?php

include 'config.php';

session_start();

$strError = '';

$mysql = new mysqli($strDBHost, $strDBUser, $strDBPass, $strDBName);

if (isset($_POST['submit'])) {
    $strName = $_POST['username'];
    $strPass = $_POST['password'];
    if (empty($strName) || empty($strPass)) {
        $strError = 'Please fill in both the username and the password';
    } else {
       
        $strName = $mysql->real_escape_string(stripslashes($strName));
        $strPass = $mysql->real_escape_string(stripslashes($strPass));
        $strPass = md5($strPass);
        $resQuery = $mysql->query("SELECT * FROM users WHERE username = '$strName' AND password = '$strPass'");
        $intRows = $resQuery->num_rows();
        $arrInfo = $resQuery->fetch_assoc();
        if ($intRows == 1) {
            $_SESSION['login_user'] = $strName;
            $_SESSION['isStaff'] = $arrInfo['isStaff'];
            $_SESSION['isAdmin'] = $arrInfo['isAdmin'];
            header('location: profile.php');
        } else {
            $strError = 'Username or Password is invalid';
        }
   }
}
?>
