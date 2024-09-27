# Support additional firmware for bc43xx and wl18xx WIFI+BT modules

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRCREV_FORMAT = "linux-firmware"

BRCM_REV = "12.29.0.22"
SRC_URI[brcm_lwb.sha256sum] = "7a1340f70a1682798d437c6f6502af1ab6cff4bcb464f79c5d288a634da1356d"
SRC_URI[brcm_lwb5.sha256sum] = "a8c843b01971883942d7d2cef4473b95d7e70864fe5cccba3e1e23ed0b45acf3"

# TI WiFi FW 8.9.0.0.88 and BT FW 4.7
SRCREV_tiwlan = "bda5304cc86e9c4029f8101394d2a8b39c640f53"
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
	https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/download/LRD-REL-${BRCM_REV}/summit-lwb-fcc-firmware-${BRCM_REV}.tar.bz2;name=brcm_lwb \
	https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/download/LRD-REL-${BRCM_REV}/summit-lwb5-fcc-firmware-${BRCM_REV}.tar.bz2;name=brcm_lwb5 \
	git://git.ti.com/git/wilink8-wlan/wl18xx_fw.git;protocol=https;branch=${BRANCH_tiwlan};destsuffix=tiwlan;name=tiwlan \
	git://git.ti.com/git/ti-bt/service-packs.git;protocol=https;branch=${BRANCH_tibt};destsuffix=tibt;name=tibt \
	file://wl1271-nvs.bin \
"
do_install:append() {
	install -d ${D}${nonarch_base_libdir}/firmware/bcm
	install -m 0755 ${WORKDIR}/lib/firmware/brcm/* ${D}${nonarch_base_libdir}/firmware/brcm/
	install -m 0755 ${WORKDIR}/tibt/initscripts/TIInit_*.bts ${D}${nonarch_base_libdir}/firmware/ti-connectivity
	install -m 0755 ${WORKDIR}/tiwlan/*.bin ${D}${nonarch_base_libdir}/firmware/ti-connectivity
	install -m 0755 ${WORKDIR}/wl1271-nvs.bin ${D}${nonarch_base_libdir}/firmware/ti-connectivity

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

FILES:${PN}-bcm4339 += " \
  ${nonarch_base_libdir}/firmware/brcm/BCM4335C0.hcd \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac4339-sdio* \
"

FILES:${PN}-bcm43430 += " \
  ${nonarch_base_libdir}/firmware/brcm/BCM43430A1.hcd \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio* \
"

