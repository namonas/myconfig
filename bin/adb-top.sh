#!/bin/sh

while true
do
  adb shell 'top -m 10 -d 1 -n 1 -s cpu; date;'
  sleep 5
done

