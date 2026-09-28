EAPI=8

CRATES=""
if [[ ${PV} != 9999 ]]; then
    declare -A GIT_CRATES=(
        [adb_client]='https://github.com/KernelSU2/adb_client;d97a966435bebaa55017834869dec08150826aa7;adb_client-%commit%/adb_client'
        [android-bootimg]='https://github.com/5ec1cff/android_bootimg;150425b027c76ea104c82e408571651f2181b2c2;android_bootimg-%commit%/android-bootimg'
        [java-properties]='https://github.com/KernelSU2/java-properties;42a4aa941b70ded2dd3be9e9f892471023e70229;java-properties-%commit%'
        [kernlog]='https://github.com/kstep/kernlog.rs;68caa7bf1e27baea35b00ebba786cafae0bca90f;kernlog.rs-%commit%'
        [prop-rs-android]='https://github.com/KernelSU2/ksu_props;6f5723105d8d4cacad31d83d343defbf032c7b33;ksu_props-%commit%/crates/prop-rs-android'
        [prop-rs]='https://github.com/KernelSU2/ksu_props;6f5723105d8d4cacad31d83d343defbf032c7b33;ksu_props-%commit%/crates/prop-rs'
        [rustix]='https://github.com/KernelSU2/rustix;4a53fbc7cb7a07cabe87125cc21dbc27db316259;rustix-%commit%'
    )
fi
RUST_MIN_VER="1.91.0"
inherit cargo

DESCRIPTION="KernelSU userspace CLI for non-Android"
HOMEPAGE="https://kernelsu.org/"

if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/tiann/KernelSU"
else
    S="${WORKDIR}/KernelSU-${PV}"
    SRC_URI="
        https://github.com/tiann/KernelSU/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-aarch64-android12-5.10_kernelsu.ko -> lkm-aarch64-android12-5.10_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-aarch64-android13-5.10_kernelsu.ko -> lkm-aarch64-android13-5.10_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-aarch64-android13-5.15_kernelsu.ko -> lkm-aarch64-android13-5.15_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-aarch64-android14-5.15_kernelsu.ko -> lkm-aarch64-android14-5.15_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-aarch64-android14-6.1_kernelsu.ko -> lkm-aarch64-android14-6.1_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-aarch64-android15-6.6_kernelsu.ko -> lkm-aarch64-android15-6.6_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-aarch64-android16-6.12_kernelsu.ko -> lkm-aarch64-android16-6.12_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-aarch64-android17-6.18_kernelsu.ko -> lkm-aarch64-android17-6.18_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-x86_64-android12-5.10_kernelsu.ko -> lkm-x86_64-android12-5.10_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-x86_64-android13-5.10_kernelsu.ko -> lkm-x86_64-android13-5.10_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-x86_64-android13-5.15_kernelsu.ko -> lkm-x86_64-android13-5.15_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-x86_64-android14-5.15_kernelsu.ko -> lkm-x86_64-android14-5.15_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-x86_64-android14-6.1_kernelsu.ko -> lkm-x86_64-android14-6.1_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-x86_64-android15-6.6_kernelsu.ko -> lkm-x86_64-android15-6.6_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-x86_64-android16-6.12_kernelsu.ko -> lkm-x86_64-android16-6.12_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/lkm-x86_64-android17-6.18_kernelsu.ko -> lkm-x86_64-android17-6.18_kernelsu_v${PV}.ko
        https://github.com/tiann/KernelSU/releases/download/v${PV}/ksuinit-x86_64 -> ksuinit-x86_64 
        https://github.com/tiann/KernelSU/releases/download/v${PV}/ksuinit-aarch64 -> ksuinit-aarch64 
        https://github.com/huaji2369/gentoo-deps/releases/download/ksud-3.3.0/ksud-3.3.0-crates.tar.xz 
        ${CARGO_CRATE_URIS}
    "
    KEYWORDS="~amd64 ~arm64"
fi

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+="
    Apache-2.0
    BSD-2
    BSD
    GPL-2
    ISC 
    MIT
    Unicode-3.0
    ZLIB 
    BZIP2
"
SLOT="0"

src_unpack() {
    if [[ ${PV} == 9999 ]]; then
        git-r3_src_unpack
        cargo_live_src_unpack
    else
        cargo_src_unpack
    fi
}

src_prepare() {
    default
    if [[ ${PV} != 9999 ]]; then
        for arch in x86_64 aarch64; do
            install -v -Dm644 "${DISTDIR}/ksuinit-${arch}" "${S}/userspace/ksud/bin/${arch}/ksuinit" 
            for ko in "${DISTDIR}"/lkm-"${arch}"*.ko ;do
                _ko=${ko##*/}
                _ko=${_ko%_v${PV}.ko}
                install -v -Dm644 "$ko" "${S}/userspace/ksud/bin/${arch}/$_ko.ko"
                unset _ko
            done
        done
    fi
}

src_compile() {
    cargo_src_compile --package ksud
}

src_install() {
    dobin "$(cargo_target_dir)/ksud"
}