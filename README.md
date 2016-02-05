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
 <li> Perl 5.12 till 5.18</li>
 <li> reCaptcha Keys</li>
 <li> Apache/Nginx</li>
 <li> Phpmyadmin/Adminer</li>
 <li> MYSQL</li>
 <li> Internet Connection</li>
</ul>

### Instructions:
<ul>
 <li> Setup an AS2 Media Server</li>
 <li> Install all the Perl modules from the <a href="https://github.com/Levi-M/Luna/blob/master/README.md#modules">modules list</a></li>
 <ul>
 <li> If some modules fail to install or refuse to install then install those particular modules manually, click <a href="http://www.thegeekstuff.com/2008/09/how-to-install-perl-modules-manually-and-using-cpan-command/">here</a> to know how to do manual installation of modules</li>
 </ul>
 <li> Import the <a href="https://github.com/Levi-M/Luna/blob/master/SQL/Database.sql">Database.sql</a> using <b>Phpmyadmin/Adminer</b></li>
 <li> Setup the <a href="https://github.com/Levi-M/Luna/blob/master/Website/">Website</a> and create an account</li> using the register or use the <a href="https://github.com/Levi-M/Luna/blob/master/README.md#default-server-account">default account</a>
 <li> Edit <a href="https://github.com/Levi-M/Luna/blob/master/Configuration/Config.pl">Config.pl</a></li>
 <li> Execute <a href="https://github.com/Levi-M/Luna/blob/master/Run.pm">Run.pm</a></li>
</ul>

### Usage:

Open <b>Terminal/Cmd</b> and type the following:

```
cd /tmp/Luna
```

and then type:

```
perl Run.pm
```

If you are using Windows, you can use <b>Run.bat</b>

*<b>Important Note:</b>* First install <b>CPAN</b> and after that type: ```reload cpan``` and then continue installing the other modules.

### Modules: 
<ul>
 <li> CPAN</li>
 <li> Method::Signatures</li>
 <li> HTML::Entities</li>
 <li> IO::Socket</li>
 <li> IO::Select</li>
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
 <li> HTTP::Date</li>
 <li> Math::Round</li>
 <li> POSIX</li>
 <li> Switch</li>
 <li> File::Basename</li>
 <li> File::Fetch</li>
 <li> Lyrics::Fetcher</li>
 <li> Lyrics::Fetcher::LyricWiki</li>
 <li> Lyrics::Fetcher::AstraWeb</li>
 <li> LWP::UserAgent</li>
 <li> URI::Escape</li>
</ul>

### Tutorials:
<ul>
 <li><a href="https://www.google.com/recaptcha/intro/index.html">reCaptcha(Required)</a></li>
 <li><a href="https://www.apachefriends.org/">Install XAMPP - Windows Users</a></li>
 <li><a href="https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu">Install LAMP - Linux Users</a></li>
 <li><a href="http://learn.perl.org/installing/">How to install Perl</a></li>
 <li><a href="http://perlmaven.com/how-to-install-a-perl-module-from-cpan">How to install Perl modules</a></li>
 <li><a href="http://nginx.org/en/docs/install.html">How to install Nginx(Optional)</a></li>
 <li><a href="http://www.adminer.org/">How to install Adminer(Optional)</a></li>
</ul>

*<b>Note:</b>* Windows users please do not install Perl when installing XAMPP. Also it is recommended that you install Active State Perl instead of Strawberry Perl.

### Default Server Account:

The source now comes with a default account, this account is created when you import the SQL into your database. 

<b>Username:</b> Isis<br>
<b>Password:</b> imfuckinggay<br>

### Paypal:

*<b>Note:</b>* Click the <b>return to the merchant site</b> button after you have paid in order for the payment to go through successfully.

Follow these steps to configure your paypal account for PDT:
    
<ul>
<li>Log in to your PayPal account</li>
<li>Click the Profile subtab</li>
<li>Click Website Payment Preferences in the Seller Preferences column</li>
<li>Under Auto Return for Website Payments, click the On radio button</li>
<li>For the Return URL, enter the URL on your site that will receive the transaction ID posted by PayPal after a customer payment</li>
<li>Under Payment Data Transfer, click the On radio button</li>
<li>Click Save</li>
<li>Click Website Payment Preferences in the Seller Preferences column</li>
<li>Scroll down to the Payment Data Transfer section of the page to view your PDT identity token</li>
<li>Copy and paste the token in <b>Website/config.php</b> where it says <code>$identity_token</code></li>
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

We are going to be using gmail here as an example. If you want to change the domain, feel free to. Also dont forget to edit the AuthUser and AuthPass in the ssmtp config.

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