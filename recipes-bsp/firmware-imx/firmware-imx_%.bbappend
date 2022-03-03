do_install:append() {
	install -d ${D}/boot
	if [ -f ${D}${nonarch_base_libdir}/firmware/imx/hdmi/hdmitxfw.bin ]; then
		mv ${D}${nonarch_base_libdir}/firmware/imx/hdmi/hdmitxfw.bin ${D}/boot
		mv ${D}${nonarch_base_libdir}/firmware/imx/hdmi/hdmirxfw.bin ${D}/boot
		mv ${D}${nonarch_base_libdir}/firmware/imx/hdmi/dpfw.bin ${D}/boot
		rm -rf ${D}${nonarch_base_libdir}/firmware/imx/hdmi
	else
		mv ${D}${nonarch_base_libdir}/firmware/hdmitxfw.bin ${D}/boot
		mv ${D}${nonarch_base_libdir}/firmware/hdmirxfw.bin ${D}/boot
		mv ${D}${nonarch_base_libdir}/firmware/dpfw.bin ${D}/boot
	fi
	install -m 0644 ${S}/firmware/vpu/vpu_fw_imx8_dec.bin ${D}${nonarch_base_libdir}/firmware/vpu
	install -m 0644 ${S}/firmware/vpu/vpu_fw_imx8_enc.bin ${D}${nonarch_base_libdir}/firmware/vpu
}

FILES:${PN}-hdmi += "/boot/"
