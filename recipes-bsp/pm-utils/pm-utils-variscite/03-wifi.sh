#!/bin/sh

[ -x /etc/wifi/variscite-wifi ] || exit 0

SOC=`cat /sys/bus/soc/devices/soc0/soc_id`
if [ "${SOC#i.MX6UL*}" != "${SOC}" ] ; then
	if [ -f /proc/device-tree/soc/bus@2100000/mmc@2190000/bcrmf@1/sdio,must-keep-power-in-suspend ] ; then
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

        if [ -f /etc/systemd/system/multi-user.target.wants/wpa_supplicant@wlan0.service ]; then
                systemctl restart systemd-networkd
                sleep 1
                systemctl restart wpa_supplicant@wlan0.service
        fi
        ;;
esac

