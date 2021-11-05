#!/bin/sh
#
# This is for EX3200 or EX4200 (Standalone or Master only)
# Question for this script, please mail to xzwei@juniper.net
# version of 2011-06-24 14:15 CST

PATH=$PATH:/bin:/usr/bin:/usr/sbin

case "$1" in
no-core|no)
	core_symbol=0
        ;;
*)
	core_symbol=1
        ;;
esac

##########################################
#  set the path for the data collection  #
##########################################

log_save_path="/var/tmp"
list_save_path="/var/tmp"
save_folder="capture_debug"

#####################
# Main program here #
#####################

rm -rf $log_save_path/$save_folder  > /dev/null 2>&1
mkdir $log_save_path/$save_folder
rm -rf $list_save_path/*.list  > /dev/null 2>&1

#shell commands
    echo "top -Sbq -s1 -d1" >>  $list_save_path/shell.list
    echo "df -k" >>  $list_save_path/shell.list
    echo "netstat -s" >>  $list_save_path/shell.list
    echo "netstat -Aan" >>  $list_save_path/shell.list
    echo "rtinfo -rnV" >>  $list_save_path/shell.list
    echo "rtinfo -rnV -f inet" >>  $list_save_path/shell.list
    echo "rtinfo -rnV -f msti" >>  $list_save_path/shell.list
    echo "rtinfo -rnV -f vlan-classification" >>  $list_save_path/shell.list
    echo "vlaninfo -av" >>  $list_save_path/shell.list
    echo "nhinfo -a -d" >>  $list_save_path/shell.list
    echo "tnpdump" >>  $list_save_path/shell.list

#cli commands
    echo "show arp inspection statistics | no-more" >>  $list_save_path/cli.list
    echo "show ethernet-switching table detail | no-more" >>  $list_save_path/cli.list
    echo "show pfe statistics traffic | no-more" >>  $list_save_path/cli.list
    echo "show arp no-resolve | no-more" >>  $list_save_path/cli.list
    echo "show firewall | no-more" >>  $list_save_path/cli.list
    echo "show system statistics no-forwarding | no-more" >>  $list_save_path/cli.list
    echo "show route forwarding-table | no-more" >>  $list_save_path/cli.list
    echo "show interfaces queue | no-more" >>  $list_save_path/cli.list
    echo "show arp inspection statistics | no-more" >>  $list_save_path/cli.list

	sysctl hw.product.model | grep 4200 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
	    echo "show virtual-chassis status" >>  $list_save_path/cli.list
	    echo "show virtual-chassis vc-port" >>  $list_save_path/cli.list
	    echo "show virtual-chassis vc-port statistics" >>  $list_save_path/cli.list
	    echo "show virtual-chassis active-topology" >>  $list_save_path/cli.list
	    echo "show virtual-chassis protocol database extensive" >>  $list_save_path/cli.list
	    echo "show virtual-chassis protocol interface detail" >>  $list_save_path/cli.list
	    echo "show virtual-chassis protocol adjacency all-members extensive" >>  $list_save_path/cli.list
	    echo "show virtual-chassis protocol route" >>  $list_save_path/cli.list
	    echo "show virtual-chassis protocol statistics" >>  $list_save_path/cli.list
	    echo "show virtual-chassis vc-port statistics" >>  $list_save_path/cli.list
	fi

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
    echo "show ukern_trace memory-composition" >>   $list_save_path/pfem.list
    echo "show route arp" >> $list_save_path/pfem.list
    echo "show route arp table" >> $list_save_path/pfem.list
    echo "show route bridge" >> $list_save_path/pfem.list
    echo "show route bridge table" >> $list_save_path/pfem.list
    echo "show route ip" >> $list_save_path/pfem.list
    echo "show route ip table" >> $list_save_path/pfem.list
    echo "show route management statistics" >> $list_save_path/pfem.list
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

    # shim registers related.

    echo "show shim shadow summary " >> $list_save_path/pfem.list
    echo "show shim shadow registers" >> $list_save_path/pfem.list

    echo "show shim register 0x03000040" >> $list_save_path/pfem.list
    echo "show shim register 0xa100000" >> $list_save_path/pfem.list
    echo "show shim register 0xa100004" >> $list_save_path/pfem.list
    echo "show shim register 0xa100010" >> $list_save_path/pfem.list
    echo "show shim register 0xa100014" >> $list_save_path/pfem.list
    echo "show shim register 0xa100020" >> $list_save_path/pfem.list
    echo "show shim register 0xa100024" >> $list_save_path/pfem.list
    echo "show shim register 0xa100030" >> $list_save_path/pfem.list
    echo "show shim register 0xa100034" >> $list_save_path/pfem.list
    echo "show shim register 0xa100040" >> $list_save_path/pfem.list
    echo "show shim register 0xa100044" >> $list_save_path/pfem.list
    echo "show shim register 0xa100ff0" >> $list_save_path/pfem.list
    echo "show shim register 0xa100ff4" >> $list_save_path/pfem.list

    echo "show shim register 0x02800000"  >> $list_save_path/pfem.list
    echo "show shim register 0x02800100"  >> $list_save_path/pfem.list
    echo "show shim register 0x02800104"  >> $list_save_path/pfem.list
    echo "show shim register 0x02800108"  >> $list_save_path/pfem.list
    echo "show shim register 0x0280010c"  >> $list_save_path/pfem.list
    echo "show shim register 0x11000012"  >> $list_save_path/pfem.list
    echo "show shim register 0x11000016"  >> $list_save_path/pfem.list
    echo "show shim register 0x1100001a"  >> $list_save_path/pfem.list
    echo "show shim register 0x11000026"  >> $list_save_path/pfem.list
    echo "show shim register 0x02800200"  >> $list_save_path/pfem.list
    echo "show shim register 0x02800204"  >> $list_save_path/pfem.list
    echo "show shim register 0x02800208"  >> $list_save_path/pfem.list
    echo "show shim register 0x0280020c"  >> $list_save_path/pfem.list
    echo "show shim register 0x1100000e"  >> $list_save_path/pfem.list
    echo "show shim register 0x02800940"  >> $list_save_path/pfem.list
    echo "show shim register 0x02800950"  >> $list_save_path/pfem.list
    echo "show shim register 0x02800954"  >> $list_save_path/pfem.list
    echo "show shim register 0x02800964"  >> $list_save_path/pfem.list
    echo "show shim register 0x02800958"  >> $list_save_path/pfem.list
    echo "show shim register 0x02800948"  >> $list_save_path/pfem.list
    echo "show shim register 0x02800944"  >> $list_save_path/pfem.list
    echo "show shim register 0x11000dfe"  >> $list_save_path/pfem.list
    echo "show shim register 0x11000e02"  >> $list_save_path/pfem.list
    echo "show shim register 0x11000d02"  >> $list_save_path/pfem.list
    echo "show shim register 0x11000cfe"  >> $list_save_path/pfem.list
    echo "show shim register 193003520"  >> $list_save_path/pfem.list
    echo "show shim register 193003520"  >> $list_save_path/pfem.list
    echo "show shim register 193003552"  >> $list_save_path/pfem.list
    echo "show shim register 193003616"  >> $list_save_path/pfem.list
    echo "show shim register 193003712"  >> $list_save_path/pfem.list
    echo "show shim register 193003840"  >> $list_save_path/pfem.list
    echo "show shim register 193004000"  >> $list_save_path/pfem.list
    echo "show shim register 193004192"  >> $list_save_path/pfem.list
    echo "show shim register 193004416"  >> $list_save_path/pfem.list
    echo "show shim register 193004672"  >> $list_save_path/pfem.list
    echo "show shim register 193004960"  >> $list_save_path/pfem.list
    echo "show shim register 193005280"  >> $list_save_path/pfem.list
    echo "show shim register 193005632"  >> $list_save_path/pfem.list
    echo "show shim register 193006016"  >> $list_save_path/pfem.list
    echo "show shim register 193006432"  >> $list_save_path/pfem.list
    echo "show shim register 193006880"  >> $list_save_path/pfem.list
    echo "show shim register 193007360"  >> $list_save_path/pfem.list
    echo "show shim register 193007872"  >> $list_save_path/pfem.list
    echo "show shim register 193008416"  >> $list_save_path/pfem.list
    echo "show shim register 193008992"  >> $list_save_path/pfem.list
    echo "show shim register 193009600"  >> $list_save_path/pfem.list
    echo "show shim register 193010240"  >> $list_save_path/pfem.list
    echo "show shim register 193010912"  >> $list_save_path/pfem.list
    echo "show shim register 193011616"  >> $list_save_path/pfem.list
    echo "show shim register 193012352"  >> $list_save_path/pfem.list
    echo "show shim register 193013120"  >> $list_save_path/pfem.list
    echo "show shim register 193013920"  >> $list_save_path/pfem.list

    #pfem filter related commands list

    echo "show filter" >> $list_save_path/pfem.list
    echo "show graph filter-class PACL" >> $list_save_path/pfem.list
    echo "show graph filter-class VACL" >> $list_save_path/pfem.list
    echo "show graph filter-class RACL" >> $list_save_path/pfem.list
    echo "show graph filter-class EPCL" >> $list_save_path/pfem.list
    echo "show tcam vendor 1 rule" >> $list_save_path/pfem.list
    echo "show tcam vendor 1 instance" >> $list_save_path/pfem.list

    for instanceno in 0 1 2 3; do
    	echo "show tcam vendor 1 instance $instanceno database 0 rules" >> $list_save_path/pfem.list
	echo "show tcam vendor 1 instance $instanceno database 1 rules" >> $list_save_path/pfem.list
	echo "show tcam vendor 1 instance $instanceno database 2 rules" >> $list_save_path/pfem.list
	echo "show tcam vendor 1 instance $instanceno database 3 rules" >> $list_save_path/pfem.list
	echo "show tcam vendor 1 instance $instanceno database 0 filter" >> $list_save_path/pfem.list
	echo "show tcam vendor 1 instance $instanceno database 1 filter" >> $list_save_path/pfem.list
	echo "show tcam vendor 1 instance $instanceno database 2 filter" >> $list_save_path/pfem.list
	echo "show tcam vendor 1 instance $instanceno database 3 filter" >> $list_save_path/pfem.list
    done

    echo "show filter counters" >> $list_save_path/pfem.list
    echo "show halp-dfw counters" >> $list_save_path/pfem.list
    echo "show ukern_trace 9" >> $list_save_path/pfem.list
    echo "show syslog messages" >> $list_save_path/pfem.list

    #pfem drop mode related commands list

    echo "all" >> $list_save_path/drop.list
    echo "accept-frame-type" >> $list_save_path/drop.list
    echo "access-matrix" >> $list_save_path/drop.list
    echo "arp-src-mac-mismatch" >> $list_save_path/drop.list
    echo "dsatag-local-dev" >> $list_save_path/drop.list
    echo "fdb-entry" >> $list_save_path/drop.list	
    echo "frag-icmp" >> $list_save_path/drop.list
    echo "ieee-rsvd" >> $list_save_path/drop.list
    echo "invalid-src-mac" >> $list_save_path/drop.list
    echo "invalid-vlan" >> $list_save_path/drop.list
    echo "ip-mc" >> $list_save_path/drop.list
    echo "local-port" >> $list_save_path/drop.list
    echo "moved-static-address" >> $list_save_path/drop.list
    echo "non-ip-mc" >> $list_save_path/drop.list
    echo "non-ipm-mc" >> $list_save_path/drop.list
    echo "port-not-in-vlan" >> $list_save_path/drop.list
    echo "rate-limit" >> $list_save_path/drop.list
    echo "secure-learning" >> $list_save_path/drop.list
    echo "stp-state" >> $list_save_path/drop.list
    echo "syn-with-data" >> $list_save_path/drop.list
    echo "tcp-flags-fup-set" >> $list_save_path/drop.list
    echo "tcp-flags-sf-set" >> $list_save_path/drop.list
    echo "tcp-flags-sr-set" >> $list_save_path/drop.list
    echo "tcp-flags-zero" >> $list_save_path/drop.list
    echo "tcp-over-mc-bc" >> $list_save_path/drop.list
    echo "tcp-udp-port-zero" >> $list_save_path/drop.list
    echo "unknown-l2-uc" >> $list_save_path/drop.list
    echo "unknown-src-mac" >> $list_save_path/drop.list
    echo "unreg-l2-ip-bc" >> $list_save_path/drop.list
    echo "unreg-l2-ip-mc" >> $list_save_path/drop.list
    echo "unreg-l2-ipv6-mc" >> $list_save_path/drop.list
    echo "unreg-l2-non-ip-bc" >> $list_save_path/drop.list
    echo "vlan-mru" >> $list_save_path/drop.list
    echo "vlan-range" >> $list_save_path/drop.list
    echo "all" >> $list_save_path/drop.list


if [ -f /usr/sbin/lcdd_cmd ] ; then

#sfid commands

    echo "show stats" >> $list_save_path/sfid.list
    echo "show device 0" >> $list_save_path/sfid.list
    echo "show ring stats 0 8" >> $list_save_path/sfid.list
    echo "show device 1" >> $list_save_path/sfid.list
    echo "show ring stats 1 8" >> $list_save_path/sfid.list
    echo "show device 2" >> $list_save_path/sfid.list
    echo "show ring stats 2 8" >> $list_save_path/sfid.list
    echo "show rate-limit tokern high 0" >> $list_save_path/sfid.list
    echo "show rate-limit tokern low 0" >> $list_save_path/sfid.list
    echo "show rate-limit tokern high 1" >> $list_save_path/sfid.list
    echo "show rate-limit tokern low 1" >> $list_save_path/sfid.list
    echo "show rate-limit tokern high 2" >> $list_save_path/sfid.list
    echo "show rate-limit tokern low 2" >> $list_save_path/sfid.list
    echo "show rate-limit tokern high 3" >> $list_save_path/sfid.list
    echo "show rate-limit tokern low 3" >> $list_save_path/sfid.list
    echo "show device 0" >> $list_save_path/sfid.list
    echo "show ring stats 0 8" >> $list_save_path/sfid.list
    echo "show device 1" >> $list_save_path/sfid.list
    echo "show ring stats 1 8" >> $list_save_path/sfid.list
    echo "show device 2" >> $list_save_path/sfid.list
    echo "show ring stats 2 8" >> $list_save_path/sfid.list
    echo "show stats" >> $list_save_path/sfid.list
    echo "show ifd" >> $list_save_path/sfid.list
    echo "show queue" >> $list_save_path/sfid.list
    echo "show bufpool global_buf_pool" >> $list_save_path/sfid.list
    echo "show bufpool sfi_bme_bufpool" >> $list_save_path/sfid.list
    echo "show aaau stats" >> $list_save_path/sfid.list
    echo "show ifd vcp-0" >> $list_save_path/sfid.list
    echo "show ifd vcp-1" >> $list_save_path/sfid.list
    echo "show ifd vcp-0" >> $list_save_path/sfid.list
    echo "show ifd vcp-1" >> $list_save_path/sfid.list
    echo "show vc param" >> $list_save_path/sfid.list
    echo "show errors last" >> $list_save_path/sfid.list
    echo "show dhcp-snoop" >> $list_save_path/sfid.list
    echo "peek device 0 0x0780000c" >> $list_save_path/sfid.list

#chassism commands

    echo "show ifd stat terse"  >> $list_save_path/chassism.list
    echo "devrtinfo" >> $list_save_path/chassism.list
    echo "devmapinfo 0" >> $list_save_path/chassism.list
    echo "devmapinfo 1" >> $list_save_path/chassism.list
    echo "devmapinfo 2" >> $list_save_path/chassism.list
    echo "vcifstats vcp-0 extensive" >> $list_save_path/chassism.list
    echo "vcifstats vcp-1 extensive" >> $list_save_path/chassism.list

fi

##########################
#  main program start    #
##########################

	echo "=== system REBOOT time ==="  >> $log_save_path/$save_folder/additional-info 

	i=9
	while [ $i -ge 0 ]
	do 
	if [ -f /var/log/messages.$i.gz ]; then
	     cli -c "show log messages.$i.gz | match copyright | match Juniper "  >>  $log_save_path/$save_folder/additional-info
	fi
	     i=`expr $i - 1`
	done
	cli -c "show log messages | match copyright | match Juniper "  >>  $log_save_path/$save_folder/additional-info


	while read LINE
	 do
	     echo >> $log_save_path/$save_folder/additional-info 
	     echo "=== $LINE  (on `date`)==="  >> $log_save_path/$save_folder/additional-info 
	     $LINE >> $log_save_path/$save_folder/additional-info
	done < $list_save_path/shell.list

	     echo >> $log_save_path/$save_folder/additional-info 
	     echo "=== sysctl -a | grep -A 20 rlim (on `date`)==="  >> $log_save_path/$save_folder/additional-info 
	     sysctl -a | grep -A 20 rlim  >> $log_save_path/$save_folder/additional-info 


	while read LINE
	 do
	     echo >> $log_save_path/$save_folder/additional-info 
	     echo "===cli -c \"$LINE\"  (on `date`)==="  >> $log_save_path/$save_folder/additional-info 
	     cli -c "$LINE" >> $log_save_path/$save_folder/additional-info
	done < $list_save_path/cli.list

	rollno=1
	while [ $rollno -le 20 ]
	do 
	     echo "===cli -c \"show configuration | compare rollback $rollno\"  (on `date`)==="  >> $log_save_path/$save_folder/additional-info 
	     cli -c "show configuration | compare rollback $rollno"  >> $log_save_path/$save_folder/additional-info 
	     rollno=`expr $rollno + 1`
	done

	sysctl hw.product.model | grep 4200 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		fpc_no=`/usr/sbin/cli -c "show virtual-chassis status" | grep FPC | grep -v new | grep "\*" | awk '{print $1}'`
	fi

	sysctl hw.product.model | grep 3200 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		fpc_no=0
	fi



		if [ -f /usr/sbin/lcdd_cmd ] ; then

  		echo "**********Getting sfid information from fpc$fpc_no**********"
		#sfid related commands
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
		#chassism related commands
			while read LINE
			 do
			     echo >> $log_save_path/$save_folder/chassism_log.fpc$fpc_no
			     echo "=== $LINE (on `date`) ==="  >> $log_save_path/$save_folder/chassism_log.fpc$fpc_no
			     /usr/sbin/lcdd_cmd -A fpc$fpc_no -d chassism -c "$LINE" >> $log_save_path/$save_folder/chassism_log.fpc$fpc_no
			done < $list_save_path/chassism.list

		fi

  		echo "**********Getting PFEM information from fpc$fpc_no**********"
		#pfem related commands
			while read LINE
			 do
			     echo >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			     echo "=== $LINE (on `date`) ==="  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			     cprod -A fpc$fpc_no -c "$LINE" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			done < $list_save_path/pfem.list

			#
			# get nhdb id ext
			#
			    nh_list=`cprod -A fpc$fpc_no -c "show nhdb" | grep -v "\---" | grep -v "ID" | awk '{ print $1 }' | egrep ^\[0-9\]`

			    for nh_index in $nh_list; do
				     echo >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
				     echo "=== show nhdb id $nh_index ext (on `date`) ==="  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
				      cprod -A fpc$fpc_no -c "show nhdb id $nh_index ext" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no

			    done


		#pfem drop mode related commands
			while read LINE
			 do
			     echo >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			     echo "=== set shim bridge drop-counter-mode $LINE (on `date`) === " >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			     cprod -A fpc$fpc_no -c "set shim bridge drop-counter-mode $LINE"   > /dev/null 2>&1
			     sleep 1
			     echo "=== show shim bridge statistics (on `date`) === " >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			     cprod -A fpc$fpc_no -c "show shim bridge statistics"  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			done < $list_save_path/drop.list
			
		#ukern  realted - these take extra effort and not simple cprod
			for i in MRVL_L2 MRVL_RT_NH MRVL_RT RT MRVL-NH; do
				echo >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			    	echo "=== show ukern_trace for $i (on `date`)==="  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
				j=`cprod -A fpc$fpc_no -c "show ukern handles" | grep -w $i | awk '{print $1}'`
				cprod -A fpc$fpc_no -c "show ukern_trace $j" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			done
			
				echo >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			    	echo "=== show ukern_trace for NH (on `date`)==="  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
				j=`cprod -A fpc$fpc_no -c "show ukern handles" | grep -w NH | grep -v MRVL| awk '{print $1}'`
				cprod -A fpc$fpc_no -c "show ukern_trace $j" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no

		#set shim register 0x02800954 value N device-all  and  display show halp-rt route block
			echo  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo "++++++++++++"  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo "#PFE IP Drop Counter for fpc$fpc_no" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo "++++++++++++"  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no	
			echo  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no	
			k=0
			while [ $k -le 16 ]
				do 
				
				case $k in
					0) 	echo "++++++++ All drops  (on `date`) ++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;				
					1) 	echo "++++++++ IP Header Error (on `date`) ++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					2) 	echo "++++++++ DIP/DA Mismatch Error (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					3)	echo "++++++++ Illeagal Address Error (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					4)	echo "++++++++ SIP All Zeros (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					5)	echo "++++++++ SIP/SA Mismatch Error (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					6)	echo "++++++++ UnicastRPFFail (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					7)	echo "++++++++ Nexhop command SoftDrop or HardDrop (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					8)	echo "++++++++ Multicast RPF Fail (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					9)	echo "++++++++ IPv4 TTL or IPv6 Hop Limit Exceeded  (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					10)	echo "++++++++ MTU Exceeded (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					11)	echo "++++++++ IPV4 Options (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					12)	echo "++++++++ IPv6Scope Exception (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					13)	echo "++++++++ IPV6 scope exception (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					14)	echo "++++++++ Unicast Packet SIP Filter (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					15)	echo "++++++++ Access Matrix Filter (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
					16)	echo "++++++++  IPv4 TTL = 1 (on `date`)++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
					;;
				esac

				echo "++++++++ set shim register 0x02800954 value $k device-all (on `date`)++++++++ "  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
				cprod -A fpc$fpc_no -c "set shim register 0x02800954 value $k device-all" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
				cprod -A fpc$fpc_no -c "show halp-rt route block" | grep "Global RT" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
				echo "-------- 2nd time after 2 seconds (on `date`)--------" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
				sleep 2
				cprod -A fpc$fpc_no -c "show halp-rt route block" | grep "Global RT" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
				echo               >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no

				k=`expr $k + 1`

			done

			echo "++++++++ All drops  (on `date`) ++++++++" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo "++++++++ set shim register 0x02800954 value 0 device-all (on `date`)++++++++ "  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			cprod -A fpc$fpc_no -c "set shim register 0x02800954 value 0 device-all" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			cprod -A fpc$fpc_no -c "show halp-rt route block" | grep "Global RT" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo "-------- 2nd time after 2 seconds (on `date`)--------" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			sleep 2
			cprod -A fpc$fpc_no -c "show halp-rt route block" | grep "Global RT" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo               >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no

			echo               >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo "++++++++ Displaying the Default routes (on `date`)++++++++ "  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo               >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo "++++++++ show halp-rt route ip r 0 p 0.0.0.0 p (on `date`) +++++++"  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			cprod -A fpc$fpc_no -c "show halp-rt route ip r 0 p 0.0.0.0 p 0" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo               >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no

			echo "++++++++ show topology route ip prefix 0.0.0.0/0 (on `date`) +++++++"  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			cprod -A fpc$fpc_no -c "show topology route ip prefix 0.0.0.0/0" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo               >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no

			echo "++++++++ show halp-rt route ip r 0 p 0.0.0.0 p 0 g 224.0.0.0 g 4 (on `date`) +++++++"  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			cprod -A fpc$fpc_no -c "show halp-rt route ip r 0 p 0.0.0.0 p 0 g 224.0.0.0 g 4" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo               >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo "++++++++ show topology route ip prefix 224/4 (on `date`) +++++++"  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			cprod -A fpc$fpc_no -c "show topology route ip prefix 224/4" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo               >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo "++++++++ Error rt-nh tree (on `date`)++++++++ "  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			cprod -A fpc$fpc_no -c "show halp-rt_nh tree error" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo               >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			echo "++++++++ halp-rt-nh tree (on `date`)++++++++ "  >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no
			cprod -A fpc$fpc_no -c "show halp-rt_nh tree" >> $log_save_path/$save_folder/pfem_log.fpc$fpc_no


# Collect request support information
	echo "**********Getting request support information **********"
	cli -c "request support information | save $log_save_path/$save_folder/rsi.log"

if [ $core_symbol -eq 1 ] ; then

	# Take gcore of sfid
  	echo "**********Getting sfid gcore file **********"
	sfidpid=`ps -auxw | grep -v grep | grep sfid | awk '{ print $2 }'`
	gcore -s -c $log_save_path/$save_folder/sfid.core $sfidpid

	# Take gcore of pfem
  	echo "**********Getting pfem gcore file **********"
	pfempid=`ps -auxw | grep -v grep| grep pfem | awk '{ print $2 }'`
	gcore -s -c $log_save_path/$save_folder/pfem.core $pfempid

fi

	 rm -rf /var/log/$save_folder.3.tgz  > /dev/null 2>&1
	 /bin/mv /var/log/$save_folder.2.tgz /var/log/$save_folder.3.tgz > /dev/null 2>&1
	 /bin/mv /var/log/$save_folder.1.tgz /var/log/$save_folder.2.tgz > /dev/null 2>&1
	 /bin/mv /var/log/$save_folder.0.tgz /var/log/$save_folder.1.tgz > /dev/null 2>&1

	tar -czvf /var/log/$save_folder.0.tgz $log_save_path/$save_folder   > /dev/null 2>&1
	rm -rf $log_save_path/$save_folder
	rm -rf $list_save_path/*.list  > /dev/null 2>&1

#EOF

