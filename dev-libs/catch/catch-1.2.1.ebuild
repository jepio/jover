# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A modern, C++ native, header-only, framework for unit-tests, TDD
and BDD."
HOMEPAGE="https://github.com/philsquared/Catch"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P^}"

src_install() {
	insinto /usr/include/
	doins single_include/catch.hpp
	insinto /usr/include/catch
	doins -r include/*
	dodoc README.md
	if use doc ; then
		dodoc docs/*.md
	fi
}
