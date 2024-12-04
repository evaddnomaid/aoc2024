#!/usr/local/bin/perl -n

BEGIN { $enable = "do"; }

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
