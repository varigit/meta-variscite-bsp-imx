#!/bin/sh

SERVICE="variscite-ot"

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

[ -x /etc/openthread/variscite-ot ] || exit 0

case "$1" in

"pre"|"suspend")
	# Check if the service is enabled and try to stop it
	if systemctl is-enabled --quiet ${SERVICE}; then
		if ! systemctl stop ${SERVICE}; then
			echo "Error stopping service"
		fi
	fi
	;;

"post"|"resume")
	# Check if the service is enabled and try to start it
	if systemctl is-enabled --quiet ${SERVICE}; then
		if ! systemctl start ${SERVICE}; then
			echo "Error starting service"
		fi
	fi
	;;

*)
	;;
esac
