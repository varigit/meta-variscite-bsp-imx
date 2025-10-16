SRC_URI:var-som = "git://github.com/varigit/imx-sm;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf-6.6.52-2.2.0_var01"
SRCREV:var-som = "3489fbe6765cc8628ecc441262b549f7292c1d5e"

do_configure:var-som() {
    oe_runmake cfg
}

COMPATIBLE_MACHINE = "(mx95-generic-bsp)"
