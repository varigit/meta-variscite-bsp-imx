SRC_URI = "git://github.com/varigit/imx-atf;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH = "lf_v2.6_var01"
SRCREV = "b15d97961fd1a921624a645aef9f2e10ef54b36c"

EXTRA_OEMAKE:append:imx8mq-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"

