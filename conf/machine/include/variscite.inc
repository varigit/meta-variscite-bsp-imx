require variscite-mirrors.inc
INHERIT += "image-buildinfo"

# Common override for all Variscite machines
MACHINEOVERRIDES =. "var-som:"

MACHINE_FEATURES += " pci bluetooth wifi screen"

IMX_DEFAULT_BSP = "nxp"

USE_VT = "0"

KERNEL_IMAGETYPE:mx8-nxp-bsp = "Image.gz"
KERNEL_IMAGETYPE:mx9-nxp-bsp = "Image.gz"

WKS_FILE:mx8-nxp-bsp ?= "imx-imx-boot-singlepart.wks.in"
WKS_FILE:mx9-nxp-bsp ?= "imx-imx-boot-singlepart.wks.in"

# Set a more generic tuning for code reuse across parts
DEFAULTTUNE:mx8-nxp-bsp:fslc     ?= "armv8a-crc-crypto"
DEFAULTTUNE:mx8m-nxp-bsp:fslc    ?= "armv8a-crc-crypto"
DEFAULTTUNE:mx8qxp-nxp-bsp:fslc  ?= "armv8a-crc-crypto"
DEFAULTTUNE:mx8x-nxp-bsp:fslc    ?= "armv8a-crc-crypto"

NETMAN_PACKAGES = "\
    networkmanager \
    networkmanager-nmcli \
"

# Yocto distros should default to systemd-networkd
PREFERRED_CONNECTIVITY_MANAGER	 ?= " \
    ${@bb.utils.contains('DISTRO', 'b2qt', '', 'systemd-networkd', d)} \
"
PREFERRED_CONNECTIVITY_MANAGER_PACKAGES	?= " \
    ${@bb.utils.contains('PREFERRED_CONNECTIVITY_MANAGER', 'networkmanager', \
        '${NETMAN_PACKAGES}','', d)} \
"

# Variscite BSP default providers
PREFERRED_PROVIDER_virtual/kernel ?= "linux-variscite"

PREFERRED_PROVIDER_u-boot ?= "u-boot-variscite"
PREFERRED_PROVIDER_virtual/bootloader ?= "u-boot-variscite"
PREFERRED_RPROVIDER_u-boot-default-env ?= "u-boot-variscite"
PREFERRED_PROVIDER_u-boot-fw-utils ?= "u-boot-fw-utils"

# Use i.MX Gstreamer Version
MACHINE_GSTREAMER_1_0_PLUGIN:mx6-nxp-bsp = "imx-gst1.0-plugin"
MACHINE_GSTREAMER_1_0_PLUGIN:mx7-nxp-bsp = "imx-gst1.0-plugin"
MACHINE_GSTREAMER_1_0_PLUGIN:mx8-nxp-bsp = "imx-gst1.0-plugin"

# Add VPU and Cortex M4/M7 firmware
MACHINE_FIRMWARE:append:mx8-nxp-bsp = " \
    firmware-imx-vpu-imx8 \
    freertos-variscite-dbg \
    freertos-variscite-scripts \
"

# Add Cortex-M33 firmware
MACHINE_FIRMWARE:append:imx93-var-som = " \
    freertos-variscite \
    freertos-variscite-scripts \
"

MACHINE_ESSENTIAL_EXTRA_RDEPENDS:mx8-nxp-bsp = " \
    kernel-image \
    kernel-devicetree \
"

MACHINE_ESSENTIAL_EXTRA_RDEPENDS:mx9-nxp-bsp = " \
    kernel-image \
    kernel-devicetree \
"

MACHINE_EXTRA_RDEPENDS += " \
    imx-kobs \
    kernel-modules \
    pm-utils-variscite \
    u-boot-fw-utils \
    u-boot-splash \
    u-boot-default-env \
    ${@bb.utils.contains('MACHINE_FEATURES', 'nxpiw612-sdio', 'iw612-utils', '', d)} \
"

CORE_IMAGE_EXTRA_INSTALL += " \
    packagegroup-tools-bluetooth \
    packagegroup-variscite-devel \
    ${PREFERRED_CONNECTIVITY_MANAGER_PACKAGES} \
"

IMAGE_FSTYPES = "tar.zst wic.zst wic.bmap wic"

# Use bluez-alsa instead of pulseaudio
DISTRO_FEATURES_BACKFILL_CONSIDERED:append = " pulseaudio"

# Enable virtualization
DISTRO_FEATURES:append = " virtualization"
