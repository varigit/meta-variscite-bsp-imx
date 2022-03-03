FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += " \
            file://0001-units-add-dependencies-to-avoid-conflict-between-con.patch \
"

# meta-imx already contains this patch
# remove it if it exists, then append it again
SRC_URI:remove = "file://0020-logind.conf-Set-HandlePowerKey-to-ignore.patch"
SRC_URI:append = "file://0020-logind.conf-Set-HandlePowerKey-to-ignore.patch"
