#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libiec61883'
dsc='An isochronous streaming media library for IEEE 1394'
lic='LGPL-2.1'
src='https://github.com/Distrotech/libiec61883.git'
sty='git'
cfg='ar'
tls=''
dep='libraw1394'
pkg='libiec61883'

eta='30'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(223 0 0 0 0 0 0 0 0 0 0)
ls1=(187 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG="--with-pic=1"
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
[[ $arch = *mingw32 ]] && dep=''

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start