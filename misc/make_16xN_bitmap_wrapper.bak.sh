#! /bin/sh

# Prev update: Sat Aug 29 12:09:05 JST 2020
# Last update: Mon Sep 14 08:23:40 JST 2020

# ==========================================================
# 表示したいメッセージを makeIt() に記述すること
# ==========================================================

makeIt() {
    makeIt1

}

makeIt1() {
    dateInt=$(date "+%s")
    dateStr1="$(LC_TIME=ja_JP.UTF-8 date -jr $dateInt '+%Y年%b月%e日(%a)'  | sed 's/ //g')"
    dateStr2="$(date -jr $dateInt '+%j' | sed 's/ //g')"
    # ----
    makeBitmap "＿＿＿＿＿＿＿＿"             255 255 255
    makeBitmap "■■"                           0   0 255;
    makeBitmap "■■"                           0 255   0;
    makeBitmap "■■"                           0 255 255;
    makeBitmap "■■"                         255   0   0;
    makeBitmap "■■"                         255   0 255;
    makeBitmap "■■"                         255 255   0;
    makeBitmap "■■■■■■■■  "           255 255 255
    makeBitmap "${dateInt}"                   255   0   0
    makeBitmap "＿＿"                         255 255 255
    # ----
    # makeBitmap "おはようございます。"         255 255 255
    makeBitmap "こんにちは。"                 255 255 255
    # makeBitmap "こんばんは。"                 255 255 255
    # ----
    # makeBitmap "木いちごの夜会・"             255 255   0
    # makeBitmap "オンライン"                   255   0 255
    # makeBitmap "開催準備中"                   255 255   0
    # makeBitmap "(本放送は21:00〜) "             0 255   0
    # ----
    makeBitmap "西風プロジェクト"             255   0  255
    makeBitmap "定例ミーティング"             255   0  255
    makeBitmap "参加中"                       255 255   0
    makeBitmap "(15:00〜) "                     0 255   0
    # ----
    # makeBitmap "時刻同期共同研究"             255 255   0
    # makeBitmap "定例ミーティング参加中"       255 255   0
    # makeBitmap "(09:00〜) "                     0 255   0
    # ----
    # makeBitmap "USP研究所"                    255 255   0
    # makeBitmap "NCNTプロジェクト"             255   0 255
    # makeBitmap "定例ミーティング参加中"       255 255   0
    # makeBitmap "(14:00〜) "                     0 255   0
    # ----
    # makeBitmap "USP研究所"                    255 255   0
    # makeBitmap "技術交流会"                   255   0 255
    # makeBitmap "参加中"                       255 255   0
    # makeBitmap "(16:00〜) "                     0 255   0

    # makeBitmap "USP研究所"                    255 255   0
    # makeBitmap "名古屋センター "              255   0 255
    # makeBitmap "朝会参加中"                   255 255   0
    # makeBitmap "(08:00〜) "                     0 255   0
    # ----
    # makeBitmap "総合メディア基盤センター"     255 255   0
    # makeBitmap "情報基盤部門 "                255   0 255
    # makeBitmap "定例ミーティング開催中．"     255 255   0
    # makeBitmap "(09:30〜) "                     0 255   0

    # ----
    # makeBitmap "総合メディア基盤センター"     255 255   0
    # makeBitmap "ISMS事務局定例会"             255   0 255
    # makeBitmap "情報セキュリティ委員会"       255   0 255
    # makeBitmap "教職員会議"                   255   0 255
    # makeBitmap "参加中．"                       0 255 255
    # makeBitmap "(14:00〜) "                     0 255   0
    # ----
    # makeBitmap "富士通＆"                     255   0 255
    # makeBitmap "総合メディア基盤センター"       0 255   0
    # makeBitmap "定例ミーティング参加中．"     255 255   0
    # makeBitmap "(13:00〜) "                     0 255   0
    # ----
    # makeBitmap "第12回情報システム基盤整備WG" 255 255   0
    # makeBitmap "事前打ち合わせ"               255   0 255
    # makeBitmap "参加中．"                       0 255 255
    # makeBitmap "(14:00〜) "                     0 255   0
    # ----
    makeBitmap "本日は "                        255 255 255
    makeBitmap "${dateStr1}"                      0   0 255
    # ----
    makeBitmap "(今年になってから"                0 255 255
    makeBitmap "${dateStr2}"                    255   0 255
    makeBitmap "日目"                           255 255 255
    makeBitmap ")です。 "                         0 255 255
}

makeIt2() {
    dateInt=$(date "+%s")
    dateStr0="$(date -R -jr $dateInt)"
    dateStr1="$(LC_TIME=ja_JP.UTF-8 date -jr $dateInt '+%Y年%b月%e日(%a)'  | sed 's/ //g')"
    dateStr2="$(LC_TIME=ja_JP.UTF-8 date -jr $dateInt '+%j' | sed 's/ //g')"
    # ----
    makeBitmap "＿＿＿＿＿＿＿＿"               255 255 255
    # makeBitmap "■■■■■■■■"             255 255 255; makeBitmap "■■■■■■■■"               255 255 255
    makeBitmap "${dateInt}"                     255 255 255
    makeBitmap "＿＿"                           255 255 255
    # ----
    # makeBitmap "Hello, "                      255 255 255
    makeBitmap "Hello, "                        255   0   0
    # ----
    # makeBitmap "Welcome to "                  255   0   0
    # ----
    makeBitmap "MYTechLab "                     255   0 255
    # makeBitmap "Raspberry Gate/Guardian "     255   0 255
    # ----
    makeBitmap "Weekly Research Meeting. "      255 255   0
    # ----
    # makeBitmap "Starting from "               255 255 255
    makeBitmap "Attending from "                255 255 255
    makeBitmap "${dateStr0}"                    0     0 255
    # ----
    makeBitmap "(day"                             0 255 255
    makeBitmap "${dateStr2}"                    255   0 255
    makeBitmap ")"                                0 255 255
}

