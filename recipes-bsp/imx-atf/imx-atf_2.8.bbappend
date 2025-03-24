FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:var-som = "git://github.com/varigit/imx-atf;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf_v2.8_var02"
SRCREV:var-som = "723c01ee4903cbce4b4d43e84ad41fbb6385e578"

EXTRA_OEMAKE:append:imx8mq-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"

EXTRA_OEMAKE:append:imx8mm-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"
