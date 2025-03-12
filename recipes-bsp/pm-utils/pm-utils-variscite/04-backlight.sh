#!/bin/sh

# Return success exit status if SoM is DART-MX91 on Sonata
is_dart_mx91_on_sonata()
{
	grep -q "DART-MX91" /sys/devices/soc0/machine && grep -q "Sonata" /sys/devices/soc0/machine
}

is_dart_mx91_on_sonata || exit 0

case $1 in
"suspend")
	# Set shutdown mode
        i2cset -y -f 0 0x2c 0x58 0xC0
        ;;
"resume")
	# Set recall mode
        i2cset -y -f 0 0x2c 0x58 0x80
        ;;
esac
