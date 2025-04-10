#don't allow to install connman through X11 Sato if we have a different PREFERRED_CONNECTIVITY_MANAGER
RDEPENDS:${PN}-base:remove = "\
    ${@bb.utils.contains_any('PREFERRED_CONNECTIVITY_MANAGER', 'networkmanager systemd-networkd', \
    'connman-gnome', '', d)} \
"
