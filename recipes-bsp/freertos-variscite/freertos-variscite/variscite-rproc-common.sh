#!/bin/sh -e

readonly CONF_SCRIPT="${DIR_SCRIPT}/variscite-rproc.conf"
. ${CONF_SCRIPT}

readonly SOC="$(cat /sys/bus/soc/devices/soc0/soc_id)"
readonly MACHINE="$(cat /sys/bus/soc/devices/soc0/machine)"

# Increasing logging verbosity for debugging
sysctl kernel.printk=7 >/dev/null 2>&1

verify_file_exists() {
    if [ ! -f $1 ]; then
        echo "Error: $1 not found"
        help
    fi
}

parse_args() {
    # Verify -f option was passed
    if [ "$#" -lt 2 ]; then
        help
    fi

    CM_CORE=0
    while [ $# -gt 0 ]
    do
        case $1 in
            -h|--help)
                help
            ;;
            -f|--firmware)
                FILE_CM_BIN="$2"
                shift # past argument
                shift # past value
            ;;
            -c|--core)
                CM_CORE="$2"
                shift # past argument
                shift # past value
            ;;
            *)    # unknown option
                echo "Unknown option: $1"
                help
            ;;
        esac
    done

    # Verify input file is populated
    if [ -z ${FILE_CM_BIN} ]; then
        help
    fi

    # Verify input file exists in the correct directory
    FILE_CM_BIN="$(basename ${FILE_CM_BIN})"
    verify_file_exists "${DIR_FW}/${FILE_CM_BIN}"

    # Verify CM_CORE exists
    case "${MACHINE}" in
        *DART-MX95*)
            if [ "${CM_CORE}" -eq 0 ]; then
                echo "Core 0 refers Cortex M33 that is not supported by FreeRTOS demos, please use 1 for Cortex M7"
                exit
            fi
        ;;
        *)
            if [ "${CM_CORE}" -ge ${CM_CORES} ]; then
                echo
                echo "Error: ${SOC} only has ${CM_CORES} cortex ${CM_SERIES}s"
                help
            fi
        ;;
    esac
}

help() {
    echo
    echo "Usage: ${DIR_SCRIPT}/${FILE_SCRIPT} <options>"
    echo
    echo " required:"
    echo " -f --firmware	Path to ${CM_SERIES} firmware"
    echo
    echo " optional:"
    echo " -c --core	zero based cortex ${CM_SERIES} core number to load firmware (Default = 0)"
    echo " -h --help	display this Help message"
    echo
    echo "Example:"
    echo "${DIR_SCRIPT}/${FILE_SCRIPT} -f ${DIR_FW}/${FILE_DEFAULT_FW} -c 0"
    echo
    exit
}

get_somrev() {
	# Get the raw output
	raw_output=$(i2cget -f -y 0x0 0x52 0x1e)

	# Convert the output to decimal
	decimal_output=$(( $raw_output ))

	# Extract major and minor versions
	major=$(( ($decimal_output & 0xE0) >> 5 ))
	minor=$(( $decimal_output & 0x1F ))

	# Adjust the major version as per the specification
	major=$(( $major + 1 ))

	echo "$major.$minor"
}

get_symphonyrev() (
    # VAR-SOM-MX8M-MINI carrier EEPROM: I2C3, address 0x54.
    # The packed header contains magic (2 bytes), version (1 byte),
    # then a 16-byte carrier revision string.
    magic_hi=$(i2cget -f -y 0x2 0x54 0x0) || return 1
    magic_lo=$(i2cget -f -y 0x2 0x54 0x1) || return 1
    [ "$((magic_hi))" -eq 86 ] && [ "$((magic_lo))" -eq 67 ] || return 1

    carrier_revision=""
    offset=3
    while [ "$offset" -lt 19 ]; do
        value=$(i2cget -f -y 0x2 0x54 "$offset") || return 1
        [ "$((value))" -ne 0 ] || break
        carrier_revision="${carrier_revision}$(printf "\\$(printf '%03o' "$((value))")")"
        offset=$((offset + 1))
    done
    printf '%s\n' "$carrier_revision"
)

# Initialize default Linux Device Tree
if [ "${MACHINE#*DART-MX*}" != "${MACHINE}" ]; then
    CM_DTB=${CM_DTB_DART}

    case "${MACHINE}" in
        *DART-MX8M-MINI*)
            somrev=$(get_somrev)
            case "${somrev}" in
                1.*)
                    CM_DTB=${CM_DTB_DART_1X}
                    ;;
                3.*)
                    CM_DTB=${CM_DTB_DART_3X}
                    ;;
            esac
            ;;

        *DART-MX8M-PLUS*)
            somrev=$(get_somrev)
            if [ "$(echo "$somrev < 2.0" | bc)" -eq 1 ]; then
                CM_DTB=${CM_DTB_DART_1X}
            fi
            ;;

        *DART-MX95*)
            if [ "${MACHINE#*Sonata-Board*}" != "${MACHINE}" ]; then
                CM_DTB=${CM_DTB_SONATA}
            fi
            ;;
    esac
elif [ "${MACHINE#*VAR-SOM*}" != "${MACHINE}" ]; then
    CM_DTB=${CM_DTB_SOM}

    case "$MACHINE" in
        *VAR-SOM-MX8M-MINI*)
            somrev=$(get_somrev)
            case "${somrev}" in
                1.*) CM_DTB=${CM_DTB_SOM_1X} ;;
            esac

            # Match U-Boot: Symphony 2.1+ uses the unsuffixed DTB;
            # older or unidentified carriers use the 2.0 variant.
            carrierrev=$(get_symphonyrev 2>/dev/null) || carrierrev="undefined"
            case "${carrierrev}" in
                sym-2.[1-9]*) ;;
                *)
                    case "${somrev}" in
                        1.*) CM_DTB=${CM_DTB_SOM_1X_SYMPHONY_20} ;;
                        *) CM_DTB=${CM_DTB_SOM_SYMPHONY_20} ;;
                    esac
                    ;;
            esac
            ;;

        *VAR-SOM-MX8M-PLUS*)
            somrev=$(get_somrev)
            if [ "$(echo "$somrev < 2.0" | bc)" -eq 1 ]; then
                CM_DTB=${CM_DTB_SOM_1X}
            fi
            ;;
    esac
elif [ "${MACHINE#*SPEAR-MX8*}" != "${MACHINE}" ]; then
    readonly CM_DTB=${CM_DTB_SPEAR}
elif [ "${MACHINE#*VAR-SMARC*}" != "${MACHINE}" ]; then
    readonly CM_DTB=${CM_DTB_SMARC}
else
    echo "Error: Unknown machine ${MACHINE}"
    exit
fi

# Verify CM_DTB not empty
if [ -z "${CM_DTB}" ]; then
    echo "Error: Please configure CM_DTB with correct Linux Device Tree in ${CONF_SCRIPT}"
    exit
fi
