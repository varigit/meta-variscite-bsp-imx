# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2017 NXP
# Copyright 2018-2024 Variscite Ltd.
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Linux kernel provided and supported by Variscite"
DESCRIPTION = "Linux kernel provided and supported by Variscite (based on the kernel provided by NXP) \
with focus on i.MX Family SOMs. It includes support for many IPs such as GPU, VPU and IPU."
HOMEPAGE = "https://github.com/varigit/linux-imx"

require recipes-kernel/linux/linux-imx.inc
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

DEPENDS += "bc-native lzop-native"

DEFAULT_PREFERENCE = "1"

KERNEL_SRC ?= "git://github.com/varigit/linux-imx;protocol=https"

SRCBRANCH = "lf-6.6.y_6.6.52-2.2.0_var01"
SRC_URI = "${KERNEL_SRC};branch=${SRCBRANCH}"
SRCREV = "c2cab9d2643849a2df4ac0d764523d03f9304e30"

LINUX_VERSION = "6.6.52"
LINUX_VERSION_EXTENSION = "-var-lts-next"

KBUILD_DEFCONFIG:mx6-nxp-bsp = "imx_v7_var_defconfig"
KBUILD_DEFCONFIG:mx7-nxp-bsp = "imx_v7_var_defconfig"
KBUILD_DEFCONFIG:mx8-nxp-bsp = "imx8_var_defconfig"
KBUILD_DEFCONFIG:mx9-nxp-bsp = "imx8_var_defconfig"
KBUILD_DEFCONFIG:imx8mq-var-dart = "imx8mq_var_dart_defconfig"
DEFAULT_DTB:imx8mq-var-dart = "sd-lvds"
DEFAULT_DTB:imx8qxp-var-som = "sd"
DEFAULT_DTB:imx8qm-var-som = "lvds"
DEFAULT_DTB_PREFIX:imx8mq-var-dart = "imx8mq-var-dart-dt8mcustomboard"
DEFAULT_DTB_PREFIX:imx8qxp-var-som = "imx8qxp-var-som-symphony"
DEFAULT_DTB_PREFIX:imx8qm-var-som = "imx8qm-var-som-symphony"

pkg_postinst:kernel-devicetree:append () {
   rm -f $D/boot/devicetree-*
}

pkg_postinst:kernel-devicetree:append:imx8mq-var-dart () {
    cd $D/boot
    ln -s ${DEFAULT_DTB_PREFIX}-${DEFAULT_DTB}.dtb ${DEFAULT_DTB_PREFIX}.dtb
}

pkg_postinst:kernel-devicetree:append:imx8qxp-var-som () {
    cd $D/boot
    ln -s ${DEFAULT_DTB_PREFIX}-${DEFAULT_DTB}.dtb ${DEFAULT_DTB_PREFIX}.dtb
    ln -s ${DEFAULT_DTB_PREFIX}-1.x-${DEFAULT_DTB}.dtb ${DEFAULT_DTB_PREFIX}-1.x.dtb
}

pkg_postinst:kernel-devicetree:append:imx8qm-var-som () {
    cd $D/boot
    ln -s ${DEFAULT_DTB_PREFIX}-${DEFAULT_DTB}.dtb ${DEFAULT_DTB_PREFIX}.dtb
    ln -s imx8qp-var-som-symphony-${DEFAULT_DTB}.dtb imx8qp-var-som-symphony.dtb
    ln -s imx8qm-var-spear-sp8customboard-${DEFAULT_DTB}.dtb imx8qm-var-spear-sp8customboard.dtb
    ln -s imx8qp-var-spear-sp8customboard-${DEFAULT_DTB}.dtb imx8qp-var-spear-sp8customboard.dtb
}

FILES:${KERNEL_PACKAGE_NAME}-base += "${nonarch_base_libdir}/modules/${KERNEL_VERSION}/modules.builtin.modinfo "

KERNEL_VERSION_SANITY_SKIP = "1"
COMPATIBLE_MACHINE = "(mx6-nxp-bsp|mx7-nxp-bsp|mx8-nxp-bsp|mx9-nxp-bsp)"
