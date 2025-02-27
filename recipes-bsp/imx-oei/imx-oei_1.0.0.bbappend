SRC_URI:var-som = "git://github.com/varigit/imx-oei;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf-6.6.52-2.2.0_var01"
SRCREV:var-som = "7b1da7588344313cb65b8e23a093ad7f563d9f34"

EXTRA_OEMAKE:remove:var-som = "DEBUG=1"

COMPATIBLE_MACHINE = "(mx95-generic-bsp)"
