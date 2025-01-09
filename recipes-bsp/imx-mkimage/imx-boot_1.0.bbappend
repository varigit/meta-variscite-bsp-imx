# Copyright (C) 2017-2024 NXP
# Copyright (C) 2024 Variscite LTD

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:var-som = " \
    file://0001-iMX8M-soc-allow-dtb-override.patch \
    file://0002-iMX8M-soc-change-padding-of-DDR4-and-LPDDR4-DMEM-fir.patch \
    "

SRC_URI:append:imx8mm-var-dart = " \
    file://0001-iMX8M-soc-imx8mm-move-TEE_LOAD_ADDR-to-512mb-memory-.patch \
    file://0003-iMX8M-soc-add-variscite-imx8mm-support.patch \
"

SRC_URI:append:imx8mq-var-dart = " file://0001-iMX8M-soc-imx8mq-move-TEE_LOAD_ADDR-to-512mb-memory.patch"

compile_mx8m:var-som() {
    bbnote 8MQ/8MM/8MN/8MP boot binary build
    for ddr_firmware in ${DDR_FIRMWARE_NAME}; do
        bbnote "Copy ddr_firmware: ${ddr_firmware} from ${DEPLOY_DIR_IMAGE} -> ${BOOT_STAGING} "
        cp ${DEPLOY_DIR_IMAGE}/${ddr_firmware}               ${BOOT_STAGING}
    done

    cp ${DEPLOY_DIR_IMAGE}/signed_dp_imx8m.bin               ${BOOT_STAGING}
    cp ${DEPLOY_DIR_IMAGE}/signed_hdmi_imx8m.bin             ${BOOT_STAGING}
    cp ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG_EXTRA} \
                                                             ${BOOT_STAGING}/u-boot-spl.bin

    if [ "x${UBOOT_SIGN_ENABLE}" = "x1" ] ; then
        # Use DTB binary patched with signature node
        cp ${DEPLOY_DIR_IMAGE}/${UBOOT_DTB_BINARY}           ${BOOT_STAGING}/${UBOOT_DTB_NAME_EXTRA}
    else
        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME_EXTRA} \
                                                             ${BOOT_STAGING}
    fi
    if [ "${UBOOT_DTB_NAME_EXTRA}" != "${UBOOT_DTB_NAME}" ] ; then
        ln -sf ${UBOOT_DTB_NAME_EXTRA}                       ${BOOT_STAGING}/${UBOOT_DTB_NAME}
    fi

    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/u-boot-nodtb.bin-${MACHINE}-${UBOOT_CONFIG_EXTRA} \
                                                             ${BOOT_STAGING}/u-boot-nodtb.bin

    cp ${DEPLOY_DIR_IMAGE}/${ATF_MACHINE_NAME}               ${BOOT_STAGING}/bl31.bin

    cp ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME_EXTRA}               ${BOOT_STAGING}/u-boot.bin

}

