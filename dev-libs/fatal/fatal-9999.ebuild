# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-r3

DESCRIPTION="Facebook Template Library."
HOMEPAGE="httsp://github.com/facebook/fatal"
SRC_URI=""
EGIT_REPO_URI="https://github.com/facebook/fatal.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="test? ( dev-cpp/glog
		dev-cpp/gtest
		dev-libs/folly )"
RDEPEND="${DEPEND}"

src_install() {
	dodoc README.md
	dodoc docs/cppcon2014.pdf
	dodoc demo/ytse_jam.cpp
	dodir /usr/include
	cp -R "${S}/fatal/" "${D}/usr/include/" || die "Install failed!"
}
