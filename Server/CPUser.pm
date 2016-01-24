package CPUser;

use strict;
use warnings;

use Method::Signatures;
use HTTP::Date qw(str2time);
use Math::Round qw(round);
use HTML::Entities;
use List::Util qw(first);
use Switch;

method new($resParent, $resSock) {
       my $obj = bless {}, $self;
       $obj->{parent} = $resParent;
       $obj->{sock} = $resSock;
       $obj->{username} = '';            
       $obj->{ID} = 0;
       $obj->{ipAddr} = '';
       $obj->{loginKey} = '';
       $obj->{coins} = 0;
       $obj->{rank} = 1;
       $obj->{age} = 0;
       $obj->{active} = 0;
       $obj->{isMuted} = 0;
       $obj->{isBanned} = 0;
       $obj->{isVIP} = 0;
       $obj->{isStaff} = 0;
       $obj->{isAdmin} = 0;
       $obj->{isAuth} = 0;
       $obj->{bitMask} = 1;
       $obj->{banCount} = 0;
       $obj->{invalidLogins} = 0;
       $obj->{colour} = 0;
       $obj->{head} = 0;
       $obj->{face} = 0;
       $obj->{neck} = 0;
       $obj->{body} = 0;
       $obj->{hand} = 0;
       $obj->{feet} = 0;
       $obj->{flag} = 0;
       $obj->{photo} = 0;
       $obj->{isEPF} = 0;
       $obj->{epfPoints} = 0;
       $obj->{totalEPFPoints} = 0;
       $obj->{fieldOPStatus} = 0;
       $obj->{room} = 0;
       $obj->{frame} = 0;
       $obj->{xpos} = 0;
       $obj->{ypos} = 0;
       $obj->{igloo} = 0;
       $obj->{floor} = 0;
       $obj->{music} = 0;
       $obj->{furniture} = '';
       $obj->{cover} = '';
       $obj->{buddies} = {};
       $obj->{ignored} = {};
       $obj->{inventory} = [];
       $obj->{ownedIgloos} = [];
       $obj->{stamps} = [];
       $obj->{restamps} = [];
       $obj->{ownedFurns} = {};
       $obj->{buddyRequests} = {};
       $obj->{tableID} = 0;
       $obj->{waddleID} = 0;
       $obj->{seatID} = 999;
       $obj->{mood} = ''; 
       $obj->{speed} = 4;
       $obj->{namecolour} = '';
       $obj->{nameglow} = '';
       $obj->{bubbletext} = '';
       $obj->{bubblecolour} = '';
       $obj->{ringcolour} = '';      
       $obj->{penguin_size} = 0;
       $obj->{penguin_blend} = '';
       $obj->{penguin_alpha} = 0;
       $obj->{isMirror} = 0;
       return $obj;
}

method sendXT(\@arrArgs) {
       my $strPacket = '%xt%';
       $strPacket .= join('%', @arrArgs) . '%';
       $self->write($strPacket);
}

method write($strData) {
       if ($self->{sock}->connected) {
           send($self->{sock}, $strData . chr(0), 0);
       }
       if ($self->{parent}->{servConfig}->{debugging}) {
           $self->{parent}->{modules}->{logger}->output('Packet Sent: ' . $strData, Logger::LEVELS->{dbg});        
       }
}

method sendRoom($strData) {
       foreach (values %{$self->{parent}->{clients}}) {
                if ($_->{room} == $self->{room}) {
                    $_->write($strData);
                }
       }
}

