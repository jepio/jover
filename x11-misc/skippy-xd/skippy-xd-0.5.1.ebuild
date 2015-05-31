# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/skippy/skippy-0.5.0.ebuild,v 1.15 2012/05/05 04:53:46 jdhore Exp $

EAPI=5
inherit eutils toolchain-funcs git-r3

DESCRIPTION="A full-screen task-switcher providing Apple Expose-like functionality with various WMs"
HOMEPAGE="http://code.google.com/p/skippy-xd/"
EGIT_REPO_URI="https://github.com/richardgv/skippy-xd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="media-libs/imlib2[X]
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXmu
	x11-libs/libXft
	media-libs/imlib2
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libXrender
	sys-libs/zlib"
DEPEND="${RDEPEND}
	x11-proto/fixesproto
	x11-proto/damageproto
	x11-proto/compositeproto
	x11-proto/xproto
	x11-proto/xineramaproto
	virtual/pkgconfig"

src_compile() {
	cd "${PN}-master"
	emake || die

}

src_install() {
	cd "${PN}-master"
	emake DESTDIR="${D}" install || die
	dodoc CHANGELOG
}

pkg_postinst() {
	echo
	elog "Settings can be editted in /etc/xdg/${PN}.rc-default"
	elog "Use x11-apps/xev to find out the keysym."
	echo
}
