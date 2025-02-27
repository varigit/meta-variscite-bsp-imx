SRC_URI:var-som = "git://github.com/varigit/imx-sm;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf-6.6.52-2.2.0_var01"
SRCREV:var-som = "091468c0742b8f0cd3abf10e118cbd308c904de6"

do_configure:var-som() {
    oe_runmake cfg
}

COMPATIBLE_MACHINE = "(mx95-generic-bsp)"
