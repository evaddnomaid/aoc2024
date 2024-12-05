#!/usr/local/bin/python3

import fileinput
import re

def tally(lines):
	matches = 0
	matcharray = []
	for line in lines:
		matcharray = re.findall(r'XMAS', line)
		matches = matches + len(matcharray)
		matcharray = re.findall(r'SAMX', line)
		matches = matches + len(matcharray)
	return matches

def rot90(matIn):
	matOut = []
	i = 0
	while i < len(matIn[0]):
		matOut.append("")
		i += 1
	j = 0
	while j < len(matIn[0]):
		i = len(matIn) - 1
		while i >= 0:
			matOut[j] = matOut[j] + matIn[i][j]
			i -= 1
		j += 1
	return matOut

# Rotate the puzzle space 45 degrees clockwise
# The input must be a rectangular matrix
def rot45(matIn):
	# Initialize the array
	matOut = []
	i = 0
	while i < len(matIn[0]) + len(matIn) - 1:
		matOut.append("")
		i += 1

	# Handle the diagonals (going up and right) that originate
	# from a first column position
	i = 0
	while i < len(matIn):
		diag = 0
		while i - diag >= 0 and i + diag < len(matIn[0]):
			#print("i: " + str(i) + "; diag: " + str(diag) + "; Accessing char " + matIn[i - diag][diag])
			matOut[i] = matOut[i] + matIn[i - diag][diag]
			diag += 1
		i += 1

	# Handle the diagonals (going up and right) that originate
	# from the bottom row starting with the second column
	j = 1
	while j < len(matIn[0]):
		diag = 0
		while j + diag < len(matIn[0]) and len(matIn) - 1 - diag >= 0:
			character = matIn[len(matIn) - 1 - diag][j + diag]
			#print("j: " + str(j) + "; diag: " + str(diag) + "; Accessing char " + character)
			matOut[len(matIn) - 1 + j] = matOut[len(matIn) - 1 + j] + character
			diag += 1
		j += 1

	return matOut

tot = 0
a = []
for line in fileinput.input():
	a.append(line.rstrip())
a = (
'MMMSXXMASM',
'MSAMXMSMSA',
'AMXSXMAAMM',
'MSAMASMSMX',
'XMASAMXAMM',
'XXAMMXXAMA',
'SMSMSASXSS',
'SAXAMASAAA',
'MAMMMXMMMM',
'MXMXAXMASX'
)

tot += tally(a)
tot += tally(rot45(a))
tot += tally(rot90(a))
tot += tally(rot45(rot90(rot90(rot90(a)))))
print(rot45(rot90(rot90(rot90(a)))))

testbed = []
testbed = (
	"abcde",
	"ABCDE",
	"12345")
testbed2 = (
	"abc",
	"ABC",
	"123",
	"ijk",
	"xyz")
#rot90(testbed)
#print(rot90(a))
#print(rot45(testbed))
print("Tally: " + str(tot))
