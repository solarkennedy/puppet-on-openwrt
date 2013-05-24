#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=puppet
PKG_VERSION:=3.2.1
PKG_RELEASE:=1

PKG_SOURCE:=${PKG_NAME}-${PKG_VERSION}.tar.gz
PKG_SOURCE_URL:=http://downloads.puppetlabs.com/puppet/
PKG_MD5SUM:=a9bce4fe7a68aebcb6e97256e7faac5b

include $(INCLUDE_DIR)/package.mk

define Package/puppet
  SECTION:=admin
  CATEGORY:=Administration
  DEPENDS:= +libruby +ruby-core +ruby-enc +facter +ruby-yaml +ruby-gems +ruby-cgi +ruby-openssl +shadow-useradd +ruby-xmlrpc \
            +shadow-useradd +shadow-userdel +shadow-usermod +shadow-groups +shadow-groupmod +shadow-groupdel +shadow-groupadd +shadow-chage +net-tools-hostname

  TITLE:=Centralized configuration management
  URL:=http://projects.puppetlabs.com/projects/puppet
endef

define Package/puppet/description
 Puppet lets you centrally manage every important aspect of your system
 using a cross-platform specification language that manages all the
 separate elements normally aggregated in different files, like users,
 cron jobs, and hosts, along with obviously discrete elements like
 packages, services, and files.

 Puppet's simple declarative specification language provides powerful
 classing abilities for drawing out the similarities between hosts while
 allowing them to be as specific as necessary, and it handles dependency
 and prerequisite relationships between objects clearly and explicitly.
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/puppet/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/$(PKG_NAME) $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/lib/ruby/1.9/puppet
	$(CP) $(PKG_BUILD_DIR)/lib/* $(1)/usr/lib/ruby/1.9/

	$(INSTALL_DIR) $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/puppet
	$(INSTALL_DATA) ./files/puppet.conf $(1)/etc/puppet/puppet.conf
	$(INSTALL_BIN) ./files/etckeeper-commit-post $(1)/etc/puppet/etckeeper-commit-post
	$(INSTALL_BIN) ./files/etckeeper-commit-pre  $(1)/etc/puppet/etckeeper-commit-pre
	$(INSTALL_DIR) $(1)/etc/puppet/manifests
	$(INSTALL_DIR) $(1)/etc/puppet/modules
	$(INSTALL_DIR) $(1)/etc/puppet/templates
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/puppet.init $(1)/etc/init.d/puppet

endef

define Package/puppet/postinst
#!/bin/sh
grep -q '^puppet:' /etc/passwd && exit 0
group=$$(grep '^puppet:' /etc/group | cut -f3 -d:)
if [ -z "$${group}" ] ; then
        group=1000
        tst=$$(cat /etc/group | grep ":$${group}:")
        while [ -n "$${tst}" ] ; do
                group=$$(($${group}+1))
                tst=$$(cat /etc/group | grep ":$${group}:")
        done
        echo "puppet:x:$${group}:" >>/etc/group
fi

user=$$(cat /etc/passwd | grep "^puppet:")
if [ -z "$${user}" ] ; then
        num="$${group}"
        tst=$$(cat /etc/passwd | grep ":.*:$${num}:")
        while [ -n "$${tst}" ] ; do
                num=$$(($${num}+1))
                tst=$$(cat /etc/passwd | grep ":.*:$${num}:")
        done
        echo "puppet:*:$${num}:$${group}:Puppet configuration management daemon:/var/lib/puppet:/bin/ash" >>/etc/passwd
fi
endef

define Package/puppet/conffiles
/etc/puppet/
endef

$(eval $(call BuildPackage,puppet))
