# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
inherit eutils

DESCRIPTION="The C++ IDE for professional developers."
HOMEPAGE="https://www.cevelop.com"
SRC_URI="https://www.cevelop.com/cevelop/downloads/${P}-201501051140-linux.gtk.x86_64.tar.gz"

S="${WORKDIR}/${PN}"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodir /opt/cevelop/
	cp -R "${S}/" "${D}/opt/" || die "Install failed!"
	dosym "/opt/cevelop/cevelop.sh" "/usr/bin/${PN}"
	newicon icon.xpm cevelop.xpm
	make_desktop_entry cevelop Cevelop cevelop Development
}
