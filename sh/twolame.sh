#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='twolame'
dsc='MPEG Audio Layer 2 (MP2) encoder'
lic='LGPL-2.1'
src='https://github.com/njh/twolame.git'
sty='git'
cfg='ac'
tls=''
dep='sndfile'
eta='225'
pkg='twolame'

eta='225'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG="--with-pic=1 --disable-maintainer-mode"
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  pushd $SRCDIR >/dev/null
  doAutoreconf $SRCDIR
		# Exclude doc-dir, or building LibTwoLAME fails.
	doLog 'patch' sed -i.bak "/^SUBDIRS/s/ doc//" $SRCDIR/Makefile.am
	popd >/dev/null
}
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start