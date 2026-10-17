#!/bin/sh

SERVICE="variscite-wifi"

SUSPEND_CONF=/run/variscite-suspend/suspend.conf

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

[ -x /etc/wifi/variscite-wifi ] || exit 0

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
		/etc/wifi/variscite-wifi stop
	fi
	;;
"post"|"resume")
	if [ -d /run/systemd/system ]; then
		# restore systemd service if it has previously been stopped
		if grep -q "${SERVICE}," "$SUSPEND_CONF"; then
			systemctl start "$SERVICE"
		fi
	else
		/etc/wifi/variscite-wifi start
	fi

	if [ -f /etc/init.d/connman ]; then
		killall -9 wpa_supplicant
		/etc/init.d/connman restart
	fi
	if [ -f /etc/systemd/system/multi-user.target.wants/connman.service ]; then
		killall -9 wpa_supplicant
		systemctl restart connman.service
	fi

	if [ -f /etc/systemd/system/multi-user.target.wants/wpa_supplicant@wlan0.service ]; then
		systemctl restart systemd-networkd
		sleep 1
		systemctl restart wpa_supplicant@wlan0.service
	fi
	;;
esac