method loadDetails {
       my $arrInfo = $self->{parent}->{modules}->{mysql}->fetchColumns("SELECT * FROM users WHERE `ID` = '$self->{ID}'"); 
       while (my ($key, $value) = each(%{$arrInfo})) {
              switch ($key) {
                      case ('age') {
                            $self->{age} = round((time - str2time($value)) / 86400);
                      }
                      case ('buddies') {
                            my @buddies = split(',', $value);
                            foreach (@buddies) {
                                     my ($userID, $username) = split('\\|', $_);
                                     $self->{buddies}->{$userID} = $username;
                            }
                      }
                      case ('ignored') {
                            my @ignored = split(',', $value);
                            foreach (@ignored) {
                                     my ($userID, $username) = split('\\|', $_);
                                     $self->{ignored}->{$userID} = $username;
                            }
                      }
                      case ('inventory') {
                            my @items = split('%', $value);
                            foreach (@items) {
                                     push(@{$self->{inventory}}, $_);
                            }
                      }
                      case ('stamps') {
                            my @stamps = split('\\|', $value);
                            foreach (@stamps) {
                                     push(@{$self->{stamps}}, $_);
                            }
                      }
                      case ('restamps') {
                            my @restamps = split('\\|', $value);
                            foreach (@restamps) {
                                     push(@{$self->{restamps}}, $_);
                            }
                      } else {
                            $self->{$key} = $value;
                      }
              }
       }   
       my $arrIglooInfo = $self->{parent}->{modules}->{mysql}->fetchColumns("SELECT * FROM igloos WHERE `ID` = '$self->{ID}'"); 
       while (my ($key, $value) = each(%{$arrIglooInfo})) {
              switch ($key) {
                      case ('ownedIgloos') {
                            my @igloos = split('\\|', $value);
                            foreach (@igloos) {
                                     push(@{$self->{ownedIgloos}}, $_);
                            }
                      }
                      case ('ownedFurns') {
                            my @furnitures = split(',', $value);
                            foreach (@furnitures) {
                                     my ($furnID, $furnQuantity) = split('\\|', $_);
                                     $self->{ownedFurns}->{$furnID} = $furnQuantity;
                            }
                      } else {
                            $self->{$key} = $value;
                      }
              }
       }
}

method buildClientString {
       my @arrInfo = (
                   $self->{ID}, # 0
                   $self->{username}, # 1
                   $self->{bitMask}, # 2
                   $self->{colour}, # 3
                   $self->{head},  # 4
                   $self->{face}, # 5
                   $self->{neck}, # 6
                   $self->{body}, # 7
                   $self->{hand}, # 8
                   $self->{feet}, # 9
                   $self->{flag}, # 10
                   $self->{photo},  # 11
                   $self->{xpos}, # 12
                   $self->{ypos},  # 13
                   $self->{frame}, 1, # 14 & 15
                   $self->{rank} * 146, # 16
                   $self->{nameglow}, # 17
                   $self->{namecolour},  # 18
                   $self->{bubblecolour}, # 19
                   $self->{bubbletext},# 20
                   $self->{ringcolour}, # 21
                   $self->{speed}, # 22
                   $self->{rank} * 146, # 23
                   $self->{mood},  # 24   
                   $self->{penguin_alpha},  # 25  
                   $self->{penguin_blend},  # 26
                   $self->{penguin_size}  # 27 
       );
       my $strInfo = join('|', @arrInfo);
       return $strInfo;
}

method buildBotString {
       my @arrInfo = (
                   $self->{parent}->{servConfig}->{botProp}->{botID},
                   $self->{parent}->{servConfig}->{botProp}->{botName},
                   $self->{parent}->{servConfig}->{botProp}->{bitMask},
                   $self->{parent}->{servConfig}->{botProp}->{botColour},
                   $self->{parent}->{servConfig}->{botProp}->{botHead},
                   $self->{parent}->{servConfig}->{botProp}->{botFace},
                   $self->{parent}->{servConfig}->{botProp}->{botNeck},
                   $self->{parent}->{servConfig}->{botProp}->{botBody},
                   $self->{parent}->{servConfig}->{botProp}->{botHand},
                   $self->{parent}->{servConfig}->{botProp}->{botFeet},
                   $self->{parent}->{servConfig}->{botProp}->{botFlag},
                   $self->{parent}->{servConfig}->{botProp}->{botPhoto},
                   $self->{parent}->{servConfig}->{botProp}->{botXPos},
                   $self->{parent}->{servConfig}->{botProp}->{botYPos},
                   $self->{parent}->{servConfig}->{botProp}->{botFrame},
                   $self->{parent}->{servConfig}->{botProp}->{botMember},
                   $self->{parent}->{servConfig}->{botProp}->{botRank},
                   $self->{parent}->{servConfig}->{botProp}->{botNameGlow},
                   $self->{parent}->{servConfig}->{botProp}->{botNameColour},
                   $self->{parent}->{servConfig}->{botProp}->{botBubbleColour},
                   $self->{parent}->{servConfig}->{botProp}->{botBubbleText},
                   $self->{parent}->{servConfig}->{botProp}->{botRingColour},
                   $self->{parent}->{servConfig}->{botProp}->{botSpeed},
                   $self->{parent}->{servConfig}->{botProp}->{botRank},
                   $self->{parent}->{servConfig}->{botProp}->{botMood},
       );
       my $strInfo = join('|', @arrInfo);
       return $strInfo;
}

