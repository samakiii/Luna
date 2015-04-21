package Gaming;

use strict;
use warnings;

use Math::Round qw(round);
use Method::Signatures;

method new($resChild) {
       my $obj = bless {}, $self;
       $obj->{child} = $resChild;
       $obj->{puck} = '0%0%0%0';
       return $obj;
}

method handleGameOver($strData, $objClient) {
       my @arrData = split('%', $strData);
       my $intCoins = $arrData[5];
       if ($objClient->{room} <= 899 || $objClient->{room} >= 1000) {
           return $objClient->sendXT(['zo', '-1', $objClient->{coins}, '', 0, 0, 0]);
       }
       if ($intCoins > 99999) {
           $objClient->sendError(611);
           return $self->{child}->{modules}->{base}->removeClient($objClient->{sock});
       }
       my $coins = round($intCoins / 10);
       $objClient->setCoins($objClient->{coins} + $coins);
       # No stamps yet, later?
       $objClient->sendXT(['zo', '-1', $objClient->{coins}, '', 0, 0, 0]);
}

method handleMovePuck($strData, $objClient) {
       my @arrData = split('%', $strData);
       $self->{puck} = $arrData[6] . '%' . $arrData[7] . '%' . $arrData[8] . '%' . $arrData[9];
       $objClient->sendRoom('%xt%zm%-1%' . $arrData[5] . '%' . $self->{puck} . '%');
}

method handleGetZone($strData, $objClient) {
       my @arrData = split('%', $strData);
       if ($objClient->{room} eq 802) {
           return $objClient->sendXT(['gz', '802', $self->{puck}]);
       } elsif ($objClient->{room} eq 220 || $objClient->{room} eq 221) { # find four
                if ($objClient->{tableID} ne 0) { 
                    my $zoneString = '%%0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0%';
                    $objClient->sendXT(['gz', '-1', substr($zoneString, 0, -1)]);
                }
       } 
}

method handleJoinZone($strData, $objClient) {
     my @arrData = split('%', $strData);
     if ($objClient->{room} eq 220 || $objClient->{room} eq 221) { # find four
         if ($objClient->{tableID} ne 0 && $objClient->{seatID} ne 999) {
             $objClient->sendXT(['jz', '-1', $objClient->{seatID} - 1, $objClient->{username}]);
             foreach (values (%{$self->{child}->{tables}->{$objClient->{tableID}}->{clients}})) {
                      if ($_->{ID} ne $objClient->{ID}){
                          $objClient->sendXT(['uz', '-1', $_->{seatID} - 1, $_->{username}]);
                          $_->sendXT(['uz', '-1', $objClient->{seatID} - 1, $objClient->{username}]);
                      }
                      $objClient->sendXT(['uz', '-1', $objClient->{seatID} - 1, $objClient->{username}]);
             }
             if (keys (%{$self->{child}->{tables}->{$objClient->{tableID}}->{clients}}) >= $self->{child}->{tables}->{$objClient->{tableID}}->{max}) {
                 $self->{child}->{tables}->{$objClient->{tableID}}->{currentTurn} = 0;
                 foreach (values (%{$self->{child}->{tables}->{$objClient->{tableID}}->{clients}})) {
                          $_->sendXT(['sz', '-1', '0']);
                 }
             }
         }
     }
}

method handleGetWaddle($strData, $objClient) {
     my @arrData = split('%', $strData);
     splice(@arrData, 0, 5);
     my $waddlePopulation = '';
     foreach (@arrData) {
                if (exists($self->{child}->{waddles}->{$_})) {
                    $waddlePopulation .= $_ . '|';
                    my $users = '';
                    foreach (values %{$self->{child}->{waddles}->{$_}->{clients}}) {
                          if (exists($_->{username})){
                               $users .= $_->{username} . ',';
                          }
                    }
                    if ($users =~ tr/,// < $self->{child}->{waddles}->{$_}->{max}){
                          for (my $i = 0; $i < $self->{child}->{waddles}->{$_}->{max}-1; $i++) {
                                $users .= ',';
                          }
                    }
                    $waddlePopulation .= $users . '%';
                }
     }
     $objClient->sendXT(['gw', '-1', substr($waddlePopulation, 0, -1)]);
}

method handleLeaveWaddle($strData, $objClient) {
     $objClient->sendRoom('%xt%uw%-1%' . $objClient->{waddleID} . '%' . $objClient->{seatID} . '%');
     $objClient->{waddleID} = 0;
     $objClient->{seatID} = 999;
}

method handleJoinWaddle($strData, $objClient) {
     my @arrData = split('%', $strData);
     my $waddleID = $arrData[5];
     return if(!int($waddleID) || !exists($self->{child}->{waddles}->{$waddleID}));
     if (scalar (keys %{$self->{child}->{waddles}->{$waddleID}->{clients}}) >= $self->{child}->{waddles}->{$waddleID}->{max} || $objClient->{waddleID} ne 0) {
          return $objClient->sendError(211);
     }
     $objClient->{waddleID} = $waddleID;
     $objClient->{seatID} = scalar(keys %{$self->{child}->{waddles}->{$waddleID}->{clients}});
     $objClient->sendRoom('%xt%uw%-1%' . $waddleID . '%' . $objClient->{seatID} . '%' . $objClient->{username} . '%' . $objClient->{ID} . '%');
     $objClient->sendXT(['jw', '-1', $objClient->{seatID}]);
     if (scalar (keys %{$self->{child}->{waddles}->{$waddleID}->{clients}}) >= $self->{child}->{waddles}->{$waddleID}->{max}) {
          
     }
}

method handleSendMove($strData, $objClient) {
     my @arrData = split('%', $strData);
     if ($objClient->{room} eq 220 || $objClient->{room} eq 221) { # find four
         if ($objClient->{tableID} ne 0 && $objClient->{seatID} ne 999) {
             my $column = $arrData[5];
             my $row = $arrData[6];
             $self->{child}->{tables}->{$objClient->{tableID}}->{boardMap}[$column][$row] = $self->{child}->{tables}->{$objClient->{tableID}}->{currentTurn};
             foreach (values (%{$self->{child}->{tables}->{$objClient->{tableID}}->{clients}})) {
                      $_->sendXT(['zm', '-1', $self->{child}->{tables}->{$objClient->{tableID}}->{currentTurn}, $column, $row]);
             }
             $self->{child}->{tables}->{$objClient->{tableID}}->{currentTurn} = $self->{child}->{tables}->{$objClient->{tableID}}->{currentTurn} == 0 ? 1 : 0;
         }
     }
}

1;
