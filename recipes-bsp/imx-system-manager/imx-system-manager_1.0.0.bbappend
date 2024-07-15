SRC_URI:var-som = "git://github.com/varigit/imx-sm;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf-6.6.3-1.0.0_var01"
SRCREV:var-som = "029f7626be526165ffb9a8dd1a54d23af54aceb8"

do_configure:var-som() {
    oe_runmake cfg
}

COMPATIBLE_MACHINE = "(mx95-generic-bsp)"
