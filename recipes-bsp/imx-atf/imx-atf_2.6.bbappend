FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI = "git://github.com/varigit/imx-atf;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH = "lf_v2.6_var03"
SRCREV = "f21a37b137fd9e85d03cf44f2c2540356dd52fd9"

SRC_URI:mx8-nxp-bsp = "\
           file://0001-Makefile-Suppress-array-bounds-error.patch \
           file://rwx-segments.patch \
"

EXTRA_OEMAKE:append:imx8mq-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"

EXTRA_OEMAKE:append:imx8mm-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"

COMPATIBLE_MACHINE = "(mx9-nxp-bsp)"
