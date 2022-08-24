FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_install:append () {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/bluealsa.service ${D}${systemd_unitdir}/system
}
