require cortexm-toolchain-cross.inc

SRC_URI = " \
    https://developer.arm.com/-/media/Files/downloads/gnu/${PV}/binrel/${TOOLCHAIN_TARBALL};name=cortexm-toolchain;subdir=${TOOLCHAIN_DIR};striplevel=1 \
"

TOOLCHAIN_TARBALL = "arm-gnu-toolchain-12.2.rel1-x86_64-arm-none-eabi.tar.xz"

SRC_URI[cortexm-toolchain.sha256sum] = "84be93d0f9e96a15addd490b6e237f588c641c8afdf90e7610a628007fc96867"
