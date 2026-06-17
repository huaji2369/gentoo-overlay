EAPI=8

inherit cmake

DESCRIPTION="Reverse engineered implementation of Tetris the Absolute: The Grand Master 2 Plus"
HOMEPAGE="https://github.com/burbruee/the-absolute-reference"

SRC_URI="https://github.com/burbruee/the-absolute-reference/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    media-libs/libsdl2
    dev-games/physfs
"
DEPEND="${RDEPEND}"

src_configure() {
    local mycmakeargs=(
        -DCMAKE_C_STANDARD=99
        -DCMAKE_BUILD_TYPE=Release
    )
    cmake_src_configure
}

src_install() {
    dobin "${BUILD_DIR}/Source/Platform/SDL2/taref"
}

pkg_postinst() {
    elog "Until free assets are created, both of TAP's MAME ROM sets (tgm2 and tgm2p)"
    elog "are required."
    elog "Run the game from command line, and it will tell you the directories where"
    elog "files need to go. In the event some ROMs are missing in tgm2.zip or tgm2p.zip,"
    elog "it will tell you which are missing."
}
