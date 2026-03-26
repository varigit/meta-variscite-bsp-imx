FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_configure:prepend:mender-uboot() {
    bbwarn "Cleaning up .config created by Mender"
    oe_runmake -C ${S} O=${B} ${UBOOT_MACHINE} mrproper
}

require recipes-bsp/u-boot/u-boot-mender.inc

SRC_URI:append:imx8mp-var-dart = " \
    file://0001-imx8mp_var_dart-Add-mender-configuration-options.patch \
"

SRC_URI:append:imx91-var-som = " \
    file://0001-imx91_var_som-Add-mender-configuration-options.patch \
"

SRC_URI:append:imx93-var-som = " \
    file://0001-imx93_var_som-Add-mender-configuration-options.patch \
"

SRC_URI:append:imx8mm-var-dart = " \
    file://0001-imx8mm_var_dart-Add-mender-configuration-options.patch \
"
