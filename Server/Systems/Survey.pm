package Survey;

use strict;
use warnings;

use Method::Signatures;
use feature qw(say);

method new($resChild) {
       my $obj = bless {}, $self;
       $obj->{child} = $resChild;
       return $obj;
}

method handleSignIglooContest($strData, $objClient) {
		my $strInfo = $objClient->{username} . ':' . $objClient->{ID};
		$self->appendToFile('IglooContests.txt', $strInfo);
}

method handleDonateCoins($strData, $objClient) {
		my @arrData = split('%', $strData);
		my $intDonation = $arrData[6];
		return if (!int($intDonation));
		my $intRemaining = $objClient->{coins} - $intDonation;
		my $strInfo = $objClient->{username} . ':' . $objClient->{ID} . '| Donated: ' . $intDonation;
		$self->appendToFile('Donations.txt', $strInfo);
		$objClient->setCoins($intRemaining);
		$objClient->loadDetails;
}

method appendToFile($strFile, $strData) {
		open(my $fh, '>>', $strFile);
		say $fh $strData;
		close $fh;
}

1;
