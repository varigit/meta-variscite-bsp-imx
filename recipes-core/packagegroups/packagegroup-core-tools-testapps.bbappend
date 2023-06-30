CONNMAN_PACKAGES = "\
    connman-tools \
    connman-tests \
    connman-client \
    "

RDEPENDS:${PN}:remove = "\
    ${@bb.utils.contains('PREFERRED_CONNECTIVITY_MANAGER', 'networkmanager', \
        '${CONNMAN_PACKAGES}', '', d)} \
    "
