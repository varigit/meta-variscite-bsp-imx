FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:var-som = "git://github.com/varigit/imx-atf;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf_v2.12_6.18.2-1.0.0_var01"
SRCREV:var-som = "bf53e42ff8fea3a1477df93ff264bcbee613f7aa"

EXTRA_OEMAKE:append:imx8mq-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"

EXTRA_OEMAKE:append:imx8mm-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"
