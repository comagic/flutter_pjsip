#!/bin/sh
set -euo pipefail

TARGET_PATH="packages/flutter_pjsip/target"

rm -rf $TARGET_PATH

mkdir -p $TARGET_PATH/lib/ios
mkdir -p $TARGET_PATH/lib/android

cp -R packages/flutter_pjsip/ios/Frameworks $TARGET_PATH/lib/ios
cp -r packages/flutter_pjsip/android/libs $TARGET_PATH/lib/android

cd $TARGET_PATH
tar -zcvf lib.tar.gz lib

rm -rf lib