method getClientByID($intPID) {
       return if (!int($intPID));
       foreach (values %{$self->{parent}->{clients}}) {
                if ($_->{ID} == $intPID) {
                    return $_;
                }
	      }
}

method getClientByName($strName) {
       return if (!$strName);
       foreach (values %{$self->{parent}->{clients}}) {
                if (lc($_->{username}) eq lc($strName)) {
                    return $_;
                }
	      }
}

method sendError($intError) {
       $self->write('%xt%e%-1%' . $intError . '%');
}

method updateCoins($intCoins) {
       return if (!int($intCoins));
       $self->sendXT(['zo', '-1', $intCoins]);
       $self->{parent}->{modules}->{mysql}->updateTable('users', 'coins', $intCoins, 'ID', $self->{ID});
       $self->{coins} = $intCoins;
}

method setCoins($intCoins) {
       return if (!int($intCoins));
       $self->{parent}->{modules}->{mysql}->updateTable('users', 'coins', $intCoins, 'ID', $self->{ID});
       $self->{coins} = $intCoins;
}

method updateIP($ipAddr) {
       return if (!$ipAddr);
       $self->{parent}->{modules}->{mysql}->updateTable('users', 'ipAddr', $ipAddr, 'ID', $self->{ID});
}

method updateKey($strKey, $strName) {
       return if (!$strName);
       $self->{parent}->{modules}->{mysql}->updateTable('users', 'loginKey', $strKey, 'username', $strName);
}

method updateInvalidLogins($intCount, $strName) {
       return if (!int($intCount) && !$strName);
       $self->{parent}->{modules}->{mysql}->updateTable('users', 'invalidLogins', $intCount, 'username', $strName);
}

method updatePlayerCard($strData, $strType, $intItem) {
       return if (!$strData && !$strType && !int($intItem));
       $self->sendRoom('%xt%' . $strData . '%-1%' . $self->{ID} . '%' . $intItem . '%');
       $self->{parent}->{modules}->{mysql}->updateTable('users', $strType, $intItem, 'ID', $self->{ID});
       $self->{$strType} = $intItem;
}

method updateOpenGlow($strType, $mixData) {
       return if (!$strType);
       $self->{parent}->{modules}->{mysql}->updateTable('users', $strType, $mixData, 'ID', $self->{ID});
       $self->{$strType} = $mixData;
       $self->sendRoom('%xt%up%-1%' . $self->buildClientString . '%');
}

method throwSnowball($intX, $intY) {
       return if (!int($intX) && !int($intY));
       $self->sendRoom('%xt%sb%-1%' . $self->{ID} . '%' . $intX . '%' . $intY . '%');
}

method sendJoke($intJoke) {
       return if (!int($intJoke));
       $self->sendRoom('%xt%sj%-1%' . $self->{ID} . '%' . $intJoke . '%');
}

method sendEmote($intEmote) {
       return if (!int($intEmote));
       $self->sendRoom('%xt%se%-1%' . $self->{ID} . '%' . $intEmote . '%');
}

method sendTourMsg($intMsg) {
       return if (!int($intMsg));
       $self->sendRoom('%xt%sg%-1%' . $self->{ID} . '%' . $intMsg . '%');
}

method sendSafeMsg($intMsg) {
       return if (!int($intMsg));
       $self->sendRoom('%xt%ss%-1%' . $self->{ID} . '%' . $intMsg . '%');    
}

method sendMascotMsg($intMsg) {
       return if (!int($intMsg));
       $self->sendRoom('%xt%sma%-1%' . $self->{ID} . '%' . $intMsg . '%');
}

