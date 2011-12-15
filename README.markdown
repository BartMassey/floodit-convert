# Google+ Flood-It Board Converter
Copyright © 2011 Bart Massey

This is a little pile of code for converting a screenshot
image of a Google+ Flood-It board to a textual array of
pixel colors suitable for building search programs around.
You can currently find Google+ Flood-It at
          http://www.google.com/ig/directory?type=gadgets&url=www.labpixies.com/campaigns/flood/flood.xml

To invoke the code, just say

> `sh floodit-convert.sh` *size* *board-image*

The current *size* values for small, medium and large Google+
Flood-It boards are 14, 21 and 28 squares: the code has no
heuristic for figuring this out, so tell it the right thing.
The *board-image* file can be any PNG (preferred)
or JPG (or any of a number of other formats, really) image
of a Flood-It board.

The code has many Google Flood-It specific assumptions. In
particular, the code has a bunch of fairly narrow heuristics
to detect exactly six square colors, which are assumed to be
(r)ed, (g)reen, (b)lue, (c)yan, (m)agenta and (y)ellow.

The code makes heavy use of a modern version of NETPBM, so
you need to have that installed. If the code complains, the
most likely problem is that you have some ancient version of
NETPBM like the one in Debian; get the SourceForge one that
actually works.

This work is released under the MIT License. Please see the
file COPYING in this distribution for license terms.

Manifest:

* `floodit-convert.sh`: Driver script.
* `floodit-text.awk`: Used by driver script as last stage.
* `floodit-pixels.awk`: Used in development of color heuristic.
* `board.png`: Sample board screenshot.
* `floodit-board.txt`: Output of `floodit-convert.sh` on sample screenshot.
* `COPYING`: License information.
* `README.markdown`: This README.
