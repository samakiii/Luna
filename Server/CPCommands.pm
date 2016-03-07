package CPCommands;

use strict;
use warnings;

use Switch;
use Method::Signatures;
use HTML::Entities;

method new($resChild) {
       my $obj = bless {}, $self;
       $obj->{child} = $resChild;
       return $obj;
}

method handlePenguinSuperSize($objClient, $strArgs) {
       return if (!$objClient->{isVIP});
       my @arrParts = split(" ", $strArgs);  
       my $intX = $arrParts[0];
       my $intY = $arrParts[1];
       return if (!int($intX) || !int($intY) || $intX > 800 || $intY > 800);
       $objClient->sendRoom('%xt%ssp%' . $objClient->{ID} . '%' . ($intX ? $intX : 100)  . '%' . ($intY ? $intY : 100) . '%');
}

method handlePenguinBlend($objClient, $strBlend) {
       return if (!$objClient->{isVIP});
       $objClient->sendRoom('%xt%ssb%' . $objClient->{ID} . '%' . $strBlend . '%');
}

method handlePenguinAlpha($objClient, $intAlpha) {
       return if (!$objClient->{isVIP} || !int($intAlpha));
       $objClient->sendRoom('%xt%ssa%' . $objClient->{ID} . '%' . $intAlpha . '%');
}

