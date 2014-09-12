#!/bin/sh

BUFIFS=$IFS
IFS=

# deviceリストをファイルに取得
adb devices > choice_tmp

DEVICE_ID_YAMA=

i=0
while read LINE
do
    # タブで区切られている行の第一フィールドのみ抜き出す. ex) 000000001111<\t>device
    DEVICE_ID_YAMA=`echo ${LINE} | cut -s -f 1`
    
    #deviceIDがあれば表示する
    if [ ${DEVICE_ID_YAMA} ]
    then
        echo "${DEVICE_ID_YAMA} : [${i}]"

        i=`expr ${i} + 1`
        DEVICE_ID_YAMA=
    fi
done < choice_tmp

# deviceが接続されていなければ終了
if [ ${i} -eq 0 ]
then
    echo "デバイスが接続されていません。"
    return 1
fi

echo "adbを実行するデバイスの番号を入力してください :"
read DEVICE_NUMBER

i=0
while read LINE
do
    # タブで区切られている行の第一フィールドのみ抜き出す
    DEVICE_ID_YAMA=`echo ${LINE} | cut -s -f 1`

    if [ ${DEVICE_ID_YAMA} ]
    then
        # 指定されたデバイス番号なら表示し、ファイルに出力する
        if [ ${i} -eq  ${DEVICE_NUMBER} ]
        then
            echo "choose ${DEVICE_ID_YAMA} : [${DEVICE_NUMBER}]"
            echo ${DEVICE_ID_YAMA} >device_id_yama
            break
        fi

        i=`expr ${i} + 1`
        DEVICE_ID_YAMA=
    fi
done < choice_tmp

rm choice_tmp

IFS=$BUFIFS
