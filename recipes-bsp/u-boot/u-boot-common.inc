LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS += "bison-native"

UBOOT_SRC ?= "git://github.com/varigit/uboot-imx;protocol=https"

SRCBRANCH = "lf_v2023.04_var01"
SRCREV = "6b1b1dde1e335e15a87459d5f7693231eb8a0283"

UBOOT_INITIAL_ENV_DEVICE = "sd"

SRCBRANCH:imx8mp-var-dart = "lf_v2023.04_var01"
SRCREV:imx8mp-var-dart = "341b473039306055c34e154af070e941d7cafb14"

SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"

S = "${WORKDIR}/git"
