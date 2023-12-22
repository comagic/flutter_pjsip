#!/bin/sh
set -euo pipefail

cd packages/flutter_pjsip

cp -R src/platform/android/ src/pjsip/pjlib/

flutter pub run ffigen --config ffigen.yaml
