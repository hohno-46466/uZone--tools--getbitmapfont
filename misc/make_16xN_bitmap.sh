#!/bin/sh

# ----------------------------------------------------------

# Last update: Sat Aug 29 09:09:27 JST 2020

# ----------------------------------------------------------

exit_with_code() {
  /bin/echo -n "${PNAME}: exit with code $1"
  [ "x$2" != "x" ] && /bin/echo -n " ($2)"
  echo
  rm -f ${TMPFILE1} ${TMPFILE2} ${PPMFILE1}
  exit $1
}

# ----------------------------------------------------------

# usage: make_16xN_bitmap.sh [input.txt [output.ppm [RED [GREEN [BLUE]]]]]

PNAME=$(basename $0)
INPUT=${1-"input.txt"}
OUTPUT=${2-"output.ppm"}
TMPDIR=/tmp
PPMFILE1=/tmp/text2ppm-out.ppm
TMPFILE1=${TMPDIR}/tmpfile1
TMPFILE2=${TMPDIR}/tmpfile2
# REMOTEHOST=RPi12-2.local

TOOL="$HOME/bin-hohno-MBP-2014A/text2ppm.sh"

RED=${3-255}
GREEN=${4-255}
BLUE=${5-255}

RED=$(echo "$RED" | awk '{printf "%d\n", ($1 < 0) ? 0 : ($1 > 255) ? 255 : $1}')
GREEN=$(echo "$GREEN" | awk '{printf "%d\n", ($1 < 0) ? 0 : ($1 > 255) ? 255 : $1}')
BLUE=$(echo "$BLUE" | awk '{printf "%d\n", ($1 < 0) ? 0 : ($1 > 255) ? 255 : $1}')
COLORS="$RED $GREEN $BLUE"

# ----------------------------------------------------------

# echo "[$INPUT] [$OUTPUT] [$TMPDIR] [$PPMFILE1] [$TMPFILE1] [$TMPFILE2] [$RED] [$GREEN] [$BLUE] [$COLORS]""

[ ! -f $TOOL ] && exit_with_code 99 "Can't find $TOOL"
[ ! -x $TOOL ] && exit_with_code 98 "$TOOL is not an executable"

rm -f ${TMPFILE1} ${TMPFILE2} ${PPMFILE1} ${OUTPUT}

# text2ppm.sh で PPM ファイルを作成
cat $INPUT | $TOOL || exit_with_code 91
[ -f ${PPMFILE1} ] || exit_with_code 92

# 白黒反転した上でアスキー形式で書き出す
convert -negate ${PPMFILE1} -compress none ${TMPFILE1}.ppm || exit_with_code 93
[ -f ${TMPFILE1}.ppm ] || exit_with_code 94

# 16bit形式から 8bit形式に変更（もっとまともな方法がありそう）
sed -e "s/65535 65535 65535/$COLORS/g" -e 's/65535/255/g' ${TMPFILE1}.ppm > ${TMPFILE2}.ppm || exit _with_code 95
[ -f ${TMPFILE2}.ppm ] || exit_with_code 96

# バイナリ形式で書き出す
convert ${TMPFILE2}.ppm ${OUTPUT} || exit_with_code 97
[ -f $OUTPUT ] || exit_with_code98

# ls -l $OUTPUT

rm -f ${TMPFILE1} ${TMPFILE2} ${PPMFILE1}

# ----------------------------------------------------------

