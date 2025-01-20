#!/usr/bin/perl -w
use strict;

sub counter {
	our %cache;
	my $stone = sprintf("%d", $_[0]);
	my $blinks = $_[1];
	if (defined($cache{$stone}[$blinks])) {
		return $cache{$stone}[$blinks];
	}
	if ($blinks == 0) {
		$cache{$stone}[$blinks] = 1;
		return $cache{$stone}[$blinks];
	}
	if ($stone == 0) {
		$cache{$stone}[$blinks] = counter(1, $blinks - 1);
		return $cache{$stone}[$blinks];
	}
	my $stone_digits_count = length($stone);
	if ($stone_digits_count % 2) {
		my $next = $stone * 2024;
		$cache{$stone}[$blinks] = counter($next, $blinks - 1);
	} else {
		my $left  = substr($stone, 0, $stone_digits_count / 2);
		my $right = substr($stone, $stone_digits_count / 2);
		$cache{$stone}[$blinks] = counter($left, $blinks - 1) + counter($right, $blinks - 1);
	}
	return $cache{$stone}[$blinks];
}

my $blinks = 75;
my @stonelist = qw(4189 413 82070 61 655813 7478611 0 8);
my $tot = 0;

foreach ( @stonelist ) {
	print $_ . "\n";
	$tot += counter($_, $blinks);
	print "Running total: " . $tot . "\n";
}
