#!/bin/sh
# TODO: can't use set -euo pipefail because of errors while building
# Makefile:1: build.mak: No such file or directory
# Makefile:2: build/host-.mak: No such file or directory
# set -euo pipefail

# Clean target directory
rm -rf target/ios

# Create target directories (for simulator and device)
mkdir -p target/ios/sim
mkdir -p target/ios/ios

# Copy iOS platform files (headers)
cp -R src/platform/ios/ src/pjsip/pjlib/

cd src/pjsip

# Clean archives
find . -type f -name "*.a" -delete

# Make iOS libraries
make clean
MIN_IOS="-miphoneos-version-min=13.0" ./configure-iphone
make dep && make clean && make

# Copy iOS libraries
find . -name "*.a" -type f -exec cp {} ../../target/ios/ios \;

export DEVPATH=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer
find . -type f -name "*.a" -delete

# Make arm64 iOS Simulator libraries
make clean
ARCH="-arch arm64" CFLAGS="-O2 -m64" LDFLAGS="-O2 -m64" MIN_IOS="-mios-simulator-version-min=13.0" ./configure-iphone
make dep && make clean && make

# Make x86_64 iOS Simulator libraries
make clean
ARCH="-arch x86_64" CFLAGS="-O2 -m64" LDFLAGS="-O2 -m64" MIN_IOS="-mios-simulator-version-min=13.0" ./configure-iphone
make dep && make clean && make

make clean

# Copy iOS Simulator libraries
find . -name "*.a" -type f -exec cp {} ../../target/ios/sim \;

# Create fat libraries for iOS Simulator
cd ../../target/ios/sim

ARM64_SIM_ARCH_SUFFIX="arm64-apple-darwin_ios.a"
X86_64_SIM_ARCH_SUFFIX="x86_64-apple-darwin_ios.a"

merge_sim_libs() {
    lipo -arch x86_64 $1-$X86_64_SIM_ARCH_SUFFIX -arch arm64 $1-$ARM64_SIM_ARCH_SUFFIX -create -output $1.a
    rm $1-$X86_64_SIM_ARCH_SUFFIX
    rm $1-$ARM64_SIM_ARCH_SUFFIX
}

# Merge iOS Simulator libraries
merge_sim_libs "libg7221codec"
merge_sim_libs "libgsmcodec"
merge_sim_libs "libilbccodec"
merge_sim_libs "libpj"
merge_sim_libs "libpjlib-util"
merge_sim_libs "libpjmedia"
merge_sim_libs "libpjmedia-audiodev"
merge_sim_libs "libpjmedia-codec"
merge_sim_libs "libpjmedia-videodev"
merge_sim_libs "libpjnath"
merge_sim_libs "libpjsdp"
merge_sim_libs "libpjsip"
merge_sim_libs "libpjsip-simple"
merge_sim_libs "libpjsip-ua"
merge_sim_libs "libpjsua"
merge_sim_libs "libpjsua2"
merge_sim_libs "libresample"
merge_sim_libs "libspeex"
merge_sim_libs "libsrtp"
merge_sim_libs "libwebrtc"
merge_sim_libs "libyuv"

# Create xcframeworks
cd ../

# Remove old xcframeworks
rm -rf *.xcframework

ARM64_IOS_ARCH_SUFFIX="arm64-apple-darwin_ios.a"

create_xcframework() {
    mv ios/$1-$ARM64_IOS_ARCH_SUFFIX ios/$1.a
    xcodebuild -create-xcframework \
        -library ios/$1.a \
        -library sim/$1.a \
        -output $1.xcframework
}

create_xcframework "libg7221codec"
create_xcframework "libgsmcodec"
create_xcframework "libilbccodec"
create_xcframework "libpj"
create_xcframework "libpjlib-util"
create_xcframework "libpjmedia"
create_xcframework "libpjmedia-audiodev"
create_xcframework "libpjmedia-codec"
create_xcframework "libpjmedia-videodev"
create_xcframework "libpjnath"
create_xcframework "libpjsdp"
create_xcframework "libpjsip"
create_xcframework "libpjsip-simple"
create_xcframework "libpjsip-ua"
create_xcframework "libpjsua"
create_xcframework "libpjsua2"
create_xcframework "libresample"
create_xcframework "libspeex"
create_xcframework "libsrtp"
create_xcframework "libwebrtc"
create_xcframework "libyuv"

# Copy xcframeworks to target directory
rm -rf ../../ios/Frameworks
mkdir -p ../../ios/Frameworks
mv *.xcframework ../../ios/Frameworks

# Clean target directory
cd ../..
rm -rf target

# Clean working directory
cd src/pjsip
find . -type f -name "*.a" -delete
make clean
