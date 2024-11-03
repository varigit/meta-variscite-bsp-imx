LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS += "bison-native"

UBOOT_SRC ?= "git://github.com/varigit/uboot-imx;protocol=https"

SRCBRANCH = "lf_v2024.04_6.6.23-2.0.0_var01"
SRCREV = "15f93470fcd03c288b6fd6a27fbb938857aebbbe"
UBOOT_INITIAL_ENV_DEVICE = "sd"

SRCBRANCH:imx6ul-var-dart = "imx_v2018.03_4.14.78_1.0.0_ga_var02"
SRCREV:imx6ul-var-dart = "9d5b55aeed8d084523c2f5d0762de5100952e4f0"
UBOOT_INITIAL_ENV_DEVICE:imx6ul-var-dart = "nand"

SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"

S = "${WORKDIR}/git"
