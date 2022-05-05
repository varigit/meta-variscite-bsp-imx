FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://remove_default_sleep_d.diff \
        file://01-bt.sh \
        file://02-wifi.sh \
        file://03-eth.sh \
"

FILES:${PN} += "${sysconfdir}/pm/sleep.d/*"

do_install:append() {
	install -d ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/01-bt.sh ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/02-wifi.sh ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/03-eth.sh ${D}/${sysconfdir}/pm/sleep.d
}
