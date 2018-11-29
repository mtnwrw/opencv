#!/bin/bash

SRC32=../build/armeabi-v7a/install
SRC64=../build/arm64-v8a/install

if [ ! -d android_sdk ]; then
  mkdir android_sdk
fi

pushd android_sdk

rm -rf *

install -d -m 755 sdk/etc
install -d -m 755 sdk/native/jni/include
install -d -m 755 sdk/native/libs/arm64-v8a
install -d -m 755 sdk/native/libs/armeabi-v7a
install -d -m 755 sdk/native/3rdparty/libs/arm64-v8a
install -d -m 755 sdk/native/3rdparty/libs/armeabi-v7a

cp -r $SRC64/sdk/etc/* sdk/etc/
cp -r $SRC64/sdk/native/jni/include sdk/native/jni/
cp -r $SRC64/sdk/native/staticlibs/arm64-v8a/* sdk/native/libs/arm64-v8a/
cp -r $SRC64/sdk/native/3rdparty/libs/arm64-v8a/* sdk/native/3rdparty/libs/arm64-v8a
cp $SRC64/sdk/native/jni/OpenCV.mk sdk/native/jni/
cp $SRC64/sdk/native/jni/OpenCV-arm64-v8a.mk sdk/native/jni/

cp -r $SRC32/sdk/native/staticlibs/armeabi-v7a/* sdk/native/libs/armeabi-v7a/
cp -r $SRC32/sdk/native/3rdparty/libs/armeabi-v7a/* sdk/native/3rdparty/libs/armeabi-v7a
cp $SRC32/sdk/native/jni/OpenCV-armeabi-v7a.mk sdk/native/jni/


popd
