$(eval $(call PKG_INIT_BIN, dnh3.2))
$(PKG)_SOURCE:=ctorrent-$($(PKG)_VERSION).tar.gz
$(PKG)_SITE:=http://www.rahul.net/dholmes/ctorrent/
$(PKG)_BINARY:=$($(PKG)_DIR)/ctorrent
$(PKG)_TARGET_BINARY:=$($(PKG)_DEST_DIR)/usr/bin/ctorrent

$(PKG)_CONFIGURE_ENV += CXXFLAGS="-Os"
$(PKG)_CONFIGURE_ENV += CXX="mipsel-linux-g++-uc"
$(PKG)_CONFIGURE_OPTIONS += --with-ssl=no


$(PKG_SOURCE_DOWNLOAD)
$(PKG_UNPACKED)
$(PKG_CONFIGURED_CONFIGURE)
		
$($(PKG)_BINARY): $($(PKG)_DIR)/.configured
	PATH="$(TARGET_PATH)" \
		$(MAKE) -C $(CTORRENT_DIR) all

$($(PKG)_TARGET_BINARY): $($(PKG)_BINARY)
	$(INSTALL_BINARY_STRIP)

ctorrent: 

ctorrent-precompiled: uclibc uclibcxx-precompiled ctorrent $($(PKG)_TARGET_BINARY)

ctorrent-clean:
	-$(MAKE) -C $(CTORRENT_DIR) clean

ctorrent-uninstall:
	rm -f $(CTORRENT_TARGET_BINARY)

$(PKG_FINISH)
