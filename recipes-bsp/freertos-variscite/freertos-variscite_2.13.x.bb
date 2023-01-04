# Copyright (C) 2023 Variscite
include freertos-variscite.inc

# See https://github.com/varigit/freertos-variscite/blob/mcuxpresso_sdk_2.13.x-var01/docs/MCUXpresso%20SDK%20Release%20Notes%20for%20MCIMX93-EVK.pdf
# "Development Tools" section for supported GCC version
CM_GCC:mx9-nxp-bsp = "gcc-arm-none-eabi-10.3-2021.10"

# The MCUXpresso SDK for the i.MX93 is currently available only from NXP's Beta
# program. To rebuild from source:
#  1) Download the MCUXpresso SDK from NXP
#  2) Add it to your own git repository
#  3) Change SRC_URI to use your git repository
#  4) bitbake -c install freertos-variscite
#  5) The binary is located: tmp/work/imx93_var_som-poky-linux/freertos-variscite/2.13.x-r0/image/lib/firmware/ethosu_firmware
SRCREV:mx9-nxp-bsp = "48b5b9a8b793dc9f86ad5dbad20a6cf2e4cc36ae"
SRC_URI:mx9-nxp-bsp = " \
    git://git@github.com/varigit/freertos-variscite-private;protocol=ssh;branch=${MCUXPRESSO_BRANCH}; \
    https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2;name=gcc-arm-none-eabi-10.3-2021.10 \
    file://0001-mcimx93evk-demo_apps-ethosu_apps_rpmsg-port-to-VAR-S.patch \
"

SRC_URI[gcc-arm-none-eabi-10.3-2021.10.sha256sum] = "97dbb4f019ad1650b732faffcc881689cedc14e2b7ee863d390e0a41ef16c9a3"

COMPATIBLE_MACHINE = "(mx9-nxp-bsp)"
