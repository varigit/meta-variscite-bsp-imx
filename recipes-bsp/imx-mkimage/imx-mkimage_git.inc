DEPENDS = "zlib-native openssl-native"

SRCBRANCH = "imx_5.4.70_2.3.0"
SRCREV = "8947fea369ab3932259630232cfb9f87b8f9dda1"
SRC_URI = "git://source.codeaurora.org/external/imx/imx-mkimage.git;protocol=https;branch=${SRCBRANCH} \
           file://0001-mkimage_fit_atf-fix-fit-generator-node-naming.patch \
"

SRCBRANCH_imx8mp-var-dart = "lf-5.10.y_2.0.0"
SRCREV_imx8mp-var-dart = "5138add7602a50d1730a54d0b67219f0ce0666b4"
SRC_URI_imx8mp-var-dart = " \
           git://source.codeaurora.org/external/imx/imx-mkimage.git;protocol=https;branch=${SRCBRANCH} \
           file://0001-mkimage_fit_atf-fix-fit-generator-node-naming.patch \
"

S = "${WORKDIR}/git"
BOOT_TOOLS = "imx-boot-tools"
SYSROOT_DIRS += "/boot"