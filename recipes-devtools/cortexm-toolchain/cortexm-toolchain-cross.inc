DESCRIPTION = "ARM GCC toolchain for non Linux M4, M7 and M33 targets"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9"
SECTION = "BSP"

# We do not need to build anything
INHIBIT_DEFAULT_DEPS = "1"

# These are needed for compatibility with cross package naming conventions
PN = "cortexm-toolchain-cross-${TUNE_PKGARCH}"
PROVIDES = "cortexm-toolchain-cross"

inherit cross

# Override those in cross as the target is not Linux/A-core but M core
# i.MX 93 is a Cortex-M33 which is armv8 while others (M4/M7) are arm7e-m
TUNE_PKGARCH:mx8-nxp-bsp = "armv7e-m"
TUNE_PKGARCH:mx9-nxp-bsp = "armv8-m"

TARGET_ARCH = "arm32"
TOOLCHAIN_DIR = "cortexm-toolchain-cross-${PV}"

SRC_URI ?= " \
    https://developer.arm.com/-/media/Files/downloads/gnu-rm/${PV}/${TOOLCHAIN_TARBALL};name=cortexm-toolchain;subdir=${TOOLCHAIN_DIR};striplevel=1 \
"

S = "${UNPACKDIR}/${TOOLCHAIN_DIR}"

do_install() {
    # Keep the prebuilt toolchain under cross.bbclass's target-specific bindir.
    install -d ${D}${bindir}/${TOOLCHAIN_DIR}
    cp -a ${S}/. ${D}${bindir}/${TOOLCHAIN_DIR}/
}

# This toolchain is not built but packaged from
# a tarball that has been stripped already
INSANE_SKIP:${PN} = "already-stripped"
