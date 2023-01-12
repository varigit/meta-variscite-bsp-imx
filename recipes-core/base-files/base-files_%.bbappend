FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:var-som = " \
	file://variscite-blacklist.conf \
"

SRC_URI:append:imx8mp-var-dart = " \
	file://variscite-hdmi-audio.conf \
"

do_install:append:var-som() {
	install -m 0755 -d ${D}${sysconfdir}/modprobe.d
	install -m 0644 ${WORKDIR}/variscite-blacklist.conf ${D}${sysconfdir}/modprobe.d
}

do_install:append:imx8mp-var-dart() {
	install -m 0644 ${WORKDIR}/variscite-hdmi-audio.conf ${D}${sysconfdir}/modprobe.d
}
