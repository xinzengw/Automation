#!/bin/sh
#
# version of 11:36 AM 01/16/2020 PST by xzwei@juniper.net
# script use for Qfabric NW-NG-0
#

# Stop the script itself with option "stop"
 
if [ $1 ]; then
  if [ $1 = "stop" ]; then
        echo
        echo "Stop the $0 script..."
        ps x | grep $0 | grep -v stop | grep -v grep | awk '{print $1}' |  xargs kill > /dev/null 2>&1
        echo
        echo
        rm -rf *.list  > /dev/null 2>&1
        exit 0
    else
   
        echo "Note: The only option for this script is \"stop\""
        echo "please execute below command if you want stop the script."
        echo
        echo "sh $0 stop"
        echo
        exit 1
  fi
fi
 
############ default value setting ############

# set check interval and minium cpu usage threshold.

interval=5
cpu_threshold=99

# set output file name, archive size and number of files to save.
# default 20M bytes and archive up to 10 files.

save_file_name="/var/tmp/cpu_check.log"
archive_size=20000000
archive_files=10

rm -rf *.list  > /dev/null 2>&1

#add shell/cli commands below:

cat >shell.list<<SHELL_LIST

sysctl vm.loadavg
vmstat -i
ps -auxw
cli -c "show task statistics"
cli -c "show chassis routing-engine"
cli -c "show chassis fpc"
netstat -A | grep -v "stream      0      0 " | grep -v "dgram       0      0 " | grep -v "tcp4       0      0" | grep -v "udp4       0      0"
ps -alxw
cli -c "show task statistics"
cli -c "show chassis routing-engine"
cli -c "show chassis fpc"

SHELL_LIST

#add pfe commands below:
cat >pfe.list<<PFE_LIST

show heap extensive
show heap 0
show sched
show threads
show syslog messages  
show heap extensive
show heap 0
show sched
show threads

PFE_LIST

#add sfid commands below:
cat >sfid.list<<SFID_LIST

show stats
show errors last

SFID_LIST


#Function for CPU usage trigger.

idle_threshold=`expr 100 - $cpu_threshold`
chk_cpu_condition () {
   result=0
	 idle_cpu=`top -Sbq -s1 -d1 | grep idle | awk '{print $10}' | sed 's/\.[0-9]\{2,\}%//g'`
	 echo  >> $save_file_name
	 echo "==top -Sbq -s1 -d1== on `date`"  >>$save_file_name
	 top -Sbq -s1 -d1 >>$save_file_name	
	 if [ $idle_cpu -lt $idle_threshold ]; then
			result=1
	 fi
}
		
#
################### Main program here ###############################
#

while [ 1 -eq 1 ]
do

	while [ 1 -eq 1 ]
	do
	
	chk_cpu_condition 
	tag0=$result
	
		if [ $tag0 -eq 0  ]; then
		#	echo "Idle is $idle_cpu, it is not less than threshold $idle_threshold, wait 5 seconds here"
			sleep $interval
		else
		# echo "The idle is $idle_cpu, is less or equal the threshould $idle_threshold "
			break
		fi
		
	done

sleep 1
chk_cpu_condition
tag1=$result

sleep 1
chk_cpu_condition 
tag2=$result

sleep 1
chk_cpu_condition
tag3=$result


#If all three tags are 1, then trigger data collections.	
if [ $tag1 -eq 1 -a $tag2 -eq 1 -a $tag3 -eq 1 ]; then

echo  >> $save_file_name
echo "+++++++++++ Data collection been triggered (on `date`)++++++++ " >> $save_file_name
echo  >> $save_file_name

# Execute shell/cli comands.

  while read LINE
   do
           echo $LINE | egrep "^ *$|#" > /dev/null 2>&1
                        if [ $? -ne 0 ]; then
                        echo "+++++++++++ $LINE (on `date`)++++++++ " >> $save_file_name
                        echo "- - - - - - - - - - - - - - - - - - - - - - - - - - -" >> $save_file_name
                        eval $LINE  >> $save_file_name
                        echo >> $save_file_name
                fi
  done < shell.list
  
 
# Execute pfe comands.

		fpc_member=`/usr/sbin/cli -c "show virtual-chassis status" | grep FPC | grep -v jvre | awk '{print $1}'`
		for fpc_no in $fpc_member ; do
		# pfem related collections.
	  	while read LINE
	   		do
	            echo $LINE | egrep "^ *$|#" > /dev/null 2>&1
	            if [ $? -ne 0 ]; then
	                 FULL_CMD="cprod -A fpc$fpc_no -c \"$LINE\""
	                 echo "+++++++++++ $FULL_CMD(on `date`)++++++++ " >> $save_file_name
	                 echo "- - - - - - - - - - - - - - - - - - - - - - - - - - -" >> $save_file_name
	                 eval $FULL_CMD  >> $save_file_name
	                 echo >> $save_file_name
	            fi              
	  		done < pfe.list
	  
  

# Execute sfid comands.

	  	while read LINE
	   		do
	            echo $LINE | egrep "^ *$|#" > /dev/null 2>&1
	            if [ $? -ne 0 ]; then
	                 FULL_CMD="lcdd_cmd -A fpc$fpc_no -d sfid -c \"$LINE\""
	                 echo "+++++++++++ $FULL_CMD(on `date`)++++++++ " >> $save_file_name
	                 echo "- - - - - - - - - - - - - - - - - - - - - - - - - - -" >> $save_file_name
	                 eval $FULL_CMD  >> $save_file_name
	                 echo >> $save_file_name
	            fi              
	  		done < sfid.list

   done
fi


# Check if need archive saved logs

SAVE_FILE_SIZE=`ls -l $save_file_name | awk '{print $5}'`
if [ $SAVE_FILE_SIZE -ge $archive_size ]; then
       CURR_ARICHIVE_NUMBBER=`expr $archive_files - 1`
       while [ $CURR_ARICHIVE_NUMBBER -ge 0 ]
       do
          rm -rf $save_file_name.$archive_files.tgz > /dev/null 2>&1
      		OLD_ARICHIVE_NUMBBER=$CURR_ARICHIVE_NUMBBER
          CURR_ARICHIVE_NUMBBER=`expr $CURR_ARICHIVE_NUMBBER - 1`
          /bin/mv $save_file_name.$CURR_ARICHIVE_NUMBBER.tgz $save_file_name.$OLD_ARICHIVE_NUMBBER.tgz > /dev/null 2>&1
 
    	done
   
     tar -czvf $save_file_name.0.tgz $save_file_name > /dev/null 2>&1
     rm -rf $save_file_name
    
fi


sleep $interval
done

#EOF

