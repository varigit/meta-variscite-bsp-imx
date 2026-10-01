SUMMARY = "Variscite suspend and resume utilities"
DESCRIPTION = "Scripts and utilities for power management specific to Variscite platforms."
SECTION = "base"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

PM_ETH_SUSPEND_MODE ?= "disabled"

SRC_URI = " \
    file://00-ot.sh \
    file://01-eth.sh \
    file://02-bt.sh \
    file://03-wifi.sh \
    file://01-variscite-sleep.conf \
"

S = "${UNPACKDIR}"

PACKAGES = "${PN} ${PN}-pm-utils ${PN}-systemd"

PM_UTILS_SLEEP_DIR = "${sysconfdir}/pm/sleep.d"
SYSTEMD_SLEEP_DIR = "${nonarch_libdir}/systemd/system-sleep"

FILES:${PN} += "\
    ${sysconfdir}/var-suspend-utils/var-suspend-config \
"

FILES:${PN}-pm-utils += "\
    ${sysconfdir}/pm/* \
    ${PM_UTILS_SLEEP_DIR}/* \
"

FILES:${PN}-systemd += "\
    ${sysconfdir}/systemd/sleep.conf.d/* \
    ${SYSTEMD_SLEEP_DIR}/* \
"

RDEPENDS:${PN}-pm-utils = "${PN} pm-utils"
RDEPENDS:${PN}-systemd = "${PN}"

do_install() {
    install -Dm 0644 ${S}/01-variscite-sleep.conf \
        ${D}${sysconfdir}/systemd/sleep.conf.d/01-variscite-sleep.conf

    for script in 00-ot.sh 01-eth.sh 02-bt.sh 03-wifi.sh; do
        install -Dm 0755 ${S}/${script} ${D}${PM_UTILS_SLEEP_DIR}/${script}
        install -Dm 0755 ${S}/${script} ${D}${SYSTEMD_SLEEP_DIR}/${script}
    done

    install -d ${D}${sysconfdir}/var-suspend-utils
    echo "ETH_SUSPEND_MODE=\"${PM_ETH_SUSPEND_MODE}\"" > \
        ${D}${sysconfdir}/var-suspend-utils/var-suspend-config
}
