#!/bin/sh

PM_SCRIPT_DIR="/etc/var-suspend-utils"

# systemd-sleep deliberately wants to execute these scripts in parallel, but
# we want to enforce sequential execution

if [ "$1" = "pre" ]; then
	# delete file from previous suspend if it exists
	rm -f /run/variscite-suspend/suspend.conf

	mkdir -p /run/variscite-suspend/
	touch /run/variscite-suspend/suspend.conf

	find "$PM_SCRIPT_DIR" -maxdepth 1 -type f -executable | sort |
	while IFS= read -r script; do
		if ! "$script" "pre"; then
			echo "Suspend hook failed: $script" >&2
		fi
	done
fi

if [ "$1" = "post" ]; then
	# execute in reverse order
	find "$PM_SCRIPT_DIR" -maxdepth 1 -type f -executable | sort -r |
	while IFS= read -r script; do
		if ! "$script" "post"; then
			echo "Resume hook failed: $script" >&2
		fi
	done
fi