method sendMessage($strMsg) {
       if (!$self->{isMuted} && $strMsg ne '') {
           if (!$self->{isMirror}) {
                $self->sendRoom('%xt%sm%-1%' .  $self->{ID} . '%' . decode_entities($strMsg) . '%');
           } else {
                $self->sendRoom('%xt%sm%-1%' .  $self->{ID} . '%' . decode_entities(reverse($strMsg)) . '%');
           }
       }
}

method getLatestRevision {
       $self->sendXT(['glr', '-1', 3555]);
}

method getPlayer($intPID) {
       return if (!int($intPID));
       my $dbInfo = $self->{parent}->{modules}->{mysql}->fetchColumns("SELECT `ID`, `nickname`, `bitMask`, `colour`, `face`, `body`, `feet`, `hand`, `neck`, `head`, `flag`, `photo`, `rank` FROM users WHERE `ID` = '$intPID'");
       my @arrDetails = ($dbInfo->{ID}, $dbInfo->{nickname}, $dbInfo->{bitMask}, $dbInfo->{colour}, $dbInfo->{head}, $dbInfo->{face}, $dbInfo->{neck}, $dbInfo->{body}, $dbInfo->{hand}, $dbInfo->{feet}, $dbInfo->{flag}, $dbInfo->{photo}, $dbInfo->{rank} * 146);
       $self->sendXT(['gp', '-1', $intPID, join('|', @arrDetails)]);
}

method sendHeartBeat {
       $self->sendXT(['h', '-1']);
}

method setPosition($intX, $intY) {
       return if (!int($intX) && !int($intY));
       $self->sendRoom('%xt%sp%-1%' . $self->{ID} . '%' . $intX . '%' . $intY . '%');
       $self->{xpos} = $intX;
       $self->{ypos} = $intY;
}

method setFrame($intFrame) {
       return if (!int($intFrame));
       $self->sendRoom('%xt%sf%-1%' . $self->{ID} . '%' . $intFrame . '%');
       $self->{frame} = $intFrame;
}

method setAction($intAction) {
       return if (!int($intAction));
       $self->sendRoom('%xt%sa%-1%' . $self->{ID} . '%' . $intAction . '%');
}

method removePlayer {
       $self->sendRoom('%xt%rp%-1%' . $self->{ID} . '%');
}

method joinRoom($intRoom, $intX = 0, $intY = 0) {
       return if (!int($intRoom) && !int($intX) && !int($intY));
       $self->removePlayer;
       if (exists($self->{parent}->{modules}->{crumbs}->{gameRoomCrumbs}->{$intRoom})) {  
           $self->{room} = $intRoom;
           return $self->sendXT(['jg', '-1', $intRoom]);
       } elsif (exists($self->{parent}->{modules}->{crumbs}->{roomCrumbs}->{$intRoom}) || $intRoom > 1000) {
                $self->{room} = $intRoom;
                $self->{xpos} = $intX;
                $self->{ypos} = $intY;
                if ($intRoom <= 899 && $self->getRoomCount >= $self->{parent}->{modules}->{crumbs}->{roomCrumbs}->{$intRoom}->{limit}) {
                    return $self->sendError(210);
                }
                my $strData = '%xt%jr%-1%'  . $intRoom . '%' . $self->buildRoomString;  
                $self->write($strData);
                $self->sendRoom('%xt%ap%-1%' . $self->buildClientString . '%');
       }
}

method addItem($intItem) { 
       return if (!int($intItem));
       if (!exists($self->{parent}->{modules}->{crumbs}->{itemCrumbs}->{$intItem})) {
	          return $self->sendError(402);
       } elsif (first {$_ == $intItem} @{$self->{inventory}}) {
	          return $self->sendError(400);
       } elsif ($self->{coins} < $self->{parent}->{modules}->{crumbs}->{itemCrumbs}->{$intItem}->{cost}) {
	          return $self->sendError(401);
       }    
       push(@{$self->{inventory}}, $intItem);
       $self->{parent}->{modules}->{mysql}->updateTable('users', 'inventory', join('%', @{$self->{inventory}}) , 'ID', $self->{ID});
       $self->setCoins($self->{coins} - $self->{parent}->{modules}->{crumbs}->{itemCrumbs}->{$intItem}->{cost});
       $self->sendXT(['ai', '-1', $intItem, $self->{coins}]);
}

