FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:var-som = "git://github.com/varigit/imx-atf;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:var-som = "lf_v2.8_var03"
SRCREV:var-som = "3d7a70ae70303e43d1ca57585ea08dd7f33a343d"
