<?php

include 'mysql.php';

session_start();

$strError = '';

if (isset($_POST['submit'])) {
    $strName = $_POST['username'];
    $strPass = $_POST['password'];
    if (empty($strName) || empty($strPass)) {
        $strError = 'Please fill in both the username and the password';
    } else {
       
        $strName = $mysql->perfEscape(stripslashes($strName));
        $strPass = $mysql->perfEscape(stripslashes($strPass));
        $strPass = md5($strPass);
        $intRows = $mysql->perfRowCount("SELECT username FROM users WHERE username = '$strName' AND password = '$strPass'");
        if ($intRows == 1) {
            $arrInfo = $mysql->perfFetchAssoc("SELECT * FROM users WHERE username = '$strName'");
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
