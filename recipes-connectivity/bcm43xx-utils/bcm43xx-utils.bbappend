FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Required by VAR-SOM-MX93 bcm43xx-wifi script
RDEPENDS:${PN}:append:mx9-nxp-bsp = " bc"
