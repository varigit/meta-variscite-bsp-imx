FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRCBRANCH:var-som = "lf_v2.6_var03"
SRCREV:var-som = "f21a37b137fd9e85d03cf44f2c2540356dd52fd9"

SRC_URI:var-som = "git://github.com/varigit/imx-atf;protocol=https;branch=${SRCBRANCH} \
           file://0001-Makefile-Suppress-array-bounds-error.patch \
           file://rwx-segments.patch \
"

EXTRA_OEMAKE:append:imx8mq-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"

EXTRA_OEMAKE:append:imx8mm-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"

COMPATIBLE_MACHINE:var-som = "(mx9-nxp-bsp)"
