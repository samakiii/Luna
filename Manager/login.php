<?php

include "config.php";

session_start();

$strError = '';

if (array_key_exists('submit', $_POST)) {
    if (empty($_POST['username']) || empty($_POST['password'])) {
        $strError = "Username or Password is invalid";
    } else {
        $strName = $_POST['username'];
        $strPass = $_POST['password'];

        $resMysql = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);

        $strName = stripslashes($strName);
        $strPass = stripslashes($strPass);

        $strName = mysqli_real_escape_string($resMysql, $strName);
        $strPass = mysqli_real_escape_string($resMysql, $strPass);

        $strPass = md5($strPass);

        $resQuery = mysqli_query($resMysql, "SELECT * FROM users WHERE password = '$strPass' AND username = '$strName'");
        $intRows = mysqli_num_rows($resQuery);
        $arrInfo = mysqli_fetch_assoc($resQuery);

        if ($intRows == 1) {
            $_SESSION['login_user'] = $strName;
            $_SESSION['isStaff'] = $arrInfo['isStaff'];
            $_SESSION['isAdmin'] = $arrInfo['isAdmin'];
            header("location: profile.php");
        } else {
            $strError = "Username or Password is invalid";
        }

        mysqli_close($resMysql);
   }
}
?>
