# Support additional firmware for bc43xx and wl18xx WIFI+BT modules

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRCREV_FORMAT = "linux-firmware"
IW612_FIRMWARE_SRC = "git://github.com/varigit/imx-firmware.git;protocol=https"
SRCREV_iw612-firmware = "f899d18fe944fb15ce07ba466cf60c11d05ec1cb"
SRCBRANCH = "lf-6.1.22_2.0.0-var01"

BRCM_REV = "10.54.0.13"
SRC_URI[brcm_lwb.sha256sum] = "8faa105e036a9f8bffe2857f5d9f5ce539521ef8624b59069290579440228ac5"
SRC_URI[brcm_lwb5.sha256sum] = "583e2b328a185f545e1c5de55acaf3ae092cdbc791a62ff005c5559515488f7f"

# TI WiFi FW 8.9.0.0.88 and BT FW 4.7
SRCREV_tiwlan = "d5c271f60bb2d90b7c2b03ce792d01af2f0a8e44"
BRANCH_tiwlan = "master"
SRCREV_tibt = "3aa1d75f3c2ae77f6e4d36194e3d281b899ab149"
BRANCH_tibt = "master"

MODEL_LIST = "${MACHINE}"
MODEL_LIST:imx6ul-var-dart = "imx6ul-var-dart imx6ul-var-som"
MODEL_LIST:imx8mm-var-dart = "imx8mm-var-dart imx8mm-var-som"
MODEL_LIST:imx8mn-var-som = "imx8mn-var-som"
MODEL_LIST:imx8mp-var-dart = "imx8mp-var-dart imx8mp-var-som"
MODEL_LIST:imx8qm-var-som = "imx8qm-var-som imx8qm-var-spear imx8qp-var-som imx8qp-var-spear"

SRC_URI:append = " \
	${IW612_FIRMWARE_SRC};branch=${SRCBRANCH};destsuffix=iw612-firmware;name=iw612-firmware \
	https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/download/LRD-REL-${BRCM_REV}/laird-lwb-fcc-firmware-${BRCM_REV}.tar.bz2;name=brcm_lwb \
	https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/download/LRD-REL-${BRCM_REV}/laird-lwb5-fcc-firmware-${BRCM_REV}.tar.bz2;name=brcm_lwb5 \
	git://git.ti.com/cgit/wilink8-wlan/wl18xx_fw;protocol=https;branch=${BRANCH_tiwlan};destsuffix=tiwlan;name=tiwlan \
	git://git.ti.com/cgit/ti-bt/service-packs;protocol=https;branch=${BRANCH_tibt};destsuffix=tibt;name=tibt \
	file://wl1271-nvs.bin \
"

do_install:append() {
	install -d ${D}${nonarch_base_libdir}/firmware/bcm
	install -m 0755 ${WORKDIR}/lib/firmware/brcm/* ${D}${nonarch_base_libdir}/firmware/brcm/
	install -m 0755 ${WORKDIR}/tibt/initscripts/TIInit_*.bts ${D}${nonarch_base_libdir}/firmware/ti-connectivity
	install -m 0755 ${WORKDIR}/tiwlan/*.bin ${D}${nonarch_base_libdir}/firmware/ti-connectivity
	install -m 0755 ${WORKDIR}/wl1271-nvs.bin ${D}${nonarch_base_libdir}/firmware/ti-connectivity

	# Install NXP Connectivity IW612 firmware
	install -d ${D}${nonarch_base_libdir}/firmware/nxp
	install -m 0644 ${WORKDIR}/iw612-firmware/nxp/FwImage_IW612_SD/sduart_nw61x_v1.bin.se ${D}${nonarch_base_libdir}/firmware/nxp
	install -m 0644 ${WORKDIR}/iw612-firmware/nxp/FwImage_IW612_SD/sd_w61x_v1.bin.se      ${D}${nonarch_base_libdir}/firmware/nxp
	install -m 0644 ${WORKDIR}/iw612-firmware/nxp/FwImage_IW612_SD/uartspi_n61x_v1.bin.se ${D}${nonarch_base_libdir}/firmware/nxp
	for f in ${WORKDIR}/iw612-firmware/nxp/FwImage_IW612_SD/IW612_SD_RFTest/*; do
		install -D -m 0644 $f ${D}${nonarch_base_libdir}/firmware/nxp/IW612_SD_RFTest/$(basename $f)
	done

	for model in ${MODEL_LIST}; do
		# Add model symbolic links to brcmfmac4339
		ln -sf brcmfmac4339-sdio.txt \
			${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac4339-sdio.variscite,${model}.txt
		ln -sf brcmfmac4339-sdio.bin \
			${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac4339-sdio.variscite,${model}.bin

		# Add model symbolic links to brcmfmac43430
		ln -sf brcmfmac43430-sdio.txt \
			${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.variscite,${model}.txt
		ln -sf brcmfmac43430-sdio.bin \
			${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.variscite,${model}.bin
	done
}

PACKAGES =+ " \
  ${PN}-nxp-common \
  ${PN}-nxpiw612-sdio \
"

FILES:${PN}-bcm4339 += " \
  ${nonarch_base_libdir}/firmware/brcm/BCM4335C0.hcd \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac4339-sdio* \
"

FILES:${PN}-bcm43430 += " \
  ${nonarch_base_libdir}/firmware/brcm/BCM43430A1.hcd \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio* \
"

FILES:${PN}-nxpiw612-sdio = " \
  ${nonarch_base_libdir}/firmware/nxp/sduart_nw61x_v1.bin.se \
  ${nonarch_base_libdir}/firmware/nxp/sd_w61x_v1.bin.se \
  ${nonarch_base_libdir}/firmware/nxp/uartspi_n61x_v1.bin.se \
  ${nonarch_base_libdir}/firmware/nxp/IW612_SD_RFTest/ \
"
RDEPENDS_${PN}-nxpiw612-sdio += "${PN}-nxp-common"

FILES:${PN}-nxp-common = " \
  ${nonarch_base_libdir}/firmware/nxp/wifi_mod_para.conf \
"
