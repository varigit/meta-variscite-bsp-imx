#!/bin/sh

[ -x /etc/bluetooth/variscite-bt ] || exit 0

SOC=`cat /sys/bus/soc/devices/soc0/soc_id`
if [ "${SOC#i.MX6UL*}" != "${SOC}" ] ; then
	if [ -f /proc/device-tree/soc/bus@2100000/mmc@2190000/bcrmf@1/sdio,must-keep-power-in-suspend ] ; then
		exit 0
	fi
fi

case $1 in

"suspend")
        /etc/bluetooth/variscite-bt stop
        ;;
"resume")
        /etc/bluetooth/variscite-bt start
        ;;
esac
