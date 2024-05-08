FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:imx8mq-var-dart = " file://usb-power.rules"
SRC_URI:append:imx8mm-var-dart = " file://usb-power.rules"
SRC_URI:append:imx8mp-var-dart = " file://usb-power.rules"

do_install:append:imx8mq-var-dart () {
        install -d ${D}${sysconfdir}/udev/rules.d
        install -m 0644 ${WORKDIR}/usb-power.rules ${D}${sysconfdir}/udev/rules.d/
}

do_install:append:imx8mm-var-dart () {
        install -d ${D}${sysconfdir}/udev/rules.d
        install -m 0644 ${WORKDIR}/usb-power.rules ${D}${sysconfdir}/udev/rules.d/
}

do_install:append:imx8mp-var-dart () {
        install -d ${D}${sysconfdir}/udev/rules.d
        install -m 0644 ${WORKDIR}/usb-power.rules ${D}${sysconfdir}/udev/rules.d/
}
