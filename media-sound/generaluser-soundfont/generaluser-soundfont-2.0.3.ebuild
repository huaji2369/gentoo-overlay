EAPI=9
S=${DISTDIR}

DESCRIPTION="The GeneralUser GS soundfont"
HOMEPAGE="https://www.schristiancollins.com/generaluser"
SRC_URI="
    https://raw.githubusercontent.com/mrbumpy409/GeneralUser-GS/97049183643d5fc5a9322a69c5b09efb667c6c3aGeneralUser-GS.sf2
"
LICENSE="GeneralUser-GS-V2"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~ppc ~ppc64 x86"

src_install() {
    insinto /usr/share/sounds/sf2
    doins GeneralUser-GS.sf2
}

