require cortexm-toolchain-cross.inc

SRC_URI = " \
    https://developer.arm.com/-/media/Files/downloads/gnu/${PV}/binrel/${TOOLCHAIN_TARBALL};name=cortexm-toolchain;unpack=0 \
"

TOOLCHAIN_TARBALL = "arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz"

SRC_URI[cortexm-toolchain.sha256sum] = "12a2815644318ebcceaf84beabb665d0924b6e79e21048452c5331a56332b309"

do_install() {
    install -d ${D}${bindir}cortexm-toolchain-cross-${PV}
    tar xf ${WORKDIR}/${TOOLCHAIN_TARBALL} -C ${D}${bindir}cortexm-toolchain-cross-${PV} --strip-components=1
}
