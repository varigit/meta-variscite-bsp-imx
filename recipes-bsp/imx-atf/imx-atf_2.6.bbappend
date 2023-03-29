FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:mx8-nxp-bsp = "git://github.com/varigit/imx-atf;protocol=https;branch=${SRCBRANCH} \
           file://0001-Makefile-Suppress-array-bounds-error.patch \
           file://rwx-segments.patch \
"
SRCBRANCH:mx8-nxp-bsp = "lf_v2.6_var01"
SRCREV:mx8-nxp-bsp = "b0039c73c070f0f1a6455c6c0d828310f12f0e8d"

SRCBRANCH:imx8mn-var-som = "lf_v2.6_var02"
SRCREV:imx8mn-var-som = "3ba4f054ee1cf65a00d28ba84b2c5b0aa7375556"

SRCBRANCH:imx8mp-var-dart = "lf_v2.6_var02"
SRCREV:imx8mp-var-dart = "3ba4f054ee1cf65a00d28ba84b2c5b0aa7375556"

EXTRA_OEMAKE:append:imx8mq-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"

EXTRA_OEMAKE:append:imx8mm-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"
