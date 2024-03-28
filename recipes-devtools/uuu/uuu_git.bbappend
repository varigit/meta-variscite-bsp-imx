FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRCREV = "1f42172b171200e2b6bdb7120b8ce7ae5bcf8aa1"
PV = "1.5.21"
SRC_URI += "file://0001-include-missing-stdint.h.patch"

DEPENDS:append = " zstd"

COMPATIBLE_MACHINE:remove = "(imx-generic-bsp)"
