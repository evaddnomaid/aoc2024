#!/usr/local/bin/perl -n
BEGIN {
	$tot = 0;
	$condtot = 0;
	$enable = "do";
}

#while (m/(do)\(\)|(don't)\(\)/g) {
while (m/mul\(([0-9]{1,3}),([0-9]{1,3})\)|(do)\(\)|(don)\'t\(\)/g) {
	if (substr($+, 0, 2) eq 'do') {
		$enable = $+;
	} else {
		$tot += $1 * $2;
		if ($enable eq "do") {
			$condtot += $1 * $2;
		}
	}
}

END {
	print "TOTAL: " . $tot . "; TOTAL CONDITIONAL: " . $condtot . "\n";
}
