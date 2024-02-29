#!/bin/sh
set -euo pipefail

cd packages/flutter_pjsip

# Clean target directory
rm -rf target/macos

# Create target directories (for simulator and device)
mkdir -p target/macos


# Copy MacOS platform files (headers)
cp -R src/platform/macos/ src/pjsip/pjlib/

cd src/pjsip

# Clean archives
find . -type f -name "*.a" -delete


# Make MacOS libraries
CFLAGS="-arch arm64 -mmacosx-version-min=11.0" LDFLAGS="-arch arm64" ./configure --host=arm-apple-darwin
make clean
make dep && make clean && make

CFLAGS="-arch x86_64 -mmacosx-version-min=11.0" LDFLAGS="-arch x86_64" ./configure --host=x86_64-apple-darwin
make clean
make dep && make clean && make

# Copy MacOS libraries
find . -name "*.a" -type f -exec cp {} ../../target/macos \;

cd ../../target/macos

# Remove old xcframeworks
rm -rf *.xcframework

ARM64_SIM_ARCH_SUFFIX="arm-apple-darwin.a"
X86_64_SIM_ARCH_SUFFIX="x86_64-apple-darwin.a"

merge_mac_libs() {
    lipo -arch x86_64 $1-$X86_64_SIM_ARCH_SUFFIX -arch arm64 $1-$ARM64_SIM_ARCH_SUFFIX -create -output $1.a
    rm $1-$X86_64_SIM_ARCH_SUFFIX
    rm $1-$ARM64_SIM_ARCH_SUFFIX
}

merge_mac_libs "libg7221codec"
merge_mac_libs "libgsmcodec"
merge_mac_libs "libilbccodec"
merge_mac_libs "libpj"
merge_mac_libs "libpjlib-util"
merge_mac_libs "libpjmedia"
merge_mac_libs "libpjmedia-audiodev"
merge_mac_libs "libpjmedia-codec"
merge_mac_libs "libpjmedia-videodev"
merge_mac_libs "libpjnath"
merge_mac_libs "libpjsdp"
merge_mac_libs "libpjsip"
merge_mac_libs "libpjsip-simple"
merge_mac_libs "libpjsip-ua"
merge_mac_libs "libpjsua"
merge_mac_libs "libpjsua2"
merge_mac_libs "libresample"
merge_mac_libs "libspeex"
merge_mac_libs "libsrtp"
merge_mac_libs "libwebrtc"
merge_mac_libs "libyuv"



create_xcframework() {
    xcodebuild -create-xcframework \
        -library $1.a \
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
rm -rf ../../macos/Frameworks
mkdir -p ../../macos/Frameworks
mv *.xcframework ../../macos/Frameworks

# Clean target directory
cd ../..
rm -rf target

# Clean working directory
cd src/pjsip
find . -type f -name "*.a" -delete
make clean
