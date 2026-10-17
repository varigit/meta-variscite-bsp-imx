#!/bin/sh

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

[ -x /etc/usbhub/variscite-usbhub ] || exit 0

case "$1" in

"pre"|"suspend")
	# assert USB HUB TUSB8041 on suspend
	systemctl stop variscite-usbhub
	;;
"post"|"resume")
	# deassert USB HUB TUSB8041 on resume
	systemctl start variscite-usbhub
	;;
esac
