<!DOCTYPE html>
<html >
<head>
<meta charset="UTF-8">
<title>Luna - Register</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	
<div class="overlay">
<ul>
<li><a href="index.php">Home</a></li>
<li><a class="active" href="register.php">Register</a></li>
<li><a href="play.php">Play</a></li>
<li><a href="manager/index.php">Manager</a></li>
<li><a href="commands.php">Commands</a></li>
<li><a href="staff.php">Staff</a></li>
<li><a href="contact.php">Contact Us</a></li>
<li><a href="about.php">About Us</a></li>
</ul>

<div class="container">
	
<?php

require 'recaptcha/src/autoload.php';
require 'config.php';

function domain_exists($strEmail, $strRecord = 'MX'){
	         list($strUser, $strDomain) = explode('@', $strEmail);
	         return checkdnsrr($strDomain, $strRecord);
}

function sendError($strErr) {
             $strMsg = "<center><h2>Error: " . $strErr . "</h2></center>"; 
             die($strMsg);
}

$resDBCon= mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName) or sendError('Failed to connect to MySQL: ' . mysqli_connect_error());

if (isset($_POST['submit'])) {
    $strUsername = $_POST['username'];
    $strPassword = $_POST['pass'];
    $strPasswordTwo = $_POST['passtwo'];
    $intColor = $_POST['color'];
    $strEmail = $_POST['email'];
    $intPin = $_POST['spin'];
    
    if (empty($strEmail) || empty($strUsername) || empty($strPassword) || empty($strPasswordTwo) || empty($intColor) || empty($intPin)) {
        sendError('One or more fields has not been completed, please complete them');
    }
    
    $strUsername = mysqli_real_escape_string($resDBCon, $strUsername);
    $strPassword = mysqli_real_escape_string($resDBCon, $strPassword);
    $strPasswordTwo = mysqli_real_escape_string($resDBCon, $strPasswordTwo);
    $intColor = mysqli_real_escape_string($resDBCon, $intColor);
    $strEmail = mysqli_real_escape_string($resDBCon, $strEmail);
    $intPin = mysqli_real_escape_string($resDBCon, $intPin);
    
    $strUsername = addslashes($strUsername);
    $strPassword = addslashes($strPassword);
    $strPasswordTwo = addslashes($strPasswordTwo);
    $intColor = addslashes($intColor);
    $strEmail = addslashes($strEmail);
    $intPin = addslashes($intPin);
     
    if (!filter_var($strEmail, FILTER_VALIDATE_EMAIL)) {
        sendError('Invalid email address! Please recheck your email');
    } elseif (!domain_exists($strEmail)) {
        sendError('Invalid domain for email address! Please use a valid domain');
    } elseif (!ctype_alnum($strUsername) && strlen($strUsername) > 10 && strlen($strUsername) <= 3) {
        sendError('Invalid username! Please make sure the username is alphanumeric and not too long or short');
    } elseif ($intColor > 15 && $intColor < 0 && !is_numeric($intColor)) {
        sendError('Invalid color! Please use a valid color');
    } elseif ($strPassword != $strPasswordTwo) {
        sendError('Password does not match! Please make sure the passwords match');
    } elseif (strlen($strPassword) > 15 && strlen($strPassword)  < 5 && strlen($strPasswordTwo) > 15 && strlen($strPasswordTwo) < 5) {
        sendError('Password is either too long or too short');
    } elseif (!is_numeric($intPin) && $intPin < 6 && $intPin > 6) {
        sendError('Invalid pin number, pin must be 6 digits long');
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
     
    $arrExistIPS = mysqli_query($resDBCon, "SELECT ipAddr FROM users WHERE ipAddr = '$strIP'");
    $intIPS = mysqli_num_rows($arrExistIPS);
     
    if ($intPS >= 2) {
        sendError('You cannot create more than two accounts using this IP');
    }
     
    $strMD5 = md5($strPassword);
     
    $recaptcha = new \ReCaptcha\ReCaptcha($strSecretKey);
    $resp = $recaptcha->verify($_POST['g-recaptcha-response'], $strIP);
     
    if (!$resp->isSuccess()) {
        sendError('You are a bot, get the fuck out');
    } else {
        $resQuery = mysqli_query($resDBCon, "INSERT INTO users (`username`, `nickname`, `email`, `password`, `colour`,  `ipAddr`, `stamps`, `spin`) VALUES ('" . $strUsername . "', '" . $strUsername . "', '" . $strEmail . "', '" . $strMD5 . "', '" . $intColor . "', '" . $strIP . "', '31|7|33|8|32|35|34|36|290|358|448', '" . $intPin . "')");
        $intPID = mysqli_insert_id($resDBCon);
        mysqli_query($resDBCon, "INSERT INTO igloos (`ID`, `username`) VALUES ('" . $intPID . "', '" . $strUsername . "')");
        mysqli_query($resDBCon, "INSERT INTO postcards (`recepient`, `mailerID`, `mailerName`, `postcardType`) VALUES ('" . $intPID . "', '0', 'Luna', '125')");
        echo "<center><h2>You have successfully registered with Luna, $strUsername ! You may now login to the game :-)</h2></center>";
    }
    
} else {
	
?>

<center>
<form class="form" name="form" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
       <input type="text" name="username" maxlength="10" placeholder="Enter Your Username">
       <input type="text" name="email" maxlength="25" placeholder="Enter Your Email">
       <input type="password" name="pass" maxlength="15" placeholder="Enter Your Password">
       <input type="password" name="passtwo" maxlength="15" placeholder="Enter Your Password Again">
       <input type="password" name="spin" maxlength="6" placeholder="Enter Your Secret Pin">
       <select name="color" id="color">
                <option value="">Color</option>
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
       <br><br>
       <div class="g-recaptcha" data-sitekey="<?php echo $strSiteKey; ?>"></div>
       <script type="text/javascript" src='https://www.google.com/recaptcha/api.js?hl=en'></script>
       <br>
       <input type="submit" id="login-button" name="submit" value="Sign Up">
</form>
</center>

<?php
}
?>
	
</div>
<div class="footer">&copy; 2016-2017 Luna &#8482; All Rights Reserved</div>
</div>
</body>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="js/index.js"></script>
</html>