makeIt3() {
  makeBitmap "こんばんは「"          255 255 255
  makeBitmap "木いちごの夜会"        255   0 255
  makeBitmap "・"                    255 255 255
  makeBitmap "オンライン"              0 255 255
  makeBitmap "」です。 "             255 255 255
  makeBitmap "今夜も "               255 255   0
  makeBitmap "まったりと"            255   0   0
  makeBitmap "行きましょう。 "       255 255   0
}

makeIt4() {
   # dateStr="$(LC_TIME=C date '+%A, %d %b %Y')"
   # dateStr="$(LC_TIME=ja_JP.UTF-8 date '+%Y年%b月%e日(%a)[day%j]' | sed 's/ //g')"
   # dateStr=$(date|sed 's/ //g')
   dateStr=$(date)
   makeBitmap "現在時刻は "           255 255 255
   makeBitmap "$dateStr"              255   0 255
   makeBitmap "です。 "               255 255 255
   makeBitmap "赤色です。 "           255   0   0
   makeBitmap "緑色です。 "             0 255   0
   makeBitmap "黄色です。 "           255 255   0
   makeBitmap "青色です。 "             0   0 255
   makeBitmap "紫色です。 "           255   0 255
   makeBitmap "水色です。 "             0 255 255
   makeBitmap "白色です。 "           255 255 255
}

# ==========================================================
# 通常は以下はいじる必要はない
# ==========================================================

PNAME=$(basename $0)
TARGETDIR="/tmp"
PREFIX="${TARGETDIR}/tmpfile-$$"
OUTFILE="${TARGETDIR}/output-$$.ppm"
# REMOTEFILE=pi@RPi12-2.local:/tmp/output.ppm
REMOTEHOST=pi@RPi12-2.local
REMOTEDIR=$HOME/sshfs/RPi12-2
REMOTEFILE=$HOME/sshfs/RPi12-2/tmp/output.ppm
TMPFILES=

TOOL=/Users/hohno/bin/make_16xN_bitmap.sh

# ----------------------------------------------------------

exit_with_code() {
  /bin/echo -n "$PNAME: exit with code $1"
  [ "x$2" != "x" ] && /bin/echo -n " ($2)"
  echo
  exit $1
}

# ----------------------------------------------------------

makeBitmap() {
  _id=${MESG_CNT:-0}
  _message=${1:-"???"}
  _color_R=${2:-255}
  _color_G=${3:-255}
  _color_B=${4:-255}
  _tmpfile="$PREFIX"-$_id.ppm

  rm -f $_tmpfile
  echo "$_message" | $TOOL -  $_tmpfile $_color_R $_color_G $_color_B 1>&2

  [ ! -f $_tmpfile ] && exit_with_code 71 "Can't open $_tmpfile"
  [ -z $_tmpfile ]   && exit_with_code 72 "$_tmpfile is empty"

  TMPFILES="$TMPFILES $_tmpfile"
  MESG_CNT=$(($MESG_CNT + 1))
}

# ----------------------------------------------------------

[ ! -f "$TOOL" ] && exit_with_code 51 "Can't find $TOOL"

[ "x$OUTFILE" = "x" ] && exit_with_code 99 "OUTFILE is not set"
[ -f "$OUTFILE" ] && rm -f "$OUTFILE"
[ -f "$OUTFILE" ] && exit_with_code 52 "Can't delete $OUTFILE"

# ----------------------------------------------------------
# ----------------------------------------------------------

MESG_CNT=0
makeIt
echo "DEBUG: $MESG_CNT messages, FILES = $TMPFILES"

[ $MESG_CNT -eq 0 ]    && exit_with_code 91 "No available files"
[ "x$TMPFILES" = "x" ] && exit_with_code 92 "No available files"

# ----------------------------------------------------------
# ----------------------------------------------------------

echo
echo convert +append $TMPFILES "$OUTFILE"
convert +append $TMPFILES "$OUTFILE"

[ ! -f "$OUTFILE" ] && exit_with_code 93 "Can't find $OUTFILE"
[ -z "$OUTFILE" ]   && exit_with_code 94 "Size of $OUTFILE is zero"

echo
file "$OUTFILE"

touch ${REMOTEDIR}/tmp/test.txt || sshfs ${REMOTEHOST}:/home/pi/ ${REMOTEDIR}

echo
# echo scp "$OUTFILE" "$REMOTEFILE"
# scp "$OUTFILE" "$REMOTEFILE"
echo cp "$OUTFILE" "$REMOTEFILE"
cp "$OUTFILE" "$REMOTEFILE" ||  exit_with_code 95 "Did you prepare file sharing using sshfs ?"

sleep 0.1

echo "Sending a signal to the LED panel controller to update the content ..."
echo "x" | mosquitto_pub -l -t hohno/LED_MTX_CTRL -h rpi12-2.local

rm -f $TMPFILES

echo

# ----------------------------------------------------------

exit 0
