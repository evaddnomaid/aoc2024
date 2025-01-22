//
//  main.swift
//  aoc2024day11
//
//  Created by Dave Burchell on 1/21/25.
//

import Foundation

let blinks = 9
print("Hello, World!");
var lookup: [Int: [Int]] = [:]
for _ in 0...blinks {
    lookup[0]?.append(0)
}

lookup[0] = [1, 1, 1, 2, 4]
lookup[0]?.append(4)
lookup[0]?[1] = 365

var numbers = [1, 2, 3, 4, 5]
numbers.append(100)
print(numbers)
// Prints "[1, 2, 3, 4, 5, 100]"
print(lookup[0]!)
//exit(0)
