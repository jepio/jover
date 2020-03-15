# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Open Source ASN.1 Compiler"
HOMEPAGE="http://asn1c.sourceforge.net/"
SRC_URI="http://lionet.info/soft/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

PATCHES=(
	"${FILESDIR}/0001-Makefile.am-follow-standard-convention-for-doc-insta.patch"
)

src_prepare() {
	default
	eautoreconf
}

src_install(){
	emake DESTDIR="${D}" install || die "make install failed"
}
