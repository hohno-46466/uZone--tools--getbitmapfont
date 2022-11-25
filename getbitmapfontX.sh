#!/bin/sh

# getbitmapfontX.sh

# First version: Tue Nov  9 07:10:37 JST 2021 (modified freom getbitmapfont.sh)

# ----------------------------------------------------------
# History of original script (getbitmapfont.sh)
# Prev updated: Mon Dec 26 08:16:28 JST 2011 by hohno
# Prev updated: Tue Nov 27 06:49:20 JST 2012 by hohno
# Prev udpate: Wed Jan 15 11:02:41 JST 2014 by hohno
# Prev udpate: Fri Jul 18 00:09:22 JST 2014 by hohno
# Last udpate: Sat Dec 27 11:34:14 JST 2014 by hohno
# ----------------------------------------------------------

# ----------------------------------------------------------
# Definition and initialize global variables
# ----------------------------------------------------------

# LANG=C export LANG
# LC_ALL=C export LC_ALL

# ----------------------------------------------------------

TRUE="TRUE"
FALSE="FALSE"

# ----------------------------------------------------------

#X# [ "x$TARGETFONTNAME" = "x" ] && TARGETFONTNAME="kanji16"
#X# [ "x$TARGETFONTSIZE" = "x" ] && TARGETFONTSIZE="16"

TARGETFONTNAME=jiskan16

# ----------------------------------------------------------

echo="/bin/echo"	# Do NOT use built-in version of "echo" included in /bin/sh

# bdump=/opt/local/bin/bdump;	bdumpOpts="-xb0"
# bdump=/usr/local/bin/bdump;	bdumpOpts="-xb0"
# bdump=$(which bdump); 	bdumpOpts="-xb0"
bdump=/usr/bin/od; 		bdumpOpts="-An -tx1"

# egrep=/usr/bin/egrep
# egrep=/bin/egrep
egrep=$(which egrep)

# gawk=/usr/local/bin/gawk
# gawk=/usr/bin/gawk
gawk=$(which gawk)

# han2zen=$HOME/bin/h2z.rb
# han2zen=$HOME/bin/h2z
han2zen=$(which h2z)

# nkf=/usr/local/bin/nkf
# nkf=/usr/bin/nkf
nkf=$(which nkf)

perl=/usr/bin/perl
perl=$(which perl)

# sed=/usr/bin/sed
# sed=/bin/sed
sed=$(which sed)

#X# # showfont=/usr/X11R6/bin/showfont
#X# # showfont=/opt/X11/bin/showfont
#X# # showfont=/usr/bin/showfont
#X# showfont=$(which showfont)

# tr=/usr/bin/tr
# tr=$(which tr)
tr=$(which tr)

#X# # xargs=/usr/bin/xargs
#X# xargs=$(which /usr/bin/xargs)

#X# ### VFONT_ROTATE=$HOME/bin/vfont-should-be-rotated.sh
#X# VFONT_ROTATE=/bin/cat

# BASENAME=/usr/bin/basename
BASENAME=$(which basename)

# ----------------------------------------------------------

cmdsfound="$TRUE"

#X# for x in bdump egrep gawk han2zen nkf perl sed showfont tr xargs VFONT_ROTATE BASENAME; do

for x in bdump egrep gawk han2zen nkf perl sed tr BASENAME; do
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
  -v)    flag_verbose="$TRUE"; shift;;
  -q)    flag_verbose="$FALSE"; shift;;
  -h|-help|--help)  flag_help="$TRUE"; break;;
  *)    break;;
  esac
done

if [ "x$flag_help" = "x$TRUE" ]; then
    usage 1>&2
    showtips 1>&2
    $echo ""
    exit 1
fi

# ----------------------------------------------------------

# Memo: foo.bdf can be generated from foo.pcf.gz like this:
#       as $pcf2bdf -o foo.bdf foo.pcf.gz

FONTFILE1=$HOME/fonts/${TARGETFONTNAME}.bdf
FONTFILE2=$HOME/fonts/.tmpfontfile

if [ ! -f "$FONTFILE1" ]; then
  echo "Can't find font file ($FONTFILE1)"
  exit 9
fi

/bin/rm -f "$FONTFILE2"
if [ -f "$FONTFILE2" ]; then
  echo "Can't erase temporary file ($FONTFILE2)"
  exit 9
fi
touch  "$FONTFILE2"
if [ ! -f "$FONTFILE2" ]; then
  echo "Can't create temporary file ($FONTFILE2)"
  exit 9
fi
/bin/rm -f "$FONTFILE2"

# ----------------------------------------------------------

