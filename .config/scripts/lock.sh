#!/bin/sh

B='#00000000'  # blank
C='#ffffff00'  # clear ish
D='#0099ddff'  # Ring
T='#00ccaaff'  # text
W='#ffffffff'  # Clicks
V='#ffffffff'  # verifying

i3lock \
--insidevercolor=$C   \
--ringvercolor=$V     \
\
--insidewrongcolor=$C \
--ringwrongcolor='#ff0000ff'  \
\
--insidecolor=$B      \
--ringcolor=$D        \
--linecolor=$B        \
--separatorcolor=$D   \
\
--textcolor=$T        \
--timecolor=$T        \
--datecolor=$T        \
--layoutcolor=$T      \
--keyhlcolor=$W       \
--bshlcolor=$W        \
\
--screen 0            \
--blur 5              \
--clock               \
--indicator           \
--timestr="%H:%M:%S"  \
--datestr="%A, %m %Y" \
--keylayout 2         \
--veriftext=". . ." \
--wrongtext=Nope! \
# --textsize=20
# --modsize=10
# --timefont=comic-sans
# --datefont=monofur
# etc
