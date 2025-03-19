#!/bin/sh -e

readonly CONF_SCRIPT="${DIR_SCRIPT}/variscite-rproc.conf"
. ${CONF_SCRIPT}

readonly SOC="$(cat /sys/bus/soc/devices/soc0/soc_id)"
readonly MACHINE="$(cat /sys/bus/soc/devices/soc0/machine)"

# Increasing logging verbosity for debugging
sysctl kernel.printk=7 -q

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
    if [ "${CM_CORE}" -ge ${CM_CORES} ]; then
        echo
        echo "Error: ${SOC} only has ${CM_CORES} cortex ${CM_SERIES}s"
        help
    fi
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

# Initialize default Linux Device Tree
if [ "${MACHINE#*DART-MX*}" != "${MACHINE}" ]; then
    CM_DTB=${CM_DTB_DART}

    case "${MACHINE}" in
        *DART-MX8M-PLUS*|*DART-MX8M-MINI*)
            somrev=$(get_somrev)
            if [ "$(echo "$somrev < 2.0" | bc)" -eq 1 ]; then
                CM_DTB=${CM_DTB_DART_1X}
            fi
            ;;
    esac
elif [ "${MACHINE#*VAR-SOM*}" != "${MACHINE}" ]; then
    CM_DTB=${CM_DTB_SOM}

    case "$MACHINE" in
        *VAR-SOM-MX8M-PLUS*|*VAR-SOM-MX8M-MINI*)
            somrev=$(get_somrev)
            if [ "$(echo "$somrev < 2.0" | bc)" -eq 1 ]; then
                CM_DTB=${CM_DTB_SOM_1X}
            fi
            ;;
    esac
elif [ "${MACHINE#*SPEAR-MX8*}" != "${MACHINE}" ]; then
    readonly CM_DTB=${CM_DTB_SPEAR}
else
    echo "Error: Unknown machine ${MACHINE}"
    exit
fi

# Verify CM_DTB not empty
if [ -z "${CM_DTB}" ]; then
    echo "Error: Please configure CM_DTB with correct Linux Device Tree in ${CONF_SCRIPT}"
    exit
fi
