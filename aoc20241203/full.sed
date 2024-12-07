s/MARKER//g
s/mul(\([0-9]\{1,3\}\),\([0-9]\{1,3\}\))/\nMARKERmul \1 \2\n/g
s/\(do()\)/\n\1\n/g
s/\(don't()\)/\n\1\n/g
