#!/bin/bash
#

set -e

export BINUTILS_VER=2.34
export GCC_VER=10.10
export GMP_VER=6.2.0
export MPFR_VER=4.0.2
export MPC_VER=1.1.0
export ISL_VER=0.22.1
export NEWLIB_VER=3.3.0

export BARCH="$1"
export OUT="$2"
export TOPDIR="$PWD"
export SRC="$OUT/src"
export TOOLS="$OUT/tools"
export SYSROOT="$OUT/sysroot"
export JOBS="$(expr $(nproc) + 1)"

[ -z "$BARCH" ] && exit 1
[ -z "$OUT" ] && exit 1

case $BARCH in
	aarch64) export TARGET="aarch64-unknown-wasp" ;;
	ppc64) export TARGET="powerpc64-unknown-wasp" ;;
	x86_64) export TARGET="x86_64-unknown-wasp" ;;
	*) exit 1 ;;
esac

rm -rf "$OUT"
mkdir -p "$SRC" "$TOOLS" "$SYSROOT"

export PATH="$TOOLS/bin:$PATH"

cd "$SRC"
echo "Downloading and unpacking binutils $BINUTILS_VER"
curl -C - -L -O http://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VER.tar.xz
bsdtar -xvf binutils-$BINUTILS_VER.tar.xz
cd binutils-$BINUTILS_VER
patch -Np1 -i "$TOPDIR"/binutils-add-support-for-waspOS.patch
mkdir build
cd build
../configure \
	--prefix="$TOOLS" \
	--target=$TARGET \
	--with-sysroot="$SYSROOT" \
	--with-pic \
	--with-system-zlib \
	--enable-64-bit-bfd \
	--enable-gold \
	--enable-ld=default \
	--enable-lto \
	--enable-plugins \
	--enable-relro \
	--enable-tls \
	--disable-multilib \
	--disable-nls \
	--disable-shared \
	--disable-werror
make -j$JOBS MAKEINFO="true" configure-host
make -j$JOBS MAKEINFO="true"
make -j$JOBS MAKEINFO="true" install
