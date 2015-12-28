<html>
<head>
<title>Luna - Register</title>
</head>
<center>

<?php

require 'recaptcha/src/autoload.php';

//Edit only these details and scroll below and edit the captcha keys
$dbHost = '127.0.0.1';
$dbName = 'Luna';
$dbUser = 'root';
$dbPass = 'passwordgoeshere';

function sendError($strErr) {
             $strMsg = "<center><h1>Error: " . $strErr . "</h1></center>"; 
             die($strMsg);
}

$resDBCon= mysqli_connect($dbHost, $dbUser, $dbPass, $dbName) or sendError('Failed to connect to MySQL: ' . mysqli_connect_error());

if (array_key_exists('submit', $_POST)) { 
     $strUsername = mysqli_real_escape_string($resDBCon, $_POST['username']);
     $strPassword = mysqli_real_escape_string($resDBCon, $_POST['pass']);
     $strPasswordTwo = mysqli_real_escape_string($resDBCon, $_POST['passtwo']);
     $intColor = mysqli_real_escape_string($resDBCon, $_POST['color']);
     $strEmail = mysqli_real_escape_string($resDBCon, $_POST['email']);
     if (empty($strEmail) && empty($strUsername) && empty($strPassword) && empty($strPasswordTwo) && empty($intColor)) {
         sendError('One or more fields has not been completed, please complete them');
     }
     if (!get_magic_quotes_gpc()) {
        $strUsername = addslashes($_POST['username']);
        $strPassword = addslashes($_POST['pass']);
        $strPasswordTwo = addslashes($_POST['passtwo']);
        $intColor = addslashes($_POST['color']);
        $strEmail = addslashes($_POST['email']);
     }
     if (!filter_var($strEmail, FILTER_VALIDATE_EMAIL)) {
         sendError('Invalid email address! Please recheck your email');
     } elseif (!ctype_alnum($strUsername) && strlen($strUsername) > 10 && strlen($strUsername) <= 3) {
         sendError('Invalid username! Please make sure the username is alphanumeric and not too long or short');
     } elseif ($intColor > 15 && $intColor < 0 && !int($intColor)) {
         sendError('Invalid color! Please use a valid color');
     } elseif ($strPassword != $strPasswordTwo) {
         sendError('Password does not match! Please make sure the passwords match');
     } elseif (strlen($strPassword) > 15 && strlen($strPassword)  < 5 && strlen($strPasswordTwo) > 15 && strlen($strPasswordTwo) < 5) {
         sendError('Password is either too long or too short');
     }
     $arrExistUsers = mysqli_query($resDBCon, "SELECT username FROM users WHERE username = '$strUsername'");
     $intUsers = mysqli_num_rows($arrExistUsers);
     if ($intUsers != 0) {
         sendError('Username already exists, please try another name');
     }
     $arrExistEmails = mysqli_query($resDBCon, "SELECT email FROM users WHERE email = '$strEmail'");
     $intEmails = mysqli_num_rows($arrExistEmails);
     if ($intEmails != 0) {
         sendError('Email is already in use, please try another email');
     }
     $strIP = mysqli_real_escape_string($resDBCon, $_SERVER['REMOTE_ADDR']);
     $strMD5 = md5($strPassword);
     $strSecretKey = '6Lee7RMTAAAAAD_B4-4nEt2Amni4XC3EfGmKEI_K'; //edit this, its your secret/private key
     $recaptcha = new \ReCaptcha\ReCaptcha($strSecretKey);
     $resp = $recaptcha->verify($_POST['g-recaptcha-response'], $strIP);
     if (!$resp->isSuccess()) {
         sendError($resp->getErrorCodes());
     } else {
         $resQuery = mysqli_query($resDBCon, "INSERT INTO users (`username`, `nickname`, `email`, `password`, `colour`,  `ipAddr`, `stamps`) VALUES ('" . $strUsername . "', '" . $strUsername . "', '" . $strEmail . "', '" . $strMD5 . "', '" . $intColor . "', '" . $strIP . "', '31|7|33|8|32|35|34|36|290|358|448')");
         $intPID = mysqli_insert_id($resDBCon);
         mysqli_query($resDBCon, "INSERT INTO igloos (`ID`, `username`) VALUES ('" . $intPID . "', '" . $strUsername . "')");
         mysqli_query($resDBCon, "INSERT INTO postcards (`recepient`, `mailerID`, `mailerName`, `postcardType`) VALUES ('" . $intPID . "', '0', 'Luna', '125')");
         echo "<center><h1>You have successfully registered with Luna, $strUsername ! You may now login to the game :-)</h1></center>";
     }
} else {
?>

<form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
<tr><td>Username:</td><td>
<input type="text" name="username" maxlength="10" placeholder="Username goes here" width="100">
</td></tr><tr>
<br>
<td>Email:</td><td>
<input type="text" name="email" maxlength="25" placeholder="Enter Your Email" width="100">
</td></tr>
<br>
<tr><td>Password:</td><td>
<input type="password" name="pass" maxlength="15" placeholder="Enter Your Password" width="100">
</td></tr>
<br>
<tr><td>Verify Password:</td><td>
<input type="password" name="passtwo" maxlength="15" placeholder="Enter Your Password Again" width="100">
</td></tr>
</td></tr>
<br>
<tr><td>Color:</td><td>
<select name="color" id="color">
<option value="0" selected="true"></option>
<option value="1">Blue</option>
<option value="2">Green</option>
<option value="3">Pink</option>
<option value="4">Black</option>   
<option value="5">Red</option>
<option value="6">Orange</option>
<option value="7">Yellow</option>
<option value="8">Dark Purple</option>
<option value="9">Brown</option>
<option value="10">Peach</option>
<option value="11">Dark Green</option>
<option value="12">Light Blue</option>
<option value="13">Light Green</option>
<option value="14">Grey</option>
<option value="15">Aqua</option>
</select>
</td></tr>
<br>
<!--edit the site key to match yours -->
<div class="g-recaptcha" data-sitekey="6Lee7RMTAAAAANDR7uPCUyEE323E9aY9n3a6yuLS"></div>
<script type="text/javascript" src='https://www.google.com/recaptcha/api.js?hl=en'></script>
<tr><th colspan=2><input type="submit" name="submit" value="Register">
</th></tr>
</table>
</form>
</center>
</html>

<?php
}
?>
