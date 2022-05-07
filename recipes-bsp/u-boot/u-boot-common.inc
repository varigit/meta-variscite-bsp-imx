LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS += "bison-native"

UBOOT_SRC ?= "git://github.com/varigit/uboot-imx;protocol=https"

SRCBRANCH = "lf_v2021.04_var03"
SRCREV = "860c409f68878b11845739f385b947a1ad59f394"
UBOOT_INITIAL_ENV_DEVICE = "sd"

SRCBRANCH:var-som-mx6 = "imx_v2018.03_4.14.78_1.0.0_ga_var02"
SRCREV:var-som-mx6 = "e382ce1bbd5ce83e4f3b9dbeed5d04e41708aae5"
UBOOT_INITIAL_ENV_DEVICE:var-som-mx6 = "nand"

SRCBRANCH:imx6ul-var-dart = "imx_v2018.03_4.14.78_1.0.0_ga_var02"
SRCREV:imx6ul-var-dart = "d93550dda0996abbc653e79851b3448bd5ed44a5"
UBOOT_INITIAL_ENV_DEVICE:imx6ul-var-dart = "nand"

SRCBRANCH:imx7-var-som = "imx_v2018.03_4.14.78_1.0.0_ga_var02"
SRCREV:imx7-var-som = "59341359399c8caa4d27b9325b777b8062af80f9"
UBOOT_INITIAL_ENV_DEVICE:imx7-var-som = "nand"

SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"

S = "${WORKDIR}/git"
