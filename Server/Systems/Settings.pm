package Settings;

use strict;
use warnings;

use Method::Signatures;

method new($resChild) {
       my $obj = bless {}, $self;
       $obj->{child} = $resChild;
       return $obj;
}

method handleUpdatePlayerClothing($strData, $objClient) {
       my @arrData = split('%', $strData);
       my $strCmd = $arrData[3];
       my @arrCmd = split('#', $strCmd);
       my $intItem = $arrData[5];
       my $strType = $arrCmd[1];
       my %arrTypes = (upc => 'colour', uph => 'head', upf => 'face', upn => 'neck', upb => 'body', upa => 'hand', upe => 'feet', upp => 'photo', upl => 'flag');
       return if (!exists($arrTypes{$strType}));   
       if ($strType eq 'upa' && $intItem == 0) {
		   my $arrWalkingPuffle = $self->{modules}->{mysql}->getWalkingPuffle($objClient->{ID});
		   $self->{modules}->{mysql}->updateWalkingPuffle(0, $arrWalkingPuffle->{puffleID}, $objClient->{ID});
		   $objClient->getPuffles($objClient->{ID});
	   }
       $objClient->updatePlayerCard($strType, $arrTypes{$strType}, $intItem);
}

1;
