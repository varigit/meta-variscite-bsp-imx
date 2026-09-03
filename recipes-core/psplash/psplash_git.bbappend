FILESEXTRAPATHS:prepend := "${THISDIR}/psplash:"

SRC_URI:append:imx6ul-var-dart = " \
    file://psplash-start.service \
    file://psplash-systemd.service \
"

# The installed systemd integration is machine-specific.  Keep its package in
# the i.MX6UL package feed so it replaces any previously built NXP variant.
PACKAGE_ARCH:imx6ul-var-dart = "${MACHINE_SOCARCH}"

SYSTEMD_SERVICE:${PN}:remove:imx6ul-var-dart = "psplash-start@.service"
SYSTEMD_SERVICE:${PN}:append:imx6ul-var-dart = " psplash-start.service"

do_install:append:imx6ul-var-dart() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        # Do not let fb0/fb1 uevents start template service instances.
        rm -f ${D}${sysconfdir}/udev/rules.d/fb.rules

        install -m 0644 ${UNPACKDIR}/psplash-start.service \
            ${D}${systemd_system_unitdir}/psplash-start.service
        install -m 0644 ${UNPACKDIR}/psplash-systemd.service \
            ${D}${systemd_system_unitdir}/psplash-systemd.service
    fi
}
