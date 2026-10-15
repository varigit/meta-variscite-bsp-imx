DEPENDS += "patchelf-native"
RDEPENDS:${PN} += "jsoncpp"

do_install:append() {
    # The prebuilt ISP components were linked against jsoncpp 1.9.5
    # (SONAME 25). jsoncpp 1.9.7 ships SONAME 27, so update the dynamic
    # dependency.
    patchelf --replace-needed libjsoncpp.so.25 libjsoncpp.so.27 \
        ${D}${libdir}/libmedia_server.so \
        ${D}/opt/imx8-isp/bin/isp_media_server \
        ${D}/opt/imx8-isp/bin/tuningext

    # Use sed to uncomment RestartPreventExitStatus=6
    sed -i 's|^#RestartPreventExitStatus=6|RestartPreventExitStatus=6|' \
        ${D}${systemd_system_unitdir}/imx8-isp.service
}
