#!/bin/sh

SERVICE="variscite-ot"

SUSPEND_CONF=/run/variscite-suspend/suspend.conf

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

[ -x /etc/openthread/variscite-ot ] || exit 0

case "$1" in

"pre"|"suspend")
	if [ -d /run/systemd/system ]; then
		if systemctl is-active --quiet "$SERVICE"; then
			systemctl stop "$SERVICE"
			echo "${SERVICE}," >> "$SUSPEND_CONF"
		fi
	else
		/etc/openthread/variscite-ot stop
	fi
	;;

"post"|"resume")
	if [ -d /run/systemd/system ]; then
		# restore systemd service if it has previously been stopped
		if grep -q "${SERVICE}," "$SUSPEND_CONF"; then
			systemctl start "$SERVICE"
		fi
	else
		/etc/openthread/variscite-ot start
	fi
	;;
esac
