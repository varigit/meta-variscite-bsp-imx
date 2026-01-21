# Update NXP Wi-Fi kernel module to lf-6.12.20_2.0.0
SRC_URI = "${MRVL_SRC};branch=${SRCBRANCH}"
SRCBRANCH = "lf-6.12.20_2.0.0"
SRCREV = "7a8beaa1605cb0870dc7ba3312c76df91cb0d6cf"

# Disable automatic module loading and configuration from NXP.
# Variscite uses a custom service to load the moal module
# with the correct configuration file (var_wifi_mod_para.conf)
KERNEL_MODULE_AUTOLOAD:remove = "moal"
KERNEL_MODULE_PROBECONF:remove = "moal"
# Explicitly unset the module configuration variable
module_conf_moal = ""