do_compile:var-som() {
    echo "Copying DTBs"
    if [ "mx8m" = "${SOC_FAMILY}" ]; then
        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}

        for UBOOT_DTB_EXTRA_FILE in ${UBOOT_DTB_EXTRA}; do
            cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_EXTRA_FILE} ${BOOT_STAGING}
        done
    fi

    # mkimage for i.MX8
    # Copy TEE binary to SoC target folder to mkimage
    if ${DEPLOY_OPTEE}; then
        cp ${DEPLOY_DIR_IMAGE}/tee.bin ${BOOT_STAGING}
        if ${DEPLOY_OPTEE_STMM}; then
            # Copy tee.bin to tee.bin-stmm
            cp ${DEPLOY_DIR_IMAGE}/tee.bin ${BOOT_STAGING}/tee.bin-stmm
        fi
    fi
    # Copy OEI firmware to SoC target folder to mkimage
    if [ "${OEI_ENABLE}" = "YES" ]; then
        cp ${DEPLOY_DIR_IMAGE}/${OEI_NAME} ${BOOT_STAGING}
    fi

    for type in ${UBOOT_CONFIG}; do
        if [ "${@d.getVarFlags('UBOOT_DTB_NAME')}" = "None" ]; then
            UBOOT_DTB_NAME_FLAGS="${type}:${UBOOT_DTB_NAME}"
        else
            UBOOT_DTB_NAME_FLAGS="${@' '.join(flag + ':' + dtb for flag, dtb in (d.getVarFlags('UBOOT_DTB_NAME')).items()) if d.getVarFlags('UBOOT_DTB_NAME') is not None else '' }"
        fi

        for key_value in ${UBOOT_DTB_NAME_FLAGS}; do
            type_key="${key_value%%:*}"
            dtb_name="${key_value#*:}"

            if [ "$type_key" = "$type" ]
            then
                bbnote "UBOOT_CONFIG = $type, UBOOT_DTB_NAME = $dtb_name"

                UBOOT_CONFIG_EXTRA="$type_key"
                if [ -e ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${dtb_name}-${type} ] ; then
                    UBOOT_DTB_NAME_EXTRA="${dtb_name}-${type}"
                else
                    # backward compatibility
                    UBOOT_DTB_NAME_EXTRA="${dtb_name}"
                fi
                UBOOT_NAME_EXTRA="u-boot-${MACHINE}.bin-${UBOOT_CONFIG_EXTRA}"
                BOOT_CONFIG_MACHINE_EXTRA="imx-boot${BOOT_VARIANT}-${MACHINE}-${UBOOT_CONFIG_EXTRA}.bin"

                for target in ${IMXBOOT_TARGETS}; do
                    compile_${SOC_FAMILY}
                    case $target in
                    *no_v2x)
                        # Special target build for i.MX 8DXL with V2X off
                        bbnote "building ${IMX_BOOT_SOC_TARGET} - ${REV_OPTION} V2X=NO ${target}"
                        make SOC=${IMX_BOOT_SOC_TARGET} ${REV_OPTION} V2X=NO dtbs=${UBOOT_DTB_NAME_EXTRA} flash_linux_m4
                        ;;
                    *stmm_capsule)
                        # target for flash_evk_stmm_capsule or
                        # flash_singleboot_stmm_capsule
                        cp ${RECIPE_SYSROOT_NATIVE}/${bindir}/mkeficapsule ${BOOT_STAGING}
                        bbnote "building ${IMX_BOOT_SOC_TARGET} - TEE=tee.bin-stmm ${target}"
                        cp ${DEPLOY_DIR_IMAGE}/CRT.* ${BOOT_STAGING}
                        make SOC=${IMX_BOOT_SOC_TARGET} TEE=tee.bin-stmm dtbs=${UBOOT_DTB_NAME} ${REV_OPTION} ${target}
                        ;;
                    *)
                        bbnote "building ${IMX_BOOT_SOC_TARGET} - ${REV_OPTION} ${MKIMAGE_EXTRA_ARGS} ${target}"
                        make SOC=${IMX_BOOT_SOC_TARGET} ${REV_OPTION} ${MKIMAGE_EXTRA_ARGS} \
                             dtbs="${UBOOT_DTB_NAME} ${UBOOT_DTB_EXTRA}" \
                             ${target}
                        ;;
                    esac

                    if [ -e "${BOOT_STAGING}/flash.bin" ]; then
                        cp ${BOOT_STAGING}/flash.bin ${S}/${BOOT_CONFIG_MACHINE_EXTRA}-${target}
                    fi
                done

                unset UBOOT_CONFIG_EXTRA
                unset UBOOT_DTB_NAME_EXTRA
                unset UBOOT_NAME_EXTRA
                unset BOOT_CONFIG_MACHINE_EXTRA
            fi

            unset type_key
            unset dtb_name
        done

        unset UBOOT_DTB_NAME_FLAGS
    done
    unset type
}
