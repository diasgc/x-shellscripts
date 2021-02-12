#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='tesseract'
dsc='An OCR Engine that was developed at HP Labs between 1985 and 1995... and now at Google'
lic='Apache-2.0'
git='https://github.com/tesseract-ocr/tesseract.git'
vrs=$(curl --silent "https://api.github.com/repos/tesseract-ocr/tesseract/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
src="https://github.com/tesseract-ocr/tesseract/archive/$vrs.tar.gz"
sty='tgz'
cfg='ag'
tls=''
dep='leptonica'
pkg='tesseract'

eta='240'
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
CFG="--with-pic=1 --disable-debug \
    --disable-graphics \
    --disable-tessdata-prefix \
    --disable-largefile"
dbld=$SRCDIR
loadToolchain --posix

if test $cfg = 'cm'; then 
  cs0="-DBUILD_SHARED_LIBS=OFF"
  cs1="-DBUILD_SHARED_LIBS=ON"
  cb0=
  cb1=
  CSH=$cs0
  CBN=$cb1
  setBuildOpts
  dbld=$SRCDIR/build_${arch}
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake -Dpkgcfg_lib_Leptonica_lept=$LIBSDIR/leptonica/lib/pkgconfig/lept.pc"
else
  [ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutogen $SRCDIR
  test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
fi
setPkgConfigDir $PKGDIR libtiff libjpeg

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start