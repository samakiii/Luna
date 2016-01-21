package Smartbot;

use strict;
use warnings;

use Method::Signatures;
use Switch;
use Lyrics::Fetcher;

method new($resChild) {
       my $obj = bless {}, $self;
       $obj->{child} = $resChild;
       $obj->{pluginType} = 2;
       $obj->{property} = {
              'u#se' => { 
                     handler => 'handleBotEmotions',
                     isEnabled => 1
              },
              'm#sm' => { 
                     handler => 'handleBotCommands',
                     isEnabled => 1
              },
              'u#sp' => { 
                     handler => 'handleBotFollow',
                     isEnabled => 1
              }
       };
       $self->{commands} = {
                   follow => 'handleFollow',
                   unfollow => 'handleUnfollow',
                   joke => 'handleJoke',
                   wiki => 'handleWiki',
                   sing => 'handleSing',
                   dance => 'handleDance',
                   move => 'handleMove',
                   mascot => 'handleMascot'
       };
       return $obj;
}

method handleBotEmotions($strData, $objClient) {
       my @arrData = split('%', $strData);
       my $intEmote = $arrData[5];
       my %arrEmotes = (
             1 => 'Smile', 
             2 => 'Happy', 
             7 => 'Wink',
             16 => 'Flower', 
             17 => 'Clover', 
             30 => 'Heart', 
             10 => 'Sad',
             9 => 'Mad',
             6 => 'Leave',
             19 => 'Fart',
             8 => 'Vomit',
             20 => 'Coin'
       );
       return if (!exists($arrEmotes{$intEmote}));
       my $strEmote = $arrEmotes{$intEmote};
       switch ($strEmote) {
                  case ('Smile') {
                           $objClient->sendRoom('%xt%se%-1%0%' . $intEmote . '%');
                           $self->handleSetFollow(1, $objClient);  
                           $self->handleFollowPosition($objClient, $objClient->{xpos}, $objClient->{ypos});
                  }
                  case ('Happy') {
                           $objClient->sendRoom('%xt%se%-1%0%' . $intEmote . '%');
                           $self->handleSetFollow(1, $objClient);  
                           $self->handleFollowPosition($objClient, $objClient->{xpos}, $objClient->{ypos});
                  }
                  case ('Wink') {
                           $objClient->sendRoom('%xt%se%-1%0%' . $intEmote . '%');
                           $self->handleSetFollow(1, $objClient);  
                           $self->handleFollowPosition($objClient, $objClient->{xpos}, $objClient->{ypos});
                  }
                  case ('Flower') {
                           $objClient->sendRoom('%xt%se%-1%0%2%');
                           $self->handleSetFollow(1, $objClient);  
                           $self->handleFollowPosition($objClient, $objClient->{xpos}, $objClient->{ypos});
                  }
                  case ('Clover') {
                           $objClient->sendRoom('%xt%se%-1%0%1%');
                           $self->handleSetFollow(1, $objClient);  
                           $self->handleFollowPosition($objClient, $objClient->{xpos}, $objClient->{ypos});
                  }
                  case ('Heart') {
                           $objClient->sendRoom('%xt%se%-1%0%2%');
                           $self->handleSetFollow(1, $objClient);  
                           $self->handleFollowPosition($objClient, $objClient->{xpos}, $objClient->{ypos});
                           $objClient->sendRoom('%xt%se%-1%0%30%');
                  }
                  case ('Sad') {
                           $objClient->botSay('Whats wrong? Why the sad face?');
                           $self->handleFollowPosition($objClient, $objClient->{xpos}, $objClient->{ypos});
                  }
                  case ('Mad') {
                           $objClient->botSay('Go throw your anger on someone else faggot');
                           $self->handleSetFollow(0, $objClient);  
                           $objClient->sendRoom('%xt%sp%-1%0%380%385%');
                  }
                  case ('Leave') {
                           $objClient->botSay('Oh fuck off! I dont need you');
                           $self->handleSetFollow(0, $objClient);  
                           $objClient->sendRoom('%xt%sp%-1%0%300%310%');
                  }
                  case ('Fart') {
                           $objClient->botSay('Ew What the fuck nigga, clean yo stomach');
                           $self->handleSetFollow(0, $objClient);  
                           $objClient->sendRoom('%xt%sp%-1%0%400%403%');
                  }
                  case ('Vomit') {
                           $objClient->botSay('Ohmygod ew, that is gross');
                           $self->handleSetFollow(0, $objClient);  
                           $objClient->sendRoom('%xt%sp%-1%0%420%424%');
                  }
                  case ('Coin') {
                           $objClient->botSay('Here you go my friend, spend the coins wisely');
                           $self->handleSetFollow(0, $objClient);  
                           $self->handleFollowPosition($objClient, $objClient->{xpos}, $objClient->{ypos});
                           $objClient->updateCoins(500);
                  }
       }
}


method handleBotCommands($strData, $objClient) {
            my @arrData = split('%', $strData);
            my $strMsg = $arrData[6];
            my $chrCmd = substr($strMsg, 0, 1);
            if ($chrCmd eq '~') {
               my @arrParts = split(' ', substr($strMsg, 1), 2);
               my $strCmd = lc($arrParts[0]);
               my $strArg = $arrParts[1];
               return if (!exists($self->{commands}->{$strCmd}));
               my $strHandler = $self->{commands}->{$strCmd};
               $self->$strHandler($objClient, $strArg);
            }
}

