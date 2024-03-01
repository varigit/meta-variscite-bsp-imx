FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PM_ETH_SUSPEND_MODE ?= "disabled"

SRC_URI:append = " \
	file://remove_default_sleep_d.diff \
	file://00-ot.sh \
	file://01-bt.sh \
	file://02-wifi.sh \
	file://03-eth.sh \
"

FILES:${PN} += "${sysconfdir}/pm/sleep.d/*"

do_install:append() {
	install -d ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/00-ot.sh ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/01-bt.sh ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/02-wifi.sh ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/03-eth.sh ${D}/${sysconfdir}/pm/sleep.d

	echo "ETH_SUSPEND_MODE=\"${PM_ETH_SUSPEND_MODE}\"" > ${WORKDIR}/var_pm_config
	install -m 0644 ${WORKDIR}/var_pm_config ${D}/${sysconfdir}/pm/
}
