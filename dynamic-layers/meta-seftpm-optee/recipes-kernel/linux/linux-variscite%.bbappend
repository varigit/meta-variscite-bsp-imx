FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
        file://tcg-ftpm-tee-fragment.cfg \
        file://add-ftpm-to-device-tree.patch \
"

DELTA_KERNEL_DEFCONFIG:append = " tcg-ftpm-tee-fragment.cfg"
