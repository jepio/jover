# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="4"
EGIT_REPO_URI="git://github.com/geany/geany"
inherit gnome2-utils git-2 autotools

DESCRIPTION="GTK+ based fast and lightweight IDE"
HOMEPAGE="http://www.geany.org"
SRC_URI=""

LICENSE="GPL-2 HPND"
SLOT="0"
KEYWORDS=""
IUSE="+vte"

COMMON_DEPEND="
	>=x11-libs/gtk+-2.12:2
	>=dev-libs/glib-2.16:2
	"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	"
RDEPEND="${COMMON_DEPEND}
	vte? ( x11-libs/vte:0 )
	"

WANT_AUTOMAKE="1.11"

src_prepare() {
	# Syntax highlighting for Portage
	sed -i -e "s:*.sh;:*.sh;*.ebuild;*.eclass;:" \
		data/filetype_extensions.conf || die

	# LINGUAS hack
	pushd po &>/dev/null
	for l in $LINGUAS; do
		test -f ${l}.po || LINGUAS=${LINGUAS/$l/}
	done
	popd &>/dev/null
	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable vte)
}

src_install() {
	emake DESTDIR="${D}" DOCDIR="${ED}/usr/share/doc/${PF}" install || die
	find "${ED}" -name '*.la' -exec rm -f '{}' + || die
	rm -f "${ED}"/usr/share/doc/${PF}/{COPYING,GPL-2,ScintillaLicense.txt}
}
