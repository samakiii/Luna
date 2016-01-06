<?php

include 'config.php';

session_start();

$strError = '';

$mysql = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);

if (isset($_POST['submit'])) {
    $strName = $_POST['username'];
    $strPass = $_POST['password'];
    if (empty($strName) || empty($strPass)) {
        $strError = 'Please fill in both the username and the password';
    } else {
       
        $strName = mysqli_real_escape_string($mysql, stripslashes($strName));
        $strPass = mysqli_real_escape_string($mysql, stripslashes($strPass));
        $strPass = md5($strPass);
        $resQuery = mysqli_query($mysql, "SELECT username FROM users WHERE username = '$strName' AND password = '$strPass'");
        $intRows = mysqli_num_rows($resQuery);
        if ($intRows == 1) {
            $resQueryTwo = mysqli_query($mysql, "SELECT username FROM users WHERE username = '$strName'");
            $arrInfo = mysqli_fetch_assoc($resQueryTwo);
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
