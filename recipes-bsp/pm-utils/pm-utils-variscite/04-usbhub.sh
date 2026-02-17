#!/bin/sh

case $1 in

"suspend")
	# assert USB HUB TUSB8041 on suspend
        systemctl stop variscite-usbhub
        ;;
"resume")
	# deassert USB HUB TUSB8041 on resume
	systemctl start variscite-usbhub
        ;;
esac

