#!/bin/bash


print_help() {
  echo "Usage: $0 [options]"
  echo "Where options are: "
  echo "-n <ndkdir> for specifying the Android NDK folder"
  echo "-c cleans out previous build attempts"
}

CLEAN=0

while getopts "hcn:" opt ; do
  case "$opt" in
   h)
     print_help
     exit 1
     ;;
   n)
     NDKROOT=$OPTARG
     ;;
   c)
     CLEAN=1
     ;;
  esac
done

if [ -z "$NDKROOT" ]; then
  echo "Please specify NDK root"
  exit 1
fi

if [ ! -e "$NDKROOT/ndk-build" ]; then
  echo "Supplied directory is not an NDK root"
  exit 1
fi

if [ ! -d build/armeabi-v7a ]; then
  mkdir -p build/armeabi-v7a
fi

if [ ! -d build/arm64-v8a ]; then
  mkdir -p build/arm64-v8a
fi

pushd build/armeabi-v7a

if [ "$CLEAN" -eq "1" ]; then
  rm -rf *
else
  if [ -f CMakeCache.txt ]; then
    rm CMakeCache.txt
    rm -rf CMakeFiles
  fi
fi

ANDROID_NDK=$NDKROOT cmake ../.. -DCMAKE_TOOLCHAIN_FILE=../../platforms/android/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_TOOLCHAIN_NAME=arm-linux-androideabi-4.9 -DANDROID_NATIVE_API_LEVEL=19

make -j 16 install

popd

pushd build/arm64-v8a

if [ "$CLEAN" -eq "1" ]; then
  rm -rf *
else
  if [ -f CMakeCache.txt ]; then
    rm CMakeCache.txt
    rm -rf CMakeFiles
  fi
fi

ANDROID_NDK=$NDKROOT cmake ../.. -DCMAKE_TOOLCHAIN_FILE=../../platforms/android/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_TOOLCHAIN_NAME=aarch64-linux-android-4.9 -DANDROID_NATIVE_API_LEVEL=21

make -j 16 install

popd

