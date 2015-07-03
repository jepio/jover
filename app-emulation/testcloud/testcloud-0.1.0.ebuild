# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 user

DESCRIPTION="testcloud is a small helper script to download and boot cloud images locally."
HOMEPAGE="http://github.com/Rorosha/testcloud"
SRC_URI="https://github.com/Rorosha/${PN}/archive/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="app-emulation/libvirt
	dev-python/libvirt-python[${PYTHON_USEDEP}]
	app-emulation/libguestfs[ocaml]
	app-emulation/libguestfs-appliance
	app-emulation/virt-manager
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
    doc? ( dev-python/sphinx )"
RDEPEND="${DEPEND}"

DOCS=( README.rst ssh_config )

pkg_setup() {
	python-single-r1_pkg_setup
	enewgroup "testcloud"
	enewuser "testcloud" -1 -1 -1 "testcloud"
}

pkg_postinst() {
	einfo "Requires running libvirtd service"
	einfo "To use as non-root add your user to the testcloud group"
}

src_install() {
	distutils-r1_src_install
	if use doc ; then
		sed -e '8,$ s/C/c/' -i "docs/source/api.rst"
		sed -e '107,$d' -i "docs/source/index.rst"
		make -C docs man
		doman "docs/build/man/testcloud.1"
	fi
	local var_path=/var/lib/testcloud
	# Prepare directories
	diropts -o testcloud -g testcloud -m 775
	dodir "${var_path}"
	dodir "${var_path}/instances"
	dodir "${var_path}/cache"
	insinto /etc/polkit-1/rules.d
	doins "${FILESDIR}/80-libvirt.rules"
	dosym "/bin/false" "/usr/bin/selinuxenabled"
}
