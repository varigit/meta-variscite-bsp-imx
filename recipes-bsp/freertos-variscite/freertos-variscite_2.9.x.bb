# Copyright (C) 2021 Variscite
include freertos-variscite.inc

SRCREV = "a8b9a7ea089d791cd30c00cc691c2768f83cc307"
# See https://github.com/varigit/freertos-variscite/blob/mcuxpresso_sdk_2.9.x-var01/docs/MCUXpresso%20SDK%20Release%20Notes%20for%20EVK-MIMX8MN.pdf
# "Development Tools" section for supported GCC version
CM_GCC = "10.3-2021.10"

SRC_URI += " \
    git://github.com/varigit/freertos-variscite.git;protocol=https;branch=${MCUXPRESSO_BRANCH}; \
"
COMPATIBLE_MACHINE = "(imx8qm-var-som|imx8qxp-var-som|imx8qxpb0-var-som)"
