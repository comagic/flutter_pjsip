import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffipkg;

import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sip_media_type.freezed.dart';

/// SIP media type containing type and subtype. For example, for
/// "application/sdp", the type is "application" and the subtype is "sdp".
@freezed
sealed class SipMediaType with _$SipMediaType {
  const factory SipMediaType({
    /// The media type.
    required String type,

    /// The media subtype.
    required String subtype,
  }) = _SipMediaType;

  const SipMediaType._();

  /// Import from pjsip structure
  factory SipMediaType.fromPj(ffi.Pointer<pjsip_media_type> prm) {
    return SipMediaType(
      type: prm.ref.type.toDartString(),
      subtype: prm.ref.subtype.toDartString(),
    );
  }

  /// Export to pjsip structure
  /// WARNING: The returned pointer and its content will be freed manually
  ffi.Pointer<pjsip_media_type> toPj() {
    final pjMt = ffipkg.calloc
        .allocate<pjsip_media_type>(ffi.sizeOf<pjsip_media_type>());

    pjMt.ref.type = PjStrTExtension.fromDartString(type).ref;
    pjMt.ref.subtype = PjStrTExtension.fromDartString(subtype).ref;

    return pjMt;
  }
}
