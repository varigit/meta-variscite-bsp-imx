LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS += "bison-native"

UBOOT_SRC ?= "git://github.com/varigit/uboot-imx;protocol=https"

SRCBRANCH = "lf_v2021.04_var03"
SRCREV = "08e82c15b6077ced0aa2bc393ad227fdb0f21f13"
UBOOT_INITIAL_ENV_DEVICE = "sd"

SRCBRANCH:var-som-mx6 = "imx_v2018.03_4.14.78_1.0.0_ga_var02"
SRCREV:var-som-mx6 = "f634b812f90a786002921c6f4987b896e62c5d7c"
UBOOT_INITIAL_ENV_DEVICE:var-som-mx6 = "nand"

SRCBRANCH:imx6ul-var-dart = "imx_v2018.03_4.14.78_1.0.0_ga_var02"
SRCREV:imx6ul-var-dart = "f3764c66fe7d0bdaa3363f63c70239e0c30cb355"
UBOOT_INITIAL_ENV_DEVICE:imx6ul-var-dart = "nand"

SRCBRANCH:imx7-var-som = "imx_v2018.03_4.14.78_1.0.0_ga_var02"
SRCREV:imx7-var-som = "f634b812f90a786002921c6f4987b896e62c5d7c"
UBOOT_INITIAL_ENV_DEVICE:imx7-var-som = "nand"

SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"

S = "${WORKDIR}/git"
