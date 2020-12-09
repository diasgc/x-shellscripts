#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='vorbis'
dsc='Ogg Vorbis audio format'
lic='BSD'
src='https://github.com/xiph/vorbis.git'
sty='git'
cfg='ag'
tls=''
dep='ogg'
pkg='vorbis'

eta='42'
lsz=
psz=(1948 0 0 0 2084)
ets=(28 0 0 0 19 0 0 0 0 0 0)
ls0=(1040 0 0 0 1176 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG="--with-pic=1 --disable-docs --disable-examples --disable-oggtest --with-ogg=$LIBSDIR/ogg"
dbld=$SRCDIR
loadToolchain
if test $cfg = 'cm'; then
  cs0="-DBUILD_SHARED_LIBS=OFF"
  cs1="-DBUILD_SHARED_LIBS=ON"
  cb0=
  cb1=
  CSH=$cs0
  CBN=$cb0
  setBuildOpts
  dbld=$SRCDIR/build_${arch}
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake -DOGG_LIBRARY=$LIBSDIR/ogg/lib/libogg.a -DOGG_INCLUDE_DIR=$LIBSDIR/ogg/include"
else
  test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start