<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Luna - Commands</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	
<div class="overlay">
<ul>
<li><a href="index.php">Home</a></li>
<li><a href="register.php">Register</a></li>
<li><a href="play.php">Play</a></li>
<li><a href="manager/index.php">Manager</a></li>
<li><a class="active" href="commands.php">Commands</a></li>
<li><a href="staff.php">Staff</a></li>
<li><a href="contact.php">Contact Us</a></li>
<li><a href="about.php">About Us</a></li>
</ul>     

<div class="container">
<center>             
<h1>Normal Users Commands: </h1>
<table>
  <tr>
    <th><h2>Command</h2></th>
    <th><h2>Example</h2></th> 
    <th><h2>Info</h2></th>
  </tr>
  <tr>
    <td>!AI</td>
    <td>!AI 127</td> 
    <td>Add an Item using an Item ID</td>
  </tr>
  <tr>
    <td>!NICK</td>
    <td>!NICK Texas</td> 
    <td>Change your nickname</td>
  </tr>
  <tr>
    <td>!AC</td>
    <td>!AC 500000</td> 
    <td>Add a specific amount of coins</td>
  </tr>
  <tr>
    <td>!GOTO</td>
    <td>!GOTO Kevin</td> 
    <td>Go to a particular user</td>
  </tr>
  <tr>
    <td>!CLONE</td>
    <td>!CLONE Kevin</td> 
    <td>Clone a Penguin by their Name</td>
  </tr>
  <tr>
    <td>!FIND</td>
    <td>!FIND Trevor</td> 
    <td>Find out where a user is in the server</td>
  </tr>
   <tr>
    <td>!SCOUNT</td>
    <td>!SCOUNT</td> 
    <td>The Bot shows the number of users in the server</td>
  </tr>
   <tr>
    <td>!RCOUNT</td>
    <td>!RCOUNT</td> 
    <td>The Bot shows the number of the users in the current room</td>
  </tr>
   <tr>
    <td>!JR</td>
    <td>!JR 100</td> 
    <td>Join a room using a Room ID</td>
  </tr>
   <tr>
  <tr>
    <td>~SIT</td>
    <td>~SIT</td> 
    <td>Makes the bot to sit down</td>
  </tr>
  <tr>
    <td>~DANCE</td>
    <td>~DANCE</td> 
    <td>Makes the bot dance</td>
  </tr>
  <tr>
    <td>~JOKE</td>
    <td>~JOKE</td> 
    <td>Makes the bot joke</td>
  </tr>
  <tr>
    <td>~MOVE</td>
    <td>~MOVE 300 300</td> 
    <td>Makes the bot move in the room</td>
  </tr>
  <tr>
    <td>~MASCOT</td>
    <td>~MASCOT ROCKHOPPER</td> 
    <td>Makes the bot dress like a mascot</td>
  </tr>
  <tr>
    <td>~TSB</td>
    <td>~TSB 310 320</td> 
    <td>Makes the bot to throw a snowball</td>
  </tr>
  <tr>
    <td>~FOLLOW</td>
    <td>~FOLLOW</td> 
    <td>Makes the bot to follow you</td>
  </tr>
  <tr>
    <td>~UNFOLLOW</td>
    <td>~UNFOLLOW</td> 
    <td>Stops the bot from following you</td>
  </tr>
  <tr>
    <td>~SING</td>
    <td>~SING Drake-Hotline Bling</td> 
    <td>Makes the bot sing a song</td>
  </tr>
  <tr>
    <td>~WIKI</td>
    <td>~WIKI Jupiter</td> 
    <td>Gets information from wikipedia, currently not yet implemented</td>
  </tr>
</table>

<h1>VIP Commands: </h1>
<table>
<tr>
    <th><h2>Command</h2></th>
    <th><h2>Example</h2></th> 
    <th><h2>Info</h2></th>
  </tr>        
  <td>!SP</td>
    <td>!SP 50</td> 
    <td>Set the penguin speed ranging from 0 to 100</td>
  </tr>
   <tr>
    <td>!NG</td>
    <td>!NG 0xFFD700</td> 
    <td>Set/Change your Nameglow</td>
  </tr> <tr>
    <td>!NC</td>
    <td>!NC 0xFFD700</td> 
    <td>Set/Change your Namecolor</td>
  </tr>
   <tr>
    <td>!BC</td>
    <td>!BC 0xFFD700</td> 
    <td>Set/Change your Bubblecolor</td>
  </tr>
   <tr>
    <td>!BT</td>
    <td>!BT 0xFFD700</td> 
    <td>Set/Change your Bubbletextcolor</td>
  </tr>
   <tr>
    <td>!RC</td>
    <td>!RC 0xFFD700</td> 
    <td>Set/Change your ring color</td>
  </tr>
   <tr>
    <td>!CG</td>
    <td>!CG 0xFFD700</td> 
    <td>Set/Change your Chat Text Glow</td>
  </tr>
</table>

<h1>Staff Commands: </h1>
<table>
<tr>
    <th><h2>Command</h2></th>
    <th><h2>Example</h2></th> 
    <th><h2>Info</h2></th>
  </tr>        
  <td>#BAN</td>
    <td>#BAN Trevor</td> 
    <td>Ban a user by their name</td>
  </tr>
   <tr>
    <td>#KBC</td>
    <td>#KBC Trevor</td> 
    <td>Kick and Ban a user by their name at the same time</td>
  </tr> <tr>
    <td>#TBAN</td>
    <td>#TBAN Trevor</td> 
    <td>Ban a user by their name for a specific amount of time(24h, 48h, 78h)</td>
  </tr>
   <tr>
    <td>#KICK</td>
    <td>#KICK Trevor</td> 
    <td>Kick a user by their name from the server</td>
  </tr>
   <tr>
    <td>#UNBAN</td>
    <td>#UNBAN Trevor</td> 
    <td>Unban a user by their name</td>
  </tr>
   <tr>
    <td>#REBOOT</td>
    <td>#REBOOT</td> 
    <td>Reboot the server</td>
  </tr>
   <tr>
    <td>sGLOBAL</td>
    <td>#GLOBAL this is a test message</td> 
    <td>Send a message across the server</td>
  </tr>
  <tr>
    <td>#SUMMON</td>
    <td>#SUMMON Trevor</td> 
    <td>Summon a user by their name to the room you're in</td>
  </tr>
  <tr>
    <td>#MIRROR</td>
    <td>#MIRROR Trevor</td> 
    <td>Activate mirror on a user by their name</td>
  </tr>
</table>
</center>			  

</div>
<div class="footer">&copy; 2016-2017 Luna &#8482; All Rights Reserved</div>
</div>
</body>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="js/index.js"></script>
</html>