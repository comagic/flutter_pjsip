# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(flutter_pjsip_library VERSION 0.0.1 LANGUAGES C)

add_library(flutter_pjsip SHARED
  "flutter_pjsip.c"
)

SET(TARGET_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../android/libs)

if(CMAKE_SYSTEM_PROCESSOR MATCHES "armv7-a")
  SET(ARCH_SUFFIX "armv7-unknown-linux-android.a")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64")
  SET(ARCH_SUFFIX "aarch64-unknown-linux-android.a")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "i686")
  SET(ARCH_SUFFIX "i686-pc-linux-android.a")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64")
SET(ARCH_SUFFIX "x86_64-pc-linux-android.a")
else()
  message(FATAL_ERROR "Unsupported architecture: ${CMAKE_SYSTEM_PROCESSOR}")
endif()

target_link_libraries(flutter_pjsip PUBLIC
  -Wl,--whole-archive
  "${TARGET_DIR}/libpjsua-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libpjsip-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libspeex-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libpjlib-util-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libwebrtc-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libresample-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libpjnath-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libsrtp-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libpjsip-ua-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libpjsip-simple-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libpjmedia-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libpjmedia-codec-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libpjmedia-audiodev-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libgsmcodec-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libilbccodec-${ARCH_SUFFIX}"
  "${TARGET_DIR}/libpj-${ARCH_SUFFIX}"
  -Wl,--no-whole-archive
  mediandk
)

# For now this archives seems not needed
# libg7221codec
# libpjmedia-videodev-
# libpjsdp-
# libpjsua2-
# libyuv-

set_target_properties(flutter_pjsip PROPERTIES
  PUBLIC_HEADER flutter_pjsip.h
  OUTPUT_NAME "flutter_pjsip"
)

target_compile_definitions(flutter_pjsip PUBLIC DART_SHARED_LIB)
