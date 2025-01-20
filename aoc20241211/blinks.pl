#!/usr/bin/perl -w
use strict;

sub counter {
	my ($stone, $blinks) = @_;
	our %cache;
	$stone = sprintf("%d", $stone);
	if (!defined($cache{$stone}[$blinks])) {
		if ($blinks == 0) {
			$cache{$stone}[$blinks] = 1;
		} elsif ($stone == 0) {
			$cache{$stone}[$blinks] = counter(1, $blinks - 1);
		} else {
			if (length($stone) % 2) {
				$cache{$stone}[$blinks] = counter($stone * 2024, $blinks - 1);
			} else {
				$cache{$stone}[$blinks]
					= counter(substr($stone, 0, length($stone) / 2), $blinks - 1)
					+ counter(substr($stone,  length($stone) / 2), $blinks - 1);
			}
		}
	}
	return $cache{$stone}[$blinks];
}

my $blinkings = 75;
my @stonelist = qw(4189 413 82070 61 655813 7478611 0 8);
my $tot = 0;

foreach ( @stonelist ) {
	print $_ . "\n";
	$tot += counter($_, $blinkings);
	print "Running total: " . $tot . "\n";
}
