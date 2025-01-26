//
//  main.swift
//  aoc2024day11
//
//  Started by Dave Burchell on 2025-01-21
//

import Foundation

var StoneBlink = StoneBlinkClass()
var blinks = 25
var stoneList = [125, 17]
var runningTot = 0
for stone in stoneList {
    runningTot += StoneBlink.stoneCount(stone: stone, blinks: blinks)
}
print("From sample data with", blinks, "blinks:", runningTot)
runningTot = 0
print("Call count:", StoneBlink.callcount)
stoneList = [4189, 413, 82070, 61, 655813, 7478611, 0, 8]
for stone in stoneList {
    runningTot += StoneBlink.stoneCount(stone: stone, blinks: blinks)
}
print(blinks, "blinks:", runningTot)
print("Call count:", StoneBlink.callcount)
runningTot = 0
blinks = 75
for stone in stoneList {
    runningTot += StoneBlink.stoneCount(stone: stone, blinks: blinks)
}
print(blinks, " blinks: ", runningTot)
print("Call count:", StoneBlink.callcount)

class StoneBlinkClass {
  var callcount: Int
  private var cache: [Int: [Int]] = [:]
  private let blink_limit = 100

  init () {
    self.callcount = 0
    //self.cache[0] = [1, 1, 1, 2]
    //self.cache[0]! += [4]
     //self.callcount += 1
     initStone(stone: 0)
  }

  private func initStone(stone: Int) {
    self.cache[stone] = []
    while self.cache[stone]!.count < blink_limit {
        self.cache[stone]! += [0]
    }
    for _ in 0...blink_limit {
        self.cache[stone]! += [0]
     }
  }

  func stoneCount(stone: Int, blinks: Int) -> Int {
    callcount += 1
    let thisStoneArray = cache[stone]
    if thisStoneArray == nil { // key set for this stone?
        initStone(stone: stone)
    }
    if cache[stone]![blinks] == 0 {
      if blinks == 0 {
        cache[stone]![blinks] = 1
      } else if (stone == 0) {
        cache[stone]![blinks] = stoneCount(stone: 1, blinks: blinks - 1)
      } else {
        let stone_string = String(stone)
        let stone_len = stone_string.count
        if stone_len % 2 == 1 {
            cache[stone]![blinks] = stoneCount(stone: stone * 2024, blinks: blinks - 1)
        } else {
            let bothsides = split(stone: stone)
            cache[stone]![blinks] +=
            stoneCount(stone: bothsides.left, blinks: blinks - 1)
            + stoneCount(stone: bothsides.right, blinks: blinks - 1)
        }
      }
    }
    return cache[stone]![blinks]
  }

  private func split(stone: Int) -> (left: Int, right: Int) {
    let stone_string = String(stone)
    let stone_len = stone_string.count
    // TODO: Use "prefix" just as we used "suffix" below?
    let leftIndexFromLeft = stone_string.startIndex
    let leftIndexToLeft = stone_string.index(stone_string.startIndex, offsetBy: stone_len / 2)
    let left_string = String(stone_string[leftIndexFromLeft..<leftIndexToLeft])
    let left_stone = Int(left_string) ?? 0
    let right_string = String(stone_string.suffix(stone_len / 2))
    let right_stone = Int(right_string) ?? 0
    return (left: left_stone, right: right_stone)
  }
}
