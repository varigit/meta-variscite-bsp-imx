LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS += "bison-native"

UBOOT_SRC ?= "git://github.com/varigit/uboot-imx;protocol=https"

SRCBRANCH = "lf_v2022.04_var01"
SRCREV = "49ec7c516ad2ad0c8a352cad5de69a5ac26c752c"
UBOOT_INITIAL_ENV_DEVICE = "sd"

SRCBRANCH:imx93-var-som = "lf_v2022.04_var02"
SRCREV:imx93-var-som = "3ec65fd1cf65a451205ab8e1f010df897ca9675f"
UBOOT_INITIAL_ENV_DEVICE:imx93-var-som = "sd"

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
