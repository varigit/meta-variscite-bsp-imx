FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# This BitBake append file is for the i.MX fork of gstreamer1.0-plugins-bad.
# It restores the fullscreen height fix for weston.ini configurations that
# set panel-position=none.

SRC_URI:append = " \
	file://0001-fix-display-fullscreen-vertical-positioning-issue.patch \
"
