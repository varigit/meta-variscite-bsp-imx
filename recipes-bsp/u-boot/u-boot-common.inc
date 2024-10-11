LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS += "bison-native"

UBOOT_SRC ?= "git://github.com/varigit/uboot-imx;protocol=https"

SRCBRANCH = "lf_v2024.04_6.6.23-2.0.0_var01"
SRCREV = "dd2e305f3a2d4fec4fe23c16b3e192fd036dcf0f"

UBOOT_INITIAL_ENV_DEVICE = "sd"

SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"

S = "${WORKDIR}/git"
