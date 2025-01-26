//
//  main.swift
//  aoc2024day11
//
//  Started by Dave Burchell on 2025-01-21
//

let StoneBlink = StoneBlinkClass()
print(StoneBlink.blink(stoneArray: [125, 17], blinks: 6))
print(StoneBlink.blink(stoneArray: [125, 17], blinks: 25))

class StoneBlinkClass {
  private var cache: [Int: [Int]] = [:]
  private let blink_limit = 100

  func blink(stoneArray: [Int], blinks: Int) -> String {
    var runningTotal = 0
    var stoneLineString = ""
    for stone in stoneArray {
      runningTotal += stoneCount(stone: stone, blinks: blinks)
      stoneLineString += String(stone) + ", "
    }
    return "Stone line " + stoneLineString + " after " + String(blinks) + " blinks: " + String(runningTotal)
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
    if cache[stone] == nil {
        initStone(stone: stone)
    }
    if cache[stone]![blinks] == 0 {
      if blinks == 0 {
        cache[stone]![blinks] = 1
      } else if (stone == 0) {
        cache[stone]![blinks] = stoneCount(stone: 1, blinks: blinks - 1)
      } else {
          if String(stone).count % 2 == 1 {
            cache[stone]![blinks] = stoneCount(stone: stone * 2024, blinks: blinks - 1)
        } else {
            cache[stone]![blinks] +=
              stoneCount(stone: Int(String(String(stone).prefix(String(stone).count / 2))) ?? 0, blinks: blinks - 1)
            + stoneCount(stone: Int(String(String(stone).suffix(String(stone).count / 2))) ?? 0, blinks: blinks - 1)
        }
      }
    }
    return cache[stone]![blinks]
  }

}
