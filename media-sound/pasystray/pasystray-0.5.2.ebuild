# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pasystray/pasystray-0.2.1.ebuild,v 1.2 2014/10/12 17:28:06 pacho Exp $

EAPI=5
inherit gnome2-utils autotools

DESCRIPTION="A system tray for pulseaudio controls (replacement for the deprecated padevchooser)"
HOMEPAGE="http://github.com/christophgysin/pasystray"
SRC_URI="https://github.com/christophgysin/${PN}/archive/${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+libnotify zeroconf +X +gtk -gtk2"
REQUIRED_USE="gtk2? ( gtk )"

RDEPEND="
	>=media-sound/pulseaudio-5.0-r3[glib,zeroconf?]
	media-sound/paprefs
	media-sound/pavucontrol
	zeroconf? ( >=net-dns/avahi-0.6 )
	gtk? (
		gtk2? ( x11-libs/gtk+:2 )
		!gtk2? ( x11-libs/gtk+:3 )
	)
	X? ( x11-libs/libX11 )
	libnotify? ( >=x11-libs/libnotify-0.7 )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS README.md TODO"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable libnotify notify) \
		$(use_enable X x11) \
		$(use_enable zeroconf avahi) \
		$(use_with gtk gtk $(usex gtk2 2 3))
}

pkg_preinst() {	gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
