#!/bin/sh

case $1 in

"suspend")
	;;
"resume")
	for eth_interface in /sys/class/net/eth* ; do
		ip link set $(basename ${eth_interface}) down
		ip link set $(basename ${eth_interface}) up
	done
	;;
esac
