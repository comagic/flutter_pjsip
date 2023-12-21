#!/bin/bash

# Remove build files generated code
find . -type f -name "*_generated.*" -delete
find . -type f -name "*.freezed.dart" -delete
find . -type f -name "*.g.dart" -delete
find . -type f -name "*.gen.dart" -delete
find . -type f -name "*.reflectable.dart" -delete
find . -type f -name "*.module.dart" -delete

rm -rf src/pjsip

rm -rf target

rm -rf android/libs
rm -rf ios/Frameworks
