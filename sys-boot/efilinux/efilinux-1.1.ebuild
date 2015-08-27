# Copyright 1999-2015 Jeremi Piotrowski <jeremi.piotrowski@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs

DESCRIPTION="A UEFI bootloader."
HOMEPAGE="https://github.com/mfleming/efilinux"
SRC_URI="https://www.kernel.org/pub/linux/utils/boot/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-boot/gnu-efi"
RDEPEND="${DEPEND}"

DOCS=( README example.cfg )

src_compile() {
	tc-export CC
	default
}

src_install() {
	insinto /usr/share/"${PN}"
	doins efilinux.efi
	dodoc ${DOCS[@]}
}
