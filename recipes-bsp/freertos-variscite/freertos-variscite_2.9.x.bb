# Copyright (C) 2026 Variscite
require freertos-variscite.inc
LIC_FILES_CHKSUM = "file://COPYING-BSD-3;md5=0858ec9c7a80c4a2cf16e4f825a2cc91"
MCUXPRESSO_BRANCH = "mcuxpresso_sdk_${PV}-var01"
# See https://github.com/varigit/freertos-variscite/blob/mcuxpresso_sdk_2.9.x-var01/docs/MCUXpresso%20SDK%20Release%20Notes%20for%20EVK-MIMX8MN.pdf
# "Development Tools" section for supported GCC version
CM_GCC = "10.3-2021.10"
SRCREV = "a8b9a7ea089d791cd30c00cc691c2768f83cc307"
COMPATIBLE_MACHINE = "(imx8qm-var-som|imx8qxp-var-som)"
