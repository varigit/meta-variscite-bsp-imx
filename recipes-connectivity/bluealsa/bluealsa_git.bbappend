FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://bluealsa.service"

do_install:append () {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/bluealsa.service ${D}${systemd_unitdir}/system
}
