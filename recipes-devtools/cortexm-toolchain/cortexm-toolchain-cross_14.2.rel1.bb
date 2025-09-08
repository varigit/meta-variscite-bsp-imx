require cortexm-toolchain-cross.inc

SRC_URI = " \
    https://developer.arm.com/-/media/Files/downloads/gnu/${PV}/binrel/${TOOLCHAIN_TARBALL};name=cortexm-toolchain;unpack=0 \
"

TOOLCHAIN_TARBALL = "arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz"

SRC_URI[cortexm-toolchain.sha256sum] = "62a63b981fe391a9cbad7ef51b17e49aeaa3e7b0d029b36ca1e9c3b2a9b78823"

do_install() {
    install -d ${D}${bindir}cortexm-toolchain-cross-${PV}
    tar xf ${UNPACKDIR}/${TOOLCHAIN_TARBALL} -C ${D}${bindir}cortexm-toolchain-cross-${PV} --strip-components=1
}
