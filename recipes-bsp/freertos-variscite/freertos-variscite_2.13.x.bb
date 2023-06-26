# Copyright (C) 2023 Variscite
include freertos-variscite.inc

# See https://github.com/varigit/freertos-variscite/blob/mcuxpresso_sdk_2.13.x-var01/docs/MCUXpresso%20SDK%20Release%20Notes%20for%20MCIMX93-EVK.pdf
# "Development Tools" section for supported GCC version
CM_GCC = "10.3-2021.10"

SRCREV = "6a8cb483219ef3d6f9c2ef3dafd094b759eb9f10"
SRC_URI += " \
    git://github.com/varigit/freertos-variscite.git;protocol=https;branch=${MCUXPRESSO_BRANCH}; \
"

SRCREV:mx9-nxp-bsp = "0a30c2c94f77914808b73bd56a815c486eded993"
SRC_URI:mx9-nxp-bsp = " \
    git://github.com/varigit/freertos-variscite.git;protocol=https;branch=${MCUXPRESSO_BRANCH}; \
"

COMPATIBLE_MACHINE = "(mx9-nxp-bsp|imx8mm-var-dart|imx8mn-var-som|imx8mp-var-dart|imx8mq-var-dart)"
