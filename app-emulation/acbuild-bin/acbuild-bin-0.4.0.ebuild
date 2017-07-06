# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MYP="${PN%-bin}-v${PV}"

DESCRIPTION="A build tool for ACIs"
HOMEPAGE="https://github.com/containers/build"
SRC_URI="https://github.com/containers/build/releases/download/v0.4.0/${MYP}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MYP}"

src_install() {
	dobin acbuild
	dobin acbuild-chroot
	dobin acbuild-script
}
