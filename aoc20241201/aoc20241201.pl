#!/usr/local/bin/perl
$debug = 0;
while (<STDIN>) {
	s/\s+$//g;
	($left, $right) = split(/ +/);
	push @left, $left;
	push @right, $right;
	$right_count[$right] = $right_count[$right] + 1;
}
@left = sort @left;
@right = sort @right;
for ($i = 0; $i <= $#left; $i++) {
	$result_part1 = $result_part1 + abs($left[$i] - $right[$i]);
	warn ($left[$i] . " minus " . $right[$i] . " makes " . abs($left[$i] - $right[$i]) . " so moves result_part1 to " . $result_part1) unless !$debug;
	$result_part2 = $result_part2 + $left[$i] * $right_count[$left[$i]];
}
print "Result part 1: " . $result_part1 . "\n";
print "Result part 2: " . $result_part2 . "\n";
