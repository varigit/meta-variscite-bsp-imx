#!/bin/sh

SERVICE="variscite-usbhub"

SUSPEND_CONF=/run/variscite-suspend/suspend.conf

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

[ -x /etc/usbhub/variscite-usbhub ] || exit 0

case "$1" in

"pre"|"suspend")
	# assert USB HUB TUSB8041 on suspend
	if [ -d /run/systemd/system ]; then
		if systemctl is-active --quiet "$SERVICE"; then
			systemctl stop "$SERVICE"
			echo "${SERVICE}," >> "$SUSPEND_CONF"
		fi
	else
		/etc/usbhub/variscite-usbhub stop
	fi
	;;

"post"|"resume")
	# deassert USB HUB TUSB8041 on resume

	if [ -d /run/systemd/system ]; then
		# restore systemd service if it has previously been stopped
		if grep -q "${SERVICE}," "$SUSPEND_CONF"; then
			systemctl start "$SERVICE"
		fi
	else
		/etc/usbhub/variscite-usbhub start
	fi
	;;
esac
