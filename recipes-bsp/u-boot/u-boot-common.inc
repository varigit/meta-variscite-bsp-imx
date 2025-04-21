LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS += "bison-native"

UBOOT_SRC ?= "git://github.com/varigit/uboot-imx;protocol=https"

SRCBRANCH = "lf_v2024.04_6.6.52-2.2.0_var01"
SRCREV = "f64a286d4a8793417d9b28c13fd02f991ed3eea2"
UBOOT_INITIAL_ENV_DEVICE = "sd"

SRCBRANCH:var-som-mx6 = "lf_v2024.04_6.6.23-2.0.0_var01"
SRCREV:var-som-mx6 = "3367fa3a9fcdf5af4ff4c8362e9d6197a16fc183"
UBOOT_INITIAL_ENV_DEVICE:var-som-mx6 = "nand"

UBOOT_INITIAL_ENV_DEVICE:imx6ul-var-dart = "nand"

SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"

S = "${WORKDIR}/git"
