SRC_URI += "file://bsp.cfg"
SRC_URI_append = " file://0001-ov5640-use-an-old-version.patch "
KERNEL_FEATURES_append = " bsp.cfg"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
