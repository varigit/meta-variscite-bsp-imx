# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2017 NXP
# Copyright 2018-2026 Variscite Ltd.
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Variscite i.MX Linux kernel based on NXP linux-imx BSP release tags"
DESCRIPTION = "Linux kernel provided and supported by Variscite (based on the kernel provided by NXP) \
with focus on i.MX Family SOMs. It includes support for many IPs such as GPU, VPU and IPU."
HOMEPAGE = "https://github.com/varigit/linux-imx"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

require recipes-kernel/linux/linux-variscite.inc

SRCBRANCH = "lf-6.6.y_6.6.52-2.2.2_var01"
SRCREV = "d8c6d581ab5eda7b6ed8172fa12a8ed5c50e8ad3"

LINUX_VERSION = "6.6.52"

COMPATIBLE_MACHINE = "(mx6-nxp-bsp|mx7-nxp-bsp|mx8-nxp-bsp|mx9-nxp-bsp)"
