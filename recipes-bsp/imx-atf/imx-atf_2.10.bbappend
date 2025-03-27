FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:var-som = "git://github.com/varigit/imx-atf;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf_v2.10_6.6.52-2.2.0_var01"
SRCREV:var-som = "5ecc7e3cd6875ff3d054ec18deb2a1b62fdefe70"

EXTRA_OEMAKE:append:imx8mq-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"

EXTRA_OEMAKE:append:imx8mm-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"
