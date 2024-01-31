#!/bin/sh

[ -x /etc/wifi/variscite-wifi ] || exit 0

SOC=`cat /sys/bus/soc/devices/soc0/soc_id`
if [ "${SOC#i.MX6UL*}" != "${SOC}" ] ; then
	if [ -d /sys/bus/platform/devices/1806000.nand-controller ] ; then
		exit 0
	fi
fi

case $1 in

"suspend")
        /etc/wifi/variscite-wifi stop
        ;;
"resume")
        /etc/wifi/variscite-wifi start
        if [ -f /etc/init.d/connman ]; then
                killall -9 wpa_supplicant
                /etc/init.d/connman restart
        fi
        if [ -f /etc/systemd/system/multi-user.target.wants/connman.service ]; then
                killall -9 wpa_supplicant
                systemctl restart connman.service
        fi
        ;;
esac

