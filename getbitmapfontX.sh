#! /bin/sh

# getbitmapfontX.sh

# First version: Tue Nov  9 07:10:37 JST 2021 (modified freom getbitmapfont.sh)

# History of original script (getbitmapfont.sh)
# Prev update: Mon Dec 26 08:16:28 JST 2011 by hohno
# Prev update: Tue Nov 27 06:49:20 JST 2012 by hohno
# Prev udpate: Wed Jan 15 11:02:41 JST 2014 by hohno
# Prev udpate: Fri Jul 18 00:09:22 JST 2014 by hohno
# Last udpate: Sat Dec 27 11:34:14 JST 2014 by hohno

# ----------------------------------------------------------
# Definition and initialize global variables
# ----------------------------------------------------------

# LANG=C export LANG
# LC_ALL=C export LC_ALL

# ----------------------------------------------------------

TRUE="TRUE"
FALSE="FALSE"

# ----------------------------------------------------------

[ "x$TARGETFONTNAME" = "x" ] && TARGETFONTNAME="kanji16"
[ "x$TARGETFONTSIZE" = "x" ] && TARGETFONTSIZE="16"

# ----------------------------------------------------------

echo="/bin/echo"	# Do NOT use built-in version of "echo" on /bin/sh

# bdump=/opt/local/bin/bdump
# bdump=/usr/local/bin/bdump
# bdumpOpts="-xb0"
bdump=/usr/bin/od
bdumpOpts="-An -tx1"
# egrep=/usr/bin/egrep
egrep=/bin/egrep
# gawk=/usr/local/bin/gawk
gawk=/usr/bin/gawk
# han2zen=$HOME/bin/h2z.rb
han2zen=$HOME/bin/h2z
# nkf=/usr/local/bin/nkf
nkf=/usr/bin/nkf
perl=/usr/bin/perl
# sed=/usr/bin/sed
sed=/bin/sed
# showfont=/usr/X11R6/bin/showfont
# showfont=/opt/X11/bin/showfont
showfont=/usr/bin/showfont
tr=/usr/bin/tr
xargs=/usr/bin/xargs


### VFONT_ROTATE=$HOME/bin/vfont-should-be-rotated.sh
VFONT_ROTATE=/bin/cat

BASENAME=/usr/bin/basename

# ----------------------------------------------------------

cmdsfound="$TRUE"

for x in bdump egrep gawk han2zen nkf perl sed showfont tr xargs VFONT_ROTATE BASENAME; do
    cmd=`eval /bin/echo '$'$x`
    if [ "x$cmd" = "x" ]; then
	cmdsfound="$FALSE"
      ( $echo ""
	$echo "*** Fatal Error *** NULL string found while searching for the full path of comamnd \"$x\"." ) 1>&2
    elif [ ! -x "$cmd" ]; then
	cmdsfound="$FALSE"
      ( $echo ""
	$echo "*** WARNING *** Can't execute $cmd" ) 1>&2
    fi
done

if [ "x$cmdsfound" != "x$TRUE" ]; then
  ( $echo ""
    $echo "*** EMERGENCY STOP !!! ***"
    $echo "" ) 1>&2
    exit 1
fi

PNAME="`($BASENAME $0 || $echo $0) 2> /dev/null`"

# ----------------------------------------------------------
# Flags
# ----------------------------------------------------------

flag_help="$FALSE"
flag_verbose="$FALSE"

# ----------------------------------------------------------
# Functions
# ----------------------------------------------------------

usage() {
    $echo ""
    $echo "Usage: `/usr/bin/basename $0` < text.dat"
    $echo ""
    $echo "Note: Don't forget to run xfs (font server) before running this command."
    $echo ""
}

showtips() {
/bin/cat << '--EOF--'
How to use this command ?

(1) get bitmap font data
    % ./ThisCommand < text.dat > /tmp/example.dat

(2) create hexadecimal font data written in C language.
    % cat /tmp/example.dat | awk '{if (/^#/){cnt++;printf "%-5s, ",$3;if(cnt%4==0){printf "\n";}}}END{printf "\n";}'

(3) create font rotation data written in C language.
    % cat /tmp/example.dat | awk -F, '{if (\!/^#/){cnt++;printf "  %s, %s,",$1,$2;if (cnt%4==0){printf "\n";}}else{printf "\n"}}'

--EOF--
}

