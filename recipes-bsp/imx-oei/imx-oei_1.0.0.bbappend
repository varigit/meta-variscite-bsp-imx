SRC_URI:var-som = "git://github.com/varigit/imx-oei;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf-6.6.3-1.0.0_var01"
SRCREV:var-som = "5424be9205e7879d53ae43cb6ba63df01e08d90c"

EXTRA_OEMAKE:remove:var-som = "DEBUG=1"

COMPATIBLE_MACHINE = "(mx95-generic-bsp)"
