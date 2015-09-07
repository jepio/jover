# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit git-r3 cmake-utils

DESCRIPTION="Gnuradio block for FUNCubeDongle Pro Plus"
HOMEPAGE="https://github.com/dl1ksv/gr-fcdproplus"
EGIT_REPO_URI="https://github.com/dl1ksv/gr-fcdproplus.git"
SRC_URI="https://github.com/dl1ksv/gr-fcdproplus/archive/with_hidapi.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="system-hidapi"

DEPEND=">=net-wireless/gnuradio-3.7
	media-libs/alsa-lib
	system-hidapi?	( dev-libs/hidapi )"
RDEPEND="${DEPEND}"

src_install() {
	cmake-utils_src_install
	insinto /lib/udev/rules.d
	doins "${FILESDIR}/55_${PN}.rules"
}
