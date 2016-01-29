<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Luna - Contact Us</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	
<div class="overlay">
<ul>
<li><a href="index.php">Home</a></li>
<li><a href="register.php">Register</a></li>
<li><a href="play.php">Play</a></li>
<li><a href="manager/index.php">Manager</a></li>
<li><a href="commands.php">Commands</a></li>
<li><a href="staff.php">Staff</a></li>
<li><a class="active" href="contact.php">Contact Us</a></li>
<li><a href="about.php">About Us</a></li>
</ul>     

<div class="container">
	
<?php

require 'recaptcha/src/autoload.php';
require 'config.php';

$strContactEmail = "your@yourdomain.com"; //edit this to your email

function domain_exists($strEmail, $strRecord = 'MX'){
	         list($strUser, $strDomain) = split('@', $strEmail);
	         return checkdnsrr($strDomain, $strRecord);
}

function sendError($strErr) {
             $strMsg = "<center><h2>Error: " . $strErr . "</h2></center>"; 
             die($strMsg);
}

$resDBCon= mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName) or sendError('Failed to connect to MySQL: ' . mysqli_connect_error());

if (isset($_POST['submit'])) {
	$strUsername = $_POST['username'];
	$strEmail = $_POST['email'];
	$strSubject = $_POST['subject'];
	$strMessage = $_POST['comments'];

	if (!isset($strUsername) || !isset($strEmail) || !isset($strSubject) || !isset($strMessage)) {
		sendError('One or more fields has not been completed, please fill in everything');		
	}
	
	$strUsername = mysqli_real_escape_string($resDBCon, $strUsername);
    $strEmail = mysqli_real_escape_string($resDBCon, $strEmail);
    $strSubject = mysqli_real_escape_string($resDBCon, $strSubject);
    $strMessage = mysqli_real_escape_string($resDBCon, $strMessage);
       
    $strUsername = stripslashes($strUsername);
    $strEmail = stripslashes($strEmail);
    $strSubject = stripslashes($strSubject);
    $strMessage = stripslashes($strMessage);
     
    if (!filter_var($strEmail, FILTER_VALIDATE_EMAIL)) {
        sendError('Invalid email address! Please recheck your email');
    } elseif (!domain_exists($strEmail)) {
        sendError('Invalid domain for email address! Please use a valid domain');
    } elseif (!ctype_alnum($strUsername) && strlen($strUsername) > 10 && strlen($strUsername) <= 3) {
        sendError('Invalid username! Please make sure the username is alphanumeric and not too long or short');
    } elseif (!ctype_alnum($strSubject) && strlen($strSubject) < 5 && strlen($strSubject) > 20) {
        sendError('Invalid title! Please enter a valid subject, make sure it is alphanumeric and more than 5 and lesser than 10 characters long');
    } elseif (!ctype_alnum($strMessage) && strlen($strMessage) < 5 && strlen($strMessage) > 500) {
        sendError('Invalid message! Please enter a valid message, make sure it is alphanumeric and more than 5 and lesser than 500 characters long');
    }

    $strSecretKey = '6Lee7RMTAAAAAD_B4-4nEt2Amni4XC3EfGmKEI_K'; //edit this, its your secret/private key for the captcha
    $recaptcha = new \ReCaptcha\ReCaptcha($strSecretKey);
    $resp = $recaptcha->verify($_POST['g-recaptcha-response'], $strIP);
     
    if (!$resp->isSuccess()) {
        sendError('You are a bot, get the fuck out');
    } else {
        $strHeaders  = "From: " . $strUsername  . "<" . $strEmail . ">\n";
        $strHeaders .= "Reply-To: " . $strUsername . "<" . $strEmail . ">\n";
        $strHeaders .= "Cc: " . $strUsername . "<" . $strEmail . ">\n"; 
        $strHeaders .= "X-Sender: " . $strUsername . "<" . $strEmail . ">\n";
        $strHeaders .= "X-Mailer: PHP/" . phpversion();
        $strHeaders .= "X-Priority: 1\n";
        $strHeaders .= "Return-Path: " . $strEmail . "\n";
        $strHeaders .= "MIME-Version: 1.0\r\n";
        $strHeaders .= "Content-Type: text/html; charset=iso-8859-1\n";

	    $strMessage = wordwrap($strMessage, 70);
	
        $blnSent = mail($strContactEmail, $strSubject, $strMessage, $strHeaders);  
    
        if ($blnSent) {
            echo "<center><h2>Thank you for contacting us, you will receive an email from us within the next 48 hours</h2></center>";
        } else {
            sendError('Failed to send email');
        }
    }
} else {
	
?>
	
<center>
<form class="form" name="form" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
       <input type="text" name="username" maxlength="10" placeholder="Enter Your Username">
       <input type="text" name="email" maxlength="25" placeholder="Enter A Valid Email">
       <input type="text" name="subject" maxlength="20" placeholder="Enter Your Subject">
       <textarea  name="comments" maxlength="500" cols="25" rows="6" placeholder="Enter Your Message"></textarea>
       <!--edit the site key to match yours for the captcha -->
       <div class="g-recaptcha" data-sitekey="6Lee7RMTAAAAANDR7uPCUyEE323E9aY9n3a6yuLS"></div>
       <script type="text/javascript" src='https://www.google.com/recaptcha/api.js?hl=en'></script>
       <br>
       <input type="submit" id="login-button" name="submit" value="Submit">
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