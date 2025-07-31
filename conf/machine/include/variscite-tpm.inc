# Include packagegroup-security-tpm2
# This package is used to include common utilities needed for a TPM2.0.

CORE_IMAGE_EXTRA_INSTALL += "packagegroup-security-tpm2"

MACHINE_FEATURES:append = " tpm2"
