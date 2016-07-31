# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit toolchain-funcs

DESCRIPTION="A fast, enterprise-ready, distributed SCM."
HOMEPAGE="https://www.bitkeeper.org"
SRC_URI="https://github.com/bitkeeper-scm/bitkeeper/archive/bk-${PV}ce.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	app-arch/lz4
	dev-util/gperf
	dev-lang/tk
	dev-libs/libpcre
	dev-libs/libtomcrypt
	dev-libs/libtommath
	sys-apps/groff
	sys-devel/bison
	sys-devel/flex
	sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-bk-${PV}ce"

src_compile() {
	cd "${S}/src"
	tc-export CC RANLIB
	export BK_NO_AUTOCLONE=1
	emake V=1 G= INSTALLED_BK= BINDIR="${EPREFIX}/usr/libexec/bitkeeper" p
}

src_install() {
	cd "${S}/src"
	tc-export CC RANLIB
	emake V=1 INSTALLED_BK= BINDIR="${EPREFIX}/usr/libexec/bitkeeper" \
		DESTDIR="${D}" install
	dosym "/usr/libexec/bitkeeper/bk" "/usr/bin/bk"
}
