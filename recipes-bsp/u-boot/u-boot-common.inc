LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS += "bison-native efitools-native"

UBOOT_SRC ?= "git://github.com/varigit/uboot-imx;protocol=https"
SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"

SRCBRANCH = "lf_v2026.04_6.18.20-2.0.0_var01"
SRCREV = "e6b091a108aa9e54688d7defb2dbb9ecfba28c99"
UBOOT_INITIAL_ENV_DEVICE = "sd"

UBOOT_INITIAL_ENV_DEVICE:var-som-mx6 = "nand"

UBOOT_INITIAL_ENV_DEVICE:imx6ul-var-dart = "nand"

UBOOT_INITIAL_ENV_DEVICE:imx7-var-som = "nand"
