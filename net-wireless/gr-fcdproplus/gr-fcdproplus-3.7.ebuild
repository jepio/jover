# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils


DESCRIPTION="Gnuradio block for FUNCubeDongle Pro Plus"
HOMEPAGE="https://github.com/dl1ksv/gr-fcdroplus"
SRC_URI="https://github.com/dl1ksv/gr-fcdproplus/archive/with_hidapi.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=net-wireless/gnuradio-3.7
	media-libs/alsa-lib"
#	dev-libs/hidapi"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-with_hidapi"

src_install() {
	cmake-utils_src_install
	
	insinto /lib/udev/rules.d
	doins "${FILESDIR}/55_${PN}.rules"
}
