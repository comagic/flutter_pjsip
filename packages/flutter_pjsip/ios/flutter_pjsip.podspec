#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_pjsip.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_pjsip'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter FFI plugin project.'
  s.description      = <<-DESC
A new Flutter FFI plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  TARGET_DIR = 'Frameworks/'
  XCF_SUFFIX = '.xcframework'

  # PJSIP XCFrameworks
  s.xcconfig = { 'OTHER_LDFLAGS' => '-Wl,-all_load' }
  s.vendored_frameworks = "#{TARGET_DIR}libpjsua#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libpjsip#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libspeex#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libpjlib-util#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libwebrtc#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libresample#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libpjnath#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libsrtp#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libpjsip-ua#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libpjsip-simple#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libpjmedia#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libpjmedia-codec#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libpjmedia-audiodev#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libgsmcodec#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libilbccodec#{XCF_SUFFIX}",
                          "#{TARGET_DIR}libpj#{XCF_SUFFIX}"
  s.frameworks = 'AudioToolbox', 'AVFoundation'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386', 'ONLY_ACTIVE_ARCH' => 'NO' }
  s.swift_version = '5.0'
end
