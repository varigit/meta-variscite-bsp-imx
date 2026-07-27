# Disable automatic module loading and configuration from NXP.
# Variscite uses a custom service to load the moal module
# with the correct configuration file (var_wifi_mod_para.conf)
KERNEL_MODULE_AUTOLOAD:remove = "moal"
KERNEL_MODULE_PROBECONF:remove = "moal"
# Explicitly unset the module configuration variable
module_conf_moal = ""
