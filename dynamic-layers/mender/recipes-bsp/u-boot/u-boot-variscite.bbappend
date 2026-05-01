FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://mender-required-configs.cfg \
"

B = "${WORKDIR}/build"

require recipes-bsp/u-boot/u-boot-mender.inc

do_configure[cleandirs] = "${B}"

# Mender validates required U-Boot symbols in do_provide_mender_defines() [1],
# before the normal U-Boot configuration flow applies the final board settings.
# This replaces Mender's base fragment file, excluding variables that may be
# overridden later by other fragments.
#
# [1] https://github.com/mendersoftware/meta-mender/blob/c3064a2767be4779589bd276079d7bb535dcb481/meta-mender-core/recipes-bsp/u-boot/u-boot-mender.inc#L212-L266
do_provide_mender_defines:append() {
    printf '%s\n' \
        "CONFIG_ENV_OFFSET=$HEX_MENDER_UBOOT_ENV_STORAGE_DEVICE_OFFSET_1" \
        "CONFIG_ENV_OFFSET_REDUND=$HEX_MENDER_UBOOT_ENV_STORAGE_DEVICE_OFFSET_2" \
        "CONFIG_SYS_MMC_ENV_PART=${MENDER_UBOOT_CONFIG_SYS_MMC_ENV_PART}" \
        > "${S}/mender_Kconfig_fragment"
}

# Convert zero-filled env to 0xFF so bmaptool copies it.
do_deploy:append:mender-uboot() {
    if [ -f ${DEPLOYDIR}/uboot.env ]; then
        dd if=/dev/zero bs=${MENDER_BOOTENV_TOTAL_ALIGNED_SIZE} count=1 \
          | tr '\000' '\377' > ${WORKDIR}/uboot.env
        install -m 644 ${WORKDIR}/uboot.env ${DEPLOYDIR}/uboot.env
    fi
}
