FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

require var-nxp-wlan-sdk_git.inc

do_install () {
    install -d ${D}${datadir}/nxp_wireless
    install -m 0644 README ${D}${datadir}/nxp_wireless
}
