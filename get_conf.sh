#!/bin/sh
# get_conf.sh : get configuration file from RSI.
# Usage:=================================================================
# usage: sh get_conf.sh [RSI file name] <output configuration file name>
# Usage:=================================================================
# <output configuratoin file name> is option.
# Question on this script, please email to xzwei@juniper.net.
# Version of Sep 19 20:28 PDT


if [ -z $1 ]; then
	echo
	echo "Error: Need give RSI file name!"
	echo "       Usage: sh get_conf.sh [RSI file name]"
	echo
	exit
elif [ ! -f $1 ]; then

	echo
	echo "Error: file $1 is not existed in currrent folder!"
	echo
	exit
fi


if [ -z $2 ]; then

	path=`pwd`
	echo $path | egrep "201[5-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]" > /dev/null 2>&1	
	if [ $? -ne 0 ];then
	        CONF_FILENAME=output_conf.txt
	else
	        filename_prefix=`echo $path | sed 's/.*\/201/201/g' | sed 's/\/.*//g'`
	        CONF_FILENAME=$filename_prefix.conf.txt
	fi

else

	CONF_FILENAME=$2

fi


egrep "show configuration" $1 | grep "SECRET-DATA" > /dev/null 2>&1	
if [ $? -eq 0 ];then
	sed -n '/show configuration \| except SECRET-DATA/,$p' $1 | sed '/show interfaces extensive no-forwarding/,$d' | sed -n '/version/,$p' |awk '/root-authentication/{print;print "        encrypted-password \"$1$GEiCtgMX$KTB1xFg93QU.lfpgtniWL0\"; ## SECRET-DATA";next}1' > $CONF_FILENAME
else
	echo
	echo "Is $1 a vaild RSI file?"
	echo
	exit
fi

echo
echo "Configuratoin file been created from RSI file $1"
echo
echo "File name: $CONF_FILENAME"
echo


#EOF