method addStamp($intStamp) {
       return if (!int($intStamp));
       return if (!exists($self->{parent}->{modules}->{crumbs}->{stampCrumbs}->{$intStamp}));
       return if (first {$_ == $intStamp} @{$self->{stamps}});
       push(@{$self->{stamps}}, $intStamp);
       push(@{$self->{restamps}}, $intStamp);
       $self->{parent}->{modules}->{mysql}->updateTable('users', 'stamps', join('|', @{$self->{stamps}}), 'ID', $self->{ID});
       $self->{parent}->{modules}->{mysql}->updateTable('users', 'restamps', join('|', @{$self->{restamps}}), 'ID', $self->{ID});
       $self->sendXT(['aabs', '-1', $intStamp]);
}

method updateEPF($blnEpf) {
       return if (!int($blnEpf));
       $self->{parent}->{modules}->{mysql}->updateTable('users', 'isEPF', $blnEpf, 'ID', $self->{ID});
       $self->{isEPF} = $blnEpf;
}

method handleBuddyOnline {
       foreach (keys %{$self->{buddies}}) {
                if ($self->getOnline($_)) {
                    my $objPlayer = $self->getClientByID($_);
                    $objPlayer->sendXT(['bon', '-1', $self->{ID}]);
                }
       }
}

method handleBuddyOffline {
       foreach (keys %{$self->{buddies}}) {
                if ($self->getOnline($_)) {
                    my $objPlayer = $self->getClientByID($_);
                    $objPlayer->sendXT(['bof', '-1', $self->{ID}]);
                }
       }
}

method updateOPStat($blnStat) {
       return if (!int($blnStat));
       $self->{parent}->{modules}->{mysql}->updateTable('users', 'fieldOPStatus', $blnStat, 'ID', $self->{ID});
       $self->{fieldOPStatus} = $blnStat;
}

method buildRoomString {
       my $userList = $self->buildClientString . '%';
       foreach (values %{$self->{parent}->{clients}}) {
                if ($_->{room} == $self->{room} && $_->{ID} ne $self->{ID}) {
                    $userList .= $_->buildClientString . '%';
                }
       }
       if ($self->{parent}->{servConfig}->{botProp}->{onServ}) {
           $userList .= $self->buildBotString . '%';
       }
       return $userList;
}

method updateEPFPoints($intPoints) {
       return if (!int($intPoints));
       $self->{parent}->{modules}->{mysql}->updateTable('users', 'epfPoints', $intPoints, 'ID', $self->{ID});
       $self->{epfPoints} = $intPoints;
}

method getRoomCount {
       my $intCount = 0;
       foreach (values %{$self->{parent}->{clients}}) {
                if ($_->{room} == $self->{room}) {
                    $intCount++;
                }
       }
       return $intCount;
}

method getOnline($intPID) {
       return if (!int($intPID));
       foreach (values %{$self->{parent}->{clients}}) {
                if ($_->{ID} == $intPID) {
                    return 1;
                }
       }
       return 0;
}

method addIgloo($intIgloo) {
       return if (!int($intIgloo));
       if (!exists($self->{parent}->{modules}->{crumbs}->{iglooCrumbs}->{$intIgloo})) {
	          return $self->sendError(402);
       } elsif (first {$_ == $intIgloo} @{$self->{ownedIgloos}}) {
	          return $self->sendError(400);
       } elsif ($self->{coins} < $self->{parent}->{modules}->{crumbs}->{iglooCrumbs}->{$intIgloo}->{cost}) {
	          return $self->sendError(401);
       }   
       push(@{$self->{ownedIgloos}}, $intIgloo); 
       $self->updateIglooInventory(join('|', @{$self->{ownedIgloos}}));
       $self->setCoins($self->{coins} - $self->{parent}->{modules}->{crumbs}->{iglooCrumbs}->{$intIgloo}->{cost});
       $self->sendXT(['au', '-1', $intIgloo, $self->{coins}]);
}

