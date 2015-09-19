# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit git-r3

DESCRIPTION="Proof of concept library providing an easy to use API for
processes instead of threads."
HOMEPAGE="http://github.com/gby/coproc"
EGIT_REPO_URI="https://github.com/jepio/coproc.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake libs
}

src_install() {
	doheader coproc.h
	dolib libcoproc.so*
	dodoc "docs/good_bad_and_ugly_elce09.odp"
}
