#!/bin/bash

## Create temp dir
if (test -x ~/ffmpeg_sources); then
    mkdir ~/ffmpeg_sources
fi

## libx265
echo "Start event: -build libx265-"
sleep 3
cd ~/ffmpeg_sources
hg clone https://bitbucket.org/multicoreware/x265
cd ~/ffmpeg_sources/x265/build/linux
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
make
make install
make distclean
echo "End event: -build libx265-"
sleep 3

## libfdk-aac
echo "Start event: -build libfdk-aac-"
sleep 3
cd ~/ffmpeg_sources
wget -O fdk-aac.tar.gz https://github.com/mstorsjo/fdk-aac/tarball/master
tar xzvf fdk-aac.tar.gz
cd mstorsjo-fdk-aac*
autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
make distclean
echo "End event: -build libfdk-aac-"
sleep 3

## libvpx
echo "Start event: -build libvpx-"
sleep 3
cd ~/ffmpeg_sources
wget http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.5.0.tar.bz2
tar xjvf libvpx-1.5.0.tar.bz2
cd libvpx-1.5.0
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --disable-examples --disable-unit-tests
PATH="$HOME/bin:$PATH" make
make install
make clean
echo "End event: -build libvpx-"
sleep 3

## ffmpeg
echo "Start event: -build ffmpeg-"
sleep 3
cd ~/ffmpeg_sources
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --pkg-config-flags="--static" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --bindir="$HOME/bin" --enable-gpl --enable-libass --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 --enable-nonfree
PATH="$HOME/bin:$PATH" make
make install
make distclean
hash -r
echo "End event: -build ffmpeg-"
sleep 3
