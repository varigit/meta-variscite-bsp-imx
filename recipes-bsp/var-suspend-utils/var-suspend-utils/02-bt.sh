#!/bin/sh

SERVICE="variscite-bt"

SUSPEND_CONF=/run/variscite-suspend/suspend.conf

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

[ -x /etc/bluetooth/variscite-bt ] || exit 0

SOC=`cat /sys/bus/soc/devices/soc0/soc_id`
if [ "${SOC#i.MX6UL*}" != "${SOC}" ] ; then
	if [ -f /proc/device-tree/soc/bus@2100000/mmc@2190000/bcrmf@1/sdio,must-keep-power-in-suspend ] ||
	   { [ -d /sys/bus/platform/devices/1806000.nand-controller ] &&
	     [ -f /proc/device-tree/soc/bus@2100000/mmc@2190000/mmc-pwrseq ]; }; then
		exit 0
	fi
fi

case "$1" in

"pre"|"suspend")
	if [ -d /run/systemd/system ]; then
		if systemctl is-active --quiet "$SERVICE"; then
			systemctl stop "$SERVICE"
			echo "${SERVICE}," >> "$SUSPEND_CONF"
		fi
	else
		/etc/bluetooth/variscite-bt stop
	fi
	;;

"post"|"resume")
	if [ -d /run/systemd/system ]; then
		# restore systemd service if it has previously been stopped
		if grep -q "${SERVICE}," "$SUSPEND_CONF"; then
			systemctl start "$SERVICE"
		fi
	else
		/etc/bluetooth/variscite-bt start
	fi
	;;
esac
