# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools

DESCRIPTION="top for UNIX systems"
HOMEPAGE="http://unixtop.sourceforge.net/"
SRC_URI="mirror://sourceforge/unixtop/top-${PV/_/}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}"

S=${WORKDIR}/top-${PV/_/}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-ncurses.patch
	epatch "${FILESDIR}"/${P}-no-AX-macros.patch
	epatch "${FILESDIR}"/${P}-renice-segfault.patch
	epatch "${FILESDIR}"/${P}-memleak-fix-v2.patch
	epatch "${FILESDIR}"/${P}-high-threadid-crash.patch
	epatch "${FILESDIR}"/${P}-percent-cpu.patch
	epatch "${FILESDIR}"/${P}-page-shift.patch
	eautoreconf
}

src_configure() {
	local myconf=
	# don't do bi-arch cruft on hosts that support that, such as Solaris
	export enable_dualarch=no
	# configure demands an override because on OSX this is "experimental"
	[[ ${CHOST} == *-darwin* ]] && myconf="${myconf} --with-module=macosx"
	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README FAQ Y2K
	rename_top_to_utop
}

rename_top_to_utop() {
	cd "${D}"
	einfo "Renaming files to avoid collisions with sys-process/procps"
	( find . -name "top*" | while read file; do mv "$file" "$(dirname $file)/u$(basename $file)"; done )|| die "Failed to rename top files"
}
