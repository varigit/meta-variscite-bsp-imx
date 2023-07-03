DESCRIPTION = "Install gpio utilities and scripts used by Variscite SOMs"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://gpiochip"

RDEPENDS:${PN} = "libgpiod-tools"

do_install() {
	install -d ${D}${sysconfdir}
	install -m 0644 ${WORKDIR}/gpiochip ${D}${sysconfdir}/gpiochip
}

FILES:${PN} = "${sysconfdir}/gpiochip"
