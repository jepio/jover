# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A profiling tool for OpenMP applications."
HOMEPAGE="http://www.ompp-tool.com"
SRC_URI="http://projekt17.pub.lab.nm.ifi.lmu.de/ompp//downloads/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	# INSTDIR
	sed -i "7s|$|${D}/usr/|" Makefile.defs
	# DOCDIR
	sed -i "19s/doc/share\/doc\/${PF}\//" Makefile.defs
	# TESTDIR
	sed -i "22s|=.*$|=${S}|" Makefile.defs
	# OMPCC
	sed -i "26s/$/gcc/" Makefile.defs
	# OMPFLAG
	sed -i "30s/$/-fopenmp/" Makefile.defs
}
