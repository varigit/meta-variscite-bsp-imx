LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS += "bison-native"

UBOOT_SRC ?= "git://github.com/varigit/uboot-imx;protocol=https"
SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"

SRCBRANCH = "lf_v2024.04_6.6.52-2.2.2_var01"
SRCREV = "ac4e317d626e92d889fe0ff222de800c9ac5fdb0"
UBOOT_INITIAL_ENV_DEVICE = "sd"

UBOOT_INITIAL_ENV_DEVICE:var-som-mx6 = "nand"

UBOOT_INITIAL_ENV_DEVICE:imx6ul-var-dart = "nand"

UBOOT_INITIAL_ENV_DEVICE:imx7-var-som = "nand"

S = "${WORKDIR}/git"
