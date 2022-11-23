################################################################################
#
# mdev-static
#
################################################################################

define MDEV_STATIC_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(MDEV_STATIC_PKGDIR)/S10mdev \
		$(TARGET_DIR)/etc/init.d/S10mdev
endef

$(eval $(generic-package))
