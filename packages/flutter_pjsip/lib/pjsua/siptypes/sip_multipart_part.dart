import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffipkg;

import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sip_multipart_part.freezed.dart';

/// This describes each multipart part.
@freezed
sealed class SipMultipartPart with _$SipMultipartPart {
  const factory SipMultipartPart({
    /// Optional headers to be put in this multipart part.
    required SipHeaderList headers,

    /// The MIME type of the body part of this multipart part.
    required SipMediaType contentType,

    /// The body part of tthis multipart part.
    required String body,
  }) = _SipMultipartPart;

  const SipMultipartPart._();

  /// Import from pjsip structure
  factory SipMultipartPart.fromPj(ffi.Pointer<pjsip_multipart_part> prm) {
    final headers = SipHeaderList.empty();

    var pjHdr = prm.ref.hdr.next;

    // Original code compares pointers, but we can't do that in Dart
    // so we compare the values instead using the == operator that
    // is overridden in generated code.
    while (pjHdr.ref != prm.ref.hdr) {
      headers.add(SipHeader.fromPj(pjHdr));
      pjHdr = pjHdr.ref.next;
    }

    if (prm.ref.body == ffi.nullptr) {
      throw Exception('Body is null');
    }

    final contentType = SipMediaType.fromPj(prm.ref.body.ref.content_type);
    final body =
        (prm.ref.body.ref.data as ffi.Pointer<ffi.Char>).toDartString();

    return SipMultipartPart(
      headers: headers,
      contentType: contentType,
      body: body,
    );
  }

  /// Export to pjsip structure
  /// WARNING: The returned pointer and its content will be freed manually
  ffi.Pointer<pjsip_multipart_part> toPj() {
    final pjMpp = ffipkg.calloc
        .allocate<pjsip_multipart_part>(ffi.sizeOf<pjsip_multipart_part>());

    final firstHdr = ffipkg.calloc.allocate<pjsip_hdr>(ffi.sizeOf<pjsip_hdr>());

    firstHdr.ref.next = firstHdr;
    firstHdr.ref.prev = firstHdr;

    var lastHdr = firstHdr;

    for (final header in headers) {
      final pjHdr = header.toPj();

      lastHdr.ref.next = pjHdr as ffi.Pointer<pjsip_hdr>;
      firstHdr.ref.prev = pjHdr as ffi.Pointer<pjsip_hdr>;

      lastHdr = pjHdr as ffi.Pointer<pjsip_hdr>;
    }

    pjMpp.ref.hdr = firstHdr.ref;

    final pjMsgBody =
        ffipkg.calloc.allocate<pjsip_msg_body>(ffi.sizeOf<pjsip_msg_body>());

    pjMsgBody.ref.content_type = contentType.toPj().ref;
    // TODO(nesquikm): Have no idea what to do with this
    // pjMsgBody.ref.print_body = _pjsip_print_text_bodyPtr;
    // pjMsgBody.ref.clone_data = _pjsip_clone_text_dataPtr;
    pjMsgBody.ref.data =
        PCExtension.fromDartString(body) as ffi.Pointer<ffi.Void>;
    pjMsgBody.ref.len = PCExtension.nativeUtf8Length(body);

    pjMpp.ref.body = pjMsgBody;

    return pjMpp;
  }
}
