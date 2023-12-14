LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS += "bison-native"

UBOOT_SRC ?= "git://github.com/varigit/uboot-imx;protocol=https"

SRCBRANCH = "lf_v2022.04_var01"
SRCREV = "49ec7c516ad2ad0c8a352cad5de69a5ac26c752c"
UBOOT_INITIAL_ENV_DEVICE = "sd"

SRCBRANCH:var-som-mx6 = "lf_v2022.04_var03"
SRCREV:var-som-mx6 = "90bc43d4fb45eea881602d2ceeefc0aee6937bd5"
UBOOT_INITIAL_ENV_DEVICE:var-som-mx6 = "nand"

SRCBRANCH:imx6ul-var-dart = "imx_v2018.03_4.14.78_1.0.0_ga_var02"
SRCREV:imx6ul-var-dart = "f634b812f90a786002921c6f4987b896e62c5d7c"
UBOOT_INITIAL_ENV_DEVICE:imx6ul-var-dart = "nand"

SRCBRANCH:imx7-var-som = "imx_v2018.03_4.14.78_1.0.0_ga_var02"
SRCREV:imx7-var-som = "f634b812f90a786002921c6f4987b896e62c5d7c"
UBOOT_INITIAL_ENV_DEVICE:imx7-var-som = "nand"

SRCBRANCH:imx8mn-var-som = "lf_v2022.04_var02"
SRCREV:imx8mn-var-som = "b826a06b6b8376bc0047a3f7c4d2d9ec6f29e428"
UBOOT_INITIAL_ENV_DEVICE:imx8mn-var-som = "sd"

SRCBRANCH:imx8mp-var-dart = "lf_v2022.04_var02"
SRCREV:imx8mp-var-dart = "c075ac258be433eb7db4384298ca21cbea9959e8"
UBOOT_INITIAL_ENV_DEVICE:imx8mp-var-dart = "sd"

SRCBRANCH:imx93-var-som = "lf_v2022.04_var02"
SRCREV:imx93-var-som = "277ff23bfc0eb4a1fdd0bc114b64edddff311903"
UBOOT_INITIAL_ENV_DEVICE:imx93-var-som = "sd"

SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"

S = "${WORKDIR}/git"
