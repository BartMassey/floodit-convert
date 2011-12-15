#!/usr/bin/awk -f
# Copyright © 2011 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.
# Convert a 14x14 ASCII PPM representing
# a Google+ Flood-It board screen capture
# to an ASCII representation for search.
#   http://www.google.com/ig/directory?type=gadgets&url=
#   www.labpixies.com/campaigns/flood/flood.xml
NR == 1 {
    if ($0 != "P3") {
        printf "floodit-text: bad input: %s\n", $0 >"/dev/stderr"
        exit(1)
    }
    next
}
/^#/ {
    next
}
!dims {
    if ($1 != "14" || $2 != "14") {
        printf "floodit-text: bad dims: %sx%s\n", $1, $2 >"/dev/stderr"
        exit(1)
    }
    dims = 1
    next
}
!pix {
    if ($1 != "255") {
        printf "floodit-text: bad depth: %s\n", $1 >"/dev/stderr"
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
        printf "floodit-text: bad component count: %d\n", npix >"/dev/stderr"
        exit 1
    }
    for (j = 0; j < 14; j++) {
        for (i = 0; i < 14; i++) {
            r = c[opix++] + 0
            g = c[opix++] + 0
            b = c[opix++] + 0
            if (r > g && r > b) {
                if (r > b + 80)
                    printf "r"
                else
                    printf "m"
            } else if (g > b && g > r) {
                if (g > r + 10)
                    printf "g"
                else
                    printf "y"
            } else if (b > r && b > g) {
                if (g > r + 60)
                    printf "c"
                else
                    printf "b"
            } else {
                printf "\nfloodit-text: bad pixel: %d %d %d\n", \
                       r, g, b >"/dev/stderr"
                exit 1
            }
        }
        printf "\n"
    }
}