#　区点コードをビットマップに変換する関数
kuten2bitmap () {				  # （$1 - 区点コード, $2 - フォントファイル）
  sed -n -e "/ENCODING $1/,/ENDCHAR/p" $2	| # 切り出し1
  sed -n '/^BITMAP/,/^ENDCHAR/p'		| # 切り出し2
  egrep -v 'BITMAP|ENDCHAR'			| # 切り出し3
  sed 's/^/1/g'				| # avoid zero-supressing
  awk '{printf "echo \"obase=2; ibase=16; %s\" | bc\n", $1}' 	| # convert to binary
  sh						| # convert to binary
  sed -e 's/^1//'				  # format （ゼロはそのまま残すのが本来の挙動）
}

#　フォントファイルから、区点コードに対応するフォントデータを抜き出す関数
kuten2fontdata () {				  # （$1 - 区点コード, $2 - フォントファイル）
  sed -n -e "/ENCODING $1/,/ENDCHAR/p" $2
}

# ----------------------------------------------------------

# 表示メッセージを1文字ずつ区点コードに変換
kuten=$(\
  $nkf -w				| # UTF-8へ
  $han2zen				| # 全角へ
  $sed -e "s/^\"//" -e "s/\"$//"	| # 前後の　”　を除去
  $tr -d '\n'				| # 改行を除去して１行にまとめる　
  $nkf -j				| # JISへ
  $bdump $bdumpOpts			| # 1バイト単位で16進数表記に変換
  $tr -d '\n'				| # 改行を除去して１行にまとめる　
  $tr 'a-z' 'A-Z'			| # 大文字に変換
  $sed -e 's/  */ /g' -e 's/1[bB] 24 42//g' -e 's/1[bB] 28 42//g' 				| # 前後のエスケープ文字を除去
  $sed -e 's/  */ /g' -e 's/ \([0-9A-Fa-f][0-9A-Fa-f]\) \([0-9A-Fa-f][0-9A-Fa-f]\)/ \1\2/g'	| # 2バイト単位にまとめる
  $tr ' ' '\n' 			| # 1文字/行　に変換
  $gawk '{if (NF>0){printf "%3d\n",strtonum("0x"$1)}}' # 16進数　→　10進数
)

# メッセージに含まれる文字だけからなるフォントファイル（FONTFILE2）を作成
/bin/rm -f "$FONTFILE2"
for x in $(echo $kuten | tr ' ' '\n' | sort -n | uniq); do
  kuten2fontdata $x "$FONTFILE1"
done > "$FONTFILE2"

# FONTFILE2 を使ってメッセージをビットマップに変換
for x in $kuten; do
  kuten2bitmap $x "$FONTFILE2"		 |
  $perl -n -e 'if (/^#/){print} else {printf "0x%s,0x%s,%s,%s,\n", unpack("H2", pack("B8",substr($_,0,8))), unpack("H2", pack("B8",substr($_,8,8))),substr($_,0,8),substr($_,8,8)}'
done

/bin/rm -f "$FONTFILE2"

#X# $nkf -w \
#X# | $han2zen \
#X# | $sed -e "s/^\"//" -e "s/\"$//" \
#X# | $tr -d '\n' \
#X# | $nkf -j \
#X# | $bdump $bdumpOpts \
#X# | $sed -e 's/^[0-9A-Fa-f]*://' \
#X# | $tr -d '\n' \
#X# | $sed -e 's/  */ /g' -e 's/1[bB] 24 42//g' -e 's/1[bB] 28 42//g' \
#X# | $sed -e 's/  */ /g' -e 's/ \([0-9A-Fa-f][0-9A-Fa-f]\) \([0-9A-Fa-f][0-9A-Fa-f]\)/ \1\2/g' \
#X# | $tr ' ' '\n' \
#X# | $gawk '{if (NF>0){printf "%3d\n",strtonum("0x"$1)}}' \
#X# | $xargs -I % $showfont -b 2 -start % -end % -fn $TARGETFONTNAME \
#X# | $egrep '^-|^#|^char' \
#X# | $sed -e '/^[-#]/s/-/0/g' -e '/^[0#]/s/#/1/g' -e 's/ #/ /g' -e '/^char/s/^/# /g' \
#X# | $perl -n -e 'if (/^#/){print} else {printf "0x%s,0x%s,%s,%s,\n", unpack("H2", pack("B8",substr($_,0,8))), unpack("H2", pack("B8",substr($_,8,8))),substr($_,0,8),substr($_,8,8)}' \
#X# | $VFONT_ROTATE

# ----------------------------------------------------------

$echo ""

exit 0
