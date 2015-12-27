<html>
<head>
<title>Luna - Register</title>
</head>
<center>

<?php

require_once('recaptchalib.php');

//Edit only these details and scroll below and edit the captcha keys
$dbHost = '127.0.0.1';
$dbName = 'Luna';
$dbUser = 'root';
$dbPass = 'kevinismybf';

function sendError($strErr) {
             $strMsg = "<center><h1>Error creating account: " . $strErr . "</h1></center>"; 
             die($strMsg);
}

$mysql = new mysqli($dbHost, $dbUser, $dbPass, $dbName);

if (array_key_exists('submit', $_POST)) { 
     $strUsername = $mysql->real_escape_string($_POST['username']);
     $strPassword = $mysql->real_escape_string($_POST['pass']);
     $strPasswordTwo = $mysql->real_escape_string($_POST['passtwo']);
     $intColor = $mysql->real_escape_string($_POST['color']);
     $strEmail = $mysql->real_escape_string($_POST['email']);
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
     $arrExistUser = $mysql->query("SELECT username FROM users WHERE username = '$strUsername'");
     $intUsers = $arrExistUser->num_rows;
     if ($intUsers != 0) {
         sendError('Username already exists, please try another name');
     }
     $arrExistEmail = $mysql->query("SELECT email FROM users WHERE email = '$strEmail'");
     $intEmails = $arrExistEmail->num_rows;
     if ($intEmails != 0) {
         sendError('Email is already in use, please try another email');
     }
     $strIP = $mysql->real_escape_string($_SERVER['REMOTE_ADDR']);
     $strMD5 = md5($strPassword);
     $mixResp = recaptcha_check_answer ('6Ldbc9cSAAAAAHs88TTzyytdrIlkbVx3h5x55t8j', $strIP, $_POST["recaptcha_challenge_field"], $_POST["recaptcha_response_field"]); // edit the first parameter, its the private key
     if (!$mixResp->is_valid) {
         sendError($mixResp->error);
     } else {
         $mysql->query("INSERT INTO users (`username`, `nickname`, `email`, `password`, `colour`, `ipAddr`, 'stamps') VALUES ('" . $strUsername . "', '" . $strUsername . "', '" . $strEmail . "', '" . $strPassword . "', '" . $intColor . "', '" . $strIP . "', '31|7|33|8|32|35|34|36|290|358|448')");
         $intPID = $mysql->insert_id;
         $mysql->query("INSERT INTO igloos ('ID', `username`) VALUES ('" . $intPID . "', '" . $strUsername . "')");
         $mysql->query("INSERT INTO postcards (`ID`, `username`) VALUES ('" . $intPID . "', '" . $strUsername . "')");
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
<?php
require_once('recaptchalib.php');
echo recaptcha_get_html('6Ldbc9cSAAAAACYGs9FWEemI_A4Atx20sOtk6YA-'); //edit this key, its the public key
?>
<tr><th colspan=2><input type="submit" name="submit" value="Register">
</th></tr>
</table>
</form>
</center>
</html>

<?php
}
?>
