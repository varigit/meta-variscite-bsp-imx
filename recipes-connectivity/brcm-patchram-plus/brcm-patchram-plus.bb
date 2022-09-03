#@DESCRIPTION: Variscite brcm_patchram_plus network apps"
#
# http://www.variscite.com

LICENSE = "Apache-2.0"

S = "${WORKDIR}"

LIC_FILES_CHKSUM = "file://brcm_patchram_plus.c;md5=8730e07b5fe13575c21ef01769aa5b01"
SRC_URI = "file://brcm_patchram_plus.c"

do_compile() {
        ${CC} ${CFLAGS} ${LDFLAGS} -o brcm_patchram_plus brcm_patchram_plus.c
}

do_install() {
        install -d ${D}${bindir}/
        install -m 0755 ${S}/brcm_patchram_plus ${D}${bindir}/
}

FILES:${PN} = "${bindir}/brcm_patchram_plus"
