require variscite-mirrors.inc
INHERIT += "image-buildinfo"

MACHINE_FEATURES += " pci bluetooth wifi screen"

IMX_DEFAULT_BSP = "nxp"

USE_VT = "0"

KERNEL_IMAGETYPE:mx8-nxp-bsp = "Image.gz"
KERNEL_IMAGETYPE:mx9-nxp-bsp = "Image.gz"

WKS_FILE:mx8-nxp-bsp = "imx-imx-boot-singlepart.wks.in"
WKS_FILE:mx9-nxp-bsp = "imx-imx-boot-singlepart.wks.in"

# Set a more generic tuning for code reuse across parts
DEFAULTTUNE:mx8-nxp-bsp:fslc     ?= "armv8a-crc-crypto"
DEFAULTTUNE:mx8m-nxp-bsp:fslc    ?= "armv8a-crc-crypto"
DEFAULTTUNE:mx8qxp-nxp-bsp:fslc  ?= "armv8a-crc-crypto"
DEFAULTTUNE:mx8x-nxp-bsp:fslc    ?= "armv8a-crc-crypto"

NETMAN_PACKAGES = "\
	networkmanager \
	networkmanager-nmcli \
"

# Wayland distros should default to networkmanager
PREFERRED_CONNECTIVITY_MANAGER	 ?= " \
	${@bb.utils.contains('DISTRO', 'b2qt', '', \
		bb.utils.contains('DISTRO_FEATURES', 'wayland', \
		'networkmanager', '', d), d)} \
"
PREFERRED_CONNECTIVITY_MANAGER_PACKAGES	?= " \
	${@bb.utils.contains('PREFERRED_CONNECTIVITY_MANAGER', 'networkmanager', \
		'${NETMAN_PACKAGES}','', d)} \
"

# Variscite BSP default providers
PREFERRED_RPROVIDER_u-boot-default-env ?= "u-boot-variscite"

# Use i.MX Gstreamer Version for mx6 SoMs
MACHINE_GSTREAMER_1_0_PLUGIN:mx6-nxp-bsp = "imx-gst1.0-plugin"
PREFERRED_VERSION_gstreamer1.0:mx6-nxp-bsp ?= "1.20.3.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-base:mx6-nxp-bsp ?= "1.20.3.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-good:mx6-nxp-bsp ?= "1.20.3.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-bad:mx6-nxp-bsp  ?= "1.20.3.imx"

# Use i.MX Gstreamer Version for mx6ul SoMs
MACHINE_GSTREAMER_1_0_PLUGIN:mx6ul-nxp-bsp = "imx-gst1.0-plugin"
PREFERRED_VERSION_gstreamer1.0:mx6ul-nxp-bsp ?= "1.20.3.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-base:mx6ul-nxp-bsp ?= "1.20.3.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-good:mx6ul-nxp-bsp ?= "1.20.3.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-bad:mx6ul-nxp-bsp  ?= "1.20.3.imx"

# Use i.MX Gstreamer Version for mx7d SoMs
MACHINE_GSTREAMER_1_0_PLUGIN:mx7d-nxp-bsp = "imx-gst1.0-plugin"
PREFERRED_VERSION_gstreamer1.0:mx7d-nxp-bsp ?= "1.20.3.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-base:mx7d-nxp-bsp ?= "1.20.3.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-good:mx7d-nxp-bsp ?= "1.20.3.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-bad:mx7d-nxp-bsp  ?= "1.20.3.imx"

# Use i.MX Gstreamer Version for mx8 SoMs
MACHINE_GSTREAMER_1_0_PLUGIN:mx8-nxp-bsp = "imx-gst1.0-plugin"

# Add VPU and Cortex M4/M7 firmware
MACHINE_FIRMWARE:append:mx8-nxp-bsp = " \
	firmware-imx-vpu-imx8 \
	freertos-variscite \
	"

MACHINE_EXTRA_RDEPENDS += " \
	gptfdisk \
	hostapd \
	hdparm \
	imx-kobs \
	iw \
	kernel-modules \
	kmod \
	${PREFERRED_CONNECTIVITY_MANAGER_PACKAGES} \
	packagegroup-tools-bluetooth \
	bluealsa \
	pm-utils \
	rng-tools \
	wpa-supplicant \
	wireless-regdb-static \
	u-boot-fw-utils \
	u-boot-splash \
	u-boot-default-env \
"

# Packages added to all images (including core-image-minimal)
IMAGE_INSTALL:append:mx8-nxp-bsp = " \
	kernel-image \
	kernel-devicetree \
"

IMAGE_INSTALL:append:mx9-nxp-bsp = " \
	kernel-image \
	kernel-devicetree \
"

IMAGE_FSTYPES = "tar.gz wic.gz"

# Wayland based distros add systemd to DISTRO_FEATURES
# Remove sysvinit or systemd based on DISTRO_FEATURES to avoid conflicts
DISTRO_FEATURES_BACKFILL_CONSIDERED:append = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', ' sysvinit', '', d)}"
DISTRO_FEATURES_BACKFILL_CONSIDERED:append = "${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', ' systemd', '', d)}"

# Use bluez-alsa instead of pulseaudio
DISTRO_FEATURES_BACKFILL_CONSIDERED:append = " pulseaudio"

# Enable virtualization
DISTRO_FEATURES:append:mx8-nxp-bsp = " virtualization"
DISTRO_FEATURES:append:mx9-nxp-bsp = " virtualization"
