# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

: ${CMAKE_MAKEFILE_GENERATOR:=ninja}

inherit cmake-utils multilib-minimal

DESCRIPTION="An OpenMP runtime library for use with the LLVM project's clang compiler"
HOMEPAGE="http://openmp.llvm.org"
SRC_URI="http://llvm.org/releases/${PV}/openmp-${PV}.src.tar.xz"

LICENSE="UoI-NCSA"
SLOT="0/3.7"
KEYWORDS="~amd64 ~x86 ~arm ~arm64 ~ppc ~ppc64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/openmp-${PV}.src"

src_prepare() {
	# this perl script looks into /etc/lsb-release, and if it finds atleast one
	# variable matching DISTRIB_* it expects to find them all. Force it to go
	# to the fallback solution straight away.
	sed -e '234s/( .* )/( 0 )/' -i runtime/tools/lib/Uname.pm || die "Failed to patch Uname.pm"
}

multilib_src_configure() {
	local libdir="$(get_libdir)"
	local lib_suffix="${libdir#lib}"
	local mycmakeargs=( "-DLIBOMP_LIBDIR_SUFFIX=${lib_suffix}" )
	cmake-utils_src_configure
}

multilib_src_compile() {
	cmake-utils_src_compile
}

multilib_src_install() {
	cmake-utils_src_install
}

pkg_preinst() {
	cd "${D}"
	# By default symlinks are installed to libomp. Unlink them
	# would interfere with gcc's openmp
	find . -name "*gomp*" -type l -exec unlink {} \; || die "Failed to unlink libgomp"
	# would interfere with icc's openmp
	find . -name "*iomp5*" -type l -exec unlink {} \; || die "Failed to unlink libiomp5"
}
