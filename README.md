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

<code>cd /tmp/Luna</code>

and then type:

<code>perl Run.pm</code>

If you are using Windows, you can use <b>Run.bat</b>

*<b>Important Note:</b>* First install <b>CPAN</b> and after that type: <code>reload cpan</code> and then continue installing the other modules.

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

*<b>Note:</b>* Click the "return to the merchant site" button after you have paid in order for the payment to go through successfully.

### Contact Page Setup

Make sure to setup a mail server, you can do so by following this:

Open your terminal and run this command:

<code>sudo apt-get install ssmpt</code>

Then edit <b>/etc/ssmtp/ssmtp.conf</b> file, comment out existing <code>mailhub</code> line and add the following lines (this example is for gmail smtp server):

<code>
mailhub=smtp.gmail.com:587
UseSTARTTLS=YES
AuthUser=youremail@gmail.com
AuthPass=yourpasswordgoeshere
</code>

Open your <b>php.ini</b> file which usually can be located at: <b>/etc/php5/apache2/</b>

Search for this line: 

<code>
;sendmail_path = 
</code>

Replace it with: 

<code>
sendmail_path = /usr/sbin/ssmtp -t
</code>

Now go back to the source and open to <b>/Website/contact.php</b>

Find this line: 

<code>
$strContactEmail = "you@yourdomain.com";
</code>

Edit that to match the one in <b>ssmpt.conf</b> and save it all

Open your terminal once again and reload the apache configuration by typing the following command:

<code>
sudo /etc/init.d/apache2 reload
</code>

Last but not the least, login to your gmail account and once you're done, click this link: https://www.google.com/settings/security/lesssecureapps

Once you're at that page, turn ON the lesssecureapps settings and go back to the contact page and voila!