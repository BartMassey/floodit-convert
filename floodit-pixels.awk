#!/usr/bin/awk -f
# Copyright © 2011 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.
NR == 1 {
    if ($0 != "P3") {
        printf "floodit-pixels: bad input: %s\n", $0 >"/dev/stderr"
        exit(1)
    }
    next
}
/^#/ {
    next
}
!dims {
    if ($1 != "14" || $2 != "14") {
        printf "floodit-pixels: bad dims: %sx%s\n", $1, $2 >"/dev/stderr"
        exit(1)
    }
    dims = 1
    next
}
!pix {
    if ($1 != "255") {
        printf "floodit-pixels: bad depth: %s\n", $1 >"/dev/stderr"
        exit(1)
    }
    pix = 1
    next
}
{
    for (i = 1; i <= NF; i++)
        c[npix++] = $i
    next
}
END {
    if (npix != 14 * 14 * 3) {
        printf "floodit-pixels: bad component count: %d\n", npix >"/dev/stderr"
        exit 1
    }
    for (j = 0; j < 14; j++) {
        for (i = 0; i < 14; i++) {
            r = c[opix++]
            g = c[opix++]
            b = c[opix++]
            cstr = r "/" g "/" b
            if (!seen[cstr]) {
                colors[ncolors++] = cstr
                seen[cstr] = 1
            }
        }
    }
    for (i = 0; i < ncolors; i++)
        printf "%s\n", colors[i]
}
