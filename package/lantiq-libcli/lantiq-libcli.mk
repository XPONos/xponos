# SPDX-License-Identifier: MPL-2.0-no-copyleft-exception

################################################################################
#
# lantiq-libcli
#
################################################################################

LANTIQ_LIBCLI_VERSION = 2.1.0
LANTIQ_LIBCLI_SOURCE = $(LANTIQ_LIBCLI_VERSION).tar.gz
LANTIQ_LIBCLI_SITE = https://github.com/XPONos/lantiq-libcli/archive/refs/tags
LANTIQ_LIBCLI_INSTALL_STAGING = YES
LANTIQ_LIBCLI_DEPENDENCIES = host-pkgconf lantiq-ifxos
LANTIQ_LIBCLI_AUTORECONF = YES
LANTIQ_LIBCLI_AUTORECONF_OPTS = --install --force
LANTIQ_LIBCLI_CONF_OPTS+=--disable-build-example
LANTIQ_LIBCLI_CONF_OPTS+=--enable-ifxos-include="-I$(STAGING_DIR)/usr/include/ifxos" --enable-ifxos-library=-L"-I$(STAGING_DIR)/usr/lib"

ifeq ($(BR2_PACKAGE_LANTIQ_LIBCLI_CONSOLE),y)
LANTIQ_LIBCLI_CONF_OPTS+=--enable-cli-console
else
LANTIQ_LIBCLI_CONF_OPTS+=--disable-cli-console
endif

ifeq ($(BR2_PACKAGE_LANTIQ_LIBCLI_PIPE),y)
LANTIQ_LIBCLI_CONF_OPTS+=--enable-cli-pipe
LANTIQ_LIBCLI_CONF_OPTS+=--with-max-pipes=$(BR2_PACKAGE_LANTIQ_LIBCLI_PIPE)
else
LANTIQ_LIBCLI_CONF_OPTS+=--disable-cli-pipe
endif

ifeq ($(BR2_PACKAGE_LANTIQ_LIBCLI_BUFFER_OUT),y)
LANTIQ_LIBCLI_CONF_OPTS+=--enable-cli-buffer-pout
else
LANTIQ_LIBCLI_CONF_OPTS+=--disable-cli-buffer-pout
endif

ifeq ($(BR2_PACKAGE_LANTIQ_LIBCLI_FILE_OUT),y)
LANTIQ_LIBCLI_CONF_OPTS+=--enable-cli-file-pout
else
LANTIQ_LIBCLI_CONF_OPTS+=--disable-cli-file-pout
endif

ifeq ($(BR2_PACKAGE_LANTIQ_LIBCLI_ERROR),y)
LANTIQ_LIBCLI_CONF_OPTS+=--enable-error-print
else
LANTIQ_LIBCLI_CONF_OPTS+=--disable-error-print
endif

ifeq ($(BR2_PACKAGE_LANTIQ_LIBCLI_DEBUG),y)
LANTIQ_LIBCLI_CONF_OPTS+=--enable-debug-print
else
LANTIQ_LIBCLI_CONF_OPTS+=--disable-debug-print
endif

define LANTIQ_LIBCLI_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) install -C $(@D)
	rm -r $(TARGET_DIR)/include/cli
	rmdir --ignore-fail-on-non-empty $(TARGET_DIR)/include
endef

$(eval $(autotools-package))
