FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:imx95-var-dart = " \
    file://mender-required-configs.cfg \
"

MENDER_UBOOT_FRAGMENTS = " \
    ${UNPACKDIR}/mender-required-configs.cfg \
"

require recipes-bsp/u-boot/u-boot-mender.inc

# Mender validates its required U-Boot settings early [1], before configuration
# fragments are applied. The Mender fragments are pre-merged here so those
# settings are visible during validation, while still allowing the normal
# configuration stage to regenerate the final configuration afterward.
#
# [1] https://github.com/mendersoftware/meta-mender/blob/c3064a2767be4779589bd276079d7bb535dcb481/meta-mender-core/recipes-bsp/u-boot/u-boot-mender.inc#L212-L266
do_provide_mender_defines:append() {
    for frag in ${MENDER_UBOOT_FRAGMENTS}; do
        cat "$frag" >> ${S}/mender_Kconfig_fragment
    done

    bbnote "Pre-merging Mender fragment into U-Boot config for ${MACHINE}"
    rm -f ${B}/.config
    oe_runmake -C ${S} O=${B} ${UBOOT_MACHINE}
    merge_config.sh -m -O ${B} ${B}/.config ${S}/mender_Kconfig_fragment
    oe_runmake -C ${S} O=${B} olddefconfig
}

do_configure:append:mender-uboot() {
    rm -f ${B}/.config
    rm -rf ${B}/include/config ${B}/include/generated
}

# Convert zero-filled env to 0xFF so bmaptool copies it.
do_deploy:append:mender-uboot() {
    if [ -f ${DEPLOYDIR}/uboot.env ]; then
        dd if=/dev/zero bs=${MENDER_BOOTENV_TOTAL_ALIGNED_SIZE} count=1 \
          | tr '\000' '\377' > ${WORKDIR}/uboot.env
        install -m 644 ${WORKDIR}/uboot.env ${DEPLOYDIR}/uboot.env
    fi
}
