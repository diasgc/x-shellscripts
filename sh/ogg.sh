#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='ogg'
dsc='Ogg media container'
lic='BSD'
src='https://github.com/xiph/ogg.git'
sty='git'
cfg='ag'
tls=''
dep=''
eta='187'
pkg='ogg'

eta='40'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0="--disable-extra-programs"
cb1="--enable-extra-programs"
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
dbld=$SRCDIR
loadToolchain
CFG="--with-pic=1"
if test $cfg = 'cm'; then
  cs0="-DBUILD_SHARED_LIBS=OFF"
  cs1="-DBUILD_SHARED_LIBS=ON"
  cb0=
  cb1=
  CSH=$cs0
  CBN=$cb0
  setBuildOpts
  dbld=$SRCDIR/build_${arch}
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake -DBUILD_TESTING=OFF -DINSTALL_DOCS=OFF"
else
  [ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutogen $SRCDIR
  test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start