method handleBotFollow($strData, $objClient) {
            my @arrData = split('%', $strData);
            my $intX = $arrData[5];
            my $intY = $arrData[6];
            my $strUsername = $objClient->{username};
            my $arrData = $self->{child}->{modules}->{mysql}->fetchColumns("SELECT `botIsFollow` FROM users WHERE `username` = '$strUsername'");
            my $blnFollow = $arrData->{botIsFollow};
            if ($blnFollow == 1) {
                $self->handleFollowPosition($objClient, $intX, $intY);
            }
}

method handleSetFollow($blnFollow, $objClient) {
            $self->{child}->{modules}->{mysql}->updateTable('users', 'botIsFollow', $blnFollow, 'username', $objClient->{username});            
}

method handleFollowPosition($objClient, $intX, $intY) {
            $objClient->{xpos} = $intX;
            $objClient->{ypos} = $intY;
            my $intBotX = $intX - 2;
            my $intBotY = $intY - 1;
            $objClient->sendRoom('%xt%sp%-1%0%' . $intBotX . '%' . $intBotY . '%');
}

method handleFollow($objClient, $nullVar) {
            my $strUsername = $objClient->{username};
            my $arrData = $self->{child}->{modules}->{mysql}->fetchColumns("SELECT `botIsFollow` FROM users WHERE `username` = '$strUsername'");
            my $blnFollow = $arrData->{botIsFollow};
            $blnFollow ? $self->handleSetFollow(1, $objClient) : $self->handleSetFollow(0, $objClient);
}

method handleUnfollow($objClient, $nullVar) {
            my $strUsername = $objClient->{username};
            my $arrData = $self->{child}->{modules}->{mysql}->fetchColumns("SELECT `botIsFollow` FROM users WHERE `username` = '$strUsername'");
            my $blnFollow = $arrData->{botIsFollow};
            $blnFollow ? $self->handleSetFollow(0, $objClient) : $self->handleSetFollow(1, $objClient);
}

method handleJoke($objClient, $nullVar) {            
            my @arrJokes = (1, 2, 30, 17, 3, 4, 5, 7, 8, 9, 10, 26, 28, 16);
            my $intJoke = $arrJokes[rand(@arrJokes)];
            $objClient->sendRoom('%xt%sj%-1%0%' . $intJoke . '%');
}

method handleMascot($objClient, $nullVar) {
           my @arrMascots = array('candence', 'rockhopper', 'gary', 'sensei', 'auntartic', 'stompin bob');
           my $strMascotName = $arrMascots[rand(@arrMascots)];
           my $strMascot = "";
           switch ($strMascotName) {
                       case ('rockhopper') {
                                $strMascot = "5|442|152|161|0|5020|0|0|0";
                       }
                       case ('auntartic') {
                                $strMascot = "2|1044|2007|0|0|0|0|0|0";
                       }
                       case ('gary') {
                                $strMascot = "1|0|115|4022|0|0|0|0|0";
                       }
                       case ('candence') {
                                $strMascot = "10|1032|0|3011|0|5023|1033|0|0";
                       }
                       case ('sensei') {
                                $strMascot = "14|1068|2009|0|0|0|0|0|0";
                       }
                       case ('stompin bob') {
                                $strMascot = "5|1002|101|0|0|5025|0|0|0";
                       }
           }
           my @arrMascotItems = split('|', $strMascot);
           $objClient->sendRoom('%xt%upc%-1%0%' . $arrMascotItems[0] . '%');
           $objClient->sendRoom('%xt%uph%-1%0%' . $arrMascotItems[1] . '%');
           $objClient->sendRoom('%xt%upf%-1%0%' . $arrMascotItems[2] . '%');
           $objClient->sendRoom('%xt%upn%-1%0%' . $arrMascotItems[3] . '%');
           $objClient->sendRoom('%xt%upb%-1%0%' . $arrMascotItems[4] . '%');
           $objClient->sendRoom('%xt%upa%-1%0%' . $arrMascotItems[5] . '%');
           $objClient->sendRoom('%xt%upe%-1%0%' . $arrMascotItems[6] . '%');
           $objClient->sendRoom('%xt%upl%-1%0%' . $arrMascotItems[7] . '%');
           $objClient->sendRoom('%xt%upp%-1%0%' . $arrMascotItems[8] . '%');
}

method handleMove($objClient, $strArg) {
            my @arrParts = split(' ', $strArg);
            my $intBotX = $arrParts[0];
            my $intBotY = $arrParts[1];
            if (int($intBotX) && int($intBotY)) {
               $objClient->sendRoom('%xt%sp%-1%0%' . $intBotX . '%' . $intBotY . '%');
            }
}

method handleDance($objClient, $nullVar) {        
            $objClient->sendRoom('%xt%upc%-1%0%0%');
            $objClient->sendRoom('%xt%uph%-1%0%0%');
            $objClient->sendRoom('%xt%upf%-1%0%0%');
            $objClient->sendRoom('%xt%upn%-1%0%0%');
            $objClient->sendRoom('%xt%upb%-1%0%0%');
            $objClient->sendRoom('%xt%upa%-1%0%5016%');
            $objClient->sendRoom('%xt%upe%-1%0%0%');
            $objClient->sendRoom('%xt%upl%-1%0%0%');
            $objClient->sendRoom('%xt%upp%-1%0%0%');
            $objClient->botSay('Watch me break the floor bitches');
            $objClient->sendRoom('%xt%sf%-1%0%26%');
}

method handleSing($objClient, $strArg) {}
method handleWiki($objClient, $strArg) {}

1;