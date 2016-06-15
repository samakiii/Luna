package Survey;

use strict;
use warnings;

use Method::Signatures;
use HTTP::Date qw(str2time);

method new($resChild) {
	my $obj = bless {}, $self;
	$obj->{child} = $resChild;
	return $obj;
}

method handleSignIglooContest($strData, $objClient) {
		my $intID = $objClient->{ID};
		my $strUsername = $objClient->{username};
		my $arrSignUps = $self->{child}->{modules}->{mysql}->checkJoinedIglooContest($intID);
		foreach (values @{$arrSignUps}) {
			my $intLastSignedTime = str2time($_->{signup_time});
			my $intCurrTimestamp = time;
			my $intTimeDiff = $intLastSignedTime - $intCurrTimestamp;
			if ($intTimeDiff < 86400) { # check if last signed up time is less than 24 hours
				return $objClient->sendError(213);
			}
		}
		$self->{child}->{modules}->{mysql}->insertData('igloo_contest', ['ID', 'username'], [$intID, $strUsername]);
}

method handleDonateCoins($strData, $objClient) {
		my @arrData = split('%', $strData);
		my $intDonation = $arrData[6];
		return if (!int($intDonation));
		my $intID = $objClient->{ID};
		my $strUsername = $objClient->{username};
		my $arrDonations = $self->{child}->{modules}->{mysql}->getLastDonations($intID);
		foreach (values @{$arrDonations}) {
			my $intLastDonatedTime = str2time($_->{donate_time});
			my $intCurrTimestamp = time;
			my $intTimeDiff = $intLastDonatedTime - $intCurrTimestamp;
			if ($intTimeDiff < 3600) { # check if last donated time is less than an hour
				return $objClient->sendError(213);
			}
		}
		if ($objClient->{coins} <= 0) { # check if client has no coins
			$objClient->sendError(401);
		}
		my $intRemaining = $objClient->{coins} - $intDonation;
		$self->{child}->{modules}->{mysql}->insertData('donations', ['ID', 'username', 'donation'], [$intID, $strUsername, $intDonation]);
		$objClient->setCoins($intRemaining);
		$objClient->loadDetails;
}

1;
