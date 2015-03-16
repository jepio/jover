# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils

DESCRIPTION="cmocka is an elegant unit testing framework for C with support \
for mock objects"

HOMEPAGE="https://cmocka.org"
SRC_URI="https://cmocka.org/files/1.0/cmocka-1.0.1.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-util/cmake"
RDEPEND=""
