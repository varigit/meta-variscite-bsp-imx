# Copyright (C) 2024 Variscite
include freertos-variscite.inc

LIC_FILES_CHKSUM = "file://COPYING-BSD-3;md5=b66f32a90f9577a5a3255c21d79bc619"

# See https://github.com/varigit/freertos-variscite/blob/mcuxpresso_sdk_2.15.x-var01/docs/MCUXpresso%20SDK%20Release%20Notes%20for%20MCIMX93-EVK.pdf
# "Development Tools" section for supported GCC version
CM_GCC:mx9-nxp-bsp = "12.2.rel1"

MCUXPRESSO_BRANCH:mx9-nxp-bsp = "mcuxpresso_sdk_${PV}-var01"

# See https://github.com/varigit/freertos-variscite/blob/mcuxpresso_sdk_2.15.x-var01/docs/MCUXpresso%20SDK%20Release%20Notes%20for%20EVK-MIMX8MN.pdf
# "Development Tools" section for supported GCC version
CM_GCC = "12.3.rel1"

SRCREV = "8a2ccf360902da86c0540f96a524ddf32fb96cc5"
SRC_URI += " \
    git://github.com/varigit/freertos-variscite.git;protocol=https;branch=${MCUXPRESSO_BRANCH}; \
"

COMPATIBLE_MACHINE = "(imx8mn-var-som|mx9-nxp-bsp|imx8mm-var-dart|imx8mp-var-dart)"
