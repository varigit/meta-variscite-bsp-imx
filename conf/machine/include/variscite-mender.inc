# inherit mender-full if meta-mender-core is included in bblayers.conf
INHERIT:append = "${@bb.utils.contains('BBLAYERS', 'meta-mender-core', ' mender-full', '', d)}"

# Override default mender features
MENDER_FEATURES_ENABLE:append = " mender-image mender-image-sd mender-uboot mender-update-install mender-systemd"
MENDER_FEATURES_ENABLE:remove = " mender-efi-boot mender-grub mender-image-uefi "

# Configure to fit on 16GB eMMC
MENDER_STORAGE_TOTAL_SIZE_MB ?= "14336"

# Remove the boot partition
IMAGE_BOOT_FILES = ""
MENDER_BOOT_PART_SIZE_MB ?= "0"
MENDER_ROOTFS_PART_A_NUMBER ?= "1"
MENDER_ROOTFS_PART_B_NUMBER ?= "2"

# Mender Demo Server
MENDER_DEMO_HOST_IP_ADDRESS = "192.168.0.155"
MENDER_SERVER_URL = "https://${MENDER_DEMO_HOST_IP_ADDRESS}"
VAR_MENDER_SERVER_SKIP_VERIFY = "1"

# Calculate bootloader offset in 512-byte sectors:
#   IMX_BOOT_SEEK is in KiB
#   sectors = bytes / 512, (IMX_BOOT_SEEK * 1024) / 512 = IMX_BOOT_SEEK * 2
MENDER_IMAGE_BOOTLOADER_BOOTSECTOR_OFFSET ?= "${@ str(int(d.getVar('IMX_BOOT_SEEK', True)) * 2) }"
MENDER_IMAGE_BOOTLOADER_FILE ?= "imx-boot"

# Mender Artifact Name
MENDER_ARTIFACT_NAME = "${MACHINE}-release-1"

MENDER_UBOOT_AUTO_CONFIGURE ?= "0"
MENDER_UBOOT_POST_SETUP_COMMANDS="setenv mmcpart \${mender_boot_part}"
