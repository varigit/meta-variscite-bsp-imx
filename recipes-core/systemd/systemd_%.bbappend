FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append:imx-generic-bsp = " file://imx.conf \
            file://0001-units-add-dependencies-to-avoid-conflict-between-con.patch \
"

do_install:append:imx-generic-bsp() {
    install -Dm 0644 ${WORKDIR}/imx.conf ${D}${sysconfdir}/systemd/logind.conf.d/imx.conf
}

