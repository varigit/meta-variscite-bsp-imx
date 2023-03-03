# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2017 NXP
# Copyright 2018-2020 Variscite Ltd.
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Linux kernel provided and supported by Variscite"
DESCRIPTION = "Linux kernel provided and supported by Variscite (based on the kernel provided by NXP) \
with focus on i.MX Family SOMs. It includes support for many IPs such as GPU, VPU and IPU."

require recipes-kernel/linux/linux-imx.inc
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

FILES:${KERNEL_PACKAGE_NAME}-base += "${nonarch_base_libdir}/modules/${KERNEL_VERSION}/modules.builtin.modinfo "

DEPENDS += "lzop-native bc-native"

DEFAULT_PREFERENCE = "1"

SRCBRANCH:mx6-nxp-bsp = "lf-5.10.y_var04"
KERNEL_SRC ?= "git://github.com/varigit/linux-imx;protocol=https"
SRC_URI = "${KERNEL_SRC};branch=${SRCBRANCH}"
SRCREV:mx6-nxp-bsp = "1483cba123232f4a7ac0881b39c3bfbfbf2f48de"
LINUX_VERSION:mx6-nxp-bsp = "5.10.72"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

LOCALVERSION:imx6ul-var-dart = "-imx6ul"

KBUILD_DEFCONFIG:mx6-nxp-bsp = "imx_v7_defconfig"
KBUILD_DEFCONFIG:imx6ul-var-dart = "imx_v7_var_defconfig"
KBUILD_DEFCONFIG:var-som-mx6 = "imx_v7_var_defconfig"
DEFAULT_DTB:imx6ul-var-dart = "sd-card"
DEFAULT_DTB:var-som-mx6 = "sd-card"
DEFAULT_DTB_PREFIX:imx6ul-var-dart = "imx6ull-var-dart-6ulcustomboard"
DEFAULT_DTB_PREFIX:var-som-mx6 = "imx6ull-var-som-symphony"

pkg_postinst:kernel-devicetree:append () {
   rm -f $D/boot/devicetree-*
}

pkg_postinst:kernel-devicetree:append:imx6ul-var-dart () {
    cd $D/boot
    ln -s ${DEFAULT_DTB_PREFIX}-${DEFAULT_DTB}.dtb ${DEFAULT_DTB_PREFIX}.dtb
}

pkg_postinst:kernel-devicetree:append:var-som-mx6 () {
    cd $D/boot
    ln -s ${DEFAULT_DTB_PREFIX}-${DEFAULT_DTB}.dtb ${DEFAULT_DTB_PREFIX}.dtb
}

KERNEL_VERSION_SANITY_SKIP="1"
COMPATIBLE_MACHINE = "(mx6-nxp-bsp)"
