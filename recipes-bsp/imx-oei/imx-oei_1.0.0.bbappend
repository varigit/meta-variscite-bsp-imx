SRC_URI:var-som = "git://github.com/varigit/imx-oei;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf-6.12.20-2.0.0_var01"
SRCREV:var-som = "e5ed3502f14f6e3a889a04175a0ac4c1826233ef"

EXTRA_OEMAKE:remove:var-som = "DEBUG=1"

COMPATIBLE_MACHINE = "(mx95-generic-bsp)"
