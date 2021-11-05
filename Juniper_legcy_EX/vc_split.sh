#!/bin/sh
#
# Question for this script, please mail to xzwei@juniper.net
# version of 2012-11-15 00:20 CST
#
# Please run the script in each member in background with below command.
#
#  % sh vc_split.sh &
#
# To stop the script, please run do below
#
#  % sh vc_split.sh stop
#


PATH=$PATH:/bin:/usr/bin:/usr/sbin

###################################
## stop script by this section   ##
###################################

case "$1" in
stop|STOP)

ps -auxw | grep $0 | grep -v grep | grep -v stop > kill.pids
	pid_number=`awk '{print $2}' kill.pids`
	for process_pid in $pid_number; do
		kill -9 $process_pid 
	echo "stopped !"
	done
	rm -rf kill.pids
exit 0
        ;;
*)
echo "running the script directly..."
echo
        ;;
esac

##########################################

fpc_valid_orig=`sysctl -a | grep valid_bitmap | awk '{print $2;}'` 

##########################################
#  set the path for the data collection  #
##########################################

log_save_path="/var/tmp"
list_save_path="/root"
save_folder="split_debug"

#####################
# Main program here #
#####################

rm -rf $log_save_path/$save_folder  > /dev/null 2>&1
rm -rf $list_save_path/*.list  > /dev/null 2>&1


#shell commands
    echo "top -Sbq -s1 -d1" >>  $list_save_path/shell.list
    echo "df -k" >>  $list_save_path/shell.list
    echo "netstat -s" >>  $list_save_path/shell.list
    echo "netstat -Aan" >>  $list_save_path/shell.list

    echo "bmebinfo -C" >>  $list_save_path/shell.list
    echo "bmebinfo -F" >>  $list_save_path/shell.list
    echo "bmebinfo -n" >>  $list_save_path/shell.list
    echo "bmebinfo -E" >>  $list_save_path/shell.list

    echo "rtinfo -rnV" >>  $list_save_path/shell.list
    echo "rtinfo -rnV -f inet" >>  $list_save_path/shell.list
    echo "rtinfo -rnV -f msti" >>  $list_save_path/shell.list
    echo "rtinfo -rnV -f vlan-classification" >>  $list_save_path/shell.list
    echo "vlaninfo -av" >>  $list_save_path/shell.list
    echo "nhinfo -a -d" >>  $list_save_path/shell.list

    echo "bmebinfo -C" >>  $list_save_path/shell.list
    echo "bmebinfo -F" >>  $list_save_path/shell.list
    echo "bmebinfo -n" >>  $list_save_path/shell.list
    echo "bmebinfo -E" >>  $list_save_path/shell.list

    echo "tnpdump" >>  $list_save_path/shell.list

#cli commands

    echo "show ethernet-switching table detail | no-more" >>  $list_save_path/cli.list
    echo "show arp no-resolve | no-more" >>  $list_save_path/cli.list
    echo "show firewall | no-more" >>  $list_save_path/cli.list
    echo "show system statistics no-forwarding | no-more" >>  $list_save_path/cli.list
    echo "show route forwarding-table | no-more" >>  $list_save_path/cli.list
    echo "show interfaces queue | no-more" >>  $list_save_path/cli.list

    echo "show virtual-chassis status" >>  $list_save_path/cli.list
    echo "show virtual-chassis vc-port" >>  $list_save_path/cli.list
    echo "show virtual-chassis active-topology" >>  $list_save_path/cli.list
    echo "show virtual-chassis protocol database extensive" >>  $list_save_path/cli.list
    echo "show virtual-chassis protocol interface detail" >>  $list_save_path/cli.list
    echo "show virtual-chassis protocol adjacency all-members extensive" >>  $list_save_path/cli.list
    echo "show virtual-chassis protocol route" >>  $list_save_path/cli.list
    echo "show virtual-chassis protocol statistics" >>  $list_save_path/cli.list

#pfem commands
    echo "show mem" >>   $list_save_path/pfem.list
    echo "show socket" >>   $list_save_path/pfem.list
    echo "show ifd brief" >> $list_save_path/pfem.list
    echo "show ifl brief" >> $list_save_path/pfem.list
    echo "show shim packet-desc device 0" >> $list_save_path/pfem.list
    echo "show shim packet-desc device 1" >> $list_save_path/pfem.list
    echo "show ipv4 address" >> $list_save_path/pfem.list
    echo "show nhdb" >> $list_save_path/pfem.list
    echo "show nhdb management hold" >> $list_save_path/pfem.list
    echo "show nhdb management ipc" >> $list_save_path/pfem.list
    echo "show nhdb management resolve" >> $list_save_path/pfem.list
    echo "show threads verbose" >>   $list_save_path/pfem.list
    echo "show pfe manager statistics" >>   $list_save_path/pfem.list
    echo "show pfe manager session statistics" >>   $list_save_path/pfem.list
    echo "show ukern_trace global" >>   $list_save_path/pfem.list
    echo "show ukern_trace handles" >>   $list_save_path/pfem.list
    echo "show route arp" >> $list_save_path/pfem.list
    echo "show route arp table" >> $list_save_path/pfem.list
    echo "show route bridge" >> $list_save_path/pfem.list
    echo "show route bridge table" >> $list_save_path/pfem.list
    echo "show route ip" >> $list_save_path/pfem.list
    echo "show route ip table" >> $list_save_path/pfem.list
    echo "show route manager statistics" >> $list_save_path/pfem.list
    echo "show shim packet-desc device 0" >> $list_save_path/pfem.list
    echo "show shim packet-desc device 1" >> $list_save_path/pfem.list
    echo "show route prefix proto arp detail" >> $list_save_path/pfem.list
    echo "show route prefix proto bridge detail" >> $list_save_path/pfem.list
    echo "show route prefix proto ip detail" >> $list_save_path/pfem.list
    echo "show route prefix proto vmem detail" >> $list_save_path/pfem.list
    echo "show route prefix proto msti" >> $list_save_path/pfem.list
    echo "show route table" >> $list_save_path/pfem.list
    echo "show route vlan" >> $list_save_path/pfem.list
    echo "show route vmem" >> $list_save_path/pfem.list
    echo "show shim packet-desc device 0" >> $list_save_path/pfem.list
    echo "show shim packet-desc device 1" >> $list_save_path/pfem.list
    echo "show shim bridge fdb" >> $list_save_path/pfem.list
    echo "show shim bridge interface" >> $list_save_path/pfem.list
    echo "show shim bridge interface extensive" >> $list_save_path/pfem.list
    echo "show shim bridge interface mac-filters" >> $list_save_path/pfem.list
    echo "show shim bridge interface spanning-tree-state" >> $list_save_path/pfem.list
    echo "show shim bridge multicast" >> $list_save_path/pfem.list
    echo "show shim bridge sec-breach" >> $list_save_path/pfem.list
    echo "show shim bridge statistics" >> $list_save_path/pfem.list
    echo "show shim bridge statistics" >> $list_save_path/pfem.list    
    echo "show shim bridge vlan" >> $list_save_path/pfem.list
    echo "show shim bridge vlan translation-table" >> $list_save_path/pfem.list
    echo "show shim packet-descriptor" >> $list_save_path/pfem.list
    echo "show shim trunk statistics" >> $list_save_path/pfem.list
    echo "show shim bridge sw-statistics" >> $list_save_path/pfem.list
    echo "show shim bridge interface spanning-tree-state validate" >> $list_save_path/pfem.list
    echo "show route msti" >> $list_save_path/pfem.list
    echo "show shim packet-desc device 0" >> $list_save_path/pfem.list
    echo "show shim packet-desc device 1" >> $list_save_path/pfem.list


    # show HALP
    echo "show halp-nh arp-table" >> $list_save_path/pfem.list
    echo "show halp-nh statistics" >> $list_save_path/pfem.list
    echo "show halp-nh tun-table" >> $list_save_path/pfem.list
    echo "show halp-rt effuse-status" >> $list_save_path/pfem.list
    echo "show halp-rt effuse-status" >> $list_save_path/pfem.list
    echo "show halp-rt mpls-defaults" >> $list_save_path/pfem.list
    echo "show halp-rt route block_counters" >> $list_save_path/pfem.list
    echo "show halp-rt route block_counters" >> $list_save_path/pfem.list
    echo "show halp-rt route block_counters" >> $list_save_path/pfem.list
    echo "show halp-rt route block_counters" >> $list_save_path/pfem.list
    echo "show halp-rt route-table ip rtt-index 0" >> $list_save_path/pfem.list
    echo "show halp-rt route-table ip rtt-index 0 summary" >> $list_save_path/pfem.list
    echo "show halp-rt route-table mpls rtt-index 0" >> $list_save_path/pfem.list
    echo "show halp-rt route-table mpls rtt-index 0 summary" >> $list_save_path/pfem.list
    echo "show halp-rt statistics" >> $list_save_path/pfem.list
    echo "show halp-rt tcam dev-num 0" >> $list_save_path/pfem.list
    echo "show halp-rt tcam dev-num 1" >> $list_save_path/pfem.list
    echo "show halp-rt tcam dev-num 2" >> $list_save_path/pfem.list
    echo "show halp-rt_nh statistics" >> $list_save_path/pfem.list
    echo "show halp-rt_nh table" >> $list_save_path/pfem.list
    echo "show halp-rt_nh tree" >> $list_save_path/pfem.list
    echo "show halp-rt_nh tree error" >> $list_save_path/pfem.list
    echo "show halp-cos buffer" >> $list_save_path/pfem.list
    echo "show halp-cos buffer" >> $list_save_path/pfem.list
    echo "show halp-rt effuse-status" >> $list_save_path/pfem.list
    echo "show halp-rt route block_counters" >> $list_save_path/pfem.list
    echo "show shim packet-desc device 0" >> $list_save_path/pfem.list
    echo "show shim packet-desc device 1" >> $list_save_path/pfem.list

	
    #pfem filter related commands list

    echo "show filter" >> $list_save_path/pfem.list
    echo "show graph filter-class PACL" >> $list_save_path/pfem.list
    echo "show graph filter-class VACL" >> $list_save_path/pfem.list
    echo "show graph filter-class RACL" >> $list_save_path/pfem.list
    echo "show graph filter-class EPCL" >> $list_save_path/pfem.list
    echo "show tcam vendor 1 rule" >> $list_save_path/pfem.list
    echo "show tcam vendor 1 instance" >> $list_save_path/pfem.list


    echo "show filter counters" >> $list_save_path/pfem.list
    echo "show halp-dfw counters" >> $list_save_path/pfem.list
    echo "show ukern_trace 9" >> $list_save_path/pfem.list
    echo "show syslog messages" >> $list_save_path/pfem.list

if [ -f /usr/sbin/lcdd_cmd ] ; then

#sfid commands

    echo "show stats" >> $list_save_path/sfid.list
    echo "show device 0" >> $list_save_path/sfid.list
    echo "show ring stats 0 8" >> $list_save_path/sfid.list
    echo "show device 1" >> $list_save_path/sfid.list
    echo "show ring stats 1 8" >> $list_save_path/sfid.list
    echo "show device 2" >> $list_save_path/sfid.list
    echo "show ring stats 2 8" >> $list_save_path/sfid.list
    echo "show stats" >> $list_save_path/sfid.list
    echo "show ifd" >> $list_save_path/sfid.list
    echo "show ifd vcp-0" >> $list_save_path/sfid.list
    echo "show ifd vcp-1" >> $list_save_path/sfid.list
    echo "show queue" >> $list_save_path/sfid.list
    echo "show bufpool global_buf_pool" >> $list_save_path/sfid.list
    echo "show bufpool sfi_bme_bufpool" >> $list_save_path/sfid.list
    echo "show aaau stats" >> $list_save_path/sfid.list
    echo "show ifd vcp-0" >> $list_save_path/sfid.list
    echo "show ifd vcp-1" >> $list_save_path/sfid.list
    echo "show vc param" >> $list_save_path/sfid.list
    echo "show errors last" >> $list_save_path/sfid.list


#chassism commands

    echo "vcifstats internal-0/24 extensive" >> $list_save_path/chassism.list
    echo "vcifstats internal-0/25 extensive" >> $list_save_path/chassism.list
    echo "vcifstats internal-0/26 extensive" >> $list_save_path/chassism.list
    echo "vcifstats internal-0/27 extensive" >> $list_save_path/chassism.list

    echo "vcifstats internal-1/24 extensive" >> $list_save_path/chassism.list
    echo "vcifstats internal-1/25 extensive" >> $list_save_path/chassism.list
    echo "vcifstats internal-1/26 extensive" >> $list_save_path/chassism.list
    echo "vcifstats internal-1/27 extensive" >> $list_save_path/chassism.list

    echo "show ifd terse"  >> $list_save_path/chassism.list
    echo "devrtinfo" >> $list_save_path/chassism.list
    echo "devmapinfo 0" >> $list_save_path/chassism.list
    echo "devmapinfo 1" >> $list_save_path/chassism.list
    echo "devmapinfo 2" >> $list_save_path/chassism.list
    echo "vcifstats vcp-0 extensive" >> $list_save_path/chassism.list
    echo "vcifstats vcp-1 extensive" >> $list_save_path/chassism.list

    echo "vcifstats internal-0/24 extensive" >> $list_save_path/chassism.list
    echo "vcifstats internal-0/25 extensive" >> $list_save_path/chassism.list
    echo "vcifstats internal-0/26 extensive" >> $list_save_path/chassism.list
    echo "vcifstats internal-0/27 extensive" >> $list_save_path/chassism.list

    echo "vcifstats internal-1/24 extensive" >> $list_save_path/chassism.list
    echo "vcifstats internal-1/25 extensive" >> $list_save_path/chassism.list
    echo "vcifstats internal-1/26 extensive" >> $list_save_path/chassism.list
    echo "vcifstats internal-1/27 extensive" >> $list_save_path/chassism.list

fi


#################################
# Detect ping fail between FPCs.#
#################################

while [ true ]
do
	fpc_valid=`sysctl -a | grep valid_bitmap | awk '{print $2;}'` 

		if [ $fpc_valid -ne $fpc_valid_orig ] ; then
		break
		fi
	sleep 1
done

mkdir $log_save_path/$save_folder

##########################
#  main problem start    #
##########################

	echo  "Original hw.vc.member_valid_bitmap is $fpc_valid_orig; Current hw.vc.member_valid_bitmap is  $fpc_valid"  >> $log_save_path/$save_folder/additional-info 
	echo  >> $log_save_path/$save_folder/additional-info 

	while read LINE
	 do
	     echo >> $log_save_path/$save_folder/additional-info 
	     echo "=== $LINE  (on `date`)==="  >> $log_save_path/$save_folder/additional-info 
	     $LINE >> $log_save_path/$save_folder/additional-info
	done < $list_save_path/shell.list

	while read LINE
	 do
	     echo >> $log_save_path/$save_folder/additional-info 
	     echo "===cli -c \"$LINE\"  (on `date`)==="  >> $log_save_path/$save_folder/additional-info 
	     cli -c "$LINE" >> $log_save_path/$save_folder/additional-info
	done < $list_save_path/cli.list

fpc_no=`/usr/sbin/cli -c "show virtual-chassis status" | grep FPC | grep -v new | grep "\*" | awk '{print $1}'`

		if [ -f /usr/sbin/lcdd_cmd ] ; then

  		echo "**********Getting sfid information from fpc$fpc_no**********"
		#pfem realted commands
		while read LINE
		 do
		     echo >> $log_save_path/$save_folder/sfid_log.fpc$fpc_no
		     echo "=== $LINE (on `date`) ==="  >> $log_save_path/$save_folder/sfid_log.fpc$fpc_no
		     /usr/sbin/lcdd_cmd -A fpc$fpc_no -d sfid -c "$LINE" >> $log_save_path/$save_folder/sfid_log.fpc$fpc_no
		done < $list_save_path/sfid.list


	#
	# get_ifd_stats_all
	#
		   all_interface=`cli -c "show interfaces terse | no-more | except down" | grep -v "\.0" | awk '{ print $1 }' | grep -v Interface | grep -v cpu | grep -v vlan`

		    for ifd_entry in $all_interface; do
			     echo >> $log_save_path/$save_folder/sfid_log.fpc$fpc_no
			     echo "=== show stats $ifd_entry (on `date`) ==="  >> $log_save_path/$save_folder/sfid_log.fpc$fpc_no
			     /usr/sbin/lcdd_cmd -A fpc$fpc_no -d sfid -c "show stats $ifd_entry" >> $log_save_path/$save_folder/sfid_log.fpc$fpc_no

			     echo >> $log_save_path/$save_folder/sfid_log.fpc$fpc_no
			     echo "=== show sfid $ifd_entry (on `date`) ==="  >> $log_save_path/$save_folder/sfid_log.fpc$fpc_no
			     /usr/sbin/lcdd_cmd -A fpc$fpc_no -d sfid -c "show ifd $ifd_entry" >> $log_save_path/$save_folder/sfid_log.fpc$fpc_no
		    done



  		echo "**********Getting chassism information from fpc$fpc_no**********"
		#pfem realted commands
		while read LINE
		 do
		     echo >> $log_save_path/$save_folder/chassism_log.fpc$fpc_no
			     echo "=== $LINE (on `date`) ==="  >> $log_save_path/$save_folder/chassism_log.fpc$fpc_no
			     /usr/sbin/lcdd_cmd -A fpc$fpc_no -d chassism -c "$LINE" >> $log_save_path/$save_folder/chassism_log.fpc$fpc_no
			done < $list_save_path/chassism.list

		fi

  		echo "**********Getting PFEM information from fpc$fpc_no**********"
		#pfem realted commands
		while read LINE
		 do
		     echo >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
		     echo "=== $LINE (on `date`) ==="  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
		     cprod -A fpc$fpc_no -c "$LINE" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
		done < $list_save_path/pfem.list
				
		#ukern  realted - these take extra effort and not simple cprod
		for i in MRVL_L2 MRVL_RT_NH MRVL-NH; do
			echo >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
		    	echo "=== show ukern_trace for $i (on `date`)==="  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			j=`cprod -A fpc$fpc_no -c "show ukern handles" | grep -w $i | awk '{print $1}'`
			cprod -A fpc$fpc_no -c "show ukern_trace $j" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
		done
				
			echo >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
		    	echo "=== show ukern_trace for MRVL_RT (on `date`)==="  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			j=`cprod -A fpc$fpc_no -c "show ukern handles" | grep MRVL_RT | grep -v NH | awk '{print $1}'`
			cprod -A fpc$fpc_no -c "show ukern_trace $j" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no


			echo >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
		    	echo "=== show ukern_trace for RT (on `date`)==="  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			j=`cprod -A fpc$fpc_no -c "show ukern handles" | grep RT | grep -v MRVL_RT | awk '{print $1}'`
			cprod -A fpc$fpc_no -c "show ukern_trace $j" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no



# Take gcore of sfid
sfidpid=`top -Sbq -s1 -d1 | grep sfid | awk '{ print $1 }'`
gcore -s -c $log_save_path/$save_folder/sfid.core.0 $sfidpid
gzip  $log_save_path/$save_folder/sfid.core.0


sleep 10
gcore -s -c $log_save_path/$save_folder/sfid.core.1 $sfidpid
gzip $log_save_path/$save_folder/sfid.core.1


sleep 10
gcore -s -c $log_save_path/$save_folder/sfid.core.2 $sfidpid
gzip $log_save_path/$save_folder/sfid.core.2

# Take gcore of pfem
pfempid=`top -Sbq -s1 -d1 | grep pfem | awk '{ print $1 }'`
gcore -s -c $log_save_path/$save_folder/pfem.core.0 $pfempid
gzip $log_save_path/$save_folder/pfem.core.0

sleep 10
pfempid=`top -Sbq -s1 -d1 | grep pfem | awk '{ print $1 }'`
gcore -s -c $log_save_path/$save_folder/pfem.core.1 $pfempid
gzip $log_save_path/$save_folder/pfem.core.1

# Take request support information

/usr/sbin/cli -c "request support information all-members | save $log_save_path/$save_folder/rsi.0.log" 
/usr/sbin/cli -c "request support information all-members | save $log_save_path/$save_folder/rsi.1.log" 

	 rm -rf /var/log/$save_folder.3.tgz  > /dev/null 2>&1
	 /bin/mv /var/log/$save_folder.2.tgz /var/log/$save_folder.3.tgz > /dev/null 2>&1
	 /bin/mv /var/log/$save_folder.1.tgz /var/log/$save_folder.2.tgz > /dev/null 2>&1
	 /bin/mv /var/log/$save_folder.0.tgz /var/log/$save_folder.1.tgz > /dev/null 2>&1

	tar -czvf /var/log/$save_folder.0.tgz $log_save_path/$save_folder   > /dev/null 2>&1
	rm -rf $log_save_path/$save_folder
	rm -rf $list_save_path/*.list  > /dev/null 2>&1

##########################
# Restart the member     #
##########################
#
# Important !!! Make sure what this for before you uncomment "reboot" line.
#

# reboot

#EOF

