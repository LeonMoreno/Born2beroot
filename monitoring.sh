#!/bin/bash

ARCH=$(hostnamectl | grep Architecture | awk '{print $2}')
VERKER=$(uname -a | awk '{print $3}')
FI_PROC=$(lscpu | grep "Socket(s)" | awk '{print $2}')
VI_CPU=$(nproc --all)
MEMTO=$(free -m | awk '/^Mem/ {print $2}')
MEMFREE=$(free -m | awk '/^Mem/ {print $4}')
MEMPOR=$(free | awk '/^Mem/ {printf("%.2f"), $4/$2*100}')
UPRO_POR=$(top -bn1 | awk '/Cpu/ {print 100 - $8 "%"}')
LAST_REB=$(last -x reboot | sed -n '2p' | awk '{print $5,$6,$7 " - " $10}')
STATUS_LVM=$(cat /etc/fstab | grep -c mapper | awk '{if ($1 > 0) {print "LVM Activo"} else {print "LVM Inactivo"}}')
CONX_TCP=$(netstat -t | grep -c tc)
USERS=$(who | wc -l)
ADR_MAC=$(ip addr | grep link/ether | awk '{print "("$2")"}')
ADR_IP=$(hostname -I)
COMM_SUDO=$(journalctl _COMM=sudo | grep COMMAND | wc -l)
DISK=$(df -h --total | grep total | awk '{print $3,"/"$2, "("$5")"}')
wall "
	#Architecture:		${ARCH}
	#Ver. Kernel:		${VERKER}
	#CPU Physiclal:		${FI_PROC}
	#vCPU:			${VI_CPU}
	#Mem RAM avaible:	$MEMFREE / $MEMTO Mb ($MEMPOR%)
	#CPU Load:		${UPRO_POR}
	#Disk usage:		${DISK}
	#Last Reboot:		${LAST_REB}
	#Status LVM		${STATUS_LVM}
	#Connexions TCP:	${CONX_TCP} ESTABLISHED	
	#User log:		${USERS}
	#Network:		IP $ADR_IP $ADR_MAC
	#COMM Sudo:		${COMM_SUDO}"
