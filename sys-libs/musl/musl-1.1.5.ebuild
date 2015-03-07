# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit flag-o-matic

DESCRIPTION="Lightweight, fast and simple C library focused on
standards-conformance and safety"
HOMEPAGE="http://www.musl-libc.org/"
SRC_URI="http://www.musl-libc.org/releases/${P}.tar.gz"

EGIT_REPO_URI="git://git.musl-libc.org/musl"


LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

MUSLPATH="/usr/local/musl"
CONF_FLAGS="--enable-shared --enable-gcc-wrapper"

pkg_setup() {
	filter-flags -O2 -O3
	append-flags -Os
}

src_configure() {
	econf --prefix=${MUSLPATH} --libdir="${MUSLPATH}/lib" ${CONF_FLAGS} || die "configure failed"
}

src_compile() {
	emake || die "Make failed"
}

src_install() {
	emake DESTDIR="${D}" install
	dodir "/usr/bin"
	dosym "../..${MUSLPATH}/bin/musl-gcc" "/usr/bin/musl-gcc"
	dodoc README
}
