# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Thrust is a parallel algorithms library which resembles the C++
Standard Template Library (STL)"
HOMEPAGE="https://thrust.github.com"
SRC_URI="https://github.com/thrust/thrust/archive/${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="examples doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

DOC_DIR="targets/doc"

src_compile() {
	if use doc ; then
		cd "${S}"
		mkdir -p "${DOC_DIR}"
		doxygen doc/thrust.dox || die "Doc generation failed."
	fi
	rm -f examples/SConscript
}

src_install() {
	insinto /usr/include
	doins -r thrust
	dodoc CHANGELOG README.md THANKS
	if use examples; then
		dodoc -r examples
	fi
	if use doc; then
		dodoc -r "${DOC_DIR}/html"
	fi
}
