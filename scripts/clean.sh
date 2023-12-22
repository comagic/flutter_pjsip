#!/bin/bash

# Remove build files generated code
find . -type f -name "*_generated.*" -delete
find . -type f -name "*.freezed.dart" -delete
find . -type f -name "*.g.dart" -delete
find . -type f -name "*.gen.dart" -delete
find . -type f -name "*.reflectable.dart" -delete
find . -type f -name "*.module.dart" -delete

rm -rf packages/flutter_pjsip/src/pjsip

rm -rf packages/flutter_pjsip/target

rm -rf packages/flutter_pjsip/android/libs
rm -rf packages/flutter_pjsip/ios/Frameworks

