# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

GTEST_PV="1.7.0"

DESCRIPTION="A general purpose GPU library."
HOMEPAGE="http://www.arrayfire.com/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
test? ( https://googletest.googlecode.com/files/gtest-${GTEST_PV}.zip )"
KEYWORDS="~amd64"

LICENSE="BSD"
SLOT="0"
IUSE="+examples +cpu cuda opencl test forge"

REQUIRED_USE="examples? ( cuda opencl )"
RDEPEND="
	>=sys-devel/gcc-4.7:*
	cuda? (
		>=dev-util/nvidia-cuda-toolkit-6.0
		dev-libs/boost
	)
	cpu? (
		virtual/blas
		virtual/cblas
		sci-libs/fftw:3.0
		virtual/lapacke
	)
	opencl? (
		dev-libs/boost
		dev-libs/boost-compute
		sci-libs/clblas
		sci-libs/clfft
		virtual/lapacke
	)
	forge? ( sci-libs/forge )
	"
DEPEND="${RDEPEND}"

BUILD_DIR="${S}/build"
CMAKE_BUILD_TYPE=Release

PATCHES=(
	"${FILESDIR}"/${P}-FindCBLAS.patch
	"${FILESDIR}"/${P}-FindLAPACKE.patch
	"${FILESDIR}"/${P}-FindClFFT.patch
)

# We need write acccess /dev/nvidiactl, /dev/nvidia0 and /dev/nvidia-uvm and the portage
# user is (usually) not in the video group
RESTRICT="userpriv"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		if [[ $(gcc-major-version) -lt 4 ]] || ( [[ $(gcc-major-version) -eq 4 && $(gcc-minor-version) -lt 7 ]] ) ; then
			die "Compilation with gcc older than 4.7 is not supported."
		fi
	fi
}

src_unpack() {
	default

	if use test; then
		mkdir -p "${BUILD_DIR}"/third_party/src/ || die
		cd "${BUILD_DIR}"/third_party/src/ || die
		unpack ${A}
		mv "${BUILD_DIR}"/third_party/src/gtest-"${GTEST_PV}" "${BUILD_DIR}"/third_party/src/googletest || die
	fi
}

src_configure() {
	if use cuda; then
		addwrite /dev/nvidiactl
		addwrite /dev/nvidia0
		addwrite /dev/nvidia-uvm
	fi

	local mycmakeargs=(
	   $(cmake-utils_use_build cpu CPU)
	   $(cmake-utils_use_build cuda CUDA)
	   $(cmake-utils_use_build opencl OPENCL)
	   $(cmake-utils_use_build examples EXAMPLES)
	   $(cmake-utils_use_build test TEST)
	   $(cmake-utils_use_build forge GRAPHICS)
	   $(cmake-utils_use_use opencl SYSTEM_BOOST_COMPUTE)
	   $(cmake-utils_use_use opencl SYSTEM_CLBLAS)
	   $(cmake-utils_use_use opencl SYSTEM_CLFFT)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	dobin "${BUILD_DIR}/bin2cpp"
}
