# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit git-r3

DESCRIPTION="Microsoft's version of the Guidelines Support Library for the C++ Core Guidelines."
HOMEPAGE="http://github.com/microsoft/gsl"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( README.md )

src_compile() {
	mv include GSL
}

src_install() {
	doheader -r GSL
	default
}
