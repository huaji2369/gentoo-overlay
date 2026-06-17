EAPI=8

S=${WORKDIR}

FONT_SUFFIX="ttf"
FONT_S="${DISTDIR}"
inherit font

DESCRIPTION="Pixel-style font for coding"
HOMEPAGE="https://github.com/MrZ626/codePixel"
SRC_URI="https://github.com/MrZ626/codePixel/releases/download/v${PV}/codePixel-Regular.ttf"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ~riscv x86"
