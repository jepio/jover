# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/skippy/skippy-0.5.0.ebuild,v 1.15 2012/05/05 04:53:46 jdhore Exp $

EAPI=5
inherit eutils toolchain-funcs

DESCRIPTION="A full-screen task-switcher providing Apple Expose-like functionality with various WMs"
HOMEPAGE="http://code.google.com/p/skippy-xd/"
SRC_URI="https://github.com/jepio/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="xinerama +png +jpeg +gif"

RDEPEND="
	xinerama? ( x11-libs/libXext x11-libs/libXinerama )
	png? ( sys-libs/zlib media-libs/libpng:0 )
	jpeg? ( virtual/jpeg:0 )
	gif? ( media-libs/giflib[X] )
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXrender
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

MAKE_STRING="SKIPPYXD_VERSION=${PV} PREFIX=${EPREFIX}/usr \
	$(usex xinerama "" CFG_NO_XINERAMA=1) \
	$(usex png "" CFG_NO_PNG=1) \
	$(usex jpeg "" CFG_NO_JPEG=1) \
	$(usex gif "" CFG_NO_GIF=1)"

src_compile() {
	tc-export CC
	emake ${MAKE_STRING}
}

src_install() {
	emake ${MAKE_STRING} DESTDIR="${D}" install
	dodoc CHANGELOG
}

pkg_postinst() {
	elog "Copy the settings file from /etc/xdg/${PN}.rc"
	elog "to ~/.config/skippy-xd/skippy-xd.rc."
	elog "Use x11-apps/xev to find out the keysym."
}
