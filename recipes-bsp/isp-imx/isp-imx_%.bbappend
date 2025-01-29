do_install:append() {
    # Use sed to uncomment RestartPreventExitStatus=6
    sed -i 's|^#RestartPreventExitStatus=6|RestartPreventExitStatus=6|' \
        ${D}${systemd_system_unitdir}/imx8-isp.service
}
