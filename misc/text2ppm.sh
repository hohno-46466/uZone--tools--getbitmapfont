#!/bin/sh

# very early version

# Last updated: Fri Dec  2 08:10:47 JST 2016

TMP=/tmp/text2ppm-tmp.txt
OUT=/tmp/text2ppm-out.ppm

for x in $TMP $OUT; do
  rm -f "$x"
  [ -f "$x" ] && exit 9
  touch "$x"
  [ ! -f "$x" ] && exit 9
done

# awk '{if(p!=""){printf "\n"};printf "%s",$0;p=$0;}' > $TMP	# No LF in the last line.
head -1 | awk '{printf "%s", $0}' > $TMP

# convert -background white -fill black -font /Library/Fonts/ipaexg.ttf -pointsize 24 +antialias label:@$TMP ppm:- \
# | convert - -crop 99999x32+0+1 ppm:- \
# > $OUT
convert -background white -fill black -font /Library/Fonts/ipaexg.ttf -pointsize 18 +antialias label:@$TMP ppm:- \
| convert - -crop 99999x16+0+1 ppm:- \
> $OUT

identify $OUT

exit 0
