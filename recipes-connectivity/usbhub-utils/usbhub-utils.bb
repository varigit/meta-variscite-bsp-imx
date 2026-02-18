SUMMARY = "Variscite USB HUB reset utilities"
DESCRIPTION = "Scripts and utilities to manage the USB HUB reset on VAR-SMARC-MX8M-PLUS SOM"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

inherit systemd

SRC_URI = " \
    file://variscite-usbhub \
    file://variscite-usbhub.service \
"

S = "${WORKDIR}"

FILES:${PN}:append = " \
    ${sysconfdir}/usbhub/variscite-usbhub  \
    ${systemd_unitdir}/system/variscite-usbhub.service \
"

do_install() {
    install -Dm 0755 ${WORKDIR}/variscite-usbhub ${D}${sysconfdir}/usbhub/variscite-usbhub
    install -Dm 0644 ${WORKDIR}/variscite-usbhub.service ${D}/${systemd_unitdir}/system/variscite-usbhub.service
}

SYSTEMD_SERVICE:${PN} = "variscite-usbhub.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

COMPATIBLE_MACHINE = "(imx8mp-var-dart)"
