#!/bin/sh

# Prev update: Sat Aug 29 12:09:05 JST 2020
# Prev update: Mon Sep 14 08:23:40 JST 2020
# Prev update: Tue Sep 22 07:47:45 JST 2020
# Last update: Sat Dec 12 14:09:57 JST 2020

# ----------------------------------------------------------

#
# 事前準備
#
# ・X11 が起動していること．たとえば以下を実行しておけば X11 は起動したままになる
#   $ xclock -update 1 &
#
# ・sshfs でのファイル共有も必要
#  ・共有開始
#    $ sshfs pi@RPi12-2.local:/home/pi ~/sshfs/RPi12-2
#  ・共有終了
#    $ sudo umount /home/hohno/sshfs/RPi12-2
#
# 実行例：
#
# ・sshfs でファイル共有ができていれば，以下のコマンドを実行後に，イメージファイルの転送，led-matrix コマンドの再起動まで行ってくれる
#
# (例1) - makeIt() の内容にしたがってビットイメージを作成
#   $ ./make_16xN_bitmap_wrapper.sh
#
# (例2) - コマンドライン引数をもとにビットイメージを作成（色指定あり）
#   $ ./make_16xN_bitmap_wrapper.sh Red "赤色です。" Green "緑色です。" Blue "青色です。" Cyan "水色です。" Magenta "紫色です。" Yellow "黄色です。" White "白色です。"
#
# (例3) - コマンドライン引数をもとにビットイメージを作成（色指定指定なし）
#   $ ./make_16xN_bitmap_wrapper.sh "これはメッセージです"


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
    makeBitmap "石川県金沢市を中心に活動する"       255 255   0
    makeBitmap "電子工作愛好者集団"                   0 255 255
    makeBitmap "木いちごの会"                       255   0 255
    makeBitmap "です。"                                 0 255 255
    makeBitmap "今回は、"                           255 255 255
    makeBitmap "新作の"                             255   0   0
    makeBitmap "電子工作用作業台 "                   0  255 255
    makeBitmap "で作ったあれこれをデモしています "     0 255   0
    makeBitmap "ちなみにこの電光掲示板は、今となっては珍しい"       0 255 255
    makeBitmap "初代のラズパイ"                     255   0   0
    makeBitmap "で動いています。もうだいぶ古いです。^^;..."       0 255 255
    # makeBitmap "今回は、電子工作用作業台を使ってあれこれデモしています "             0 255   0
    # ----
    # makeBitmap "木いちごの夜会・"             255 255   0
    # makeBitmap "オンライン"                   255   0 255
    # makeBitmap "開催準備中"                   255 255   0
    # makeBitmap "(本放送は21:00〜) "             0 255   0
    # ----
    # makeBitmap "西風プロジェクト"             255 255   0
    # makeBitmap "定例ミーティング"             255   0  255
    # makeBitmap "参加中"                       255 255   0
    # makeBitmap "(15:00〜) "                     0 255   0
    # ----
    # makeBitmap "時刻同期共同研究"             255 255   0
    # makeBitmap "定例ミーティング参加中"       255   0   0
    # makeBitmap "参加中"                       255 255   0
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
    # makeBitmap "＆"                           255 255 255
    # makeBitmap "附属病院 "                    255   0 255
    # makeBitmap "定例会開催中．"               255 255   0
    # makeBitmap "(09:30〜) "                     0 255   0
    # ----
    # makeBitmap "総合メディア基盤センター"     255 255   0
    # makeBitmap "ISMSマネジメントレビュー"     255   0 255
    # makeBitmap "開催中．"                     255 255   0
    # makeBitmap "(10:00〜) "                     0 255   0
    # ----
    # makeBitmap "総合メディア基盤センター"     255 255   0
    # makeBitmap "ISMS事務局定例会"             255   0 255
    # makeBitmap "情報セキュリティ委員会"       255   0 255
    # makeBitmap "教職員会議"                   255   0 255
    # makeBitmap "参加中．"                     255 255   0
    # makeBitmap "(14:00〜) "                     0 255   0
    # ----
    # makeBitmap "富士通"                       255 255   0
    # makeBitmap "＆"                           255 255 255
    # makeBitmap "総合メディア基盤センター"     255   0   0
    # makeBitmap "定例ミーティング参加中．"     255 255   0
    # makeBitmap "(13:00〜) "                     0 255   0
    # ----
    # makeBitmap "第12回情報システム基盤整備WG" 255 255   0
    # makeBitmap "事前打ち合わせ"               255   0 255
    # makeBitmap "参加中．"                     255 255   0
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
    makeBitmap "${dateInt}"                     255   0   0
    makeBitmap "＿＿"                           255 255 255
    # ----
    makeBitmap "Hello, "                        255 255 255
    # makeBitmap "Welcome to "                  255 255 255
    # ----
    makeBitmap "MYTechLab "                     255 255   0
    # makeBitmap "Raspberry Gate/Guardian "     255 255   0
    # ----
    makeBitmap "Weekly Research Meeting. "      255   0 255
    # ----
    makeBitmap "Starting from "                 255 255   0
    # makeBitmap "Attending from "              255 255   0
    makeBitmap "${dateStr0}"                      0 255   0
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
   #old# dateStr="$(LC_TIME=C date '+%A, %d %b %Y')"
   #old# dateStr="$(LC_TIME=ja_JP.UTF-8 date '+%Y年%b月%e日(%a)[day%j]' | sed 's/ //g')"
   #old# dateStr=$(date|sed 's/ //g')
   dateInt=$(date "+%s")
   dateStr1="$(LC_TIME=ja_JP.UTF-8 date -jr $dateInt '+%Y年%b月%e日(%a)'  | sed 's/ //g')"
   dateStr2="$(date -jr $dateInt '+%j' | sed 's/ //g')"
   dateStr0=$(date -jr $dateInt)
   # ----
   makeBitmap "現在時刻は "           255 255 255
   makeBitmap "$dateStr0"             255   0 255
   makeBitmap "です。 "               255 255 255
   makeBitmap "赤色です。 "           255   0   0
   makeBitmap "緑色です。 "             0 255   0
   makeBitmap "黄色です。 "           255 255   0
   makeBitmap "青色です。 "             0   0 255
   makeBitmap "紫色です。 "           255   0 255
   makeBitmap "水色です。 "             0 255 255
   makeBitmap "白色です。 "           255 255 255
   # ----
   makeBitmap "本日は "               255 255 255
   makeBitmap "${dateStr1}"             0   0 255
   # ----
   makeBitmap "(今年になってから"       0 255 255
   makeBitmap "${dateStr2}"           255   0 255
   makeBitmap "日目"                  255 255 255
   makeBitmap ")です。 "                0 255 255
}

