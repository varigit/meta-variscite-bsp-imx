SRC_URI:var-som = "git://github.com/varigit/imx-oei;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf-6.18.20-2.0.0_var01"
SRCREV:var-som = "5ccc725d0ef7bc87f769974767c01a5f024ecd6f"

# TODO: Remove once upstream fixes the inline DDR_CONFIG expansion in EXTRA_OEMAKE.
OEI_DDR_CONFIG_FILE:var-som = "${@bb.utils.contains('PACKAGECONFIG', 'ecc', d.getVar('OEI_DDR_CONFIG_ECC'), d.getVar('OEI_DDR_CONFIG'), d)}"

EXTRA_OEMAKE:var-som = "\
    board=${OEI_BOARD} \
    DDR_CONFIG=${OEI_DDR_CONFIG_FILE} \
    DEBUG=1 \
    OEI_CROSS_COMPILE=arm-none-eabi-"

COMPATIBLE_MACHINE = "(mx95-generic-bsp)"
