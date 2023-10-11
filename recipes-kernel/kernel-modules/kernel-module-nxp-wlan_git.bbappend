FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

require recipes-connectivity/nxp-wlan-sdk/var-nxp-wlan-sdk_git.inc

SRC_URI:append:var-som = " \
    file://moal_modprobe.conf \
    file://moal_modules-load.conf \
"

do_install:append:var-som() {
    install -d ${D}${sysconfdir}/modprobe.d
    install -m 0644 ${WORKDIR}/moal_modprobe.conf ${D}${sysconfdir}/modprobe.d/moal.conf

    install -d ${D}${sysconfdir}/modules-load.d
    install -m 0644 ${WORKDIR}/moal_modules-load.conf ${D}${sysconfdir}/modules-load.d/moal.conf
}
