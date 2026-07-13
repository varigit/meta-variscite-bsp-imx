SRC_URI:var-som = "git://github.com/varigit/imx-oei;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf-6.12.49-2.2.0_var01"
SRCREV:var-som = "395c4c349cf8db7dbb3df0cfe11fd4d005d40cc0"

# TODO: Remove once upstream fixes the inline DDR_CONFIG expansion in EXTRA_OEMAKE.
OEI_DDR_CONFIG_FILE:var-som = "${@bb.utils.contains('PACKAGECONFIG', 'ecc', d.getVar('OEI_DDR_CONFIG_ECC'), d.getVar('OEI_DDR_CONFIG'), d)}"

EXTRA_OEMAKE:var-som = "\
    board=${OEI_BOARD} \
    DDR_CONFIG=${OEI_DDR_CONFIG_FILE} \
    DEBUG=1 \
    OEI_CROSS_COMPILE=arm-none-eabi-"

COMPATIBLE_MACHINE = "(mx95-generic-bsp)"
