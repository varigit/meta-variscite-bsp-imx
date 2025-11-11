SECTION = "base"
SUMMARY = "Variscite specific extensions to pm-utils"
DESCRIPTION = "Scripts and utilities for power management specific to Variscite platforms."
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

PM_ETH_SUSPEND_MODE ?= "disabled"

RDEPENDS:${PN} = "pm-utils"

SRC_URI = " \
	file://00-ot.sh \
	file://01-eth.sh \
	file://02-bt.sh \
	file://03-wifi.sh \
"

S = "${WORKDIR}"

do_install() {
	install -d ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/00-ot.sh ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/01-eth.sh ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/02-bt.sh ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/03-wifi.sh ${D}/${sysconfdir}/pm/sleep.d

	echo "ETH_SUSPEND_MODE=\"${PM_ETH_SUSPEND_MODE}\"" > ${WORKDIR}/var_pm_config
	install -m 0644 ${WORKDIR}/var_pm_config ${D}/${sysconfdir}/pm/
}

FILES:${PN} = " \
	${sysconfdir}/pm/* \
	${sysconfdir}/pm/sleep.d/* \
"
