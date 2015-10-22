# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit toolchain-funcs eutils

DESCRIPTION="Topal is a 'glue' program that links GnuPG and Pine/Alpine"
HOMEPAGE="http://homepage.ntlworld.com/phil.brooke/topal/"
SRC_URI="http://homepage.ntlworld.com/phil.brooke/topal/rel-${PV}/topal-package-${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=app-crypt/gnupg-2.0.7-r1
	|| ( net-mail/metamail app-misc/run-mailcap )
	|| ( app-text/dos2unix app-text/hd2u )
	sys-libs/ncurses
	sys-libs/readline
	mail-filter/procmail"

# Requires virtual/ada:2005 but currently this defaults to gnat-gcc:4.6 which
# doesn't build. The first alternative is gnat-gpl-4.1 which also doesn't
# build. Hence explicitly depend on gnat-gcc versions that are _not_ known to
# break. The only one I tried is gnat-gcc-4.5.
DEPEND="${RDEPEND}
	>=dev-lang/gnat-gcc-4.3
	<=dev-lang/gnat-gcc-4.6
	doc? (  app-text/texlive
		dev-tex/bera )"

src_prepare() {
	rm "${S}"/MIME-tool/mime-tool || die
	# This patch overrides all flag settings and forces gnat2005 compilation
	# mode instead of upstreams gnat2012 mode. Fortunately it compiles fine,
	# let's see if there are any adverse consequences.
	epatch "${FILESDIR}/${PV}-Makefile.patch"
	use doc || sed -i -e '/pdflatex/s/^/#/' Makefile
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake install \
		INSTALLPATH="${D}"/usr \
		INSTALLPATHDOC="${D}/usr/share/doc/${PF}"
	dohtml "${S}"/*.html
	if use doc; then
		dodoc topal.pdf
	fi
}

pkg_postinst() {
	einfo "The Topal patches to alpine are deprecated and have not been update"
	einfo "for alpine-2.20."
	einfo "Check the documentation at"
	einfo
	einfo "\thttp://homepage.ntlworld.com/phil.brooke/topal/rel-76/topal.pdf"
	einfo
	einfo "for information on what the recommended setup is."
}
