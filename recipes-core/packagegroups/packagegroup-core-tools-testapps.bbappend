CONNMAN_PACKAGES = "\
    connman-tools \
    connman-tests \
    connman-client \
    "

RDEPENDS:${PN}:remove = "\
    ${@bb.utils.contains_any('PREFERRED_CONNECTIVITY_MANAGER', 'networkmanager systemd-networkd', \
        '${CONNMAN_PACKAGES}', '', d)} \
    "
