#!/bin/sh
set -euo pipefail

cd packages/flutter_pjsip

PJSIP_VERSION="2.14"
# TODO: Actually github prefer to use REST API to get a release:
# https://docs.github.com/en/rest/releases/releases?apiVersion=2022-11-28#get-a-release
# But it is not possible to use it without token, so we use direct link to tarball
URL="https://github.com/pjsip/pjproject/archive/refs/tags/$PJSIP_VERSION.tar.gz"
SRC_DIR="src/pjsip"
LOCAL_TARBALL="$SRC_DIR/pjsip.tar.gz"

rm -rf src/pjsip

echo "Downloading PJSIP $PJSIP_VERSION to $LOCAL_TARBALL"
mkdir -p src/pjsip

curl -L $URL -o $LOCAL_TARBALL
tar xzf $LOCAL_TARBALL -C $SRC_DIR --strip-components=1
rm $LOCAL_TARBALL
