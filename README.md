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

### Contact Page Setup:

Make sure to setup a mail server, you can do so by following these instructions below.

Open your terminal and run these commands:

```
sudo apt-get install msmtp ca-certificates
sudo mkdir /etc/msmtp
sudo mkdir /var/log/msmtp
sudo touch /etc/msmtp/cpps
sudo nano /etc/msmtp/cpps
```

Then edit <b>/etc/msmtp/cpps</b> config file and add this:

```
# Define here some setting that can be useful for every account
defaults
        logfile /var/log/msmtp/general.log

# Settings for cpps account
account cpps
        protocol smtp
        host smtp.gmail.com
        tls on
        tls_trust_file /usr/share/ca-certificates/mozilla/Equifax_Secure_CA.crt
        port 587
        auth login
        user youremailgoeshere@gmail.com
        password yourpasswordgoeshere
        from youremailgoeshereagain@gmail.com
        logfile /var/log/msmtp/cpps.log

# If you don't use any "-a" parameter in your command line,
# the default account "cpps" will be used.
account default: cpps
```

We are going to be using gmail here as an example. If you want to change the domain, feel free to.

Now open your <b>php.ini</b> file which usually can be located at: <b>/etc/php5/apache2/</b>

Search for this line: 

```
;sendmail_path = 
```

Replace it with: 

```
sendmail_path = /usr/sbin/msmtp -t
```

Now go back to the source and open <b>/Website/contact.php</b>

Find this line: 

```
$strContactEmail = "you@yourdomain.com";
```

Edit that to match the one in the msmtp config file and save it all.

Open your terminal once again and reload the apache configuration by typing the following command:

```
sudo /etc/init.d/apache2 reload
```

Last but not the least, login to your gmail account and once you're done, click this link: https://www.google.com/settings/security/lesssecureapps

Once you're at that page, turn ON the <b>lesssecureapps</b> settings and go back to the contact page and voila!