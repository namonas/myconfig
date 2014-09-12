#!/bin/sh
for var in `ls -1 *.a`
do
	echo $var
	arm-eabi-objdump -D $var > $var.dump
done
