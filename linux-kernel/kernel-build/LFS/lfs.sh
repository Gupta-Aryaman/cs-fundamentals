#!/bin/bash

export LFS=/mnt/lfs
export LSF_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sdd

if ! grep -q "$LFS" /proc/mounts; then
    source setupdisk.sh "$LFS_DISK"
    sudo mount "${LFS_DISK}2" "$LFS"
    sudo chown -v $USER "$LFS"
fi

mkdir -pv $LFS/sources
mkdir -pv $LFS/tools

mkdir -pv $LFS/boot
mkdir -pv $LFS/etc
mkdir -pv $LFS/bin
mkdir -pv $LFS/lib
mkdir -pv $LFS/sbin
mkdir -pv $LFS/usr
mkdir -pv $LFS/var

case $(uname -m) in
    x86_64) mkdir -pv $LFS/lib64 ;;
esac


cp -rf *.sh chapter* packages.csv "$LFS/sources"
cd "$LFS/sources"
export PATH="$LFS/tools/bin:$PATH"



source download.sh

source packageinstall.sh 5 binutils
# for package in gcc linux-api-headers glibc libstdc++; do
#     source packageinstall.sh 5 $package
# done
