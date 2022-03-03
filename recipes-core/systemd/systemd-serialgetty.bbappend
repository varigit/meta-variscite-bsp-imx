FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:imx8mm-var-dart = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:imx8mm-var-dart = " \ 
        ${systemd_unitdir}/system/* \
        ${sysconfdir}/systemd/system/* \
"

SRC_URI:append:imx8mp-var-dart = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"

FILES:${PN}:append:imx8mp-var-dart = " \
        ${systemd_unitdir}/system/* \
        ${sysconfdir}/systemd/system/* \
"

do_install:append:imx8mm-var-dart() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system
	
	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:imx8mp-var-dart() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}
