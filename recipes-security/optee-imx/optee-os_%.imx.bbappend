FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://0001-core-pta-attestation-fix-buffer-size-for-generated-k.patch \
    file://0002-core-pta-return-error-code-when-failing-to-deseriali.patch \
"

SRC_URI:append:imx8mq-var-dart = " file://0001-imx-imx8mq-add-support-more-than-3GB.patch"
SRC_URI:append:imx8mm-var-dart = " file://0001-imx-imx8mm-add-support-more-than-3GB.patch"

EXTRA_OEMAKE:append:imx8mq-var-dart = " \
    CFG_DDR_SIZE=${TEE_CFG_DDR_SIZE} \
    CFG_TZDRAM_START=${TEE_LOAD_ADDR} \
"

EXTRA_OEMAKE:append:imx8mp-var-dart = " \
    CFG_DDR_SIZE=${TEE_CFG_DDR_SIZE} \
"

EXTRA_OEMAKE:append:imx8mm-var-dart = " \
    CFG_DDR_SIZE=${TEE_CFG_DDR_SIZE} \
    CFG_TZDRAM_START=${TEE_LOAD_ADDR} \
"
