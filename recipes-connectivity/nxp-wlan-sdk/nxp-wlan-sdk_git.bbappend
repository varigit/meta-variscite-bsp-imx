FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_install () {
    install -d ${D}${datadir}/nxp_wireless
    install -m 0644 README ${D}${datadir}/nxp_wireless
}
