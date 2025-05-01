FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_configure:prepend:mender-uboot() {
    bbwarn "Cleaning up .config created by Mender"
    oe_runmake -C ${S} O=${B} ${UBOOT_MACHINE} mrproper
}

require recipes-bsp/u-boot/u-boot-mender.inc
