# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools-utils

DESCRIPTION="Folly is an open-source C++ library developed and used at Facebook."
HOMEPAGE="https://github.com/facebook/folly"
SRC_URI="https://github.com/facebook/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-doc"

S="${S}/${PN}/"

DEPEND="dev-cpp/gflags
	dev-cpp/glog
	sys-devel/libtool
	dev-libs/libevent
	dev-libs/boost[context,threads]
	dev-libs/double-conversion
	app-arch/lz4
	app-arch/snappy
	sys-libs/zlib
	dev-libs/openssl:0
	app-arch/xz-utils
	doc? ( app-text/pandoc )"
RDEPEND="${DEPEND}"

src_compile() {
	autotools-utils_src_compile
	if use doc; then
		einfo "Building documentation"
		cd docs
		make all docs.md
	fi
}

src_install() {
	autotools-utils_src_install
	if use doc; then
		einfo "Installing documentation"
		cd docs
		dodoc *.html
		dodoc docs.md
	fi
}
