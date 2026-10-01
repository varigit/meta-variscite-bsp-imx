#!/bin/sh

# Read the configuration file if it exists
if [ -f /etc/var-suspend-utils/var-suspend-config ]; then
	. /etc/var-suspend-utils/var-suspend-config
fi

case "$1" in

"pre"|"suspend")
	if [ "$ETH_SUSPEND_MODE" = "disabled" ]; then
		# Bring down all eth interfaces for low power suspend
		for eth_interface in /sys/class/net/eth* ; do
			ip link set $(basename ${eth_interface}) down
		done
		exit 0
	fi
	;;
"post"|"resume")
	for eth_interface in /sys/class/net/eth* ; do
		ip link set $(basename ${eth_interface}) down
		ip link set $(basename ${eth_interface}) up
	done
	exit 0
	;;
esac
