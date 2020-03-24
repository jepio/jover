# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Open Source ASN.1 Compiler"
HOMEPAGE="http://asn1c.sourceforge.net/"
EGIT_COMMIT="fdb68ce2782423ce38caf84f28441d1b0776e9ee"
SRC_URI="https://github.com/vlm/asn1c/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}-${EGIT_COMMIT}

src_prepare() {
	default
	eautoreconf
}

src_install(){
	emake DESTDIR="${D}" install || die "make install failed"
}
