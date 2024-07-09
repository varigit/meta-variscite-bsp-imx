SRC_URI:var-som = "git://github.com/varigit/imx-sm;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf-6.6.3-1.0.0_var01"
SRCREV:var-som = "e5ebd6893860695aaa44083405023411bf902859"

EXTRA_OEMAKE += "cfg"

COMPATIBLE_MACHINE = "(mx95-generic-bsp)"
