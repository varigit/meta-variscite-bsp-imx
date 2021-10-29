FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += " \
            file://0001-units-add-dependencies-to-avoid-conflict-between-con.patch \
"

# meta-imx already contains this patch
# remove it if it exists, then append it again
SRC_URI_remove = "file://0020-logind.conf-Set-HandlePowerKey-to-ignore.patch"
SRC_URI_append = "file://0020-logind.conf-Set-HandlePowerKey-to-ignore.patch"
