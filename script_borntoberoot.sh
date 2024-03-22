#!/bin/bash

    #Architecture
architecture=`uname -a`

    #CPU
cpu_p=`lscpu | grep Socket | awk '{print $2}'`
vCPY=`nproc`

    #RAM
total_mem=`free -m | grep "Mem" | awk '{print $2}'`
used_mem=`free -m | grep "Mem" | awk '{print $3}'`
porc_umem=`echo $used_mem $total_mem | awk '{printf("%.2f", ($1 / $2) * 100 )}'`

    #disk
total_disk=`df -h --total | grep "total" | awk '{print $2}'`
used_disk=`df -m --total | grep "total" | awk '{print $3}'`
proc_udisk=`df --total | grep "total" | awk '{print $5}'`

    #user
user_log=`who | awk '{print $1}' | sort -u | wc -l`

    #CPU
cpu_l=`top -bn1 | tr ',' ' ' | awk ' NR == 3 {print $8}'`

    #last boot
last_boot=`who -b | awk '{print $3 " " $4}'`

    #LVM
lvm_u=`[ "lvs | grep "LVMGroup " | wc -l" -eq "0" ] && echo "no" || echo "yes" `

    #Network
mac=`cat "/sys/class/net/enp0s3/address"`
ip=`hostname -I`
tcp_c=`netstat | grep tcp | grep ESTABLISHED | wc -l`

    #sudo
nbr_sudo=`journalctl | grep sudo | grep -c COMMAND`

wall "
#Architecture: $architecture
#CPU physical : $cpu_p
#vCPU : $vCPY
#Memory Usage: $used_mem/$total_mem ($porc_umem%)
#Disk Usage: $used_disk/$total_disk ($proc_udisk)
#CPU load: $cpu_l%
#Last boot: $last_boot
#LVM use: $lvm_u
#Connections TCP : $tcp_c ESTABLISHED
#User log: $user_log
#Network: IP $ip ($mac)
#Sudo : $nbr_sudo cmd
"
