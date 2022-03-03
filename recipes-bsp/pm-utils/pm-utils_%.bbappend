FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://remove_default_sleep_d.diff \
        file://01-bt.sh \
        file://02-wifi.sh \
"

SRC_URI:append:imx6ul-var-dart = " \
	file://03-eth.sh \
"

SRC_URI:append:imx8mm-var-dart = " \
	file://03-eth.sh \
"

SRC_URI:append:imx8mn-var-som = " \
        file://03-eth.sh \
"

SRC_URI:append:imx7-var-som = " \
        file://03-eth.sh \
"

SRC_URI:append:imx8mp-var-dart = " \
	file://03-eth.sh \
"

FILES:${PN} += "${sysconfdir}/pm/sleep.d/*"

do_install:append() {
	install -d ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/01-bt.sh ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/02-wifi.sh ${D}/${sysconfdir}/pm/sleep.d
}

do_install:append:imx6ul-var-dart() {
        install -d ${D}/${sysconfdir}/pm/sleep.d
        install -m 0755 ${WORKDIR}/03-eth.sh ${D}/${sysconfdir}/pm/sleep.d
}

do_install:append:imx7-var-som() {
	install -d ${D}/${sysconfdir}/pm/sleep.d
        install -m 0755 ${WORKDIR}/03-eth.sh ${D}/${sysconfdir}/pm/sleep.d
}

do_install:append:imx8mm-var-dart() {
        install -d ${D}/${sysconfdir}/pm/sleep.d
        install -m 0755 ${WORKDIR}/03-eth.sh ${D}/${sysconfdir}/pm/sleep.d
}

do_install:append:imx8mn-var-som() {
        install -d ${D}/${sysconfdir}/pm/sleep.d
        install -m 0755 ${WORKDIR}/03-eth.sh ${D}/${sysconfdir}/pm/sleep.d
}

do_install:append:imx8mp-var-dart() {
	install -d ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/03-eth.sh ${D}/${sysconfdir}/pm/sleep.d
}