method handleSetNameGlow($objClient, $strGlow) {
       return if (!$objClient->{isVIP} || $strGlow !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('nameglow', $strGlow);
}

method handleSetNameColour($objClient, $strNColour) {
       return if (!$objClient->{isVIP} || $strNColour !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('namecolour', $strNColour);
}

method handleSetChatGlow($objClient, $strCGGlow) {
       return if (!$objClient->{isVIP} || $strCGGlow !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('chatglow', $strCGGlow);
}

method handleSetPenguinGlow($objClient, $strGlow) {
       return if (!$objClient->{isVIP} || $strGlow !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('penguinglow', $strGlow);
}

method handleSetPenguinColor($objClient, $strColor) {
       return if (!$objClient->{isVIP} || $strColor !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('colour', $strColor);
}

method handleSetSnowballGlow($objClient, $strGlow) {
       return if (!$objClient->{isVIP} || $strGlow !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('snowballglow', $strGlow);
}

method handleSetBubbleGlow($objClient, $strGlow) {
       return if (!$objClient->{isVIP} || $strGlow !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('bubbleglow', $strGlow);
}

method handleSetMoodGlow($objClient, $strGlow) {
       return if (!$objClient->{isVIP} || $strGlow !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('moodglow', $strGlow);
}

method handleSetMoodColor($objClient, $strColor) {
       return if (!$objClient->{isVIP} || $strColor !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('moodcolor', $strColor);
}

method handlePenguinTransformation($objClient, $strName) {
       $strName = lc($strName);
       $self->handleClearPenguinClothing($objClient, '');
       $objClient->updateOpenGlow('transformation', $strName);
}

method handleSetPenguinTitle($objClient, $strTitle) {
	   return if (length($strTitle) >= 10);
       $objClient->updateOpenGlow('title', decode_entities($strTitle));
}

method handleSetPenguinTitleGlow($objClient, $strGlow) {
       return if (!$objClient->{isVIP} || $strGlow !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('titleglow', $strGlow);
}

method handleSetPenguinTitleColor($objClient, $strColor) {
       return if (!$objClient->{isVIP} || $strColor !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('titlecolor', $strColor);
}

method handleAddAllItems($objClient, $nullVar) {
	   my @arrItems = ();
	   foreach (keys %{$self->{child}->{modules}->{crumbs}->{itemCrumbs}}) {
		        push(@arrItems, $_);
	   }
	   my $strItems = join('%', @arrItems);
	   $self->{child}->{modules}->{mysql}->updateTable('users', 'inventory', $strItems, 'ID', $objClient->{ID});
	   $objClient->loadDetails;
	   $objClient->botSay($objClient->{username} . ' please re-login to the server in order for all the items to appear in your inventory');
}

method handleDisableEnableCloning($objClient, $nullVar) {
            my $arrInfo = $self->{child}->{modules}->{mysql}->fetchColumns("SELECT `isCloneable` FROM users WHERE `username` = '$objClient->{username}'");
            my $blnCloneable = $arrInfo->{isCloneable};
            if ($blnCloneable) {
                $self->{child}->{modules}->{mysql}->updateTable('users', 'isCloneable', 0, 'ID', $objClient->{ID});
                $objClient->botSay('Cloning has been disabled');
            } else {
                $self->{child}->{modules}->{mysql}->updateTable('users', 'isCloneable', 1, 'ID', $objClient->{ID});
                $objClient->botSay('Cloning has been enabled');
            }
}

method handleWalkOnWalls($objClient, $nullVar) {
            if ($objClient->{wow}) {
                $self->{child}->{modules}->{mysql}->updateTable('users', 'wow', 0, 'ID', $objClient->{ID});
                $objClient->{wow} = 0;
                $objClient->botSay('Walk on walls has been disabled');
            } else {
                $self->{child}->{modules}->{mysql}->updateTable('users', 'wow', 1, 'ID', $objClient->{ID});
                $objClient->{wow} = 1;
                $objClient->botSay('Walk on walls has been enabled');
            }
}

method handleClonePenguin($objClient, $strName) {
            my $arrInfo = $self->{child}->{modules}->{mysql}->fetchColumns("SELECT `isCloneable`, `colour`, `head`, `face`, `neck`, `body`, `hand`, `feet`, `photo`, `flag` FROM users WHERE `username` = '$strName'");
            my $blnCloneable = $arrInfo->{isCloneable};
            if ($blnCloneable) {
                $objClient->updatePlayerCard('upc', 'colour', $arrInfo->{colour});
                $objClient->updatePlayerCard('uph', 'head', $arrInfo->{head});
                $objClient->updatePlayerCard('upf', 'face', $arrInfo->{face});
                $objClient->updatePlayerCard('upn', 'neck', $arrInfo->{neck});
                $objClient->updatePlayerCard('upb', 'body', $arrInfo->{body});
                $objClient->updatePlayerCard('upa', 'hand', $arrInfo->{hand});
                $objClient->updatePlayerCard('upe', 'feet', $arrInfo->{feet});
                $objClient->updatePlayerCard('upp', 'photo', $arrInfo->{photo});
                $objClient->updatePlayerCard('upl', 'flag', $arrInfo->{flag});
            }
}

method handleClearPenguinClothing($objClient, $nullVar) {
            $objClient->updatePlayerCard('upc', 'colour', 0);
            $objClient->updatePlayerCard('uph', 'head', 0);
            $objClient->updatePlayerCard('upf', 'face', 0);
            $objClient->updatePlayerCard('upn', 'neck', 0);
            $objClient->updatePlayerCard('upb', 'body', 0);
            $objClient->updatePlayerCard('upa', 'hand', 0);
            $objClient->updatePlayerCard('upe', 'feet', 0);
            $objClient->updatePlayerCard('upp', 'photo', 0);
            $objClient->updatePlayerCard('upl', 'flag', 0);
}

method handleSetPenguinSpeed($objClient, $intSpeed) {
       return if (!$objClient->{isVIP} || !int($intSpeed) && $intSpeed < 4);
       $objClient->updateOpenGlow('speed', $intSpeed);
}

method handleSetBubbleColour($objClient, $strBColour) {
       return if (!$objClient->{isVIP} || $strBColour !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('bubblecolour', $strBColour);
} 

method handleSetBubbleText($objClient, $strText) {
       return if (!$objClient->{isVIP} || $strText !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('bubbletext', $strText);
}

method handleSetRingColour($objClient, $strRColour) {
       return if (!$objClient->{isVIP} || $strRColour !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('ringcolour', $strRColour);
}

method handleAddItem($objClient, $intItem) {
       $objClient->addItem($intItem);
}

method handleAddFurniture($objClient, $intFurniture) {
       $objClient->addFurniture($intFurniture);
}

method handleChangeIglooFloor($objClient, $intFloor) {
       $objClient->updateFloor($intFloor);
}

method handleAddIgloo($objClient, $intIgloo) {
       $objClient->addIgloo($intIgloo);
       $objClient->updateIgloo($intIgloo);
}

method handleSendPong($objClient, $nullVar) {
       $self->handleServerSay($objClient, 'pong');
}

method handleSendID($objClient, $nullVar) {
       my $strName = $objClient->{username};
       my $intID = $objClient->{ID};
       my $strMsg = $strName . ' Your ID is: ' . $intID;
       $self->handleServerSay($objClient, $strMsg);
}

method handleServerSay($objClient, $strMsg) {
       $objClient->botSay($strMsg);
}

method handleServerSayAll($objClient, $strMsg) {
       foreach (values %{$self->{child}->{clients}}) {
                $_->botSay('[' . $objClient->{username} . ']: ' . $strMsg);
       }
}


method handleAddCoins($objClient, $intCoins) {
       return if ($intCoins > 5000);
       my $intTotalCoins = $objClient->{coins} + $intCoins;
       $objClient->updateCoins($intTotalCoins);
}

method handleSendServerPopulation($objClient, $nullVar) {
       my $intCount = scalar(keys %{$self->{child}->{clients}});
       my $strMsg = '';
       if ($intCount == 1) {
           $strMsg = 'I guess its just you and me in this server';
       } else {
           $strMsg = 'There are currently ' . $intCount . ' users in this server';
       }
       $self->handleServerSay($objClient, $strMsg);
} 

method handleSendRoomPopulation($objClient, $nullVar) {
       my $intCount = $objClient->getRoomCount;
       my $strMsg = '';
       if ($intCount == 1) {
           $strMsg = 'I guess its just you and me in this room';
       } else {
           $strMsg = 'There are currently ' . $intCount . ' users in this room';
       }
       $self->handleServerSay($objClient, $strMsg);
}

method handleJoinRoom($objClient, $intRoom) {
       if ($intRoom > 0 && $intRoom < 1000) {
           $objClient->joinRoom($intRoom);
       }
}

method handleShutdownServer($objClient, $nullVar) {
       return if (!$objClient->{isAdmin});
       foreach (values %{$self->{child}->{clients}}) {
                $_->sendError(990);
                $self->{child}->{modules}->{base}->removeClient($_->{sock});
       }
}

method handleKickClient($objClient, $strName) {
       return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
       my $objPlayer = $objClient->getClientByName($strName);
       return if ($objPlayer->{rank} > 4);
       $objPlayer->sendError(610);
       $self->handleServerSay($objClient, $objClient->{username} . ' has kicked ' . $strName . ' from the server');
       $self->{child}->{modules}->{base}->removeClient($objPlayer->{sock});
}

method handleFindClient($objClient, $strName) {
       return if (uc($objClient->{username}) eq uc($strName));
       my $objPlayer = $objClient->getClientByName($strName);
       my $strRoomName = $self->{child}->{modules}->{crumbs}->{roomCrumbs}->{$objPlayer->{room}}->{name};
       my $strMsg = $strName . ' is at the ' . $strRoomName;
       $self->handleServerSay($objClient, $strMsg);
}

method handleTeleportClient($objClient, $strName) {
       return if (uc($objClient->{username}) eq uc($strName));
       my $objPlayer = $objClient->getClientByName($strName);
       $objClient->joinRoom($objPlayer->{room});
}

method handleSummonClient($objClient, $strName) {
       return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
       my $objPlayer = $objClient->getClientByName($strName);
       $objPlayer->joinRoom($objClient->{room});
}

method handleSummonAllClients($objClient, $nullVar) {
	   return if ($objClient->{rank} < 5);
	   foreach (values %{$self->{child}->{clients}}) {
		        if (uc($_->{username}) ne uc($objClient->{username})) {
					$_->joinRoom($objClient->{room});
			    }
	   }
}

method handleMirrorClient($objClient, $strName) {
            return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
            my $objPlayer = $objClient->getClientByName($strName);       
            return if ($objPlayer->{rank} > 4);     
            $self->{child}->{modules}->{mysql}->updateTable('users', 'isMirror', 1, 'ID', $objPlayer->{ID});
}

method handleUnmirrorClient($objClient, $strName) {
            return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
            my $objPlayer = $objClient->getClientByName($strName);       
            return if ($objPlayer->{rank} > 4);     
            $self->{child}->{modules}->{mysql}->updateTable('users', 'isMirror', 0, 'ID', $objPlayer->{ID});
}

method handleBanClient($objClient, $strName) {
       return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
       my $objPlayer = $objClient->getClientByName($strName);
       return if ($objPlayer->{rank} > 4);
       $objPlayer->sendError(603);
       $self->{child}->{modules}->{base}->removeClient($objPlayer->{sock});
       $self->{child}->{modules}->{mysql}->updateTable('users', 'isBanned', 'PERM', 'username', $strName);
       $objPlayer->{isBanned} = 'PERM';
       $self->handleServerSay($objClient, $objClient->{username} . ' has permanently banned ' . $strName);
}

method handleKickBanClient($objClient, $strName) {
       return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
       $self->handleKickClient($objClient, $strName);
       $self->handleBanClient($objClient, $strName);
}

method handleUnbanClient($objClient, $strName) {
       return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
       $self->{child}->{modules}->{mysql}->updateTable('users', 'isBanned', 0, 'username', $strName);
       $self->{child}->{modules}->{mysql}->updateTable('users', 'banCount', 0, 'username', $strName);
       $self->handleServerSay($objClient, $objClient->{username} . ' has unbanned ' . $strName);
}

method handleChangeNickname($objClient, $strNick) {
       if ($strNick !~ /^[a-zA-Z0-9]+$/) {
           return $objClient->sendError(441);
       }
       my $arrInfo = $self->{child}->{modules}->{mysql}->fetchColumns("SELECT `username`, `nickname` FROM users WHERE `nickname` = '$strNick'");
       my $strUCNick = uc($strNick);
       my $strDBName = uc($arrInfo->{username});
       my $strDBNick = uc($arrInfo->{nickname});
       if ($strUCNick eq $strDBName && $strDBNick eq $strUCNick) {
           return $objClient->sendError(441);
       }
       $self->{child}->{modules}->{mysql}->updateTable('users', 'nickname', $strNick, 'ID', $objClient->{ID});
       $self->handleServerSay($objClient, $objClient->{username} . ' please re-login to the game to see your new nickname');
}

method handleTimeBanClient($objClient, $strName) {
       return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
       my $objPlayer = $objClient->getClientByName($strName);
       return if ($objPlayer->{rank} > 4);
       switch ($objPlayer->{banCount}) {
               case (0) {
                     $objClient->updateBanCount($objPlayer, 1);
                     $self->{child}->{modules}->{mysql}->updateTable('users', 'isBanned', time + 86400, 'ID', $objPlayer->{ID});
                     $objPlayer->sendError(610 . '%' . 'Your account has temporarily been suspended for 24 hours by ' . $objClient->{username});
                     $self->handleServerSay($objClient, $objClient->{username} . ' has temporarily banned ' . $strName . ' for 24 hours');
                     return $self->{child}->{modules}->{base}->removeClient($objPlayer->{sock});
               }
               case (1) {
                     $objClient->updateBanCount($objPlayer, 2);
                     $self->{child}->{modules}->{mysql}->updateTable('users', 'isBanned', time + 172800, 'ID', $objPlayer->{ID});
                     $objPlayer->sendError(610 . '%' . 'Your account has been temporarily suspended for 48 hours by ' . $objClient->{username});
                     $self->handleServerSay($objClient, $objClient->{username} . ' has temporarily banned ' . $strName . ' for 48 hours');
                     return $self->{child}->{modules}->{base}->removeClient($objPlayer->{sock});
               }
               case (2) {
                     $objClient->updateBanCount($objPlayer, 3);
                     $self->{child}->{modules}->{mysql}->updateTable('users', 'isBanned', time + 259200, 'ID', $objPlayer->{ID});
                     $objPlayer->sendError(610 . '%' . 'Your account has been temporarily suspended for 72 hours by ' . $objClient->{username});
                     $self->handleServerSay($objClient, $objClient->{username} . ' has temporarily banned ' . $strName . ' for 72 hours');
                     return $self->{child}->{modules}->{base}->removeClient($objPlayer->{sock});
               } 
               case (3) {                        
                     $self->handleBanClient($objClient, $strName);
              }
       }
}

1;
