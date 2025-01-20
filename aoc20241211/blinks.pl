#!/usr/bin/perl -w
use strict;

sub counter {
	my $result;
	our $calls;
	our %cache;
	$calls++;
	if ($calls % 1_000 == 0) { print "Calls: " . $calls . "\n"};
=pod
=cut
	my $nowarn = 1;
	my $stone = sprintf("%d", $_[0]);
	my $blinks = $_[1];
	if (defined($cache{$stone}[$blinks])) {
		return $cache{$stone}[$blinks];
	}
	warn "Stone: $stone; Blinks: $blinks\n" unless $nowarn;
	
	if ($blinks == 0) {
		return 1;
	}
	if ($stone == 0) {
		$cache{$stone}[$blinks] = counter(1, $blinks - 1);
		return $cache{$stone}[$blinks];
	}
	my $stone_digits_count = length($stone);
	warn "Stone is $stone with length of $stone_digits_count" unless $nowarn;
	if ($stone_digits_count % 2) {
		my $next = $stone * 2024;
		warn "Stone $stone blinks to $next" unless $nowarn;
		$cache{$stone}[$blinks] = counter($next, $blinks - 1);
		return $cache{$stone}[$blinks];
	}
	my $left  = substr($stone, 0, $stone_digits_count / 2);
	my $right = substr($stone, $stone_digits_count / 2);
	$cache{$stone}[$blinks] = counter($left, $blinks - 1) + counter($right, $blinks - 1);
	return $cache{$stone}[$blinks];
}

$main::calls = 0;
my $blinks = 75;
printf("================>> Total stone count: %d\n", counter(125, $blinks) + counter(17, $blinks));

my @stonelist = qw(4189 413 82070 61 655813 7478611 0 8);
my $tot = 0;

foreach ( @stonelist ) {
	print $_ . "\n";
	$tot += counter($_, $blinks);
	print "Subtot: " . $tot . "\n";
}

