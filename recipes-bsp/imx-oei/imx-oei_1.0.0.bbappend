SRC_URI:var-som = "git://github.com/varigit/imx-oei;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf-6.6.23-2.0.0_var01"
SRCREV:var-som = "52b1a1afb317fd85c604e088f29d1fa37457718d"

EXTRA_OEMAKE:remove:var-som = "DEBUG=1"

COMPATIBLE_MACHINE = "(mx95-generic-bsp)"