method addFurniture($intFurn) {
       return if (!int($intFurn));
       if (!exists($self->{parent}->{modules}->{crumbs}->{furnitureCrumbs}->{$intFurn})) {
           return $self->sendError(402);
       } elsif ($self->{coins} < $self->{parent}->{modules}->{crumbs}->{furnitureCrumbs}->{$intFurn}->{cost}) {
           return $self->sendError(401);
       }
       my $quantity = 1;
       if (exists($self->{ownedFurns}->{$intFurn})) {
           $quantity += $self->{ownedFurns}->{$intFurn};           
       }
       $self->{ownedFurns}->{$intFurn} = $quantity;  
       my $strFurns = join(',', map { $_ . '|' . $self->{ownedFurns}->{$_}; } keys %{$self->{ownedFurns}});
       $self->updateFurnInventory($strFurns);
       $self->setCoins($self->{coins} - $self->{parent}->{modules}->{crumbs}->{furnitureCrumbs}->{$intFurn}->{cost});
       $self->sendXT(['af', '-1', $intFurn, $self->{coins}]);
}

method openIgloo {
       $self->{parent}->{igloos}->{$self->{ID}} = $self->{username};
}

method closeIgloo {
       delete($self->{parent}->{igloos}->{$self->{ID}});
}

method updateFurnInventory($strFurns) {
       $self->{parent}->{modules}->{mysql}->updateTable('igloos', 'ownedFurns', $strFurns, 'ID', $self->{ID});
}

method updateIglooInventory($strIgloos) {
       $self->{parent}->{modules}->{mysql}->updateTable('igloos', 'ownedIgloos', $strIgloos, 'ID', $self->{ID});
}

method updateFurniture($strFurn) {
       $self->{parent}->{modules}->{mysql}->updateTable('igloos', 'furniture', $strFurn, 'ID', $self->{ID});
}

method updateIgloo($intIgloo) {
       return if (!int($intIgloo));
       $self->{igloo} = $intIgloo;
       $self->{parent}->{modules}->{mysql}->updateTable('igloos', 'igloo', $intIgloo, 'ID', $self->{ID});
       $self->sendXT(['ao', '-1', $intIgloo, $self->{coins}]);
}

method updateFloor($intFloor) {
       return if (!int($intFloor));
       if (!exists($self->{parent}->{modules}->{crumbs}->{floorCrumbs}->{$intFloor})) {
           return $self->sendError(402);
       } elsif ($self->{coins} < $self->{parent}->{modules}->{crumbs}->{floorCrumbs}->{$intFloor}->{cost}) {
           return $self->sendError(401);
       }
       $self->{floor} = $intFloor;
       $self->{parent}->{modules}->{mysql}->updateTable('igloos', 'floor', $intFloor, 'ID', $self->{ID});
       $self->setCoins($self->{coins} - $self->{parent}->{modules}->{crumbs}->{floorCrumbs}->{$intFloor}->{cost});
       $self->sendXT(['ag', '-1', $intFloor, $self->{coins}]);
}

method updateMusic($intMusic) {
       return if (!int($intMusic));
       $self->{music} = $intMusic;
       $self->{parent}->{modules}->{mysql}->updateTable('igloos', 'music', $intMusic, 'ID', $self->{ID});
       $self->sendXT(['um', '-1', $intMusic]);
}

method botSay($strMsg) {
       if ($strMsg ne '') {
           $self->sendRoom('%xt%sm%-1%0%' . decode_entities($strMsg) . '%');
       }
}

method addPuffle($puffleType, $puffleName) {
       return if (!int($puffleType) && !$puffleName);
       my $puffleID = $self->{parent}->{modules}->{mysql}->insertData('puffles', ['ownerID', 'puffleName', 'puffleType'], [$self->{ID}, $puffleName, $puffleType]);
       $self->setCoins($self->{coins} - 800);
       my $petString = $puffleID . '|' . $puffleName . '|' . $puffleType . '|100|100|100';
       return $petString;
}

method getPuffles($userID) {
       my $puffles = '';
       my $arrInfo = $self->{parent}->{modules}->{mysql}->fetchAll("SELECT * FROM puffles WHERE `ownerID` = '$userID'");
       foreach (values @{$arrInfo}) {
                $puffles .= $_->{puffleID} . '|' . $_->{puffleName} . '|' . $_->{puffleType} . '|' . $_->{puffleEnergy} . '|' . $_->{puffleHealth} . '|' . $_->{puffleRest} . '%';
       }
       return substr($puffles, 0, -1);
}

