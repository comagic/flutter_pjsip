#!/bin/sh
set -euo pipefail

cp -R src/platform/android/ src/pjsip/pjlib/

flutter pub run ffigen --config ffigen.yaml
