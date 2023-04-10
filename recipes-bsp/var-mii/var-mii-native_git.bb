require var-mii_git.inc

inherit native

do_install() {
    install -d ${D}${STAGING_DIR_NATIVE}
    install -m 0755 var-mii ${D}${STAGING_DIR_NATIVE}
}

FILES_${PN} += "${bindir}/var-mii"
