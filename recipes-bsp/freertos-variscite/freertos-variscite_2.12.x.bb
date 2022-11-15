# Copyright (C) 2022 Variscite
include freertos-variscite.inc

SRCREV = "ec1d199c34cc37b0812a5bdc0de4cbfd020cbb4c"
# See https://github.com/varigit/freertos-variscite/blob/mcuxpresso_sdk_2.12.x-var01/docs/MCUXpresso%20SDK%20Release%20Notes%20for%20EVK-MIMX8MN.pdf
# "Development Tools" section for supported GCC version
CM_GCC = "gcc-arm-none-eabi-10.3-2021.10"

SRC_URI += " \
    git://github.com/varigit/freertos-variscite.git;protocol=https;branch=${MCUXPRESSO_BRANCH}; \
    https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2;name=gcc-arm-none-eabi-10.3-2021.10 \
"

SRC_URI[gcc-arm-none-eabi-10.3-2021.10.sha256sum] = "97dbb4f019ad1650b732faffcc881689cedc14e2b7ee863d390e0a41ef16c9a3"

COMPATIBLE_MACHINE = "(imx8mn-var-som)"