# ----------------------------------------------------------

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

MESG_CNT=0
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

# ccv_X - current color value for X

setCurrentColorVal() {
    case "$1" in
	"白" | "白色" | "white" | "White" | "WHITE" )
	    ccv_R=255;  ccv_G=255;  ccv_B=255;;
	"赤" | "赤色" | "red" | "Red" | "RED" )
	    ccv_R=255;  ccv_G=0;    ccv_B=0;;
	"緑" | "緑色" | "green" | "Green" | "GREEN" )
	    ccv_R=0;    ccv_G=255;  ccv_B=0;;
	"青" | "青色" | "blue" | "Blue" | "BLUE" )
	    ccv_R=0;    ccv_G=0;    ccv_B=255;;
	"水" | "水色" | "cyan" | "Cyan" | "CYAN" )
	    ccv_R=0;    ccv_G=255;  ccv_B=255;;
	"紫" | "紫色" | "purple" | "Purple" | "PURPLE" | "magenta"  | "Magenta"  | "MAGENTA" )
	    ccv_R=255;  ccv_G=0;    ccv_B=255;;
	"黄" | "黄色" | "yellow" | "Yellow" | "YELLOW" )
	    ccv_R=255;  ccv_G=255;  ccv_B=0;;
	"黒" | "黒色" | "black" | "Black" | "BLACK" )
	    ccv_R=0;    ccv_G=0;    ccv_B=0;;
	*)
	    ccv_R=255;  ccv_G=255;  ccv_B=255;;
    esac
}

# ----------------------------------------------------------

usage() {
  echo "usage: ${PNAME}"
  echo "usage: ${PNAME} \"message\""
  echo "usage: ${PNAME} color \"message\" [ [color \"message\"]... ]"
  exit 99
}

# ----------------------------------------------------------

[ ! -f "$TOOL" ] && exit_with_code 50 "Can't find $TOOL"

[ "x$OUTFILE" = "x" ] && exit_with_code 51 "OUTFILE is not set"
[ -f "$OUTFILE" ] && rm -f "$OUTFILE"
[ -f "$OUTFILE" ] && exit_with_code 52 "Can't delete $OUTFILE"


# ----------------------------------------------------------
# 処理開始（実質的にはここからスタート）
# ----------------------------------------------------------

[ "x$1" = "x-h" -o "x$1" = "x--help" ] && usage

MESG_CNT=0
TMPFILES=

if [ "x$1" = "x" ]; then
   # 引数なし
    makeIt

elif [ "x$2" = "x" ]; then
   # 引数ひとつだけ（単色でのメッセージ表示)
    echo makeBitmap "$1" 255 255 255
    makeBitmap "$1" 255 255 255
else
  # 引数が二つあるいはそれ以上
  while [ "x$2" != "x" ]; do
    # doit
    setCurrentColorVal $1
    echo makeBitmap "$2" $ccv_R $ccv_G $ccv_B
    makeBitmap "$2" $ccv_R $ccv_G $ccv_B
    shift; shift
  done
fi

echo "DEBUG: $MESG_CNT messages, FILES = \"$TMPFILES\""

[ $MESG_CNT -eq 0 ]    && exit_with_code 91 "No available files"
[ "x$TMPFILES" = "x" ] && exit_with_code 92 "No available files"

# ----------------------------------------------------------

echo
echo convert +append $TMPFILES "$OUTFILE"
convert +append $TMPFILES "$OUTFILE"

[ ! -f "$OUTFILE" ] && exit_with_code 93 "Can't find $OUTFILE"
[ -z "$OUTFILE" ]   && exit_with_code 94 "Size of $OUTFILE is zero"

echo
file "$OUTFILE"

touch ${REMOTEDIR}/tmp/test.txt 2>&1 > /dev/null  || sshfs ${REMOTEHOST}:/home/pi/ ${REMOTEDIR}

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
