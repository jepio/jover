# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
inherit eutils

DESCRIPTION="The C++ IDE for professional developers."
HOMEPAGE="https://www.cevelop.com"
DATE=201507061451
URI="${HOMEPAGE}/${PN}/downloads/"
COMMON_FILENAME="${P}-${DATE}-linux.gtk"
SRC_URI="amd64? ( ${URI}${COMMON_FILENAME}.x86_64.tar.gz )
	x86? ( ${URI}${COMMON_FILENAME}.x86.tar.gz )"

S="${WORKDIR}/${PN}"
LICENSE="Cevelop"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please download the file corresponding to your arch"
	einfo "  - ${COMMON_FILENAME}.x86_64.tar.gz"
	einfo "  - ${COMMON_FILENAME}.x86.tar.gz"
	einfo "from ${URI} and place it"
	einfo "in ${DISTDIR}"
}

src_install() {
	dodir /opt/cevelop/
	cp -R "${S}/" "${D}/opt/" || die "Install failed!"
	dosym "/opt/cevelop/cevelop.sh" "/usr/bin/${PN}"
	newicon icon.xpm cevelop.xpm
	make_desktop_entry cevelop Cevelop cevelop Development
}
