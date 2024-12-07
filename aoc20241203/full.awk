BEGIN { enable = 1 }
/^do\(\)$/ { enable = 1 }
/^don't\(\)$/ { enable = 0 }
/^MARKER/ { part1 += $2 * $3 ; if (enable) {part2 += $2 * $3}}
END { printf("Part 1: %d; Part 2: %d\n", part1, part2) }
