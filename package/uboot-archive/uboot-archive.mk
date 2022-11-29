# SPDX-License-Identifier: MPL-2.0-no-copyleft-exception

################################################################################
#
# uboot-archive
#
################################################################################

define UBOOT_ARCHIVE_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(UBOOT_ARCHIVE_PKGDIR)/uboot-archive.sh \
                $(TARGET_DIR)/usr/bin/uboot-archive
endef

$(eval $(generic-package))
