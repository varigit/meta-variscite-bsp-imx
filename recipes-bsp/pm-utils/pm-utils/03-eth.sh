#!/bin/sh

# Check if the configuration file exists and read from it
if [ -f /etc/pm/var_pm_config ]; then
	. /etc/pm/var_pm_config
fi

case $1 in

"suspend")
	if [ "$ETH_SUSPEND_MODE" = "disabled" ]; then
		# Bring down all eth interfaces for low power suspend
		for eth_interface in /sys/class/net/eth* ; do
			ip link set $(basename ${eth_interface}) down
		done
	fi
	;;
"resume")
	for eth_interface in /sys/class/net/eth* ; do
		ip link set $(basename ${eth_interface}) down
		ip link set $(basename ${eth_interface}) up
	done
	;;
esac
