# Copyright (C) 2023 Variscite
include freertos-variscite.inc

# See https://github.com/varigit/freertos-variscite/blob/mcuxpresso_sdk_2.13.x-var01/docs/MCUXpresso%20SDK%20Release%20Notes%20for%20MCIMX93-EVK.pdf
# "Development Tools" section for supported GCC version
CM_GCC = "10.3-2021.10"

SRCREV = "66cb1c980506524e85364ddadbdaace381c621a6"
SRC_URI += " \
    git://github.com/varigit/freertos-variscite.git;protocol=https;branch=${MCUXPRESSO_BRANCH}; \
"

SRCREV:mx9-nxp-bsp = "f42b3c3b87bcffdf702a965d880569972333be65"
SRC_URI:append:mx9-nxp-bsp = " \
    git://github.com/varigit/freertos-variscite.git;protocol=https;branch=${MCUXPRESSO_BRANCH}; \
"

COMPATIBLE_MACHINE = "(mx9-nxp-bsp|imx8mm-var-dart|imx8mn-var-som|imx8mp-var-dart|imx8mq-var-dart)"
