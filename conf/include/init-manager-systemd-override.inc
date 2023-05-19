# Set systemd as init manager
# This specifically introduces an override "broken_initmanager"
# which corrects effects from Langdale's inability to override
# distro poky.conf INIT_MANAGER = "sysvinit" default
# see conf/distro/include/init-manager-*.inc

DISTRO_FEATURES:append:broken_initmanager = " systemd"
DISTRO_FEATURES_BACKFILL_CONSIDERED:append:broken_initmanager = " sysvinit"
VIRTUAL-RUNTIME_init_manager:broken_initmanager = "systemd"
VIRTUAL-RUNTIME_initscripts:broken_initmanager = "systemd-compat-units"
VIRTUAL-RUNTIME_login_manager:broken_initmanager = "shadow-base"
VIRTUAL-RUNTIME_dev_manager:broken_initmanager = "systemd"

DISTRO_FEATURES_BACKFILL_CONSIDERED:remove:broken_initmanager = "systemd"
DISTRO_FEATURES:remove:broken_initmanager = "sysvinit"
