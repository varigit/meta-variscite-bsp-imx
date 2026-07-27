require cortexm-toolchain-cross.inc

SRC_URI = " \
    https://developer.arm.com/-/media/Files/downloads/gnu/${PV}/binrel/${TOOLCHAIN_TARBALL};name=cortexm-toolchain;subdir=${TOOLCHAIN_DIR};striplevel=1 \
"

TOOLCHAIN_TARBALL = "arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz"

SRC_URI[cortexm-toolchain.sha256sum] = "12a2815644318ebcceaf84beabb665d0924b6e79e21048452c5331a56332b309"
