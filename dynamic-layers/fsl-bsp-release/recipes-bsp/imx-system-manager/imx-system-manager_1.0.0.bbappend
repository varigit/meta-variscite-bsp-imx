SRC_URI:var-som = "git://github.com/varigit/imx-sm;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf-6.6.23-2.0.0_var01"
SRCREV:var-som = "3fee6dc5504b955bfa59ac91e2a41faca4f06473"

do_configure:var-som() {
    oe_runmake cfg
}

COMPATIBLE_MACHINE = "(mx95-generic-bsp)"
