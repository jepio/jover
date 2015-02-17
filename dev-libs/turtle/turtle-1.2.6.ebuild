# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A C++ mock object library for Boost."
HOMEPAGE="http://turtle.sourceforge.net"
SRC_URI="http://downloads.sourceforge.net/project/turtle/turtle/1.2.6/turtle-1.2.6.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="dev-libs/boost:0"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir -p "${S}"
	cd "${S}"
	unpack ${A}
}

src_install() {
	if use doc; then
		dodoc -r doc/*
	fi
	dodir /usr/
	cp -R "${S}/include/" "${D}/usr/" || die "Install failed"
}
