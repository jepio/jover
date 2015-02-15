# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils


DESCRIPTION="A dynamic mathematics software for algebra, geometry, graphing and\
statistics."
HOMEPAGE="http://www.geogebra.org/cms/en"

MY_P="GeoGebra-Linux-Portable-${PV}"
S="${WORKDIR}/${MY_P}"
MAJ_V="5.0"
NAME="${PN}-${MAJ_V}"

SRC_URI="http://download.geogebra.org/installers/${MAJ_V}/${MY_P}.tar.bz2"

#LICENSE="geogebra"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/jre"
RDEPEND="${DEPEND}"

src_configure(){
:
}

src_compile(){
	echo $'#!/usr/bin/env bash\njava -jar /opt/geogebra/geogebra.jar &>/dev/null' > "${NAME}"
}

src_install(){
	dodir /opt/geogebra/
	cp -R "${S}/geogebra/" "${D}/opt/" || die "Install failed!"
	doicon -s 16 "${S}/geogebra.png"
	LOC="/usr/local"
	into "${LOC}"
	dobin "${S}/${NAME}"
	dosym "${LOC}/bin/${NAME}" "${LOC}/bin/${PN}"
}