# ----------------------------------------------------------
# Main routine
# ----------------------------------------------------------

while [ "x$1" != "x" ]; do
    case $1 in
	-v)	    flag_verbose="$TRUE"; shift;;
	-q)	    flag_verbose="$FALSE"; shift;;
	-h|-help|--help)  flag_help="$TRUE"; break;;
	*)	    break;;
    esac
done

if [ "x$flag_help" = "x$TRUE" ]; then
    usage 1>&2
    showtips 1>&2
    $echo ""
    exit 1
fi

# ----------------------------------------------------------

# pcf2bdf  -o jiskan16-2004-1.bdf jiskan16-2004-1.pcf.gz 
# pcf2bdf  -o jiskan16.bdf jiskan16.pcf.gz 

FONTFILE=$HOME/fonts/jiskan16.bdf

if [ ! -f "$FONTFILE" ]; then
  echo "Can't find font file ($FONTFILE)"
  exit 9
fi

kuten2bitmap () {
  sed -n -e "/ENCODING $1/,/ENDCHAR/p" $FONTFILE \
  | sed -n '/^BITMAP/,/^ENDCHAR/p'  \
  | egrep -v 'BITMAP|ENDCHAR'  \
  | sed 's/^/1/g'  \
  | awk '{printf "echo \"obase=2; ibase=16; %s\" | bc\n", $1}'  \
  | sh  \
  | sed -e 's/0/ /g' -e 's/^1//'
}

# ----------------------------------------------------------

kuten=$(\
$nkf -w \
| $han2zen \
| $sed -e "s/^\"//" -e "s/\"$//" \
| $tr -d '\n' \
| $nkf -j \
| $bdump $bdumpOpts \
| $tr -d '\n' \
| $tr 'a-z' 'A-Z'\
| $sed -e 's/  */ /g' -e 's/1[bB] 24 42//g' -e 's/1[bB] 28 42//g' \
| $sed -e 's/  */ /g' -e 's/ \([0-9A-Fa-f][0-9A-Fa-f]\) \([0-9A-Fa-f][0-9A-Fa-f]\)/ \1\2/g' \
| $tr ' ' '\n' \
| $gawk '{if (NF>0){printf "%3d\n",strtonum("0x"$1)}}'
)

for x in $kuten; do
  kuten2bitmap $x
done  

# $nkf -w \
# | $han2zen \
# | $sed -e "s/^\"//" -e "s/\"$//" \
# | $tr -d '\n' \
# | $nkf -j \
# | $bdump $bdumpOpts \
# | $sed -e 's/^[0-9A-Fa-f]*://' \
# | $tr -d '\n' \
# | $sed -e 's/  */ /g' -e 's/1[bB] 24 42//g' -e 's/1[bB] 28 42//g' \
# | $sed -e 's/  */ /g' -e 's/ \([0-9A-Fa-f][0-9A-Fa-f]\) \([0-9A-Fa-f][0-9A-Fa-f]\)/ \1\2/g' \
# | $tr ' ' '\n' \
# | $gawk '{if (NF>0){printf "%3d\n",strtonum("0x"$1)}}' \
# | $xargs -I % $showfont -b 2 -start % -end % -fn $TARGETFONTNAME \
# | $egrep '^-|^#|^char' \
# | $sed -e '/^[-#]/s/-/0/g' -e '/^[0#]/s/#/1/g' -e 's/ #/ /g' -e '/^char/s/^/# /g' \
# | $perl -n -e 'if (/^#/){print} else {printf "0x%s,0x%s,%s,%s,\n", unpack("H2", pack("B8",substr($_,0,8))), unpack("H2", pack("B8",substr($_,8,8))),substr($_,0,8),substr($_,8,8)}' \
# | $VFONT_ROTATE

# ----------------------------------------------------------

$echo ""

exit 0
