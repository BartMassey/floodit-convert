#!/bin/sh
# Copyright © 2011 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.
# Convert a Google+ Flood-It board screen capture
# to an ASCII representation for search.
#   http://www.google.com/ig/directory?type=gadgets&url=
#   www.labpixies.com/campaigns/flood/flood.xml
if [ $# -ne 1 ]
then
    echo "floodit-convert: usage: floodit-convert <board-image>" >&2
    exit 1
fi
BASENAME="`echo \"$1\" | sed 's/\.[^\.]*$//'`"
OUTFILE=floodit-"$BASENAME".txt
TMP="/tmp/floodit-convert-$$.ppm"
trap "rm -f $TMP" 0 1 2 3 15
# Quantize and crop the board
anytopnm $1 |
pnmquant -center -nofs 7 |
pnmcrop >$TMP
# Figure out the board scale (better be square and mod 14)
pamfile $TMP |
sed 's/^.* \([0-9]*\) by \([0-9]*\) .*$/\1 \2/' | (
    read X Y
    if [ $X -ne $Y ]
    then
        echo "floodit-convert: non-square board (${X}x${Y})" >&2
        exit 1
    fi
    F=`expr $X '%' 14`
    if [ $F -ne 0 ]
    then
        echo "floodit-convert: board size not multiple of 14 ($X)" >&2
        exit 1
    fi
    W=`expr $X '/' 14`
    pamscale -reduce $W $TMP ) |
pamtopnm -plain |
awk -f floodit-text.awk >"$OUTFILE"
# Handle errors
if [ $? -ne 0 ]
then
    rm -f "$OUTFILE"
    exit 1
fi
exit 0
