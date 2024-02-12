# This BitBake append file is for the i.MX fork of gstreamer1.0-plugins-bad,
# adds the fixes for fullscreen display vertical positioning issue when panel-position
# set to none in weston.ini file.

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:append = " \
	file://0001-fix-display-fullscreen-vertical-positioning-issue.patch \
"
