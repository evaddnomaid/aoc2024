sedawk.out: full.sed full.awk
	sed -f full.sed < input.txt | awk -f full.awk
	./part2.pl < input.txt

outfile.txt: part2.pl input.txt
	./part2.pl < input.txt
	./part2.pl < input.txt > outfile.txt
