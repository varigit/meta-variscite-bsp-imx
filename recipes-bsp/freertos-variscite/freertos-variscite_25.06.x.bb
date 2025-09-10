# Copyright (C) 2025 Variscite
require freertos-variscite.inc

LIC_FILES_CHKSUM = "file://COPYING-BSD-3;md5=44c38a502d2cf694b754eea743b6ec97"

# See https://mcuxpresso.nxp.com/mcuxsdk/25.09.00-pvw2/html/boards/i.MX/imx95lpd5evk19/releaseNotes/rnindex.html#development-tools
CM_GCC = "14.2.rel1"

MCUXPRESSO_BRANCH = "mcuxpresso_sdk_${PV}-var01"

SRCREV = "c16f95aaff1f1e65ee3c6b5fa6ef0332c9bd6253"

COMPATIBLE_MACHINE = "(imx95-var-dart)"
