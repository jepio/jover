# Copyright (C) 2013-2014 Jonathan Vasquez <fearedbliss@funtoo.org>
# Copyright (C) 2014 Sandy McArthur <Sandy@McArthur.org>
# Copyright (C) 2015 Scott Alfter <scott@alfter.us>
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils user
NAME="${PN}"
DESCRIPTION="Magic folder style file syncing powered by BitTorrent."
HOMEPAGE="http://www.getsync.com/"
SRC_URI="
	amd64?	( https://download-cdn.getsync.com/${PV}/linux-x64/BitTorrent-Sync_x64.tar.gz -> ${NAME}_x64-${PV}.tar.gz )
	x86?	( https://download-cdn.getsync.com/${PV}/linux-i386/BitTorrent-Sync_i386.tar.gz -> ${NAME}_i386-${PV}.tar.gz )
	arm?	( https://download-cdn.getsync.com/${PV}/linux-arm/BitTorrent-Sync_arm.tar.gz -> ${NAME}_arm-${PV}.tar.gz )"

RESTRICT="mirror strip"
LICENSE="BitTorrent"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

QA_PREBUILT="opt/btsync/btsync"

S="${WORKDIR}"

pkg_setup() {
	enewgroup btsync
	enewuser btsync -1 -1 -1 "btsync" --system
}

src_install() {
	einfo dodir "/opt/${NAME}"
	dodir "/opt/${NAME}"
	exeinto "/opt/${NAME}"
	doexe btsync
	insinto "/opt/${NAME}"
	doins LICENSE.TXT

	newinitd "${FILESDIR}/${P/-/_}_initd" "${PN}"
	newconfd "${FILESDIR}/${P/-/_}_confd" "${PN}"

	einfo dodir "/etc/${NAME}"
	dodir "/etc/${NAME}"
	"${D}/opt/btsync/btsync" --dump-sample-config > "${D}/etc/${NAME}/config"
	sed -i 's|// "pid_file"|   "pid_file"|' "${D}/etc/${NAME}/config"
	fowners btsync "/etc/${NAME}/config"
	fperms 460 "/etc/${NAME}/config"
}

pkg_preinst() {
	# Customize for local machine
	# Set device name to `hostname`
	sed -i "s/My Sync Device/$(hostname) Gentoo Linux/"  "${D}/etc/btsync/config"
	# Update defaults to the btsync's home dir
	sed -i "s|/home/user|$(egethome btsync)|"  "${D}/etc/btsync/config"
}

pkg_postinst() {
	elog "Init scripts launch btsync daemon as btsync:btsync "
	elog "Please review/tweak /etc/${NAME}/config for default configuration."
	elog "Default web-gui URL is http://localhost:8888/ ."
}
