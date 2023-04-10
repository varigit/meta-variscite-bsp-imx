require var-mii_git.inc

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/var-mii ${D}${bindir}
}

FILES_${PN} += "${bindir}/var-mii"
