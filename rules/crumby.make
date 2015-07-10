# -*-makefile-*-
#
# Copyright (C) 2015 by icke2063
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CRUMBY) += crumby

#
# Paths and names
#
CRUMBY_VERSION	:= master
CRUMBY		:= crumby-$(CRUMBY_VERSION)
CRUMBY_URL		:= file://$(PTXDIST_WORKSPACE)/local_src/crumby
CRUMBY_DIR		:= $(BUILDDIR)/$(CRUMBY)
CRUMBY_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#$(CRUMBY_SOURCE):
#	@$(call targetinfo)
#	@$(call get, CRUMBY)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#CRUMBY_CONF_ENV	:= $(CROSS_ENV)

#
# cmake
#
CRUMBY_CONF_TOOL	:= cmake
#CRUMBY_CONF_OPT	:= $(CROSS_CMAKE_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/crumby.targetinstall:
	@$(call targetinfo)

	@$(call install_init, crumby)
	@$(call install_fixup, crumby, PRIORITY, optional)
	@$(call install_fixup, crumby, SECTION, base)
	@$(call install_fixup, crumby, AUTHOR, "icke2063")
	@$(call install_fixup, crumby, DESCRIPTION, missing)

#	#
#	# example code:; copy all binaries
#	#

	@for i in $(shell cd $(CRUMBY_PKGDIR) && find bin sbin usr/bin usr/sbin -type f); do \
		$(call install_copy, crumby, 0, 0, 0755, -, /$$i); \
	done

#	#
#	# FIXME: add all necessary things here
#	#

	echo $(CRUMBY_PKGDIR)


	@$(call install_lib, crumby, 0, 0, 0644, libcommon_cpp-shared)




### systemd startup
	@$(call install_alternative, crumby, 0, 0, 0644, /lib/systemd/system/crumby.service)
	@$(call install_link, crumby, ../crumby.service, /lib/systemd/system/multi-user.target.wants/crumby.service)

###


	@$(call install_finish, crumby)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/crumby.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, CRUMBY)

# vim: syntax=make
