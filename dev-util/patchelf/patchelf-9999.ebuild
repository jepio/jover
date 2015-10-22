# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils git-r3

DESCRIPTION="Small utility to modify the dynamic linker and RPATH of ELF executables"
HOMEPAGE="http://nixos.org/patchelf.html"
EGIT_REPO_URI="https://github.com/NixOS/patchelf.git"
SRC_URI=""

SLOT="0"
KEYWORDS=""
LICENSE="GPL-3"
IUSE=""

AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	rm src/elf.h || die
	sed -e 's:-Werror::g' -i configure.ac || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=( --docdir="${EPREFIX}"/usr/share/doc/${PF} )
	autotools-utils_src_configure
}

src_test() {
	autotools-utils_src_test -j1
}
