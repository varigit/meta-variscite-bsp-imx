require cortexm-toolchain-cross.inc

SRC_URI = " \
    https://developer.arm.com/-/media/Files/downloads/gnu/${PV}/binrel/${TOOLCHAIN_TARBALL};name=cortexm-toolchain;unpack=0 \
"

TOOLCHAIN_TARBALL = "arm-gnu-toolchain-12.2.rel1-x86_64-arm-none-eabi.tar.xz"

SRC_URI[cortexm-toolchain.sha256sum] = "84be93d0f9e96a15addd490b6e237f588c641c8afdf90e7610a628007fc96867"

do_install() {
    install -d ${D}${bindir}cortexm-toolchain-cross-${PV}
    tar xf ${WORKDIR}/${TOOLCHAIN_TARBALL} -C ${D}${bindir}cortexm-toolchain-cross-${PV} --strip-components=1
}
