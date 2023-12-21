#!/bin/sh
set -euo pipefail

# Clean target directory
rm -rf target/android

# Create target directory
mkdir -p target/android

# Copy Android platform files (headers)
cp -R src/platform/android/ src/pjsip/pjlib/

cd src/pjsip

# Clean archives
find . -type f -name "*.a" -delete

# TODO: Should be corrected for use with CI
export ANDROID_NDK_ROOT="$ANDROID_HOME/ndk/25.1.8937393"

# Make armv7 Android libraries
TARGET_ABI=armeabi-v7a ./configure-android --use-ndk-cflags
make clean
make dep && make clean && make

# Make arm64 Android libraries
TARGET_ABI=arm64-v8a ./configure-android --use-ndk-cflags
make clean
make dep && make clean && make

# Make x86 Android libraries
TARGET_ABI=x86 ./configure-android --use-ndk-cflags
make clean
make dep && make clean && make

# Make x86_64 Android libraries
TARGET_ABI=x86_64 ./configure-android --use-ndk-cflags
make clean
make dep && make clean && make

# Clean all
make clean

# Copy Android libraries
find . -name "*.a" -type f -exec cp {} ../../target/android \;

cd ../../target/android

# Copy libs to target directory
rm -rf ../../android/libs
mkdir -p ../../android/libs
mv *.a ../../android/libs

# Clean target directory
cd ../..
rm -rf target

# Clean working directory
cd src/pjsip
find . -type f -name "*.a" -delete
make clean
