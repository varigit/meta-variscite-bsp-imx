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

SRC_URI:append:imx93-var-som = " file://0004-iMX93-soc-change-padding-of-LPDDR4-DMEM-firmware.patch"

python __anonymous () {
    import re

    # Do not run when hab is in OVERRIDES for compatability with meta-variscite-hab
    if re.search(r'\bhab\b', d.getVar('OVERRIDES') or ""):
        return  # Do nothing if 'hab' is in OVERRIDES

    do_compile_orig = d.getVar('do_compile') or ""

    # Insert ${UBOOT_DTB_EXTRA} into the dtbs= argument.
    # This modifies lines of the form:
    #   make SOC=... REV=... dtbs=<somefile> ${target}
    # and converts them to:
    #   make SOC=... REV=... dtbs="<somefile> ${UBOOT_DTB_EXTRA}" ${target}

    pattern = r'(make\s+SOC=[^\s]+\s+REV=[^\s]+\s+(?:[^\s]+\s+)*dtbs=)([^\s"]+)(\s+\$\{target\})'
    replacement = r'\1"\2 ${UBOOT_DTB_EXTRA}"\3'

    do_compile_mod = re.sub(pattern, replacement, do_compile_orig)
    d.setVar('do_compile', do_compile_mod)

    # bb.warn("Original do_compile:\n%s" % do_compile_orig)
    # bb.warn("Modified do_compile:\n%s" % do_compile_mod)
}

python __anonymous () {
    import re

    compile_mx8m_orig = d.getVar('compile_mx8m') or ""

    #
    # The original line looks like:
    #   ln -sf ${UBOOT_DTB_NAME_EXTRA}  /absolute/path/imx8mm-var-dart-customboard.dtb
    #
    # Capture the absolute path in group #2 (the part after ${UBOOT_DTB_NAME_EXTRA}).
    # Then wrap it with an if-condition:
    #   if [ "${UBOOT_DTB_NAME_EXTRA}" != "${UBOOT_DTB_NAME}" ] ; then
    #       ln -sf ${UBOOT_DTB_NAME_EXTRA} <that path>
    #   fi
    #
    pattern = r'(ln\s+-sf\s+\$\{UBOOT_DTB_NAME_EXTRA\}\s+)(/.*\.dtb)'
    replacement = (
        'if [ "${UBOOT_DTB_NAME_EXTRA}" != "${UBOOT_DTB_NAME}" ] ; then\n'
        '        \\1\\2\n'
        '    fi'
    )

    compile_mx8m_mod = re.sub(pattern, replacement, compile_mx8m_orig)
    d.setVar('compile_mx8m', compile_mx8m_mod)

    # bb.warn("Original compile_mx8m:\n%s" % compile_mx8m_orig)
    # bb.warn("Modified compile_mx8m:\n%s" % compile_mx8m_mod)
}

do_compile:prepend() {
    bbnote "Copying DTBs"
    if [ "mx8m" = "${SOC_FAMILY}" ]; then
        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}

        for UBOOT_DTB_EXTRA_FILE in ${UBOOT_DTB_EXTRA}; do
            cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_EXTRA_FILE} ${BOOT_STAGING}
        done
    fi
}