method getPuffle($intPuffle) {
       my $petDetails = $self->{parent}->{modules}->{mysql}->fetchColumns("SELECT * FROM puffles WHERE `puffleID` = '$intPuffle' AND `ownerID` = '$self->{ID}'");
       my $petString = '';
       $petString .= $petDetails->{puffleID} . '|';
       $petString .= $petDetails->{puffleName} . '|';
       $petString .= $petDetails->{puffleType} . '|';
       $petString .= $petDetails->{puffleHealth} . '|';
       $petString .= $petDetails->{puffleEnergy} . '|';
       $petString .= $petDetails->{puffleRest} . '%';
       return $petString;
}

method getPostcards($intPID) {
       return if (!int($intPID));
       my $strCards = '';
       my $arrCards = $self->{parent}->{modules}->{mysql}->fetchAll("SELECT * FROM postcards WHERE `recepient` = '$intPID'");
       my $intCount = 0;
       foreach (values @{$arrCards}) {
                $intCount++;
                $strCards .= $_->{mailerName} . '|' . $_->{mailerID} . '|' . $_->{postcardType} . '|' . $_->{notes} . '|' . $_->{timestamp} . '|' . $intCount . '%';
       }
       return $strCards;
}

method getUnreadPostcards($intPID) {
       return if (!int($intPID));
       my $unreadCount = $self->{parent}->{modules}->{mysql}->countRows("SELECT `isRead` FROM postcards WHERE `recepient` = '$intPID' AND `isRead` = '0'");
       return $unreadCount;
}

method getPostcardCount($intPID) {
       return if (!int($intPID));
       my $intCount = $self->{parent}->{modules}->{mysql}->countRows("SELECT `recepient` FROM postcards WHERE `recepient` = '$intPID'");
       return $intCount;
}

method sendPostcard($recepient, $mailerName = 'Server', $mailerID = 0, $notes = 'Cool', $type = 1, $timestamp = time) {
       my $postcardID = $self->{parent}->{modules}->{mysql}->insertData('postcards', ['recepient', 'mailerName', 'mailerID', 'notes', 'postcardType', 'timestamp'], [$recepient, $mailerName, $mailerID, $notes, $type, $timestamp]);
       return $postcardID;
}

method updateMute($objClient, $blnMute) {
       return if (!int($blnMute));
       $self->{parent}->{modules}->{mysql}->updateTable('users', 'isMuted', $blnMute, 'ID', $objClient->{ID});
       $objClient->{isMuted} = $blnMute;
}

method updateBan($objClient, $strBan) {
       $self->{parent}->{modules}->{mysql}->updateTable('users', 'isBanned', $strBan, 'ID', $objClient->{ID});
       $objClient->{isBanned} = $strBan;   
}

method updateBanCount($objClient, $intCount) {
       return if (!int($intCount));
       $self->{parent}->{modules}->{mysql}->updateTable('users' , 'banCount', $intCount, 'ID', $objClient->{ID});
       $objClient->{banCount} = $intCount;
}

method setLastLogin($time = time) {
       return if (!int($time));
       $self->{parent}->{modules}->{mysql}->execQuery("UPDATE users SET `LastLogin` = FROM_UNIXTIME($time) WHERE `ID` = '$self->{ID}'");
}

method changePuffleStats($intPuffle, $strType, $intCount, $blnInc = 1) {
       my $arrInfo = $self->{parent}->{modules}->{mysql}->fetchColumns("SELECT $strType FROM puffles WHERE `puffleID` = '$intPuffle' AND `ownerID` = '$self->{ID}'");
       my $intStat = $arrInfo->{$strType};
       $blnInc ? ($intStat += $intCount) : ($intStat -= $intCount);
       $intStat > 100 ? ($intStat -= ($intStat - 100)) : $intStat;
       $self->{parent}->{modules}->{mysql}->execQuery("UPDATE puffles SET `$strType` = '$intStat' WHERE `puffleID` = '$intPuffle' AND `ownerID` = '$self->{ID}'");
}

