#!/bin/sh

SERVICE="variscite-ot"

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

# Check if the service file exists in either /etc or /lib
if [ ! -f "/etc/systemd/system/${SERVICE}.service" ] && \
   [ ! -f "/lib/systemd/system/${SERVICE}.service" ]; then
	echo "${SERVICE}.service does not exist in" \
	     "/etc/systemd/system or /lib/systemd/system."
	exit 0
fi

case "$1" in

"suspend")
	# Check if the service is enabled and try to stop it
	if systemctl is-enabled --quiet ${SERVICE}; then
		if ! systemctl stop ${SERVICE}; then
			echo "Error stopping service"
		fi
	fi
	;;

"resume")
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
