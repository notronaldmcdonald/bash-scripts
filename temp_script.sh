#!/bin/bash
apt-get install build-essential autoconf2.13 xorg-dev xserver-xorg-dev xutils-dev libtool debhelper
dpkg --add-architecture i386
apt-get update
apt-get install lib32z1 lib32ncurses5 lib32bz2-1.0 libc6-i386 lib32tinfo5 libc6-i386
dpkg -i xf86-input-nextwindow_0.3.4~precise1_amd64.deb
dpkg -i nwfermi-0.6.5.0_amd64.deb