method changeRandPuffStat($intPuffle) { # I dont even know if this is the proper way lol
       my $arrInfo = $self->{parent}->{modules}->{mysql}->fetchColumns("SELECT * FROM puffles WHERE `puffleID` = '$intPuffle' AND `ownerID` = '$self->{ID}'");
       my $intRandHealth = $self->{parent}->{modules}->{crypt}->generateInt(1, 10);
       my $intRandEnergy = $self->{parent}->{modules}->{crypt}->generateInt(1, 10);
       my $intRandRest = $self->{parent}->{modules}->{crypt}->generateInt(1, 10);
       my $intNewHealth = $arrInfo->{puffleHealth} - $intRandHealth;
       my $intNewEnergy = $arrInfo->{puffleEnergy} - $intRandEnergy;
       my $intNewRest = $arrInfo->{puffleRest} - $intRandRest;
       $self->{parent}->{modules}->{mysql}->execQuery("UPDATE puffles SET `puffleHealth` = '$intNewHealth' WHERE `puffleID` = '$intPuffle' AND `ownerID` = '$self->{ID}'");
       $self->{parent}->{modules}->{mysql}->execQuery("UPDATE puffles SET `puffleEnergy` = '$intNewEnergy' WHERE `puffleID` = '$intPuffle' AND `ownerID` = '$self->{ID}'");
       $self->{parent}->{modules}->{mysql}->execQuery("UPDATE puffles SET `puffleRest` = '$intNewRest' WHERE `puffleID` = '$intPuffle' AND `ownerID` = '$self->{ID}'");
}

method updatePuffleStatistics {
       my $intLastLogin = $self->{parent}->{modules}->{mysql}->fetchColumns("SELECT UNIX_TIMESTAMP(LastLogin) FROM users WHERE `ID` = '$self->{ID}'")->{'UNIX_TIMESTAMP(LastLogin)'};
       my $intTime = time - 432000;
       my $intRand = $self->{parent}->{modules}->{crypt}->generateInt(0, 4);
       my $blnMajor = 0;
       if ($intLastLogin ne 0) {
           my $intSubtract = $intLastLogin - $intTime;
           $blnMajor = $intSubtract < 0;
       }
       my $puffles = $self->{parent}->{modules}->{mysql}->fetchAll("SELECT * FROM puffles WHERE `ownerID` = '$self->{ID}'");
       foreach (values @{$puffles}) {
                my $intPuffle = $_->{puffleID};
                my $intMin = $blnMajor ? 25 : 0;
                my $intMax = $blnMajor ? 45 : 15;
                my $intHealth = $_->{puffleHealth} - $self->{parent}->{modules}->{crypt}->generateInt($intMin, $intMax);
                if ($intHealth <= 5) {
                    $self->{parent}->{modules}->{mysql}->execQuery("DELETE FROM puffles WHERE `puffleID` = '$intPuffle' AND `ownerID` = '$self->{ID}'");
                    my $postcardID = $self->sendPostcard($self->{ID}, 'sys', 0, $_->{puffleName}, 10 . $_->{puffleType});
                    $self->sendXT(['mr', '-1', 'sys', 0, 10 . $_->{puffleType}, $_->{puffleName}, time, $postcardID]);
                } else {
                    my $intHunger = $_->{puffleEnergy} - $self->{parent}->{modules}->{crypt}->generateInt($intMin, $intMax);
                    if ($intHunger <= 45) {
                        my $postcardID = $self->sendPostcard($self->{ID}, 'sys', 0, $_->{puffleName}, 110);
                        $self->sendXT(['mr', '-1', 'sys', 0, 110, $_->{puffleName}, time, $postcardID]);
                    }
                    my $intRest = $_->{puffleRest} - $self->{parent}->{modules}->{crypt}->generateInt($intMin, $intMax);
                    $self->{parent}->{modules}->{mysql}->execQuery("UPDATE puffles SET `puffleHealth` = '$intHealth', `puffleEnergy` = '$intHunger', `puffleRest` = '$intRest' WHERE `puffleID` = '$intPuffle' AND `ownerID` = '$self->{ID}'");
                }
       }
}

method DESTROY {
       if ($self->{tableID} ne 0) {
           $self->{parent}->{systems}->{Tables}->handleLeaveTable((), $self);
       }
       $self->removePlayer;
       $self->handleBuddyOffline;
       $self->closeIgloo;
}

1;
