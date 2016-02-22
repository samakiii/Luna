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
    <td>!SID</td>
    <td>!SID</td> 
    <td>Know your penguin ID</td>
  </tr>
  <tr>
    <td>!SPING</td>
    <td>!SPING</td> 
    <td>Check if the server is alive</td>
  </tr>
  <tr>
    <td>!AI</td>
    <td>!AI 127</td> 
    <td>Add an Item using an Item ID</td>
  </tr>
  <tr>
    <td>!AF</td>
    <td>!AF 64</td> 
    <td>Add a Furniture using a Furniture ID</td>
  </tr>
  <tr>
    <td>!AIG</td>
    <td>!AIG 8</td> 
    <td>Add an Igloo using a Igloo ID</td>
  </tr>
  <tr>
    <td>!CIF</td>
    <td>!CIF 12</td> 
    <td>Change the Igloo Flooring using a Floor ID</td>
  </tr>
  <tr>
    <td>!CPC</td>
    <td>!CPC</td> 
    <td>Remove all clothing items from the penguin</td>
  </tr>
  <tr>
    <td>!CNICK</td>
    <td>!CNICK Texas</td> 
    <td>Change your nickname</td>
  </tr>
  <tr>
    <td>!AC</td>
    <td>!AC 5000</td> 
    <td>Add a specific amount of coins</td>
  </tr>
  <tr>
    <td>!GOTO</td>
    <td>!GOTO Kevin</td> 
    <td>Go to a particular user</td>
  </tr>
  <tr>
    <td>!PCLONE</td>
    <td>!PCLONE Kevin</td> 
    <td>Clone a penguin by their name</td>
  </tr>
  <tr>
    <td>!DEC</td>
    <td>!DEC</td> 
    <td>Disable/Enable cloning</td>
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
</table>

<h1>VIP Commands: </h1>
<table>
<tr>
    <th><h2>Command</h2></th>
    <th><h2>Example</h2></th> 
    <th><h2>Info</h2></th>
  </tr>        
  <td>!SPS</td>
    <td>!SPS 50</td> 
    <td>Set the penguin speed ranging from 0 to 100</td>
  </tr>
   <tr>
    <td>!SNG</td>
    <td>!SNG 0xFFD700</td> 
    <td>Set/Change your Nameglow</td>
  </tr> 
  <tr>
    <td>!SNC</td>
    <td>!SNC 0xFFD700</td> 
    <td>Set/Change your Namecolor</td>
  </tr>
   <tr>
    <td>!SBC</td>
    <td>!SBC 0xFFD700</td> 
    <td>Set/Change your Bubblecolor</td>
  </tr>
   <tr>
    <td>!SBT</td>
    <td>!SBT 0xFFD700</td> 
    <td>Set/Change your Bubbletextcolor</td>
  </tr>
   <tr>
    <td>!SRC</td>
    <td>!SRC 0xFFD700</td> 
    <td>Set/Change your ring color</td>
  </tr>
   <tr>
    <td>!SCG</td>
    <td>!SCG 0xFFD700</td> 
    <td>Set/Change your Chat Text Glow</td>
  </tr>
  <td>!PBLEND</td>
    <td>!PBLEND Invert</td> 
    <td>Blend the penguin</td>
  </tr>
  <td>!PSS</td>
    <td>!PSS 420</td> 
    <td>Change the penguin size</td>
  </tr>
  <td>!PALPHA</td>
    <td>!PALPHA 6</td> 
    <td>Change the visibility of the penguin</td>
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
  </tr> 
  <tr>
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
    <td>#SHUTDOWN</td>
    <td>#SHUTDOWN</td> 
    <td>Shutdown the server</td>
  </tr>
   <tr>
    <td>#GLOBAL</td>
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
