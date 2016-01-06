<?php

include 'session.php';
include 'config.php';

$strError = '';
$strMessage = '';

$mysql = new mysqli($strDBHost, $strDBUser, $strDBPass, $strDBName);

if (isset($_POST['update'])) {
    $strNG = $_POST['nameglow'];
    $strNC = $_POST['namecolor'];
    $strBT = $_POST['bubbletext'];
    $strBC = $_POST['bubblecolor'];
    $strRC = $_POST['ringcolor'];
    $intSpeed = $_POST['speed'];

    if (isset($strNG) && isset($strNC) && isset($strBT) && isset($strBC) && isset($strRC)) {
        $strNG = $mysql->real_escape_string(stripslashes($strNG));
        $strNC = $mysql->real_escape_string(stripslashes($strNC));
        $strBT = $mysql->real_escape_string(stripslashes($strBT));
        $strBC = $mysql->real_escape_string(stripslashes($strBC));
        $strRC = $mysql->real_escape_string(stripslashes($strRC));
        $intSpeed = $mysql->real_escape_string(stripslashes($intSpeed));

        $strUsername = $_SESSION['login_user'];

        if (is_numeric($intSpeed) && $intSpeed <= 100) {
            if (ctype_alnum($strNG) && strlen($strNG) <= 6) {
                if (ctype_alnum($strNC) && strlen($strNC) <= 6) {
                    if (ctype_alnum($strBT) && strlen($strBT) <= 6) {
                        if (ctype_alnum($strBC) && strlen($strBC) <= 6) {
                            if (ctype_alnum($strRC) && strlen($strRC) <= 6) {
                                $strNGHex = '0x' . $strNG;
                                $strNCHex = '0x' . $strNC;
                                $strBTHex = '0x' . $strBT;
                                $strBCHex = '0x' . $strBC;
                                $strRCHex = '0x' . $strRC;
                                $mysql->query("UPDATE users SET nameglow = '$strNGHex' WHERE username = '$strUsername'");
                                $mysql->query("UPDATE users SET namecolour = '$strNCHex' WHERE username = '$strUsername'");
                                $mysql->query("UPDATE users SET bubbletext = '$strBTHex' WHERE username = '$strUsername'");
                                $mysql->query("UPDATE users SET bubblecolour = '$strBCHex' WHERE username = '$strUsername'");
                                $mysql->query("UPDATE users SET ringcolour = '$strRCHex' WHERE username = '$strUsername'");
                                $mysql->query("UPDATE users SET speed = '$intSpeed' WHERE username = '$strUsername'");
                                $strMessage = 'Successfully updated glow settings';
                            } else {
                                $strError = 'Invalid Ring Color Pattern';
                            }
                        } else {
                            $strError = 'Invalid Bubble Color Pattern';
                        }
                    } else {
                        $strError = 'Invalid Bubble Text Pattern';
                    }
                } else {
                    $strError = 'Invalid Name Color Pattern';
                }
            } else {
                $strError = 'Invalid Name Glow Pattern';
            }
        } else {
            $strError = 'Invalid Penguin Speed';
        }
    }
}

?>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Luna - Manager</title>
<link rel="stylesheet" href="css/style.css">
<script src="js/jscolor.js"></script>
<script type="text/javascript">
var r = document.querySelectorAll('input[type=range]'), 
    prefs = ['webkit-slider-runnable', 'moz-range'], 
    styles = [], 
    l = prefs.length,
    n = r.length;

var getTrackStyleStr = function(el, j) {
  var str = '', 
      min = el.min || 0, 
      perc = (el.max) ? ~~(100*(el.value - min)/(el.max - min)) : el.value, 
      val = perc + '% 100%';

  for(var i = 0; i < l; i++) {
    str += 'input[type=range]:nth-of-type(' + j + ')::-' + prefs[i] + '-track{background-size:' + val + '} ';
  }
  return str;
};

var setDragStyleStr = function(evt) {
  //console.log(evt, this);
  var trackStyle = getTrackStyleStr(evt.target, this + 1);  
  console.log(trackStyle);
  styles[this].textContent = trackStyle;
};

for(var i = 0; i < n; i++) {
  var s = document.createElement('style');
  document.body.appendChild(s);
  styles.push(s);  
  r[i].addEventListener('input', setDragStyleStr.bind(i), false);
}
</script>
</head>
<body>

<div class="wrapper">
<ul>
<li><a href="profile.php">Home</a></li>
<li><a href="settings.php">Settings</a></li>
<li><a class="active" href="glows.php">Glow Panel</a></li>
<li><a href="search.php">Search</a></li>
<?php if ($_SESSION['isStaff'] == true) { ?>
 <li><a href="moderator.php">Mod Panel</a></li>
<?php if ($_SESSION['isAdmin'] == true) { ?>
<li><a href="admin.php">Admin Panel</a></li>
<?php } } ?>
<li><a href="logout.php">Logout</a></li>
</ul>     
</div>

<div class="container">
<center>
<form class="form" name="form" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
       <label for="nameglow">Name Glow: </label>
       <input class="jscolor" type="text" name="nameglow" maxlength="6">
       <label for="namecolor">Name Color: </label>
       <input class="jscolor" type="text" name="namecolor" maxlength="6">
       <label for="bubbletext">Bubble Text Glow: </label>
       <input class="jscolor" type="text" name="bubbletext" maxlength="6">
       <label for="bubblecolor">Bubble Color: </label>
       <input class="jscolor" type="text" name="bubblecolor" maxlength="6">
       <label for="ringcolor">Ring Color: </label>
       <input class="jscolor" type="text" name="ringcolor" maxlength="6">
       <label for="speed">Speed: </label>
       <output for="range">0</output>
       <input type="range" name="speed" value="0">
       <input type="submit" id="login-button" name="update" value="Update">
       <span><?php echo $strError; ?></span>
       <span><?php echo $strMessage; ?></span>
</form>
</center>
</div>
<footer class="bg-bubbles">
    <li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
</footer>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="js/index.js"></script>
</body>
</html>
