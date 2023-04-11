# SPDX-License-Identifier: MPL-2.0-no-copyleft-exception

################################################################################
#
# lantiq-ifxos
#
################################################################################

LANTIQ_IFXOS_VERSION = 1.7.1
LANTIQ_IFXOS_SOURCE = $(LANTIQ_IFXOS_VERSION).tar.gz
LANTIQ_IFXOS_SITE = https://github.com/XPONos/lantiq-ifxos/archive/refs/tags
LANTIQ_IFXOS_INSTALL_STAGING = YES
LANTIQ_IFXOS_DEPENDENCIES = host-pkgconf
LANTIQ_IFXOS_AUTORECONF = YES
LANTIQ_IFXOS_AUTORECONF_OPTS = --install --force
LANTIQ_IFXOS_CONF_OPTS+=--without-kernel-module

ifeq ($(BR2_PACKAGE_LANTIQ_IFXOS_SHARED_LIB),y)
LANTIQ_IFXOS_CONF_OPTS+=--enable-shared --enable-static
else
LANTIQ_IFXOS_CONF_OPTS+=--disable-shared --enable-static
endif

define LANTIQ_IFXOS_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(STAGING_DIR) install -C $(@D)
	cp -r $(@D)/src/include $(STAGING_DIR)/usr/include/ifxos
endef

$(eval $(autotools-package))
