# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Simple PKCS11 provider for TPM chips"
HOMEPAGE="https://github.com/ThomasHabets/simple-tpm-pk11"

LICENSE="Apache-2.0"
SLOT="0"
if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/ThomasHabets/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	HASH=3302ccd74365da1e409d910d7e0239e19bd969bb
	SRC_URI="https://github.com/ThomasHabets/${PN}/archive/${HASH}.zip -> ${P}.zip"
	KEYWORDS="~amd64"
fi

IUSE="libressl"
RESTRICT="test" # needs to communicate with the TPM and gtest is all broken

DEPEND="app-crypt/tpm-tools[pkcs11]
	dev-libs/opencryptoki[tpm]
	app-crypt/trousers
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
RDEPEND="${DEPEND}
	net-misc/openssh[-X509]"

S="${WORKDIR}/${PN}-${HASH}"

src_prepare() {
	eapply_user
	eautoreconf
}

src_configure() {
	econf --disable-static
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
