FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

replace_pcm() {
    sed -i 's/pcm "hw:0,0"/pcm "hw:wm8904audio"/g' ${D}${sysconfdir}/asound.conf
}

do_install:append:var-som:mx8-nxp-bsp() {
    replace_pcm
}

do_install:append:var-som:mx9-nxp-bsp() {
    replace_pcm
}
