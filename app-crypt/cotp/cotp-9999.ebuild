EAPI=8

CRATES=""
RUST_MIN_VER="1.88.0"

inherit cargo

DESCRIPTION="Trustworthy, encrypted, command-line TOTP/HOTP authenticator app with import functionality"
HOMEPAGE="https://github.com/replydev/cotp"

if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/replydev/cotp.git"
else
    SRC_URI="
        https://github.com/replydev/cotp/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
        ${CARGO_CRATE_URIS}
    "
    KEYWORDS="~amd64"
fi
LICENSE="GPL-3+"
SLOT="0"
#IUSE=""
RDEPEND="
    x11-libs/libxcb
    x11-libs/libxkbcommon
"
DEPEND="${RDEPEND}"
#BDEPEND=""

pkg_setup() {
    rust_pkg_setup
}

src_unpack() {
    if [[ ${PV} == 9999 ]]; then
        git-r3_src_unpack
        cargo_live_src_unpack
    else
        cargo_src_unpack
    fi
}

src_prepare() {
    sed -i \
        -e 's/git = "[^ ]*"/version = "*"/' \
        -e '/rev =/d' \
        Cargo.toml || die
    default
}

src_configure() {
    cargo_src_configure --no-default-features
}

src_compile() {
    cargo_src_compile
}

src_test() {
    cargo_src_test
}

src_install() {
    cargo_src_install
}
