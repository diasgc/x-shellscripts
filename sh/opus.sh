#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='opus'
dsc='Opus is a codec for interactive speech and audio transmission over the Internet'
lic='BSD'
src='https://github.com/xiph/opus.git'
sty='git'
cfg='ag'
tls=''
dep='ogg'
pkg='opus'

eta='208'
lsz=
psz=(2840)
ets=(64 0 0 0 0 0 0 0 0 0 0)
ls0=(2660 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0="--disable-extra-programs"
cb1="--enable-extra-programs"
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG="--with-pic=1"
dbld=$SRCDIR
loadToolchain

if test $cfg = 'cm'; then
  cs0="-DBUILD_SHARED_LIBS=OFF"
  cs1="-DBUILD_SHARED_LIBS=ON"
  cb0=
  cb1=
  CSH=$cs0
  CBN=$cb1
  setBuildOpts
  dbld=$SRCDIR/build_${arch}
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"
else
  [ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutogen $SRCDIR
  test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start