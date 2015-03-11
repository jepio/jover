# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit autotools eutils

DESCRIPTION="Folly is an open-source C++ library developed and used at Facebook."
HOMEPAGE="https://github.com/facebook/folly"
SRC_URI="https://github.com/facebook/${PN}/archive/v${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${S}/${PN}/"

DEPEND="dev-cpp/gflags
	dev-cpp/glog
	sys-devel/libtool
	dev-libs/libevent
	dev-libs/boost
	dev-libs/double-conversion
	app-arch/lz4
	app-arch/snappy
	sys-libs/zlib
	dev-libs/openssl
	app-arch/xz-utils"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/offsetof_clang.patch"
	epatch "${FILESDIR}/async_max_long_long_long.patch"
	eautoreconf
}
