DESCRIPTION = "Configuration utility for TI wireless drivers"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://README;beginline=1;endline=21;md5=adc05a1903d3f107f85c90328e3a9438"

# Tag: R8.8 (8.8)
SRCREV = "b23772347318e5e3f724e9686f271efc01512708"
SRC_URI = "git://git.ti.com/cgit/wilink8-wlan/18xx-ti-utils;protocol=https;branch=master"

S = "${WORKDIR}/git/wlconf"

EXTRA_OEMAKE = "CC="${CC}""

do_install() {
	install -d ${D}${sbindir}
	install -d ${D}${sbindir}/wlconf/
	install -d ${D}${sbindir}/wlconf/official_inis
	install -d ${D}/lib/firmware/ti-connectivity

	install -m 0755 wlconf ${D}${sbindir}/wlconf/
	install -m 0755 dictionary.txt ${D}${sbindir}/wlconf/
	install -m 0755 struct.bin ${D}${sbindir}/wlconf/
	install -m 0755 default.conf ${D}${sbindir}/wlconf/
	install -m 0755 wl18xx-conf-default.bin ${D}${sbindir}/wlconf/
	install -m 0755 wl18xx-conf-default.bin ${D}/lib/firmware/ti-connectivity/wl18xx-conf.bin
	install -m 0755 README ${D}${sbindir}/wlconf/
	install -m 0755 example.conf ${D}${sbindir}/wlconf/
	install -m 0755 example.ini ${D}${sbindir}/wlconf/
	install -m 0755 configure-device.sh ${D}${sbindir}/wlconf/
	install -m 0755 ${S}/official_inis/* \
			${D}${sbindir}/wlconf/official_inis/
}

FILES:${PN} += " \
	${sbindir}/wlconf \
	${sbindir}/wlconf/official_inis \
	/lib/firmware/ti-connectivity/wl18xx-conf.bin \
"

FILES:${PN}-dbg += "${sbindir}/wlconf/.debug"
