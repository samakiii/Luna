Luna
====

Club Penguin Server Emulator - AS2 Protocol

![Alt tag](https://github.com/Levi-M/Luna/blob/master/Screenshots/01ae9c2572c8e9b7b2092f9cf2e590f2.png)
![Alt tag](https://github.com/Levi-M/Luna/blob/master/Screenshots/118ae5a5f2fed6b4157bdb5e19b0f33a.png)
![Alt tag](https://github.com/Levi-M/Luna/blob/master/Screenshots/c67d31b1845ae286f6f80d3135f597ef.png)
![Alt tag](https://github.com/Levi-M/Luna/blob/master/Screenshots/fd4dac2adf30d0e5b0a8122d5d4c124d.png)

### Requirements:
<ul>
 <li> PHP 5.5+</li>
 <li> Perl v5.12 till v5.18</li>
 <li> reCaptcha Keys</li>
 <li> Apache2/Nginx</li>
 <li> Phpmyadmin/Adminer</li>
 <li> MySQL</li>
 <li> Internet Connection</li>
</ul>

### Instructions:
<ul>
 <li> Install PHP and setup a webserver - <a href="http://www.wikihow.com/Install-XAMPP-for-Windows">Windows</a>/<a href="https://www.rosehosting.com/blog/how-to-install-lamp-linux-apache-mysql-php-and-phpmyadmin-on-a-debian-8-vps/">Linux</a></li>
 <li> Install all the Perl modules from the <a href="https://github.com/Levi-M/Luna#modules">modules list</a></li>
 <ul>
 <li> If some modules fail to install or refuse to install then install those particular modules manually, click <a href="http://www.thegeekstuff.com/2008/09/how-to-install-perl-modules-manually-and-using-cpan-command/">here</a> to know how to do manual installation of modules or use <code>force install</code> to install them</li>
 <li> If you are still not able to install the modules by yourself, you can create an issue but do not create an issue if you did not try the above</li>
 </ul>
 <li> Setup an AS2 Media Server</li>
 <li> Import the <a href="https://github.com/Levi-M/Luna/blob/master/SQL/Database.sql">SQL</a> using <b>Phpmyadmin/Adminer</b></li>
 <li> Edit <a href="https://github.com/Levi-M/Luna/blob/master/Website/config.php">Config.php</a> and create an account</li> using the register or use the <a href="https://github.com/Levi-M/Luna/blob/master/README.md#default-server-account">default account</a>
 <li> Edit <a href="https://github.com/Levi-M/Luna/blob/master/Configuration/Config.pl">Config.pl</a></li>
 <li> Execute <a href="https://github.com/Levi-M/Luna/blob/master/Run.pm">Run.pm</a></li>
</ul>

*<b>Important Note:</b>* First install <b>CPAN</b> and after that type: ```reload cpan``` and then continue installing the other modules.

### Modules: 
<ul>
 <li> CPAN</li>
 <li> Method::Signatures</li>
 <li> Digest::MD5</li>
 <li> XML::Simple</li>
 <li> LWP::Simple</li>
 <li> Data::Alias</li>
 <li> Cwd</li>
 <li> JSON</li>
 <li> Coro</li>
 <li> DBI</li>
 <li> DBD::mysql</li>
 <li> Module::Find</li>
 <li> Array::Utils</li>
 <li> List::Util</li>
 <li> Math::Round</li>
 <li> Switch</li>
 <li> File::Fetch</li>
 <li> Lyrics::Fetcher</li>
 <li> Lyrics::Fetcher::LyricWiki</li>
 <li> Lyrics::Fetcher::AstraWeb</li>
</ul>


### Tutorials:

### VPS Setup:

To setup Luna on a VPS is very easy, since most of the VPS's come with <b>Ubuntu 14</b>, I will be using <b>Ubuntu</b> here:

First you got to setup <a href="http://howtoubuntu.org/how-to-install-lamp-on-ubuntu">LAMP</a>

Please also execute these commands after installing LAMP:

```
echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf
sudo a2enconf fqdn
sudo apt-get install php5-mysql
sudo apt-get install libmysqlclient-dev
sudo service apache2 restart
```

Then after you have done that, check the version of Perl your server comes bundled with, so open up your terminal and execute this command:

```
perl -v
```

These days your servers comes bundled with <b>Perl 5.20+</b> which is not compatible with Luna yet. So what do you got to do? Simple! Use <b>perlbrew</b>!

So open up your terminal again and run these commands:

```
sudo cpan App::perlbrew
perlbrew init
```

There we go, <b>perlbrew</b> is installed! Now lets install <b>Perl 5.14</b> and use that as the default version of Perl by running these commands:

```
perlbrew install perl-5.14.4
perlbrew switch perl-5.14.4
```

and you're done. Now before we proceed any further, lets make sure you have an updated server. So run these commands:

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get install build-essential
```

Now lets start installing the required modules for Luna, please note that some modules in the list are already pre-installed so watch what you do.

First lets initiate <b>CPAN</b>, run this command:

```
cpan
```

If you get any prompts, type <b>y</b>(yes) and hit the <b>enter</b> key on your keyboard.

Now lets first update <a>CPAN</b> by executing these commands:

```
install CPAN
reload CPAN
```

Now using the <a href="https://github.com/Levi-M/Luna#modules">modules list</a> go ahead and install each of those modules except <b>CPAN</b> since we already updated it. Usually after installing a module, it will display a status to let you know if it is installed or not so please be aware of it.

After you have done that, download <a href="https://github.com/Levi-M/Luna/archive/master.zip">Luna</a> and unzip it and store it somewhere in your server.

Now lets import the SQL onto Phpmyadmin:

<ul>
  <li>Go to <b>http://yourserverip/phpmyadmin</b> and login using your MySQL username and password</li>
  <li>Go to the <b>Import</b> tab</li>
  <li>Click <b>Browse</b>, locate Luna's SQL file, click <b>Open</b>, and then click <b>Go</b></li>
</ul>

Make sure you follow these tutorials too:

<ul>
  <li><a href="https://github.com/Levi-M/Luna#paypal">Paypal</a></li>
  <li><a href="https://github.com/Levi-M/Luna#contact-page-setup">Contact Page Setup</a></li>
</ul>

and setup a <a href="https://www.google.com/recaptcha">reCaptcha</a> account and get your keys.

Now go back to Luna's directory and open <b>/Configuration/Config.pl</b> and <b>/Website/config.php</b>

Edit your information in those files and save it.

One more thing, move the content from the <b>Website</b> folder from Luna to <b>/var/www/html/</b> and make sure to edit <b>play.php</b> too.

Last but not the least, pull up your terminal and using the ```cd``` command, navigate to Luna's directory and execute this command:

```
perl Run.pm
```

Now you should have Luna successfully running, if you want to keep Luna running 24/7 you can use <a href="https://www.howtoforge.com/linux_screen">Screen </a> or <a href="http://www.cyberciti.biz/tips/nohup-execute-commands-after-you-exit-from-a-shell-prompt.html">nohup</a>.

 

### Paypal:
*<b>Note:</b>* Click the <b>return to the merchant site</b> button after you have paid in order for the payment to go through successfully.

Follow these steps to configure your paypal account for PDT:
    
<ul>
  <li> Log in to your PayPal account</li>
  <li> Click the <b>Profile</b> subtab</li>
  <li> Click <b>Website Payment Preferences</b> in the <b>Seller Preferences</b> column</li>
  <li> Under <b>Auto Return</b> for <b>Website Payments</b>, click the <b>On</b> radio button</li>
  <li> For the <b>Return URL</b>, enter the URL on your site that will receive the transaction ID posted by PayPal after a customer payment</li>
  <li> Under <b>Payment Data Transfer</b>, click the <b>On</b> radio button</li>
  <li> Click <b>Save</b></li>
  <li> Click <b>Website Payment Preferences</b> in the <b>Seller Preferences</b> column</li>
  <li> Scroll down to the <b>Payment Data Transfer</b> section of the page to view your PDT identity token</li>
  <li> Copy and paste the token in <b>Website/config.php</b> where it says <code>$identity_token</code></li>
</ul>

### Contact Page Setup:
Make sure to setup a mail server, you can do so by following these instructions below.

Open your terminal and run this command:

```
sudo apt-get install ssmtp
```

Then open <b>/etc/ssmtp/ssmtp.conf</b> file and find and replace these lines:

```
# The place where the mail goes. The actual machine name is required no 
# MX records are consulted. Commonly mailhosts are named mail.domain.com
mailhub=
```

With this:

```
# The place where the mail goes. The actual machine name is required no 
# MX records are consulted. Commonly mailhosts are named mail.domain.com
mailhub=smtp.gmail.com:587
UseSTARTTLS=YES
UseTLS=YES
AuthUser=youremailgoeshere@gmail.com
AuthPass=yourpasswordgoeshere
```

We are going to be using gmail here as an example. If you want to change the domain, feel free to. Also dont forget to edit the <code>AuthUser</code> and <code>AuthPass</code> in the ssmtp config.

Now open your <b>php.ini</b> file which usually can be located at: <b>/etc/php5/apache2/</b>

Search for this line: 

```
;sendmail_path = 
```

Replace it with: 

```
sendmail_path = /usr/sbin/ssmtp -t
```

Next go back to the source and open <b>/Website/config.php</b>

Find this line: 

```
$strContactEmail = "you@yourdomain.com";
```

Edit that to match the one in the ssmtp config file and save it all.

Open your terminal once again and reload the apache configuration by typing the following command:

```
sudo /etc/init.d/apache2 reload
```

Last but not the least, login to your gmail account and once you're done, click this link: https://www.google.com/settings/security/lesssecureapps

Once you're at that page, turn ON the <b>lesssecureapps</b> settings and go back to the contact page and voila!

### Default Server Account:
The source comes with a default account, this account is created when you import the SQL into your database. 

<b>Username:</b> Isis<br>
<b>Password:</b> imfuckinggay<br>
