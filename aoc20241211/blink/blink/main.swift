//
//  main.swift
//  aoc2024day11
//
//  Created by Dave Burchell on 1/21/25.
//

import Foundation


func counter(stone: Int, blinks: Int) -> Int {
    //cache.updateValue([1], forKey: 0)
    let all_keys = cache.keys
    if all_keys == nil || !(all_keys.contains(stone)) {
        for _ in 0...blink_limit {
            cache[stone].append(0)
        }
    }
    if cache[stone]![blinks] == 0 {
        if blinks == 0 {
            cache[stone]![blinks] = 1
        } else if (stone == 0) {
            cache[stone]![blinks] = counter(stone: 1, blinks: blinks - 1)
        } else {
            let stone_string = String(stone)
            let stone_len = stone_string.count
            if stone_len % 2 == 1 {
                cache[stone]![blinks] = counter(stone: stone * 2024, blinks: blinks - 1)
            } else {
                let bothsides = split(stone: stone)
                cache[stone]![blinks] +=
                counter(stone: bothsides.left, blinks: blinks - 1)
                + counter(stone: bothsides.right, blinks: blinks - 1)
            }
        }
    }
    return cache[stone]![blinks]
}

func split(stone: Int) -> (left: Int, right: Int) {
    let stone_string = String(stone)
    let stone_len = stone_string.count
    let leftIndexFromLeft = stone_string.startIndex
    let leftIndexToLeft = stone_string.index(stone_string.startIndex, offsetBy: stone_len / 2)
    let left_string = String(stone_string[leftIndexFromLeft..<leftIndexToLeft])
    let left_stone = Int(left_string) ?? 0
    let rightIndexFromLeft = stone_string.startIndex
    let rightIndexToLeft = stone_string.index(stone_string.startIndex, offsetBy: stone_len / 2)
    let right_string = String(stone_string.suffix(stone_len / 2))
    let right_stone = Int(right_string) ?? 0
    return (left: left_stone, right: right_stone)
}
let blink_limit = 100
//var cache: Dictionary<Int, Array<Int>>
var cache: [Int: [Int]]
let bothsides = split(stone: 88882222)
print("left: \(bothsides.left); right: \(bothsides.right)")
print(counter(stone: 0, blinks: 2))
