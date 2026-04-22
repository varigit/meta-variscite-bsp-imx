# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2017 NXP
# Copyright 2018-2026 Variscite Ltd.
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Variscite i.MX Linux kernel based on FSLC i.MX stable-merged branch"
DESCRIPTION = "Linux kernel provided and supported by Variscite for i.MX Family SoMs. \
It is based on the NXP kernel and also merges newer upstream kernel revisions via the \
linux-fslc repository."
HOMEPAGE = "https://github.com/varigit/linux-imx"

require recipes-kernel/linux/linux-variscite.inc

SRCBRANCH = "6.6-2.2.x-imx_var01"
SRCREV = "4d2f47c42584b18e0951746dcb74db1beef083ea"

LINUX_VERSION = "6.6.119"
LINUX_VERSION_EXTENSION = "-var-lts-next"

COMPATIBLE_MACHINE = "(mx6-nxp-bsp|mx7-nxp-bsp|mx8-nxp-bsp|mx9-nxp-bsp)"
