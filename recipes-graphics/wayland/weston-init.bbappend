FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN}_append = " adwaita-icon-theme adwaita-icon-theme-cursors"

# [Shell] is already uncommented by default in Variscite's weston.ini
INI_UNCOMMENT_ASSIGNMENTS_remove_mx8mq = " \
    \\[shell\\] \
"

INI_UNCOMMENT_ASSIGNMENTS_append_mx6 = " \
    use-g2d=1 \
"

# same as update_file in meta-imx, but warn instead of error
update_file_weak() {
    if ! grep -q "$1" $3; then
        # Warn if fails
        bbwarn $1 not found in $3
    else
        sed -i -e "s,$1,$2," $3
    fi
}

do_install_append() {
    # meta-imx applies the following changes to weston.service
    # Community based releases (without meta-imx) also need these changes (See https://github.com/varigit/meta-variscite-fslc/commit/8535fb5b6e164476b651a3a5887144b26f9bea16)
    # For compatibiltiy with and without meta-imx, attempt to update weston.service here also and only print a warning when it fails.
    # When using meta-imx, it is normal for update_file_weak to fail

    # Add weston.log back, used by NXP for testing
    update_file_weak "ExecStart=/usr/bin/weston " "ExecStart=/usr/bin/weston --log=\$\{XDG_RUNTIME_DIR\}/weston.log " ${D}${systemd_system_unitdir}/weston.service

    # FIXME: weston should be run as weston, not as root
    update_file_weak "User=weston" "User=root" ${D}${systemd_system_unitdir}/weston.service
    update_file_weak "Group=weston" "Group=root" ${D}${systemd_system_unitdir}/weston.service

    update_file_weak "WatchdogSec=20" "WatchdogSec=${WATCHDOG_SEC}" ${D}${systemd_system_unitdir}/weston.service
}
