#!/bin/sh
#
# This is for collect routing information. New EX and QFX.
# Usage: sh l3info.sh fpc#
# Question for this script, please mail to xzwei@juniper.net
# version of 2017-11-05 21:30 PDT

PATH=$PATH:/bin:/usr/bin:/usr/sbin

if echo $1 | grep -v fpc ; then
	echo  "0: Need give fpc# as parameter"
	exit 0
fi

echo $1 | sed 's/fpc//g'| egrep -q '^[0-9]+$'
if [ $? -ne 0 ]; then
	echo  "1: Need give fpc# as parameter"
  exit 0
fi

######
SAVE_NAME="l3_info_dump"
SAVE_FILE_NO=`ls -l /var/log | grep $SAVE_NAME.$1 | wc -l | sed 's/ //g'` > /dev/null 2>&1
######

QFX_BCM_PREFIX="set dcb bc"
EX4300_BCM_PREFIX="set exb bc"


#add your shell commands here

cat >shell.list<<SHELL_LIST

arp -an
nhinfo -da
rtinfo -rnV
cli show ethernet-switching table
cli -c "show route forwarding-table all extensive"
cli -c "show route detail"

SHELL_LIST

#add your pfe commands here
cat >pfe.list<<PFE_LIST

show nhdb all extensive

PFE_LIST

# add your BCM commands here

cat >bcm.list<<BCM_LIST

l3 l3table show
l3 defip show
l3 intf show
l3 egress show

BCM_LIST


QFX_BCM_PREFIX="set dcb bc"
EX4300_BCM_PREFIX="set exb bc"
CMD_PREFIX=$QFX_BCM_PREFIX
sysctl hw.product.model | grep ex4300 > /dev/null 2>&1
if [ $? -eq 0 ]; then

  CMD_PREFIX=$EX4300_BCM_PREFIX
fi


# Execute shell/cli comands.

  while read LINE
   do
	   echo $LINE | egrep "^ *$|#" > /dev/null 2>&1
			if [ $? -ne 0 ]; then
			echo "+++++++++++ $1: $LINE (on `date`)++++++++ "
			echo "+++++++++++ $1: $LINE (on `date`)++++++++ " >> /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO
			echo "- - - - - - - - - - - - - - - - - - - - - - - - - - -" >> /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO
			eval $LINE  >> /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO
			echo >> /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO

		fi
  done < shell.list


# Execute pfe shell comands.


  while read LINE
   do
		echo $LINE | egrep "^ *$|#" > /dev/null 2>&1
		if [ $? -ne 0 ]; then
				FULL_CMD="cprod -A fpc0 -c \"$LINE\""
				echo "+++++++++++ $1: $FULL_CMD (on `date`)++++++++ "
				echo "+++++++++++ $1: $FULL_CMD(on `date`)++++++++ " >> /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO
				echo "- - - - - - - - - - - - - - - - - - - - - - - - - - -" >> /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO
				eval $FULL_CMD  >> /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO
				echo >> /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO
			fi
		
  done < pfe.list
  
# Execute BRCM shell comands.

  while read LINE
   do 
		echo $LINE | egrep "^ *$|#" > /dev/null 2>&1
		if [ $? -ne 0 ]; then
				FULL_CMD="cprod -A fpc0 -c '$CMD_PREFIX \"$LINE\"'"
				
		
				echo "+++++++++++ $1: $FULL_CMD (on `date`)++++++++ "
				echo "+++++++++++ $1: $FULL_CMD(on `date`)++++++++ " >> /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO
				echo "- - - - - - - - - - - - - - - - - - - - - - - - - - -" >> /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO
			 	eval $FULL_CMD  >> /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO
				echo >> /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO
			fi
		
  done < bcm.list
  
rm -rf *.list

gzip /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO

echo
echo "$1 : $0 logs been saved to /var/log/$SAVE_NAME.$1.$SAVE_FILE_NO.gz"

echo
echo "Done !!!" 
echo

#EOF




        
        






