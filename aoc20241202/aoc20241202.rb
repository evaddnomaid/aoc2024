#!/usr/bin/ruby

def safe? (report=[])
	print "REPORT of len ", report.length, ": ", report, "\n"
	if report.length < 2
		print "safe\n"
		return true
	end
	if (report[1] - report[0]) > 3
		print "UNSAFE - over 3\n"
		return false
	end
	if (report[1] - report[0]) < 1
		print "UNSAFE - zero or lower\n"
		return false
	end
	return safe?(report[1..-1])
end

def dampsafe? (report=[])
	if report.length < 3
		print "DAMPsafe\n"
		return true
	end
	0..report.length.times do |i|
		print "i: " , i
		newarray = report[0,i] + report[i+1,report.length - i]
		print "NEW array: ", newarray, "\n"
		if safe?(report[0,i] + report[i+1,report.length - i])
			return true
		end
	end
	return false
end

safe = 0
unsafe = 0
dampsafe = 0
i = 0
ARGF.each do |line|
	i += 1
	print "\n", i, ": ", line
	report = line.split(" ").map { |string| string.to_i }
	if report[0] > report[report.size-1]
		print "REVERSE\n"
		report = report.reverse
	end
	if safe?(report)
		safe += 1
	else
		unsafe += 1
		if dampsafe?(report)
			dampsafe += 1
		end
	end
	print "Safe: ", safe, " - Unsafe: ", unsafe, " - Dampsafe: ", dampsafe, "\n"
end
