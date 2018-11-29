#!/bin/bash

NDKROOT=/opt/android-ndk-r15c

if [ ! -d build/armeabi-v7a ]; then
  mkdir -p build/armeabi-v7a
fi

if [ ! -d build/arm64-v8a ]; then
  mkdir -p build/arm64-v8a
fi

pushd build/armeabi-v7a

if [ -f CMakeCache.txt ]; then
  rm CMakeCache.txt
  rm -rf CMakeFiles
fi

ANDROID_NDK=$NDKROOT cmake ../.. -DCMAKE_TOOLCHAIN_FILE=../../platforms/android/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_TOOLCHAIN_NAME=arm-linux-androideabi-4.9 -DANDROID_NATIVE_API_LEVEL=19

make -j 16 install

popd

pushd build/arm64-v8a

if [ -f CMakeCache.txt ]; then
  rm CMakeCache.txt
  rm -rf CMakeFiles
fi

ANDROID_NDK=$NDKROOT cmake ../.. -DCMAKE_TOOLCHAIN_FILE=../../platforms/android/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_TOOLCHAIN_NAME=aarch64-linux-android-4.9 -DANDROID_NATIVE_API_LEVEL=21

make -j 16 install

popd

